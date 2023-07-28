Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62795C001DC
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 03:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjG1Df5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 23:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjG1Dfs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 23:35:48 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA82727
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 20:35:42 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5839f38342fso16944877b3.0
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 20:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690515341; x=1691120141;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mNwlmitutFq5nW4PCaL58E76VLxYv7ZCZUsLksZN9M=;
        b=QWo5wTb22FTftuEjsn1Mi+Jnnl8J7qgU2cm+50weMDdDyGC3wF1GnlX3zrrkMYIQWW
         lN5raWR96IOj56Haso4B5v+N0tlzjAmXq3Ncf1Ejg+EENp+OXGIh/gT9cxJiYGGRLLY7
         8UUjzcCa2w/ZwyHLujIcOugxfb+gN5H1ZjAITlpKQ/cClw+DSDuAri4nw1yp5/64qZSB
         tvjLYLXljt0kyVKTf9+/N6kMPoaFOUQOppaRbUryBL82brjCZWEJWp1XkdZzX8TuZhOg
         7nM/pPvqNBLiAmK34qgjxBU2BXLA/lTvQSMfcMZz/S3DoaCr/yX1fE+OCqYbg7r5axQ2
         SFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690515341; x=1691120141;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mNwlmitutFq5nW4PCaL58E76VLxYv7ZCZUsLksZN9M=;
        b=Mr8mPy1uJg+IG2rL0gargNfNXOpQIGnusQrejFzuzWS841/LQ5y3WsXewQzFdL7WAs
         ki//LYNJXNLykTSjB8TIupQdMlJmgRs4xm396P/Wenw6atr5WcTfuRCskDtbgEmMDIcg
         AhW0P4u1c+OW6QvTm8BdjnvuOP9WM/OcbmoTrVojHXSn40INk0PQR8nHtzPydqNW7s/R
         3C216px7fG2szizxwNhDwfmBM4C97O2MpPctwmsIeALW424NHZ1M0ahp+uDcAZd0nGpb
         VAuFU/XvYaR6mF8nDPpb2rKAUb4xQW2NGEOefNMDvCDz6+VXQhpvBh6o7fhVoD5zh63D
         LAZQ==
X-Gm-Message-State: ABy/qLbnSLiHoh1jMQrlRuQhdSk3VkOu3r5gzbTp2GOdwDm9c9vjTzqP
        YeInaMH6M19ZsDaak7bKKH65EYcnyYtR4h4TfVdTueD6EyC7fmMB
X-Google-Smtp-Source: APBJJlGpjcY16EK2nF4moOm4V1meO5KONSvoyQAvGfzFX0h4bkqnIiqwIIcY+L27b8PeIrSsDa2vW8PPelwOLZ8uKGE=
X-Received: by 2002:a81:6889:0:b0:57a:6675:3051 with SMTP id
 d131-20020a816889000000b0057a66753051mr822610ywc.46.1690515341429; Thu, 27
 Jul 2023 20:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <20230727171334.6qg2xtecvmplg3or@carbon>
In-Reply-To: <20230727171334.6qg2xtecvmplg3or@carbon>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 28 Jul 2023 11:35:28 +0800
Message-ID: <CAOLTT8TOs2eTryXWTy5aZ8BGNAymgjrsg1BCLbigFunkFpc7JQ@mail.gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
To:     Git List <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> =E4=BA=8E2023=E5=B9=B47=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 01:13=E5=86=99=E9=81=93=EF=BC=9A
>
> >> If you haven't created one, of course it would fail.  It should help
> >> to do
> >>
> >>     $ git hash-object -w --stdin </dev/null
> >>
> >> before running
> >>
> >>     $ git diff 00750edc e69de29bb
> >>
> >
> > This is a viable solution, but it's a bit ugly since a read-only "diff"
> > requires =E2=80=9Dwrite=E2=80=9C an empty blob.
>
> You could probably just do
>
>   git cat-file -s e69de29bb
>
> to figure out whether a blob is empty.
>
> What is your end goal? Do you indeed want to produce a "trivial patch" wh=
ich
> merely "adds" all the lines of the blob you'd like to compare to an empty=
 one
> (assuming the blob conains text)?
>

Yes, I need to compare the diff between multiple versions of blobs in real =
time
(only given the blobID). Once a file is deleted or created, I have to
perform this
comparison with the "empty blob".
