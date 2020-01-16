Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A9C33CB3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB65D20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZwyqGM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbgAPVSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:18:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41303 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgAPVSb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:18:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so20631847wrw.8
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDuSkblCJphL+oSqg/pCp/OZntGmMPmOFoDEYJ1ONYw=;
        b=GZwyqGM+YadjBkz7t7yk7IR3XGbDawn3SZ3/Yj/LvMtoZQmaGEtuguY/IfPwSumSNc
         nobnE7DDFrlg/xTssL9xuIIFnkz5DGul3mCsekX1cf8GoQjKvGoDnLKK+XbsousEyoch
         XL0EyLRdwPF4wNWuUegVpc12fdQBk89qL2XelE+Hjs6DLvA/PD3EF6abSLpi6rLsUYDj
         Um9wKYVnz3Lm1iLoC12okqD7FLRSo2mrO/9xVHeLY0o/RTioe04lNeNNTCXX+TByiMWG
         1zdUCsOAn2DakOkGLexS6A8ykqZl+dKegCFgxY5B1YnP+n/uRKLPrsLTnPh6LoKcVbcy
         mxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDuSkblCJphL+oSqg/pCp/OZntGmMPmOFoDEYJ1ONYw=;
        b=EktKmRfJPrgt7bKvOBe16nO8wYyUCTt+elMCADBImx481/NFu6HfE39CQ3ee1sNDnh
         oOtaawOpI/9yIuxss+6SYetRN2pLmVY6OAavM3B9v7J0Bp0MxhnLgUpaYVJzwXau+YOA
         oT2AePvD8kthF+i7ttutrJn6ovgMUpW5Y4SHZGG+SK3PdvGy2o0U7hFC2bTAeC8FYsKZ
         sT+BzFEvkc8H7EyvyV2XHr8C9a8MKYJzMgmItFxOAGw/3v6YAO3bjnBZ1AAYORn683e4
         M7wBobIw1ss+EKsvn+p0KM0AW9HTfgarecZBDokk3+0ijTQ7op6BebLpjcZwfp7+mChE
         /RmA==
X-Gm-Message-State: APjAAAWwELjtVNuSR96Bk1IVOy2gUQ1IqvGcdk2v07wKL9ZoH6QMru63
        E/Z57bUbdCnsFl54wU5f7cyUTzk6
X-Google-Smtp-Source: APXvYqxFUDuTfxv2aOR8Wyq1DQ579KqnuTNS6D4fXPmwIChdpIZ3g7xwmmq+vJUSqcXx6kF0qzOGmw==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr5267228wru.230.1579209508574;
        Thu, 16 Jan 2020 13:18:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm155072wma.40.2020.01.16.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:18:28 -0800 (PST)
Message-Id: <2ae2e435b0ef6888e72defc7abee1909b29aa914.1579209506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.git.1579209506.gitgitgadget@gmail.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 21:18:24 +0000
Subject: [PATCH 1/3] parse_insn_line(): improve error message when parsing
 failed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the case that a `get_oid()` call failed, we showed some rather bogus
part of the line instead of the precise string we sent to said function.
That makes it rather hard for users to understand what is going wrong,
so let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..7c30dad59c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2118,6 +2118,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
 	status = get_oid(bol, &commit_oid);
+	if (status < 0)
+		error(_("could not parse '%s'"), bol); /* return later */
 	*end_of_object_name = saved;
 
 	bol = end_of_object_name + strspn(end_of_object_name, " \t");
@@ -2125,11 +2127,10 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	item->arg_len = (int)(eol - bol);
 
 	if (status < 0)
-		return error(_("could not parse '%.*s'"),
-			     (int)(end_of_object_name - bol), bol);
+		return status;
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
-	return !item->commit;
+	return item->commit ? 0 : -1;
 }
 
 int sequencer_get_last_command(struct repository *r, enum replay_action *action)
-- 
gitgitgadget

