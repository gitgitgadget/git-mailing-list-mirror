Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BB3234
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215094; cv=none; b=g3/pJBMWDypSVGoGI/PY8yZM52UJrllDVSC6auosRiuvVVBra/5wbJCZoSUnO/9YZ7FGDxrIcTxJ8x5CTpioS8nWcQSwsiCfonU7eivem8c7Ypusbt5a4wyntZr7itZDuYGH7GvcF1ABqYiPyzgIwpl5TArqVGcRiwdnpEMauBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215094; c=relaxed/simple;
	bh=G3dthQgPQj2EfdTHha+B72xqSgUnQ/8jaQSmmG9KFYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q++o58pzJplZQsF6C8VF+ThzhQObmFlLqsbMoN80NASed+8l0ti5ETJfNlT3O/MSOPV0fbLtdeVF9LNfoEyJkaQ+L37NZXlxMsioEwNNFceu7avcntWWQkOmJ6PLriUIaIsidVYABtmSVAlBcfCq1KHm8Qls2eoA8iISlnec6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=t7wAIs4B; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="t7wAIs4B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1749215088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFt0JPUsWSg0XKGrzFwqv6l8Wg6NZBJpyxoE7DruqbQ=;
	b=t7wAIs4BYkj6NYDIzh0JueJ9uaVHOcN4k1ViMUVwp+7wi5KD/cV7jcmewF7HLHYwD8OBeM
	IQ1Uab2j9Qm2bPSe3qKnZC+12d5almVXW83eGKTyT4LhK6KaJcTXyZM547RMP3WG4aY1pi
	/r0hiniAdK2BBACRIZ1so77le4BeS4M=
From: Toon Claes <toon@iotcl.com>
To: Martin von Zweigbergk <martinvonz@google.com>, Junio C Hamano
 <gitster@pobox.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, Nico Williams <nico@cryptonector.com>, Theodore
 Ts'o <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>, Edwin Kempin
 <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <CAESOdVCjc1kvQSKnxGfNNSTvFhLRjH_vzwMauP8ZWQ5hhfBnEw@mail.gmail.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
 <CAESOdVDG_tfrWMvV6V_Ad76EqXU3Be+EpJDLvtgPcfCRHoJoYQ@mail.gmail.com>
 <xmqqjz7a27ww.fsf@gitster.g>
 <CAESOdVCjc1kvQSKnxGfNNSTvFhLRjH_vzwMauP8ZWQ5hhfBnEw@mail.gmail.com>
Date: Fri, 06 Jun 2025 15:04:36 +0200
Message-ID: <87plfh10nv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Martin von Zweigbergk <martinvonz@google.com> writes:

> On Wed, 23 Apr 2025 at 08:51, Junio C Hamano <gitster@pobox.com> wrote:
>> Would it make sense, though?  Imagine that a contributor in your
>> project did not refactor code properly and instead made a
>> copy-and-paste duplicates of a very similar code.  I find a bug in
>> one of them, without realizing that the old mistake of duplicating
>> code (instead of making it a shared helper that is called from the
>> two places) and create a fix for it.  Later somebody else realizes
>> the same fix is needed for the other copy---attempting to cherry
>> pick the original fix may find that remaining copy of a buggy code
>> as the logic to perform a three-way merge across renames that is
>> sufficiently clever kicks in.  Shouldn't these two commits to fix
>> the same bug in two places share the same change ID so that it is
>> clear to the later developers that the latter fix was derived from
>> the former one?
>
> Maybe it depends on how the forge uses the change id. If the forge is
> Gerrit, it will use the (change id, target branch) to identify a
> review (IIUC), so then it will require a new change ID because it
> requires a new review. If it doesn't have that requirement (maybe it's
> PR-style forge), then it could at least highlight to the reviewer that
> there was an old version of the change that has already been merged.

I've been thinking some more about duplicates.

First, I don't think you can enforce uniqueness. Whenever you're working
with forks you can have commit A from fork I to have the same change-ID
as commit B in fork II (because either of them might be rebased).
Enforcing uniqueness on change-IDs would disallow the user to fetch from
both forks, or they would need to specify how to resolve the change-id
conflict.

I like Martin's idea of having forges ensuring uniqueness, but I was
wondering if we should take it a step furter: a commit should not be
able to reach another commit with the same change-id. Verifying this on
the client-side, helps the user detect issues sooner. Only seeing that
error when pushing to the forge might be annoying.

Anyhow on the other hand, what about merges? If people merge the 'main'
branch into their feature branch, it would no longer be possible to
merge the feature branch into the 'main' branch.

But to circle back to Junio's example. It depends on what you want to
track. You could consider both changes to be different, and thus
requiring different change-ids, because one didn't fix all of it.

-- 
Cheers,
Toon
