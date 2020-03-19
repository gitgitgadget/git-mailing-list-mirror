Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EC2C43332
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE232080C
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moznrKe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgCSR2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:28:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32768 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSR2M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:28:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id z65so3765707ede.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qzcMJa+mkLK1M0dyKPSed4/B6s0GK+ogulNk4HwyAQY=;
        b=moznrKe0odV/JRDr5831nv8nmeIcCCt3kw0hP2fSQq9jZvqImx8hsPeplIEKvfqOMu
         j83XLXgLsgFoJs4TR98JLywbawpC/jFgNEKMZk4GC5TkuQFl/ZdfGo5FsIJ4MSvCrsw2
         2GH8WlW1Eytzx0bQ2SLJUz9wrsAZ/fiyrgeTaAYBrDWs1LYqDoff5jrm+wrHl0JL7Hk8
         ++4Bspx3k2AcYI6txfipGVrNTm/lDu07jIyXCSV97BJCY7rN3hyjhKTrfVaRmNg4PZq5
         9I0r2qlC68VFzizHKnCusfZWU+B/Ul8UORXg1PrFfeHrqtdaia3W9JOXf4t1OppV235l
         P4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qzcMJa+mkLK1M0dyKPSed4/B6s0GK+ogulNk4HwyAQY=;
        b=b8HO7fLs6meJQtY8p4nqD/rIkxOUdMHxY1Ji0Bn0AkDkmbaZDBSXmSHM19lrnujxOS
         t9XKdHGVWlU92GSEULsoTDezaGqx8LH9Amv4BXdL715gWKBBbHqW6mo6Nsq10k+Wqrhi
         baW+tj07wZk7pa/YZjqRquj+mi9QMwnWG+ezrnPNwbaiQkZU8H6DMCTpp7YjT/wnMtKd
         vy3x3QDiJPOg0tPFVbUKHnul+nz4I96gb2y9qYl5MGcrF2NAiWHl1CFjhC5SEtA12WPX
         om4+GOZeF2Crg34raLgUHswX3TNx1+pIARNWzk7I+BQqd0XTKANVhz9O5E/E7TsgJAvA
         Xmxw==
X-Gm-Message-State: ANhLgQ3TKOXv3i2qNg/u9S66I+Fe5InpsfKBDXxCyT5AsDLey+2PD8G2
        JzeKudZjHblOL+sELxXll9j4c5bl
X-Google-Smtp-Source: ADFU+vu91z+hG69dkvn5pX9nD/6dZjNERDskgr00IkSZnnZx2AHqrg0n3O/sCd/CMUI4oCkaR2cLxg==
X-Received: by 2002:a05:6402:1584:: with SMTP id c4mr3901587edv.272.1584638889771;
        Thu, 19 Mar 2020 10:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gv4sm181154ejb.15.2020.03.19.10.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:28:09 -0700 (PDT)
Message-Id: <9baf4c8ba383414e41d3d7726cf40c39cbf197e7.1584638887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.586.git.1584638887.gitgitgadget@gmail.com>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Mar 2020 17:28:07 +0000
Subject: [PATCH 2/2] clone: document --partial and --filter options
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

The previous change added the "--partial[=<size>]" option to
"git clone" equivalent to "--filter=blob:none" or
"--filter=blob:limit=<size>" but did not document that addition.
It turns out that the "--filter=<filter-spec>" option was not
documented anywhere in the "git clone" page, and instead is
detailed carefully in "git rev-list" where it serves a
different purpose.

Add a small bit about these options in the documentation. It
would be worth some time to create a subsection in the "git clone"
documentation about partial clone as a concept and how it can be
a surprising experience. For example, "git checkout" will likely
trigger a pack download.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-clone.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bf24f1813ad..eafa1c39927 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
+	  [--partial[=<size>]|--filter=<filter>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -162,6 +163,18 @@ objects from the source repository into a pack in the cloned repository.
 	of the repository. The sparse-checkout file can be
 	modified to grow the working directory as needed.
 
+--partial[=<size>]::
+--filter=<filter-spec>::
+	Use the partial clone feature and request that the server sends
+	a subset of reachable objects according to a given object filter.
+	When using `--filter`, the supplied `<filter-spec>` is used for
+	the partial clone filter. When using `--partial` with no `<size>`,
+	the `blob:none` filter is applied to filter all blobs. When using
+	`--partial=<size>` the `blob:limit=<size>` filter is applied to
+	filter all blobs with size larger than `<size>`. For more details
+	on filter specifications, see the `--filter` option in
+	linkgit:git-rev-list[1].
+
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
-- 
gitgitgadget
