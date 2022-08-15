Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFFC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 05:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiHOFQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 01:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiHOFQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 01:16:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4F1573B
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 22:16:38 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 10so1721700iou.2
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 22:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=XAmItbtO+swf+L2qjMq9n0zD/MBi2G/RkbHIQxG1ci0=;
        b=IB4m5L0899lYOksNK18a/45CVxRQ7uiBQOaiqBVblaDUQyf8Uu31/U/8GvUuexfT/X
         P5JI0aZBmy8n7q85d1IgPw/Yyb0ccZxpJxdDVtYirLCHFDra1rA+c2v/PlKYgjCB08Yk
         7wcNFad1l5tuWlZWBqg2nbgHWiKgi7xp+jOOYhZoVFKr5QJwRthsIjH/e6FxD9xQB9Tw
         PCrdkpwenc41lT7j9MMRISmRkUqsAwEnGc0+u2STxrC7/08HzYvtvDrvORrageKEZOFq
         yC9d5Xjjvl4k0Sfc2RT6mjFa853NGa/pOxv9AUtPBgVILO9anLZXEX8k6XFYV05Ql8y8
         9odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=XAmItbtO+swf+L2qjMq9n0zD/MBi2G/RkbHIQxG1ci0=;
        b=celr+6VdvfXIxexhGyykQ+3zrYMPirnXPeUOk9lQcEeD6qeoGclwxGXqZ3Q+CL1fPJ
         ce1TOYHHD9Ng5pbsSfeMFmyPWTDI6Ca1zl9MB+FNSZwgsxyEloSumJS4XagSI+hWJ8RW
         TN7q3UgUQBmEQR+i6jyI/SWNVKxfeGu/B/HNxLgMvCN1oyLo4F/uOjS/CjuwlE5Ul3Sv
         9BLhwbslD0W+PjYnxhNGukMmOhqbXnARDAcL9dmiYqYf7RCCz6QsfSWQLoF8dR01s5Xi
         zYMpGAxqcmjLsHgWcc1vHT2dT1C0DCq5xneK3sxNjSJyA1YONcV9k8/34UHAG9hRHvPL
         fkHg==
X-Gm-Message-State: ACgBeo1sGRW/AjPuiJo5L5gy80hCx64ISEHN4qd3jCsIcjMEszk+m5fG
        i9dKvPXbXcIT9BZgr/jasBuBrqVLhtdurWVHouw=
X-Google-Smtp-Source: AA6agR5e5PWi+/3WiE3+MO8y5C0KDAuAsaxPucfWaXzAQAZo6mKXi5A01F8qFwYfE/5LOZqPxf47VtflY4RW7pADWTI=
X-Received: by 2002:a05:6638:3450:b0:343:3c23:ec7e with SMTP id
 q16-20020a056638345000b003433c23ec7emr6726776jav.67.1660540598260; Sun, 14
 Aug 2022 22:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com> <20220811172219.2308120-1-jonathantanmy@google.com>
 <08dae83ba1b541adac0fd96e2f99b194@xiaomi.com>
In-Reply-To: <08dae83ba1b541adac0fd96e2f99b194@xiaomi.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 15 Aug 2022 13:16:27 +0800
Message-ID: <CAOLTT8R6hNKWGen4RD2sSU-asjjS6HXnxY2JC4k9SeL4YDzB-g@mail.gmail.com>
Subject: Re: [External Mail]Re: Partial-clone cause big performance impact on server
To:     =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E7=A8=8B=E6=B4=8B <chengyang@xiaomi.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=881=
3=E6=97=A5=E5=91=A8=E5=85=AD 16:00=E5=86=99=E9=81=93=EF=BC=9A
>
> > >     3. with GIT_TRACE_PACKET=3D1. We found on big repositories (200K+=
refs, 6m+ objects). Git will sends 40k want.
> > >     4. And we then track our server(which is gerrit with jgit). We fo=
und the server is couting objects. Then we check those 40k objects, most of=
 them are blobs rather than commit. (which means they're not in bitmap)
> > >     5. We believe that's the root cause of our problem. Git sends too=
 many "want SHA1" which are not in bitmap, cause the server to count object=
s frequently, which then slow down the server.
> > >
> > > What we want is, download the things we need to checkout to specific =
commit. But if one commit contain so many objects (like us , 40k+). It take=
s more time to counting than downloading.
> > > Is it possible to let git only send "commit want" rather than all the=
 objects SHA1 one by one?
> >
> > On a technical level, it may be possible - at the point in the Git code=
 where the
> > batch prefetch occurs, I'm not sure if we have the commit, but we could
> > plumb the commit information there. (We have the tree, but this doesn't=
 help
> > us here because as far as I know, the tree won't be in the bitmap so th=
e server
> > would need to count objects anyway, resulting in the same problem.)
> >
> > However, sending only commits as wants would mean that we would be
> > fetching more blobs than needed. For example, if we were to clone (with
> > checkout) and then checkout HEAD^, sending a "commit want" for the latt=
er
> > checkout would result in all blobs referenced by the commit's tree bein=
g
> > fetched and not only the blobs that are different.
>
> It seems your solution require changes from both server side and client s=
ide
> Why not we just add another filter, allow partial-clone always sends comm=
it level want?
> If we checkout HEAD~1, then client can send "want HEAD~1 HEAD~2".
>

I am interesting about this question too, maybe I can try if we can do
this.. ;-)

ZheNing Hu
