Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936151F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfKFJUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38077 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfKFJUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so3540874pgh.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rXVqJ0C9I1znzANkMY14/MgQCxkjcmfztDiYR3m6OjI=;
        b=Aq3Smsgn5IqTmPmqdrra09DIMKt71qTmusuFxx71Owbw/qcroh97OjYDXHwdxEGnzB
         17otU4P49M711cpBuu/4wASfdWL6153tMJxrD1OATT2bWaMaFQNoXR1SymWEo/DpYr+x
         obZrojAlNEeUDd33fz5mjxkBK4PL4p0Pp7klTlkbOzEaOfzjLBZYCRagZQSQ1JQmbVey
         O1jBRFo5k22DlK/OKe4uPNQQu/hrdONj744zSmeDrPSgk0/oCxejqG/0PgMux4teKptF
         xPJGDUb6y9mhptrV91v2O9p5Jr2pJbYmTDx7X7RlbfMST6e/jyXHF61s3xDZBtz2dOrd
         aU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXVqJ0C9I1znzANkMY14/MgQCxkjcmfztDiYR3m6OjI=;
        b=YVCcMTlGn8avTOxdVM1J2IpJSijbHBuELcJlNivOsxiJr2Fty9a6DP1ea2sDWnIHLr
         ofr3q2Go60l463IukvEIZ2iEDNiR4/frCyCPMfsl9tQfx+dD4wc+ykyiKkODabnrhOEA
         lRsSqff3z0kDdXrIx4epXXmzpLAg5i8t+YeY+clRBYA+xuodXmRjdDsZPDHCVLOVIfr4
         4aSxtsAzESohH6WAQThtRqRABwl9jjXzcR7F7WGth/SoEyTbxiGz+gqB6zdw4hVo9tx7
         mhurtjkpFkp8Jbod8wGzJsH4iEeoIDLxy+BuwU+tCoIJPRIJUSBJRv/w03plo/CmFUx4
         wEEw==
X-Gm-Message-State: APjAAAVreDVGDlW7uzDdyZ9ibkmcIkOAAvfsb031mKI4Geqq4yWOFRnV
        eiw6kZJWU1Je0H88sEZrh0lbqKeq
X-Google-Smtp-Source: APXvYqzTzYGs7cxLMNMN+D6qgS1C84K8OzD8uTLkduXauBc0lIzDMqTEh4rNiH9p2gji9CI572Bh3w==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr1772765pgl.70.1573032041686;
        Wed, 06 Nov 2019 01:20:41 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:41 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 4/8] sequencer: reencode to utf-8 before arrange rebase's todo list
Date:   Wed,  6 Nov 2019 16:20:02 +0700
Message-Id: <6a51fdd29cc9b1132548726028e882a5a99acbd1.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
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
By doing this, we also remove a breakage introduced in the previous
commit.

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
index 85cac6e2dc..7501555c52 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -209,7 +209,7 @@ test_commit_autosquash_multi_encoding () {
 	old=$2
 	new=$3
 	msg=$4
-	test_expect_failure "commit --$flag into $old from $new" '
+	test_expect_success "commit --$flag into $old from $new" '
 		git checkout -b '$flag-$old-$new' C0 &&
 		git config i18n.commitencoding '$old' &&
 		echo '$old' >>F &&
-- 
2.24.0.4.g6a51fdd29c

