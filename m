Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB23C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbiCHOk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347550AbiCHOkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140CF38DA2
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso1649376wmr.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h62JVzb/uF3I+8SLeb9g0QKm9zTbW6d6LFRo3OfnaqQ=;
        b=NcMP5kSSNdcO6eL8kr+JDNGW8GEmFj168vKIQBL7O1LuAXrYgDTKQRAlwr78mwTnVs
         8JE7XB+4YhntcPpTzifu7vl0g1nQybfjWWLknowsj2jqWoOgegfebKG969dNXveifn0Y
         +T+vRW55JGcZ/WAJwuMEDPQbh6e6aDVM5clnw1pOpxaokbP0AgH/GkcpH0fRyGZ/zIB1
         QGkXKsAq3/TtvYO5XnfghU3N1w+qK8iTM+rHpUrAtq0u87lxhC7Nlufixkrrptb0NSGS
         m29OlF2EVd6BF70lPKPa9FWFUsMpt9o92SNQeO8jskkTUn+wLeHqWV4dv5mHkjhndV4G
         hbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h62JVzb/uF3I+8SLeb9g0QKm9zTbW6d6LFRo3OfnaqQ=;
        b=7CwtkuTLtHm6m08G3kbRESRY5+cBWJnBLZuPN/eJPBnNLlSJlX0HJkVj4cCk6CADau
         lDakrKEVCXCHDiSpjzR5fobm9ZokniPGY2k4393pxwRvmV7SSbjjzyjHkXHNg1RozZBe
         24/gJ47fIdrN831FKYtVPAAxwCNrqxQPt9QEm7XmjbCMu8GylzcVcEVmtxOU0ivsvVKD
         oWK1Dn1Q2a1Oloj6GjG9f/RES/pcYar1qA/Xe74Owvhfc95eMQ4qSm4bGOoajikjVwyX
         hFElcIX4GnMZHx/dZ9+ylNPQFhl2NoVTEHMb9vepoomJErhHy+xjEIK8NI14MoQyWEJe
         Bmpg==
X-Gm-Message-State: AOAM533uAHRT+0mImMBN8kd3su4oW41+EnESrJJPDpORCD0zwD05rewE
        rqDCbOEi/9e8bNrDjrqZNGDPu4GG5Tw=
X-Google-Smtp-Source: ABdhPJzLrVZIrZgK0mMiQIgLokmZ3Yikx6ZFsIZ+PTbHgFOjS8Se2ADq5vd6Oh7BM3HQKtgO0RrPzg==
X-Received: by 2002:a05:600c:240b:b0:389:b41c:57bc with SMTP id 11-20020a05600c240b00b00389b41c57bcmr3895900wmp.131.1646750363494;
        Tue, 08 Mar 2022 06:39:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b003899d242c3asm2527625wms.44.2022.03.08.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:23 -0800 (PST)
Message-Id: <d5edb193229731edbac9f861ad569885ec2b4405.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:10 +0000
Subject: [PATCH v3 03/12] pack-objects: use rev.filter when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In builtin/pack-objects.c, we use a 'filter_options' global to populate
the --filter=<X> argument. The previous change created a pointer to a
filter option in 'struct rev_info', so we can use that pointer here as a
start to simplifying some usage of object filters.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..256d9b1798f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
@@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **av)
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, &s_r_opt);
+	revs.filter = &filter_options;
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list_filtered(&filter_options, &revs,
+	traverse_commit_list_filtered(revs.filter, &revs,
 				      show_commit, fn_show_object, NULL,
 				      NULL);
 
-- 
gitgitgadget

