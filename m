Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37D31F576
	for <e@80x24.org>; Sat, 24 Feb 2018 08:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeBXIPn (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 03:15:43 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45951 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeBXIPm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 03:15:42 -0500
Received: by mail-qt0-f196.google.com with SMTP id v90so13377967qte.12
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 00:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=j+z12zQ0jmiCd/HeuA2prpYSjtnHG5pH8TxEqi8vamk=;
        b=lsucshf1mlv16bgaTqyIC8SB81xrCMfDkzMNbo6rcBumJuIfguu1eDDhNKGihmLtzj
         W6HvdUjCYNmYS5Vax6wFwa3KJvxomw/+KaSjj8KEFkEAc+sJF2jAW7I42Jim3IZiRCZy
         MuULP6uQ6ROLEwGqpz0KX0D9XSIyLiiFxKgp8hLhvk586ZizafTpwmBQCjhPLlk7cY4b
         GDZkWi5x2kWgkXQMnw6gfovhdMwswJRsdaWqd4CMw7BxJd0jRiHZoICsmdDYgCiNu6rK
         nMpa1KYNpYSCepAo4pP1Rc45P95AlmuX9Yuw7L8kTTS3pd5RTwjKZAs6A9aIgN+xvjfW
         yGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=j+z12zQ0jmiCd/HeuA2prpYSjtnHG5pH8TxEqi8vamk=;
        b=RCZH1qnzC4k45VEY92wzgyEWKH6vgzhidYPAD/jkqmw8KbU4G6K/kiiFl+4tmDfrF8
         N2SIpYpo81Rq8BL0J6+AqCBnKtsJwGHs4c3yLzefPaADe3UruLuuoCU+xNuLMdV8LF/M
         xgHCOPotQxeoFKQ15/h3rPGAg4o/eg9/IRMSR6euj6Kzjh92lLw6k+3hNB3E7sJSTfmN
         DrYWEzkgE+hugVpawCbmaveC3h5yXZ1p/NDHvMA++mBSnIfJDa3w6LyXRLZ0Kjcxt2dI
         iy0eaasiX7jDU1qLuEFrazHpAD5lWxm9bGjhxo6k6EpqTnHVs5de4jUPXQiyx3eD7svC
         GfRA==
X-Gm-Message-State: APf1xPCgQmnmwV4G29rQOrgxZ6fVI4zgHy54ogntogdza2k0D5y2NZRj
        Ndc6cpXsvh2hNT0cFVQI/PXGMRmC5iUS6PkvdNQ=
X-Google-Smtp-Source: AG47ELvsfLUTMgibYCRpkkzuP+Go1WoDbQNLTNKMtqs2ypfpwZdVUtKRnorY4zJCgxqitkNg3xsM7rJCcjChJ5dDIhA=
X-Received: by 10.200.58.167 with SMTP id x36mr6865023qte.246.1519460141956;
 Sat, 24 Feb 2018 00:15:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 24 Feb 2018 00:15:41 -0800 (PST)
In-Reply-To: <20180224033429.9656-5-pclouds@gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com> <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-5-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Feb 2018 03:15:41 -0500
X-Google-Sender-Auth: -GXf8I1g-xbG1OHCZJSFjXOCrLM
Message-ID: <CAPig+cQq32eyArKME4_H0njjn2mbPkNVKo=ULbh-16d55tVYOQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] diff.c: initialize hash algo when running in
 --no-index mode
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 10:34 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> Our "git diff" command supports running as a standalone tool. In this
> code path, we try to hash the file content but after
> 18e2588e11 (sha1_file: switch uses of SHA-1 to the_hash_algo -
> 2018-02-01), there is a chance that the_hash_algo (required by
> index_path) may still be uninitialized if no repository is found.
>
> Executing index_path() when the_hash_algo is NULL (or points to unknown
> algo) either crashes or dies. Let's make it a bit safer by explicitly
> falling back to SHA-1 (so that the diff output remains the same as
> before, compared to the alternative that we simply do not hash).
>
> d=C3=B2ng =C4=91=C6=B0=E1=BB=A3c

Accidental paste?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/diff.c b/diff.c
> @@ -3995,6 +3995,18 @@ static void run_diff(struct diff_filepair *p, stru=
ct diff_options *o)
> +       /*
> +        * NEEDSWORK: When running in no-index mode (and no repo is
> +        * found, thus no hash algo conifugred), fall back to SHA-1

s/conifugred/configured/

> +        * hashing (which is used by diff_fill_oid_info below) to
> +        * avoid regression in diff output.
> +        *
> +        * In future, perhaps we can allow the user to specify their
> +        * hash algorithm from command line in this mode.
> +        */
> +       if (o->flags.no_index && !the_hash_algo)
> +               the_hash_algo =3D &hash_algos[GIT_HASH_SHA1];
> +
>         diff_fill_oid_info(one);
>         diff_fill_oid_info(two);
