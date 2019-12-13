Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2563CC5072C
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28B24704
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs96MdNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfLMN6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:58:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39874 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfLMN6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:58:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so6754231wrt.6
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YmwJ1AiAhROBSVvbSzClqv1iDdOg1HA0hifERAW9N5c=;
        b=Vs96MdNJzwmmk4L0QybHZe10Nx2a4BaYK9QOTFU3PChABClNkgdPiiFxoghEZArJRy
         rqMja1TKkiZsAMnUgoN6xf59/u/AnhzRzrwkhDynuk2R0TJzNtoP+Ut7EvhEEOIXKFIQ
         2S0e5NL+nulawXU+uAykGolimOWMk0MbfxY+0GCrirxwidOtpvqRx8DpB51tcc6E5RX6
         d53FcIxChYxHY7qUdmT7iopVyd6dQ5xkAlgraXSbWemXiauFBLjIAiaFGR2gsBVUNCH8
         gAkDCLHEepalgHdw4UtK2/7q/t5ROwKbzkTtftBMR7lHJ0oWv9mrvzcX+mhqOM7BQKlZ
         ag1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YmwJ1AiAhROBSVvbSzClqv1iDdOg1HA0hifERAW9N5c=;
        b=SaDeRP7pVCsUaxdncnwUvisbemdLgHnH2EnipAME3qP5ieIVvXYEk1Yzvgl63CfgsX
         e4MOfjXDb+I1DaMneGbwyr076jnsaeJ5bTNX8ASCHBkdW5Ns897c0m6rngYWjJxnxq0V
         6rPhYdq7TN9CiL9ekc9Xs2sOxZxfXYbtzDf/mTQM6teAp5hrW5rdrH+xKY7QYGF13xDI
         9Adt/SuK77HvSQJ5p8HvNfcDqIlXm7Z0s9Ybz36dciutKtaPhwV6FQa8du2ohIn0ghIy
         xTCzmd0Qw4bPcPEhUd27Cy1t0s/CUkkll2jhX5elXO9wadP1iMRKDucTNPcH3PdjGl+t
         +YJA==
X-Gm-Message-State: APjAAAWlGv8F9HZdVkSqZignOwcunV2qQLZQD/rPiNtzZPJtBtKMmdLj
        ck6yKZa1dYrtrJl9CECXxXePt2if
X-Google-Smtp-Source: APXvYqyd26kFUGlOScjZREQE97sN4oQXwJ5i7tygQK5xq5gyznL5eCn46AImuR097on4GcYzI7ru3A==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr12748368wrj.261.1576245486011;
        Fri, 13 Dec 2019 05:58:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm10258020wro.67.2019.12.13.05.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:58:05 -0800 (PST)
Message-Id: <c78e2e4db14ce712375dbd63f9f45335902df2ae.1576245481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
References: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
        <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 13:58:01 +0000
Subject: [PATCH v4 4/4] git-p4: failure because of RCS keywords should show
 help
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

When applying a commit fails because of RCS keywords, Git
will fail the P4 submit. It would help the user if Git suggested that
the user set git-p4.attemptRCSCleanup to true.

Change the applyCommit() method that when applying a commit fails
becasue of the P4 RCS Keywords, the user should consider setting
git-p4.attemptRCSCleanup to true.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 03969052c8..690e5088cc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1962,6 +1962,14 @@ def applyCommit(self, id):
                         for f in editedFiles:
                             p4_revert(f)
                         raise
+            else:
+                # They do not have attemptRCSCleanup set, this might be the fail point
+                # Check to see if the file has RCS keywords and suggest setting the property.
+                for file in editedFiles | filesToDelete:
+                    if p4_keywords_regexp_for_file(file) is not None:
+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
+                        break
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-- 
gitgitgadget
