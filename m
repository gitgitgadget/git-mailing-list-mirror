Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8D3BBED
	for <git@vger.kernel.org>; Fri, 24 May 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575152; cv=none; b=hFVqhwmr5RVaBVjiqM4M9R1tZVnbzte66ccoAupTImelQv9y8bmiX8R9Dfxs95/+bPGejIJSSYSqNNo4j9m+MhpB9RVw+u0SE8GRGyq3IC+FOkC760q4ExBBQvN0cw6UrGYl+xGCcOwquVFQtI5bMm4PXh1V5TQ+OoXQgygPr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575152; c=relaxed/simple;
	bh=sfAjTk1un0RMo1ZOfQw6gbvgXt71Maq1pu78+3bbLP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tb1gniEVjIra3U6mL4x2zuXI3o4QgFjWLDK+Y6wY4t+q4gFgH408dJMH5ZVg82Lup9vlOtxYH/lq1j3yr/t8geCjEBmURoeQRbWCLQZJVXYw6NGKJO+pRZpqLNDz0gBJsMl8x0BttPT/l3PU2GPvhrvj3Y5kaZe+nurEtqUm7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JA1l328L; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JA1l328L"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D05726DBA;
	Fri, 24 May 2024 14:25:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sfAjTk1un0RMo1ZOfQw6gbvgXt71Maq1pu78+3
	bbLP8=; b=JA1l328LWN9pYqOeoK3nLPyvgfX4NYwKBnnW8x2VIzB1OHm28S+UjC
	F9GFM5I4CfPl4TCRaspFA36YR2RH1aOLyJN4LYdvPOZQ6jWgzW+u9xLMrIQJEFJp
	j4YBmRliB2vgRXF4QrmvFWI3uh8OA3DX2BalmvqG/NXD7ZbJyaioU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5560D26DB9;
	Fri, 24 May 2024 14:25:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73D9E26DB8;
	Fri, 24 May 2024 14:25:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/3] upload-pack: support a missing-action
In-Reply-To: <20240524163926.2019648-1-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 24 May 2024 18:39:23 +0200")
References: <20240418184043.2900955-1-christian.couder@gmail.com>
	<20240524163926.2019648-1-christian.couder@gmail.com>
Date: Fri, 24 May 2024 11:25:46 -0700
Message-ID: <xmqq5xv3kqxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A77FB4A-19FB-11EF-A271-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> The changes since v2 are the following:
> ...
>
> Thanks to Junio for his reviews of v1 and v3, and for suggesting the
> most of the above changes.
> ...

>
> Range diff between v2 and v3
> ============================
>
> (Might not be super useful as changes in patch 2/3 are not seen.)
>
> 1:  0a961dd4f5 = 1:  67c761b08a rev-list: refactor --missing=<missing-action>
> 2:  410acc6a39 < -:  ---------- pack-objects: use the missing action API
> -:  ---------- > 2:  7bf04f3096 pack-objects: use the missing action API
> 3:  0f5efb064b ! 3:  bac909a070 upload-pack: allow configuring a missing-action
>     @@ Metadata
>       ## Commit message ##
>          upload-pack: allow configuring a missing-action
>      
>     -    In case some objects are missing from a server, it might still be
>     +    In case some objects are missing from a server, it is sometimes
>          useful to be able to fetch or clone from it if the client already has
>          the missing objects or can get them in some way.
>      
>     -    For example, in case both the server and the client are using a
>     -    separate promisor remote that contain some objects, it can be better
>     -    if the server doesn't try to send such objects back to the client, but
>     -    instead let the client get those objects separately from the promisor
>     -    remote. (The client needs to have the separate promisor remote
>     -    configured, for that to work.)
>     +    Suppose repository S borrows from its "promisor" X, and repository C
>     +    which initially cloned from S borrows from its "promisor" S. If C
>     +    wants an object in order to fill in the gap in its object graph, and
>     +    S does not have it (as S itself has no need for that object), then it
>     +    makes sense to let C go directly to X bypassing S.

Most notably, what is still missing in this iteration, even though I
already pointed it out in the earlier reviews, is that the readers
would not get a good sense of how much trust they need to place on
the other side S, in order to save their repositories from getting
corrupted by S sending an incomplete pack, and what mechanism there
already is to make sure missing objects after fetching such an
incomplete pack from S are all available at X.

In short, I agree with the goal of having "S is borrowing from X, we
cloned from S, we can fill our missing objects by lazily fetching
directly from X" as a feature.  But I want to see it as a safe
feature, but from these patches I do not see how the necessary
safety is guaranteed.

Thanks.
