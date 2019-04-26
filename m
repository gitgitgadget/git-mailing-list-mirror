Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7051C1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 10:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZKdh (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 06:33:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52337 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZKdg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 06:33:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id j13so3214046wmh.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=SSzKCqriSpyIMtGicIsw7CGHmTKpA2O6/6zvz/3AVbA=;
        b=eOIGK+ImjMylm/MChURzo+KncERHWgrEFR/W4dBfm8ebdcgpUAqnyVtRkNepEfdKzn
         eP+IXqjhLgE041zxVy64PoJj+IbaTthXnta75kpdtvexKm7Rezo3X1Wr8JyJG2KazmcC
         mT6Jo7bAfmUDpmMCkAXPijKsflqfLhhUYQdv9KHtDlGYIASv5HoTZUBbN8QMBA9odurb
         i4IRx5S4LI3oS3e4yL/9LOn9ZF+ll0FAFWOqvQFepYISAINSCRQFp48q/gBdzqDfg8zX
         XLxMz7MOkUreHzXwluC+rP2Gxx44TF7i/wpkmuZD+JNX0taNwKM9ea0RiklbEgHB1baL
         HlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=SSzKCqriSpyIMtGicIsw7CGHmTKpA2O6/6zvz/3AVbA=;
        b=OB1Gg6xMCt2yfA7jkSeqMKFNN2wdmoM6oFgH13GO2hdmObOZm8Z0T6+QjHO0nFQ90e
         IcQW9aFYi4uh4vTZ8wEWc3VN8fqCs3NTXzY7jB5JWk6lam2uxiscVPF3Azrl1CV4n8lD
         8hA0FyL9jcYPzONdUzErU1/lFJTw2nCxLEHNHDv0EPtQnVSvZyQXOjO+YKHeQxkqxOfD
         hbJ0Hx3Xk/qers3bzrVo5k7yXPabdsNN6Ps/bx5rwhicVkQGHw/gtJysWP5+Wl4xIgVQ
         jorlDnca9KkqNqfnFMALZx6bA+/egMySJsR02xhC1bKSULJu+TfbOzDS2zo1YhGkrKrU
         oHsA==
X-Gm-Message-State: APjAAAWqtRDI1EekKk7HjvtTWxworRkw93UF8gxhIs8s7rWSVvZ+I/PM
        rkI9tc5r62dBLHFnF3F96bJn54KGYOs=
X-Google-Smtp-Source: APXvYqyLfXUz+ScgIAE+7+4C0sVTVKgoHfuJknoV2r7lE7o/Bmnm3Gd6Gmv+wrPSUxtAgi7WD/sWyQ==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr7554606wmh.32.1556274815232;
        Fri, 26 Apr 2019 03:33:35 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id z140sm49267112wmc.27.2019.04.26.03.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:33:34 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] rebase -r: always reword merge -c
Date:   Fri, 26 Apr 2019 11:33:32 +0100
Message-Id: <20190426103332.9036-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a merge can be fast-forwarded then make sure that we still edit the
commit message if the user specifies -c. The implementation follows the
same pattern that is used for ordinary rewords that are fast-forwarded.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c              |  5 +++++
 t/t3430-rebase-merges.sh | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 0db410d590..ff8565e7a8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3248,6 +3248,10 @@ static int do_merge(struct repository *r,
 		rollback_lock_file(&lock);
 		ret = fast_forward_to(r, &commit->object.oid,
 				      &head_commit->object.oid, 0, opts);
+		if (flags & TODO_EDIT_MERGE_MSG) {
+			run_commit_flags |= AMEND_MSG;
+			goto fast_forward_edit;
+		}
 		goto leave_merge;
 	}
 
@@ -3351,6 +3355,7 @@ static int do_merge(struct repository *r,
 		 * value (a negative one would indicate that the `merge`
 		 * command needs to be rescheduled).
 		 */
+	fast_forward_edit:
 		ret = !!run_git_commit(r, git_path_merge_msg(r), opts,
 				       run_commit_flags);
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 4c69255ee6..3d484a3c72 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -164,6 +164,16 @@ test_expect_success 'failed `merge <branch>` does not crash' '
 	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
 '
 
+test_expect_success 'fast-forward merge -c still rewords' '
+	git checkout -b fast-forward-merge-c H &&
+	set_fake_editor &&
+	FAKE_COMMIT_MESSAGE=edited GIT_SEQUENCE_EDITOR="echo merge -c H G >" \
+		git rebase -ir @^ &&
+	echo edited >expected &&
+	git log --pretty=format:%B -1 >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with a branch tip that was cherry-picked already' '
 	git checkout -b already-upstream master &&
 	base="$(git rev-parse --verify HEAD)" &&
-- 
2.21.0

