Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872B41F404
	for <e@80x24.org>; Sat, 24 Feb 2018 14:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeBXOgf (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 09:36:35 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39927 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXOge (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 09:36:34 -0500
Received: by mail-oi0-f67.google.com with SMTP id t185so7767640oif.6
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 06:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p96QOD0Zi1O6ffSeE/RYIuhcg3Hd1XBME5A3sGATdoE=;
        b=sQB6qte2hswheoErobmzFBfoqgThvnP6qjILOSXcGvinNW1drZlF9f7vG672wj4I+u
         mFTZZsoPPV71z68SP4k/FXbHKb+vsDQpCwhI6p85o+QO54AlbDBwmMJMbBPnc/NhZuWv
         3agh3oZqgm4BBxEwXau91B67T2BoOpuEMtVHXKr4aYkqaxoDmWjPxD9uEJhOpkQtFwjf
         N31Ww4l4JA0xqsCPJpzm7+A8BWj+gTDznGp0WG8qIDXv1JTwuC95yFwmejijLwfYlEJ3
         q2ksphzkFDiW3Yi95Va5Daxg13m1O4/8rmhPdTvJq3lmXy9LbAcgJHD3hqkepIiApcov
         iAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p96QOD0Zi1O6ffSeE/RYIuhcg3Hd1XBME5A3sGATdoE=;
        b=HmdEPE8mr/gtF4+Mu5KtUnzmNjOcWIQcIbIF1OVcdREe+ku6sjU1BWCdWVV2R0kur3
         wqkRGHQKy3TIPySgkrDKke82qf/tSqi13rQiA5hFvKjtoSFhLzE2vm+eYK9I3MekxdU2
         YlO69c5aeg7KxcMMxc0zR1nmO27Cbok5dIcczJMBcLtP/t09Oj8UZrYvYIer9RlK0oZW
         qK8eyu6WzTaacB2cifCPH+DedjNMR8uk//xETpTBcgyfYhRUioUlTFtF81IZb+zXOCJ2
         TbK09UtvaP7J2F/8eKeqg84k5PQCecRPcraETC5dYgVIfp3TWCOr8CBcAxxFvca5P6Bz
         659Q==
X-Gm-Message-State: APf1xPA1lazmNL3ZiH3N1yeHnndRPFGvrh8xcvI7TEmliVRia0rWQkuj
        3+z5HYdhFswbKMJdDSHPYXzZWUHo5IJ9USzvC6jrPg==
X-Google-Smtp-Source: AG47ELv0pgb3NGSql+/9oUkX/qATP8zJ+2tGe/ZBnYC0C68MqxIdIN31XnuyHmj2EacMQSd+iE/a01svLy6CzQPdrIQ=
X-Received: by 10.202.83.129 with SMTP id h123mr3205393oib.228.1519482993803;
 Sat, 24 Feb 2018 06:36:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Sat, 24 Feb 2018 06:36:03 -0800 (PST)
In-Reply-To: <20180224033429.9656-5-pclouds@gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com> <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-5-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Feb 2018 21:36:03 +0700
Message-ID: <CACsJy8AUXf4uA-zymrhWUagW84bUzfB6JBQLyaHDJtudTcNy=A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] diff.c: initialize hash algo when running in
 --no-index mode
To:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 10:34 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> @@ -3995,6 +3995,18 @@ static void run_diff(struct diff_filepair *p, stru=
ct diff_options *o)
>                 return;
>         }
>
> +       /*
> +        * NEEDSWORK: When running in no-index mode (and no repo is
> +        * found, thus no hash algo conifugred), fall back to SHA-1
> +        * hashing (which is used by diff_fill_oid_info below) to
> +        * avoid regression in diff output.
> +        *
> +        * In future, perhaps we can allow the user to specify their
> +        * hash algorithm from command line in this mode.
> +        */
> +       if (o->flags.no_index && !the_hash_algo)
> +               the_hash_algo =3D &hash_algos[GIT_HASH_SHA1];

Brian, are we supposed to use the_hash_algo this way (i.e. as a
writable var)? Or should I stick to something like

    repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

which allows us to notify other parts inside struct repository about
the hash algorithm change, if we ever need to?

If the_hash_algo is supposed to be read-only, maybe I should convert
that macro to an inline function to prevent people from accidentally
reassigning it?

> +
>         diff_fill_oid_info(one);
>         diff_fill_oid_info(two);
>
> --
> 2.16.1.435.g8f24da2e1a
>
--=20
Duy
