Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED032E696
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160298; cv=none; b=My8XGGrLn8fL/gUbRhIDeiNspjOxUo4rcRKpQczOQIzQX63g5jayxe5wc3J5nwf3C9g0gLqBPQCpOcSABT/ekSbMsHxMLKRfW7tijGYehUj4yuR8jTj/rMkr9EqJrU5NKTmJUcRXLWhZDPFXu5rl+odKjaanWaey5rMhy6r46h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160298; c=relaxed/simple;
	bh=9MClX2RpWB3mSAmRDWmKFDOZJS8xmhlikQr/hFip29U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wt03FFrgf6F5IKPLxJ731iYRtjFhGrn70OsBpRX/kbN2XurSZ7HTGUvd8X3M2U2IZLfcOB1gVDB1wbkeyUqmDEH/bjtlIDSvMyY/M2eJcvSPzXVd+0TELBADSIe8z4K0KXjTlUC7xPLysJ/0g47e+Udio+yaGFqr+MKwB4sYaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mH4GLFaz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJrHR2ZX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mH4GLFaz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJrHR2ZX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 62CD21D000CA;
	Fri, 11 Sep 2026 16:58:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 16:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789160296; x=1789246696; bh=glNVyDHfCG
	VFEiwg4++fkDaX31exYcAyVM2/hyAE2DE=; b=mH4GLFaz3oGjuw7jq2qQBXzVdQ
	QaD9CjK7lnEp48GzbYSY2FF7e1XLmRT2V6WogX/a+RMP8DZnEfT29ls8GHc+lSzE
	U3dQIbzX1JDs9+vlN5ZCMeO3lzmkslMNLighdz/9G3UjdFA8gsyXTSv9x/JZIi9P
	Fkg8go5yvGSFR+etdZ7cDeA3U7TOZeVsXdn5bHEKC/rimX7q3bF2Vjf8gI6zOdBA
	eioJOTAeFoWWu/VBnutMoogS8HZvE1NrboUIHsfUBwoS7iG2F6B0OCQJoSJz5/9R
	rZB4QEIf3Zih2qhRKcjYwZbM3ZXrOnC2ebVBt3AKDFhWrr0CHuvYDxWztEHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789160296; x=1789246696; bh=glNVyDHfCGVFEiwg4++fkDaX31exYcAyVM2
	/hyAE2DE=; b=OJrHR2ZXVx//jvtQoiAIDcuVsP7IGEDrEhgeEzSdQ+xOXWrgXd+
	K+leJ9dZWIIPJdLZf8C4ySRdTY9n9Bg8DqSmtnRc4Mi5crFXYUnk0Cb0UPOZnqWG
	gEk8hcealfJav20nQB+tofZTIMrQb6qKw9rjnSTag2C4iKxcd2X2iYwuSGlegk3Q
	D09uSDykhzZj06Xwa7Pl2OjPnK2a68eimGFkOkSDRXle/F7T1+/vnYkohnySkLbN
	8evrVKcH0eqrT2Qd4Ar9Uap4Kk34xdNksDuzwxSB4jenLUn/2sqhPuZWcOmZGJYq
	xBN2fcEXzKNNvf3KCE2wgvTLhyBUvco80QQ==
X-ME-Sender: <xms:Z2ukart1f2x8BTHzu-OazB2malW0OZlZAk9dM-FKHaf7MnUyJDt-LQ>
    <xme:Z2ukajUJnIP42qdZzH2gZHON2xnrYhn-nnGogHq93MeJ24mnxDBA-_ijmpoDudz4o
    jwP4V2ssVVzG9g16POLuzP-4trpIx0w1wKykY9SEZRc5Dh_sfoUVsg>
X-ME-Received: <xmr:Z2ukanEcpE_pxDARSptOmCK3hEBJcwpsuEB2KxsKSWdtqKsgZGJLxBR8-0-vM6GjBi3p9Da4Sel3KVeQHsOJqgG6tVJj35qMbcKK>
X-ME-Proxy-Cause: dmFkZTFFq4gm48mQBAkeLWIr3sJ7d1+NLt2UG06xmVmEbkKZFydkPnz8yljsAPO+dn3zqb
    SHgRC4RM+YTJT8OUzhkoV9ZxYIT8vZpqAQ6IPqac24oSv8w9AEI2FNfVCPs2z2rQafyyTE
    Jsn+L4zHeZaa0K8NpLf08Yo3+80v2y2fcFXf5qz5XmVAxv8b4BDXlnb4N6ak4CjcaRlJzK
    TFK2MRykTIRK7S4EG7oShv9jagmCVyjAct1K7sgzC8ywiaYPTVRdax6bqpl/bssAyAB7Vq
    ++JCWQuaBLufBJFZcewlameb5qHwyXlY3pC83U8RvZ8P7IGLxvO809368n8SvrpVr0U9nn
    DiROxFdYt+PqHgNj0cK668o43ZiO7/mB0IoLgCfurvogtBFR+QIl1mch7I7kbr4zcdG0N/
    caZhhOYGc22OC+PaQuKK/30R4c29SZzyf4mtwbVN0uSaJmfmORgnRlTv8us3f0cDvN4aI1
    /Q/NO6apxQKnxJqOOcJur7qkbnmFP9R3Z5KngW7TbZu2uSmepWBzEeR2fmAmOtxoRPQPwE
    X1mns/omaXkBGMswYWa4NaQLID9icW4GMCFex3OAzbSgwMY8d0m5Zh1kIv1Ju8+x1+3joK
    WJDwn/BCb59Zcj3Yyc9WjO3kKRuO41bVVPzPoFEwLmkPDK1Bahf8Z9/wIqKg
X-ME-Proxy: <xmx:aGukal3MOhZTARwIDhw1Wu9j1jT6BKBDqUCARy44AcBdoW0presJvg>
    <xmx:aGukapNOdov4ohWzVBY5ZPAltJWQus0_6iR-DFW7acgaE1k8h-S0Gg>
    <xmx:aGukak7gd5nfUnfP127BgDOZGvH18G1z0b_uBs_tYVhntxoZsAA8Hg>
    <xmx:aGukaj3dsc0QDWDxEdr9_JjGqXU53cc6WqR38YYFqPMFKHuNJWdcNw>
    <xmx:aGukaiJYU1Dbvo6ZcrTlq-SHytw30khwBkJXSsrkdHjYDFjWVg5k3h1q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 16:58:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH (RESEND)] ci: use system asciidoctor
In-Reply-To: <20260911195250.31201-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Fri, 11 Sep 2026 22:52:50 +0300")
References: <20260902071113.GA70165@coredump.intra.peff.net>
	<20260911195250.31201-1-taahol@utu.fi>
Date: Fri, 11 Sep 2026 13:58:14 -0700
Message-ID: <xmqqeceza4k9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Notes:
>     The release notes draft for v2.56.0 already claims that asciidoctor
>     has been updated to be installed via the system package manager.
>     Clearly it refers to this patch which isn't, however, anywhere near
>     the master branch.

I think the description was added to the release notes in 47ce80527c
(A bit more for -rc1, 2026-09-11), one integration cycle after the
2.56-rc0 was tagged.  This patch and Patrick's "gem" patch were
merged between 2.56-rc0 and 47ce80527c (aka "today's master").

So there is nothing to see here, I think.

