Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD5CC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 13:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7A4610CC
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 13:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhDJNA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJNA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 09:00:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB4C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 06:00:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 18so9641630edx.3
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfNe5MrAyDpUkKCxsgsyoBk6zw46PyOu1LNde47+798=;
        b=m1jRvE5Mw2UYIynPLD9VAywJJ1shZ5C2xSqXvY/DjsetusH5IltpIzBnIBbNS8qjvb
         5gJqeM9/3fyMz0HJ+k+IZol2uMAG4uQhK1joLCA+eAIo62K0di8NlfZpd9j5i6CMJsTB
         uqKkFDUGAbGfGBfhAhpchkVmBKihxVU1rZD7jFnKeZTRNvTvh0RKUIjyW4Xx2pdLf1w+
         uM2GFfcQdyZ+nxK+TlgjWfhDhk48UKpz5Nt9J51mKRB5HTYEYk9hwHy9RDB75EfVZqPg
         pEqSRUqF5QTzfeH4/eUmeRTDsvpowycx2UpTXi6Jh24tIxzIEaRa2AZ4FxbBuWVRRm3g
         VdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfNe5MrAyDpUkKCxsgsyoBk6zw46PyOu1LNde47+798=;
        b=gXz99dp2UESSsWg3ovmmPsd+drxZvmngz2vMhjGHwOv9rzX1WnL1RlvSxoiebbQSy9
         lYcV1UttFDsgwI/9d/p0FZNOYrJlzCs3hfGFiko7pV0rAdb+s59VTiGQq4JBsXsljC1j
         CYH0ANrFNlY+y9df4tGvH14uLIUWUP1/trrxfrdFn/j0Np0vSuqSlhubCLqmmF5oVkuB
         Z9WsZB94V5BqwZQlKbs7dKRcaBJNHawuexGLj78fR1h6Idmt9962g9GmBPWQLk4eN0mF
         TgQPDhhCW+a/RrnDddJJgTkoroCepBiisfYic9FvqL5HQR7CjvAC27/o5t9aVNsS3PXe
         62uQ==
X-Gm-Message-State: AOAM531QXAQHD7QIP1eVdu3JTGiYbaxf9EJ4ExkPGFabcjLj3VWKizOw
        SMLYTacfyCB/0jwh/0mwLDKH2cB6PkH3TAPROqE=
X-Google-Smtp-Source: ABdhPJy0c+1aWPszod0RM7s7A6ERFJs096iyyayhJejMwYUyAHOtXS7nSK28GNwPhAcZgNu2IQ9a2AGFkWnDvVyvoMk=
X-Received: by 2002:a50:f30b:: with SMTP id p11mr21970011edm.387.1618059610095;
 Sat, 10 Apr 2021 06:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com> <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
In-Reply-To: <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 10 Apr 2021 14:59:59 +0200
Message-ID: <CAP8UFD2hhtpnz+WE2J9iLbzfRJ2k5EOtUMRW=QcH9xe1U6y69g@mail.gmail.com>
Subject: Re: [GSoC][Draft Proposal v2] Finish converting git submodule to builtin
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 8, 2021 at 12:19 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Here's my updated draft. Changes since v1:
>
> - Elaborated more on example porting strategy, stating how the patches
>    could be broken up.
> - Made language at the end of section 6 less ambiguous.
> - Updated status of microproject.
> - s/git/Git in several places.

Thanks for this summary of the changes since the previous version!

> 3 Me and Git
> ============
>
>   Here are the various forms of contributions that I have made to Git:
>
>   - [Microproject] userdiff: userdiff: add support for Scheme Status: In

s/userdiff: userdiff/userdiff/

>     progress, patch v3 requiring a review List:
>     <https://lore.kernel.org/git/20210408091442.22740-1-raykar.ath@gmail.com/>
>
>   - [Git Education] Conducted a workshop with attendance of hundreds of
>     students new to git, and increased the prevalence of of git's usage

s/git/Git/
s/of of git/of Git/

>     in my campus.
>     Photos: <https://photos.app.goo.gl/T7CPk1zkHdK7mx6v7> and
>     <https://photos.app.goo.gl/bzTgdHMttxDen6z9A>

[...]

> 6 General implementation strategy
> =================================
>
>   The way to port the shell to C code for `submodule' will largely
>   remain the same. There already exists the builtin
>   `submodule--helper.c' which contains most of the previous commands'
>   ports. All that the shell script for `git-submodule.sh' is doing for
>   the previously completed ports is parsing the flags and then calling
>   the helper, which does all the business logic.
>
>   So I will be moving out all the business logic that the shell script
>   is performing to `submodule--helper.c'. Any reusable functionality
>   that is introduced during the port will be added to `submodule.c' in
>   the top level.
>
>       For example: The general strategy for converting `cmd_update()' would
>       be to have a call to `submodule--helper' in the shell script to a
>       function which would resemble something like `module_update()'.

Does module_update() already exists? It's hard to understand if you
are referring to something that already exists (where?) or that you
would create (how?) here. More details about this would be nice.

> This
>       would perform the work being done by the shell script past the flags
>       being parsed and make the necessary call to `update_clone()', which
>       returns information about the cloned modules.

How does it return information?

> For each cloned module,
>       it will find out the update mode through `module_update_mode()', and
>       run the appropriate operation according to that mode (like a rebase,
>       if that was the update mode).
>
>       One possible way this work can be broken up into multiple patches, is
>       by moving over the shell code into C in a bottom-up manner.
>       For example: The shell part which retrieves the latest revision in the
>       remote (if --remote is specified) can be wrapped into a command of
>       `submodule--helper.c'.

Could you give an example of how the command would be named, what
arguments it would take and how it could be used?

> Then we can move the part where we run the
>       update method (ie the `case' on line 611 onwards) into a C function.

Do you mean the code that does something like:

                       case "$update_module" in
                       checkout)
                               ...
                       rebase)
                               ...
                       merge)
                               ...
                       !*)
                               ...
                       *)
                               ...
                       esac

                       if (sanitize_submodule_env; cd "$sm_path" &&
$command "$sha1")
                       then
                               say "$say_msg"
                       elif test -n "$must_die_on_failure"
                       then
                               die_with_status 2 "$die_msg"
                       else
                               err="${err};$die_msg"
                               continue
                       fi

?

Could you also give an example of how the command would be named, what
arguments it would take and how it could be used?

>       Eventually, the shell part will just look like a bunch of invocations
>       to `submodule--helper', at which point, the whole thing can be
>       encapsulated in a single command called `git submodule--helper update'
>       (Bonus: Move the whole functionality to C, including the parsing of
>       flags, to work towards getting rid of `git-submodule.sh'). I believe
>       this is a fairly non-destructive and incremental way to work, and the
>       porting efforts by Stefan seem to follow this same kind of philosophy.
>       I will most likely end up tuning the size of these increments when I
>       get around to planning in my first phase of the project.
>
>   After this process, I will be adding the `add' and `update' command to
>   the commands array in `submodule--helper.c'. And since these two
>   functions are the last bit of functionality left to convert in
>   submodules, an extended goal can be to get rid of the shell script
>   altogether, and make the helper into the actual builtin [1].
>
>   [1]
>   <https://lore.kernel.org/git/nycvar.QRO.7.76.6.2011191327320.56@tvgsbejvaqbjf.bet/>
