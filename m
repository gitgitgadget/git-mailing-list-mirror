Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32082773E5
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101566; cv=none; b=RrX7XVcKdfmtIuhsX3HWKXNkPrVBtiJR7h9h42jPD8Mynj7IfEOMH2EfDJXE8tUfNH7FuBruDB/aMBmW7/U5IoxJ5iSQgyXotaZZdIHQ7VWJt+L46EMitQmYDi2/03Nxr/v9dERDU0xHP65EYkn8dhQscewLH1Ey01VFL9/1we0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101566; c=relaxed/simple;
	bh=dZxel30Gy8wP4ns+dETKuRMuc+iPgZvCC1A4VnOcI5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKrs5JGD90dNE8RX4PqS1Nj/1+PSWHExfnXCsaCznGWXdwY7fKAEDiFWfCNL/uT63e8mN7+qZr7tayBj2CxfVIWZQG8TcVV+Vxy+bxvYTQk+yI9brU2fILe84USj94PJcyDwMchYdzAh9Aj7dggF550vFFQq7A7zXJz0gu0zRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=trmEF5U3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9J5Ei1t; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="trmEF5U3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9J5Ei1t"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1011D1D0024B;
	Mon, 13 Apr 2026 13:32:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 13:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776101563; x=1776187963; bh=W0to+ird6y
	YX+tRIeG4bXpwHx3BAwsJD7j5qHTbuO3E=; b=trmEF5U34kbh95zY9oww6rXThe
	+rxwxEWirCcYyCxNe6+O3R+bAv9rIVsAr4z31DYCDifjyocYXHD+XrwY5bjxucMz
	GDw058VIUxBiAfq97fHqp2tgBnNM0FtPK83i48M1MBqfMS9ua3lHcmTyiDELF6X8
	v81qqxU4cYOOVBnCvODlzy1SXdmdRjF0QJ+qT3YQ6GhMuyjTajpwSZd2q6fKMwiB
	ktTx6GDJ+kOtx3UAnbtsmFeZr2/Ft9SU565vYrEqDUgKw13dpMrNvG0NQc4ml/CR
	wF5/1jtFq3RWae05LlekR2Xf+iqo40tyUj72UE0sR9SoqDZl8gig6RzEs1ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776101563; x=1776187963; bh=W0to+ird6yYX+tRIeG4bXpwHx3BAwsJD7j5
	qHTbuO3E=; b=P9J5Ei1txwULWDEozt6JbHaHMCTDB6QJrYxo9bvzGqxN6eAfiWe
	Nqzh5kWjcehyJFaJr4nhikq9Ucy22DjqOuhIF8El1afqF/eqwORRh/YuLdLJB9g7
	R+CcxF/6itj1/i3+UdiaodH9KDL2KP4etieQEEQjbWEOv75awjhraT98nK+KK4bo
	Lx0UC2KpyPAxhRFgRroal1CVEqbiMXPI9vhbywUIV26tmHvFOP9VPKsYHwBiTZcd
	2NAyZ4IQ/0yD1JcD0cgDV26Ap93DZAJqnt531DW8lpxzOROlG+KryqTiDKGlxYbQ
	0wW5YLr3wtCxLVM1ChQUe0NORuVEr89Etmg==
X-ME-Sender: <xms:uyjdaWSyJW2bR6A7Qoi2CwWfAV-5iC0K_lyA54hoJRyFtrI804qEaA>
    <xme:uyjdaSyNseY6s-rCImu15ox6QzYREughUpanXtRlc0tRVbNHSGq-EVvQzGQBSEXnR
    ew59PD2FnJmHxSavggclUnjgo_YSASkXdJe4balNP02iUbzs2WmDQ>
X-ME-Received: <xmr:uyjdaY2x6HieqnNdus1bw-DXg4YfszBmoNCG5P3N9HSDZItWXM_gpTnokiiKwM0VkzwpUpjh0mracdqzI7jhwNBEwNjiHHXQ1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepjeejgeekjeejgeeiueejhffhffetfe
    ekvedtjedvjeevheelieffhfetleeutdegnecuffhomhgrihhnpehmvghsshgrghgvihgu
    rddqqdhnohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uyjdaQ5VtFfFwMFhmxLOShGk5upuCKejZ7WHjapK6RwDLrxNosus0A>
    <xmx:uyjdabUAXJbjSlYlmE5tbQZJZAeWVbbCjr1xWq2G7NH5QcOxKw-LRw>
    <xmx:uyjdafA4QZkrRbvohFRpAa6BYVyAn9eagS9m-JYsujDhtUsixE8FVg>
    <xmx:uyjdaa7xF__B-wBih1YGUFzKXgMIZ2UlyP0msxTcExcwCiI8IPXKJA>
    <xmx:uyjdaXfwhlr7LT-HosRbCBp7oOwLXM-T59yQ5_FT6SBYsIqe_R032aRF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:32:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: am: correct to full --no-message-id
In-Reply-To: <typo_--no-message-id.572@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sat, 11 Apr 2026
	22:20:10 +0200")
References: <typo_--no-message-id.572@msgid.xyz>
Date: Mon, 13 Apr 2026 10:32:41 -0700
Message-ID: <xmqqbjfmix52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     I should have spotted this while working on topic kh/doc-am-xref.

Both patches look sensible material just in time for -rc2.

Will apply.  Thanks.

>
>  Documentation/git-am.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
> index 384e0cd7f9b..26c6670f6fc 100644
> --- a/Documentation/git-am.adoc
> +++ b/Documentation/git-am.adoc
> @@ -92,7 +92,7 @@ OPTIONS
>  
>  --no-message-id::
>  	Do not add the Message-ID header to the commit message.
> -	`no-message-id` is useful to override `am.messageid`.
> +	`--no-message-id` is useful to override `am.messageid`.
>  
>  -q::
>  --quiet::
>
> base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
