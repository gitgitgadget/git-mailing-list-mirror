Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E29ECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiIAAaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIAAaG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799E832D88
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so443623wma.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=26YUjmv3YfoBiahlEeoZe8AJZ67CvGYEVs/aobgiE7s=;
        b=ADFZT7fUabyWKAnh0iK3d8EPxLDoGFpbIRAj92JFwKQWGZOo5yF3O7MnDv2zSrp8gL
         e1RH/aFmhpYd5f2BgWDKc+b0c4j0BDUtvfY5nHRMBPEtvP5mqtQIK7Qpn+TW06zLZAp6
         3YzSBfbipESRA6L8wK4uGzXL4nu/LMUMcGDWG5ZR4XVNRs85xP8qIe0fykaSTHVXa8dq
         DWXETaOvIHMD+W80p5ChjiCBCKyqU0ZFiGpCV4xpSb3fVwGUlmWs6S7B8H37ee/Z0BQP
         p2QzWVW7YPsAqd+QZr8b9QwCChK0W0gEfwtnEgyMl8Yebqb8jTedDu6VYFIJgFBXPkMI
         u8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=26YUjmv3YfoBiahlEeoZe8AJZ67CvGYEVs/aobgiE7s=;
        b=SoZhqFWLxu0VLvij0QJ/c6XtxKdhpv8FgLGriEihufNyI3JUY/D1vPh/bKxPqKVzuJ
         TtxHEov2cfVnCTozpDyKeF1aFNArZu8748YgmiskOcTUT57Amj7hd+aX1llWaLZjuojt
         SEj1YgBREEjAUI8b6L8BRMNdnhptzKAo056QW3EJpyEyjcIgvKdpPjj0+Km4WNCcMhJR
         5IgrAiELksVV4VVD+NUvblE3GqswxtMIesLjAqFXxWFUMmB7a87t1t5WX+93qKJtE7Oe
         qYBfGyaPwgOM29vj3EN64tg58NF7Kq1EvhINF5Bl2TsXUcTjWDJw9fT6s+iELkI6ns4A
         qQcg==
X-Gm-Message-State: ACgBeo2onzsFYR8fMLAbt0Nut2EL168S15IfR/6q2BVJETKUfDnjf/LR
        3DKuOYhXtsdnadQuaXBePbCRiZKB8Qw=
X-Google-Smtp-Source: AA6agR71l8eMJ2mHrk/+P77Tb7IgIZ6zoNDaEatTdI/UM/5Okq0SeiYHN1Bem78OQO5L+AUEP9JK5w==
X-Received: by 2002:a7b:c2a9:0:b0:3a6:2400:722c with SMTP id c9-20020a7bc2a9000000b003a62400722cmr3402082wmk.108.1661992203882;
        Wed, 31 Aug 2022 17:30:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b003a5b6086381sm4243050wmq.48.2022.08.31.17.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:03 -0700 (PDT)
Message-Id: <cbd94b343cb0e180d9333f0ecd285d7c7deb7904.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:42 +0000
Subject: [PATCH 04/18] chainlint.pl: add parser to validate tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Continue fleshing out chainlint.pl by adding TestParser, a parser with
special knowledge about how Git tests should be written; for instance,
it knows that commands within a test body should be chained together
with `&&`. An upcoming parser which plucks test definitions from test
scripts will invoke TestParser for each test body it encounters.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index cdf136896be..ad257106e56 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -441,6 +441,52 @@ DONE:
 	return @tokens;
 }
 
+# TestParser is a subclass of ShellParser which, beyond parsing shell script
+# code, is also imbued with semantic knowledge of test construction, and checks
+# tests for common problems (such as broken &&-chains) which might hide bugs in
+# the tests themselves or in behaviors being exercised by the tests. As such,
+# TestParser is only called upon to parse test bodies, not the top-level
+# scripts in which the tests are defined.
+package TestParser;
+
+use base 'ShellParser';
+
+sub find_non_nl {
+	my $tokens = shift @_;
+	my $n = shift @_;
+	$n = $#$tokens if !defined($n);
+	$n-- while $n >= 0 && $$tokens[$n] eq "\n";
+	return $n;
+}
+
+sub ends_with {
+	my ($tokens, $needles) = @_;
+	my $n = find_non_nl($tokens);
+	for my $needle (reverse(@$needles)) {
+		return undef if $n < 0;
+		$n = find_non_nl($tokens, $n), next if $needle eq "\n";
+		return undef if $$tokens[$n] !~ $needle;
+		$n--;
+	}
+	return 1;
+}
+
+sub accumulate {
+	my ($self, $tokens, $cmd) = @_;
+	goto DONE unless @$tokens;
+	goto DONE if @$cmd == 1 && $$cmd[0] eq "\n";
+
+	# did previous command end with "&&", "||", "|"?
+	goto DONE if ends_with($tokens, [qr/^(?:&&|\|\||\|)$/]);
+
+	# flag missing "&&" at end of previous command
+	my $n = find_non_nl($tokens);
+	splice(@$tokens, $n + 1, 0, '?!AMP?!') unless $n < 0;
+
+DONE:
+	$self->SUPER::accumulate($tokens, $cmd);
+}
+
 package ScriptParser;
 
 sub new {
-- 
gitgitgadget

