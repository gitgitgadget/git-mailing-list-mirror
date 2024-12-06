Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB820127B
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480865; cv=none; b=oTkAqO2aHo2qVNhDHYO2AtU52lxASWvrjV19/cr7vRGivms1MS9DMcgGpiG9Xp7ccwQxct/atjoTvrOMfZfosUg1bhJiH/aEInzd5YvqKzxHoatxSg6FZN/K8+sknLcDuhkurEQLyg3UFMkdV+nufaFq5SGV+835oCXPTiyExZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480865; c=relaxed/simple;
	bh=3bAiEC3dupnf/7lgMKCnNShW/DVInUpbO3Zl9XrZQ0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyMC9CCnSWrxe9+Y2EPLCcnZSrJBnecGRlz/i8+wIM633+LA/9Bf2WgnZyCmNvS3ux5GQJwTegKP58vNptKKechthHRvQSJurhSk55rVjkxrfbVGKxsVXfabIZfUCob+JOw/ICMgeGDA+5RGmcNJ/K1RLfTwTF7QLi8CeBUpv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rlfxlnpc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g2jUcu2P; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rlfxlnpc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2jUcu2P"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 525AB114017B;
	Fri,  6 Dec 2024 05:27:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 05:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480862;
	 x=1733567262; bh=cYzUS1HzqYti2IA7mNf2QlhblaIXXfyAVh1w59Hu4o0=; b=
	RlfxlnpcJ31g4b4NHx9XD5eymPxyHs2ID2CoUA56BAvgeyRhUiExBfx/FkHU5H1z
	AkMQhvL2dqrzubx5Plgzq8YcPxv3ngwAXF3V5bTv3Nxd1Y49cpBgIBkoXtabK4LM
	8+5x5aWGaHyGcLQU2icMv9t5nnISzyD1iXhlf5g8IYQEXmnm7hXaZNHCscWwo8X/
	oIR7f8AEQTwovY2vH8il962iC416q92bF82SV1GE5XQxoiTLnk8vBSdIY3HYYmDi
	25aXVllI9mYPhePCy2GESyX1hICVS0VrMnmj8QpM8WS/VKNoluxyl5uqiwLp6Suf
	OGMdbYTU3KeYFOhNxPc6rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480862; x=
	1733567262; bh=cYzUS1HzqYti2IA7mNf2QlhblaIXXfyAVh1w59Hu4o0=; b=g
	2jUcu2PoCzLtO/EKh12cENBaqXogeB83KBTqIPfi4GvCdYJBy83nx4QIX0a3sW8x
	WJG9m2Uk1s+44NttX8RUw59gnIVvN3gvYB/3EUAxJCdf4ywWNkjMf19eEJL1O82c
	qKHyRfKz9VIdFQUr1FxjoONzwSfxWrPPs26VZcKoh6M/AvHvg007JDLmTOskjdeT
	9ydvoqV9SLw0pSBrSmgf1Xw6+PZtAqd3loXYdT4EQGrmwwQFPboU5J4ktofWoTbq
	l9HaMFZNIpRukSTmDSVnL04xn1W70L5r5kamkYMgdizro/QmtMFPcxFkg+bEsYXN
	pfTpYJZUAGCOh7cRVrImw==
X-ME-Sender: <xms:ntFSZ4p5lfRrTYgzI3Z1ZMFsv2miKqZxm1j3zQwf_Qe7tdRoQvj3IQ>
    <xme:ntFSZ-rXBG561cTAtnPm6suaN4_yHkpujE880_b7EZgMduqNIf4M83MTAYq5uwL36
    wxSUHGuZ6MwjGAA6A>
X-ME-Received: <xmr:ntFSZ9OCJCG7JDGvoQuQyq1eDc-6we2m-evy7KH1cPcXpC8hsjWRbpzuc0glw-WEmpWEbnvvPRPHz_t1rMA_qLTd4p0BbEo_Q1HEAVOnQRIP6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ntFSZ_6xfMPa8NUUr8PH0cjA0j9TLlfX5YMmMLaXAuu0O8FAvmVrgg>
    <xmx:ntFSZ37BbdplO1jmn6X-nfuQie9ySakV1D-0s5-aMst502K96N4nqw>
    <xmx:ntFSZ_gyocEUWI1Rvx2LtSfkHBs2MhvQJ2ZnTKuP0UXZB1j83U4ueA>
    <xmx:ntFSZx4Vq8SQ1sMi3hLP7_jQP7vtZS-KKv9I4aILwKTBo5LKenmaNw>
    <xmx:ntFSZ63pcqCEcCYF6QfYwZzse7AORTTgyOiTqte-oFH-8ANB8oaA0FoK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 35d2c3c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:22 +0100
Subject: [PATCH v4 07/16] csum-file: fix -Wsign-compare warning on 32-bit
 platform
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-7-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Junio C Hamano <gitster@pobox.com>

On 32-bit platforms, ssize_t may be "int" while size_t may be
"unsigned int".  At times we compare the number of bytes we read
stored in a ssize_t variable with "unsigned int", but that is done
after we check that we did not get an error return (which is
negative---and that is the whole reason why we used ssize_t and not
size_t), so these comparisons are safe.

But compilers may not realize that.  Cast these to size_t to work
around the false positives.  On platforms with size_t/ssize_t wider
than a normal int, this won't be an issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 csum-file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index c14bacc7f9e5f56fcdb06a3abc7ac9babc45041a..5716016e12eec8c35f6495141fb2fcc250732803 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -9,7 +9,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "progress.h"
@@ -24,7 +23,7 @@ static void verify_buffer_or_die(struct hashfile *f,
 
 	if (ret < 0)
 		die_errno("%s: sha1 file read error", f->name);
-	if (ret != count)
+	if ((size_t)ret != count)
 		die("%s: sha1 file truncated", f->name);
 	if (memcmp(buf, f->check_buffer, count))
 		die("sha1 file '%s' validation error", f->name);

-- 
2.47.0.366.g5daf58cba8.dirty

