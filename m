Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04370C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03C6206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc5Khoa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEPLQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgEPLQ6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:16:58 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A18C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:16:58 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g15so1752837uah.5
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tcObnSybsFdRWileqs0r2wcL+gufzlcTGT2TmXxUoc=;
        b=Sc5Khoa8a9hN5clMG3v1+0FHZblQhetwn/HYkt+M4iXZsQAXlz9/6nY9nINOk1f+zY
         Qwkp1BZTkk5sV0ZXsKsGzOV68m1Mt8nd1TBNe2vW6Hw303xuoe1/pC9aT0fbVJub+IzU
         48E9XQUPgIAkLvIe+x+hlHXrzkiHbYlqIEB8R8AYYfaAIYHC0mxfO4fDCzGaPYwxAc2K
         AhlJXXrXV2DKpbexi5ZimS9LZDsCVht9wMXDivxt9GCANo0t4pI9H6Jt42bcUPTqtUW9
         X6Z4vmbiIdUL09k6n3oKmKieWWEHrUDTHKQWPUeOqh/jSpUYzbMpTMsvPy/0HDI6Czjj
         tkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tcObnSybsFdRWileqs0r2wcL+gufzlcTGT2TmXxUoc=;
        b=nFZqOqAfcVxza/4r+N5Vtj7IBtfyqmhlclEgXcoIV9JoWSc3SSOnlcR2Lan313u5Ic
         Fmc6isXnavb0LedaCyI9csL7EbC6fNWLibTQrR4akhN7iYmdb8SIN3+0SVaI9ODZNj9F
         H+rlOmNE+6Iv3P0ZR5PvT+yUI5i7rBes/zFzCQYtj2K/z4XXe+XUu+Oi1RYLBc6CdSM6
         4k+iApDS/xPh5qPanElP2X5xxwV4lgOlL7BGIrpIw79s00KsCdYpiclUYG59jzXw1WNK
         dyhoUS1Sk7hXlwDYxIPaP2zbP/uc8uRC8m4tXaJvtz8/B8Pi/aq9EZfsldiUr5eoBVje
         ZWAg==
X-Gm-Message-State: AOAM533W9o9PVJwtrxGzOlPjScPAnCVWfsxu58pakbK9SOmQTYPbTmnc
        ttmypbewv+58BBMGwDQed6cZJupN4arSEYgSezUTKA==
X-Google-Smtp-Source: ABdhPJyTS6dH4Hpz3ISbgQ/6DE31UPPSC1Pk84Cinq/7S8McoASoiJx51DakD2xIX6nEcsj5PZ/X2u7vBTLLyRF0CL8=
X-Received: by 2002:ab0:1e4:: with SMTP id 91mr867086ual.112.1589627817225;
 Sat, 16 May 2020 04:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-35-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-35-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:16:46 +0200
Message-ID: <CAN0heSrLxatUNbJPZDmMC=NtF4R_AZF8gF-pUwJ+uQFMp3A6-w@mail.gmail.com>
Subject: Re: [PATCH 34/44] builtin/ls-remote: initialize repository based on fetch
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:58, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> ls-remote may or may not operate within a repository, and as such will
> not have been initialized with the repository's hash algorithm.  Even if
> it were, the remote side could be using a different algorithm and we
> would still want to display those refs properly.  Find the hash
> algorithm used by the remote side by querying the transport object and
> set our hash algorithm accordingly.
>
> Without this change, if the remote side is using SHA-256, we truncate
> the refs to 40 hex characters, since that's the length of the default
> hash algorithm (SHA-1).

Could we add a test that passes now but would have failed before?

>         ref = transport_get_remote_refs(transport, &ref_prefixes);
> +       if (ref) {
> +               int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
> +               repo_set_hash_algo(the_repository, hash_algo);
> +       }

This will modify `the_hash_algo`. Quoting commit 78a6766802 ("Integrate
hash algorithm support with repo setup", 2017-11-12):

  Add a constant, the_hash_algo, which points to the hash_algo structure
  pointer in the repository global.  Note that this is the hash which is
  used to serialize data to disk, not the hash which is used to display
  items to the user.  The transition plan anticipates that these may be
  different.  We can add an additional element in the future (say,
  ui_hash_algo) to provide for this case.

Don't we violate that here? Is it mostly luck that we can go on to list
what we want to list and that we will never write to disk based on
`the_hash_algo` being "wrong"(?)? Or am I missing something?


Martin
