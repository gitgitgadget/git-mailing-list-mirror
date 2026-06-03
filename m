Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FC38C401
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465209; cv=none; b=Tm0x/wPjE9kzeSxGYcbS+piWfH2aTDS//p9Q/FUztlvov5y3tzghuWLvXBvFv6Az2gK5xB1PQ0V9YMSe2ZapMUtRavcUGKrSvToolHozlP3iyMVJQQwk1rErtyxCUfzy2SQd6EoaJQKv//crZ3X7Cm/20zr4qyuYN/UvtiTDyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465209; c=relaxed/simple;
	bh=R1bvVu7Gcv4nxqxRQPKh75MSpzpkJ06hNIBGTJO9W7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCDvwYWgk4U9RnjC9JYCW1HIgLVszToTPVezAnwLJknOMkfZH/f/gEBiJDm1THsxS02KZ5foBUUyWqeJPUz/Gm44ecyNIIUEuouIw5vKkUFgtj8R3Rs0XiF+klkutyE2bgbL2IL1tc5z1xkGG1yBoUIWtGFBmVCLp0yb6ecEoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O/Kg1scx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ljr+zTeh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O/Kg1scx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ljr+zTeh"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD34E7A00CB;
	Wed,  3 Jun 2026 01:40:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Jun 2026 01:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780465206;
	 x=1780551606; bh=zxG8UBm2SAFJT0t/UvTPOEauJkAxh7EAF0/EnOA0Uko=; b=
	O/Kg1scxWGkfXpBg6y4qZhmFuJbt6cTViFdFrSHl9Q7pbnkDHMGZovStskfzhml5
	CP5Ve3Jw92y9vjPmAKTNNrBv/2qXoUh2kZp2ddUa87dfeZakoPbw46hQaBfjQZJc
	3oTMhdeiiS5kX7UGL4NWG9gtJ7Ja6m3jwo4yVihmEqFrhz8x1zU8s4p/IJSG+RE9
	POh1Pdl1Rlr5zkzvKFzu8nsiv3uTwt0UtMCwXG87w1a1KG1Z18XmaqYKMpbwTmCk
	13zDq09/sKwQUgGNcDS4bi59e00QEzt+5psMORr59v5nM+ep66dOaKKrhR1AVzgL
	zPSoY2RksB1rzBMYStr7kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780465206; x=
	1780551606; bh=zxG8UBm2SAFJT0t/UvTPOEauJkAxh7EAF0/EnOA0Uko=; b=L
	jr+zTehZ1OxJTX3Vb0FEGSKH29gigg9QFL/LmO2Wr0rjml6AsavrXr3a1pTW3SJI
	bNdvsq77oUNmq6jkY3veVVlXGCw0gzjw7BvvnyLv2KVaqgnX3zDwXhqDHTJMJtwx
	48BRlMJpN/VJRDGzL3cCrWFel1VJ9PtLCYYi3TuX9obuGpRdmWyrgjpWeU+OfuFr
	146PpUvpPKZUKU2CALXg/dBR1kBV7QnLE48FdIdaahst6IaD8aGk2onAy4X8Nto9
	zvkpKYzdHgSbEW9hwic7LAi3k3oe/9jG4JmtlvsgFqWYLEpH6uiRRai4fCjt14YU
	VzRySNNcXMsIWnmRll1Nw==
X-ME-Sender: <xms:Nr4fakgG5rU13TgTQ1rIWlBQa52OW07wg9ewoHs7n-Ym98wi099Gxg>
    <xme:Nr4fajD8iC8fPr2zMMJlP5-TFM-ukwDLKkiLCFyWfHXw72GV4EIW6Cc-6lnOZG6sQ
    rN2wLJsPLUfttB-Hq0rXYzi4Ww_yQTGV_1h8kfA2Yml8WqX359xSw>
X-ME-Received: <xmr:Nr4fapt2b6BUZPKHMTPdCkVlzVbr_Jaam4OWHJVPGydEIT5TC9b_srsVfOX1yrMKWdkQR88mhauPFwpYjKFh7eLBU_bNcywbe8UDK3-P5n_e>
X-ME-Proxy-Cause: dmFkZTGrzJjPUIO2NsjW9q+5peeonH880scV9FOwhilzaab+1LfhkAPwBnkrMwRIuUbz5U
    +LFYbPLgv1t9z3xYVoPZqQCANWbAn6dNOhLOqMLvkTYH4NGpC2/4VXq116frN/7U2UiL3X
    FNqwOHtvAyZWy5QK3mB9oFxj9mimN69S68JTbcR+0jmsBSt9VsSYceza+JvrHAfa17hbrJ
    qPeLlkQrbj+kzq0dpWBfv2Zb8+smTByit0nlFJgiKOFfTTd/lgjGLqrmXBIahvqi+x4kES
    OPOiOF30oDhR7cCn51miGT5BBhXmaMVzueivIFWud02qrGXtLDHKJdEpKsJTn7BAeXReUX
    euq+yyhG+5pP77lc5oEsXd5GI4VN2jPzf30BZ+d7dzz68y3WHC3kYwIJpEFcJRnmdpRwTk
    S+Kt1kes9DVmtw3G1bsYCP+aIc8r9XFdsD4VNttbVP5HOShDoVdcb2bhYOk3OcGLWCTnJT
    qbssLvAQcfYNOCE318N7fNnHm7pISJ2MGIoh1LbebT48GGpDzA/+MI4wuRRWS5ylJjeEg4
    C4Y+01x+KVvfXsX6DqRDLYvFDYW7Bv6YEx5ZCIEZPPpr84AGGbxWeIUPvlIAzori6ulzG2
    s6LXRXVbBElXOVIUhPP5zvX6N2YLQx2+8X35KmZUIC27yGNRxSvoTYZ5GyZg
X-ME-Proxy: <xmx:Nr4fagYLw1xoB1cXWTVaDKf0oJUonRjgGliPvVbwqQbBFj5t0ejVrA>
    <xmx:Nr4fakWTQQI7WVff8EK4qwTMSoIZD-tpkrRzMY7dczbAcWl7b6x1Yw>
    <xmx:Nr4fas6dbxe3cw_PZ5NFVMe2VK9Cx4lx8AUQIfsiVpOey0C4lxLN8g>
    <xmx:Nr4fanj3yTseyfN98qvDrp_qMXiaOIfIvlwU6UMijbJhPcjrfYp7uQ>
    <xmx:Nr4fan7YY-jyp7CDVkPKytEi84WTxQO_zTZYTXbFGpCaoeWKb9-uEuRd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 01:40:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0552a1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 05:40:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 07:39:47 +0200
Subject: [PATCH v2 4/4] t: let prove fail when parsing invalid TAP output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-pks-t7527-fix-tap-output-v2-4-cf3af5694e20@pks.im>
References: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
In-Reply-To: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

