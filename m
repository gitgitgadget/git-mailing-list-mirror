Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154EAC2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F26613C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhE1PVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhE1PVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 11:21:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6138C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:19:40 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z24so4540130ioi.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W+WkFvUXa3DHlthDnrS4k5HjP0DbbTKrZ2/PSTJctaE=;
        b=qXigzqvlFsqScdIOcTsVtZ/CFzN4kvY2/h73t9zj7FYKSDZNaGUAhFpi6JTdDjW8Mo
         iNtQ/TJloc9gO5BVsnzMgmVfkW0hFwwCZQFLz3GcGFmCckpRQBmGB8Pj5wmgpDP9dwmH
         CKNPhRm1KAsR1DtpD5+bZL95BULCW8gH3QKhmaydgjXXyBp1bX9YVOMgdyzraUVtkeYq
         YY8L1vaSKI8C95MntY8+riT3VLGT4j0siK5ZSWp0HRRnqDZOUcmk6BTc/4HFUTVR1wMn
         l2qkKTAE1b0TmeTvRMZfnrSx1/O/ToVpFBg03g52BTSN7UWfT+vj5hPOfyn5zGSgaO90
         IrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+WkFvUXa3DHlthDnrS4k5HjP0DbbTKrZ2/PSTJctaE=;
        b=KTwiMtmAAvclr/DQ3Z7rrQKOyux7u4tHrEylGprRuwBOM5Jq99Jfn+tb30YS8m1VIC
         yKeKGN+TACd8vwZYvluGEzK0QBRDHVMMeUDVL1SUU434a0HOsJsBUXSSc4omFg77EC+C
         JjzKYoeQKwuPhnT1lv4+YYUwfktvRvs58wZQ2U5rPPN6+tvwjGZE2C99zsmgFxjN8YqZ
         2gFMC5xLlXcr7J6TH3xg6v+7lO1Y8ynxNd2r/AEgBlb0HbebQ1rx34nGL8qvhmo5/A1k
         jU0aTRvHIFf/XbYYtcjsIVWE3gAP/V43YhlQXOgDMWb9eWMcKI99cS/cMp0DRhPCJ7BX
         nzgw==
X-Gm-Message-State: AOAM53067iVGHZLhwlHR2ubkw2L+oYmK7kvfnxHZpvIvhtdWIt4/UumD
        pcvzoPiQAPNRqkEoWD8JgdVZWU66S8RGiZOwpX5TCBdJL8hhoA3a
X-Google-Smtp-Source: ABdhPJwzIRvg27KGfkZVrX7Fuvg8bWh2JdZWu05akNohVlTzkPot/HzKepfDW9duPnvsLeltNQejYdgNWwI49qnm6uU=
X-Received: by 2002:a05:6638:150d:: with SMTP id b13mr9392347jat.51.1622215180326;
 Fri, 28 May 2021 08:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
 <xmqqpmxb79v8.fsf@gitster.g>
In-Reply-To: <xmqqpmxb79v8.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 28 May 2021 23:19:29 +0800
Message-ID: <CAOLTT8SDHK-e6ReErs80bFh+2nQA_v5Z095XeNiXe4dDQEd3-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(header) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8812:36=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >               struct {
> >                       enum { RAW_BARE, RAW_LENGTH } option;
> >               } raw_data;
> > +             struct {
> > +                     enum { H_BARE, H_LENGTH } option;
> > +             } header;
>
> Raw does not use R_{BARE,LENGTH} and uses raw_data member.  Header
> should follow suit unless there is a compelling reason not to, no?
>
>                 struct {
>                         enum { HEADER_BARE, HEADER_LENGTH } option;
>                 } header_data;
>
> perhaps?
>

OK.


> > @@ -1372,6 +1389,15 @@ static void grab_raw_data(struct atom_value *val=
, int deref, void *buf, unsigned
> >                                   &bodypos, &bodylen, &nonsiglen,
> >                                   &sigpos, &siglen);
> >
> > +             if (starts_with(name, "header")) {
> > +                     size_t header_len =3D subpos - (const char *)buf =
- 1;
>
> Hmph, is this correct?  I would expect that the "header" part of a
> commit or a tag object excludes the blank line after the header
> fields.  In other words, the "header" would be separated by a blank
> line from the "body", and that separating blank line is not part of
> "header" or "body".
>
> Otherwise, if there is a user of %(header), it needs to be coded to
> ignore the last blank line but has to diagnose it as an error if
> there is a blank line before that.
>

I am a bit confused, Is there any problem with me doing this?

> > +                     size_t header_len =3D subpos - (const char *)buf =
- 1;

"header" part starts from "buf" and header_len have minus 1 so that
header part will not touch the blank line. At the same time, "contents"
part starts from subpos, and it also does not touch the blank line.

> While having this may not be wrong, I am not sure who needs it.  Is
> your "cat-file --batch" topic needs this new atom?

Ok, I will remove it from this topic temporarily.

Thanks.
--
ZheNing Hu
