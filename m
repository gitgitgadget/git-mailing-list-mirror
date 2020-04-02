Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97344C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 02:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C37320675
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 02:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRLIIZEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbgDBCCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:02:31 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:55344 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgDBCCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 22:02:31 -0400
Received: by mail-wm1-f41.google.com with SMTP id r16so1732907wmg.5
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 19:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=R8jy4WCzF2jjbQ6LGNuPIuU37z6/40Pegm3dML6IzXU=;
        b=cRLIIZEa5hJfWX95+c9XdKPh9h+FhP8+KS+uCn7QM91sPENFdOVxWIaV7OwEl01caX
         CdEKzzxvLqiIReyCbbjJc+w0zD19CG1XoSrIOHsNC/UZgl6KnV8bPZiledZS/S+CiVNI
         +BYjjwDOct+jv77uu/Kl8oAAtrUzOcGRivcWyVLwKSN+ABQyhjJKBrmiOQu4qFQbOCMH
         dvI0Q5MlMhw5v3OC7a95NkR9uRpeJOSZRpOOt4e7T6iImc2jRHCYPCAgohLdneCvMwwl
         GJvN74krKrBK7pgiyfQAgRw1owwVlf+W7/xC59sA0tIKrgLWpYHMyRVdwHNgqKy3GvuD
         jpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R8jy4WCzF2jjbQ6LGNuPIuU37z6/40Pegm3dML6IzXU=;
        b=ZNt+zNzyFh5qXnWPlCwFiT5NBUBJ4nTXIUvcOOsUVQC8tTi6R3srpE7Qs2MM7FlIQC
         hsAfPO2W0UEkSpjNF8sQ45zA/zwZ1MKBS2OHBT9IyG/QDijjHukU80R4I5WqDGY1S4Ll
         mV0YT0vJomhiAgsVY39KjIPxWGxJQYXAoSalUqQva+3ht8Lsz7X1AdG6ccssAS+T2juV
         R8G1CEdCJz7EDiSpOX42WBeaEwcdak8CD3VDk/2ecHUayt/LUEazqn3teGLvB/02q+GJ
         KC64gPBsPqbrlIh0xa7Kr3ZkRWi2ovmoY9/kQePetvgiA0AsmEVZzwDuw0PHXjtA6EdK
         Abfw==
X-Gm-Message-State: AGi0PuZ3gwWYPYao7QrpOlWjg3nAtU8UHNs+mSprWD4LcfZjj0w6s0rN
        OT0bkniSIHbyiTUOgtUXuze7RTg5
X-Google-Smtp-Source: APiQypJ+Dqv2y1vmxbfHSflfS8PRzO/+kx+0TtHBDJ5IO/eVRLfypIHHYYVA6xE5wMZZnmkcklUc4w==
X-Received: by 2002:a1c:9652:: with SMTP id y79mr879157wmd.89.1585792947556;
        Wed, 01 Apr 2020 19:02:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm5639332wrb.4.2020.04.01.19.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 19:02:26 -0700 (PDT)
Message-Id: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
From:   "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Apr 2020 02:02:26 +0000
Subject: [PATCH] clone: document partial clone section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Dyrone Teng <dyroneteng@gmail.com>
Sender: git-owner@vger.kernel.org
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v1
Pull-Request: https://github.com/git/git/pull/745

 Documentation/git-clone.txt | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bf24f1813ad..dd92d153535 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -297,6 +297,75 @@ or `--mirror` is given)
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
 

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
