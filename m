Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E3C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E8F6115C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhDITDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhDITCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 15:02:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4CC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 12:02:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hq27so10246940ejc.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xk/KmK0Od8hIxrU4xLkQnDqVhuULpZtPscjqnPHCoaA=;
        b=ByBpop8LEdjBQYYSo8Lzdz1WNm1hjdKZiwVy26cHkvOOrp3KXGqQLMvBFHbW0vWWQJ
         hfS6MeFtd3EUQgL7g665Qy+vL3oDosdpLFMFzbIlX7vFnDNm1jvcpax6n+ToC0BMcFvu
         orDlN2XVKmdfFn4Eo0AUjJ9+8r7bFg8PYwaZtFKGblpJTJDXvai7Zpdl9XPdZnzW+ebZ
         9jkZTFOxv03L8H54iNkiUDp1eMkhDyPJPlvPW4EP/5Bb7DCZfV9RU5fCgbY6KT1xEWVH
         8uKeF0+UoZZgcbtHqqnzdrCE2l96b6cD8tTbXIj0JVrzFEslO0Lk654h7wR8clqfW7dP
         X1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk/KmK0Od8hIxrU4xLkQnDqVhuULpZtPscjqnPHCoaA=;
        b=YTkonljx8VPcAxxp/HTOxzcCfX7ZOBkCFQLFkTz7DIMcVe+YeXnqDxWUIEw518OToM
         EOpYG/adaEHkQiJMl0uc5ledHREvMFQtjwsJYNu1ZIysyvIkqI/a6VPVo4cRUKp9KPWr
         BhQk8Tr8vGgrKzLqodTEGGIDKTCq627v/3JeAU9Y6BUj1hkkd5AOUd+zwSWwcWgEOxrA
         TH0nBVNRnNBYXk9I7Q9RxM2ynmD/JKN1+RBvCIeUMzzG+00WUsStS0GGsu4nos4/opjD
         FM7Rt6nchmTiAx1T8cbT06ZvxxlYJd2iKrxAXm04bfN2P/LilAUf8SNZ3rH5lJvgslIb
         8EvQ==
X-Gm-Message-State: AOAM532q2PragembSTtkj2pFBeMQPEcoY6JPq8XFhz9fBFLQX/X0pWfD
        95nPO6sjkncYGLuwMGi+nzKkC+ZJoZk+a9MHhcuenMerKkIhXA==
X-Google-Smtp-Source: ABdhPJyX6G1bi0LfXpsn0IwiHx+XK5EsqgQXRpKNWUwYqnuM2Gd72NfGDIEYmh3NAk3JEiyYvo+ZeRxHxloQsdH5xZc=
X-Received: by 2002:a17:907:3fa8:: with SMTP id hr40mr15233940ejc.283.1617994946476;
 Fri, 09 Apr 2021 12:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
 <pull.913.v8.git.1617975462.gitgitgadget@gmail.com> <505903811df83cf26f4dd70c5b811dde169896a2.1617975462.git.gitgitgadget@gmail.com>
In-Reply-To: <505903811df83cf26f4dd70c5b811dde169896a2.1617975462.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 9 Apr 2021 21:02:14 +0200
Message-ID: <CAP8UFD0q=7JT1Wsbr6wj9_LEh41ZKbvKsgnE+_3hSM3aMnjwzw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] [GSOC] docs: correct descript of trailer.<token>.command
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 9, 2021 at 3:37 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> In the original documentation of `trailer.<token>.command`,
> some descriptions are easily misunderstood. So let's modify
> it to increase its readability.
>
> In addition, clarify that `$ARG` in command can only be
> replaced once since `$ARG` is text replacement.

I think you can remove the "since `$ARG` is text replacement" part.
Otherwise this looks fine.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-interpret-trailers.txt | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 96ec6499f001..3e5aa3a65ae9 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -237,20 +237,20 @@ trailer.<token>.command::
>         specified <token>.

The beginning of the doc for trailer.<token>.command could already be
improved. It is:

       This option can be used to specify a shell command that will
       be called to automatically add or modify a trailer with the
       specified <token>.

Instead we could say for example:

       This option can be used to specify a shell command that will
       be called:
         - once to automatically add a trailer with the specified
<token>, and then
         - each time a '--trailer <token>=<value>' argument to modify
the <value> of the trailer that this option would produce

>  When this option is specified, the behavior is as if a special

I would rather say:

When the specified command is first called to add a trailer with the
specified <token>, the behavior is as if a special

> -'<token>=<value>' argument were added at the beginning of the command
> -line, where <value> is taken to be the standard output of the
> -specified command with any leading and trailing whitespace trimmed
> -off.
> +'--trailer <token>=<value>' argument was added at the beginning of
> +the "git interpret-trailers" command, where <value> is taken to be the
> +standard output of the specified command with any leading and trailing

Here we can remove "specified" as we now use it at the beginning of
the sentence.

> +whitespace trimmed off.
>  +
> -If the command contains the `$ARG` string, this string will be
> -replaced with the <value> part of an existing trailer with the same
> -<token>, if any, before the command is launched.
> +The first occurrence of substring `$ARG` will be replaced with the
> +<value> part of an existing trailer with the same <token>, if any,
> +before the command is launched.

I think we should not talk about `$ARG` at this point, let's remove
this and see what we can do below in the next paragraph or after it.

>  If some '<token>=<value>' arguments are also passed on the command

s/'<token>=<value>'/'--trailer <token>=<value>'/

> -line, when a 'trailer.<token>.command' is configured, the command will
> -also be executed for each of these arguments. And the <value> part of
> -these arguments, if any, will be used to replace the `$ARG` string in
> -the command.
> +line, when a 'trailer.<token>.command' is configured, the command is run

s/when a 'trailer.<token>.command' is configured, //
s/the command is run/the command is called again/

> +once for each these arguments with the same <token>.

s/each these/each of these/

> And the <value>
> +part of these arguments, if any, will be used to replace the first `$ARG`
> +string in the command.

s/first `$ARG` string/first occurrence of substring `$ARG`/

Let's also add something to explain the purpose of this, for example
we could add:

"This way the command can produce a <value> computed from the <value>
passed in the '--trailer <token>=<value>' argument."

And then let's also explain what happens when the command is called
the first time, with for example:

"For consistency, the first occurrence of substring `$ARG` is also
replaced, this time with the empty string, in the command when the
command is first called to add a trailer with the specified <token>."

To sum up this would give the following (not properly formatted) description:

-------------------
trailer.<token>.command::
       This option can be used to specify a shell command that will be called:
         - once to automatically add a trailer with the specified
<token>, and then
         - each time a '--trailer <token>=<value>' argument to modify
the <value> of the trailer that this option would produce

       When the specified command is first called to add a trailer
with the specified <token>, the behavior is as if a special
       '--trailer <token>=<value>' argument was added at the beginning
of the "git interpret-trailers" command, where <value>
       is taken to be the standard output of the command with any
leading and trailing whitespace trimmed off.

       If some '--trailer <token>=<value>' arguments are also passed
on the command
       line, the command is called again once for each of these
arguments with the same <token>.
       And the <value> part of these arguments, if any, will be used
to replace the first occurrence
       of substring `$ARG` in the command. This way the command can
produce a <value>
       computed from the <value> passed in the '--trailer
<token>=<value>' argument.

       For consistency, the first occurrence of substring `$ARG` is
also replaced, this time with the
       empty string, in the command when the command is first called
to add a trailer with the
       specified <token>.
-------------------

Thanks!
