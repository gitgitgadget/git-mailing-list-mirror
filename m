Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5156B7F
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366849; cv=none; b=ADJ7C+Jytkyd7JN4hqduk+D0VOlBIMK+kpVclj9Oz7SrmskC3kGbnS2EcAm4bddcsPkvd/isquabGGKdkidpW9fNY3E5lJ7FOutq8n1VMTvn7upHCoO1r8wDU5XzgvsxgpL5tvqA/P+rn56ty42Bvh44H0RH4H4Dm8Nlct60nxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366849; c=relaxed/simple;
	bh=oCyE/w+vXtP4YIsPQPpxlMsU+sgmqUsx0HsRo2IiCEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbAyM5GQiuKwg7Bekw7W6xaOIeNBrhYzMTlXblmav4BOGWhqg6/wd9DyeCZNdTdy30beof+W4LGnUib8iC0vN6fbB+FxzH46iQyUIak6y50NAJHlsB3DpvUw06RFX25XdH1wt83M4YbSUCS9C65etavkimVVAgykBjcCkAVX5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=T4L87cCJ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="T4L87cCJ"
Message-ID: <fda3e8f4-fd9e-4a43-a307-c6607d982436@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710366842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xL2+fzSbixTXApzoVs6+xN50pW8P2biRG9QeldjmFQM=;
	b=T4L87cCJdZ7t2SRfEWYcw8CFhj81xRfWDePm78ZTOTRt0rWLEH30klkVi7TAgmdyMIrR/r
	M2XIDogS7oEKTluoDkRJMt5FoAMb4n7h1b60DDAPWXJQmHGk4x0QtYxq++75Qv80EX9113
	sKPZYOuTJnmtZpBxQz7eLdpU2FKx+ageTSkf1bgD+hSPzJ/d0p98f7TRtoU9gVUfpWqMtQ
	3f9RAX9P8RMSKDS0TYkT/C3cT7skw/ZYw3D8LHKgByrZI3jCKVwl65laf7HoCDNcX4pDNQ
	RIJsxVL2eJpnoJtH7j1ccYVYw/8cO7uRvmHYVrzY9pNXiSTqg7365kX0SGTsEw==
Date: Wed, 13 Mar 2024 22:53:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com> <xmqqy1aqvx9n.fsf@gitster.g>
 <9fb02065-12d2-4c92-b1a5-74c06125c692@iencinas.com>
 <xmqqil1ssm5y.fsf@gitster.g>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <xmqqil1ssm5y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/3/24 18:39, Junio C Hamano wrote:
> Ignacio Encinas Rubio <ignacio@iencinas.com> writes:
> 
>> I can't think of any room for improvement other than integrating
>> hostname (or a custom hostname) into git and using it in the tests, but
>> I doubt it is worth it.
> 
> Ah, that is a thought.  We have t/helper that builds "test-tool"
> just for that, and exposing the output of xhostname() does sounds
> like a reasonable way to go.  It would roughly involve

Great! I hadn't noticed "test-tool". Just to double-check, what name do
we want to use for this? xhostname, hostname, xgethostname, gethostname?

If I didn't miss something, the only place the test use hostname is in 

    $ git grep '$(hostname' t/
    t/t6500-gc.sh:	hostname=$(hostname || echo unknown) &&

as you previously pointed out. So my plan is:

1. Extend test-tool, migrate t6500-gc.sh to test-tool xhostname(*)
2. Update my v2 to use "test-tool xhostname(*)"

(*) or however we want to name it

>  * Add t/helper/test-xhostname.c that defines cmd__xhostname() and
>    writes the result of calling xhostname() to its standard output.
> 
>  * Plumb it through by adding it to a few places:
> 
>    - t/helper/test-tool.h wants the extern definition.
>    - t/helper/test-tool.c wants it in its cmds[] array.
>    - Makefile wants to list it in TEST_BUILTIN_OBJS
> 
>  * Then use "test-tool xhostname" in your tests, instead of
>    "hostname".
> 
> You can run
> 
>     $ git grep chmtime ':!t/*.sh"
> 
> to find places that needed to be touched when a similar internal
> tool "chmtime" was added.

Thank you very much for the pointers, they were very helpful!
