Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD25200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeECXB0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:01:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:36977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbeECXBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:01:24 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MWC9x-1epzni2JgH-00XNK3; Fri, 04 May 2018 01:01:19 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH v2 3/6] rebase -i --root: let the sequencer handle even the initial part
Date:   Fri,  4 May 2018 01:01:18 +0200
Message-Id: <2dfe8315993abb882c8b63ff54076218d4a911d3.1525388472.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.38.g05ca542f78d
In-Reply-To: <cover.1525388472.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZGGIQZkkfMDrSqA1hx2N5Qkh36o0EzC1hhGggBMip/wBjCF1seO
 JrPtZgxA/E1NwSSp7Q9DkS2cm9XgmAmF5E8rGK/EZZsmx0WgJ/mzSz/S2PqxpOh7gk4i2i4
 pm8ESdea/+o1CGAHu4UyXa8jE9rrQ8GAXTqApzY1NHR9PJyOK0fhEWwTCb0vaiqgwAerM+R
 0w/RrzvhSk+cAh7g3COLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7mHze1QuoHU=:50Ol0tc3sEanJDe1yvPvEp
 16lzpJ6ft6PT/zWSo3XcmVGcceywM5mKTm7wrvwgzPopD20nOqqDVTBzU7UQjsu5l+29XbNrv
 oOtA7tn5tZ0TPLsQI28Mby3SpTXBiKuO0sRGRChb0laW8jE20ugTwgWp/3OxMa3ZNCHKBWlNs
 mnh3aaLd9dqrntjg62kGLtQSkHyasr3plAcnjoDXUqw/KsqWysUKm/teK4j6TQvNS5ZDyLKGT
 6WQUs5XxzVz1OoQMLsyzXsWn3D20H1chsM6OuEw244WsTI9p2VJcqZ6HLvCftoy3nk8qgD9oE
 fWqLLjuiwLK6qqXEywQNcbz3vfpvJQMI0FHAhQ4z/QJMAVkaNDGgdSw077MQwUXwQIjOYmQow
 wc+y/jixyZ6bTEM5xDk2ld7yB9vMxuRcyjYTeZUz0Qjn6BAXW3dfaeXzInT0OgqwLJidK7mJk
 X7nS9NOhlaIbULFcf0yIeC9jer9sYQNTG0ds53xzJD13XJKUXifwcK96eBgTEFVbxzlZDs95V
 Q6xnMlE5bpJDeDgJu9MmnMz00BLW91rxBY2gMgOMS0IQfgfM9yIGhpTyv55Tiv8nniPYLz+tw
 52yqAQVZxvgmmMOfCPIhXnkyGNY09uEZzL/UpTQp95Nep+DoI82ILLAOVFi8jF5dLI6Wh1Vgk
 /Yz83sOTfKLXH9q4/gjGNpdiysXLCGVMeybt1K6snA6K80Z6QPXcv620cIrVAMH0GJOiy5Mz0
 NXu4T96sarHHAAsfFHwM8J/c6iAAXvE6feZXEMTCnxymUEyTk9VC46jHxJxoU2+ruOmYWMd72
 mOiEhOk5ASoIK0zuqUAA8s/HUt2YqQ603RxdUDSvIdEBCD6ltLPZBU2wNDOg92NzsYJ1Flveg
 ufheQo4vlVs1RlABJRjKZ4MCbboEOcajBMADIhK/XKq3pRHkfOT0n3DBb02i9zbp4NARrKT08
 atqf0UOmygZdAgv37TxJsh6fIqnwqONcgzLJI79BHouVZu6TEVhw3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this developer's earlier attempt to accelerate interactive rebases by
converting large parts from Unix shell script into portable, performant
C, the --root handling was specifically excluded (to simplify the task a
little bit; it still took over a year to get that reduced set of patches
into Git proper).

This patch ties up that loose end: now only --preserve-merges uses the
slow Unix shell script implementation to perform the interactive rebase.

As the rebase--helper reports progress to stderr (unlike the scripted
interactive rebase, which reports it to stdout, of all places), we have
to adjust a couple of tests that did not expect that for `git rebase -i
--root`.

This patch fixes -- at long last! -- the really old bug reported in
6a6bc5bdc4d (add tests for rebasing root, 2013-06-06) that rebasing with
--root *always* rewrote the root commit, even if there were no changes.

The bug still persists in --preserve-merges mode, of course, but that
mode will be deprecated as soon as the new --rebase-merges mode
stabilizes, anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh        |  4 +++-
 t/t3404-rebase-interactive.sh     | 19 +++++++++++++------
 t/t3421-rebase-topology-linear.sh |  6 +++---
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cbf44f86482..2f4941d0fc9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -894,6 +894,8 @@ init_revisions_and_shortrevisions () {
 	else
 		revisions=$onto...$orig_head
 		shortrevisions=$shorthead
+		test -z "$squash_onto" ||
+		echo "$squash_onto" >"$state_dir"/squash-onto
 	fi
 }
 
@@ -948,7 +950,7 @@ EOF
 	die "Could not skip unnecessary pick commands"
 
 	checkout_onto
-	if test -z "$rebase_root" && test ! -d "$rewritten"
+	if test ! -d "$rewritten"
 	then
 		require_clean_work_tree "rebase"
 		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 59c766540e5..c65826ddace 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1204,10 +1204,6 @@ test_expect_success 'drop' '
 	test A = $(git cat-file commit HEAD^^ | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Successfully rebased and updated refs/heads/missing-commit.
-EOF
-
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 	test_config rebase.missingCommitsCheck ignore &&
 	rebase_setup_and_clean missing-commit &&
@@ -1215,7 +1211,9 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 	FAKE_LINES="1 2 3 4" \
 		git rebase -i --root 2>actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
-	test_i18ncmp expect actual
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
 '
 
 cat >expect <<EOF
@@ -1227,15 +1225,24 @@ To avoid this message, use "drop" to explicitly remove a commit.
 Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 
+Rebasing (1/4)
+Rebasing (2/4)
+Rebasing (3/4)
+Rebasing (4/4)
 Successfully rebased and updated refs/heads/missing-commit.
 EOF
 
+cr_to_nl () {
+	tr '\015' '\012'
+}
+
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
 	FAKE_LINES="1 2 3 4" \
-		git rebase -i --root 2>actual &&
+		git rebase -i --root 2>actual.2 &&
+	cr_to_nl <actual.2 >actual &&
 	test_i18ncmp expect actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
 '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index e7438ad06ac..99b2aac9219 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -328,9 +328,9 @@ test_run_rebase () {
 		test_cmp_rev c HEAD
 	"
 }
-test_run_rebase failure ''
-test_run_rebase failure -m
-test_run_rebase failure -i
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
 test_run_rebase failure -p
 
 test_run_rebase () {
-- 
2.17.0.windows.1.38.g05ca542f78d


