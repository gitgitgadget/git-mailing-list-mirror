Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C425B2FA
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452078; cv=none; b=akP0VMa5rPOxtVQtD8j9g9Qp3qI2MhQViXpY4p4MZX7bmWOTxBHz99o55MZM89Jl+l7R0bIhMWtmHwjLfOLrmVrHaDtZPWEv+YxhlB2Y8fET07ntkyigYix5/lmIdQdTlTlzvQcX31/Dxp0goV042OvjPxqNTnxXHQMTrqO8Fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452078; c=relaxed/simple;
	bh=PvT6Wsyi7vtzr5KfLIPX70rkXh+5SBwvrcG/PSopo6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvPztHNIm/j3c8ec8vj8X++AdQZAbYKbDxzQlLeia5RFRx17x7OpJUAmfVpUfQ37y8hokYoCmum2vfRUixGzSZWaRbPgIVelpRmcqSag26k43jgN+D4t+Vw5jgCbPyglTnqW2wCe/EX+akbdqwO0IGZ4cpTiy7nOssQdV6iS2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bqPo13SF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTqBDtv8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bqPo13SF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTqBDtv8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 182711400133;
	Tue,  7 Jul 2026 15:21:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 15:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783452076; x=1783538476; bh=oBQ80ovVne
	DcRi6vmWB/Surjlk3igOKv4/221A36c0s=; b=bqPo13SFoP8mb9s38hkWJ6Wm3X
	MKZZMPiwTY0Tc7Oa+8iqBGvCQ+8pZ2OR/y7W8RKJ4GgB4ocdt4VQGWCUg4wR6VBZ
	eXseD0ham5aoUZvlcOovnSkDWFt033GDCZSP0+J5zJ1xM1ZV7wGNisypuc5cD74O
	HGCYggyZBE799AHFfWW0msYuBdgi8z9corBXOG7ytVryR9GXl7HTIms2kugxU2Uu
	YmBeh74rS62FDOXOOg2XLFMIRxDaacRgWLlSg+bsTb1wYkpvtSurpMZG0voV7Kk8
	AQznhiF8dTWFu3Cdcv1eoc4sNAkrSNMpdPTg4S/Cv+C7vY3V5QHZr+3o8zQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783452076; x=1783538476; bh=oBQ80ovVneDcRi6vmWB/Surjlk3igOKv4/2
	21A36c0s=; b=HTqBDtv8iPPQ7nw1TizUK0dtW5QjcIjddtFbpnaH++xiz62GH36
	If1vNQTTFkcp8QDcNGsZlUmX5JxSwk75fTCtSp8MNIXYeWjvnlBzkutJZYKx4tEb
	r1CMsTISfN6nRFpofE9+cblI7DC2kbqV0HQ7DJxfCEGMq/NPjBVyRemm4bCJMfcq
	8W2wqrV7D4dVTW0/TMpJfkNxhO752xhC0M5337PjJd2zL7GwJm4rexldjmhRTa0T
	QaXi/lRJfyollrs1F9tFGfuTKJTkughMC2KYFZ2DnCXMjMCFMFnlonXtUOAYfpjj
	kJWy4NIeR7NEiR9jQTvqPIwEXOu99AOWIGQ==
X-ME-Sender: <xms:q1FNav0mGLv71LqnlsBJVJs-K8fsP2yFUyNfwxueefm8WTDs5tCIYg>
    <xme:q1FNagrIP-aUJxUywW8vGLoGdqETKm42nz0AWRvX5OlYMTTW3G-xjBhC3pP3x0r09
    ui5jWdE-fNr9U22O-gK4_VMhG87MwML9dPpOgGErv-ca6XTIRH-NQ>
X-ME-Received: <xmr:q1FNajj9NvOLR_z2LE_bS9W0Ms8rIBoRm6cJSt3KkE1tiSJhB6PQkC8gNpCoKnduhDFRff-7iorNpKJwrDZ3UMTyaYf0YxXfbpXDCGo>
X-ME-Proxy-Cause: dmFkZTFApyl7KNztq2WHGDnySXVsGJiX+RHiSp4clbacicwkCt69ciu1FX5LURjKcbov2P
    zGl659uWILEGEN9jR8iCXe22XsHh5/nYBzuiT0BSomucqi6kpvCC5/7FrF6GeZrnMgD2Wa
    tlvUiICn6hTAE4FxZC+2iVYSLiiAsf/S/dGIGgimYY1NFPHqw86XDGHqma9LCvPF5miWXa
    Yuws32Z0LyMTuxHaIjCOUrx7XGEQkyjGKaXD2tExXDM7w52NVGOc+8iLHgjD9qYf+FQRU9
    Oaug1PsLD0KiWhzbpnINmqLKbS/3cAJ56s1o62YBCQg+0aYO1cQ/It85jAFS3Ni0a9W6iK
    N5c0wLq/FgEcy8JmTEPVUS2/01u8yM7Nai3N6J6Nwn2m/0DXN25J6BeBbIax7+XslCfm+X
    jz7fwKa8RdrNH5fP0TXVY18XrhfNJyi2Aa+3LJ+goNZ9bErNIoMso9oyE50pknA9Kkp7w2
    YW1VT84aQx17bhCI9XJ1G/UUuwaFOVyMKBzUX3tafh1zm39vAtMQ8uSVWJmqHFnm+mf1PL
    X8VXXvxYtReiPI10JfKKhvBIQbCUHBqsFVzrTN66qYXI6Yzma2Jocx5hpzLjDj9yuQNuYg
    Qfhf6/b29vkYhK2tJZKcgmOJtmWgPeRU4papcR51F2u1hzCETpQoXC3nt8cg
X-ME-Proxy: <xmx:q1FNak_WFgNc11o2YniVOdXAAKqWZ3jXzf2cAvQkMNSc-_mSlEV9JA>
    <xmx:q1FNanVpmGn5RyTkqXmpIb_Z9wwgzvMx-K2kkGDeBa9LjXgsTCLTvQ>
    <xmx:q1FNagC7IaTePaVquT_jEB5XAj_oi4gRiJxX1jb_Q3raAAbFOVTf1w>
    <xmx:q1FNakGbZV1TOv6NQVKvGbEXf0vSnf_PEtBx_8JTnXef5loAsMsoiA>
    <xmx:rFFNah6d95zpT9m_D02vA7ZB3D7XrRpDrkZW842Q3c0lG6Sn3IcqoaWV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 15:21:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Shardul Natu <snatu@google.com>,
  Koji Nakamaru <koji.nakamaru@gree.net>,  Patrick Steinhardt <ps@pks.im>,
  Shardul Natu <shardul.27591@gmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v7 0/3] Makefile: link osxkeychain helper against Rust
In-Reply-To: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com> (Shardul
	Natu via GitGitGadget's message of "Tue, 07 Jul 2026 17:02:22 +0000")
References: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
	<pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 12:21:14 -0700
Message-ID: <xmqqjyr638t1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series improves macOS build reliability, automated CI verification, and
> distribution support when Rust is enabled in the Git build system. It
> addresses three distinct challenges: a parallel build race condition in
> git-credential-osxkeychain, support for macOS Universal Binaries
> (multi-architecture distribution), and missing automated CI test wiring for
> macOS contrib utilities.
> ...
> Range-diff vs v6:
>
>  1:  0d215139406 = 1:  8f2bd4b14a3 Makefile: add $(RUST_LIB) prerequisite to osxkeychain
>  2:  21dedb91f09 = 2:  a999be69392 Makefile: support universal macOS builds via RUST_TARGETS
>  3:  8455e449f38 = 3:  32af2c51a89 contrib: wire up osxkeychain in contrib/Makefile on macOS

Did an automation go wrong, or something?  I have v6 queued already
so I'd skip this round that is identical for now.

