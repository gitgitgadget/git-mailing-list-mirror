Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD7C433FE
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 14:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A81660E74
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 14:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbhJKOdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbhJKOdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 10:33:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070DC061783
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 07:21:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i20so52129495edj.10
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=N9UWSVmjXUcn8fqcorlyRbPpRPE3VHMnc1bi5YliAag=;
        b=R8nd7SYFkfZC+PGpY/Y/29962vnHj+2htF//Yj1zX0DhDDDZVi3VPsNiUcVLzXcJ/L
         aESVE9FU5mkjvDWeugssLQVwZoWiLQ4uVamWreH/ykF8Gc7zXh5jlnoiG1KweFqy6qyr
         2u5HoedgIIejefwQOQRSFNtR9Evb5LY1LIuZFB8ZBqN/kKVqjS35waI0F5voRatUahAV
         VA5edxZoCHGBil2d/G+GrzZAuvaqY2tY0KkAkE6BdRGrB94/Ws71rFz3p8zhSzHAnu/x
         CoDNzNMot6d/jcm8KYkIHRRuE9omGuevznlz4N5Bz+JpoYKG1VCMcWvSDl8X4QlRKPbC
         3YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=N9UWSVmjXUcn8fqcorlyRbPpRPE3VHMnc1bi5YliAag=;
        b=gdakfD4fM0duznRBUraIKAi0Kk12xMo5DZCFugs8PygJog9uQcEiYeMzBzuSzzEQ/K
         WftXKYNijzigQtJ3tSZLngswIgjqLc/r5w43nCz49eFMzaLgL30QDdG9COfiU0usXPQT
         aQi1OmD81fa5kbRN6wL+WLsXSKfxX5vVfr0gbVP4y0B8emEwFMFHa5qSFnW0/aklcor0
         9jRnICMxnGcrRpF33gaRzkfEJvODyl7BNCnEf66Apz0VOMkrPj9+UwxfEpnTx0/Cgcik
         Yi02IgVIT49rRf06+JCEjyNpLtktFAOdNsFLJ+rU7fv2RyPsHZzfWAqLy886F5fMt4vu
         4eOw==
X-Gm-Message-State: AOAM530uUyZfQvmld+YOd1U1DaWECMtXpDCt1VRcSXLMcFHLitYxnvvH
        DX0usq3k5KkqvuT/BBUaUq+JFGUBWVMR1eSH
X-Google-Smtp-Source: ABdhPJxkL1+3/aHdyn0thiMgsizYrEtxWq30hIiu1UFwNbEI3t6yxXCkI++LDE/UDeudivyLUU3Z0Q==
X-Received: by 2002:a05:6402:1d4e:: with SMTP id dz14mr42565593edb.348.1633962093119;
        Mon, 11 Oct 2021 07:21:33 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p23sm4544219edw.94.2021.10.11.07.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:21:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, angavrilov@gmail.com, me@yadavpratyush.com
Subject: Re: [RFC PATCH 0/4] git-gui: support SHA-256 repositories
Date:   Mon, 11 Oct 2021 16:15:36 +0200
References: <20211011121757.627-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211011121757.627-1-carenas@gmail.com>
Message-ID: <87bl3vlk0j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> While poking a SHA-256 hash repository, was surprised to find gitk
> would fail with a fatal error when called, hence this series.
>
> Sending as an RFC, since I am not a git-gui or gitk user, and so
> while this fixes the original issue and allows me to call gitk to
> see the branch merge history (which is usually as much as I do with
> it), it is likey missing some changes, as most of them where found
> by lightly poking at all of the gui menus (except for remote or tool)
>
> It could also be reordered to reduce unnecessary churn and of course
> also needs the gitk change[1] that was sent independently, and better
> commit messages.
>
> [1] https://lore.kernel.org/git/20211011114723.204-1-carenas@gmail.com/
>
> Carlo Marcelo Arenas Bel=C3=B3n (4):
>   blame: prefer null_sha1 over nullid and retire later
>   rename all *_sha1 variables and make null_oid hash aware
>   expand regexp matching an oid to be hash agnostic
>   track oid_size to allow for checks that are hash agnostic
>
>  git-gui.sh                   | 30 ++++++++++++++++--------------
>  lib/blame.tcl                | 18 +++++++++---------
>  lib/checkout_op.tcl          |  4 ++--
>  lib/choose_repository.tcl    |  2 +-
>  lib/commit.tcl               |  3 ++-
>  lib/remote_branch_delete.tcl |  2 +-
>  6 files changed, 31 insertions(+), 28 deletions(-)

There was a similar series earlier this year which didn't make it that
fixes some of the same issues:
https://lore.kernel.org/git/pull.979.git.1623687519832.gitgitgadget@gmail.c=
om/

My comment on this one is much the same as that: I don't use this
software, and if you've tested this I trust that it's better & this
going in as-is would be better than the status quo.

But also that as noted in the feedback there it seems that:

 1. Figuring out if we're using SHA-1 or SHA-256

 2. Adjusting all regexes to *exactly* math those things, i.e. using
    things like x{40}(?:x{24})

Just seems like a lot of needless work as opposed to just matching
x{40,64} or whatever.  Yes that's not the same regex semantically, but I
think the current code is just being overly strict, i.e. it's parsing
some plumbing output, we can trust that the thing that looks like the
OID in that position is the OID.

If anything I'd think we could just match [0-9a-f]{4,} in most/all of
these cases, would make things like this easier to read:

-		if {[regexp {^([a-z0-9]{40}) (\d+) (\d+) (\d+)$} $line line \
+		if {[regexp {^([a-z0-9]{40}(?:[0-9a-f]{24})?) (\d+) (\d+) (\d+)$} $line =
line \

And also the pre-existing [a-z0-9]{40} is a very weird mixture of being
overly permissive and overly strict :)
