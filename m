Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79401F453
	for <e@80x24.org>; Thu,  2 May 2019 10:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEBKXK (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 06:23:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBKXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 06:23:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so2518807wrr.13
        for <git@vger.kernel.org>; Thu, 02 May 2019 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=tz16CSlRmpAemYgCW3SzvPxLQ8Z6p05bzA97vBTppPQ=;
        b=HrRs39MFyk7L6+rZqCePGYppOidF1YLbE5AMo6GRiz1APKx21RcUpBkGfHanV8K1Vm
         RWllcHTgSiQqKtY9ORE5V5qADxhxeIngEJeBpd0M96OqH4K2Tgl8haLGPgmwnlGl319x
         FqE9Bx3crypbsUdH1Xtaz+9fKSOLmXQMqb6nzi6iVJ1oz8dGP44i3mSKVpTAo+INd8dN
         ZG6qy0ISzFm2OigQ1MmE/w17lHy2kJ+fL56NmzaPal1gzzjVgaY2aqgYFAHiRUfoZKBT
         05pz+KbMni3UwFjn+HTGk0dR2zAOPa/yx5pP2vvR1KvItOzjlMppB879IIu/VrZV17GG
         VG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=tz16CSlRmpAemYgCW3SzvPxLQ8Z6p05bzA97vBTppPQ=;
        b=EedYp+KBHuhEm+osbxtKfn5eeb27tQl8cbDqcd8EqUfmYQ5Px+WNL44nN9ui+ktv+I
         XJiOGNQG9F1rOyCUcT5RkWexqp0Yry6NtgWrk49Ws/QpHzsMV5cChBCIZB7ILuVF+qcO
         BleB4mbhwieSXKWjBU/x3DMX1aknODV2WfD+rBxiKzr8Bfh3BvjoGwm5Lg/K+FIOOxzw
         cAKYe0Uc4rBEonxjGDmM3mYGJVDS84nff4DLEjBnP0ewFp/mgbbvkregSfQcGnU8u3fh
         v4ysw/1R1kmMhROP1gp6kqAABRYV1DFrWn6NFFegMdr898MCeM4hALJbe3mFciMB1QWW
         1McQ==
X-Gm-Message-State: APjAAAWrrkq8dQkRYqWVxLvz2X6PzKNvVx58DB30lVO5tSHQyT2kD/by
        RN0uvEsotLte30U4h7MJmZniaOj+
X-Google-Smtp-Source: APXvYqxOLiu4in1AtHHCKnT+IhaQ00w6cGK/FsbPIUjpycWzVxr98DuTDUmZbZ3+fZTwrL7x7f6JtA==
X-Received: by 2002:adf:f98f:: with SMTP id f15mr2310944wrr.10.1556792588190;
        Thu, 02 May 2019 03:23:08 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id v5sm15503552wra.83.2019.05.02.03.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 03:23:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] rebase -r: always reword merge -c
Date:   Thu,  2 May 2019 11:22:49 +0100
Message-Id: <20190502102249.9071-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com>
References: <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com>
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
Thanks to Dscho for his comments on v1, I've changed the test as he suggested.

Range-diff:
1:  0532b70644 ! 1:  738799241a rebase -r: always reword merge -c
    @@ -40,9 +40,12 @@
      
     +test_expect_success 'fast-forward merge -c still rewords' '
     +  git checkout -b fast-forward-merge-c H &&
    -+  set_fake_editor &&
    -+  FAKE_COMMIT_MESSAGE=edited GIT_SEQUENCE_EDITOR="echo merge -c H G >" \
    -+          git rebase -ir @^ &&
    ++  (
    ++          set_fake_editor &&
    ++          FAKE_COMMIT_MESSAGE=edited \
    ++                  GIT_SEQUENCE_EDITOR="echo merge -c H G >" \
    ++                  git rebase -ir @^
    ++  ) &&
     +  echo edited >expected &&
     +  git log --pretty=format:%B -1 >actual &&
     +  test_cmp expected actual

 sequencer.c              |  5 +++++
 t/t3430-rebase-merges.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+)

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
index 4c69255ee6..01238d4b6e 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -164,6 +164,19 @@ test_expect_success 'failed `merge <branch>` does not crash' '
 	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
 '
 
+test_expect_success 'fast-forward merge -c still rewords' '
+	git checkout -b fast-forward-merge-c H &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE=edited \
+			GIT_SEQUENCE_EDITOR="echo merge -c H G >" \
+			git rebase -ir @^
+	) &&
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

