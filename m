Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE686C74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCZWqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCZWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:45:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840515BBA
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m2so6837161wrh.6
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870748;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3ib7yuv25Yk7MrLfx2gVEaVtF2eRGWMtyxxUs9Xe7A=;
        b=EXZgwtkmYrXMByio/XZ1y+y4dGH/o4FBCdCwzCIotn34GWTDL6Ku+OsCMmxG0E08f8
         MA+P1VVpmb1aXqJdWNGv1Br7o701wX7J+hYKy6bYZ74T643ylZjy6Xhr2EWuLsA40O1q
         KIUg3Ykpqf1x9RCrA6VwshDWVfEqQNDAFWGri8/eOkguf999II7HkhCez8BfiVlyJEwD
         OTg6pbQJZErNBd1ceCiMkcYeeWOdW2SJtKQEObp0bDzlVKLZweCIrTF7tugbOsRKwk8T
         Xof9paeBeK0Sz+Xe8YkG0ZjyVDv8KkDW/u1FVW+E6+K0t63x4bXSvjW9oAXT1WoS/DFn
         sqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870748;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3ib7yuv25Yk7MrLfx2gVEaVtF2eRGWMtyxxUs9Xe7A=;
        b=Bw2UOuYC0WSbD2IxHUsKvQJu+ToaL5APe1w5hEE6Nnvk8ZbtXKro0DkIRmwNkmV4eG
         1cJNQNXUcG5ZsBf/k1lS9LhRJWTftAAvdLJ9sn2voxbOvpbBplC2mV21LgVJx4qptT7t
         VmiXHtDss+FBRDMfBz6Y+SfRNSJ9/KYH1jrmPEWJE0LsMogAzfNTzTUdZvQ43X4FaDMN
         2mtfF2G1npvy++BvGSM6Ia8T8v9OCuJiGNUGlEUVIKvKPEUC/3gvfoQrXWJC4MSuW7XW
         FfhzBtrwdwAXD5UK+L5E6AOdlDEpMoTe6GbPgB3AxQtfe4ZkEq8dN1UxK8d4UrDHa0Fm
         WO6w==
X-Gm-Message-State: AAQBX9ehm4RkhmHa3q0dtOZBiUO4dvYqxy9BJ9rdA8RpQ7LfcUwF2Hum
        CJvUAoN0ozKfIA442S49d8qESdilXRA=
X-Google-Smtp-Source: AKy350bDm2RP4RZJ/FS8kZMX7rPz1XsCTQU2YhxOoumOiz9LjUU5TSnt7Oy3o9w5ZUzpfUnRRLd8AA==
X-Received: by 2002:a5d:5257:0:b0:2dc:d670:5367 with SMTP id k23-20020a5d5257000000b002dcd6705367mr7020222wrc.27.1679870747987;
        Sun, 26 Mar 2023 15:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003ed2433aa4asm11745351wml.41.2023.03.26.15.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 15:45:47 -0700 (PDT)
Message-Id: <df61146eaf5bb6245f8607bacfb91ab5613e322a.1679870743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
        <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Mar 2023 22:45:43 +0000
Subject: [PATCH v2 4/4] unpack-trees: take care to propagate the split-index
 flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When copying the `split_index` structure from one index structure to
another, we need to propagate the `SPLIT_INDEX_ORDERED` flag, too, if it
is set, otherwise Git might forget to write the shared index when that
is actually needed.

It just so _happens_ that in many instances when `unpack_trees()` is
called, the result causes the shared index to be written anyway, but
there are edge cases when that is not so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 unpack-trees.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 90b92114be8..ca5e47c77c0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1916,6 +1916,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		 * create a new one.
 		 */
 		o->result.split_index = o->src_index->split_index;
+		if (o->src_index->cache_changed & SPLIT_INDEX_ORDERED)
+			o->result.cache_changed |= SPLIT_INDEX_ORDERED;
 		o->result.split_index->refcount++;
 	} else {
 		o->result.split_index = init_split_index(&o->result);
-- 
gitgitgadget
