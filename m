Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC832C433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiFZNgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiFZNf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:35:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD685EE26
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:35:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id k6so4428909ilq.2
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fsjfPLGleI4LWonIDbgPvWcYuv48H5DyXb1fVegiDUc=;
        b=X6oD5Buh3u+Ot4kVkNfGEqoB7oQZl8k5wdeUKT6owBNTFl3lrQytLYGttuKjV0sq3o
         j7e0I5PuiVkszQF9vZ7TE1tL01K3McdpKsFn8h37Vr+tQn/FvQpzxStwkWM+IHS5w8Vb
         EkDcGC1ZDXSD9F7vd0vKJAyIHa+gc9oQj5xSwFpGqdRdmxFZmuXXtIbwCZCt6KrhdnQp
         fQ5IAVyB9noUGoXVwno0NMOr6zFgEcitlF0gfnfzw0DNyf6PO4lRhtEDdLTDmQiTj3O+
         6iuKSfblwGDxqlIyna+xDsxwW3dbLTD2ux/f761yaa3OmrSZu78boBN6WOx89Q5I9st+
         WCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsjfPLGleI4LWonIDbgPvWcYuv48H5DyXb1fVegiDUc=;
        b=5cOhAF5XaAfjzSqA4F8RONF+dx4+0dhOPWhcMOB2lOd+8Iwedp+ofy9n/Irt3bWpzq
         DLg669E3Y4SxzAV6ufyZV0CcJCXrE4o0SrFbb+MrcDRt3MUFPMCslj8D/KMU7dTalSDk
         /BPrsq6ZQl6dskCpFcKm3LU/U3JCmDTVunLQbNIF167cnySI/Io6Z2N60YcOZO701VK/
         frPfoS4FhRdHRE0vCCe1MUGWq++bbhUIjeRhUyjSTvHdmsustVX4Gy8O5h3ToYwrd7e6
         cdtvt5AOedSfnvzFFSCsiSs8qsmHmN5mpMX2q83OYCsVNpmzRQG5aeDi8KD/EUA9Elso
         TjJQ==
X-Gm-Message-State: AJIora/hOhh8QPTz8Q9AkDSS6yHVmn/m6ec6iusnMxXdtevPJoEe7q1x
        QXIzSaqS/HcOmyCxm2E6pEhkPgk2MnmlH28RCzk=
X-Google-Smtp-Source: AGRyM1utsdcrjw4wGbFzvGDNIoR/Y9z9tb+2TsW5qLNR5fsr6GJEHyOe9+foDhcYZ52R+MWetI8oseN0mcVVUgcEyPI=
X-Received: by 2002:a05:6e02:1bc8:b0:2d4:342:9c68 with SMTP id
 x8-20020a056e021bc800b002d403429c68mr4676301ilv.254.1656250557064; Sun, 26
 Jun 2022 06:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com> <220624.86letmi383.gmgdl@evledraar.gmail.com>
 <xmqqsfnuvzxc.fsf@gitster.g>
In-Reply-To: <xmqqsfnuvzxc.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 26 Jun 2022 21:35:46 +0800
Message-ID: <CAOLTT8Tc95-aUE+uN2d8QjTJpGpGw6cBJfG+bpmyE55OcXTSRA@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 23:33=E5=86=99=E9=81=93=EF=BC=9A
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Tue, Jun 21 2022, ZheNing Hu via GitGitGadget wrote:
> >> +    if (skip_prefix(start, "(objectmode)", &p))
> >> +            strbuf_addf(sb, "%06o", data->ce->ce_mode);
> >> +    else if (skip_prefix(start, "(objectname)", &p))
> >> +            strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
> >> +    else if (skip_prefix(start, "(stage)", &p))
> >> +            strbuf_addf(sb, "%d", ce_stage(data->ce));
> >> +    else if (skip_prefix(start, "(path)", &p))
> >> +            write_name_to_buf(sb, data->pathname);
>
> These are just "values".
>
> >> +    else if (skip_prefix(start, "(ctime)", &p))
> >> +            strbuf_addf(sb, "ctime: %u:%u",
> >> +                        sd->sd_ctime.sec, sd->sd_ctime.nsec);
> >> +    else if (skip_prefix(start, "(mtime)", &p))
> >> +            strbuf_addf(sb, "mtime: %u:%u",
> >> +                        sd->sd_mtime.sec, sd->sd_mtime.nsec);
> >> +    else if (skip_prefix(start, "(dev)", &p))
> >> +            strbuf_addf(sb, "dev: %u", sd->sd_dev);
> >> +    else if (skip_prefix(start, "(ino)", &p))
> >> +            strbuf_addf(sb, "ino: %u", sd->sd_ino);
> >> +    else if (skip_prefix(start, "(uid)", &p))
> >> +            strbuf_addf(sb, "uid: %u", sd->sd_uid);
> >> +    else if (skip_prefix(start, "(gid)", &p))
> >> +            strbuf_addf(sb, "gid: %u", sd->sd_gid);
> >> +    else if (skip_prefix(start, "(size)", &p))
> >> +            strbuf_addf(sb, "size: %u", sd->sd_size);
> >> +    else if (skip_prefix(start, "(flags)", &p))
> >> +            strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
>
> These are not.
>
Agree. So I just remove them as you see. If someone else
need them for some reason, we can add them back.

ZheNing Hu
