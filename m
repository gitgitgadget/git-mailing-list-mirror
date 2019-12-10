Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4106AC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18F20637
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIG1ZCi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfLJPXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:23:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34071 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfLJPW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 10:22:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so20589707wrr.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l9LGdKxj+2Di3hR4JXgCF7aaU49P/5Wi/NT+hpbcM/c=;
        b=uIG1ZCi9czLJYQqIgeTfcwJbwYtgF84Na6l6IsWcNeG7kZtpFpraJKmKlYdweqpyBo
         LbxHs0hS6R2vMTakQXOaNzp1yYi7J+peAO9ywGDZqhy0SgdjmdnuWblp7yWRNhpt0DSx
         Snss6x+M2YuIZLHlw21EkJPFrlzOzOJvmnZ5ibo3NArPr+7avhYGfrriAubrk3DXAdx1
         9ymYwFrvft/yZhhQhM3Teg3cpzUu595XFcPgxCMeA+afSfgHMnvfca6JHo69eFIuolqW
         RAeEn9jqEg/MZF1P4p09TfqhbyLWyuHHfILqOYrSOWenTri7P+baNSwRgT43e/ntVzdr
         0rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l9LGdKxj+2Di3hR4JXgCF7aaU49P/5Wi/NT+hpbcM/c=;
        b=LZoCZvGX+ujRcQsJ8eSqBhig99GD/badMxaoO0941ir92nRHLRdd2hkyZRTJv5uMQb
         Z9qkB/qXz+tnMbCclGlwAAsQ4NyOYm27EcNkDz9nWnT6ABox1sdqviBcJRpatRIv3QcR
         qRn0tUvzdbTKN9mpAluXDRddvrQnRbOOEdaW+v+BRt3Iaw8nlB0vE5/S5rmmyYgIguVR
         /fpOF+qC7VwN/N4aRgC7Gzk3u3vlBRHNMMKxkavrAjD+uUCU7z49+dYn/Zpu170B/Ej0
         /Cx0ts9n35UNMMnMeWcQNMF1PcuvYqWmr77cb7oaJujeHX5FcffAhQUDH0luSpxsN+s2
         jyVQ==
X-Gm-Message-State: APjAAAXYym3B2bmo09NSH+rncd23jx+0xh/Y0wqnFQKMQubpheAyeTd3
        MMZfhA1HhS0fg/wXqKPzTdD9YZw8
X-Google-Smtp-Source: APXvYqwf7Z+0+P59988WlBarRirusf1SqKIhp+z6ky3rVrKU+lkqFGyr3L1J8GjtYGBcb2q9H4RPdQ==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr3714072wrs.217.1575991377963;
        Tue, 10 Dec 2019 07:22:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm3632172wrt.29.2019.12.10.07.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:22:57 -0800 (PST)
Message-Id: <1d4f4e210b480b6267207044b1bf79a59a70de24.1575991374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
        <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 15:22:52 +0000
Subject: [PATCH v2 2/4] git-p4: show detailed help when parsing options fail
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When a user provides invalid parameters to git-p4, the program
reports the failure but does not provide the correct command syntax.

Add an exception handler to the command-line argument parser to display
the command's specific command line parameter syntax when an exception
is thrown. Rethrow the exception so the current behavior is retained.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 0fa562fac9..daa6e8a57a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4151,7 +4151,12 @@ def main():
                                    description = cmd.description,
                                    formatter = HelpFormatter())
 
-    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    try:
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    except:
+        parser.print_help()
+        raise
+
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-- 
gitgitgadget

