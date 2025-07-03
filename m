Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7512E6D0F
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542340; cv=none; b=FY2a6xedZHy59iZz3PFnMEkd3pJb6UrNZZ1qBlTmCMdjkKMGXXV9j0yTyYi/lerQRw5iPQ3Ef/mpOmX/53vGQHe3GIpQEWYy/2oP68SdEZUFt32xKqpUPkMicrfWvQb28K1zgOGUDKVk2UUf92+MfsvG46/13MRcUrCxRHtArUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542340; c=relaxed/simple;
	bh=u8iDh4wmyAfhIc29D0fHg0+fh8+gj0FBc9SNTVY3b30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTnkujP/YsW9xg1YdJ5dCXPlHl86b46QzgcmI5nAr1ELl0hHdQCI7v0erggTRYxszeRZDJfBSOUPkWcDwIbh/3+FFx1m910gYQOmSvo2534X02NKGAkh4JIWlxv569wXppAICQQhGoLlz6hRi3rX/dZjylETOPxHN1lr5/rZi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QH8fQvqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+puXB+H; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QH8fQvqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+puXB+H"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F26C1D00283;
	Thu,  3 Jul 2025 07:32:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 03 Jul 2025 07:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751542338; x=1751628738; bh=u8iDh4wmyA
	fhIc29D0fHg0+fh8+gj0FBc9SNTVY3b30=; b=QH8fQvqr1HDv6jI8blNYAGHJ+0
	CBr1krDyOBWU74uibRfhPdWkIU2Lp+iaQFLZab8YT+3WkH66+vJH3VQoAXe/IVhg
	Krxl4bPVFALwA5Ea6kHqwDyAVqcsy7fYMcYbseqdwnSwpq0MJadkVcIOudduflda
	sxX4rQPXMYx1XN/pVvfIiJoge5Joz1cydX25162hlUA3R+qApMUjgFDQ3pIO5RWI
	j/l2iP5FtFPFQJBR2njXbMgUCeXV+YCxntFf9oF/V4PpDY2GhvfpCFn7fetsgBEk
	zpeVwLhp2XLVDRrs7aWxPzEKS8ODxVVnYQ91tBZUHKmiqPbKR9+L3lEuBXUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751542338; x=1751628738; bh=u8iDh4wmyAfhIc29D0fHg0+fh8+gj0FBc9S
	NTVY3b30=; b=F+puXB+HxuWUYU74oFsrJjSohnsv9iGLDakY4ggDgBRAuQ/smEz
	xSb/gLT7xHwW7cThM2+Uu1sxRm9eRc6F0QcEFj/pTS5aAEwYePLs0eT4fsvFTHqi
	SbUjQRA5r7HnjTY3kGOd6tv4VZGypTtnqZ26R81Rq7ViEZdIw7pgYO4uOiy+qfWE
	Pl8m7nk+M+2CMIXXkC9WCRB98IAa+PgK++qsoImv+zjcfUNuEIu98vFS9iD9Fbpn
	pY2Ry65nK120RUHLvdsyUyFiSQuGu9EhlW1nYvbD+figIVN/6zztfGHU7eH2yTDR
	h3h8l0hJWsD+FRMBe6AwHUWZF4BNub8kjUQ==
X-ME-Sender: <xms:QmpmaIXP0W31ekyCFt-9plWr_E0N1d0vBzDAWCmTkNqyzwcZWGQkrA>
    <xme:QmpmaMn1WC-mNFqv_rAr7w56w6FK5_O0U9Ic8RHmdn-OiVox2h5TZmHDAlhAfGGso
    fMbsYpclRJTgyonog>
X-ME-Received: <xmr:QmpmaMaUX_BpKaz3RNjx2dlbbAtFV5z3_GVSYjiP3E_QlhFBbyD6HNGMgqwzEO3lERacda4hRIWBzJpdceCYsnmwGf3d5HkJSF7JRfA6xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QmpmaHWox1eVpgSzqIYP9og_vhkKkqZc4kUyz7NzKlHcAKZF_ULurw>
    <xmx:QmpmaCmce79z9xvMvSp_JZEaK4494iyY_-YF1GtqlM_fPP_lTcidWQ>
    <xmx:QmpmaMfvoJoPR_JFVxTQpTFWpJu-c3y1AcvBz7jVrSLcd7ME0vUUgw>
    <xmx:QmpmaEFzBH4Ugpb1s6k5dpyEhfpqpA8KfboWhO-T59SwyfqeudXOsQ>
    <xmx:QmpmaH1ZRPUOXsQkfejZdPwz2_aWX-_RScq07kdHuH2oE0irVRT6LdV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 07:32:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78b3a742 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 11:32:16 +0000 (UTC)
Date: Thu, 3 Jul 2025 13:32:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com
Subject: Re: [GSoC RFC PATCH v2 6/7] repo-info: add field layout.bare
Message-ID: <aGZqPC47iPMixyvW@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-7-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619225751.99699-7-lucasseikioshiro@gmail.com>

On Thu, Jun 19, 2025 at 07:57:50PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index 6ce3e6134f..1650d3595c 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -1,4 +1,8 @@
> +#define USE_THE_REPOSITORY_VARIABLE

Meh, `is_bare_repository()` strikes again :/

Patrick
