Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFDECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiIAAap (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiIAAaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25193F33C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so17540049wrm.8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=h5RsgfjcFiVXikZi8QggWlCtjp9Xr85P6jHdbE2KQtY=;
        b=po7ShVkiU2PeAYC2wBpKf1ayaAp0/x2qjNwUGvMxXHozubBj0IYwhGa8BvAmpY09Bw
         rXByU3ArIXzuHZzF1QI3/W11NIvC3Jd7seOvzOVj0v8eb5iV8tDqbq54KBDRXlOgeVFb
         C2sykul4tcQSbzKJzrQcTSWkeKWR52bUbaw5Eb3EnBBBqjfVpnOowqG2EeB5ldnST3aJ
         EA3YipfgZsiHay0WSYgsfv7ipMTHZXRCINrnGkQ2oLbQ4FnzY+W1r2rFwEFMXYj/V6K7
         OK/A5M5esLLWBklPp+iUXNVOWF8Upg5Cda2gfUVw/Gz4N3V9tofqnSji9J2oQMNLiT7+
         0sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=h5RsgfjcFiVXikZi8QggWlCtjp9Xr85P6jHdbE2KQtY=;
        b=gkYNQUVai5mnl3PtgJCsO4F238EdqGGGScz81pPP8pbIakOGpoO1kvqwxMbGMDKAID
         LSN3tI3prfn/PMZ0ZI8ie6azIFNwuwzUhUEAbw5haIMMsVKci3hA1Sm1GtjjcfVu+Hvp
         N09cxAegdlaQhypKsZF++E22gETpn0T7WU7v5qchOPJuU0y6S8AJCTIepeMcJaVku4Nm
         L+bOGteET5cZr7AI0k5KB/uYxlgMiYbSU0WRpKBK00hZHYBTFX+mVU34za125ZFJg6J/
         rMIAd2LwWHBtuSSytigmpDlxh4ez8XepEdYTRZv1uYxVxDN5b47l2Hpjtk5d0Gy/l4VD
         lclg==
X-Gm-Message-State: ACgBeo2My5hsizJm8BaOznkL41Egft15+Y3BaF8VzHPErbzDZV4rMBfC
        MQl2H6sgyQDGBGy2kSqnYjgIlWVpGFY=
X-Google-Smtp-Source: AA6agR4FPTUAA01NgmiP+JgVXJL+bdzJew8Hf/gs9fyeDsRrcCjj2hUk9STX274F7XlTEDf1HvI1sA==
X-Received: by 2002:a5d:64a4:0:b0:226:df78:5db7 with SMTP id m4-20020a5d64a4000000b00226df785db7mr8160654wrp.591.1661992214092;
        Wed, 31 Aug 2022 17:30:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b0021e4829d359sm12756109wrd.39.2022.08.31.17.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:13 -0700 (PDT)
Message-Id: <7179972013825de50bddb6a68a17f0b83d5f35a8.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:51 +0000
Subject: [PATCH 13/18] chainlint.pl: allow `|| echo` to signal failure
 upstream of a pipe
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

The use of `|| return` (or `|| exit`) to signal failure within a loop
isn't effective when the loop is upstream of a pipe since the pipe
swallows all upstream exit codes and returns only the exit code of the
final command in the pipeline.

To work around this limitation, tests may adopt an alternative strategy
of signaling failure by emitting text which would never be emitted in
the non-failing case. For instance:

    while condition
    do
        command1 &&
        command2 ||
        echo "impossible text"
    done |
    sort >actual &&

Such usage indicates deliberate thought about failure cases by the test
author, thus flagging them as missing `|| return` (or `|| exit`) is not
helpful. Therefore, take this case into consideration when checking for
explicit loop termination.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                        |  3 +++
 t/chainlint/loop-upstream-pipe.expect | 10 ++++++++++
 t/chainlint/loop-upstream-pipe.test   | 11 +++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 t/chainlint/loop-upstream-pipe.expect
 create mode 100644 t/chainlint/loop-upstream-pipe.test

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 674b3ddf696..386999ce65d 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -487,6 +487,9 @@ sub parse_loop_body {
 	my @tokens = $self->SUPER::parse_loop_body(@_);
 	# did loop signal failure via "|| return" or "|| exit"?
 	return @tokens if !@tokens || grep(/^(?:return|exit|\$\?)$/, @tokens);
+	# did loop upstream of a pipe signal failure via "|| echo 'impossible
+	# text'" as the final command in the loop body?
+	return @tokens if ends_with(\@tokens, [qr/^\|\|$/, "\n", qr/^echo$/, qr/^.+$/]);
 	# flag missing "return/exit" handling explicit failure in loop body
 	my $n = find_non_nl(\@tokens);
 	splice(@tokens, $n + 1, 0, '?!LOOP?!');
diff --git a/t/chainlint/loop-upstream-pipe.expect b/t/chainlint/loop-upstream-pipe.expect
new file mode 100644
index 00000000000..0b82ecc4b96
--- /dev/null
+++ b/t/chainlint/loop-upstream-pipe.expect
@@ -0,0 +1,10 @@
+(
+	git rev-list --objects --no-object-names base..loose |
+	while read oid
+	do
+		path="$objdir/$(test_oid_to_path "$oid")" &&
+		printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" ||
+		echo "object list generation failed for $oid"
+	done |
+	sort -k1
+) >expect &&
diff --git a/t/chainlint/loop-upstream-pipe.test b/t/chainlint/loop-upstream-pipe.test
new file mode 100644
index 00000000000..efb77da897c
--- /dev/null
+++ b/t/chainlint/loop-upstream-pipe.test
@@ -0,0 +1,11 @@
+(
+	git rev-list --objects --no-object-names base..loose |
+	while read oid
+	do
+# LINT: "|| echo" signals failure in loop upstream of a pipe
+		path="$objdir/$(test_oid_to_path "$oid")" &&
+		printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" ||
+		echo "object list generation failed for $oid"
+	done |
+	sort -k1
+) >expect &&
-- 
gitgitgadget

