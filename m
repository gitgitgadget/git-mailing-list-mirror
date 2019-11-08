Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27FD11F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfKHJoI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38571 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbfKHJoH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so3628099pgh.5
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6d1DUXlkPxPMpW7ps8CA8nF/TrGO3MWgHW+oDNIXGU=;
        b=gf7VRjLjkcpxi8LCLfdA3ZpkREEOFvzeucUREsx58oJhSIB1KgO8w/uWEk3jx+IgPC
         3WmqDSE0Ff8stRJmzcppXvUQdETXNo4+6GAVgWyooNEJu8wgxGhlGrRsVjeppaKzv5jU
         tuJpzciNI2T55KZAUakS68yTkd2h4NIYvALvJS3LNna2FS8Dw4ONmrKNKAqEjflegyaH
         JsRa0u0G34O9OghOCwwrDtxiSk/0Ad82RbSWBhF9QS/kEtv6lstW5Zp8afBVNaJm/Z7z
         NayIXBQGZG+XkqqFqgnvb18LpP+Zndy3MCVOaoCjxRaRulnHSzEXvtmgiwFR0dYufrsg
         Tpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6d1DUXlkPxPMpW7ps8CA8nF/TrGO3MWgHW+oDNIXGU=;
        b=C6vULi2wkeuHegtgTvGQA8qzC1suT+HYtkluzB1mTLQvpeI9A9X7EjdxI5iSdekh6A
         4qdaZI2S0lmbH6LSebs18vdanEu0gN8aggsoishqJC/QsHYEh8QCaotBUULLwGdQsOtg
         PPVXYQM3GNgsN0qAeu2xIu8Dgi/wOSSJBs194rvMDQWfoiTWyurKHLK5RCY4UhXVXGs5
         v3A92L4LyN3Oy0Xd2SjoPGR4GqLhBK+6ydW1oem9T2cp+pxqYdrKMUzff4UIVjLvRZnl
         C2VVAQcgLrPrlcvIKj1deXkRueKJPeqQxQFyCuheVjmjz99JrvvbUTiLAiBSaSRpzcZV
         EhqA==
X-Gm-Message-State: APjAAAU7t9bTEAiisF3Wd/x2OpzvMhoFKFZO9ZynbwpbaSNyZ9Nb/1tt
        k1+dq7Ktok71kj+BdzxGgaV4w1dV
X-Google-Smtp-Source: APXvYqzt5fyNo8LEkW9rDiEtJhLu1SpKNMwloMTxCA2uLJG1tKc27jqBZ1DydUgr8ZShrnb+b+jndA==
X-Received: by 2002:a17:90a:c2:: with SMTP id v2mr12078202pjd.19.1573206246940;
        Fri, 08 Nov 2019 01:44:06 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:06 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 4/9] sequencer: reencode to utf-8 before arrange rebase's todo list
Date:   Fri,  8 Nov 2019 16:43:46 +0700
Message-Id: <17165b81e53e45b0abe9d5a03d7f214a28043cc8.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
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

Thus, t3900::test_commit_autosquash_flags is failing on musl libc.

Reencode to utf-8 before arranging rebase's todo list.

By doing this, we also remove a breakage noticed by a test added in the
previous commit.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c            | 2 +-
 t/t3900-i18n-commit.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index dd56384b93..a518281b04 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -209,7 +209,7 @@ test_commit_autosquash_multi_encoding () {
 	old=$2
 	new=$3
 	msg=$4
-	test_expect_failure "commit --$flag into $old from $new" '
+	test_expect_success "commit --$flag into $old from $new" '
 		git checkout -b $flag-$old-$new C0 &&
 		git config i18n.commitencoding $old &&
 		echo $old >>F &&
-- 
2.24.0.8.g2e95ca57d2.dirty

