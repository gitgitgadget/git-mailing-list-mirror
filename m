Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9AC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5BC6108E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFGQAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:00:48 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37840 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhFGQAs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:00:48 -0400
Received: by mail-oi1-f169.google.com with SMTP id h9so18545982oih.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jQG82idYE5gJex9ZO8V8hpOLLQhHq7K5gvtMo5SMNz0=;
        b=Z5nM2jT7eL4dPncTaSAZm/crS6AC64xnN7RUE+lbtqcmTK/QB4LU1kKeupz/HCORJM
         I5T0RJiMh7oHjTuuW1wcgzYwKM4P4npTdvJ73HWbIQNTKJCmUd1xhWMdi/JGcyENn5Ii
         Aee/5f9zRgxlYzUJi3TtnN67Q40CgVkzyV8zPZXX2MO1B4gFoDlS3nsj8UAWGe78MJxY
         FoBdBKPyKF8ayOA5MXMjeQzQzXI7ojhCSrNA7AbCUg/ZGBvW4R3dQ47GXwq7gDNH4MJu
         J2ntPWMiKOJ1J/vmtjZ3CL663EY0NnKD556KPpeRUztxsDDgk/4XkRpl8YtdUdp1mJ7r
         OBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jQG82idYE5gJex9ZO8V8hpOLLQhHq7K5gvtMo5SMNz0=;
        b=pdq+cuo/M55eckSiad8bzseO6GG8hhl8bmiiIcNuF73T+CxkCwnB/hIxOcUb14OnKp
         WJsSzsKy9+apr32VU9l+TBS30hc1260yUb49/RjkIIHtyDZs9hpnVlDocJVGO+BpxMNq
         TKhUutUid6e2h1cCaZHjZX8pVQwPclGGqSXmuj2zPVwB3DUbCqZv2iNdZ0KxkeShkAaS
         EwpRd7ckEJdlkABN1BB/zV6/TgQ3I9PwbCGS9mNr7HV0HfaOwHggrouTYiEOSMe35Yhy
         k3+i+z1+ZiULcv68mY2jDymTk1iI8gbsbWw57d95o9OXaWdvuajBqrRWdj1z9GBzt2Vr
         eZPA==
X-Gm-Message-State: AOAM532aM3OZLwMHFJVFgcQxIpYLEF/V4sgyS1Fa9w3hEA3M6trfsbnW
        9kEFGWsFexXmhkieXIfbLEU=
X-Google-Smtp-Source: ABdhPJzUBjxxjqZvPyoMaxqSdeleqvCR8LWjZozj/JBw/30kTUNDwajH3ieSxyNw7vthJ0PU62rb6g==
X-Received: by 2002:a05:6808:1404:: with SMTP id w4mr19953692oiv.53.1623081463960;
        Mon, 07 Jun 2021 08:57:43 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 7sm939343oip.56.2021.06.07.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:57:43 -0700 (PDT)
Date:   Mon, 07 Jun 2021 10:57:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60be41f6473e2_39c0a208f6@natae.notmuch>
In-Reply-To: <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
Subject: Re: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sat, Jun 05, 2021 at 10:18:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> =

> > As for the proposal, I don't use "branch -v" all that much much, so I=

> > don't have strong knee-jerk feelings on it, but just considering it n=
ow
> > I'd think that the current default is a fundamentally better
> > approximation of what most users would like as a default.
> > =

> > I.e. I think it's fair to say that to the extent that most users have=

> > topic branches they're part of some pull-request workflow where they'=
re
> > always tracking the one upstream they always care about, usually
> > origin/master.
> =

> I'm in the same boat. I don't use "branch -v" either, but showing the
> upstream name wouldn't be at all helpful to me, since it they would all=

> just be "origin/master".

But this patch is not for you, it's for the majority of git users.

> (This will vary based on workflow, but the
> other common workflow would probably just show "topic" being based on
> "origin/topic").

Based on what evidence?

As I showed in [1], all the top results when googling "upstream branch"
show the upstream branch being used in the opposite way: it's set to the
place you push to:

  git push --set-upstream @ github/my-pull-request

> > The -v output showing the ahead/behind relationship to that branch
> > without naming it is thus the best use of the limited space we have, =
and
> > with a bit more verbosity under -vv we'd show the (usually the same f=
or
> > all of those) upstream name.
> =

> The notion of what to show for a verbose format may depend on workflow,=

> or even what the user's currently interested in. These days we have
> --format to give much more flexible output.
> =

> The "-v" and "-vv" options predate --format, but these days are
> implemented on top of it (they literally build a format string that's
> passed into ref-filter.c's interpreter).
> =

> So we could document them as: behave as if "--format=3D..." was given o=
n
> the command line (unfortunately "..." here is a complex set of %(if)
> mechanisms, but it would mostly be for reference; nobody would need to
> type it).

You mean like this?

  %(if:notequals=3Drefs/remotes)%(refname:rstrip=3D-2)%(then)%(if)%(HEAD)=
%(then)* =1B[32m%(else)%(if)%(worktreepath)%(then)+ =1B[36m%(else)  %(end=
)%(end)%(align:34,left)%(refname:lstrip=3D2)%(end)=1B[m %(objectname:shor=
t) %(if)%(upstream:track)%(then)%(upstream:track) %(end)%(contents:subjec=
t)%(else)  =1B[31m%(align:34,left)remotes/%(refname:lstrip=3D2)%(end)=1B[=
m%(if)%(symref)%(then) -> %(symref:short)%(else) %(objectname:short) %(co=
ntents:subject)%(end)%(end)

I don't think that's particularly useful to anyone.

> And then it is not a far leap to change that to: behave as if --format
> was set to the value of branch.verboseFormat, and the default of that
> config option is "...". And then anybody can make "branch -v" behave
> however they like.

I don't think telling users to do `git command --code=3D"type here the
code you want git to do"` is very user friendly.

I don't even want to look at that huge-almost-unparsable string any more
than I have to, and you are suggesting that *all* our users subject
themselves to that pain in order to fine-tune the output of
`git branch -v`?

And what about `git branch -vv`? Are we going to ask users to fill an
even bigger branch.verboseverboseFormat configuration that it's mostly
repeating what branch.verboseFormat has?

I'm not interested in implementing that in the least.

But even if that was implemented, the whole point of this patch is about
what the default value of branch.verboseFormat should be.


Do I need to produce a list of the top 10 Google results of
"git branch -v" vs. "git branch -vv", to show that most people don't
find the output of -v useful?

Or what kind of evidence would satisfy you?

Cheers.

[1] https://lore.kernel.org/git/60be3b2d6e1e6_39c0a20883@natae.notmuch/

-- =

Felipe Contreras=
