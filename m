Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A7EC54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 01:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjAZBjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 20:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAZBjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 20:39:05 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69F36474
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 17:39:03 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id p25so387856ljn.12
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 17:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EMHP8QT5HUYYAYxRS6x/C5PERBuMASfGq2d/Oy4wPc=;
        b=THEOPF35ZyKKVIt7y0BHNRwU8MZLmROb/zrbRU/r7FB4MJkR5b1aeWU0cUIUsJG9De
         jpIq6VNaMqiccmPaThgxsE3J/cZw44XRXUXZIqyxD2pBZtrLK09fR4PgNVOS7w8fR1Zj
         yp8yvbytytdUWD+2go9ujmaBTE/pYT8fB+w6+qPW3J5QXo1PXyvWnyyqYhilHM4KVZtt
         qTg/6EzXWMFrW8E8SoY7+vMkPj6OOoTb/uNCEEUS6PJeWrQtQ4MQiv29Bf02/JJGcd8f
         4WCOXOBdy4oBzMNnIK5LvrFVRTC5H6SK0zdkMX3JwEnaJeeixY6McaykOejRvrgM2dtF
         2h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EMHP8QT5HUYYAYxRS6x/C5PERBuMASfGq2d/Oy4wPc=;
        b=gsLwfEXQbRJ7ov/S/Uitq8EJhneiQUkfo1Ky7sphvcV6XaS4Qo9QMlgNuh9h1raWTn
         IqANJCWnM8rxFxfZd2wxRxRsb3gikwrBfaC2+3hz0K6GLcCdWhwA1huqOhPMIEFe4bcO
         QRJCQnCUNiwDHFnFUkq9JYilM3GIgcc5n2dBnI+Ngc3lOZ60fA3Z4mNS81lSVSVvsuga
         IqJfTKkc2KhjkqLZuXX5N1k8NwpkfqO8YewZADe6WD/tS9m/3JqSSSjFNeTvTcGgt1wU
         PC4kYecH/v6S3r9dBqM9z6P6xJr7szoWw1fJtTxDb53xZPGophYPPclIlkqirH1QJZ03
         lNaA==
X-Gm-Message-State: AO0yUKUwNqsh6juo4rFiQRtCsd3IzPU1g02q97UykNV9/9GVNJbZdBms
        DETdHT0n6c/pakfIlHm5v142mkVlinljY0O2cX0=
X-Google-Smtp-Source: AK7set/+ffNvgn57jbgpda8okyo9lMdEwdEMLmV42OOqA6+w7zhNgRPG+XK2eSsRcp/+fAM2CJvvtBXMOrxDxacyDTg=
X-Received: by 2002:a2e:8e8d:0:b0:28d:1eec:de24 with SMTP id
 z13-20020a2e8e8d000000b0028d1eecde24mr357970ljk.125.1674697141621; Wed, 25
 Jan 2023 17:39:01 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <patch-v5-02.19-9eb758117dc-20230118T120334Z-avarab@gmail.com>
In-Reply-To: <patch-v5-02.19-9eb758117dc-20230118T120334Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 17:38:00 -0800
Message-ID: <CABPp-BHyHJLXHU2q9sLsJM54GZzMY5f7dS4SLEfDbWzDKxz_Yg@mail.gmail.com>
Subject: Re: [PATCH v5 02/19] bundle.c: don't leak the "args" in the "struct child_process"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 5:16 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Fix a leak that's been here since 7366096de9d (bundle API: change
> "flags" to be "extra_index_pack_args", 2021-09-05), if can't verify
> the bundle we didn't call child_process_clear() to clear the "args".

That's really hard to parse.  Perhaps:

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05).  If we can't verify
the bundle, we didn't call child_process_clear() to clear the "args".

> But rather than doing that let's verify the bundle before we start
> preparing the process we're going to spawn, if we get an error we
> don't need to push anything to the "args".

Also hard to parse.  Perhaps:

But rather than adding an additional child_process_clear() call, let's
verify the bundle before we start
preparing the process we're going to spawn.  If we fail to verify, we
don't need to push anything to the child_process "args".


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  bundle.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 4ef7256aa11..9ebb10a8f72 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_hea=
der *header,
>              enum verify_bundle_flags flags)
>  {
>         struct child_process ip =3D CHILD_PROCESS_INIT;
> +
> +       if (verify_bundle(r, header, flags))
> +               return -1;
> +
>         strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NUL=
L);
>
>         /* If there is a filter, then we need to create the promisor pack=
. */
> @@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_head=
er *header,
>                 strvec_clear(extra_index_pack_args);
>         }
>
> -       if (verify_bundle(r, header, flags))
> -               return -1;
>         ip.in =3D bundle_fd;
>         ip.no_stdout =3D 1;
>         ip.git_cmd =3D 1;
> --
> 2.39.0.1225.g30a3d88132d
