Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E3C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB95C2224B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgLAX0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLAX0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:26:45 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EB8C0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:26:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so5612559wrn.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQKIgiVVRrQNEsx72BqFjk60Xr53+6FfVNpEnaSsdw8=;
        b=GJ73VV2MaTyigtSanhqDL2XTCdXRjGv7aUPFIeiLnLtgDb2iHiY/L1JZrajuivMsLk
         +4XHiNLPf8GNebEZZn8Wkpex/dl4m5hNgoL1rM4Ahu2lxee3K5eQWRxl3lkB63Y+sAJ5
         ZnCT8jZmDEqlu/PH57uXwpwJrTREC60obEyzfBpXaG1Ff+dO6yt+z4+TvYracFGDbkvw
         J91LNa+alvp08sL0KWWYg0+Js574Z8c71foOTYwzOHXbfyPITuzbHbtWM2mXRe5mOyts
         wIf2kFKtupCbSmRGzN3iM0g/Q/LqjggthAUztripbJsvVismBsJWI+lAV6+SQ5xy7k2+
         tiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQKIgiVVRrQNEsx72BqFjk60Xr53+6FfVNpEnaSsdw8=;
        b=PsoaSadX+DTFz6UTElcSQBsf8Wr6SwUk9m/nfisE5K/VRgk27suUT8tkhQCjeppVIu
         ypCniN4k1Do1Oy8qOOw1YWs8tstPdnNPJcH5OZAa3vgVRmCLkbdI9KEc67SF/KF76fRu
         Y9VaZub50M172NZ8NoO1IdzqoYEI2DpxNNAXqdWOsAOCFVZohQwLGjauXFU2vpsbzLoT
         KB+7wd/MjtxgB8mN9ueWQNgQOBSacjdX+1a/qZbHFx1D7eFCshWTtgLzciym7L9LX4qg
         ejzXmZKbfmVFJ6/L7CHrhMQEz4q4A3/Il6tjcNxDn23JH+Q+Cx85lprkIK88QuDVREh0
         c8xg==
X-Gm-Message-State: AOAM533giKmkiksUzgwSQGMWvZ/EA8ZCC5XppdCXxREcL9Irjh+T4SP1
        pJY5HU/8BFyMq61lBtDBMmcRDpz0HhTfPvDknF8O5thQusc=
X-Google-Smtp-Source: ABdhPJzu6XqSmrCEb1rW0LueuQD/SzGMML0xG5/KX1oS1ZL+lx8+Tr98HAnSjUhpFd9apM56psthkmOaRb8uj6eNqpI=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr6981920wrv.255.1606865164076;
 Tue, 01 Dec 2020 15:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-2-felipe.contreras@gmail.com> <X8YsXjN7MQrLnytw@coredump.intra.peff.net>
In-Reply-To: <X8YsXjN7MQrLnytw@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 17:25:53 -0600
Message-ID: <CAMP44s3usd5EW4sA6_qapnDBVRAWg4nk5ZSxAPPQN1UygD=ctA@mail.gmail.com>
Subject: Re: [PATCH 1/4] refspec: trivial cleanup
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 5:43 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 30, 2020 at 06:46:46PM -0600, Felipe Contreras wrote:
>
> > We can remove one level of indentation and make the code clearer. So why
> > not do so?
>
> I know your question was rhetorical, but a good reason not to do so in
> general is that the existing pattern reveals some intent. E.g., it
> sometimes is the case that with the _current_ code we can return early
> from a function or loop, but that is not inherent to what the code is
> doing, and the early return or continue makes it harder to understand
> that.

Yes, but even in those cases it arguably helps readability.

Anyway, I prefer to argue on the tangible rather than hypotheticals
because the hypotheticals are infinite.

In this particular case there's no particular reason to just continue
if there's no prefix.

Cheers.

-- 
Felipe Contreras
