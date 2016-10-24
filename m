Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480522022A
	for <e@80x24.org>; Mon, 24 Oct 2016 10:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757237AbcJXKmk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 06:42:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35140 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757171AbcJXKmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 06:42:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id s8so16259182pfj.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpacT+C6gOoRmtaa/F9oMa8VvO1YY3bx4k1SzQZwv0Y=;
        b=VKFK6whe2J1tHWHQuMzj2aA4Yu1lcKWgm780im+8HVJYUYIPMNAvOcKTJQcT1TpWCo
         SEfuvBqjE6BaVM6vWqTOKgQ5RRIp/2W+glYEx0lczq66AoU0srukmhWr85fI6NBh5RA4
         raDsw2hfZVh2KZN+CZEAkSsron8JZwRZOcyTiQdlirlCJKSSUI013voph5tIFzI3L+zM
         8tGEwGZdx5uLfmaCDkF0altUaoZ0gzEf/NhNz+NwZMzDHqe3lrnUipg197lVrRBYbl3N
         6248Ukq834C8OKWuH1W3EszxfgSQTy49bD41cERlIJfEIGYIvK59F7WQX1T/JITuZg1I
         5EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpacT+C6gOoRmtaa/F9oMa8VvO1YY3bx4k1SzQZwv0Y=;
        b=FPyt3H3AgrLDUIZkfJs7dlAOVLt0zA2Z7GOvoAe0Jc3xo48zqKO7pR6kYlwuXDknGW
         YclWNtD1YL/vlAhxdK2TtgsKmx2sUvEepk4A53pIgJcc9/vJ29M6nr24eeBRTuz8rp/K
         6GVEmPLE/Y0nuh+YVeT4UGpVqbiX/U0w4m4lmVIvIIQ4T6NmaXDtcDaWhWklvyNrXgtm
         zUeB8JR5GZZbPv3No/uv+m/XyDlzErl0fjgC55c0uiQ8Fbg8mVOLUDxXGo8sq/CNuyxh
         ZWfLrDW2eyE6M3ZwXAZlyhiSVX38iOYupNGmAWbryYohHfZxcVzcMVukikHj65MnJfJu
         Ja9Q==
X-Gm-Message-State: ABUngve15z0jlm9C/my418nhdYn1t9fWRmJyuMSTI/aDiUOMn026rymu32zSXXMU2bWGfg==
X-Received: by 10.99.226.83 with SMTP id y19mr819562pgj.147.1477305758482;
        Mon, 24 Oct 2016 03:42:38 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id z3sm24297538pff.89.2016.10.24.03.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2016 03:42:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Oct 2016 17:42:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/4] diff: add --ita-[in]visible-in-index
Date:   Mon, 24 Oct 2016 17:42:20 +0700
Message-Id: <20161024104222.31128-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161024104222.31128-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
 <20161024104222.31128-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option --ita-invisible-in-index exposes the "ita_invisible_in_index"
diff flag to outside to allow easier experimentation with this new mode.
The "plan" is to make --ita-invisible-in-index default to keep consistent
behavior with 'status' and 'commit', but a bunch other commands like
'apply', 'merge', 'reset'.... need to be taken into consideration as well.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++++++
 diff.c                         | 4 ++++
 t/t2203-add-intent.sh          | 4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7805a0c..0fdd53f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -575,5 +575,13 @@ endif::git-format-patch[]
 --line-prefix=<prefix>::
 	Prepend an additional prefix to every line of output.
 
+--ita-invisible-in-index::
+	By default entries added by "git add -N" appear as an existing
+	empty file in "git diff" and a new file in "git diff --cached".
+	This option makes the entry appear as a new file in "git diff"
+	and non-existent in "git diff --cached". This option could be
+	reverted with `--ita-visible-in-index`. Both options are
+	experimental and could be removed in future.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/diff.c b/diff.c
index c6da383..e8e73f8 100644
--- a/diff.c
+++ b/diff.c
@@ -3923,6 +3923,10 @@ int diff_opt_parse(struct diff_options *options,
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight(options, arg);
+	else if (!strcmp(arg, "--ita-invisible-in-index"))
+		options->ita_invisible_in_index = 1;
+	else if (!strcmp(arg, "--ita-visible-in-index"))
+		options->ita_invisible_in_index = 0;
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2276e4e..0e54f63 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -57,7 +57,9 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1 &&
+	test $(git diff --name-only --ita-invisible-in-index HEAD -- nitfol | wc -l) = 0 &&
+	test $(git diff --name-only --ita-invisible-in-index -- nitfol | wc -l) = 1
 '
 
 test_expect_success 'can commit with an unrelated i-t-a entry in index' '
-- 
2.8.2.524.g6ff3d78

