Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B58C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 07:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE66611ED
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 07:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhG0H5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhG0H5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 03:57:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F73C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 00:57:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b7so14182557edu.3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wZQy3YbuCB5rP26URWJIeW0Qq19O924QA2e79PKa4Kw=;
        b=syBFSIEvjleemdx06aALvsXgGsRCyBARARSyRtoWp+7jW/d2VqWF+Vw91Cwtob4o5L
         MJXC4pEA7YUZtKwCDkmUv0D16ze5WpMz15qzQ3dDAZfUZUIFpgODFjnPsXlbss6iaykJ
         M8gjA7ORItU0qQ9Av+R9gl67qEhRBvtTo5xL+CpNPTp76Dd9Jmq2fTbIR/w8rBLsBOHu
         D/ci4GGAMUR4AxgxdBLvuPJPjT4a11wCyd1++piT+Xhqm1WmpjTpwk5UA0xk4QXA87dN
         H6sFAGUM9/VO7Xpt1pvIvfNy1EEwwgi1TbEnkz2K7PVSSmoO512+lQMH6pcWn7pQbvST
         V0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wZQy3YbuCB5rP26URWJIeW0Qq19O924QA2e79PKa4Kw=;
        b=mtKhgIVLDNMtPedP4M5oPKQ6eYY7XhvkSW+db5Q8dqrdBG2CWmRq3pifFhCyynKyaw
         FJLwS9p4eKO3ckvBmMLSv1sWUijueJPxI3D39pJ64kJicU7zx93vOb0+GLJsIHKi5BtH
         c9g0DerPK0I9IYLPcjtRy2ecJKU1CCJ3Y5wvlAVWJ34N0ykLsFwIBLuu2BPpRF0FvDUG
         /PWHzVrenezzc34n7T3L4cjTQL9Kw8Yosra12COcNOOgOpocBixMnuKY3y/RvwU6VCyI
         NIQScNO0doaElQtPbJ+UeF7o0YjT06/Vyckbq+dVunc8Urn7x9T8DwKkLHtUzb8WU1D5
         0H9g==
X-Gm-Message-State: AOAM533BAvdb9U+8yQ5mH7YG8G2X5JY187UZC/HVEvw300Q/fC7Ryz20
        yh06TO8s18wQ+2IU7XwJ8T+AB7hext5ihg==
X-Google-Smtp-Source: ABdhPJwnG9UcG4xBmSvglDMcbiC3WT343YG0n3bp/w9m0Q5v2hwVDwFIA7BiPXkwha6bJzEmkNjwvQ==
X-Received: by 2002:aa7:d8d0:: with SMTP id k16mr26057236eds.202.1627372636544;
        Tue, 27 Jul 2021 00:57:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m12sm628576ejd.21.2021.07.27.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:57:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] send-pack: fix push.negotiate with remote helper
Date:   Tue, 27 Jul 2021 09:56:38 +0200
References: <cover.1624486920.git.jonathantanmy@google.com>
 <cover.1626370766.git.jonathantanmy@google.com>
 <af40bee611d4dbbd9bb5f1466bec0be118b74165.1626370766.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <af40bee611d4dbbd9bb5f1466bec0be118b74165.1626370766.git.jonathantanmy@google.com>
Message-ID: <87y29sqjd1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Jonathan Tan wrote:


> +	git init client &&
> +	test_when_finished 'rm -rf client' &&

Nit (don't think this needs a re-roll): Better to do test_when_finished
before whatever creates the thing, in case the command has a bug/errors
out etc. during development. Ditto the below.
