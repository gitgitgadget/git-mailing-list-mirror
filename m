Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD4C3A59D
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 01:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJWB2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 21:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJWB2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 21:28:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A97E32B
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 18:28:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu30so10394214wrb.8
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 18:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VAq/M/jqWwY7wTJMo/BSQcY/PR/PPPt4EhUTPfnIO0=;
        b=RLXdpFGFDx61S/tXRjmgubQ91BDs883H9XdAvhDnW18eKZZ7X6VTt1M3ieg8/aeVt+
         bfpBBCMER3kPcwd8N2w9xFUQAYs4XrSKujJnxpJuixHbPk0VN+nHeW1ZLGhXOKjIEcKi
         HC116r1NnZ2ywOeRAyG3gp8cldl8qYJ2/NnC5Ec8FON1pPYpc4a2SfQ4PvBm+t469nL+
         qveS6mcAHA+3qAyMqQLQ90euqSyC83Pw2tZMWD8chvioYL2Cn41yAh/97E0xXJ2vCVpo
         4pdg5Rhf9h1meSciuap+1MiZROI0NvotR2Hry53XAZaly9yyQnOm7sjACcWWZhS3hsWD
         qiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VAq/M/jqWwY7wTJMo/BSQcY/PR/PPPt4EhUTPfnIO0=;
        b=khJAkPJ3iO/Emm62nVI5MGENNKOglsOwTZ5L1HfynPUXgTR9LTnv/k7hN/y+/Z7qE6
         iuUn3c5u8dzwknQ6PIdbB797/2wilUbiZVVJz/F9tm1w9JcVrxpALFhrm2LlrPBreDY5
         +jE22tFC4S1OGYRIEcve32Jf94j+oCaJenkpW1KNeTRvfEjbKdHLe+k/we1bK7nTiwXl
         CjKaWeManiBb3oqC3fz4zc4OWKw53yI8ffZ04x9Fb+5I+W/jaoROXX4RpemCEs7Nx/f5
         nFdhxZmKLdw1EKSlsjPYuGKWuxrcWn6MQfacnSYFKjM6DIAxBRmaJIxSp6w6EECua/X9
         Majw==
X-Gm-Message-State: ACrzQf2jwLf3cu8S+7D0wcxANWwTmQe0T/ZgBLwszfnz+ky4XiByrxjj
        t78GoM+RtBOW6WoVIzO5hPUcbH3Tc3k=
X-Google-Smtp-Source: AMsMyM7uy1D5iszMCbktzAKxJyf+bJjGwiYLp7VuNS9LZZZRfPyzNhofR68/BV78O530/b9KIYK5hA==
X-Received: by 2002:a5d:47cb:0:b0:236:4b94:7236 with SMTP id o11-20020a5d47cb000000b002364b947236mr8309766wrc.243.1666488487946;
        Sat, 22 Oct 2022 18:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003a8434530bbsm4420160wmq.13.2022.10.22.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 18:28:07 -0700 (PDT)
Message-Id: <980cf9df9a9c1cd0a538ff00c6ea2ce81b483aa4.1666488485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1361.git.1666488485.gitgitgadget@gmail.com>
References: <pull.1361.git.1666488485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 Oct 2022 01:28:04 +0000
Subject: [PATCH 1/2] merge-tree: update documentation for differences in -z
 output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The Informational Messages was updated in de90581141 ("merge-ort:
optionally produce machine-readable output", 2022-06-18) to provide more
detailed and machine parseable output when `-z` is passed, but the
Documentation was not updated to reflect these changes.  Update it now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 46 +++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index d6c356740ef..9914b1bc0cd 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -108,18 +108,50 @@ character instead of a newline character.
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
-This always starts with a blank line (or NUL if `-z` is passed) to
-separate it from the previous sections, and then has free-form
-messages about the merge, such as:
+This section provides informational messages, typically about
+conflicts.  The format of the section varies significantly depending
+on whether `-z` is passed.
+
+If `-z` is passed:
+
+The output format is zero or more conflict informational records, each
+of the form:
+
+	<list-of-paths><conflict-type>NUL<conflict-message>NUL
+
+where <list-of-paths> is of the form
+
+	<number-of-paths>NUL<path1>NUL<path2>NUL...<pathN>NUL
+
+and includes paths (or branch names) affected by the conflict or
+informational message in <conflict-message>.  Also, <conflict-type> is a
+stable string explaining the type of conflict, such as
+
+  * "Auto-merging"
+  * "CONFLICT (rename/delete)"
+  * "CONFLICT (submodule lacks merge base)"
+  * "CONFLICT (binary)"
+
+and <conflict-message> is a more detailed message about the conflict which often
+(but not always) embeds the <stable-short-type-description> within it.  These
+strings may change in future Git versions.  Some examples:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
-  * "Failed to merge submodule <submodule> (<reason>)"
+  * "Failed to merge submodule <submodule> (no merge base)"
   * "Warning: cannot merge binary files: <filename>"
 
-Note that these free-form messages will never have a NUL character
-in or between them, even if -z is passed.  It is simply a large block
-of text taking up the remainder of the output.
+If `-z` is NOT passed:
+
+This section starts with a blank line to separate it from the previous
+sections, and then only contains the <conflict-message> information
+from the previous section (separated by newlines).  These are
+non-stable strings that should not be parsed by scripts, and are just
+meant for human consumption.  Also, note that while <conflict-message>
+strings usually do not contain embedded newlines, they sometimes do.
+(However, the free-form messages will never have an embedded NUL
+character).  So, the entire block of information is meant for human
+readers as an agglomeration of all conflict messages.
 
 EXIT STATUS
 -----------
-- 
gitgitgadget

