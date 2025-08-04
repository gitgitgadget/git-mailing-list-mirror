Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80843236A9F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317154; cv=none; b=Y2ZBY6mgK9+dOgg8VYTjbSXb2k/ckbWG6P6xLjYq/+zu40jVbAmB0p9++75h0mHM4CuzclA5LVyrV0493hZWZinS9NkoNgzLiu1+wpLjAUVkR9aOfvbc/YNYZxxsoZG520De6uXr6j5cKV+5uBGeCrbq3izwcnIKB00gsqFbEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317154; c=relaxed/simple;
	bh=cX94e1n2Jruoz2NcUlhDYiTm+mP1jXrplNlZXbCkpFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sihu5ZRYslVmPwTdHye10/HbU05KgAXT9yAmSsjVCfxYJg0lmvc5ZLKXebI4xHGJ5BkjQj/MDRBA0wFnEk9MYW5f0MhORobrr/TZgzPJ2xvH7XowO0s4X2Iqct+nujdQsQL7Q6Xm+MridXF3jeGMqN55vWAiKtgZqwzprs+KZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HDeZ29MM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PcGiW1CV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HDeZ29MM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcGiW1CV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D851EC01BD;
	Mon,  4 Aug 2025 10:19:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 04 Aug 2025 10:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754317151; x=1754403551; bh=UcFW6XapAF
	/YPVmcgXQmNWMGDUM508cswJuKTT3UxyE=; b=HDeZ29MMk3ezweMuRNz0mqIptC
	lmIFTZv3N7SEPs+GEUBO6ToixTI6X5bZCuyya5F2TH4w5dgY+n8Z2I92DicvuaKu
	uJUtrREKaVStzPBSiY8ABPzZL9vU8CqLFKhsynRLQn2r5q4iWD34I2IcNhL390OW
	QBr5LaDWSyKHjOdCRNL0Kp2Dd5ESdykeeyMZHzPesjZYZi/a7cq1TZTte6eRSSrS
	i+aY17fXH7UjblicQNckO5hqy+DCx4cJc1iE/5HXfnqq03pCDVvvYkmiWxhrr28K
	ik2vDWADSX6APlbmsrRg+X6800o25jSaODyd9ejgxN3qMwDPl8/va74U6CKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754317151; x=1754403551; bh=UcFW6XapAF/YPVmcgXQmNWMGDUM508cswJu
	KTT3UxyE=; b=PcGiW1CVwsrjLMul8B74MCcs61ZqwDyBRz+HgSFSBhbtMexCDxt
	i+QXljBPkAHNfo6ZLE2Q5SXzAgilCjGxEzKww16TFUHF5Bn8AI0M5qfO2g/e94Jz
	DdSG+i4maHniCAkyEJPzZIrIfwC1eR20T25E9Ir6iPJCXR7Jw2SuywH+/QI6xtO6
	oIS+g5cfsR/+PcyBFGPZP5lsM9ebOEp9yhQaga3FUGWwBh6SGUgTHsIZHnhUXO7C
	0W5buD+ktPmvs7QkOaCLDDD3ugp4UUMLmsbQLaK31FK75TbLjy0Duvohaxx4uaeY
	BAHmOW1ay+qS30wggCVWxOgwCRPNGOmYGzA==
X-ME-Sender: <xms:X8GQaIpJmUjX7cVeMCiU-JFIuxUmjDVofQJFYV5kwBZQHlEIuxvzDA>
    <xme:X8GQaB5UDE3Y9PeQOXvxO3X-Kdiz0xFQyYkQkPpIpZ_j05x0wGhZDEyHfmgEckJ7P
    ROGOQxvIV5WB_lhqA>
X-ME-Received: <xmr:X8GQaGpIRVp0IhTf6TQ2byfyNsFN0W0wD01aQCyvjJTeQYA6iCnw3FXdOvVUE2C8GZKX4MYs8JWbDe7LxkibVT2TxHKUdRNH53OjJvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X8GQaLiMqMaTeNtV6Reld1eN61Pv4pROeAH23bqr42DlzBE6n1enrQ>
    <xmx:X8GQaIK7YlhnnNVRwa1tMviN08dH_1cxJuUoSBNo-IMbtQUbqmygvA>
    <xmx:X8GQaDCsK1xFA7GFvH_ix-SDJm0SMgeMfy1umC-4SxNrrdkcTUYneA>
    <xmx:X8GQaAgxujoF0PWsMzKhdyM9a-_J2puuwh2t-f4xadGjnsE-p7JEcg>
    <xmx:X8GQaCjaCSZRl0y4bPdk80xknl6BKKqICLNrHcRKzsisAtT5HOTP1-JT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 10:19:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
In-Reply-To: <3eb95731ea07c5f25ed7a47cc639f53b4b18e113.1754300389.git.liu.denton@gmail.com>
	(Denton Liu's message of "Mon, 4 Aug 2025 02:43:05 -0700")
References: <cover.1754300389.git.liu.denton@gmail.com>
	<3eb95731ea07c5f25ed7a47cc639f53b4b18e113.1754300389.git.liu.denton@gmail.com>
Date: Mon, 04 Aug 2025 07:19:09 -0700
Message-ID: <xmqq5xf39nky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Denton Liu <liu.denton@gmail.com> writes:

> In the case where a non-existent oid is given as the <src> for a
> refspec and the destination is unqualified, we end up hitting the BUG in
> show_push_unqualified_ref_name_error().
>
> This is because before hitting this advise message, the <src> is passed
> through repo_get_oid() which, upon receiving a fully qualified oid,
> doesn't actually check the existence of the object and just returns
> found.

The tail end of the above sentence does not quite parse for me.
Strike "and just returns found" out, perhaps?

> This means that it's actually possible for the
> odb_read_object_info() call to return not found under normal usage and
> thus, it's not actually a bug.

Again it is unclear what this "not found", used as noun, means.

Often saying "A" and having to follow it with "this means B" is a
sign that both needs to be rewritten to clarify.  The above does it
three times ("A", "this is because B", "this means C").  How about
flowing your thought in a slightly different order, perhaps like
this?

    When "git push <remote> <src>:<dst>" does not spell out the
    destination side of the ref fully, and when <src> is not given
    as a reference but an object name, the code tries to give advice
    messages based on the type of that object.

    The type is determined by calling odb_read_object_info() and
    signalled by its return value.  The code however reported a
    programming error with BUG() when this function said that there
    is no such object, which happens when the object name is given
    as a full hexadecimal (if the object name is given as a partial
    hexadecimal or an non-existing ref, the function would have died
    without returning, so this BUG() wouldn't have triggered).  This
    is wrong.  It is an ordinary end-user mistake to give an object
    name that does not exist and treated as such.

or something?

> Replace the BUG() with an advise() displaying a helpful message about
> the oid possibly not existing.

I briefly thought this may need to be an error(), but with a larger
context, this else clause is at the end of if/else if/... cascade
for different object types, each arm of which emits per object type
advice messages, so the new one being another call to advise() would
make sense.

>  	} else {
> -		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
> -		    matched_src_name, type);
> +		advise(_("The <src> part of the refspec is an oid that doesn't exist.\n"
> +			 "Please ensure that the oid '%s' is correct."),
> +		       matched_src_name);

Unlike the other existing messages, the second line after the
diagnosis in this new message states something that is too obvious
to anybody---even to somebody who may be helped by an advice message
that says "you seem to have a commit, perhaps you meant to create a
branch?"

Thanks.


