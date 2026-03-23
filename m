Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977333B8959
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284886; cv=none; b=EiHxoYnYxHSr4hJQ17ekzKjQlb5AeMDIZ9BnIiwKC91GQsX6IHpKur5dbOAttt4TA/bnBQV6/sji+gFab0vs7IKtDLCvE8aWChnzOgQyo3+6NTfDqOetIFiR2DiGm6oz1F/407gVFP04J4pI/ZA8hTHWrW4ovVz+yxw0NLLOmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284886; c=relaxed/simple;
	bh=BBMC2Qrg8WZWOPt90NfYpOohv2EZIL3WAUFJBadRTQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mArS7wf+QcgwXjpZvxkHwhnxfeD1vnD+ChZwCgR1KMCCX9InREj8qH7DDzuHvDB6USUarjM/8J5DS+0HiB3XkAFC7VNPwmj6nLka88+GEvh5B52BUBI5XmokKvYuYQE65Zp2KyRiBtu2VWw/ayfeHXiEbSjYvQS8hSj6ifEdRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4h6cE4q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJ/guJAy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4h6cE4q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJ/guJAy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC93D14001B2;
	Mon, 23 Mar 2026 12:54:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 23 Mar 2026 12:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774284883; x=1774371283; bh=y0OFv3awZ0
	VrVEY6UQ2fkwXhnSqVJ1rbbUfrXi/NXO4=; b=X4h6cE4qggqi3andGkgbki0F0B
	u1Bbw8RsSqdXVCcdniypyAUHXqugWz0s9jSbcXTRCNzL5AbDuryNrSwxkgOHfvOG
	qAvDj36txz0SH6GTcrL5aIdCpYezi5KrZOB7ngtP87E34+MPgdnt1/xnPvbOIBvc
	78Z/ZmhMcEKnELbuQMWkGKPoUVz3riGnVXL9glp99gN0zEkNX45m9KBM7IJ/X+3G
	P6K/mO0Y3czibCSw/Mk7H+k/VOcX1U57zlwMvhONhUK4H1T94n9tLgmx7SqR9VGe
	MvNms+PDVrPQrRsh6bRHTbTGie93qGTC+ATVpJ30fyLEr3h1jwtGdO5GQVJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774284883; x=1774371283; bh=y0OFv3awZ0VrVEY6UQ2fkwXhnSqVJ1rbbUf
	rXi/NXO4=; b=QJ/guJAyB7ejM3n3CiX0yca09dhpcPo/PE7KpWegZWKqxPESlmC
	J1NGKy/nDw86mJK//2ypjBwAS0aTfYW2KfR8GzmrR66C/NI68Xg8JA5dq3T9RRS0
	/jZPREtRLfe57Wq2Y9f0j3sG5tkRGo0/vL9bUWyZDG1wcaReNFNC0VcO7kkp5lwe
	PsykTJObua63QGyJm0wyHVOzxY1bBmdmSm1DYOI1TzkCf0fp4hebPOOaSNpUxxqq
	d9a1RppbV4W+vMhF0JwXyxOyKEGo2trOzdMmysY+uQrMEt2hFHZnZDFyAphAkpab
	2alBhhf/I3c0qSKuOIFYNxyaswGpBJeuq8A==
X-ME-Sender: <xms:U3DBaZh4q8_nqQGl2Q6bSfO3KteTp5tHiXHv2GTDeUdTD6gJxMf7bg>
    <xme:U3DBaVCpqdmosdfHYkSNNwHT-PXzi5SyyXDhFm_baFARP4wQicQARHXIP2te_tKF0
    gb-FFntZMLl73KTH_4etf2pIbPDMaEaeAdSEg4_SEQ9Xh_FzFs>
X-ME-Received: <xmr:U3DBaeEEBf_If00hPAC8qAxB19RCPaJ-_JiHJYAVaxvDz5nQDU_w6LAUpSDM61tsYYf6OuW165EBh0ZuOQAzna4SlUGfZ6fOCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffdtvefhgfelgeektdffteehleefuddtvdefhedutdeigffggeethfehffeu
    ffelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhgvghgtohhmphgpvghnhhgrnh
    gtvggurdgtfidpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:U3DBadJHEY5t8UcrR216kHaiZDwoHNHfu2LhYwoZXxMeKww-fR23_g>
    <xmx:U3DBaSl2uwI9lNB6GfjdoMXGjyzR8hYgPXRAdhkXG0rg1judVtrviQ>
    <xmx:U3DBaVRzXGBWoYCGjnR2vXnOQR22g_-B2h5zJhbi00el9zZPQVrVRw>
    <xmx:U3DBaUKmVciVGaZvk-w-4XI5ZbC8Ht_w4M4NmP1PfG7S6W08MTCwCQ>
    <xmx:U3DBaTaBoyVALTxRoY0jUHDIvpWhx_yGt3RWS51vjhrEgP3q0FcfspOf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 12:54:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #08)
In-Reply-To: <458ad3c1-96df-4575-ee42-e6eb754f25f6@gmx.de> (Johannes
	Schindelin's message of "Mon, 23 Mar 2026 17:32:41 +0100 (CET)")
References: <xmqq1phc9x98.fsf@gitster.g>
	<6c108696-2d41-4fa1-9662-fbf6db97f767@web.de>
	<xmqqwlz392k0.fsf@gitster.g>
	<458ad3c1-96df-4575-ee42-e6eb754f25f6@gmx.de>
Date: Mon, 23 Mar 2026 09:54:42 -0700
Message-ID: <xmqq8qbi5vvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And indeed, the broken `macos-14-arm64/20260317.0174` release has been
> deleted from https://github.com/actions/runner-images/releases -- the
> latest published `macos-14-arm64` release as of time of writing is once
> again (the last known good one):
> https://github.com/actions/runner-images/releases/tag/macos-14-arm64%2F20260302.0147

Great to know.

> In light of that, the workaround in
> `js/macos-homebrew-forgets-reg-enhanced` may still be worth keeping as
> insurance, even though the immediate breakage has been mitigated by the
> image rollback. We would be one image refresh away from the same failure
> otherwise.

Yes, it will become necessary to resurrect it or something similar
when they break it the same way in the future.

The question is where we keep it---I am assuming that forcing build
with "clang" to use the compat/ regexp library replacement would not
be something we want to do until they break it again, so keeping it
forever in 'seen' does not feel quite right (let alone merging it
down anywhere near 'next' or 'master').  The lore archive will of
course keep it safely and we can retrieve it when it becomes
necessary *and* if we remember which patch it was.  

Would the best thing we can do here be something like this patch,
perhaps?

--- >8 ---
Subject: regexp: leave a pointer to resurrect workaround for Homebrew

Recently some GitHub CI jobs were broken by update on the platform
side, which was eventually resolved by image rollback, but in the
meantime Dscho invented a workaround patch to sidestep the broken
part of the platform.  Their future image update may contain the
same bug, in which case the workaround may again become needed.

As we do not want to be building with workaround that avoids system
regexp library altogether unless the system is known to be broken,
so short of an automated "detect broken system and apply workaround"
mechanism, let's use the folks who are compiling the code to detect
breakage on their system and cope with the breakage ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/regcomp_enhanced.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/compat/regcomp_enhanced.c w/compat/regcomp_enhanced.c
index 84193ce53b..29c74eee99 100644
--- c/compat/regcomp_enhanced.c
+++ w/compat/regcomp_enhanced.c
@@ -3,6 +3,11 @@
 
 int git_regcomp(regex_t *preg, const char *pattern, int cflags)
 {
+	/*
+	 * If you are on macOS with clang and fail to compile this line,
+	 * https://lore.kernel.org/git/458ad3c1-96df-4575-ee42-e6eb754f25f6@gmx.de/
+	 * might be relevant.
+	 */
 	if (!(cflags & REG_EXTENDED))
 		cflags |= REG_ENHANCED;
 	return regcomp(preg, pattern, cflags);



