Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4030EC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207CD207BB
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvPurM0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHBQIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBQIU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 12:08:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E2CC06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 09:08:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so31960845wrj.13
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vN/cANN1vgxuEq33zAHb0Y0/Spp5ooISs1tzUQf8aq8=;
        b=JvPurM0f+xcTbm9xy55w74tolBGM6Gr4/AbkI5+2WlxiTMAvX1K5EXBhz2t4rq1dlA
         svh6EtRUbyixZH2Ff3sEkgO8r2F9Q96D5m8jXHDWFWC0Wk/HopxbjYmPqXHRlRbw/bkz
         +uTInsszcZDOIrJyGZlSo6MaUESkcXVaahDio1TbPdCBBVVjsa/Ip50h/ZGhAc46Z+F9
         xBhjnVK1a4IOUCkumrDD/J3pHvLAUBLr66xVlq/bNGyWAwjsQ8Ozz1u/7cIQ4/BhYxcu
         am1cFaftgMBth9XwQUROmV7f5L9JCzr4uyvfiYQ7GyX7s1keBhH5L7uFEUeMdhVTs2Jh
         TgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vN/cANN1vgxuEq33zAHb0Y0/Spp5ooISs1tzUQf8aq8=;
        b=TjxnFHAbkfdEwBurGX0FTzPkStQlHaQ+OOFMAEmt9XPqb3ruaP9MVvSkOB2LGNjfGt
         Rmz6d0wkQrch0e76TanswOM+be18IcIWVzvSIhvVFhcVIhGYPa0mBJp7wnyh6FTLzIOX
         J7twyRCHay9aEwdpRFRLYQ64B8gOtLU8zYoMi4uJTrV3R0eh8kXdPMqtrfRfjNIKOP5k
         abDc53vg/UB37A7TgHZFvpKmEt2tNBWOskuaM/n8eTkP6Ywa4iuHm7+GjF7iOGQbTpOy
         zjjdWOWkjFGTqbeVSm9Nek36vI6KDGkBn1dQGDnWePS4GbH9ehpCjKiNrBvNjfb3OlcJ
         n1+g==
X-Gm-Message-State: AOAM533aIJ9+8rrEa9qCqKrJ5vpq0n5OHhtYD2GHJw2Wbgt8c8XX86bE
        3qck7yfGEQA2yhZMGGMe7xSIswQTu6nWLTbY3u4=
X-Google-Smtp-Source: ABdhPJxqrRfl7D+MgNn5chAg1ZedRJB6tCZJFtJgVoayIwzERvaG8tgLglYigdpRZb02R9U46zkmJvLGp6fuoxdKAak=
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr10832494wrx.50.1596384498683;
 Sun, 02 Aug 2020 09:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <2e2907ac-3be9-c0ed-830a-f8aa28b471aa@web.de>
In-Reply-To: <2e2907ac-3be9-c0ed-830a-f8aa28b471aa@web.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 2 Aug 2020 09:08:08 -0700
Message-ID: <CAPx1Gvesmwf_CBj6D=YriFQgtEsDyUe7PHa6p9AvxG=fwAvHpA@mail.gmail.com>
Subject: Re: [PATCH] connected: use buffered I/O to talk to rev-list
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 7:39 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> @@ -135,16 +135,10 @@ int check_connected(oid_iterate_fn fn, void *cb_dat=
a,
>                 if (new_pack && find_pack_entry_one(oid.hash, new_pack))
>                         continue;
>
> -               memcpy(commit, oid_to_hex(&oid), hexsz);
> -               if (write_in_full(rev_list.in, commit, hexsz + 1) < 0) {
> -                       if (errno !=3D EPIPE && errno !=3D EINVAL)
> -                               error_errno(_("failed write to rev-list")=
);
> -                       err =3D -1;
> -                       break;
> -               }
> +               fprintf(rev_list_in, "%s\n", oid_to_hex(&oid));
>         } while (!fn(cb_data, &oid));
>
> -       if (close(rev_list.in))
> +       if (fclose(rev_list_in))
>                 err =3D error_errno(_("failed to close rev-list's stdin")=
);
>
>         sigchain_pop(SIGPIPE);
> --
> 2.28.0

The same ferror()-before-fclose() remarks apply here too,
but this time the explicit errno checking (EPIPE) cannot
be done -- it's too late, errno is probably overwritten.  I'm
not sure how valuable the explicit errno tests are in the first
place so I will leave that to others, but if we want to keep
the explicit tests, use:

    if (fprintf(...) < 0)

to check each fprintf(), and add a final fflush() call (with
another check) before the fclose().

Chris
