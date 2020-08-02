Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD3EC433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 04:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD02075B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 04:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq5D9+qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgHBERu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 00:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgHBERt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 00:17:49 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D6C06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 21:17:49 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id g18so5822128ooa.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T16bq60pazTUExCpgSAIROyRM8VICV1bMIrL75kljyA=;
        b=pq5D9+qmAsS7YvNEtJIcpM8fpvv2oxBCzyyjb4hVLJOd/jY4DbvO8pWhQAtEhQQIgr
         ZNdd5NF2Q8sn0yeR0FQzESxUFf3ajTGr23HVglb6Ue5xgDUP3efGzA4+1kePvZxmZW3q
         hHT5yWMFTwRYm/qL0u5rrjuoGmq26anv668MDRZRqKFGxJ8iMWH+vdJ7F5I76aOl4Vtg
         QrFSmwdj2HAJH+VOyUJUTIKA2DZhBIYfeYGnwDlVQRtORUZv23UjQfHiWM5e/A0Wx9ZT
         vNNz4Mc2o1gliyXNvk3X4ZkDBC3Sx2ZbAkR9uHb+hgLWG6CmXlqGiL1CB97iDCOEH7Jc
         vc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=T16bq60pazTUExCpgSAIROyRM8VICV1bMIrL75kljyA=;
        b=ZHEE49zuIYvXAkZKXh0oDvojSTHXjf8uUuxwua4Hfl6wKUiZXYMUKkr0cfEFxczTpQ
         dSobDulHcOTuQ8NZqfuOelOF0oU+xt2O433B1dvDTG859w3AlSroGGQlDW/HqiSrtkJD
         HktWnBeTkqVWTSmCAqY3nIu/G0QUj+/2BE7ngqq93iqXIfanHUSZhKu8GmZ4Bb0jhrML
         O7NoEssDPIicasUmWKJSrzNenhuk81a9jTTZwmPNQeTW5NR3OrU61H30igGQ4WQwgPed
         QngrTvQA7xnD1MT/uYK95a3NJKuxuEp7mjTSUqMRr7BCOje6Uf+KMmxENLLWx5qY1Dor
         BUKw==
X-Gm-Message-State: AOAM532pIdExjTLi1z4L15cA1IDXS8ABaHhzQCA6BJ1WalqRhfOONwEd
        N29TRyj7PgzLgYpVroVdBrMveETBsczExDbTUCA=
X-Google-Smtp-Source: ABdhPJxrrYMJk6lwjEJJSaaDYwl6stSRTvG0GeLADTwZ8ZWwuOqRQQlpo0QHNoCmHAuedyNZXjVzgSLqkFmZbG/6ndM=
X-Received: by 2002:a4a:ab85:: with SMTP id m5mr9281784oon.66.1596341868896;
 Sat, 01 Aug 2020 21:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEcaDL=BrqFf7bwJ0cVWK-+vUKLmuihhKr8m0_w2CCSNfA9LEw@mail.gmail.com>
 <20200802012802.GK6540@camp.crustytoothpaste.net>
In-Reply-To: <20200802012802.GK6540@camp.crustytoothpaste.net>
From:   Nicholas Hsiang <xianghongai@gmail.com>
Date:   Sun, 2 Aug 2020 12:17:37 +0800
Message-ID: <CAEcaDL=DOn8d=L0Db41o--vOzjSzxVxsDTX9poXHTHHwBV0SCQ@mail.gmail.com>
Subject: Re: Chinese characters are garbled, setting utf-8 is also garbled
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Nicholas Hsiang <xianghongai@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I submit an issue with them, Thanks for the tip!
:)
--
xiang hong ai: ChangSha, HuNan, CN

brian m. carlson <sandals@crustytoothpaste.net> =E4=BA=8E2020=E5=B9=B48=E6=
=9C=882=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=889:28=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 2020-08-01 at 04:36:50, Nicholas Hsiang wrote:
> > Hi,
> >
> > There are some problems here.
> >
> > I have configured the character encoding in .gitconfig:
> >
> > ```yaml
> > [core]
> >   quotepath =3D false
> > [gui]
> >   encoding =3D utf-8
> > [i18n]
> >   commitencoding =3D utf-8
> >   logoutputencoding =3D utf-8
> > ```
> >
> > and Git Bash configed: Options > Text > Locale: zh_CN, Character set: U=
TF-8
> >
> > However, when executing `git pull/reset/status`, Chinese characters
> > still appeared garbled.
> >
> > ```bash
> > Xiang@Xiang MINGW64 /c/me/front-end-note (master)
> > $ git reset --hard df576e2
> > HEAD is now at df576e2 doc: =E7=90=9B=E3=83=A5=E5=8E=96 ES5 =E7=BC=81=
=D1=84=E5=A3=99
> > ```
>
> Since this is a Windows issue, you'd be better off reporting this at the
> Git for Windows issue tracker at
> https://github.com/git-for-windows/git/issues/.  As far as what I've
> seen in your email, the characters do appear to be in Chinese, although
> since I don't speak or read that language, I don't know whether they
> make any sense or are garbled.
> --
> brian m. carlson: Houston, Texas, US



--=20
Live Long and Prosper.
