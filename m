Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277D420899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbdHBTl3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36960 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbdHBTl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id t138so141934wmt.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wn41vkdGfILK4mfdA8GdTWBd09R7wsSUZPuUJDu6Y+w=;
        b=MsUO4gFaWcr9MOZaPmwyUdhoYZQGSzfxmH2uMtB716a+bN3XCKYkRhCbn8He1IrMxo
         1RDOlF88yP3LW04pjes4ZON3B1+TNSxu1fEnfNd+yZ3wsag//dGdefEeGfBSJyoTfeD6
         aaih1PiN/DacRCMy6qlgnsBF02zzrKcEqjIC0jjSV2sFD/AGVwp/TazrtJwt+RMR3RUp
         S4j3UwbX44LcN3joDgV8rTPkPqr3KL2/qSw7N/m1aKlN91APsUz5Tyiy5ppO2K5nrH1q
         jMGtuIkEhqJ/O99O0ZqBGRR76bTgxOI1TrP5XvFfsP1voTgB1J6pFSaEpKoCS3kWGYt4
         dRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wn41vkdGfILK4mfdA8GdTWBd09R7wsSUZPuUJDu6Y+w=;
        b=pK0AfF8YUIQeTNswEUgrETSwvgSjQQIbGdsW22oWx54HwLN9eYUQtcFpgAQYUmfd0I
         tDfy3hClI/DuuYjRWDyvSR4K9j9+8j6v3Kg2zzBPzaKuUuDYcHM37won/aZQSNiIPzSH
         6kuWCk7MjLsU3uig1K3jkAD5Rpq+K6FDGFdkemeRuEYSdcMdS6c0D0kcgquSklmltk2g
         SlL7mHOIUQiv5J5G8eav5hULq4KMPbglNhlzbr4SVRtKZNrAJR1Kiq17eZIsV3xXIXr/
         JehHUSVR08ua+zXsa8r7Gtz+dqwfRVqKYiMHjcyR3Ei0BihM1V5R3mcH+PbFTR0nbZUX
         IlOg==
X-Gm-Message-State: AIVw110ugCPb4pIomuL+6wivL+D2eB/Vfl//nMSeXcnMX2mxWjwfKo41
        LXJuQznMOZfH7FPB
X-Received: by 10.28.66.147 with SMTP id k19mr4737525wmi.31.1501702887112;
        Wed, 02 Aug 2017 12:41:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 7/7] git.c: ignore pager.* when launching builtin as dashed external
Date:   Wed,  2 Aug 2017 21:40:55 +0200
Message-Id: <68240873fe154bbeda0bf3c4d324f46b6bb800a3.1501701129.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running, e.g., `git -c alias.bar=foo bar`, we expand the alias and
execute `git-foo` as a dashed external. This is true even if git foo is
a builtin. That is on purpose, and is motivated in a comment which was
added in commit 441981bc ("git: simplify environment save/restore
logic", 2016-01-26).

Shortly before we launch a dashed external, and unless we have already
found out whether we should use a pager, we check `pager.foo`. This was
added in commit 92058e4d ("support pager.* for external commands",
2011-08-18). If the dashed external is a builtin, this does not match
that commit's intention and is arguably wrong, since it would be cleaner
if we let the "dashed external builtin" handle `pager.foo`.

This has not mattered in practice, but a recent patch taught `git-tag`
to ignore `pager.tag` under certain circumstances. But, when started
using an alias, it doesn't get the chance to do so, as outlined above.
That recent patch added a test to document this breakage.

Do not check `pager.foo` before launching a builtin as a dashed
external, i.e., if we recognize the name of the external as a builtin.
Change the test to use `test_expect_success`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7006-pager.sh | 2 +-
 git.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index afa03f3b6..9128ec5ac 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -201,7 +201,7 @@ test_expect_success TTY 'git tag -a respects --paginate' '
 	test -e paginated.out
 '
 
-test_expect_failure TTY 'git tag as alias ignores pager.tag with -a' '
+test_expect_success TTY 'git tag as alias ignores pager.tag with -a' '
 	test_when_finished "git tag -d newtag" &&
 	rm -f paginated.out &&
 	test_terminal git -c pager.tag -c alias.t=tag t -am message newtag &&
diff --git a/git.c b/git.c
index 82ac2a092..6b6d9f68e 100644
--- a/git.c
+++ b/git.c
@@ -559,7 +559,7 @@ static void execv_dashed_external(const char **argv)
 	if (get_super_prefix())
 		die("%s doesn't support --super-prefix", argv[0]);
 
-	if (use_pager == -1)
+	if (use_pager == -1 && !is_builtin(argv[0]))
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
 
-- 
2.14.0.rc1.12.ge2d9c4613

