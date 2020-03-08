Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA4C10DCE
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA392080C
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUT27/XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCHS3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:29:51 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37190 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCHS3u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 14:29:50 -0400
Received: by mail-ed1-f52.google.com with SMTP id b23so1277490edx.4
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9GxdOtN0bmM+XVUuzeI/34i+MSmFF2Wr/jG/pEgwPqQ=;
        b=CUT27/XBZ8hY+ZE8xln60Kzo3BGUpNLn0W5lZNyxYmaE2ERSzVgYgCy+1c4ePP+VSR
         fFt2x+/S3sZwonXFbWe+DzJaSndsw7zwN6LBP3Tsj7W2pyzWlaTjkvWBbXGRnmrEOh3T
         7GCI7UgICpmeDa8rUuj4FWOwWJgv2YY/NSMp3ucg/MVotsFao+XuVsKsgE3wd6t395Dy
         f+GwoY3whStMa0n1jSzzZdqBueloRaiNVkWVsWi4cULJOEypNZLZCEtrzV8XhxveEhN+
         yy/TdqGI+HaQljvWu2wa78GVPYHxYk/R5m9STAlkl/CIkSUBKw/xI92SuiTV8f6tPFJc
         iQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9GxdOtN0bmM+XVUuzeI/34i+MSmFF2Wr/jG/pEgwPqQ=;
        b=F1xT/S9sPO5DBXpM/xBef+zSAIbOL5WyuByHruX5AG39CtBHDEHZj8s3f4MfnfoRON
         qrXp1X1yR628KTBhl6QxxiYPQteO6jNftVcJ3i3sC1rL7+C3GSrUozsFsKT0duVjqESl
         noqdpUWcmUHKh+DJgLljKfbna0F7LsPvSxkjYQNutPNDwUWWc0KZmyORi+StljjmWbNE
         GOYGRfSFf4mlE4Q8veh5TiDOcmT5+lgVjWdybtA/iJINalpLl/dnhQuuOEfuQImq4tyO
         iWXdFNw5+/iujS1z8HGcwcEvB2RQ/Wx+BenQFFRdFTttI5H6HlgdI1UUdo8HXJSR9pkG
         3Vsw==
X-Gm-Message-State: ANhLgQ16Ep4u/EqAnnz33ozEqv6BK6KQWUpsxCaZWTk1/4o5X3jLVpzR
        XL3jHSB3HkFf3wb3/rLEDrrW+Ofh
X-Google-Smtp-Source: ADFU+vsr3jAL0dxi0HsxAupFQA9oGLP6vXjI3zotS5M4sBTSBCD8peFJWIZT2QUFbXPHl2tCXS7dRA==
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr14078592edv.273.1583692188929;
        Sun, 08 Mar 2020 11:29:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm1719315edi.93.2020.03.08.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 11:29:48 -0700 (PDT)
Message-Id: <3e5b8ace7b8965ae8ef4f93f20fb7b268acf90df.1583692184.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.git.1583692184.gitgitgadget@gmail.com>
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Mar 2020 18:29:44 +0000
Subject: [PATCH 3/3] log: add tests for messages containing CRLF to t4202
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A previous commit fixed a bug in the ref-filter API causing messages
containing CRLF to be incorrectly parsed and displayed.

Add a test to also check that `git log` correctly handles such messages,
to prevent futur regressions.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t4202-log.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 4694b6d0ce7..1e6149372c5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -6,6 +6,7 @@ test_description='git log'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-crlf-messages.sh"
 
 test_cmp_graph () {
 	lib_test_cmp_graph --format=%s "$@"
@@ -105,6 +106,29 @@ test_expect_success 'oneline' '
 	test_cmp expect actual
 '
 
+test_create_crlf_refs
+
+test_expect_success 'oneline with CRLF messages' '
+	echo "002093e Subject first line" >expect &&
+	git log --oneline -1 crlf >actual-branch &&
+	git log --oneline -1 tag-crlf >actual-tag &&
+	test_cmp expect actual-branch &&
+	test_cmp expect actual-tag &&
+	echo "6f814b0 Subject first line" >expect &&
+	git log --oneline -1 crlf-empty-lines-after-subject >actual-branch &&
+	git log --oneline -1 tag-crlf-empty-lines-after-subject >actual-tag &&
+	test_cmp expect actual-branch &&
+	test_cmp expect actual-tag &&
+	echo "8c58a85 Subject first line Subject second line" >expect &&
+	git log --oneline -1 crlf-two-line-subject >actual-branch &&
+	git log --oneline -1 tag-crlf-two-line-subject >actual-tag &&
+	test_cmp expect actual-branch &&
+	test_cmp expect actual-tag
+'
+test_crlf_subject_body_and_contents log --all --reverse --grep Subject
+
+test_cleanup_crlf_refs
+
 test_expect_success 'diff-filter=A' '
 
 	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
-- 
gitgitgadget
