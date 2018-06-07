Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B82D1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeFGFIx (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:08:53 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37699 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbeFGFIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:08:52 -0400
Received: by mail-oi0-f68.google.com with SMTP id l22-v6so7444081oib.4
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7e9EHjVnhRgKbFxjJW35tl/wYSpHDYYt8MoFtBUxG3U=;
        b=ES69klM/Rwca4Ns5ehRLDbGH1A7+oKtjgW7g2mikvFDpdI04Lq5jl0S0gQQkJzZGBJ
         agZfHTlPZHvqjk2Edn8P2hZnh3etAvuyGHZEU6cJ8NRtViXzSFf9/7pz+DVFNYsuX2j+
         oqWlIG7zOckg049jcBweQ6SdBT1ARly0/3nLpIIunHS5iwdh53NeEQuvgAYmSgQObVZM
         y/LfbA2Ddp2w87T3oLAiXaDq96spHmd25rvy29BTIxqQ6ocQdqZUePJVEpYS98U5vmIB
         52Bk3pSGioS1zesLLhO2c74Ed3lMJyahfamqtgKn2EZSmqRPzs4nF6W9V1GNgyEaEMQw
         lN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7e9EHjVnhRgKbFxjJW35tl/wYSpHDYYt8MoFtBUxG3U=;
        b=LxsxiTAqwHSgxnVKRLhP0OF37q2jc7erlyny5Es53xIhnyIAMJBBaFmQv3ZWnJpemG
         r2LOgHHUuQjEvYzEnpKfFLXf/s3XLHdGSjsdJiReCxE0uJTgOGIQXfKDiBaMWZruRjyz
         xh/F9fcpQ8eNAjIEiNwGkSMFCgQb0zn8lECO5ti48lgzfTDEVqj+rHcOB0jv6leYVFN7
         ZTZESPzSsuqIJMnSZ+CwZMWWAuTfwN0bfJOJeKHCsswIUuKZpY568m2ffinL6VCG32JU
         ZjZcoOsvGrwih7TxJcFzUjWIv7ADWCTPaMPfCuZ6SfOZ+7WZGBEsQze/ibunk0rdMKDv
         6yLw==
X-Gm-Message-State: APt69E26k638kb63pV3l/UnFSDmqH553aT6NW2goUg4SQ0vBlm77rb7H
        K0ztV62kbfGPND6CT8HlhvBANg==
X-Google-Smtp-Source: ADUXVKIfWo2vyDW/CArUkYafH6xO+wkgZIaggJPhbEuh0z0/q+So6In+AJX4LLfTGM70P8MY1jtl5Q==
X-Received: by 2002:aca:6b89:: with SMTP id g131-v6mr155003oic.118.1528348131956;
        Wed, 06 Jun 2018 22:08:51 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f97-v6sm7200539otb.9.2018.06.06.22.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:08:51 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t3418: add testcase showing problems with rebase -i and strategy options
Date:   Wed,  6 Jun 2018 22:08:44 -0700
Message-Id: <20180607050845.19779-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are not passing the same args to merge strategies when we are doing an
--interactive rebase as we do with a --merge rebase.  The merge strategy
should not need to be aware of which type of rebase is in effect.  Add a
testcase which checks for the appropriate args.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3418-rebase-continue.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 03bf1b8a3b..872022106f 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -74,6 +74,38 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
+test_expect_failure 'rebase -i --continue handles merge strategy and options' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
+	test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
+	mkdir test-bin &&
+	cat >test-bin/git-merge-funny <<-EOF &&
+	#!$SHELL_PATH
+	echo "\$@" >>funny.args
+	case "\$1" in --opt) ;; *) exit 2 ;; esac
+	case "\$2" in --foo) ;; *) exit 2 ;; esac
+	case "\$4" in --) ;; *) exit 2 ;; esac
+	shift 2 &&
+	>funny.was.run &&
+	exec git merge-recursive "\$@"
+	EOF
+	chmod +x test-bin/git-merge-funny &&
+	(
+		PATH=./test-bin:$PATH
+		test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
+	) &&
+	test -f funny.was.run &&
+	rm funny.was.run &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	(
+		PATH=./test-bin:$PATH
+		git rebase --continue
+	) &&
+	test -f funny.was.run
+'
+
 test_expect_success 'rebase passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.18.0.rc0.46.g9cee8fce43

