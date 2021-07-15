Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04154C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50816136E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhGOJrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhGOJrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 05:47:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F08C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:44:18 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso5491266oty.12
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sqMQbTWs3l9cYc4w8veXQL6ePq6WPvoEyxYmahaKSLY=;
        b=IyKFcpQ429zyfS9jV52HErA17/PPoH7/tNW+Oi92oautOI5uWV5LePfwr6omkMLwJe
         64OMLunzc/wBGScmEdXZIi7f3d3+U7wAvyhnZq54kjq+jYmgOcupN2o+a0CwSqBV3mGt
         E8OVdy92WRu9+BLjumeuQpC4Hgccd+YMqX2z69sXQKBpzMojzT9q991zRweHcu/v7Alx
         mIBRKs44j2tUHo6daafyTnf7T67BtqJ8vG3TwMHj75+vzUVfNMHAbV1KhOjLHWsqvCrO
         8oXbGIht/+9+9hckLzIPZX5LTbzBxmf8vmtQUqOyJNHOLhqeZrzu6v62veAaAQCiCmse
         Wk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sqMQbTWs3l9cYc4w8veXQL6ePq6WPvoEyxYmahaKSLY=;
        b=ndoEptI79KdOzjsC12UKmIWUitJnDy/hKnG1GUyivwYxYAqtK811uFp7SigGl+iEJz
         CWNI3fE+oe/HDLE7n0moavufgAr+I8RnyIUYgLT/R8Fifmm9eezfRE16UFjn/RFIdCL2
         tqAC1CdwzEiuj0q4JS/RegG+E4z88wXqjx+Ar/t+APmszu5MbQ8/vRTfajNqLvDMRRaV
         dz5E/JyKbVPZYN1CEM4FsW2K3T9EkNl/wfyJh3Dfw+1IbZVb5A7qKeU2+Oxx9sfykl9d
         HsyRrRlxMy84TuisHzhx9nshI0nX6CU0YgfeK+wsYwuzZsCyV4MkD80q/zO6guCOW8M1
         TYvg==
X-Gm-Message-State: AOAM533Zsf8OaUe2dF/LE7ech1a5QoZzLJ/bNNmukBc8MiAj8I9pZIZT
        hmL0dpoGyL7ZBojRHO/L3Fk=
X-Google-Smtp-Source: ABdhPJwnv600ak5h3o3c4TVXadzRsjNipq7k69M8yBRRLOOUST0WDEpO1/0BMjTNWRyjYD8aMKHWPg==
X-Received: by 2002:a9d:38d:: with SMTP id f13mr2914547otf.306.1626342257522;
        Thu, 15 Jul 2021 02:44:17 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id m1sm38942ote.47.2021.07.15.02.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:44:16 -0700 (PDT)
Date:   Thu, 15 Jul 2021 04:44:15 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f0036fa3c97_2e67208c3@natae.notmuch>
In-Reply-To: <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The --rebase[=...] flags and the various ff flags are incompatible,
> except that --no-rebase (or --rebase=false) work with any of the ff
> flags, and --ff works with any of the rebase flags.

This is wrong, the following commands should work

git -c pull.ff=only -c pull.rebase=true pull
git -c pull.ff=only -c pull.rebase=true pull --no-rebase

-- 
Felipe Contreras
