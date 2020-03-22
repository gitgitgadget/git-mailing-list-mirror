Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E693C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D0120719
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exB/Jk1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVTuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:50:10 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44113 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCVTuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 15:50:10 -0400
Received: by mail-ed1-f54.google.com with SMTP id z3so13876153edq.11
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/TCqx1vx+4dBVTIZi91U7HyiDIF7gAW5055PVGCPXW8=;
        b=exB/Jk1MEtvoXjSfo3C8Xg6sebcX8r+MwkF8uSVeZva4cumW6N1kYM8n1VtM3ZMGYP
         uJ1iJleFi9y19rG8eUen4Am+qIlE3CZ1mibYwWJMi2Q9cR5fMahSBVk2q8OT7LVJQ15g
         9hSWxieT1rXDeryCvOmMOSRbynMOx12FgtQRZaqo1KNLsYTFM/SwcvxDtf0Bgz8zdhfi
         UcjmnWMFaWxUPTh+kjTRDBAirXdDkfMS+H5C6swisHPu5TUJ34jORZqVy6ZJjt3lgCeG
         0dyJ08Bm5ILBo5o836tuFYtXJYyZUP4F+bBBzi3YHpNybUCcb6enhS8YsEK4jBpP8Oy3
         6Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/TCqx1vx+4dBVTIZi91U7HyiDIF7gAW5055PVGCPXW8=;
        b=L3hw07yfSz8ddIwIs/eX3Ebe+YbLop0gis8sWdq8WUXivbOo8YSM3m8OouDaWfgV0H
         ieeZmkfPJhwyY0uTBticGNwnBH+gLgiBFTdAh5sZfqi6tcmxkYyXD1bnQ982WRpjsMBL
         UhPoFOTsoY1noiD30ATDtXNohcSVF2ZMCWKodVXs6Ge60sbP+O7wrOsiiA7qseUd/eOw
         /mfO8wYp2LaTP/aw3BD8ymwoUWTd6h2UsWHPqKK+yhkhDizWb9AXxEy72CX2hpCmMtHe
         f78bBsAwNnMAiqaP+R6HbcmDYElT++VGG1KRdEMhhXskwS0zn32LaLTyO6gQAujWsfKg
         uU/w==
X-Gm-Message-State: ANhLgQ2T5YtnSADWBWEaklWFkYecdNACAqgsZaD+k6TuLc/16/unALBV
        o1dVJQi0GwL7f+0u0uM4KKHwXu/x
X-Google-Smtp-Source: ADFU+vtWVH++uyq1KyAkmj3U1/0ntWJxCqbKge8LCZrWSf9yZLd3+8oDbJ7hCTm4dCT4C0HIPWqm/A==
X-Received: by 2002:a17:906:1993:: with SMTP id g19mr16213239ejd.264.1584906607714;
        Sun, 22 Mar 2020 12:50:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm203706edx.87.2020.03.22.12.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 12:50:07 -0700 (PDT)
Message-Id: <pull.586.v2.git.1584906606469.gitgitgadget@gmail.com>
In-Reply-To: <pull.586.git.1584638887.gitgitgadget@gmail.com>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Mar 2020 19:50:06 +0000
Subject: [PATCH v2] clone: document --filter options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It turns out that the "--filter=<filter-spec>" option is not
documented anywhere in the "git clone" page, and instead is
detailed carefully in "git rev-list" where it serves a
different purpose.

Add a small bit about this option in the documentation. It
would be worth some time to create a subsection in the "git clone"
documentation about partial clone as a concept and how it can be
a surprising experience. For example, "git checkout" will likely
trigger a pack download.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    Slightly simplify partial clone user experience
    
    V2: Only update the documentation of --filter.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-586%2Fderrickstolee%2Fpartial-clone-ux-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-586/derrickstolee/partial-clone-ux-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/586

Range-diff vs v1:

 1:  6f340d9aadf < -:  ----------- partial-clone: set default filter with --partial
 2:  9baf4c8ba38 ! 1:  a55c2d975ab clone: document --partial and --filter options
     @@ -1,16 +1,13 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    clone: document --partial and --filter options
     +    clone: document --filter options
      
     -    The previous change added the "--partial[=<size>]" option to
     -    "git clone" equivalent to "--filter=blob:none" or
     -    "--filter=blob:limit=<size>" but did not document that addition.
     -    It turns out that the "--filter=<filter-spec>" option was not
     +    It turns out that the "--filter=<filter-spec>" option is not
          documented anywhere in the "git clone" page, and instead is
          detailed carefully in "git rev-list" where it serves a
          different purpose.
      
     -    Add a small bit about these options in the documentation. It
     +    Add a small bit about this option in the documentation. It
          would be worth some time to create a subsection in the "git clone"
          documentation about partial clone as a concept and how it can be
          a surprising experience. For example, "git checkout" will likely
     @@ -27,7 +24,7 @@
       	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
      -	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
      +	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
     -+	  [--partial[=<size>]|--filter=<filter>] [--] <repository>
     ++	  [--filter=<filter>] [--] <repository>
       	  [<directory>]
       
       DESCRIPTION
     @@ -35,17 +32,15 @@
       	of the repository. The sparse-checkout file can be
       	modified to grow the working directory as needed.
       
     -+--partial[=<size>]::
      +--filter=<filter-spec>::
      +	Use the partial clone feature and request that the server sends
      +	a subset of reachable objects according to a given object filter.
      +	When using `--filter`, the supplied `<filter-spec>` is used for
     -+	the partial clone filter. When using `--partial` with no `<size>`,
     -+	the `blob:none` filter is applied to filter all blobs. When using
     -+	`--partial=<size>` the `blob:limit=<size>` filter is applied to
     -+	filter all blobs with size larger than `<size>`. For more details
     -+	on filter specifications, see the `--filter` option in
     -+	linkgit:git-rev-list[1].
     ++	the partial clone filter. For example, `--filter=blob:none` will
     ++	filter out all blobs (file contents) until needed by Git. Also,
     ++	`--filter=blob:limit=<size>` will filter out all blobs of size
     ++	at least `<size>`. For more details on filter specifications, see
     ++	the `--filter` option in linkgit:git-rev-list[1].
      +
       --mirror::
       	Set up a mirror of the source repository.  This implies `--bare`.


 Documentation/git-clone.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bf24f1813ad..08d6045c4a8 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
+	  [--filter=<filter>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -162,6 +163,16 @@ objects from the source repository into a pack in the cloned repository.
 	of the repository. The sparse-checkout file can be
 	modified to grow the working directory as needed.
 
+--filter=<filter-spec>::
+	Use the partial clone feature and request that the server sends
+	a subset of reachable objects according to a given object filter.
+	When using `--filter`, the supplied `<filter-spec>` is used for
+	the partial clone filter. For example, `--filter=blob:none` will
+	filter out all blobs (file contents) until needed by Git. Also,
+	`--filter=blob:limit=<size>` will filter out all blobs of size
+	at least `<size>`. For more details on filter specifications, see
+	the `--filter` option in linkgit:git-rev-list[1].
+
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the

base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
-- 
gitgitgadget
