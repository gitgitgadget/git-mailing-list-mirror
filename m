Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74381C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiA1AMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiA1AMg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C5C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso6995843wmh.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n0OsaVS4N8R3uutCBihXpyJsQg+PHu3KsqzE/4O5064=;
        b=VM6cVF5aTuUrLhecz+7CvqG1q150s6ugPhQX+DJVKQ4gnNSVV7kXFQ0PlHj8lL0y5j
         4naXeLzNprNaX4YHHUC3forX/TU4iE3nT2x6LKPQo78V6eHsOUQOQ8yZVYt7dmn8wU0G
         33OePka8ThaOLg9n6nkAz/qDmkZ/07NDXdZjeT9TlhAgjqNyrXngBwq1Ys2tCP6FDvuY
         3Ix56BMIVBnzhF/AaTuksLQtvMC6NKvPFqDyJFCruODIya3XC4gRDTlc2nxnVl7TsGDM
         i8PFQyUxEfce8kt1AcLfbofrXbqz3PITcTAm4Tdlz2UStWeC9lj8x34bJeFBQqWdkYWL
         wwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n0OsaVS4N8R3uutCBihXpyJsQg+PHu3KsqzE/4O5064=;
        b=hwbIpeMMBJtE3O0KU3CdHQG6H8CmpqFs3XIMz7qomAIyHhzYFhRof6c7FU3W+GREVH
         6jKz8IWfkbJmrYZB2LeKKfxwcbB5RdF35vV9ySdwn4pZtmO6jd7vTfHCBVVDZch95U22
         Iw10TxGPJeGLszm37q8cRnYOIEIUq4kx51H4ftaWhgHxhud95wUAfhkspeFNsapZ6Msw
         FRz1Rmq8bB2ZfHCJxQvJ+KzXfYfLIl7EsrMoZQrBGpRpZMoNhBGl2oY+2rvhWv8wuNs3
         HA/7dVb4M/YjR/n/NoLWttJWsxjMTsOfG11p20UUSUw/CWuj17gPTbDEJQNR39RUxzxl
         I4Hg==
X-Gm-Message-State: AOAM532h87NHlL+w059KT0X0fKrSjX36Xjqk2wM3Dk0PN2vkcxgmseXn
        q5gld4dcJr9uvrzV8c1w9fzh8EIBwhk=
X-Google-Smtp-Source: ABdhPJzadBbRXGBTY3vnOoRo4MEBNMEmj63wHx+a2fJbN03SWmv06CZENH2BghWQzfX7j9G80PWzTQ==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr5110911wma.9.1643328754520;
        Thu, 27 Jan 2022 16:12:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13sm4019252wrq.35.2022.01.27.16.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:34 -0800 (PST)
Message-Id: <93d19d85ee38f50019d5f05605ce7b5eca76cbd6.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:22 +0000
Subject: [PATCH 01/11] bisect run: fix the error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
the part that prints out an error message when the implicit `git bisect
bad` or `git bisect good` failed.

However, the error message was supposed to print out whether the state
was "good" or "bad", but used a bogus (because non-populated) `args`
variable for it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..4208206af07 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1093,7 +1093,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
-	struct strvec args = STRVEC_INIT;
 	struct strvec run_args = STRVEC_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
@@ -1111,8 +1110,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	strvec_push(&run_args, command.buf);
 
 	while (1) {
-		strvec_clear(&args);
-
 		printf(_("running %s\n"), command.buf);
 		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
 
@@ -1157,14 +1154,13 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			printf(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'git bisect--helper --bisect-state"
-			" %s' exited with error code %d"), args.v[0], res);
+			error(_("bisect run failed: 'git bisect"
+			" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
 		}
 
 		strbuf_release(&command);
-		strvec_clear(&args);
 		strvec_clear(&run_args);
 		return res;
 	}
-- 
gitgitgadget

