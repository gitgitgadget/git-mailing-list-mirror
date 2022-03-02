Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D4C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiCBA6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbiCBA6p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:58:45 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3403D483
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:02 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c14so39726ioa.12
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U57WZotEOCKfboIeqgCsQcTnM0wsgdqmIpBbD+9WI7g=;
        b=UHmlSWD6alRVXQbCxXM2ytsTEiy2cglCF63oZ/+SLo8PzaweYOHNYxrFwgYVaj1gKs
         7P4ftzbuuTAdSXSCfzjzjszDRoYObihhxIAcUV0k9JQuXg9n7jo4peYwYVhBdi4BxZOR
         TdecJhyT+sn1RA2wG4RSkR6TnwI4NyJEV50XqJzjoCxvVV6uprGAYIxllB1Q2SFLlu3F
         mIND1EWXJfjVlfqOSZm0vx94rAUTclpR7Ds/9y3mHSlSlDu+Mt1dWXbVmCCp7Ataahi5
         Jz4IhIwbveDO0SpwliEIhCVQSlfOFbW9lUEGdm67Nrog68Bhg/2opGxtn8XGSFcyjiID
         PrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U57WZotEOCKfboIeqgCsQcTnM0wsgdqmIpBbD+9WI7g=;
        b=r4VQ0jsy4QJbbC8mXSDTiIGyEWYc6stBq2woDEmsxNvMJXeJm/SK7xlae2faDypb+9
         LOzf0B+5OMUN+yNkljLdY4BcExjx41VyOEgfv0Yi9ldO6OXcURigKvLKnsdLUJ9Dnz3i
         071tERv3/t4zfHwUzMZ5zXjNJjsFqBp9oMhZwzYeBAXxgBbhjQXIZMKrSVLxY3zvoysO
         QKtFmyaaZaFqomx3w7wUw3xQE5zAeRxbt5wXGMMWSeA+8EemxxtcfucU4B1Zo4Jg9S85
         l8JxvTdjeyHIkHhHaime0Dy5rv76rxaYJYMpi4dikQQ6r3kTESr9fVXhFTa99+OZJtok
         1R5Q==
X-Gm-Message-State: AOAM53018l0h18/PFIyo7IKToVdcv1lpw7igbreSMZtLBIQcqok6CyGq
        kd2WCzIYW0S45P5cKmdiA7ftfOaKUU3uxms8
X-Google-Smtp-Source: ABdhPJzZ8qL3gf3fT3t1OHCfw38aea2R9/5HWnyoVq80c5DkZCHrilCNiG+1lfi8Z6jyJvKx5imC4w==
X-Received: by 2002:a5d:8714:0:b0:636:13bb:bc89 with SMTP id u20-20020a5d8714000000b0063613bbbc89mr20834822iom.126.1646182681342;
        Tue, 01 Mar 2022 16:58:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm8757506ilh.70.2022.03.01.16.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:01 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a technical document to explain cruft packs. It contains a brief
overview of the problem, some background, details on the implementation,
and a couple of alternative approaches not considered here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/Makefile                  |  1 +
 Documentation/technical/cruft-packs.txt | 97 +++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/technical/cruft-packs.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae..0b01c9408e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -91,6 +91,7 @@ TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += technical/bundle-format
+TECH_DOCS += technical/cruft-packs
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
diff --git a/Documentation/technical/cruft-packs.txt b/Documentation/technical/cruft-packs.txt
new file mode 100644
index 0000000000..2c3c5d93f8
--- /dev/null
+++ b/Documentation/technical/cruft-packs.txt
@@ -0,0 +1,97 @@
+= Cruft packs
+
+The cruft packs feature offer an alternative to Git's traditional mechanism of
+removing unreachable objects. This document provides an overview of Git's
+pruning mechanism, and how a cruft pack can be used instead to accomplish the
+same.
+
+== Background
+
+To remove unreachable objects from your repository, Git offers `git repack -Ad`
+(see linkgit:git-repack[1]). Quoting from the documentation:
+
+[quote]
+[...] unreachable objects in a previous pack become loose, unpacked objects,
+instead of being left in the old pack. [...] loose unreachable objects will be
+pruned according to normal expiry rules with the next 'git gc' invocation.
+
+Unreachable objects aren't removed immediately, since doing so could race with
+an incoming push which may reference an object which is about to be deleted.
+Instead, those unreachable objects are stored as loose object and stay that way
+until they are older than the expiration window, at which point they are removed
+by linkgit:git-prune[1].
+
+Git must store these unreachable objects loose in order to keep track of their
+per-object mtimes. If these unreachable objects were written into one big pack,
+then either freshening that pack (because an object contained within it was
+re-written) or creating a new pack of unreachable objects would cause the pack's
+mtime to get updated, and the objects within it would never leave the expiration
+window. Instead, objects are stored loose in order to keep track of the
+individual object mtimes and avoid a situation where all cruft objects are
+freshened at once.
+
+This can lead to undesirable situations when a repository contains many
+unreachable objects which have not yet left the grace period. Having large
+directories in the shards of `.git/objects` can lead to decreased performance in
+the repository. But given enough unreachable objects, this can lead to inode
+starvation and degrade the performance of the whole system. Since we
+can never pack those objects, these repositories often take up a large amount of
+disk space, since we can only zlib compress them, but not store them in delta
+chains.
+
+== Cruft packs
+
+A cruft pack eliminates the need for storing unreachable objects in a loose
+state by including the per-object mtimes in a separate file alongside a single
+pack containing all loose objects.
+
+A cruft pack is written by `git repack --cruft` when generating a new pack.
+linkgit:git-pack-objects[1]'s `--cruft` option. Note that `git repack --cruft`
+is a classic all-into-one repack, meaning that everything in the resulting pack is
+reachable, and everything else is unreachable. Once written, the `--cruft`
+option instructs `git repack` to generate another pack containing only objects
+not packed in the previous step (which equates to packing all unreachable
+objects together). This progresses as follows:
+
+  1. Enumerate every object, marking any object which is (a) not contained in a
+     kept-pack, and (b) whose mtime is within the grace period as a traversal
+     tip.
+
+  2. Perform a reachability traversal based on the tips gathered in the previous
+     step, adding every object along the way to the pack.
+
+  3. Write the pack out, along with a `.mtimes` file that records the per-object
+     timestamps.
+
+This mode is invoked internally by linkgit:git-repack[1] when instructed to
+write a cruft pack. Crucially, the set of in-core kept packs is exactly the set
+of packs which will not be deleted by the repack; in other words, they contain
+all of the repository's reachable objects.
+
+When a repository already has a cruft pack, `git repack --cruft` typically only
+adds objects to it. An exception to this is when `git repack` is given the
+`--cruft-expiration` option, which allows the generated cruft pack to omit
+expired objects instead of waiting for linkgit:git-gc[1] to expire those objects
+later on.
+
+It is linkgit:git-gc[1] that is typically responsible for removing expired
+unreachable objects.
+
+== Alternatives
+
+Notable alternatives to this design include:
+
+  - The location of the per-object mtime data, and
+  - Storing unreachable objects in multiple cruft packs.
+
+On the location of mtime data, a new auxiliary file tied to the pack was chosen
+to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
+support for optional chunks of data, it may make sense to consolidate the
+`.mtimes` format into the `.idx` itself.
+
+Storing unreachable objects among multiple cruft packs (e.g., creating a new
+cruft pack during each repacking operation including only unreachable objects
+which aren't already stored in an earlier cruft pack) is significantly more
+complicated to construct, and so aren't pursued here. The obvious drawback to
+the current implementation is that the entire cruft pack must be re-written from
+scratch.
-- 
2.35.1.73.gccc5557600

