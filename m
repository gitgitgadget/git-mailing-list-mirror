Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F06C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B84A61026
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhFAVCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhFAVCN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:02:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A6C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 14:00:31 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id x9so49670ilp.4
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWMFUBeY0Kp9aMXmwvyFEeRF11EOPJMI3LmWaC6nEeg=;
        b=HhKSlB70hLbdbcW96LZLT4ja4V7FCcaJVG9SaqrykTVNH44ZthS1mBxR9mGDjghHFo
         vk+0ENxGU4GbZRfDM/rL9rS6soepsdzZu7c8Aob0y3unq/3OSsikBRlLGVp0kSHntK5X
         BXs8slcZlHdf+wALgq0qt8aAJtZd5d41szfOGORgXgT2YqaOOaeQOg6M8o3yATI3NJeh
         tAo76WqPS513JuCKuxaGm7pHe4kVYITbyKU0kCSqBxQCDueDtAjandtQThdNRC4DoVmr
         KZ+zuXQT2wD/mbz4/wxUcR97T9LUri5GC8GfWWRZdegXt4K/YIeWjiVqcz8M//3qtZC6
         mVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWMFUBeY0Kp9aMXmwvyFEeRF11EOPJMI3LmWaC6nEeg=;
        b=mDF2BjYDbJPOOi1wIJDfO2vMQNMPdGK99v84KSqbK4JdF32m/RAGMkBN8Cu1gG4T/9
         nKT8c14zXy/QRYCeZqqdsvFR1r6wCN0//dNjO7tio9uucbZMBzaH0HX2QB9HvidL/Jij
         HL/h4o3PI6PW0HEw0cNUtYaEb41NazLz/ywYFIvv5yF8bg0l+OHekZHkw9HD1D6CRVzg
         HKYxs5lC9lBf7C8q3fXZyMWvpkq6Yj0ph+x1JwlM8CLOB0RseNWe/yNqd/0lxKoKQF92
         UN/tvmITsjoKAI4U54Yd4qm0pTXx1ilMQ/QvDBrztB4bH9hMTAIrNSrKzCNR7y8oTyT9
         C8dQ==
X-Gm-Message-State: AOAM532HMUUfqOT69kcpoW3EqfWEgw5Hjc6B6xONGtRG4TLDKZ4LtI+9
        XjL+taDYYIEQBggu0hmBnC2gxRDdzsVt5+7gUVM=
X-Google-Smtp-Source: ABdhPJyFXZW0KhFyzLRC3+V25DSKg7JRwv9kEvZXDFT7dngEeH99vk8Icike/BU6h/yHHS0pEvKwyxwlgDPuiPqaTLo=
X-Received: by 2002:a92:c68c:: with SMTP id o12mr12932360ilg.6.1622581230800;
 Tue, 01 Jun 2021 14:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210601165254.18136-1-davvid@gmail.com> <60b6873624c6f_1a702085e@natae.notmuch>
In-Reply-To: <60b6873624c6f_1a702085e@natae.notmuch>
From:   David Aguilar <davvid@gmail.com>
Date:   Tue, 1 Jun 2021 13:59:54 -0700
Message-ID: <CAJDDKr630n7=8FqsSRXpN7fNy9ZB8FOzO=LxvfHFVrMR1=L3_A@mail.gmail.com>
Subject: Re: [PATCH v3] contrib/completion: fix zsh completion regression from 59d85a2a05
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 1, 2021 at 12:15 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> David Aguilar wrote:
> > A recent change to make git-completion.bash use $__git_cmd_idx
> > Add "git" to the "words" array in _git_zsh_main to guarantee
> > that "git" is at least always in the completion list.
>
> Hm, no. The current code already guarantees "git" is always at the start
> of the completion list. In [1] I suggested to add git *if* $words is
> used instead of $orig_words.
>
> If you add "git" to $orig_words you end up with something like
> "git git mv", so the __git_cmd_idx is definitely not 1.
>
> You should probably try to test yourself:
>
>   words=( git ${words[@]} )
>   echo "$words" >> /tmp/words-log.txt
>
> The problem is that zsh's _arguments eats all the words it finds, so for
> example if you type:
>
>   git mv --force <tab>
>
> $words will be 'mv --force'.
>
> It's better to use $words because in case there's arguments beforehand,
> like:
>
>   git --git-dir=/tmp/test/.git mv --force
>
> $words will be 'mv --force', so we can get the proper index by just
> adding 'git' beforehand.
>
> But it doesn't work for arguments not in _arguments, like:
>
>   git --foo mv --force
>
> Which returns:
>
>   --foo mv --force
>
> And unfortunately upstream's version of the wrapper doesn't understand
> many arguments, like -c, or -C. git-completion does have all of them
>
> It's better to just leave the code as it is and just fix the regression
> by adding __git_cmd_idx=1.
>
> > Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> I mean I kind of wrote 2 of the 3 lines you sent, can I get a
> Suggested-by?


The v4 I just sent is now basically the same as v2 modulo the
Suggested-by: trailer update.


>
> > --- a/contrib/completion/git-completion.zsh
> > +++ b/contrib/completion/git-completion.zsh
> > @@ -251,7 +251,7 @@ __git_zsh_main ()
> >               done
> >               ;;
> >       (arg)
> > -             local command="${words[1]}" __git_dir
> > +             local command="${words[1]}" __git_dir __git_cmd_idx=1
>
> This is needed.
>
> >
> >               if (( $+opt_args[--bare] )); then
> >                       __git_dir='.'
> > @@ -261,7 +261,7 @@ __git_zsh_main ()
> >
> >               (( $+opt_args[--help] )) && command='help'
> >
> > -             words=( ${orig_words[@]} )
> > +             words=( git ${orig_words[@]} )
>
> This is wrong. The current code is fine.
>
> Cheers.
>
> [1] https://lore.kernel.org/git/60b3c2d7557bd_be762089a@natae.notmuch/

Thanks for the detailed explanation.

Just so I'm understanding this correctly.. if this was instead..

    words=( git ${words[@]} )

(instead of orig_words like I mistakenly included in v3) would that be
an improvement, no-op or would it be worse? It sounds like additional
changes are needed to make it properly support options between "git"
and the sub-command name, hence the patch is fine as-is in v4,
correct?

Hopefully in the future it can be extended to cover eg. "git -c
foo.bar -C some-dir <sub-command>" as well. Thanks for your patience.

cheers,
-- 
David
