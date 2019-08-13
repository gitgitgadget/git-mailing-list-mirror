Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DA01F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfHMSCu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:02:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44633 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMSCu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:02:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so108576576wrf.11
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0ygGgWoHe528QOSmCcO9x0DYnWSkowkRaGwbawYAR4=;
        b=klXS9bXinBh76tpHp1CPJZIEjOQm6K88F7AwcvfN0oGyIF8VlHexBirBLH9MjEk4T+
         QzSVHewdnGyAxwu6N4MPL+8AZBOjTyiR0VH/upjXOCU3qq1vZkFIJ5jfJaTRoKDQyzxQ
         u84UsVMk3DxEzt6c3/ujMG6nXPe9r6gkr58CQVum0zhIJmyzR+GDUb9pvPos/5s3iPlT
         U2aq8e6Mkk2yh7boTdUhofsaQ4zmm1Q51oRLG4Q0e2+ZiL1JqjiYq8uf44NZ+i9b2BaD
         YJrtDUf7PejtdIVoS5+0wKMWE0suMHkFRzA146zOGrrPyMpjJPHX2N6x9l4WJl5zf/cx
         5LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0ygGgWoHe528QOSmCcO9x0DYnWSkowkRaGwbawYAR4=;
        b=RWjiuP97zG466yTCSLgy9OvcWjkRkWsaX7O8tQAj8OK6NAKuWm0z+gikPEB2DtNiuE
         r++tArlNEyx0PfYJ3cth+2jW/3M2xkWfTw8u4HsSD3dg3wwO5+IGLCwV8DxHQLre4QTf
         peHyxRCz3c5j5GKh+dCM0blhrIAALEPV3mMef0V0GVO7ByDueiQTh9ikzAPTxUyVXTbT
         /orxuar0mFiwLUIOxlqBOnTzNJ0BtCtc92pozSy6tYCkjF6Pw7DImeI9j1TxCbi9hddI
         u7kb7ncFDvJdFTT7fV6s3rCQUfsiCUzjpAKcpkRZ9sivSROoK8X14F2FQ6qd7D4FotND
         C0Eg==
X-Gm-Message-State: APjAAAUUs22cW4TTVbUqeyjg5P64QcKaRmiYAA98xNbCTNe+e6syWLjj
        f+ZDuMvISytWnv+wLL5Xk18Zcx5b
X-Google-Smtp-Source: APXvYqzK6Bi+9DVDcxkFgIySqJuCQG9E25jRt8wiVzzfL7d6T/byKXetiVmBQDD3/xnbKuH4ed99qQ==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr48659180wrr.92.1565719368382;
        Tue, 13 Aug 2019 11:02:48 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id n9sm161819685wrp.54.2019.08.13.11.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 11:02:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] worktree remove: clarify error message on dirty worktree
Date:   Tue, 13 Aug 2019 20:02:44 +0200
Message-Id: <20190813180244.28641-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid data loss, 'git worktree remove' refuses to delete a worktree
if it's dirty or contains untracked files.  However, the error message
only mentions that the worktree "is dirty", even if the worktree in
question is in fact clean, but contains untracked files:

  $ git worktree add test-worktree
  Preparing worktree (new branch 'test-worktree')
  HEAD is now at aa53e60 Initial
  $ >test-worktree/untracked-file
  $ git worktree remove test-worktree/
  fatal: 'test-worktree/' is dirty, use --force to delete it
  $ git -C test-worktree/ diff
  $ git -C test-worktree/ diff --cached
  $ # Huh?  Where are those dirty files?!

Clarify this error message to say that the worktree "contains modified
or untracked files".

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I spent more time searching for those dirty files that I would like to
admit...

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a5bb02b207..7f094f8170 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -880,7 +880,7 @@ static void check_clean_worktree(struct worktree *wt,
 			  original_path);
 	ret = xread(cp.out, buf, sizeof(buf));
 	if (ret)
-		die(_("'%s' is dirty, use --force to delete it"),
+		die(_("'%s' contains modified or untracked files, use --force to delete it"),
 		    original_path);
 	close(cp.out);
 	ret = finish_command(&cp);
-- 
2.23.0.rc2.350.gf4fdc32db7

