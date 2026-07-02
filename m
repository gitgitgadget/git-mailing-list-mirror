Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83D48C3FB
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993685; cv=none; b=oc/9a1GikHNr+Wwc3cKlVdS7UX9B6+aa+rb752YZJU3iWTs6d8koxiyb+QIukdwJ9nlByqty3PSr9FIrV+FRyvweA6ixXS8k6FIhc5nhrltP1N6EIdAsosHJUpgsPf2cL5jdo+MLKEr8a0qWGbV4I97OeZjE5nphfcIbGW+JYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993685; c=relaxed/simple;
	bh=Jl3GJIY7/9cDbfjCrlNi2BHzibY3HLXyycIm+bl+j9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZ9mOgFaeLDMtgcxvo/Elv1kEZmFctVwcWEr/4g84ezQjWmH90SmavPVWpuSH0SmNYA7OFzczF5nlhw6hMBtHzcPlxvHChFg0ByKW+ngUmGunSx0EUlFiMgR0iC2rb0D7u/MEqjdp434NFsEtwcBXffx1doEEXIEsMP8WqU9CFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gt8VlRCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXVw0Dou; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gt8VlRCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXVw0Dou"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 254C21D000B6;
	Thu,  2 Jul 2026 08:01:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 08:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993683;
	 x=1783080083; bh=Bi22qJ+c5ZltwLA6XIbB/YqHsWgC1UX0IgyRBEk6Oz4=; b=
	Gt8VlRCPe9fpqbQcwJVV7ABdlSWzjwLzPHR8Yf/Vbk726lHbI2Vvu45ui/IjDuE4
	EvkPCuVjzf9/U7jDaUx8PcNciGQo/No8dOPmoCZWdk14dhkaR5R5/RGdQEDBxtA4
	kJUvCiT9osQ4ocbRSJHSTe8sRJ5PLupNeGPnqG6kqKI2nFapQivS77C74LlMw7c4
	IMEE6oUwFmv+nkkt6Ai3uZv1Vb3lwVhBnSjpDOcZJkAhUPQd2gA76aww59WYYcpi
	18Guv4cn/glM+jlFbYs9/ngD3pVLEs8LHwqPnYeLsfgWPYh7xvsWvleiZdU80A2O
	pjuNntNNLwv+9FN4u/qGqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993683; x=
	1783080083; bh=Bi22qJ+c5ZltwLA6XIbB/YqHsWgC1UX0IgyRBEk6Oz4=; b=l
	XVw0DouZ8E6LirgcenD7gaqVwVsNTWyR3Pu7cJ0fDCxEJoJOWUUuTmU2qehFWz1c
	Sj51MqNLUGZAlLuyC/U2RM1pH6cfDQbLjg1HdRhXQizwQw/JpPxvUKHHnPgUmC4e
	hZ8oRLEsclySdbYnsOmKdhAIpQLRFKETmcWi27zkUwJhqp7POqeWcWrb0v1zoMjr
	3vNPnDWQbCfII2hcficw4txX9RWfq9jEPzbZrmfeSYkC3d3r3tnSxiTPEBeOMfKe
	Y6i4Brt59vJ35ZrN6DCVbCvrBavkdktt/0etsE+ocu5JwRVrsfekZO1y35QM0i2m
	RebWOeHO8t/+sMCAGzCqg==
X-ME-Sender: <xms:ElNGan9xpjPj2Yl9Ni8YrnLMT-2RTC491tHxI9iIs24TrO0ZXat50Q>
    <xme:ElNGarJkvPw8T_rBAqJQoHWjxqc7OC48eTJPUvTU81RaX_oekU-MjA7wlewRFav4K
    k_guGXRTh-tYQ59Av9P9j4m03VHlmJmBPWFeoCJ6GcXgpi139IgrA>
X-ME-Received: <xmr:ElNGaibUREOS9cMf92ZipcC0IBLqjO8LQIMlbNoyX-K-C-Ig3CzsA7UDq-ZQaRXUkr6OyTsfIJIG2oadwsgzsB66rnXs2eSqF-Ix_Qk0DSPm3A>
X-ME-Proxy-Cause: dmFkZTFq7YBXd34E3oKLbU9QoJDzZu1SA0HD/2618r+TdBaFUyYiI3/D0H3cg7pIWe5P7j
    6adEx1nwQuyPEDK8gBVp7Dj6BJB+4VhrrDabi4MCd2l8Dg9Rp9Zn0yBk/sUjhTrI9w4rWW
    AIaFBJZfG7w1qUhCNib+yYWChSi23zgbTECZJVOSqaUA+hdbQBGxoKKCJbTsHmyL6+3q4X
    tkFNRTpe6u5Zs0dvX1k7kUQ7rsAiUnmwun/4Ja9PNPI8Z9BBvPTORyNVgFKE9iqLgtDQpX
    W8eH51QB4nClwUU5Vc5BbRscIWdQEJlrAkhl0RMI4INjjJIdZFhbUkPupFwoJ6mciZyPWn
    Fs03eqQZp10r9yrABCZXyYW5YJbCSyOGG7EgTiLs2cjBT4AOsXy1stv823OMdVmUBvs4pC
    BY667xs7t8fbjxGjmtjS6gMbjg6wKjmQJ95jEQdt5r18uGxxK/6swAM8EVkSl+TU8wIrBZ
    SwIBmgQEBldQakkYht+jD8kqTcdp5YDztzsabq0Yeu0MGi2N4O/l3vDzh9GRTDH3rASmKE
    FC48uEChgG9qHWlfdHZGNZUGBMnh6upkUaMt25o37hZhAEvnW4g4u+iw8ov046p2T8D3p8
    jz5GO5XZVBt5Mdam9wqcY73BghHAuEekRS6K1X2qHnfR2aseykFpBN3kIhtQ
X-ME-Proxy: <xmx:ElNGatL7uupYfBe_WVasqZlyXJXQZGf_8TNEWkZbocBgBnA-KfM-Hw>
    <xmx:ElNGagBg1ZsgJgkI5mjXqSDRRIpbiIVKkRI814Ql4FKJXH6b5ZlbmQ>
    <xmx:ElNGaiphq5jk4zlOUrTysnjtk9rIRS15gbf8uMg3KWt7wN77YwSDCg>
    <xmx:ElNGargkz2YVLUkyaMZhq_UQVlJvxh3BwGRn3GNNauFB1XycvyATiQ>
    <xmx:E1NGatudSDuAw2jRzXCj2fec5FKoUjFUBiAlxA6u5mjd_LWPyEfj5dfH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a427ac6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:01:00 +0200
Subject: [PATCH 7/9] t: use `test_bool_env` to parse GIT_TEST_LONG
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-7-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

It's currently hard to explicitly disable GIT_TEST_LONG by setting it to
`false`. Fix this by using `test_bool_env` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh     | 2 +-
 t/test-lib.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b939110a6e..01a0bc6b75 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -321,7 +321,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 # enable the long tests for pushes to the integration branches as well.
 case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
 pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
-	export GIT_TEST_LONG=YesPlease
+	export GIT_TEST_LONG=true
 	;;
 esac
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ceefb99bff..623fcfb747 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -210,7 +210,7 @@ parse_option () {
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
+		GIT_TEST_LONG=true; export GIT_TEST_LONG ;;
 	-r)
 		mark_option_requires_arg "$opt" run_list
 		;;
@@ -1849,7 +1849,7 @@ test_lazy_prereq AUTOIDENT '
 '
 
 test_lazy_prereq EXPENSIVE '
-	test -n "$GIT_TEST_LONG"
+	test_bool_env GIT_TEST_LONG false
 '
 
 test_lazy_prereq EXPENSIVE_ON_WINDOWS '

-- 
2.55.0.795.g602f6c329a.dirty

