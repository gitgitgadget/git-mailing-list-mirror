Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF06361DDA
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920185; cv=none; b=uYRpTOULHhOXLk9IZYj1tTii7/tNbDXfsV9Xq6GP66+xgSRRl+0m3WFAjv6b0pdz4Qau6U3ASo2UAwIu41zkwX6asnwQuWvV1hbxKqE4eE2vIY+lohziaUVXYoQ5aDphJEV31wKXkH3BKfWRFtSMbkCfqZ4pecUbJRSD53mCX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920185; c=relaxed/simple;
	bh=CjIOkFwayt8e2CH203eapDHL3a22i+d8u/yv0a3p0MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOR365O+DnckytF93YviATulbB5dGwuz3kGKSyqz5dbv6BHeivZ7FPsPrc5MRNiESz/JBwcC1++f/euWiQGgIWKlDBVV7naYoqYcHrY5EToQDiufsQyOpnLVOg10udUowjUFOibIUCGH3Too0S8KbuhKxB3ofK6R3gLgOa7QvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nqmtdtlH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qRi4wkFL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nqmtdtlH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qRi4wkFL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 462DD1400096;
	Mon, 13 Jul 2026 01:23:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 01:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783920183; x=1784006583; bh=CjIOkFwayt
	8e2CH203eapDHL3a22i+d8u/yv0a3p0MM=; b=nqmtdtlHM3tUF9/0vWUlmblx95
	N5yHwVGF+XaE+eEcE3utI9qc/E6f1zdlNjQ9fX8OYPW+dmeIlp5XXahWJRdEMWFb
	4TLT1tJ2fgOoOL2I0o1jkJSxqPdpoZ3W9K0JLWxO3bU1WAU0T4eGR0gc6DkyJbIR
	w93F8bBl0De3Cj5QGm+jcbnO2jv/dR/t/rwrqMcYHwzpixEM645eIij/kP0DLGEk
	8c0RT5Tw5nfRg6lFGGfBlrZR42QuqtFn7MVIkojuqKZ1bmt7iTiyxdf2u/eUSfB2
	NxNXrjYyHDscpgQnalGf7/zfvxlZGioa3OnHE66zJonkviig0KZwRQfyPc/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783920183; x=1784006583; bh=CjIOkFwayt8e2CH203eapDHL3a22i+d8u/y
	v0a3p0MM=; b=qRi4wkFL0am57JpTymfdopnnrYSfqU5/zEweC+ZdzRsw7M4shih
	EDRUmNYbj9gRVlPH04pq2tXXLhlxWVJZ9xNYuNpXS2G7qHcAzM1Og/LcRb/9iQpQ
	uQP3CEAIw5eYfedq2voZ6lTN4YS34Vt8zaWOY84VbPZfnuT7RC7DvAxNJb9xV4Nq
	infKz4FLSRNtWKyKuI0PBVDq4P4qnfD41KI3B8k6G6WK89vOariFyxOCq6GB0e8F
	Ih+3PB05yhZCFNLpSD96NSRqRnxyDfiSoyUk/wWOMik3fCNRfB8Smi3xwpk2WL5j
	N3Kyqb3eGNbSOMnoSFBiPAvSwKbWEt85HuQ==
X-ME-Sender: <xms:NnZUagX9wz-JOEABkDXKeyfTCqQ_fkumVQt892nMQBz5gC7sfhnh6g>
    <xme:NnZUare0wjygpGw0a7HETBfHz_lDyYvha9tWbPCVE_S95we1okU-UgVKtN_oUKh_K
    qbpK2CmH6dq9jTdm70D1c6BvsT9L2n2ihPuZAqKncEXKdaeUjMrjAM>
X-ME-Received: <xmr:NnZUahXdiCJ_2CD1dfKvhK4G1ToUmohnTBc0NUVOr6WYKm36MmD54I5P7BmawwYsh9_iX6hWEt0Yb0AdcGUT5IZEk2hq_3dARlpxn-ld>
X-ME-Proxy-Cause: dmFkZTFuuUvd+wD8s2NA+QnZebw2zmjngSTg0hHYjI/vpOS+fuGsP4BEUqDMRyoijqp6Qs
    XH2d2TCRfglym2tZbNf0lTOwdoRonsUk520wOY2s4viTdsKf8E0E5vwz/fZa5ssyBRfju7
    YZvVQGWWJsDkgoj7ulAuo+QBAKbgFmvoxVtX68pLhCJpfP0fLZY1AbC/h5hKI6UB5sPoQU
    H86nhx2jvEr3DYxKwb1AEXIWnF5zKfC5lrI9vs7q2TZ2FoD08FAOd6DMUWw9taO3dXR/an
    fy0kiYEd9A0I6WCP65hMY2X08CdMyMi8+7uXSOi8fOu7xSPbb5kD/dqTktC5h/VsE9qAVR
    R7gZ4aRhL670JybW0sASh9vjGLBAFBeBI98JvMBt+ZUzGAMVYg327ZdA/tP78cPzySIkwc
    F5PK9nk71Nl6cpOMOktBkDTRXhIcLJshGUah3VRKxWRaol7yHMLOs3P/Mcc1KF62GG5W5E
    ZFH6fhCr3E5MehstwyXR7wahp+axZZ4YCzJi2gdaKym3BgzgwrUabKUyUxGYA8YieDtvbe
    uLI6QwCEU4bBM6bLixJCxIncMveP4Ttm/eW2RpLCwnW8+C9wM/5t5jlrIXh9TJlESEALyq
    x7Wr/GhHgCrblchB8rZ+R2VL7Lh0GezhOD1S70bfxMRn7tWtyl8hGrS5uerw
X-ME-Proxy: <xmx:NnZUascJFh7vtYxGKFbaJMOmFZ4TH9493zrxYDNfAtBskLwNXuTxyw>
    <xmx:NnZUalO0zZTc2mFFnp1OsVanFPY4y32UqKHZee256arJwY1yDta9rQ>
    <xmx:NnZUaihnBtBznKzy9kPeNpVkMxbLBO12UGLE5sADu7f5ENkzzrHEHA>
    <xmx:NnZUag3qZ_VopC75bvc-VrrLjLFCIlC5DgY1LJDlZWlDgkgDhI2ZBw>
    <xmx:N3ZUaiZfWBZr0VPsrg7JrwrHZMurNVjCROcWYYGmWADXBKQMJ2GUAbpy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:23:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e35ad423 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:23:00 +0000 (UTC)
Date: Mon, 13 Jul 2026 07:22:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix up lib directory move
Message-ID: <alR2MbquROPkcm1O@pks.im>
References: <0c94331b-7eb1-4116-afa5-811082ad5854@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c94331b-7eb1-4116-afa5-811082ad5854@ramsayjones.plus.com>

On Fri, Jul 10, 2026 at 07:38:44PM +0100, Ramsay Jones wrote:
> If you need to re-roll your 'ps/libgit-in-subdir' branch, could you please squash
> this into the relevant patch. (This patch was created directly on top of the 'seen'
> branch, rather than on top of your branch).

Thanks, let me squash this in and send another version.

Patrick
