Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F040DC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C933F61287
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhENIpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 04:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhENIpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 04:45:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F29C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:43:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so23646820pga.11
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiAqJVcv8mda3IM7Tsl4a7VpHfbmQZsyivIT8Ww9xwo=;
        b=eZ1584qU8cOjnWeftaFmWSvruL2LTEQWuicU1yCpBzBKXA+S1/vk21XSsjg2tbPHXx
         FGYYoCLgkhQQ+wn6qdtKqdnYziBkAqYHBUBQKBKXluBazKrg05zZ1fttx9dmwJBfpC+J
         TE6TNtdqXDTCeoUHeIuND4Kv67CmPmbTIJoDrnK6X5x8cJcmYuwcE036K16hIjpGfbVC
         hx0hWgXLClDq1lGRHjq3exCLwF3BNyt2mGLsHGBF0xYO9kuy0ARdIW5lBPhdngOoluYt
         P99+6mRB+JU3l/4HnvvvWrI1WbctAMJ2mamlYJ90FFTnPsLBOpIDaORreMDyhNGZLcX3
         N/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiAqJVcv8mda3IM7Tsl4a7VpHfbmQZsyivIT8Ww9xwo=;
        b=tOpX7Nuwx0wKhN+IqzwJ2Dx7cXZNJbNRC1zeAgbVWN/Zz6lZaLNcb18oqsIW6fHpqR
         YikXh7LDqaGwh7hZMuFLc3dT7gyRHehXft/Mx4AebHTobBmlShhvN8RZ3O2M3KEHPM63
         2qEGjXzSiHPq3igy5sPwncRSa56G0yhFAcFSsgsr8JVGcviMmNrLlz/wAIKi2VccF8Mh
         uscb6yFYPnSYqwgsveUUTT1w925+56LHDp90N2XhqPi8CiGBSYXgA6k9/yuR+lb0oHKM
         mwt9dvTwSDeLeun0aqqGtQ9Z5zZ1U8YErDeyWFHH03zek/ZfU76FwvI8ekdW1P5m/ZUA
         Z/jg==
X-Gm-Message-State: AOAM533W9eEMG88b7PuyyWA25cJewF5xy8r5lpb+lfRjMoyrEbCIjOxZ
        CpSH84jLyY8yya0/2NicJb90Y2XAutWdcrqRdxq/2PFY4No=
X-Google-Smtp-Source: ABdhPJyPas/6qgdkTU4IFx6kwPqoL2Bfw7J5dPo4nUP5mntf+ugV1/E1EAAnUUDwCgsl5wpPWXgtN5feqLfw7ccjZhM=
X-Received: by 2002:aa7:92da:0:b029:2d5:59bc:a7e4 with SMTP id
 k26-20020aa792da0000b02902d559bca7e4mr2551128pfa.46.1620981833478; Fri, 14
 May 2021 01:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620928059.git.martin.agren@gmail.com> <609dd5171e7de_19566208ca@natae.notmuch>
In-Reply-To: <609dd5171e7de_19566208ca@natae.notmuch>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 10:43:41 +0200
Message-ID: <CAN0heSoK5VfP68Us2e2bwSfTzY=5FBEBjxuTHRXeA_qg5MH65w@mail.gmail.com>
Subject: Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 at 03:40, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> We should be submitting bug reports to the asciidoctor project as well,
> so in the future it's less likely we find ourselves in the same
> scenario.
>
> Preferably the bug report should be in the commit message.

I don't have an account with the website they use for their issue
tracking. If you want to submit a bug report and post the link here,
that's fine by me and I'll include it in the reroll.

Martin
