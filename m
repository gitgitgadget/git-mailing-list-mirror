Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5628C3B186
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3D92072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdNxNdsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBJWGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:06:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54620 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgBJWGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:06:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so989546wmh.4
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RsZglsNnw4Dxu30zclNRqvtGtTwNRbIm2GiByo9/2uU=;
        b=GdNxNdsptWklDSq4BTE4CsO0Z8xhwYx3dazSwVICeNLcYW39P30IhSCnOtTprTjSNv
         RnmQjEkmDxggYYfmjUJrGd91aSYO3KAmyrvEFFi7m5w1jAlw+nBcnCHnu4mgUasMs4fQ
         CXZEBAAR2jsfI4239nCEck3nIEtYVgRcEg6ouuESmKUrZb8GSw4tw1jgenSD9uyEy83U
         gQ5j2bCf+5T8KjKMGXVOT+wLJ5cr4p2RttpnEBtRvLZcad2vtqTt/XK65AZNb/pTc5WL
         R0a+e6gmHfnASMslebeVoEUnco6aTpvJq80FUbY8jBjrhuFulWPPDiN1IZcH64INdK9H
         vORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RsZglsNnw4Dxu30zclNRqvtGtTwNRbIm2GiByo9/2uU=;
        b=s7U9heHPzHlWbkailPl7YkjIjDySQVLkiUYCc9xNr2s28YKWnzct9gey2QOhGH1ZCb
         v0wLh84zFBW96kxzdG7GQ4mGgI5/NheqdG21P/1oE8HgkFeck6PgQBlHsns39uG0f3sY
         5yc5QvPN5/ka53B94B5VTPyqfBwdodU2iibz1g/Zi/imjB9nA0N2gWjy3KjzOr8wVBDS
         h/09Mo6U27GvFhwCc6QxCtOpLiMUttHRAC22DW8EJpjXD+kSY1hovoK+1xKdYncAuLu3
         os9sxCLenpU1m/bHSPJs5bJ4fRj1zukTvb2G/JZ9x0vgNdIP30DQoU5whCK19fD/09LE
         7lbw==
X-Gm-Message-State: APjAAAWpT3xQZbsneBZKB4GAx9NriXgcVwyhQPuY9q0064SPLL29GO/i
        Q6rf/HTji9c9/7p1CFN8/rBPHU2o
X-Google-Smtp-Source: APXvYqxKAGIsRWbh2xk28Y4/WHaiPn4YbD2kx8oUjNMG5amIq1mkIo0Sh4knSoPAgbhXO9PcyPRTpA==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr1168946wmc.185.1581372379081;
        Mon, 10 Feb 2020 14:06:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm917734wmi.23.2020.02.10.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:06:18 -0800 (PST)
Message-Id: <71c51ccfb0c53fdac67ba35d474c51a9da0c28e0.1581372376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
References: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 22:06:11 +0000
Subject: [PATCH v4 1/6] git-p4: rewrite prompt to be Windows compatible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

The existing function prompt(prompt_text) does not work correctly when
run on Windows 10 bash terminal when launched from the sourcetree
GUI application. The stdout is not flushed properly so the prompt text
is not displayed to the user until the next flush of stdout, which is
quite confusing.

Change this method by:
* Adding flush to stderr, stdout, and stdin
* Use readline from sys.stdin instead of raw_input.

The existing strip().lower() are retained.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 40d9e7c594..65b6d4dca0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -175,7 +175,10 @@ def prompt(prompt_text):
     """
     choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
     while True:
-        response = raw_input(prompt_text).strip().lower()
+        sys.stderr.flush()
+        sys.stdout.write(prompt_text)
+        sys.stdout.flush()
+        response=sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
-- 
gitgitgadget

