Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB933A5439
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567681; cv=none; b=F7TMBsoSSwxrIsp75ScNc5tbFCtGOfSlQT6p0KdHIcW54uiQ7IZUU6gl4DiYkle1L/c71RYh3JoTe4XWsbiXyrmGH77XIlvIKm+0E3Gcl8N+/yHXCHlo47TNlyvqzHe0/qIX/oB9q/55/x0ZLGLMbvLTNmDIxPw46Gjj10MJopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567681; c=relaxed/simple;
	bh=R1bvVu7Gcv4nxqxRQPKh75MSpzpkJ06hNIBGTJO9W7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qqf4tsXoee4HqU4g7z3Yaj7OzVhhs8ooEHu7YLP5rfAojJwTWHjdEITn5EnKcHCU++ezCRpwk0kLiaPjHjT7OHLAillJJiNOP8KC1suHIM32fI5qNrH0Kd8qrfLF4hhgLrd7GFTrEzLxDBJ5Ui6n1RHJTtZkp+m3+ngYhPtDFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tElTbyPP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gD087K80; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tElTbyPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gD087K80"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C04614000F1;
	Thu,  4 Jun 2026 06:07:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 06:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567676;
	 x=1780654076; bh=zxG8UBm2SAFJT0t/UvTPOEauJkAxh7EAF0/EnOA0Uko=; b=
	tElTbyPPF0Mct2nawDZJKlrgX1wtEDn/k2O6hkpY6/99P2sBkopBwhikct/jTpsm
	g3VPUwhWSkZqDH7FUZlmOVBYnoLy79R85WXe4nsGFdiSzEaP3xE4lVRlC7sDk4dc
	BbshjQcO7U9aqIUjutX2eC+lCz35+TH5meayrGG523TicM5ITkNUrhN8MOj3HeYn
	LSb/uL2KjFyw9ChQIfhVA1zrdJhASCl+TvlW3Z2hZ5ZZt9PdjLkr/Lp0QPzAnxBO
	2iaKmBb92rko+KxUvwPX5aY4lbAi1M3afTqbZv4xNyev4OLWEKL4nfe3sv32U3X3
	OQDXvQSx9205iTiDxDpz/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567676; x=
	1780654076; bh=zxG8UBm2SAFJT0t/UvTPOEauJkAxh7EAF0/EnOA0Uko=; b=g
	D087K807JXJg1B94NqeIKdGZWMzuldlJVKMv/KRgTmmMO/gQeOXaQXFZaqVOM6OL
	MrUT4WsBLEvZT1BXvZeUOwMaTjIAhv8PZTIpp8S4eaiiP/5xczraM0YjotSe4Oql
	YG5nrurcrrQss4S8NJB2HdX2FsNKFexCk7+XzCoomXbwTJQs5JglOe+yIQBLitPr
	CreD22YZyYA+8NmOfnxn7DCMAd4Uj1YcM6Br3JjcgjnJLEwMIkNEnrwyfNYZ1apb
	b8hLUjwI0MXJ3P8oLvh/otLb7CuT1OcQqxI6f/Kc9KI8Ai6Lhaoqy3jy3ylHCuoT
	9qMKMY4ILSLJOak/DYN4g==
X-ME-Sender: <xms:fE4hapjIvb1u1jVMvP_9YmGogaSQq5HlYZjkZTJGGrgWNxkl9JTJoQ>
    <xme:fE4halfw-LkvBLhOljAnEfA9RdktfXKS-68rsWK4P3PRVs3-_C_JU3AgHQU5JGUc-
    2El9HSb8ZuCWyO1Cm5uFUddu6nLCJdlo7uEiCRfJefdsuznLOItxw>
X-ME-Received: <xmr:fE4hameHng2-FT_3kWiqWSphSFLDwVLridStelvpSNKRBRI1r4Rfzk0Lj-ezl-Pqf0P7kObw_mq7m4yqGt7V8is5AdlLAPvX-VS6TmGnXfc>
X-ME-Proxy-Cause: dmFkZTF97uXIgYi2XOVONy3OSnAk1KnYayqV+MuWi/V7XF4ljE2olCYVOAFXzrzYCEA0Nf
    N90RNO8k6i6TKJ+3a5Iu3O2BdPv1FHvho+8i3yIq15qVJDJfCGrPva8qJcXlkJf0nk5EXC
    CX/C0VRPpQUNcHD1NbLZLz+davAp6J/hinNSXl/sb2YfnaYUJgibYWWepM39TFCGNMSyE0
    DcMEW0njie5NEET8/nM16xahWCiia4dQs9pgiSrdrhf/Ir/dn10/PI6Y8QXwhR8neProFE
    Skwe2zbfptTB8vwwBLFZMP5eh6yOWeZe05fCZkJ+GNa3qJXTeCVO4ZK48d3rPA+let/mSM
    kC9Vp/F6igXk/uIKIP11sfOc4ZDN2Ru3QwNaMGDeTfhuJNuH6082wndSmpNnThy39zoS3f
    6Q655EmYoo6idhhQdFtijRapN2OHmE90RZYcn4hTJy1s6RLVgiiw6OiBtZj2Oc4U6t3wy0
    18wQdxVrOS0KBwdJZG4WhG7ryWula2cSQGM7/ZLuUrn1JFb+BYCjOxRe6axZk+dq5f8IX2
    0s+L+T5ebBL5TSLvd1DokKIVAK4DOHBOKtdZ0YTviB4VeJ2hxTh6ITpM8dgTbqUV1p6Rj1
    +ZtKglo62qbSxjN/nl/9yyHAWIMOjrUyC9VJCv5kVFVOl/DNh2SmYusJRTMA
X-ME-Proxy: <xmx:fE4han-05Ed5aS87wZY6nZlTR_cCJJ2lVE_jxV5ISfbFWsH5HHUHzg>
    <xmx:fE4haqlvAAheSZaoSTw2q571GfPGzRiORe3ueKC1pIohw8JmhEDtjQ>
    <xmx:fE4hah_i3lQtoTank3KMwLbhMvC7jbcH4DLa2jOaxn-gAF_GkdEcmA>
    <xmx:fE4hagkrdSb-88C1RV7VPxCpXFL-jNPOFXfKevMoBPL1-IhGzPQFKA>
    <xmx:fE4hagMsKMHpNQjmBSVg1vVuKHi-XSQT1XT7Yy60_XygqslX6CS5y1Bo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ee6deb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:38 +0200
Subject: [PATCH v3 8/8] t: let prove fail when parsing invalid TAP output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-8-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

To make the result of our tests accessible we use the TAP protocol. This
protocol is parsed by either prove or by Meson. Unfortunately, these two
tools differ when it comes to their strictness when parsing the
protocol:

  - Prove by default happily accepts lines not specified by the
    protocol.

  - Meson will also accept such lines, but prints a big and ugly warning
    message.

We have fixed our test suite in the past to not print invalid TAP lines
anymore via b1dc2e796e (Merge branch 'ps/meson-tap-parse', 2025-06-17).
But as none of our tools perform a strict check it's still possible for
broken tests to sneak back in, like for example in 362f69547f (Merge
branch 'ps/t1006-tap-fix', 2025-07-16). This doesn't hurt at all when
using prove, but it's quite annoying when using Meson due to the
generated warnings.

Unfortunately, there doesn't seem to be a portable way to make all tools
complain about violations of the TAP format. The TAP 14 specification
has added pragmas to the protocol that would allow us to say `pragma
+strict`, and the effect of that would be to treat invalid TAP lines as
a test failure. But the release of TAP 14 is still rather recent, and
Test-Harness for example only gained support for it in version 3.48,
which was released in 2023.

In fact though, this pragma was already introduced as an inofficial
extension of the TAP protocol with Test-Harness 3.10, released in 2008.
So while not all tools understand the pragma, at least prove does for a
long time.

Unconditionally enable the pragma when using prove so that we'll detect
tests that emit broken TAP output right away. This would have detected
the issues fixed in preceding commits:

    $ prove t7527-builtin-fsmonitor.sh
    t7527-builtin-fsmonitor.sh .. All 69 subtests passed
            (less 6 skipped subtests: 63 okay)

    Test Summary Report
    -------------------
    t7527-builtin-fsmonitor.sh (Wstat: 0 Tests: 69 Failed: 0)
      Parse errors: Unknown TAP token: "Initialized empty Git repository in /tmp/git/test_fsmonitor_smoke/.git/"

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d1d24c4124..ceefb99bff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1532,6 +1532,12 @@ then
 	BAIL_OUT 'You need to build test-tool; Run "make t/helper/test-tool" in the source (toplevel) directory'
 fi
 
+if test -n "$HARNESS_ACTIVE"
+then
+	say "TAP version 13"
+	say "pragma +strict"
+fi
+
 # Are we running this test at all?
 remove_trash=
 this_test=${0##*/}

-- 
2.54.0.1064.gd145956f57.dirty

