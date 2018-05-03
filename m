Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53CA200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeECXBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:01:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:38699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeECXBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:01:33 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LqF9o-1ejQ883ume-00dpny; Fri, 04 May 2018 01:01:29 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH v2 5/6] rebase --rebase-merges: a "merge" into a new root is a fast-forward
Date:   Fri,  4 May 2018 01:01:28 +0200
Message-Id: <29d7a9265e30fb9b27b87aba1d6cd5efff93a596.1525388473.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.38.g05ca542f78d
In-Reply-To: <cover.1525388472.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qcyrD4AuRBdNBnBTsJEREfieX7ys0qsKSoQNaNiMe78L0Cxw0dR
 hGKF+54PkaKO9s0HZ/pF4aVY/ha68VRASzFkmSCfaIm4c/gAEqRx0iPCpfqlxBq8xMS78lv
 2kkhhxLJQGvLCOayAWLB9FnIsb7Jh9GTKD/VJYY5hh0gl05J3bTlvOh1iYMh04iRxXRkDdY
 IYPAR7zUCxDE2UTDXuzKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xi4IxXbbUCg=:bxw5XKIOrgqdAeMlhHYn3a
 ukPnOMddweWrDR5tAVR+kWeKv/6YkAECEtqkR0RaKM/0y5dYjaaW3n1i/CCyvc2dJkean7kgn
 pgFLEMZqGuT1/matvXbcjYSmEg1CViifHKomwX8LE6DmJJx2ja1zRR4T+WjNMoAXAEnVGUifQ
 OQUF6ZSLw8MfkzVuqRH1bD2PDohxUrToZCAFBxqC8pGz3sG2cp6fpw3X1LJnJ168ku8RxdHtZ
 EBAMCTEZw44kUidMDopKGPtuAlhazrh0su2kQ/ETzXOYxHw0CMgX4pc90t7qrnKnGH9nR/W7n
 YZ4Kff6L5V23yXM3npUYWKzDVVFYE0YjENpV80ycW5Fn/Zk/QMioToqV3662ACwWW039T5H1x
 A3agWonxji5LipVO8ZSaf2vfPyjRXjvICiL32zqm2D8B0H20pgDrLBRCbRkszeISosidzGZBi
 xSub/YipwvNXptxgHFxNOWlxFcWQI6sw8W8mIb0Xk4Wc0wd4FXxof6BW9rXDlcBxz6c59jbgB
 vkVNfMiUN75stRRgGUfWrGEjtQ/yfacqkUX5bBFJmH1NrZFV0FOEu0ZIgV2dvOcJGWhw7lEyS
 3jfSnFGLbJ8Z4PTojvn78wau4c1LglcOJGvFPux/gvDAsItAAbQsWROlEh6TSWbOPBkWT8/Gy
 zzhBqXk1tBXILyMAJwXqVoTGx0H/eL5Ovom8IWfcWLpbNhNeaqTfscrutiwD9a++YoA5ZnC8R
 OlnmVULHUaYxDN4O3wIhCl/TLd2dB/wX5814oj9IGDpFe/Im49ezG56lckEBVHjDMD3cbsw2b
 Oyljf1l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user provides a todo list containing something like

	reset [new root]
	merge my-branch

let's do the same as if pulling into an orphan branch: simply
fast-forward.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 12 ++++++++++++
 t/t3430-rebase-merges.sh | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index a7832399b1f..65a8c493781 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2870,6 +2870,18 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		goto leave_merge;
 	}
 
+	if (opts->have_squash_onto &&
+	    !oidcmp(&head_commit->object.oid, &opts->squash_onto)) {
+		/*
+		 * When the user tells us to "merge" something into a
+		 * "[new root]", let's simply fast-forward to the merge head.
+		 */
+		rollback_lock_file(&lock);
+		ret = fast_forward_to(&merge_commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+		goto leave_merge;
+	}
+
 	if (commit) {
 		const char *message = get_commit_buffer(commit, NULL);
 		const char *body;
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 35260862fcb..5543f1d5a34 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -275,4 +275,17 @@ test_expect_success 'root commits' '
 	test_cmp_rev HEAD $before
 '
 
+test_expect_success 'a "merge" into a root commit is a fast-forward' '
+	head=$(git rev-parse HEAD) &&
+	cat >script-from-scratch <<-EOF &&
+	reset [new root]
+	merge $head
+	EOF
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i -r HEAD^ &&
+	test_cmp_rev HEAD $head
+'
+
+
 test_done
-- 
2.17.0.windows.1.38.g05ca542f78d


