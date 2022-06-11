Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6BC43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 02:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbiFKCpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 22:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349718AbiFKCpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 22:45:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735273F62C5
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t2so732443pld.4
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwBjxKyIkVBuOPUHp1A97ClrKGi3RzEhKlM7mpYh2eg=;
        b=Orbllgx3IZyk0GVf6gBnb74s8FwM9ysnmJwPdqTiXgyZG3bII6NLlcCX18CzJz+K8a
         Kj94aLdU7BYEjHEvTNTurf+6vsBjx7tETUX6NNMXXHJUYwrdJ8iHFdqZwpRs/OMZ9dUK
         LTQcmRRQLG1IkDYnLbVdGZ1rc5lnx3AZO6W9UBBxFp0Lu0dH5rsOTcJdKZx+2wV9v9ZU
         lpJSKuSZs17a/xzPwaRxHOPLzlyQsNzUTBYItFbp1t0yWF4vjg9kOMqLI0z/oikurmGI
         NR+wEDcl4dE8qNMLSJX6BVLuN2DTY7qUBsYnJZaGcQr0eqae+Q6pITCixVRNsaWiEu3U
         MlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwBjxKyIkVBuOPUHp1A97ClrKGi3RzEhKlM7mpYh2eg=;
        b=47YKfYswdYlw4hBIU5hVrkpwMCQu34l+ZXaEtYtsK2YbCOTlWT0xCPVLLTM7Fsh2fN
         NZoDsnWcR0Qo2conCpoTSPU8x2IZol92xGYPggcM9gYulgl5T6dk+NScf/ykAzPY4tat
         3MDJxwgCa9FRN4/oOkjENP6/uHQlTFSrPY19GMI1sWF4tLpd4qs957fm21JaZWOdZBg9
         14eQQ8352BS63Vp90NaONkFeXaD35/MbXzAxiGBo+pK2JVsSYtqse6PUO0JUPmWe5Cpp
         RaXA3bcnwnAudEl3KuUAUDWVlY23JCUSZfIDwc9f6PNvQf+2qmF0I9O3t1dDhMD1/kDf
         kJMQ==
X-Gm-Message-State: AOAM531M/MSzLEnw1o0kG9YQLKqQT6Cfw4YJall8hShT4SWLUSVcTNNv
        3OzQS2rR2PWTFW5/dUZLXa4=
X-Google-Smtp-Source: ABdhPJxiB/T5wPosxuu0khjTlwWMakYzXM3ZrSqKmu5x9CxLLjRDfOFra/PtUV3djc/g15fAbIkYtg==
X-Received: by 2002:a17:902:ca0b:b0:167:4c4d:7320 with SMTP id w11-20020a170902ca0b00b001674c4d7320mr40255507pld.113.1654915497617;
        Fri, 10 Jun 2022 19:44:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:80c:ca60:6957:cd88:1852:9438])
        by smtp.gmail.com with ESMTPSA id l13-20020a62be0d000000b0051ba90d55acsm257077pff.207.2022.06.10.19.44.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 19:44:57 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     chiyutianyi@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        l.s.r@web.de, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>
Subject: [PATCH v15 5/6] core doc: modernize core.bigFileThreshold documentation
Date:   Sat, 11 Jun 2022 10:44:20 +0800
Message-Id: <61ae1c1632582ba1cfd9e15e375c57fdb3f559af.1654914555.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654914555.git.chiyutianyi@gmail.com>
References: <cover.1654871915.git.chiyutianyi@gmail.com> <cover.1654914555.git.chiyutianyi@gmail.com>
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
index 41e330f306..87e4c04836 100644
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
+The default limit is primarily set with this use-case in mind. With it,
+most projects will have their source code and other text files delta
+compressed, but not larger binary media files.
++
+Storing large files without delta compression avoids excessive memory
+usage, at the slight expense of increased disk usage.
++
+* Will be treated as if they were labeled "binary" (see
+  linkgit:gitattributes[5]). e.g. linkgit:git-log[1] and
+  linkgit:git-diff[1] will not compute diffs for files above this limit.
++
+* Will generally be streamed when written, which avoids excessive
+memory usage, at the cost of some fixed overhead. Commands that make
+use of this include linkgit:git-archive[1],
+linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
+linkgit:git-fsck[1].
 
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
-- 
2.36.1

