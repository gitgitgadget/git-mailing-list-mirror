Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97268C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5383E221FC
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbhAIVjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 16:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIVjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 16:39:36 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DBBC061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 13:38:56 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u26so13702405iof.3
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKqFXDYDh8VkEiZ2XsG8ZZKn8ZCCSCMJnLwWI2VNlMo=;
        b=JA9cWuEsThT0UOV0sNw7Sua4Jq/yn/ZksoAFgp+Vadg8jXp695GhXuH7wW1k+DW+3n
         u1Sag5cXer1V8Vco+tk2Rfkcxo4LAhhqpKoeXHYG59I89rQdyfPqEzzy9BhJrYzsoDQk
         RqOMlFVtwerkJhDU/n/Zk47L7F3+PZ986aDjc/iRaMx7LXmDVojnZqI0KhATo9AHF475
         zU6tjw/CDN+ZhChzC5pigftEbEd8fq0gHO+Vj8+d/tpzw7HvvTGkDichPgm61kue3tKv
         WlJ65sgXePpKt/KzU9nzXSoudZ9dGSvIUbxHw1XCrKYUVq0DRltAhsmmtxe5TTVPMbmR
         bu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKqFXDYDh8VkEiZ2XsG8ZZKn8ZCCSCMJnLwWI2VNlMo=;
        b=CwPsyxhXnuJFl6/CK4dhOWAEmY+4i7lx72A0u9ickBznH3I2H7zjKXQjZg7kbtmfCV
         tywfoVy28rF8pEmtyYxSdutC917kowZXpgFAVfoR7ro2ndxyB8SaC6QF0YG3KaExeHaE
         HoXn94vaeteWh/xLDADOgZuZDDoZRG8eNbvXO6Y+ItdVP5yxSUuzXE/33yCkWn4SNBk8
         GMkSs26eqUNfxbT3EhH0oBTQ/qSouGLV9+y1BdhgLjmdG8ho28Hzi/IFLiT63H8efshG
         I7DE4ymyJKrrTasoLS4Du/Jg33l50zkruFhNPhjUscJJrBlQCSs+M1Zlj1ZwYyzfpbZi
         ih9A==
X-Gm-Message-State: AOAM533XcJp2EEXBd3BszeOLHkPEPB/kaX0AmDrrUbqW6sYKUYjxBuC7
        izM/dV5mQCC3gOzoI4cIjgDgww94ZoQyE3Kzb/I=
X-Google-Smtp-Source: ABdhPJxXtiZ0UgtXHMzi2I64L331d9/D0bhzH+Nkaxs1L30wsTpFZKDJItWPVfLW2TNmrHpUKy1bZXE/kWCxaX4T0rY=
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr8722065jaq.102.1610228335967;
 Sat, 09 Jan 2021 13:38:55 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Sat, 9 Jan 2021 13:38:20 -0800
Message-ID: <CAJDDKr6V+kKMs4yz+YQx1AhiY5qQwENfs_yZqxXWBqmLUk2oAw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
To:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 11:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * fc/mergetool-automerge (2021-01-06) 5 commits
>  . mergetool: add automerge_enabled tool-specific override function
>  . mergetool: break setup_tool out into separate initialization function
>  . mergetool: add per-tool support for the autoMerge flag
>  . mergetool: alphabetize the mergetool config docs
>  . mergetool: add automerge configuration
>
>  "git mergetool" feeds three versions (base, local and remote) of
>  a conflicted path unmodified.  The command learned to optionally
>  prepare these files with unconflicted parts already resolved.
>
>  Breaks tests on macOS.
>  cf. https://github.com/git/git/runs/1659807735?check_suite_focus=true#step:4:1641


Thank you for seeing these changes through.  It's so close now!

I did some investigation into this issue and narrowed down the root cause.

Here is an example input file called "tiger" for testing the sed
invocations in auto_merge():

$ cat tiger
<<<<<<< HEAD
branch1 both added
=======
tiger both added
>>>>>>> tiger

There are two sed invocations that use \r\? to maybe-match \r for crlf support.
\r\? is not portable to macOS (and freebsd?) sed.

For example, auto_merge() does the equivalent of this in one of the invocations:

    sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' tiger

It prints nothing on macOS.  "gsed" (gnu-sed) from homebrew prints
"tiger both added". This may affect other unix flavors where sed is
not gnu as well.

To verify I changed the sed invocations in auto_merge() to use gsed
and it's then able to pass the tests.

Fun times in sed portability land.  After a bit of experimentation,
this is what I've managed to whip up:

cr=$(printf '\x0d')
sed -e "/^<<<<<<< /,/^=======$cr\{0,1\}$/d" -e '/^>>>>>>> /d' tiger

- Instead of \r use printf to capture CR into a string so that we can
embed the literal using $cr.
- DQ "..." instead of SQ '...' to allow $cr to be substituted in the string.
- Instead of \? use \{0,1\} which seems to work on both macOS and Linux.

That seems to work and the tests now pass.
If not sed, is there perhaps a perl equivalent for these multi-line
delete-from-X-until-Y expressions that might provide better
portability?

I'll start putting together a patch shortly as this seems to work in
practice.  Let me know if y'all have any sugs or if there are any
portability pitfalls I'm not considering.

cheers,

--
David
