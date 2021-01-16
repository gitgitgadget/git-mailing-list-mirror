Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F8FC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 04:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610BB221ED
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 04:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbhAPEuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 23:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhAPEuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 23:50:14 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC5C0613D3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 20:49:33 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id d8so10738541otq.6
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 20:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTvTeHfCcIFD2CLPgYc/fMmHPkyZqW8JfJSfZi7O7wQ=;
        b=hFuOcxM7smfM4rRI9ZQ9zm5uWj9VzZXbD2d4zZNElQub69bSkqstqfySnvPJYmf2yf
         26hX+Lz3LfkZyo4yNdVPR24uh9HaluJr2ftxRlJYs0CGIcRmYfcp7KVQbFqQaxYb5dhT
         TtsHQIzOFoTZ6HPcStl72Q4nPKdytMlQok4pDLtjlC4EC6pUnGvc4xu4dyjVJBCltSke
         psyA84B7jAuRzYuk8LEHU2MvJrhFf+F/2fiAdFF3+eXaBCRhBYqH1F77NVXw93ebBAfk
         8Iy6a8Xfq8xwV7X5GjqldfA/0/UF6RWR7AL0lYx2kyJDk51EG7luAesnqmHktTiUOmTw
         IS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTvTeHfCcIFD2CLPgYc/fMmHPkyZqW8JfJSfZi7O7wQ=;
        b=ggWHtQoSMH4sSC890J2RE3tEdxxgeHpqOL4fPs9TlVKV3jFGLT3cHWIn3Eq/6pHARv
         MOmWv3QN5Mm3bTCQodKPXOkxp+hKjcPXW52MAwoC7moYEN1jKxVPcxJveChygima/ugf
         w0+afsHoTdf2w3mTUFhOi1oX+3bHd5bxPOaXfD/0XAKIcFxRUMQvvk6EAyvqnGmrd06Q
         VHsAdSYaMeCWN9+ADKK/vk6DzRDNNywXxVQDSvxwFf3e9ffbAlhUL/+QXiM52U6Y0/yu
         mQ0mU8fzZh/pKHFo8ZhSzPi/TNizpQTCGFWE8JoW+0t5hOXh1+SglztjuzneL+ta157u
         G3nA==
X-Gm-Message-State: AOAM533jqkKSf1us/l9odpPmuTYs0zo+2IlkREyUlz2IEZ7w2OVz6L38
        vUpwv696e13XtQNe/n7ebbFYln0O5lPmo5mtlaI=
X-Google-Smtp-Source: ABdhPJwHJfz16fwVQkHjbTtf9iEyBzHK8lHRtuDra0vj5LPa/yJj8xt7G59kEduRoSdLiWW7P5m1FwdZXqKTzLE6eZE=
X-Received: by 2002:a9d:313:: with SMTP id 19mr2982063otv.147.1610772573391;
 Fri, 15 Jan 2021 20:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-2-charvi077@gmail.com>
 <X/8/WassxF7ujqjX@nand.local> <CAPSFM5ew583ZPZO9XUWxskQPsdSv520gKCM30GH2huhdTDxb2A@mail.gmail.com>
 <ac1691d6-e13e-2c04-b105-73a0645f4883@gmail.com> <CAPSFM5eBCVD9sx-AkA6Zr-PAq3JgTftcf2UhZBcBmK_00ff1+Q@mail.gmail.com>
 <xmqqbldqt8rm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbldqt8rm.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 16 Jan 2021 10:19:21 +0530
Message-ID: <CAPSFM5cq6kVM5tUWWKryFvmQBbNzOaOf-SR-Q4wRvs-4Cvc-fA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] rebase -i: only write fixup-message when it's needed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 15 Jan 2021 at 22:52, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > Okay, I looked into the write_message(...) and agree that it does not return
> > a positive value and only returns non-zero for error case and zero for
> > success. So, for this patch maybe we can ignore checking '< 0' here and
> > later add another patch to make this function follow the convention of
> > "negative is error".
>
> Please don't.  There is a higher cognitive cost to readers when you write
>
>         if (write_message(...)) {
>
> The reader is forced to look at its implementation to see if it
> returns positive in a non-error situation.
>
> If you write it like so from the beginning
>
>         if (write_message(...) < 0) {
>
> the reader can trust that the code follows "negative is an error"
> convention.  One fewer thing readers have to worry about.

I agree, earlier I was confused as there were many instances of
write_message() without '< 0' in sequencer.c but considering the
above I completely agree to follow the convention.

Thanks and Regards,
Charvi
