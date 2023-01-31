Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B3C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjAaN3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjAaN3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302ED4FC2C
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so14177658wrz.12
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNFrRUzAOuNSF8t1leDfh9Tj6xawIPV4QkdV6yQMg+U=;
        b=hIIgwIq6bU6jZQVNwfZpe6RSRro0spxzWbi198oNJI09x9up8UtB0FzBHIGWZF+ZHN
         zfHRrtAn8IONMsYW7o14oUpLMRbT+Xi7tx/JIMR2lqPiVNtb4mAj5QL7oDvxDZ28UaKs
         sEK1ahEqlmkYg3LeS8yxGGkifcLdJXzlFF7TUdti3yAp2tqeRnrUBSjk/5nAINRIhXa9
         sOEzlA9AeicxOC61IypZGeKpvbLxRqUx1iwWcRTjLdVTE8r09eSUhXDnkbh9KnRJW7x/
         IvNJFJcSFJ4L9LbmFoJWpMnQnyMJekGuJ7srhmIyVYBQ8K3M2Q+y3XLefVxCiLUjrPhL
         72Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNFrRUzAOuNSF8t1leDfh9Tj6xawIPV4QkdV6yQMg+U=;
        b=N8zxH4Sk+gTyulDw6qTkL0wsWlaD+rl1RanPIWBdOensxu5fwECj3qNR6oqh6Zjo1T
         xD/Zim5IaStZKvVSoEheUvB0xf6yDBDNNe0+ZClUUm5sM4M52ACBlvg0wWe96yw5VCCK
         XOSCBA9vAH8KifyPSD7bjaZgODooeaJLhQX8Ppi4eTdMzZQU35lP9ujn2jSgTW4k7lY8
         6k66ZmRJVdOIc55ViyAp4clGCFZJTX/jHDzAcnv3LZHIXFOwErhZvxLWfJRrqBv9+tT3
         v3zfoMALSteMyQzXou9TOBJwvD1l/20dZKlTQVKoO20DH4KmZDQxqMvIxwmg3Psndx3L
         M3RQ==
X-Gm-Message-State: AFqh2koYnWY6crkvivwgNJFZ1UCrZVd4eIO8hrBc0ADQ8IffqgN3/SEO
        8n4t0UlLFQLTYcQExH+Rv7/Gd7dbb2I=
X-Google-Smtp-Source: AMrXdXsp3JEy1eiXOmRui9ds5H2m9lIVPXnFVcMVkn3ROMWSCPYjQz2QSGoH9Lmr02Akikqn2avLMw==
X-Received: by 2002:a5d:6d4b:0:b0:242:2d7:71e4 with SMTP id k11-20020a5d6d4b000000b0024202d771e4mr43013586wri.2.1675171768470;
        Tue, 31 Jan 2023 05:29:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b002bfcc940014sm13535715wrj.82.2023.01.31.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:28 -0800 (PST)
Message-Id: <83f49b37c6975a5898e66a420f13a70ef25afc59.1675171760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:16 +0000
Subject: [PATCH v3 08/11] bundle-uri: drop bundle.flag from design doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The Implementation Plan section lists a 'bundle.flag' option that is not
documented anywhere else. What is documented elsewhere in the document
and implemented by previous changes is the 'bundle.heuristic' config
key. For now, a heuristic is required to indicate that a bundle list is
organized for use during 'git fetch', and it is also sufficient for all
existing designs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/technical/bundle-uri.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
index b78d01d9adf..91d3a13e327 100644
--- a/Documentation/technical/bundle-uri.txt
+++ b/Documentation/technical/bundle-uri.txt
@@ -479,14 +479,14 @@ outline for submitting these features:
    (This choice is an opt-in via a config option and a command-line
    option.)
 
-4. Allow the client to understand the `bundle.flag=forFetch` configuration
+4. Allow the client to understand the `bundle.heuristic` configuration key
    and the `bundle.<id>.creationToken` heuristic. When `git clone`
-   discovers a bundle URI with `bundle.flag=forFetch`, it configures the
-   client repository to check that bundle URI during later `git fetch <remote>`
+   discovers a bundle URI with `bundle.heuristic`, it configures the client
+   repository to check that bundle URI during later `git fetch <remote>`
    commands.
 
 5. Allow clients to discover bundle URIs during `git fetch` and configure
-   a bundle URI for later fetches if `bundle.flag=forFetch`.
+   a bundle URI for later fetches if `bundle.heuristic` is set.
 
 6. Implement the "inspect headers" heuristic to reduce data downloads when
    the `bundle.<id>.creationToken` heuristic is not available.
-- 
gitgitgadget

