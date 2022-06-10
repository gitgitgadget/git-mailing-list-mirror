Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAD4CCA47B
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiFJOss (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349683AbiFJOr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E29F3BBDF
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h192so18191851pgc.4
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjcwYh0Ii8wc1gfx1hiFbX3M7RlEDLIVbiPqPcLqNgY=;
        b=SHADqNJcolagakLneWiYajtcljH8700nMHwBr1xyZB2MU5LukbYs8n+d5k7VpUX0+V
         eQFJWAwpGh3xVicT+2YE8Pn304I4sSxlKetvs8lvarGld7SDfBW+aWyV78eBnATMNE73
         vC/B10c6B69w0l2pcGxrzooJfD5VZs58xSFbYNx3rtQW/zpEIyOIg6vUp7P+AT01ggT5
         ixrQqXVHORJITWe4/Hy7XCJsJj/NIG3dK2wJttLP40QucYcXIanop8g0Dscz+0dcOk1a
         hgXX9DirPS4j2vSLvEBemC58r0bbAiIhKZxuraqnYmqz1+DbP1igpXxLEyXDbKXkQTsV
         guBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjcwYh0Ii8wc1gfx1hiFbX3M7RlEDLIVbiPqPcLqNgY=;
        b=VJ4I8EoHM+GxrhdFVo8AdSJpYfjR62ep+6KpM++K0Nn1xl79uCytOLjB2bH7UzkkBZ
         0MW8QpML/oxu40k0nq2cQSCbWJxA19DA3HE/1R2OvNte6OBLRxESyOx7CSpQXhbWU/BU
         NuxcQQA2DoRxWNwynqj3G6sQvdh9mG9QaogS27k3LQLYxo3WUJXY/MzIJdQPM1/TjWBT
         V9TZIxmb2wDn670S0AmIKJouGnmkb+/NrL3pShqm2nlBuvYqSSli2Dla6+iIY7rdCMp7
         mO7Pefr5gENS9MOoajeVxjutR1wVx/HXEb7wbGPIWms455KRNKe9qM0MHyeG98R7ibWr
         EunA==
X-Gm-Message-State: AOAM53241hlozfwQASkShCxbJe/s1nSYFYQlLBq8gMzp2JZ2ffQBAK6G
        Rm6KLldFi+VZVzuCkBfneG8=
X-Google-Smtp-Source: ABdhPJwc3xGWRvBHqA427bkhk/aaPz4GWSRTvqOZwzcEnlfP1H/iMm4F7Tvc9ac4geHfthPQ3bFutg==
X-Received: by 2002:a63:90c1:0:b0:3fc:7de1:b2b9 with SMTP id a184-20020a6390c1000000b003fc7de1b2b9mr39741287pge.440.1654872460561;
        Fri, 10 Jun 2022 07:47:40 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:39 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     chiyutianyi@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        l.s.r@web.de, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>
Subject: [PATCH v14 6/7] core doc: modernize core.bigFileThreshold documentation
Date:   Fri, 10 Jun 2022 22:46:06 +0800
Message-Id: <dea5c4172b3908104d703dd09b644796ae52d873.1654871916.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654871915.git.chiyutianyi@gmail.com>
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com> <cover.1654871915.git.chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The core.bigFileThreshold documentation has been largely unchanged
since 5eef828bc03 (fast-import: Stream very large blobs directly to
pack, 2010-02-01).

But since then this setting has been expanded to affect a lot more
than that description indicated. Most notably in how "git diff" treats
them, see 6bf3b813486 (diff --stat: mark any file larger than
core.bigfilethreshold binary, 2014-08-16).

In addition to that, numerous commands and APIs make use of a
streaming mode for files above this threshold.

So let's attempt to summarize 12 years of changes in behavior, which
can be seen with:

    git log --oneline -Gbig_file_thre 5eef828bc03.. -- '*.c'

To do that turn this into a bullet-point list. The summary Han Xin
produced in [1] helped a lot, but is a bit too detailed for
documentation aimed at users. Let's instead summarize how
user-observable behavior differs, and generally describe how we tend
to stream these files in various commands.

1. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@gmail.com/

Helped-by: Han Xin <chiyutianyi@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 41e330f306..f2e75dd824 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -444,17 +444,32 @@ You probably do not need to adjust this value.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.bigFileThreshold::
-	Files larger than this size are stored deflated, without
-	attempting delta compression.  Storing large files without
-	delta compression avoids excessive memory usage, at the
-	slight expense of increased disk usage. Additionally files
-	larger than this size are always treated as binary.
+	The size of files considered "big", which as discussed below
+	changes the behavior of numerous git commands, as well as how
+	such files are stored within the repository. The default is
+	512 MiB. Common unit suffixes of 'k', 'm', or 'g' are
+	supported.
 +
-Default is 512 MiB on all platforms.  This should be reasonable
-for most projects as source code and other text files can still
-be delta compressed, but larger binary media files won't be.
+Files above the configured limit will be:
 +
-Common unit suffixes of 'k', 'm', or 'g' are supported.
+* Stored deflated in packfiles, without attempting delta compression.
++
+The default limit is primarily set with this use-case in mind. With it
+most projects will have their source code and other text files delta
+compressed, but not larger binary media files.
++
+Storing large files without delta compression avoids excessive memory
+usage, at the slight expense of increased disk usage.
++
+* Will be treated as if though they were labeled "binary" (see
+  linkgit:gitattributes[5]). e.g. linkgit:git-log[1] and
+  linkgit:git-diff[1] will not diffs for files above this limit.
++
+* Will be generally be streamed when written, which avoids excessive
+memory usage, at the cost of some fixed overhead. Commands that make
+use of this include linkgit:git-archive[1],
+linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
+linkgit:git-fsck[1].
 
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
-- 
2.36.1

