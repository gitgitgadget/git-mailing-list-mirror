Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22A20DD64
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130446; cv=none; b=TkL8znSWSiRKlCDbO8HbWfHcIq/Mb6fGPLdB3Ni1GxNIDaB55CVAwjXuLE38mXbh0ePP+klQSFJKzIiXIaBcu5HO41DFMbQfb453f++eFVWgxioy8jqTJi57j3sxeevsnlEGqhmHyL8DvsHloTJhuPOTG0qy0Sm28sUdfCVZCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130446; c=relaxed/simple;
	bh=DweFoN4OVLbpJs43elJgUmmRF7MY68hNy7ZCtEaq2SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9JPvMtBan1xQuoEB9D9cLLBr7FrGv3WPt241KLJwCCB00c74GON4CaUA6fKcmvgSKhe01AiZP2Xcsw3jHK4Zp0bpsPWQIe4kpx3Eu0q+pM+BaYvEIaGgRKt1A/eXbE+NeXdr7KQOp8USyKWv4Fc8ImcibL3J9zLCJcm5i09fHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vxauJUPq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0q55vQ3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vxauJUPq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0q55vQ3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E325A13833D2;
	Thu, 27 Mar 2025 22:54:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 27 Mar 2025 22:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743130442; x=1743216842; bh=1a7Oc2EgT+
	CQfkqjRUS926i612AkbMxiERniJpxrGzE=; b=vxauJUPq8IUyyCTsrt1SM1bV8q
	luiqK+Gh7ipQsnzl4jbMGwb7zoZp0b0GejUf1AZdDD5KA+UNsoMPX1uV2ucCMHMk
	hdVqIYmPaB95mWjuwnoOC2J8g/Ia+BDqNzYziEOMt8IfvEm1O/WgvfpdTP2YST0V
	LTn4fKUi9ipZlaaLEtIh+i9bvl+3j36TqsODb4A0rWy8D5GowDyxFlTqovu0c8jU
	ip5onzvcoCTtc/dwiFSnT9HiG+xmdLaoUxuexer6SSrv55YJfliDPJq/FRXiAMdD
	R7pV1d5uM96jqr/7T3LcJEbfIVcR8QqAjpFY4LD2rLG4Bjb6ot46m1pM1pjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743130442; x=1743216842; bh=1a7Oc2EgT+CQfkqjRUS926i612AkbMxiERn
	iJpxrGzE=; b=O0q55vQ3e9oiKzCu0VHrNbvyc7AjOeXUiIjQD+kEC0JT5yXtUUT
	3O/OY8sAa0HuouasfFUKcKxEvjQRjERm+6y1wzSBKbj7j94uqQ/pDvgSdRI6F8wn
	xlrcWuVXdmN6Q+obBKttsscFkm05SMpAMmmRIkX0Zrc0N9FsWCd2af4CM5LtZGi6
	mEn/ivsNJ8f7cvq7GF3NY8YwnBGlnIy/+QVC/svYW6up41TEZRidai6BOxEfETr6
	T1nxpUgYp2+gDxTQR04ViIphkfmyyWJeMszkvrSv6mTf/r20OyNv+LGxglDbWoJq
	BANuSYFYWfzJ5A8DRPnK37wtoUoyZBM4kNg==
X-ME-Sender: <xms:Sg_mZ7kcLwqYqM85GysigOv89O5XDJbmotdZpdnUdDZqxzmYDv_8Mg>
    <xme:Sg_mZ-2MX9ptRscYI7a_R39W1Ucl5atBLmwB1N1snnJP3R9RJsMhSQsIYI4otgFiM
    zVXpBGcZcNfKy90yg>
X-ME-Received: <xmr:Sg_mZxpHKDuG7Sc_NhBtzRvjIafj4tQPBbbaraVQXPZOVbAeRaGckDdV9m_Pg5z2x1lv6xbnDS_waAGEOsFYq6B05s_7u66sgY6xk9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Sg_mZzkO47x_RwCTzcUzyPRetD6byg-Ms5lsRr45pR1kvmYN97O5AQ>
    <xmx:Sg_mZ50IRDKPXkzrTecYp_rtCVr3mDp0ZTYPWjgx0G84qvtSNP9xkQ>
    <xmx:Sg_mZytVVx73MUUnFhIkt7Fbh6LBmewI6HQxRMna9shmRyJ6mvF-Rw>
    <xmx:Sg_mZ9V29aFd8r3xjqpJ5knfUfg6l2CBCuknuHUEubAIKdvy7_-pyg>
    <xmx:Sg_mZx96EzE7b3FPhWXd4u-YrJQUv9MS6ln1dAU3mzwp1fgxQPJNWdFy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 22:54:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] diff: check range before dereferencing an array
 element
In-Reply-To: <ddfb44ed924615bdb61a30ae7627326942575567.1743073557.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 27 Mar 2025
	11:05:56 +0000")
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
	<pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
	<ddfb44ed924615bdb61a30ae7627326942575567.1743073557.git.gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 19:54:00 -0700
Message-ID: <xmqqy0wphnlj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Before accessing an array element at a given index, we should make sure
> that the index is within the desired bounds, not afterwards, otherwise
> it may not make sense to even access the array element in the first
> place.
>
> Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.

At least this part should say this is a false positive, forcing us
to make an unnecessary change to help future developers who are
running "git blame" and "git log -p" to find out why only s[off]
checked against CR needs this check _before_ it, while checking
against other values needs _no_ check.

In other words, the first paragraph of the proposed log message is a
total red herring.  We are accessing an array element at a given
index 'off' in the original, we are still accessing the same element
in the updated code, and we know the index is within the array
bounds.  If the condition were "We want to skip CR only at odd
places", we would have written 

	|| (s[off] == '\r' && (off & 01))

or

	|| ((off & 01) || s[off] == '\r')

and both are equally valid.  (off < len -1) should be no different.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index c89c15d98e0..18ba3060460 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
>  
>  	/* skip any \v \f \r at start of indentation */
>  	while (s[off] == '\f' || s[off] == '\v' ||
> -	       (s[off] == '\r' && off < len - 1))
> +	       (off < len - 1 && s[off] == '\r'))
>  		off++;
>  
>  	/* calculate the visual width of indentation */
