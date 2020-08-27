Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F89C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFE422BF5
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 13:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL3aSqA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgH0Ncz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgH0Nc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 09:32:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C36C061234
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 06:32:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y2so6454167ljc.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6PpB3O7YrtVkz34zHWd/Pm7X3qnBqlcbPS97d+lb0A=;
        b=bL3aSqA6nAxI62YDc39IVnk+4WyYeRK4OcQOZH3QAckzDoxU3T2IPa8+MDLl9jCk3E
         qRxiEZuo4+Jq60Q68pNAMnzdAYT1t76/a3fnwIkJZ+7qO7Z381RoyVZW5ZG5CzzeBpFU
         +BbCEA3IJuezGqfDujIuruu5jivRX+YOW1U8LhwQa/NwN6Mhr1ghreZfMalky29ynbEx
         2y2dzYNFytFPcMI0W86IG0wEq9jaNqqi812ZIPiuQeCik2YrbK3fHAE9OxBQDTUfbmL9
         Yc8YzBDxXc9dT6odPWqnmlTtvtLjqczkKTEnrvoUhs3/LeSDYjp4kbz2bzzykx2RnSAa
         AaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6PpB3O7YrtVkz34zHWd/Pm7X3qnBqlcbPS97d+lb0A=;
        b=bIu0WV0CL2ipvMNaMKcEKN65aZxGjqjWNbkpIsDRQ/hUwH6u2X+8QSZ6TVuVDtVwZu
         AvIziPYQVLWT7niqXeQBgfzjNyMUvK04uei+oLPCNuxbCfUqOsu+ksblEuVr2cg5Pf6R
         eZy2zLImKmlKRncUZDz3KGoCEUDJJOBF7DnW/SWQimTe0uFmkcOFdUFYKuDxmU9OlwJO
         hujwvTw8iWKh7a+7guhUdMjaTOpJ0p7ZyaHuO/2lbZRk3bTfhcoVH1uEpMYV1Mb6pE2i
         7GZDYd4U1aSkjPerndwluoUPIaha3XnUfpBV2kmx80GqMSD/BhfL3/GztHmu8vZfSx2p
         kSaw==
X-Gm-Message-State: AOAM531YbJv/HjiColXEDyzUTpvX3XvCsJeWhPo1WpmYNZs8rFqCfku8
        WZsrC6Cg1upJ5l7+dDVx6fEUoD2KCAX80UTiM0YRQYbDIzS2uQ==
X-Google-Smtp-Source: ABdhPJyeVVC1Cloz6NGuxWDerFRRujyD+PrGeQnM76sw+Y9mAnpOHqfYxn3Z9Z+wtwY0ddLx6b6UMFRMWUWckdRb1bw=
X-Received: by 2002:a05:651c:2cf:: with SMTP id f15mr2215706ljo.79.1598535144188;
 Thu, 27 Aug 2020 06:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAF2SHyBYZ7=vcL4sPdP=T9zRCBrwW_z0-o1v9=gC4=oPqv4oXQ@mail.gmail.com>
 <20200827101924.iklvsy6lnscrpojs@yadavpratyush.com> <CAF2SHyA_bg1wxaDaLN=m2G+0sZB=b30LTnm3rOPVEYgAx9Uazg@mail.gmail.com>
 <20200827115350.q3xzad3c2v4sgvaf@yadavpratyush.com>
In-Reply-To: <20200827115350.q3xzad3c2v4sgvaf@yadavpratyush.com>
From:   Toni Brkic <brkict@gmail.com>
Date:   Thu, 27 Aug 2020 15:32:12 +0200
Message-ID: <CAF2SHyD2EO7o7RhKRGmMaffAa2=6z_rkO+CeBPWREObD=4HmuQ@mail.gmail.com>
Subject: Re: feature request - add --only-author option to git push
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >
> > The pre-push hook I do not believe could be used to solve it. Due to
> > that it seems that you cannot have options to
> > pre-hooks. I only want the pre-hook to run when having the
> > --only-authors option. Or some other way to not run the hook.
> >
> > Since there might be situation where I want to change somebody elses patch.
>
> You can pass `--no-verify` to `git push` to skip the pre-push hook:
>
>   --[no-]verify
>      Toggle the pre-push hook (see githooks(5)). The default is
>      --verify, giving the hook a chance to prevent the push. With
>      --no-verify, the hook is bypassed completely.
>
> --
> Regards,
> Pratyush Yadav

Thanks. I could do that for myself. Would not be ideal, but it would
work as work around for me.
I still think this would be a good feature to add to git.
Not sure how the flow for requesting new features. If this would be
something that would be of interest to be added I could take a look
myself and try
to write a patch.
