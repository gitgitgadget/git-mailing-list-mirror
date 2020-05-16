Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782ECC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BF02074D
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOi5lMoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgEPKzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 06:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgEPKzp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 06:55:45 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC819C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:55:44 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u12so2802830vsq.0
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+R/GjULBqsSYTYBvwDIQk5PVtwTwozcJeSTnN7CbgYw=;
        b=DOi5lMoB5S+xchdgh6fVCkivQyVlTE5uR56e0wVf7vpXs0c9hyKPvVWtUi8s4DcWhr
         xDnLWtl4jel5/rCZsvNuD4mL9P/+w+CSCyCJ+c8Nv11JAk6gkuYv7SwkKbYz2gpE0TH4
         KYgvxt7tTeLbiknlA26lwCqrclo2njg4chwMH+TitkQKRYjBYvujCxNikFPNmwiRvN2P
         XQEFrmUWYITGojgGvw+u1pM3kZe1GvGxHkdfqwwXPK1RsDfSMa6Wc2J16BcPBl1Vitnj
         0G/dNY8z76KiR6idFeaUd+lQoMyudwrw9Je7TJxbWLySaBJb1YIcWEz7wN8Ghh23coxe
         MSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+R/GjULBqsSYTYBvwDIQk5PVtwTwozcJeSTnN7CbgYw=;
        b=pYCBzM9b84oWuHMdJsr39y9swVuBLIZJGrcWNTDqnhH76aJ74IOd69gHi6+ruGgqIX
         3XsRnI+TaY7KSIZ9q2mNsX8WuEhRzlAXHbQU3NHi19Rph2xe4TLXqIpAUaO+oYAV8dss
         Q8nEw17BDDE608bNmouwNSa1Eq7tD3wKLP36aBh2y5CvFXrb+l4w4GsHAn/ULcbVj+u7
         UVcN8MjkdfAaP9iOb7nOMRRx9FtgPIViIYtnBkkjEpkXnvVsOixW6z1m0qVvFABRz5Fi
         GSERcC9iZRtbQhfjCd/7OWwQAhLmSkpC5zRz/SaKHt725uM+s1wGDRJ4MCJSGKnl1IId
         yocw==
X-Gm-Message-State: AOAM532tldfAlu0TFAn3L/P9FM5LvIZaLbf47tzV4gUgIuXJIOlSeOif
        lyrGpoF8rh3+nL/bkNePcd9Oq9IQdtxZD2UBgZc=
X-Google-Smtp-Source: ABdhPJzDyyWW4lShjthBj8J0P7WcDQb7weyd/JMqcJIbo4+qIXR11eLngAh60lQJSTxNfjoPLZxV0kpEqcnPGE9Kk1A=
X-Received: by 2002:a67:f4c6:: with SMTP id s6mr5298685vsn.46.1589626543990;
 Sat, 16 May 2020 03:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-21-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-21-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 12:55:33 +0200
Message-ID: <CAN0heSqVrOTpSpptqe+zu+9-qQVYAL=jcx7tas3pNRcSVH+auQ@mail.gmail.com>
Subject: Re: [PATCH 20/44] t5562: pass object-format in synthesized test data
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Ensure that we pass the object-format capability in the synthesized test
> data so that this test works with algorithms other than SHA-1.

Right.

> In addition, add an additional test using the old data for when we're
> using SHA-1 so that we can be sure that we preserve backwards
> compatibility with servers not offering the object-format capability.

I'll have some questions on this below.

> @@ -62,8 +63,8 @@ test_expect_success 'setup' '
>         test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
>         hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
>         {
> -               printf "%s %s refs/heads/newbranch\\0report-status\\n" \
> -                       "$ZERO_OID" "$hash_next" | packetize &&
> +               printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
> +                       "$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
>                 printf 0000 &&
>                 echo "$hash_next" | git pack-objects --stdout
>         } >push_body &&

Makes sense.

> @@ -117,6 +118,15 @@ test_expect_success GZIP 'push plain' '
>         test_cmp act.head exp.head
>  '
>
> +test_expect_success GZIP 'push plain with SHA-1' '
> +       test_when_finished "git branch -D newbranch" &&
> +       test_http_env receive push_body &&
> +       verify_http_result "200 OK" &&
> +       git rev-parse newbranch >act.head &&
> +       echo "$hash_next" >exp.head &&
> +       test_cmp act.head exp.head
> +'
> +

Hmmm. Isn't this an exact copy of the 'push plain' test immediately
preceding it? The commit message talks about using the "old data"
(i.e., without "object-format=%s"?). Should this test use a variant of
push_body where we're not adding "object-format"? I'm not sure I grok
what exactly we want to test here.. And does it really belong in
t/t*-content-length.sh?


Martin
