Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05F21F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 09:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfJaJ0u (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 05:26:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41708 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJ0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 05:26:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id l3so3660998pgr.8
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9de70hLkesdnysxA/4QZ+v4DWWxjEbE4xMW+R8BEhw0=;
        b=pgwDz/hagKRNffOKUFDmKUa25Hp8Gn5XjBeK7kYA656+1vrcJ1AGap2iZ6TDo170GZ
         3S7ihUCM+/XjTODSm7AHhx/1bvwft7kLIZrxDBH6iq4d0l483eFOj3/fWVlaIyvs7EcU
         1LeK7+bUcNcZZfjq91xjHQmBEbwCiyZFEkFfy/IpUAX6HXW/SQAqUIzlsKDLytY3BUsr
         OXRsYprNCx2b++w2g2u/hWh00MK/xcZlxKxdhzKEv9ia4JbU4F5SSXWEwt53olbgALPC
         uBvZ+L9RrJcI0ySC+guYzyg4K/RtjUyx25oInwjS0HJ/TbjOMHp5jk00RgddJx3DFd04
         SM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9de70hLkesdnysxA/4QZ+v4DWWxjEbE4xMW+R8BEhw0=;
        b=fk8PRzkBNe5+6tQykmGXm7qdL1UP0WE7RAuvcKRI6vyscaPDTnek848fVr/ao7idVA
         cWmtM/i6dfckwFdXnqgq0WLKzcwouM8DboBA/vTwtajTeVUnKb2j/Jhw6rSmdH2B1kJH
         jvP8SklJ+57YC1mjDo2nCZpgJh7rk/l0VL3ndXWriwFDo88JKyOQ4lXasnPGwiB1ZnF5
         MjgvJQNp2WvnPIaX/Fa95JMDne2Ic2npAm/+RFgT6xgwb4Pwbcft/wLKYNByCml0wMjX
         SOpD6Lxd71qpwISrT7AFkFS0vuEE8M6M4honFDdDZaMIXnr3UMbw1eyBfhEnS3Z1JOnw
         0Ddw==
X-Gm-Message-State: APjAAAVweindDUFHWY4c1PfqS3Gi0q/E4+xvsuuDmDbb2cPayXs3bViH
        /D0DpGbLqs/u5HcxO8KpZmJd9rzw
X-Google-Smtp-Source: APXvYqyoQGbnq/+agPVqQuGzbNKd8Adqy4WMChm05BSU2bAkWP/1rLF5ijjo4Z7468XE57beyIgNKw==
X-Received: by 2002:a63:a452:: with SMTP id c18mr5324347pgp.188.1572514008719;
        Thu, 31 Oct 2019 02:26:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:2d45:2809:9830:be60:8e46])
        by smtp.gmail.com with ESMTPSA id y24sm3570558pfr.116.2019.10.31.02.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 02:26:48 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 3/3] sequencer: reencode to utf-8 before arrange rebase's todo list
Date:   Thu, 31 Oct 2019 16:26:18 +0700
Message-Id: <20191031092618.29073-4-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.3.gc8da3990e5
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On musl libc, ISO-2022-JP encoder is too eager to switch back to
1 byte encoding, musl's iconv always switch back after every combining
character. Comparing glibc and musl's output for this command
$ sed q t/t3900/ISO-2022-JP.txt| iconv -f ISO-2022-JP -t utf-8 |
	iconv -f utf-8 -t ISO-2022-JP | xxd

glibc:
00000000: 1b24 4224 4f24 6c24 5224 5b24 551b 2842  .$B$O$l$R$[$U.(B
00000010: 0a                                       .

musl:
00000000: 1b24 4224 4f1b 2842 1b24 4224 6c1b 2842  .$B$O.(B.$B$l.(B
00000010: 1b24 4224 521b 2842 1b24 4224 5b1b 2842  .$B$R.(B.$B$[.(B
00000020: 1b24 4224 551b 2842 0a                   .$B$U.(B.

Although musl iconv's output isn't optimal, it's still correct.

From commit 7d509878b8, ("pretty.c: format string with truncate respects
logOutputEncoding", 2014-05-21), we're encoding the message to utf-8
first, then format it and convert the message to the actual output
encoding on git commit --squash.

Thus, t3900 is failing on Linux with musl libc.

Reencode to utf-8 before arranging rebase's todo list.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---

Notes:
    The todo list shown to user has already been reencoded by sequencer_make_script,
    without this patch it looks like this:
    
    $ head -3 .git/rebase-merge/git-rebase-todo | xxd
    00000000: 7069 636b 2065 6633 3961 3033 201b 2442  pick ef39a03 .$B
    00000010: 244f 1b28 421b 2442 246c 1b28 421b 2442  $O.(B.$B$l.(B.$B
    00000020: 2452 1b28 421b 2442 245b 1b28 421b 2442  $R.(B.$B$[.(B.$B
    00000030: 2455 1b28 420a 7069 636b 2062 3832 3931  $U.(B.pick b8291
    00000040: 3336 2073 7175 6173 6821 201b 2442 244f  36 squash! .$B$O
    00000050: 1b28 421b 2442 246c 1b28 421b 2442 2452  .(B.$B$l.(B.$B$R
    00000060: 1b28 421b 2442 245b 1b28 421b 2442 2455  .(B.$B$[.(B.$B$U
    00000070: 1b28 420a 7069 636b 2062 3532 3132 6437  .(B.pick b5212d7
    00000080: 2069 6e74 6572 6d65 6469 6174 6520 636f   intermediate co
    00000090: 6d6d 6974 0a                             mmit.

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 9d5964fd81..69430fe23f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5169,7 +5169,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		*commit_todo_item_at(&commit_todo, item->commit) = item;
 
 		parse_commit(item->commit);
-		commit_buffer = get_commit_buffer(item->commit, NULL);
+		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
-- 
2.24.0.rc1.3.g89530838a3.dirty

