Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1A31F461
	for <e@80x24.org>; Tue, 14 May 2019 18:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfENSEH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:04:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39441 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfENSEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:04:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so27258wmk.4
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=nASAkG9LFdEMkYOsj/hg9OnOgwU/MZOaALnQ/b8M4qg=;
        b=uvowXe9Tn0mSUuHzjY+MwgXzhJyRBspMOW/ul1Te/obK+b8MpVAWTn4cqns7svTlgp
         OrbtmWKO7uigrk1Kcv5hwJA3iwM8uPoxahtQjoobSrZWhpeKppQcK/LoXO+kyi6KH0mm
         8IfJcvUdLpGnWdKLzIb9tFtETt/+bohWmlPVuYyA5eD43zahUy80GWijdJryeFByGJIi
         Hj8Dw4EElf3Jkpr6n1dNVcJ+MYQZD2XbswBTKaPtmKDYdIu3IGIMzUw0ajuZMmgAdMBx
         Nn4D1XQMXzofZDGYQVjtEuwHQYHHbOKnrFSXf4Lw6y1MM5Yi7KKNvymJNaRerIOSxULo
         lSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=nASAkG9LFdEMkYOsj/hg9OnOgwU/MZOaALnQ/b8M4qg=;
        b=KbmHQS2ErPzWz0db8lfz7V8S2bZi1f7W1LSaX7bM6JULBgzHVwCG+Qf84T15T28Sis
         FGbrwxpSG5/bGWOsHJd6BBYtaGupmgoeoxYK604IilGvh2CGbBfVPzsGefNSPkT5MObc
         DnQSQdwJjJn++EY1hGElrjBe5FXczpdfooa88sLd4K3ay0YpJ4H0t6lopG0mk3RC/ovc
         B2NeJM9EPUxYQdVNv2popahoQjjdWFCUYxj3BKPQtUpfEHTy3NgVT7fmBXjrgXfjO4ng
         ZchOMfNVS30MOL7yW/eokN9r64w2ziZZSOiK8KxqzXoQEN7tsvr2NZBS2iyxBoMD7mQ+
         BBdw==
X-Gm-Message-State: APjAAAUkRZtAtRGPqlBZU9eAKj/DT/G4f5rJx5Gyn8q5MZAT3nMBN17L
        BO8gro0EQlNWpFFrM6XotjsHG+NB
X-Google-Smtp-Source: APXvYqxr3Ig1UlK9MuOrOK4NM/Kt+UNMD0EFAsaB8n9krZHIjyLearEY8DpS9nJB5G10uk6r4r77Hw==
X-Received: by 2002:a1c:7e8d:: with SMTP id z135mr9974101wmc.72.1557857043616;
        Tue, 14 May 2019 11:04:03 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id a4sm4528230wmf.45.2019.05.14.11.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:04:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/4] sequencer: return errors from sequencer_remove_state()
Date:   Tue, 14 May 2019 19:03:48 +0100
Message-Id: <20190514180349.17245-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514180349.17245-1-phillip.wood123@gmail.com>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
 <20190514180349.17245-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there is an error when removing the state directory then we should
report it. This matches what the non-interactive rebase does.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 610b7ece14..258e583156 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -274,7 +274,7 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i;
+	int i, ret = 0;
 
 	if (is_rebase_i(opts) &&
 	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
@@ -283,8 +283,10 @@ int sequencer_remove_state(struct replay_opts *opts)
 			char *eol = strchr(p, '\n');
 			if (eol)
 				*eol = '\0';
-			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0)
+			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0) {
 				warning(_("could not delete '%s'"), p);
+				ret = -1;
+			}
 			if (!eol)
 				break;
 			p = eol + 1;
@@ -300,10 +302,11 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, get_dir(opts));
-	remove_dir_recursively(&buf, 0);
+	if (remove_dir_recursively(&buf, 0))
+		ret = error(_("could not remove '%s'"), buf.buf);
 	strbuf_release(&buf);
 
-	return 0;
+	return ret;
 }
 
 static const char *action_name(const struct replay_opts *opts)
-- 
2.21.0

