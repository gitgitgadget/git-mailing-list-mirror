Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E85BC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9C96191C
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhEKMyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhEKMye (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 08:54:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646CAC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:53:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p8so17966772iol.11
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GnMYATIUMcRABXXfk9PVzscWGLeIcQG7dDOdD9pJ2Pw=;
        b=CXIVM6vFIjqsQyie/VXsIk3RMHkomGyRiMi9MqSNTibPpK1N6bNd4iB6qPeP07Feyn
         eQqg0Ch9q0Z+x1QXL4+tIHsFXx1ALzdcBuNPSfbFJqcjk8eTi7AXb0FMF/8OOXqlODQo
         jTxFSfcSrSSGVTpoJLO+9ClcFdRVabQL3lzh9kX2ZsluRiV/g02OEwdH2gSrYXEan8No
         aasW5UVH2wVH9i2kHHwv3Tqq9FdkyvfWDEGOfAE/fwZzUWsGECHaFQFpU30ZKQMBdfog
         ZFk7ajo6LILxOAaCnYrAx0p0PV/i6MkZ6qD6uFScO1pGVI2XwioI+fOgX57UnrP3iUwO
         rvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GnMYATIUMcRABXXfk9PVzscWGLeIcQG7dDOdD9pJ2Pw=;
        b=L8L+qGB9XJjVZpwiO01/h2Cjg+LDJRG3MSD31QwbhLcf2YZBGm41aPBTQpCcHu87hP
         1T8WU/XLuxAjXZXnAuEuZDR1z9cYTrBAjWc/ZOJBFV+Wru+qjDL+9f/nx/EZF0QkZf/e
         bjdlOPGl07SZYAASnswciVtT9kehW9j0cRBHaK+ptpceydxA+T+OeDUBCi6SmpYQGjUi
         DduMlas+S+5yYp9ekJvwr4PZGo8dBhpmxZzYl68sANsE+JiycrB4CBplnIMBFtwt/rlT
         YRBFhswPlzrG+n6bfDeZWeVlP6PRx3GM675F72klfNEC4ax99m2O0Bno5wnLQW+2GT12
         YhcQ==
X-Gm-Message-State: AOAM5308JVi39uRfqJ0Pxno4JYHnLELQ1uEzwRCtyhh6MaNBYD84xQx6
        uzUVn/gW6SBOtciaDCvYK/bXj8ITBTpQ8uR++Uo=
X-Google-Smtp-Source: ABdhPJxx4Qed8qgIKY+kzEDZU2jPDtk/bxLLJZkjynPZ8afL2CvQu3Y1sauReH+ubGaTxJHA6VbIjfQq50QeGbh44u8=
X-Received: by 2002:a05:6638:1242:: with SMTP id o2mr26581771jas.10.1620737607865;
 Tue, 11 May 2021 05:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
 <pull.951.v2.git.1620659000.gitgitgadget@gmail.com> <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
 <xmqqh7jaow31.fsf@gitster.g> <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
 <xmqq7dk5ol3c.fsf@gitster.g>
In-Reply-To: <xmqq7dk5ol3c.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 11 May 2021 20:53:11 +0800
Message-ID: <CAOLTT8T-pUc7SOaivdydXHXm+_-hY=ARpWqGA_OOnej8gRrMCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: introduce enum atom_type
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:12=E5=86=99=E9=81=93=EF=BC=9A
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> I find it far more intuitive to say
> >>
> >>         for (i =3D 0; i < ATOM_INVALID; i++)
> >>
> >> than having to say UNKNOWN+1.
> >
> > Yeah, that's more intuitive. But in my opinion, using `ATOM_UNKNOWN +
> > 1` instead of `0` at least shouldn't often result in more lines of
> > code, and should be a bit easier to get right, compared to having to
> > initialize the field with ATOM_UNKNOWN.
>
> Number of lines is not all that important.
>
> But the developers must remember that UNKNOWN is at the bottom end
> and INVALID is at the top end, which is very taxing.  Tying UNKNOWN
> to the top end and INVALID to the bottom end would equally be
> plausible and there is no memory aid to help us remember which one
> is which.  Compare it to "array indices begin at 0, and the upper
> end is MAX".  Your scheme is much easier for developers to screw up.
>

Yes, UNKNOWN + 1 is difficult to use. But using UNKNOWN =3D -1,
this means that the coder may indirectly use an init atom_type with
junk value "ATOM_REFNAME", they maybe did't notice they need
reinitialize the value to UNKNOWN.

I thought that perhaps such a naming would be better:

ATOM_BEGIN =3D ATOM_UNKNOWN + 1,
ATOM_END =3D ATOM_INVALID

       for (i =3D ATOM_BEGIN; i < ATOM_END; i++) {
       }

But ATOM_END has been used...

--
ZheNing Hu
