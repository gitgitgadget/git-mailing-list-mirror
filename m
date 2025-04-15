Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4023F419
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744298; cv=none; b=ntURCIA6/G/hfxAqN/ztZNLpsqLQDQHM4q2kNXGAgYblW44VqX8XkhfyX1Ot7czKXe6x/MRjOJh2xaeb/kzOBGXtUMEragsTb5vFzL0Qi5jCZR0Tu2i8mQwDukXHQoU9/saxr3ZOGpgDfOHPU3v3T+FHglit24n+4sKmXrquEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744298; c=relaxed/simple;
	bh=xvnhEbLNaj/emw8ilyEJ/7u/yCGUK0D+BYrCLzk17dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=stSf6DiIjUFBZyJUJ09pRYc4vFc6CHc61vQ2Uj2Or8JnBtawEa9PwvIiiYCrnyloG6qEgxy4XY7Kkue1k3U2FL9qbg5c1Cn3hqrKea353xsdeJDSgPRHGOG1BGnoIMGZZCcb2lO6DNz6BwSU6gKa+vwl5JUGgKJ0bO54ddHCdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MeoIaowu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hx1HgkBG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MeoIaowu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hx1HgkBG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15D1E254011D;
	Tue, 15 Apr 2025 15:11:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 15:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744744294; x=1744830694; bh=PDOL8LLqCe
	FFoAsFwGeAtGGpDx0Pd0ThyC5lzA0H914=; b=MeoIaowui+rjwZhwjsnHPIqlq7
	TCWx8mixLFWR5VQLNWlMBki5let0Wi93Vw0jQ8rX0+tUJ3ts+l/UQ4UhSX9Owx7H
	4vQQdqvnj7Cz2Lc1cdNGmS0llip3atCxMTb6HpLx+gdgC1m1feWpASttqgpgSQum
	jjFrl5Hbgx+ycgot+7UT50GRbf4wxrosSoDTBXWVPypkZJsRYrKThKkeXsY/f+X9
	oEZYMoNDThy+aJKxHg6iXZzIyP5GqrDg+DFtnznLHDZquhfKV2cbuisqfiBQZ8oI
	kVgFLH7L9YzwuiK8XBL/ExoRMj4EGnUXIn/7sKPKYM+Og1yebYKS/wPAJc6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744744294; x=1744830694; bh=PDOL8LLqCeFFoAsFwGeAtGGpDx0Pd0ThyC5
	lzA0H914=; b=hx1HgkBGHtFmTHuO91xLjQ/Lfy1DSuP/6svAuAlhw+oV5WNrKlg
	n9b8ceP7339UtDgwOz5g7inP/W8Q+xotLpGF7WE4fpDJfG2i7GRLKNu1PGyLtxp0
	kSYXZrKmDK7Hlnhj7CYVrx8WlskhFOFXmdje16KcRhMVU7+M/jvVAXx5sh8NEEmM
	buMikbc01HkdqEmhbPchGeLl0fnWeiou3ofh1eaKyM2B+28H8d6qElCWywXgnPHW
	1BXwMs5A00fhTTD7wqBgwQDWgNRZLEGxkKerKuPTXmZX6oLg/HnxIIBlUJ1pdD+a
	fQL12WsoFf2FRuN+JWZZWifauudOQX6br6Q==
X-ME-Sender: <xms:Zq_-Z38lZtP7QeAuVVW3f8ByNbQnqaXZKUOvDL9tO2KiVjvxDXglBA>
    <xme:Zq_-ZzstOMN5rtDL5_WGaPlj52hOdB6mnW0GutiCocPf17f7uC8ee_XQMZYeHMGkI
    cZ-RooBHqoQX_gOzw>
X-ME-Received: <xmr:Zq_-Z1CcUmshplMMv13FuVDr8EVtvyfss2hSksHFEuZ0sKeJ963mEt1Tnlb5xHoW2JKlU0ZCguKdtsigylAYLMVIQG2KpX2wlfRG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:Zq_-ZzfaP6mLEm2Qx86wJukZfPc7GskLT7UE1AV_JrjJg8qpgY5Uew>
    <xmx:Zq_-Z8MXNYeDg1X9qLszem5icSkrbuHw52vptBGF35s3qusXatGWYw>
    <xmx:Zq_-Z1nsnseWuvkDdKdYMDkZ5TCZbEFjXrXhZovW46J251MOzsPEHA>
    <xmx:Zq_-Z2sprEnRyBEKo0-9pIF_qZTuUHKJOU9u_7CT-UKYSFoLrg6UAg>
    <xmx:Zq_-ZwIUF32-GfIje1JKLOYLCeXFpu1_7dqrv7PEjywuwKab5nIuzvBG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:11:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: meson build failure on 'seen'
In-Reply-To: <c358c9b7-bd83-407f-8abc-17ce9363618e@ramsayjones.plus.com>
	(Ramsay Jones's message of "Tue, 15 Apr 2025 18:16:02 +0100")
References: <c358c9b7-bd83-407f-8abc-17ce9363618e@ramsayjones.plus.com>
Date: Tue, 15 Apr 2025 12:11:32 -0700
Message-ID: <xmqqy0w1kzob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> It appears that the tip commit 916e0fb7c0 (Merge branch 'ps/meson-build-perf-bench'
> into seen, 2025-04-14) drops the call to 'find_program()' which sets/defines the
> 'target_shell' variable.

Ahh, indeed.  This was the mismerge I was looking for.

Will adjust the broken merge.  Thanks!
