Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E30AC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiGTSRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiGTSRu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:17:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122C63904
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:17:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so14423448wrc.8
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z0cyL2G7rRCD38bFO/lfjNpunGPbxN9v5PK3AbAyJcI=;
        b=ZLBC5ifSGpAAc/BIPhAbJexRryqMG3LB9kB7JLP51LZRW5hkk7Qg3VofOeSm4JYNBA
         2aqwN1poSAwVDcIADQf+O6GdKb8l5Z/EFXv2mD6nonA37h06PAfaAwWGCdNEhrCc01TP
         ah0dMh2KfTYM3rN0S7rcwwGsHk3Cx0yOleuKoSnQgI7nTHd8bu1SfarA6WP/VimwqZtZ
         L6zHSUHXX3Poh2TqC5wdLhf3TXttmnxspFgSUDbNRDAnSH+Q1Ab0q7iw2ha8R38N2+0Z
         2bOzCef5PrWeX4B5f3OCCqybleXFpfDcr33aY8/oTLg51dl8JiOwyO4uLr52fCF/h0C9
         skYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z0cyL2G7rRCD38bFO/lfjNpunGPbxN9v5PK3AbAyJcI=;
        b=3VvhouL5QgolA3WaC5BQlKS7d7Ml5Ppa9zX9Zky2YmhbHvSUd0wkn0lqRlTvt3aWh9
         OnsvaAmLugk+9sEsiBq1xnuBmqf6IyZ7XU81hADJUF7I2MM2i+zgxXzJc8gdHtAQ83sF
         3ta+/SyKBW0+G96OB6gSObVgfwcdMT9HQ/5bq7TdW3yZtucrZcC550/agzapmD5eDn6D
         kG3QpiNcFJSMFQT4iRg5v7zmzdyJWu7LoWidp3fo5S81YTSO5a/zRG3vxOpkYKlvdiDh
         rOvqkdYWK5CaplGLt/ouDWECxsfYUel9ZKb+lVYTa7dA+Ix94pAVB5Yb7dy7aGiO26zx
         Gu7A==
X-Gm-Message-State: AJIora+tQgIE66lopKGJCLQetCpGvLJ8nth6Wwyd5LYNOsIbSzMnisFs
        pZYSA58sKtLwIFX55kyF8o4QzRyUg04=
X-Google-Smtp-Source: AGRyM1uutMOHuZeRRtkOkr19DuMu3/Px4RBMEWdYJ+X7Myvi8iflB7CSv/8hillRGu3/F1TWhKzNzQ==
X-Received: by 2002:a5d:5888:0:b0:21d:754b:7afb with SMTP id n8-20020a5d5888000000b0021d754b7afbmr31206848wrf.117.1658341066640;
        Wed, 20 Jul 2022 11:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b003a32297598csm3846397wmq.43.2022.07.20.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:17:46 -0700 (PDT)
Message-Id: <pull.1294.v2.git.git.1658341065221.gitgitgadget@gmail.com>
In-Reply-To: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com>
References: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:17:45 +0000
Subject: [PATCH v2] git-p4: fix CR LF handling for utf16 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        "Baumann, Moritz" <moritz.baumann@sap.com>,
        Moritz Baumann <moritz.baumann@sap.com>,
        Moritz Baumann <moritz.baumann@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Moritz Baumann <moritz.baumann@sap.com>

Perforce silently replaces LF with CR LF for "utf16" files if the client
is a native Windows client. Since git's autocrlf logic does not undo
this transformation for UTF-16 encoded files, git-p4 replaces CR LF with
LF during the sync if the file type "utf16" is detected and the Perforce
client platform indicates that this conversion is performed.

Windows only runs on little-endian architectures, therefore the encoding
of the byte stream received from the Perforce client is UTF-16-LE and
the relevant byte sequence is 0D 00 0A 00.

Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
---
    git-p4: fix crlf handling for utf16 files on Windows

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1294%2Fmbs-c%2Ffix-crlf-conversion-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1294/mbs-c/fix-crlf-conversion-v2
Pull-Request: https://github.com/git/git/pull/1294

Range-diff vs v1:

 1:  4a7a14eec28 ! 1:  4d0043712d3 git-p4: fix crlf handling for utf16 files on Windows
     @@ Metadata
      Author: Moritz Baumann <moritz.baumann@sap.com>
      
       ## Commit message ##
     -    git-p4: fix crlf handling for utf16 files on Windows
     +    git-p4: fix CR LF handling for utf16 files
     +
     +    Perforce silently replaces LF with CR LF for "utf16" files if the client
     +    is a native Windows client. Since git's autocrlf logic does not undo
     +    this transformation for UTF-16 encoded files, git-p4 replaces CR LF with
     +    LF during the sync if the file type "utf16" is detected and the Perforce
     +    client platform indicates that this conversion is performed.
     +
     +    Windows only runs on little-endian architectures, therefore the encoding
     +    of the byte stream received from the Perforce client is UTF-16-LE and
     +    the relevant byte sequence is 0D 00 0A 00.
      
          Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
      


 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 8fbf6eb1fe3..0a9d7e2ed7c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3148,7 +3148,7 @@ class P4Sync(Command, P4UserMap):
                     raise e
             else:
                 if p4_version_string().find('/NT') >= 0:
-                    text = text.replace(b'\r\n', b'\n')
+                    text = text.replace(b'\x0d\x00\x0a\x00', b'\x0a\x00')
                 contents = [text]
 
         if type_base == "apple":

base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
-- 
gitgitgadget
