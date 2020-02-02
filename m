Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D587BC35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F52A20658
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfTVjjpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBBTpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:45:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37913 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBBTpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 14:45:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so5404375pjz.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 11:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+mrUG8G7tqh4GaDFgUx3hZjjyRpi9zAg/EmKPZdCb4=;
        b=UfTVjjpwT0S++lBoa2WXSAoPNzp34e0+mSt3CSjFB6UmmnO4NiBaokShx/+k2LtXKj
         8HDWWLuOTVhH66GB/xSYDQBxBh6hPBN0eaZTnXf0AbhtGPEW6xX+s/gppaI3h4mbplP7
         Z/5t1OoDgyyROD8WJDGGkAlHp48lC6xkS+Ph8MMMG/v9kXexttMLATn4yuD4BoQpvP5j
         mdly1bFNzfQKDvMcxQ8ScueI+Y0vKuBwh6nKvdCcbMpHZIXV5aSpt6/GGL9vCreeNLw3
         MugisBBOIs5wc1uyjWfVzpGV8eJyWzBHkNy1AKT3YFPoFH48aqf5ZNtdaQw71MCAFylk
         EMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+mrUG8G7tqh4GaDFgUx3hZjjyRpi9zAg/EmKPZdCb4=;
        b=iujZrrISq+oZr3xIWbFfCKZcOJoWR40I/cygmflFUBEHIGigBbyyc7VV055EIY/Y2U
         Sj9f3+lv8DvhCMo5KR3bWMi2s8W8J/Mr2wSZgOYarzNZtLvKbXluZrfRTbH5qmn/uu+6
         ZtBjkYcEFyclrstrKpKnM4GQV64VKyACtpr7RyRN6gH3B6BkcZ+yumaZnMjD9XbIHg3P
         DPU831ZFk4TNCtV5fFVuRPyjGjGGS8tGPYXc1/0Q5IPhooklbZ4zBmVHCft5VJ8JEMqO
         3bRwHSVub/UvtdNBWNbCDqg5NeXwlltYQ2VQ3RDQPC7sXNRuatgeUUrccopnMbAW346I
         VzPA==
X-Gm-Message-State: APjAAAU/IyG7OcNs6UwXIZQW1C/vrhIuhXfwRhEHRmVWJz8yenZ3CQwM
        lzl24es7D73PHhPnZldeiIBatSXNs8+jwOX7KpM=
X-Google-Smtp-Source: APXvYqyE1CNhBvFNeJhALxc75uDbHCSjZyzUhvmw144PL500+8mUvDrQ1WsmNP2MT2X7n2Lr+rPUquXjURlIsh76P2o=
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr19733515pln.178.1580672752529;
 Sun, 02 Feb 2020 11:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20200202192226.29176-1-adam@dinwoodie.org>
In-Reply-To: <20200202192226.29176-1-adam@dinwoodie.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 2 Feb 2020 20:45:41 +0100
Message-ID: <CAN0heSoxgsNDbi_tbxEoSSaGOxoJYArqYa-cLu1sPWVvH6wkFg@mail.gmail.com>
Subject: Re: [PATCH] diff-options.txt: correct command syntax
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Phil Hord <phil.hord@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Sun, 2 Feb 2020 at 20:24, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> Change the example arguments in the description of the -G diff argument
> to be consistent throughout the description.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>  Documentation/diff-options.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 09faee3b44..84a74cb2da 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -561,19 +561,19 @@ Binary files are searched as well.
>  -G<regex>::
>         Look for differences whose patch text contains added/removed
>         lines that match <regex>.
>  +
>  To illustrate the difference between `-S<regex> --pickaxe-regex` and
>  `-G<regex>`, consider a commit with the following diff in the same
>  file:
>  +
>  ----
>  +    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
>  ...
>  -    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
>  ----
>  +
> -While `git log -G"regexec\(regexp"` will show this commit, `git log
> --S"regexec\(regexp" --pickaxe-regex` will not (because the number of
> +While `git log -G<regex>` will show this commit, `git log
> +-S<regex> --pickaxe-regex` will not (because the number of
>  occurrences of that string did not change).

I don't think this is correct. "<regex>" is a placeholder and this
example wants to use a real-world regex instead of the placeholder.
Maybe this could be made clearer by having an example that does not try
to grep in regex-code using the regex "regexec\(regexp".

Maybe instead of "regexec", "regexp" and "regmatch", this example could
use words from some other domain? Would something like this be clearer?

 To illustrate the difference between `-S<regex> --pickaxe-regex` and
 `-G<regex>`, consider a commit with the following diff in the same
 file:
 +
 ----
 +    return !frotz(nitfol, two->ptr, 1, 0);
 ...
 -    hit = !frotz(nitfol, mf2.ptr, 1, 0);
 ----
 +
 While `git log -G"frotz\(nitfol"` will show this commit, `git log
 -S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
 occurrences of that string did not change).

BTW, I wonder what "in the same file" tries to say -- my hunch is we
could drop those words without any loss of correctness or readability.
Would you agree?

Martin
