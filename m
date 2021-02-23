Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB2C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056C064E2E
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBWGto (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:49:44 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:40039 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBWGtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:49:42 -0500
Received: by mail-ej1-f54.google.com with SMTP id u20so32190274ejb.7
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jB/zphZZpmghKexQgRtljqCpmfTF97oFoU+TLvgPM3w=;
        b=GSOLN/UWVmkDZQ2owJ3Ne713h9g2HaCp6i8Uf/4orix3GELptC7k96Pn8TSofPT0cu
         ePmBRgXUH8GNQp4XM0LYo4yZsJ3tf3RRqNtn/4PXmNMqMXjI4Iak8FkSciSxHM8z+o5b
         IHg3h2CniBc/TAFxXueqJR/uZzp44kRN6p4vc+slCzOe4h+PVUOZ7Kvti2vWPRSWysMI
         kWmA0iqz9R6pB14pMf5tUApOljT762ZrA/6DrF0eAa2o/0g88WSsHQwuU+plxYeJBXLp
         ZxPhIo9bUTHvRFKjO1/c6WOqt9KM3YEeyoRaJZtRL8WuQcaIznJklhO6wTPveQaVIduP
         +WoA==
X-Gm-Message-State: AOAM532HPQIj829K74RxX65ZtvjhNl+kb4ReugQHlt+Nsqxaw6JYxrXm
        m9uXkXrGbTtuiw42CqpqBhjC+TxhdrtE7Ua1JGk=
X-Google-Smtp-Source: ABdhPJyUd7V8jSIz760jHvEpTLXR4mqQRjMgovuFRcIKxGZu4TZaml0eQgOWGbTkTYX2XWMkw5XQd4rWP/vIVQV4jOE=
X-Received: by 2002:a17:906:1fc7:: with SMTP id e7mr16670886ejt.202.1614062940851;
 Mon, 22 Feb 2021 22:49:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614062288.git.liu.denton@gmail.com> <a24cbbe955f45072ffa88ca16f84e2443720a38f.1614062288.git.liu.denton@gmail.com>
In-Reply-To: <a24cbbe955f45072ffa88ca16f84e2443720a38f.1614062288.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Feb 2021 01:48:50 -0500
Message-ID: <CAPig+cSy3M4Lp6ej5ca47GzAAOPz2Q9p6cSZWsLs9STu-KauSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] git-cat-file.txt: remove references to "sha1"
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 1:41 AM Denton Liu <liu.denton@gmail.com> wrote:
> As part of the hash-transition, git can operate on more than just SHA-1
> repositories. Replace "sha1"-specific documentation with hash-agnostic
> terminology.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> @@ -200,7 +200,7 @@ object, with placeholders of the form `%(atom)` expanded, followed by a
>  `objectname`::
> -       The 40-hex object name of the object.
> +       The full hex representation of the object.

I find this new terminology confusing and ambiguous. To me, this seems
to be saying that it is a hex representation of the entire object
rather than a hex representation of the hash of the object. Perhaps
say either "hex representation of the hash of the object" or "hex
representation of the object ID"?

> @@ -215,8 +215,8 @@ newline. The available atoms are:
>  `deltabase`::
>         If the object is stored as a delta on-disk, this expands to the
> -       40-hex sha1 of the delta base object. Otherwise, expands to the
> -       null sha1 (40 zeroes). See `CAVEATS` below.
> +       full hex representation of the delta base object. Otherwise, expands to the
> +       null OID (all zeroes). See `CAVEATS` below.

Same issue. "hex representation of the delta base object" sounds
misleading. Should probably mention "hash of the" in there somewhere
or something.
