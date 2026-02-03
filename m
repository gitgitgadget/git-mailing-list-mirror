Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829B155322
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081375; cv=none; b=mM6xXx17aTGrRUv1qVn7MKA8l6PwtIhOkw2eNVOdM5RVqZZglMmiIqu176mudjnjSGUIza2bHmu75D4g+jQTmLPIP71ls+5MfJRHwdTsxJ3+8b++HP+cRoG4rhyyIkUL1lbTQtE73U7LBfQSLa61hwFybJUb1M8dzzrlO3PjBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081375; c=relaxed/simple;
	bh=Z0oQj+01m7EWyY/k4C3J6HjdXGbMON/Se/cLC23aoP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTK5FudX2WWXqqJaUQ1k+AA5L4wjrcEuR4NiTUs1uxF0i+a1BK74ZFP/+sRem101Hq0t4ysCZuDusKTP5NVZOs0jMNVNpKQ8Qi661KB0zSXVC74QuVQv4ZM+oWWZO3f0r4NaX9vBf1Ti8LetoEOUi5mcqu8HxM9e1yQ+GP2gaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GNqPNoUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYpKt13k; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GNqPNoUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYpKt13k"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DE141D00009;
	Mon,  2 Feb 2026 20:16:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 20:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770081373; x=1770167773; bh=SmkU4DyQpr
	LLYLZmsNefAzyx9RZ164sEOOvdZJhpcp4=; b=GNqPNoUSKeZ6Xcji0pHbMlatUx
	wAVHbeJh2t7Xig4MNhFrRIQ1FaN78vrnEojqZeAxTPnWrIxlEVby8Hz8vtNWWMYl
	UA3vI/LyjqUu+CLe7jCKwmXp2FZGjPbqTgCdGamr/X/poDcn2EKJgwk7KRUOqUtM
	SoUBL40uKBpW2Fa4FOsIFgoRb249U80sahJ80j5GdAGd4XNVLQUZcEDTlW9c+npQ
	xT0L8Mcdt87BNQEMktFv6HamGJ/6G2Pd2fLG/Xz7JExc4qHZoEHuvJTn7YV6g5Yc
	ZF0e5urMUS547ATmctXqQsMacTec8/rKJ0hkgxjM42cRWbyI5ufeX5tshinA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770081373; x=1770167773; bh=SmkU4DyQprLLYLZmsNefAzyx9RZ164sEOOv
	dZJhpcp4=; b=MYpKt13kFVwsICBq2HVcrximPJibWYA8ifDOtkgsbOV4Cx6FcJ9
	JVa+OLWMXkM0rfaP2VMgW2S1mrjPli1f6l9U9oFBFYIuTxKu6jWpnsO1BlWyRUoe
	XlCAmxx4wthkCLNomRMOGjS7QbMZzjCzsKvCZey8wZStBMxL/w9BZPIPDIwTvvnd
	6iEehfUCUjgfYA/WxqFyuLm3xKgDKVPyY2Pdb8Y4GTIqnh2edahzSRB7ATvLCJGD
	0kCJ29d5mBUnoHwGdUFmmbisKTZOSv3ZjsnIIfwll3o+Y/amS6drWLWqcBcG0u+Y
	h80bU9SWUlADxrffpYafxa8zyd+PFgbLBRg==
X-ME-Sender: <xms:XEyBaZg1LwVjV5Ho8bC_W6ntydGGwtYg4_IrbR4Sfy8h7ZsTGQ-dTg>
    <xme:XEyBaVAijzp6gmnYKKUpvlDmingevCHhkXXrb4x4uDXP944ppeiC2hI81nqo6v32_
    mhdsF82RwycjmGuSc1EyAtJ92SzU7bwrZGwml2xe2js2hY50pbOiA>
X-ME-Received: <xmr:XEyBaeGJb_fyiKm_rRfrt6jdPH7Ero4xIqXdjkYIPUUUr0gFyaesuD6K0OzDcCh7d8RJ3xTBc7a0xMm_z1skKNuKixGoBhWxfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XEyBadLo6aIFIGet6AOrxMNivFDXvUyAtxpW8vRcFLI8fVfPIHGusg>
    <xmx:XEyBaSkDnu8XU7kk3TaCuYArji-QGqwUXBvuwtQO0KjITXRvPxrGFg>
    <xmx:XEyBaVR8gMNDDVzKcBoFil-Rgrg56rYsWBObYFHiAluX1vCEqlawlA>
    <xmx:XEyBaUJ7w6rZjfBMcKYPLqaSjFNQls3a1rGiBw-xFYt07wD4PzT5oQ>
    <xmx:XUyBaVlzrEyI-pwoDbBGioRU3LyX0c6gOni4btQ8tUTdz_EDxH8fVSTK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 20:16:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/4] odb: support ODB source specific transaction
 handling
In-Reply-To: <20260203001002.2500198-1-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 2 Feb 2026 18:09:58 -0600")
References: <20260128234519.2721179-1-jltobler@gmail.com>
	<20260203001002.2500198-1-jltobler@gmail.com>
Date: Mon, 02 Feb 2026 17:16:11 -0800
Message-ID: <xmqqjywuvd7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Changes since V1:
>
> - Renamed the files transaction type to be `odb_transaction_files`.
>   Associated functions were also renamed accordingly.
> - Updated commit messages.
> - The `tmp_objdir` subsystem has been left unchange in the version. In a
>   followup series, I plan to couple tmpdirs directly to ODB files
>   transactions.

Ah, I was wondering why the changes are so small (it looked
essentially s/loose/files/ and nothing else to me), but if we are
leaving the tmp_objdir stuff out of the scope (which is sensible),
then there aren't much left to do relative to the previous
iteration.

Looking good.  Will replace.

Thanks.
