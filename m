Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C6C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903BC613A9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhGOJvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhGOJvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 05:51:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08DBC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:48:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso5499503oty.12
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ldcBhbZFut5u5p4Oxa2QuCGPqmzMw4DMxP2313mirB0=;
        b=J2d2wR7678Ps1EZmNOq/SIt0MCiHOlWm5ti59JXFWoNhcPk8R0sjr9AUYPlbkEY6H+
         F6qH3+5I9R8tcadD5LbbtPj79ITUEi4c/Kq2ouNEL7yhwwpfLAVkwr8uuMOVGjHkTIGj
         6mEjzRJBGH44P9+aY2oK5zxpemYnqGFvm6zy/Qs076/ZU2i2S4OA1xrWX3i3knFjggd1
         2xmgUvte6adPnz+N8GrltbKYXfGehPJS6GEr0tMQKM9nDXKRRO4MjT1XK9HrpVay9dTZ
         HuIpPQMOzrrSbnsiL0AHyBIR0d4TP5YtFSP7CTULI1mt8/iaXrmMTkfuh7i/7IEchNdb
         iXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ldcBhbZFut5u5p4Oxa2QuCGPqmzMw4DMxP2313mirB0=;
        b=Mh33Eo0r6TpZMJvmioELhaagzc/QkJ7+8ouZ4EfFXkEbkGWm0NGrGbc0Lmld2WJWAe
         09SjK2gwKgcOJvr0s+aVWz9kKEJov8cQ4AB0u+DxSKYHUmi+Ed3E6OjgN+3wPE9QjDTr
         c5sfKMtHQ+2viUsWRdNAgcDM6fY8u3sWHxLwyadkTt1WQkYbT2InyFieUQWObmz0pPAf
         uZL1MJ6mPsiGImR5txfVhuJoEjZbQvnI43kfa0VUBaYD15PwBlFvFRH9S9XljuirmOux
         9/42bLvLyu8N31R+yhztPMpbIpO64Y5UooL9SmOLhsWtSrInmJyjtzbF04bsuCqtFijh
         bhcg==
X-Gm-Message-State: AOAM530nmv3LpjyOqLPnpKZX5+6QPb2ErHmrijXHrczJsSmV9RaGe8Cr
        KNO/37BBIBjdust23H57nRU=
X-Google-Smtp-Source: ABdhPJy+vN5Vi3AlReV+m2IRSaCaPShvhmRhx1occ0BbPTuVtz6zTmk251B9WCVFCT7al3XsLS7fAQ==
X-Received: by 2002:a9d:6ac4:: with SMTP id m4mr3017311otq.203.1626342492280;
        Thu, 15 Jul 2021 02:48:12 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x30sm1016148ote.44.2021.07.15.02.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:48:11 -0700 (PDT)
Date:   Thu, 15 Jul 2021 04:48:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f0045aad10c_2e6720891@natae.notmuch>
In-Reply-To: <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 5/5] pull: abort by default when fast-forwarding is not
 possible
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
> We have for some time shown a long warning when the user does not
> specify how to reconcile divergent branches with git pull.  Make it an
> error now.

A warning doesn't imply deprecation.

Users have been warnged *zero* days that the default is going to change,
to what it's going to change, how to configure the new behavior, or how
to keep the old behavior.

NAK.

-- 
Felipe Contreras
