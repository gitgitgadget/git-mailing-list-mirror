Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B20CC2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EF422226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLV8XaIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKBUuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBUuE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:50:04 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC444C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:50:03 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b8so16180847wrn.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WEBopASz2wN3sgsdcNRR5MaKxfw7b3eLyz+PnWC9Gc=;
        b=NLV8XaIPrDsMvNqho7oweGMIB+SS8qHMurALvb1GEaBzt7OXzaRJLtt/JFoI2QcEWI
         9265LbR2t0NktrSXdJY0BOt/nYnnYD115Mtl68Y4Z3dGFj+N/T643PaAlIZ5ws4uqlLU
         0Ypq9i0mFdP9gbwjAM9g17I9hWOD/xGwf4hJild4dJuNee1VI9XUxpRqLfNeHMVuP1Ci
         oFPdiF6uDuZ5CKl66RdUp8S24ADyv1Cc4Hf7I8KhFfNT7wOTJmjcA/h50N/h1UUgUyQr
         7oWNxoMyldUzNKFFiWruIVY7EZB3UAd078ccGv1jAe7LUA3f/wi1PBOqAOlGSE+r6jeR
         2XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WEBopASz2wN3sgsdcNRR5MaKxfw7b3eLyz+PnWC9Gc=;
        b=fVf7PDWa1OXUHnNincfEuLhyr4dXaosWpR2eMBdrmHWnpQ9Xkn1cd7LuPHhY8ty9ie
         H3VXr07zO/UdYDsVZxwEbAWe+MglI/Bofh6Zl3dYPXGufi2+npCaZdM55ByVTtAm5QSY
         Y2+NmQFK+wOqirm5hf5+ihLhfS5b3b3TVNpXHt0A72iwAXVrBQ7UvKyof+mVMuENFO2o
         LEKegJT/0717ST6waqb2QrA0/aiAZeQLBIpAcI6L8BnUWA5G5LUSzXdSCm/foJhfMWS4
         EO7JJgIKq09f3FsH7LY+AOoNnJbEnijL7y1WWHrlS4cPRtvedB0A3TK7aTcfq/BcVwzN
         sT6w==
X-Gm-Message-State: AOAM5330Ou/mIQfBgbsOWHuTm3FGckHtoBTmIbzu4Iaanlq5MgBzh6Z6
        Tu4OtqeiE71JhcxVco4wzG6j5joqs8kfEQvkRLU=
X-Google-Smtp-Source: ABdhPJz2dUN3oYlO7M0iuP8GQzMdKDTdk3QikQ5vxQbHBUPX5eP18SsFw4cmJK4RVl/wiyLFRO4a9w73z3tCkypx9nU=
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr22610593wrh.139.1604350202475;
 Mon, 02 Nov 2020 12:50:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com> <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
 <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
 <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de> <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
 <xmqqwnzbbfsi.fsf@gitster.c.googlers.com> <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
 <xmqqtuuc7wgu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuuc7wgu.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 2 Nov 2020 14:49:51 -0600
Message-ID: <CAMP44s1+bJMrmJWeAQx18S-=spoKb0BmzWyJ4WgzuE+rNuf0cg@mail.gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>, Stefan Haller <lists@haller-berlin.de>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 11:50 AM Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > The first time you run zsh you are greeted with a configuration dialog
> > that includes this question:
>
> Ahh, yes, that reminds me why I gave up trying it out the last time.
> The large dialog asking my permission to contaminate ~/.* was simply
> too scary and distasteful for a "dip my toe in the water" sightseer.

You don't *need* to run the dialog, just touch a ~/.zshrc file.

This should be enough:
---
autoload -U compinit && compinit
---

> Makes sense.  Instead of adjusting my rerere database for that,
> ejecting lo/zsh-completion topic would be easier---what the other
> half of that patch does is already in your 29-patch series.

Yes.

-- 
Felipe Contreras
