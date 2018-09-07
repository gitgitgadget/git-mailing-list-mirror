Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0C91F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIGXCC (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:02:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40455 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeIGXCB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:02:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so7372476pga.7
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B49F1kB6gosK0V9gAMjrhZj8eNL+L4idpNHd4+AVFDM=;
        b=cJDa/lhlPlAlP7VDR/WAxuQhwOgB/FCyJ8OhhcwFqEBTQyIgGbERzY/H2mdDBL2Jsf
         X42+FZ/ulJNCao0NuyR8GeOPseOCpZCzCy+baQajeKuc3jLpUhDjkYqmhos9ns9Clwm5
         RMICDrTJiE4r9+EBIC1VEiQ129S2gwCCQadlBudTmfelqiS8pFUQ/klZyWOX1vyGKdFA
         dko05/MNXwhYlbUt1mLdwkwV6QcsvnRXAomY9HlKn9OF/2X6yziydPVfPb5MmHjbkKLp
         yYQO8uhO6Rd7bvwYi5vyN5QXBfF8qUucrUAFhdxsFBcLCExFWQeKe60uu9g77nfOU/iN
         BWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B49F1kB6gosK0V9gAMjrhZj8eNL+L4idpNHd4+AVFDM=;
        b=egCtTItIYq9FQrhCLkIrhViiOP8VsZ0rjXZeiFYgEGADzzB/OOsTr3cqhLnOEUy0B6
         ESmnpOu2If4kAcZo0PaZPtXUeVxMPbD9oQjVeoKyc+ccFAapdZgl1s9w9s8hL5sxAmuf
         yldt/4yjTfjehAvihS8ADB/TKncRsxqMLnngQo+Z0xurVch9G7MmIdpsaUQb5VIrlVi1
         evqu1OnnmLaCyCrkN2g/so7C10KzabvvNt2mIMeGy+uOIClYeQV9h1fHRZmAqvDzgGVQ
         ifAcX0Z0OK4YQHZcX4A22o1Ad1LTW1zy4V6KBeiOov3HIfFYsTlujAVqOqwrTZNqq0YN
         K9Vw==
X-Gm-Message-State: APzg51DTRCT9kqmn8bsT6OPNS0MB0Q8NIfTqhfWjgCOsyGAaxmdvn2Or
        11B8nKZq3G1SVVI685JlCzn06MtD
X-Google-Smtp-Source: ANB0VdaOShYW7wbFNrEDfUXrdNnRLPDZ1nuMQ3AyfNovfhXLEH/sS2sGrtntKMvhfOZYOspCp3qWRA==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr9617589pgj.15.1536344393146;
        Fri, 07 Sep 2018 11:19:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u25-v6sm11950342pfk.177.2018.09.07.11.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:19:52 -0700 (PDT)
Date:   Fri, 07 Sep 2018 11:19:52 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Sep 2018 18:19:46 GMT
Message-Id: <f433937d55974b75750cfc7d579a6a56109259a4.1536344387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.35.git.gitgitgadget@gmail.com>
References: <pull.35.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mingw: fix mingw_open_append to work with named pipes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 858ca14a57..ef03bbe5d2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -355,7 +355,7 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	 * FILE_SHARE_WRITE is required to permit child processes
 	 * to append to the file.
 	 */
-	handle = CreateFileW(wfilename, FILE_APPEND_DATA,
+	handle = CreateFileW(wfilename, FILE_WRITE_DATA | FILE_APPEND_DATA,
 			FILE_SHARE_WRITE | FILE_SHARE_READ,
 			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
 	if (handle == INVALID_HANDLE_VALUE)
-- 
gitgitgadget
