Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37274C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 01:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D445764E13
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 01:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhAaBsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 20:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhAaBsm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 20:48:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3FC061574
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 17:48:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c2so14888356edr.11
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 17:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Xd4Ihj9oQnV0bYPavKIOPk5VQqLIswyZ7oDq/P+9Mlk=;
        b=kPwPt/Uj9Ylk0my8d0QMevLGxyqmjIR12ZEqoqp2Myb20oOKfEoMAD1nV3a/f3ENAM
         OuXYUF/HV9W9+OvpfMr6Mzx7yfAFJUsMsg10uz+zj6KYh7I6IWSfflUceql5wIfg+ano
         ZeWIuZ9xBrcPKxMGrqj3KaxW1CcMdO6Q4Dq5a7IELcjjeLaEjmJL1zW5izHPNcXbWZgQ
         wakzxXAwovubxCiEjJmbnEy+Gb3FWtzb0y6qt+vfGz6rCTP+D/m4ADBSTaEg8hQJIqRU
         fGRPbwGt1aMWlURo106pJ+KPefRr4DU3yGMDTQ8BNx/tllC2X7jk8IVxVcfhQ/ETXe/W
         e60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Xd4Ihj9oQnV0bYPavKIOPk5VQqLIswyZ7oDq/P+9Mlk=;
        b=amWcqm+TvOFPOLbY78K/4lSu4mySHQ6hnribSLDu48S5xQ/gpV7fqXanCrGTlzWaIk
         6OnhRbVvd231wA8ZdyzenHNu6xyM9S+5r4V40l+KCkMNaiaxggPV4WjIeGt3cMWf1Nxu
         xpBdKEthhkMIBXfkTMVdSdwmmDYvw7aDmYfdmTV2iL3BK5RZ3bZwNO3F7qQj72DUtK/u
         szCrRuBH94dURvk674hGIY6MyrGNT/Nzqdr7fwPwCXrDsiuEZFrVpNIDE5b9WOYy+JOo
         7vQlAlNlCCCuEmQWaNsoe3nus81XNr44wpACElZ5uKmBh/BniHh+tr8zyptQfyTs9Zdb
         fi8g==
X-Gm-Message-State: AOAM532sv/LbdOF+/GQCjOSnJG5wk3tYX4NQniwN0sjoCF1R14yxcKnI
        zAMGhtiMh3U9mnN0j9Dl8Vl2d2dtSho=
X-Google-Smtp-Source: ABdhPJzzSpZjkVsmZzmBqJFiWEA8XwCdHYAbEmZm6x8L3pXLNKP8j3QeOq2+R8tzIL3y+6QWm5AHew==
X-Received: by 2002:a05:6402:1155:: with SMTP id g21mr12268458edw.279.1612057680165;
        Sat, 30 Jan 2021 17:48:00 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id gt34sm357021ejc.22.2021.01.30.17.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:47:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     git@vger.kernel.org
Subject: Re: git fails with a broken pipe when one quits the pager
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <YAG/vzctP4JwSp5x@zira.vinc17.org>
Date:   Sun, 31 Jan 2021 02:47:59 +0100
Message-ID: <8735yhq3lc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 15 2021, Vincent Lefevre wrote:

> I had reported the following bug at
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D914896
>
> It still occurs with Git 2.30.0.
>
> Some git commands with a lot of output fail with a broken pipe when
> one quits the pager (without going to the end of the output).
>
> For instance, in zsh:
>
> cventin% setopt PRINT_EXIT_VALUE
> cventin% git log
> zsh: broken pipe  git log
> cventin% echo $?
> 141
> cventin%=20
>
> This is annoying[...]

Yes it's annoying, but the annoying output is from zsh, not
git. Consider a smarter implementation like:

    case $__exit_status in
        0) __exit_emoji=3D=F0=9F=98=80;;
        1) __exit_emoji=3D=E2=98=B9=EF=B8=8F ;;
        141) __exit_emoji=3D=F0=9F=A4=95 ;;
        [...]

Then put the $__exit_emoji in your $PS1 prompt, now when you 'q' in a
pager you know the difference between having quit at the full output
being emitted or not.

> And of course, I don't want to hide error messages by default, because
> this would hide *real* errors.

Isn't the solution to this that your shell stops reporting failures due
to SIGPIPE in such a prominent way then?

> The broken pipe is internally expected, thus should not be reported
> by git.
>
> Just to be clear: this broken pipe should be discarded only when git
> uses its builtin pager feature, not with a general pipe, where the
> error may be important.
>
> For instance,
>
> $ { git log ; echo "Exit status: $?" >&2 ; } | true
>
> should still output
>
> Exit status: 141

I don't get it, how is it less meaningful when git itself invokes the
pager?

In both cases the exit code means the same thing, that something in a
pipe wasn't fully consumed being signalled to calling processes is the
point of SIGPIPE.
