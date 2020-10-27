Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31FC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 03:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8213320872
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 03:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cERVnlOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444598AbgJ0DMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 23:12:06 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34921 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443814AbgJ0DMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 23:12:06 -0400
Received: by mail-wm1-f43.google.com with SMTP id h22so169836wmb.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 20:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7hp6mh8TmfqQIzR44rQzSn7343sSB+CqFX9Xm3cSdQ8=;
        b=cERVnlOP1CHtRg0dMfb3m1zcUCHavp+x3sC4uKj9c+N4duotqDO7UmuY54+mWc8zjl
         bXFGcJdRoptAkmfWssT+9yYI6EbPDMzg2icfWhN7NuLIFyBjRrP2asYmGbYjEGoLB9D+
         zQB63XthsUbystaKYi9VbPXLkUndIA935398VMPUpUpRvCbAhkdo9TUS4cIpLGs1CDTA
         Ye5FPea5fQHQHsBm1Pi4sDnCpNznSBqPmVFILvf9LMhUUbdNoYp5sKd0eoT456bP7TNo
         N162eGZ4PVhI1NNmtt1rduXxQdvljbS2Yp+BZqDIUwsXARpIIpcnVO6deV/9XNS/BOp0
         Ho9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7hp6mh8TmfqQIzR44rQzSn7343sSB+CqFX9Xm3cSdQ8=;
        b=OxOp/vVhsNH+ghj9c5rCOf/s8rAZg4rtE+QAE7See7IL10TQqH/o3cz/Nj8MnVT7Ll
         jGBsoGiKiXUkh1vMqXt32MvqZx996mxcwwYDSGQAro5adMUglaI54Ikes+ZUcsOq6FDJ
         6cuDKHcGDFXZjQ0U1BVL5Rioe6AoMZ0VMxasd9rfRLTpZsNza6qwnCCRWNjpCPEyTJTp
         /Ypz1Sei7+78Y1eocY56+dlvqJYkGJjBpmlz4+vwJGVLPon652c1y5ltmbjfbFBXR1BC
         9A1JM7LinX6zxPr84UWgZ2/88An5UiwF/Fh7Zfo5Ex+ZKQRXENkY1zXFpCWHglySGjfw
         RD3g==
X-Gm-Message-State: AOAM533O+Co8yaQkoMdxDpwNt9qM+kvuBBI0vcRHtG6fPRFHEcJ2b2M/
        Z78d8ijgawh83CCOWjJMJ7FMUp2fb2U=
X-Google-Smtp-Source: ABdhPJytQZgqqg/9Q8+TvM3zpTuFPUVQJVYALMLz+RlrJ+to715GPk0Ys5CV6VzCqe3lEj/EYedufQ==
X-Received: by 2002:a7b:cf15:: with SMTP id l21mr274993wmg.3.1603768322702;
        Mon, 26 Oct 2020 20:12:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d129sm231248wmd.5.2020.10.26.20.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 20:12:02 -0700 (PDT)
Message-Id: <pull.745.v3.git.git.1603768321361.gitgitgadget@gmail.com>
In-Reply-To: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
References: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
From:   "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 03:12:01 +0000
Subject: [PATCH v3] clone: document partial clone section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Dyrone Teng <dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dyrone Teng <dyroneteng@gmail.com>

Partial clones are created using 'git clone', but there is no related
help information in the git-clone documentation during a period. Add
a relevant section to help users understand what partial clones are
and how they differ from normal clones.

The section briefly introduces the applicable scenarios and some
precautions of partial clone. If users want to know more about its
technical design and other details, users can view the link of
git-partial-clone(7) according to the guidelines in the section.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
    clone: document partial clone section
    
    Partial clones are created using 'git clone', but there is no related
    help information in the git-clone documentation during a period. Add a
    relevant section to help users understand what partial clones are and
    how they differ from normal clones.
    
    The section briefly introduces the applicable scenarios and some
    precautions of partial clone. If users want to know more about its
    technical design and other details, users can view the link of
    git-partial-clone(7) according to the guidelines in the section.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v3
Pull-Request: https://github.com/git/git/pull/745

Range-diff vs v2:

 1:  6f340d9aad < -:  ---------- partial-clone: set default filter with --partial
 2:  9baf4c8ba3 < -:  ---------- clone: document --partial and --filter options
 3:  c1a44a3509 ! 1:  681c5dcb79 clone: document partial clone section
     @@ Commit message
          clone: document partial clone section
      
          Partial clones are created using 'git clone', but there is no related
     -    help information in the git-clone documentation. Add a relevant section
     -    to help users understand what partial clones are and how they differ
     -    from normal clones.
     +    help information in the git-clone documentation during a period. Add
     +    a relevant section to help users understand what partial clones are
     +    and how they differ from normal clones.
      
          The section briefly introduces the applicable scenarios and some
          precautions of partial clone. If users want to know more about its
          technical design and other details, users can view the link of
          git-partial-clone(7) according to the guidelines in the section.
      
     -    Signed-off-by: Dyrone Teng <dyroneteng@gmail.com>
     +    Signed-off-by: Teng Long <dyroneteng@gmail.com>
      
       ## Documentation/git-clone.txt ##
      @@ Documentation/git-clone.txt: or `--mirror` is given)
     @@ Documentation/git-clone.txt: or `--mirror` is given)
      +-------------
      +
      +By default, `git clone` will download every reachable object, including
     -+every version of every file in the history of the repository. The
     -+**partial clone** feature allows Git to transfer fewer objects and
     -+request them from the remote only when they are needed, so some
     -+reachable objects can be omitted from the initial `git clone` and
     -+subsequent `git fetch` operations.
     ++every version of every file in the history of the repository. The **partial clone**
     ++feature allows Git to transfer fewer objects and request them from the
     ++remote only when they are needed, so some reachable objects can be
     ++omitted from the initial `git clone` and subsequent `git fetch`
     ++operations. In this way, a partial clone can reduce the network traffic
     ++costs and disk space usage when git is working under a large repository.
      +
      +To use the partial clone feature, you can run `git clone` with the 
     -+`--filter=<filter-spec>` option. If you want to clone a repository
     -+without download any blobs, the form `filter=blob:none` will omit all
     -+the blobs. If the repository has some large blobs and you want to
     -+prevent some large blobs being downloaded by an appropriate threshold,
     -+the form `--filter=blob:limit=<n>[kmg]`omits blobs larger than n bytes
     -+or units (see linkgit:git-rev-list[1]).
     ++`--filter=<filter-spec>` option. If the repository has a deep history
     ++and you don't want to download any blobs, the form `filter=blob:none`
     ++will omit all the blobs. If the repository has some large blobs and you
     ++want to prevent some large blobs being downloaded by an appropriate
     ++threshold, the form `--filter=blob:limit=<n>[kmg]` omits blobs larger
     ++than n bytes or units (see linkgit:git-rev-list[1]).
      +
     -+As mentioned before, a partially cloned repository may have to request
     -+the missing objects when they are needed. So some 'local' commands may
     -+fail without a network connection to the remote repository.
     ++When using a partial clone, Git will request missing objects from the
     ++remote(s) when necessary. Several commands that do not involve a request
     ++over a network may now trigger these requests.
      +
      +For example, The <repository> contains two branches which names 'master'
      +and 'topic. Then, we clone the repository by
     @@ Documentation/git-clone.txt: or `--mirror` is given)
      +were downloaded previously.
      +
      +`git log` may also make a surprise with partial clones. `git log
     -+-- <pathspec>` will not cause downloads with the blob filters, because
     -+it's only reading commits and trees. In addition to any options that
     -+require git to look at the contents of blobs, like "-p" and "--stat"
     -+, options that cause git to report pathnames, like "--summary" and
     -+"--raw", will trigger lazy/on-demand fetching of blobs, as they are
     -+needed to detect inexact renames.
     -+
     -+linkgit:partial-clone[1]
     ++--<path>` will not cause downloads with the blob filters, because it's
     ++only reading commits. `git log -p -- <path>` will download blobs to
     ++generate the patch output and git log --raw will download all blobs
     ++that changed at recent commits in order to compute renames.
      +
       :git-clone: 1
       include::urls.txt[]


 Documentation/git-clone.txt | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c898310099..15495675a8 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -308,6 +308,75 @@ or `--mirror` is given)
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
+Partial Clone
+-------------
+
+By default, `git clone` will download every reachable object, including
+every version of every file in the history of the repository. The **partial clone**
+feature allows Git to transfer fewer objects and request them from the
+remote only when they are needed, so some reachable objects can be
+omitted from the initial `git clone` and subsequent `git fetch`
+operations. In this way, a partial clone can reduce the network traffic
+costs and disk space usage when git is working under a large repository.
+
+To use the partial clone feature, you can run `git clone` with the 
+`--filter=<filter-spec>` option. If the repository has a deep history
+and you don't want to download any blobs, the form `filter=blob:none`
+will omit all the blobs. If the repository has some large blobs and you
+want to prevent some large blobs being downloaded by an appropriate
+threshold, the form `--filter=blob:limit=<n>[kmg]` omits blobs larger
+than n bytes or units (see linkgit:git-rev-list[1]).
+
+When using a partial clone, Git will request missing objects from the
+remote(s) when necessary. Several commands that do not involve a request
+over a network may now trigger these requests.
+
+For example, The <repository> contains two branches which names 'master'
+and 'topic. Then, we clone the repository by
+
+    $ git clone --filter=blob:none --no-checkout <repository>
+
+With the `--filter=blob:none` option Git will omit all the blobs and
+the `--no-checkout` option Git will not perform a checkout of HEAD
+after the clone is complete. Then, we check out the remote tracking
+'topic' branch by
+
+    $ git checkout -b topic origin/topic 
+
+The output looks like
+
+------------
+    remote: Enumerating objects: 1, done.
+    remote: Counting objects: 100% (1/1), done.
+    remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
+    Receiving objects: 100% (1/1), 43 bytes | 43.00 KiB/s, done.
+    Branch 'topic' set up to track remote branch 'topic' from 'origin'.
+    Switched to a new branch 'topic'
+------------
+
+The output is a bit surprising but it shows how partial clone works.
+When we check out the branch 'topic' Git will request the missing blobs
+because they are needed. Then, We can switch back to branch 'master' by
+
+    $ git checkout master
+
+This time the output looks like
+
+------------
+    Switched to branch 'master'
+    Your branch is up to date with 'origin/master'.
+------------
+
+It shows that when we switch back to the previous location, the checkout
+is done without a download because the repository has all the blobs that
+were downloaded previously.
+
+`git log` may also make a surprise with partial clones. `git log
+--<path>` will not cause downloads with the blob filters, because it's
+only reading commits. `git log -p -- <path>` will download blobs to
+generate the patch output and git log --raw will download all blobs
+that changed at recent commits in order to compute renames.
+
 :git-clone: 1
 include::urls.txt[]
 

base-commit: e1cfff676549cdcd702cbac105468723ef2722f4
-- 
gitgitgadget
