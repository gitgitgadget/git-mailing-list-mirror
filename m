Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C211BC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D1D61184
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhHYCXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbhHYCXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64AC061796
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so3122614pjw.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2AAyi3xdKM2quMoj/wE8DktKqVER/T+ZtH6I+HstiU=;
        b=lxarbMWWF2kIwrMh1LtY4n3NRoUFDpuTZS8k8TnElDgeAOjJr3j+pFv9U3uFWUyZbJ
         MYiNy6gzqbNPGe0iWWGqf23OAmPHGI5qHTtPQHa4Nr9g1AB+J5wnoH9yC3xTe9Lq3mGY
         9hzTn9MzVheD5a9oWHjp5zW+O408SbbpIPUsI3kMmncL5fmgth81O/rOSM/lfnGCJrBD
         7LipEqZYAkxXNbEjOljVtoIJqpTCMecx5HyfulUDhJ6nCBzQWv+BEErfOXC8KB5UL7aZ
         AKYYK+7f9UaESTMZupcIhh9EWKiZKm/7fcV/6/vB6D5U4ide5J3zLKtBVUmI+KXVb6jp
         6zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2AAyi3xdKM2quMoj/wE8DktKqVER/T+ZtH6I+HstiU=;
        b=BuO3E9fmjTQ9pEnXRZmqwAlDSvMivRhO+Iq7ZFOG9GLdNKx4ljWpw+ugdRYvTGk73d
         fBQAmBJ8QahPpNtgTpLOkU+lS/mg4TyZ2GkQ8nKxFxG+suFzyQllo/XQlSN4Bw0EWEnY
         FhxiuN9pMI/uFLvG2I6ArFIlxzvfH1Sx+EfPNVSWdNQQWzKbRKRu/u1IQ9eWWByhdtEl
         wFwzHZkP/4piHy9LEgP6wk18Bs++Ss4yqwBZtHOWwXY1aeCzeAnJ580eMO0AX66e+42e
         ArLsmJaj1fWZSc+G/QD9vAMkrgQneVi4yjUap7/h7sly+zS7nuN2QuJ56razOWZtJSal
         lbgg==
X-Gm-Message-State: AOAM531eAvxJlNUspSHn6245JdaNW6mltYGT0PjysxKJRG2OFL+IFKg/
        TmY9FyQGBqWLMG1LXkBBYmI=
X-Google-Smtp-Source: ABdhPJy5BuUVmLBg/5puTgTNAz+CF8zDP5JNsTz2YWqMXMz/Lg7N+K0+MspKjAmi1HfeqEsjBH0RIQ==
X-Received: by 2002:a17:902:dcca:b0:12d:7f02:f6a2 with SMTP id t10-20020a170902dcca00b0012d7f02f6a2mr35982039pll.7.1629858139844;
        Tue, 24 Aug 2021 19:22:19 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 05/14] packfile-uri.txt: support for excluding commits and trees
Date:   Wed, 25 Aug 2021 10:21:49 +0800
Message-Id: <8e5bf4010cb0d7e8b4f6c7285fe1f5365af955e8.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 32 ++++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..c3e4873956 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -35,13 +35,26 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
 at least so that we can test the client.
 
 This is the implementation: a feature, marked experimental, that allows the
-server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
-<uri>` entries. Whenever the list of objects to be sent is assembled, all such
-blobs are excluded, replaced with URIs. As noted in "Future work" below, the
-server can evolve in the future to support excluding other objects (or other
-implementations of servers could be made that support excluding other objects)
-without needing a protocol change, so clients should not expect that packfiles
-downloaded in this way only contain single blobs.
+server to be configured by one or more entries with the format:
+
+    uploadpack.excludeobject=<object-hash> <pack-hash> <uri>
+
+Value <object-hash> is the key of entry, and the object type can be a blob,
+tree, or commit. The exclusion of tree and commit is recursive by default,
+which means that when a tree or commit object is excluded, the object itself
+and all reachable objects of the object will be excluded recursively. Whenever
+the list of objects to be sent is assembled, all such objects are excluded,
+replaced with URIs.
+
+Configuration compatibility
+-------------
+
+The old configuration of packfile-uri:
+
+	`uploadpack.blobPackfileUri=<object-hash> <pack-hash> <uri>`
+
+For the old configuration is compatible with the new one, but it only
+supports the exclusion of blob objects.
 
 Client design
 -------------
@@ -65,9 +78,6 @@ The protocol design allows some evolution of the server and client without any
 need for protocol changes, so only a small-scoped design is included here to
 form the MVP. For example, the following can be done:
 
- * On the server, more sophisticated means of excluding objects (e.g. by
-   specifying a commit to represent that commit and all objects that it
-   references).
  * On the client, resumption of clone. If a clone is interrupted, information
    could be recorded in the repository's config and a "clone-resume" command
    can resume the clone in progress. (Resumption of subsequent fetches is more
@@ -78,4 +88,4 @@ There are some possible features that will require a change in protocol:
 
  * Additional HTTP headers (e.g. authentication)
  * Byte range support
- * Different file formats referenced by URIs (e.g. raw object)
+ * Different file formats referenced by URIs (e.g. raw object)
\ No newline at end of file
-- 
2.31.1.456.gec51e24953

