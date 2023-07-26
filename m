Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DC4C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 18:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGZSAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 14:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGZSAg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 14:00:36 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57172724
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 11:00:29 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9ec15e014so57545a34.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690394429; x=1690999229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AayW+R2888iWapUDuXUn/FEvE6SrsoveAbtdyNkAI4s=;
        b=oAetjIRmDnX9s2E9tavPGXC2UrSMqEche9v4+YXFnYNAuXNHM9tjqJ0bq7J44aKiIB
         qfVDtHQ+GYpjNh1xOR3RKLBG8Pui7nGy8AXDo+MDapod3opsgHBT9COCNUxstEYVgpbn
         V4sZcjELkHilEHlTtTgmXXkc7rSWwVPufkjdVfe5wZv12tU42zVyedgpcqlQv6hvGRcb
         QRAn9w5/02ZJOPEMnkcvW4jrtrwh/H4Txd/mFyLUXapM/9eCOgJrUMAmXmucsjY8DANq
         s5/u5cKGQf4y/GenNz1W/KLMUxZSVcbTpOxUyX/ddPCEdTNQly2wIGSONLAVuIMRgQmW
         FNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690394429; x=1690999229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AayW+R2888iWapUDuXUn/FEvE6SrsoveAbtdyNkAI4s=;
        b=XKyG1AS8jmSt9+Zav0Up6poH+ZF8QxZpUEIc2MMYAJ48IwMdgqhdVsjJAZb4Utws+a
         cmPU+6o4RhvnY6yYAgoHtP7qQZJQgHXWMwz3d8i8inpbxap4GQnx14pl5Qk3vLyTht/A
         yq19B2/Lqe6ZRHK3JbdDc1ZzWxg4MGMjjW71AxUcX/v1qVvhWKeN12Pm7CZrR3hCuWKl
         vXxeYEXGlMXQQqmVMFbFqnt2fMPt9/GZXGzw1AVLXdGGh626Ib40CO1A54hG2cPc2wOj
         8FFsY/EiaGSPBJG8yK7Q3jpPWiiK1tbHLS7PBMnlHA1Gv33h5LKm4sznVUfZ536szKCn
         T48A==
X-Gm-Message-State: ABy/qLbYYMpRbvepZLX3Ei3fbQoCjOu+j+aNsOIcWGRbm6k85KYDi2D+
        xSkmzEoZKEWDadpW2zI/b+eCWNmDLQW3wPQvNKaEyDpzFCoPO8jd
X-Google-Smtp-Source: APBJJlFVsZdT7rM3X4/On1dUBpgSQxiNGYwgapSCQ/eZikLozTVuG5ZMJM0+3esS5/Kxg89sWtxMOc6Cl7reErWGKLs=
X-Received: by 2002:a05:6358:70a:b0:132:ce36:ee31 with SMTP id
 e10-20020a056358070a00b00132ce36ee31mr2347716rwj.6.1690394429032; Wed, 26 Jul
 2023 11:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g>
In-Reply-To: <xmqqo7k7c1yw.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 27 Jul 2023 02:00:17 +0800
Message-ID: <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:15=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > I want to diff two blobs right now, and one of them
> > may be empty, so I tried using
> > 0000000000000000000000000000000000000000 or
> > e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 (empty blobID)
> > to test its effect, and the result I found was:
> >
> > git diff 00750edc07d6415dcc07ae0351e9397b0222b7ba
> > 0000000000000000000000000000000000000000
> > fatal: bad object 0000000000000000000000000000000000000000
>
> As the object name for an empty blob is not all-0, this is expected.
>
> > git diff 00750edc07d6415dcc07ae0351e9397b0222b7ba
> > e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> > fatal: bad object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> >
> > Since the "empty object" has not been created, the
> > git diff operation fails.
>
> If you haven't created one, of course it would fail.  It should help
> to do
>
>     $ git hash-object -w --stdin </dev/null
>
> before running
>
>     $ git diff 00750edc e69de29bb
>

This is a viable solution, but it's a bit ugly since a read-only "diff"
requires =E2=80=9Dwrite=E2=80=9C an empty blob.

> Long time ago, with 346245a1 (hard-code the empty tree object,
> 2008-02-13) we taught git what an empty-tree looks like, but it
> seems that we never did the same for an empty blob, perhaps?
>

It would be great to have that capability.

> Interesting.  I am not sure if it is a good idea to teach empty_blob
> to find_cached_object() and leaning negative but I haven't thought
> things through on this.
>

I currently don't have time to delve into implementation details,
so I went with the approach that requires writing an empty blob, but
I'll take a closer look at it later.

>
>

Thanks,
ZheNing Hu
