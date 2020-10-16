Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF8CC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 12:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098EB207DE
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 12:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4J0alBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406604AbgJPMyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395307AbgJPMyi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 08:54:38 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E039C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 05:54:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dn5so2202278edb.10
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEZzuOVYeAJv435PCa3dZoc49y0qXuJQTcZqS3EUZcE=;
        b=S4J0alBBUrfnR5HNxEJ3Ib9iyE9fL0VFOmDB9fpas6leXR396ONwM9BB+kGr73Uvkz
         CKEZOiG4pGAAOaHO192Da2EopmH1rq+fpGDu6+PEdKXEz9k4Ks4wXnFXu2Vb6s53QMlt
         AvMGMJNibGUOaRs6bU2EkpcPvSc2F+66Yyj8bM/17yufdTRXgXmqIj4D03+sP9rbYCja
         dRzLpTKS4PqrzvUJumLBSd9hUWqiQH7HYtr+u8X2/NHdMGvNLEYVP6rDyXwcCosRFe29
         aFXAiPYxsPIdQRw6yu50c5DWsyfCW5BOyuq95p8ypLHvz3R4GtjhDhG4l3lLvYmNLCgD
         Qlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEZzuOVYeAJv435PCa3dZoc49y0qXuJQTcZqS3EUZcE=;
        b=HqGO0lhJYDD8p+dJbEiU9SYQA4qzRAqMFYLrxqLv4NVjGuLkNNNYCiSaLkNnv3Uvxb
         zONW5zoqHiPVCX562WqmMMd0N09ZWgZ47+HX1sRL2oYVy3gD1nX6XXhgNxNjdyT4uqs3
         ak/gW5cULHTYkiEIrM78iDrFHSGRKXD6SNssi7DHYm8SiKZEg3hOIMVPxo2ZwquMi/0R
         LgyqIocDRxbv0wQinxGk3DkTriR8rrCmYO2wsKf08cRYVvIAZAIdjGEK0D5L0xcN7UeD
         wQP+K/3BoQikhQVLwSfecV7X9iX7c8JYUTqyC8RSmbiiyVQQao+t7rOtETbfoevfaoPb
         Feig==
X-Gm-Message-State: AOAM532QQ+VASKYpPvNx6/cJuHj1Nvt9hByRsyTpfSVwEdnqY2luBIP5
        Hc1LuzxheAv7y1TokC8Dzgv3Ldm3cqu8qykPsoU=
X-Google-Smtp-Source: ABdhPJwAcDtCLL2zityRD+/3gZjtxrJFbDoW/ubri+Gr+S7lhH8kyHtf0c1xIlvkrl6PF+KWBdwbsm2aWpE+QrMT2uk=
X-Received: by 2002:a05:6402:384:: with SMTP id o4mr3712448edv.387.1602852876790;
 Fri, 16 Oct 2020 05:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com>
In-Reply-To: <20201015175709.20121-1-charvi077@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Oct 2020 14:54:24 +0200
Message-ID: <CAP8UFD1J8hpcfyzMKvqy67-bMZipzsUvR9f1cXxtPR9Co5hNRA@mail.gmail.com>
Subject: Re: [PATCH 0/5][Outreachy] modernizing the test scripts
To:     charvi-077 <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>, phillip.wood123@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 7:57 PM charvi-077 <charvi077@gmail.com> wrote:
>
> This is my first patch series to the GIT mailing list. I followed the
> link[1] and t7001 patches to modernize and clean up the test scripts.

Thanks for getting started contributing!

> This patch series :
>  -modernize the three test scripts : t7101, t7201 and t102.

s/t102/t7102/

On https://git.github.io/Outreachy-21-Microprojects/ we say:

"Find one test script that needs some of the same changes and make them."

So working only one test script, for example only t7101, would have
been better than working on 3 test scripts. Now that you started
working on 3 test scripts, it's ok to finish modernizing all these 3
test scripts though.

>  - cleans up with 5 types of changes in all the three scripts.
>    1. Converting the old old style test format to new one

s/old old/old/

>    2. Removing blankspaces in test bodies
>    3. Removing whitespaces after the redirect operator, according to
>       Codingguidelines .

s/Codingguidelines/CodingGuidelines/

>    4. Using git -C instead of cd
>    5. Placing all commands in seperate lines.

s/seperate/separate/

> Also, I have tested the scripts and set up travis CI[2].

Nice!

Thanks,
Christian.
