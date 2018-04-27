Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75B01F424
	for <e@80x24.org>; Fri, 27 Apr 2018 22:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932990AbeD0WcQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 18:32:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:55571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932889AbeD0WcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 18:32:14 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MVsUW-1esS5w3hSS-00X3Qu; Sat, 28 Apr 2018 00:32:09 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 6/6] rebase --rebase-merges: root commits can be cousins, too
Date:   Sat, 28 Apr 2018 00:31:58 +0200
Message-Id: <270b8fdf477b6c876e203ae6a6b461b010d25f76.1524868165.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:M/Wo30usLJBrb19QX03+7PRhKj0GD4fMOBXcTDYMfm5sYUkScKe
 A+0MHch8UGVtBCst7Sb8kO8Swf1AiZdFeyfO6xVXeuANxs5VoSXKJI/D6jlXURVEhAT9RqT
 6mgjULsEb67mBRI0Zlr/tRVHvYPCMwk43pQqZn88fwvDcNPCjz4PYJXNK6CgsDAilxz49yv
 YdmWtzEkvSm/yTgb/gLoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1l2jQ7KhYRU=:99FYhEhrU/dhyjeYsczExN
 ogsfnMiG8DenfjIKSDEFYHFn0ydkbNUmJq5xNdmEssIaYPaCaa+OMJzjAmz7+2htvKxCTMmcv
 1/3mIfsH/jq1f4bGQJXd7UjlAx4vS0uI8Mt3va0cZGJC1PPHttBEWCSw1ENn0M/OGvsFNgbPx
 zobdEnLLDLseM730yn0sI4WJPzTcn9BvAfG9uRNU8fjvBWFuUi+MVu4qmUzALM9E/ExNWE3Av
 sIxRlm4uJKEZJ14lPVwmG63gLXrXx/LpaQnYnGaC3UY8Zp6v4gd8JYeT2tufPOs/9aSEhu+35
 ZeWScRgsBifKyOVCUbQ8FaPzQMh+V4yzFeUd7gpfy2VC9Y5uPJFqUk+QObuqlGKJUPP6gGKls
 4QKM/jjepZi/pMBg4iLLKjy3l3Yzyw8SbVkkhFzfHIb0SfUgPGbXFpDKCgOCcTTY39wfn3LFy
 1iCRUCmq9Xwk+YFOCyjVgJ+b9kNXnCO2w65eeTrFebH3R4sW0zIzhOCkzk6lpwxz+6vc3EppS
 UHGta+q8Ci7VioCwsC1cLY+fjz5wwqVhDg1pm4PvQ5bJgmV0mjrZP5XS6Ez9ML5/P9mUFXVVR
 MojpP4nXig9WgqCjr+Yr4VgArP0okDs6ljtKoS+wri8nbqp5CAyV3Bi3bfHlM/1EC16GcGscg
 /gl/I45JCaAdISZGzlvMEn7QWWOv13YJHHfELtABxXtPN27vVfePnuMN2k5DBJ9ZIJwKgNlzD
 gXpGWabAbcOKw9pIRXshn1dOmh2/Hm8FqzHquwnwKvFjSf/ah3FaM3WBpHGo1M6HdkZv67ItU
 VWvzaNI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by Wink Saville: when rebasing with no-rebase-cousins, we
will want to refrain from rebasing all of them, even when they are
root commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              |  3 ++-
 t/t3430-rebase-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index ad5ff2709a6..2bcd13e1fc6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3883,7 +3883,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 
 		if (!commit)
-			fprintf(out, "%s onto\n", cmd_reset);
+			fprintf(out, "%s %s\n", cmd_reset,
+				rebase_cousins ? "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 5543f1d5a34..ce6de6f491e 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -287,5 +287,30 @@ test_expect_success 'a "merge" into a root commit is a fast-forward' '
 	test_cmp_rev HEAD $head
 '
 
+test_expect_success 'A root commit can be a cousin, treat it that way' '
+	git checkout --orphan khnum &&
+	test_commit yama &&
+	git checkout -b asherah master &&
+	test_commit shamkat &&
+	git merge --allow-unrelated-histories khnum &&
+	test_tick &&
+	git rebase -f -r HEAD^ &&
+	! test_cmp_rev HEAD^2 khnum &&
+	test_cmp_graph HEAD^.. <<-\EOF &&
+	*   Merge branch '\''khnum'\'' into asherah
+	|\
+	| * yama
+	o shamkat
+	EOF
+	test_tick &&
+	git rebase --rebase-merges=rebase-cousins HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge branch '\''khnum'\'' into asherah
+	|\
+	| * yama
+	|/
+	o shamkat
+	EOF
+'
 
 test_done
-- 
2.17.0.windows.1.33.gfcbb1fa0445
