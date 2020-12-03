Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1598C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 09:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAE4217A0
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 09:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgLCJIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgLCJIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 04:08:52 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D7C061A51
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 01:08:12 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so1091912wrt.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 01:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOKg6vbY8YFynTOy1+dDoa7DqAFojirJxl2jhjqC0+0=;
        b=s39zbjKkJmZEBR7P7+BVqg/A553lnRwqXcXegn4JnGAts+ZHGCRwgIV5HJGCKAbM4u
         pkolsfPQuLoC85GvSmQLEzQcrq4iTkDHBniHYJgWhOgQzbbgNtyOAqheyQMGPyyIqbQh
         eislr0Qq6oZ3xekPQZZ0p2TvS2f+c3h69pu/5Cacb4g0f8NN16t7UfTSuBXaCf777vyk
         eJR4iTqgalIP0L+yalJ/2GqwKHJELQhlrvUnc3+72wJOSMwlHIxDxNMrBmV3mZorE8/D
         I8FHxn7ruq8ibKpcrwmcb0g65/zUiVLVtL+J53bO4tJLqxaFHlVPzV4RChAfizZtCxAw
         Db6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOKg6vbY8YFynTOy1+dDoa7DqAFojirJxl2jhjqC0+0=;
        b=OG9I12gZKmnysx7P/uBdK7HP1HQES7xzpbeVao+BfBVRqP2iPgdhuybD6VuRKhxSVQ
         Iovdg5O8a/UfnKPKgGvsZ1Pz/u9BAuyFH7uzL/FC/9qWki3TEz+EA5vKi6K53JYMLnI4
         UEcBqr34EBalNT0AvR0KBJQfqz5VJ/bC9JnttjKmZP49r+m4OkgYWMNnPk6t8aZZ7yd5
         G+I3cSOvX7AuMUO4e0zNV90+BbB+bubMkgxpUj75mKcrdZVVWFkTBWZgVrztH7K7TZcR
         XJOGytrlQSNsTyIA9xhZDc5Yu5cNQX+ymMW7S49gZwTd8WBOiQq1dEMsDEJjfLYR1ILw
         Yq2Q==
X-Gm-Message-State: AOAM531JB1iKA8vZUmpf5v3P+pr/Y0hPqVFTywKgfHBmBUuiy+OgX4Fz
        t12zijO+NlHQ6ZGO1jU6ggNq3SS/g5MWUql4VUE=
X-Google-Smtp-Source: ABdhPJyFqZV7BcEDdqZUHolUXKlvICvsDXm3KGcIp78LdVv5KyGhqeRsK6ZNwssNyZZAarOrywCfj4h1Dhx5AgE9hRs=
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr2454461wrw.139.1606986490734;
 Thu, 03 Dec 2020 01:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 3 Dec 2020 03:07:59 -0600
Message-ID: <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 2, 2020 at 8:21 PM Junio C Hamano <gitster@pobox.com> wrote:

> So, the idea is that we currently return NULL when pull.ff is set,
> but now we also check "pull.rebase" etc. and give "--ff-only" when
> we did not choose --[no-]rebase and lack the configuration.  So the
> default (i.e. when pull.ff and pull.rebase are not set) would be as
> if the user said
>
>         git pull --ff-only --no-rebase
>
> I am not seeing what problem this tries to solve, exactly, though.
>
> I would have expected that for those who did not choose between
> merge and rebase (either with the pull.rebase configuration or from
> the command line --[no-]rebase option) the command would behave as
> if --ff-only is given, regardless of how pull.ff configuration is
> set.

That's right, I would have expected the same as well, but right now
the pull warning is disabled when you have a pull.ff configuration (or
--[no-]ff[-only]), as it was done in commit: 54200cef86 (pull: don't
warn if pull.ff has been set).

In my mind doing "git pull" is the equivalent of doing an implicit
"git pull --ff", so I don't see why setting "pull.ff=true" should
change the warning. The warning should not be about lack of
configuration (we want git to eventually work correctly without
configuration), it should be about something unexpected about to
happen (i.e. a non-fast-forward merge).

So quite likely Alex extended the logic of the current warning to the
default mode, which I don't think is right.

We want the logic of the warning to change: to be displayed a) only
when there's a non-fast-forward, b) when the user has not specified or
configured either a merge or a rebase.

Only after a while of this warning on the wild should the default mode
be changed.

But we need to fix the logic of the warning first.

> > @@ -344,23 +348,7 @@ static enum rebase_type config_get_rebase(void)
> >       if (!git_config_get_value("pull.rebase", &value))
> >               return parse_config_rebase("pull.rebase", value, 1);

...

> > -     return REBASE_FALSE;
> > +     return REBASE_INVALID;
> >  }
>
> Hmph, and who reacts to this REBASE_INVALID value?  Shouldn't there
> be something that catches this INVALID value and stop/complain?

Later on there's a "if (opt_rebase < 0) opt_rebase = REBASE_FALSE", so
this is only temporarily set as REBASE_INVALID for config_get_ff().

I don't find the semantics of this approach appealing, which is why I
introduced REBASE_DEFAULT in my patch series, so that the meaning of
REBASE_INVALID is not muddled.

> Another thing.  Does "git pull --rebase --ff-only" behave sensibly?
> "rebase our history on top of theirs only if we are truly ahead" is
> a bit strange way to say "we only ride along without having our own
> development, and once we discover we have our own stuff, stop us".
> IIRC, "git pull --rebase" ignored the "--ff-only" request and
> rebased our own stuff on top of their history anyway, which we would
> want to fix.

We would want this new mode to consistently fail with a good
user-friendly message, better than "fatal: Not possible to
fast-forward, aborting.".

But this mode is the opposite of "git pull --rebase", which is why it
doesn't make sense to do "git pull --rebase --ff-only" (which is
ignored right now).

In other words: --rebase should disable the --ff-only mode.

Also, we would want --no-rebase to disable the default --ff-only mode.
That would require changing the semantics of --ff-only, so that "git
pull --no-rebase --ff-only" doesn't make sense (as --ff-only is
overridden by --no-rebase).

If we do this, then the only time where --ff-only would make sense is
in "git pull --ff-only" (no --rebase or --no-rebase), and if we change
the semantics this way, then there's no need for my suggested
pull.mode (although it still might be desired).

Moreover, I see no tests that check for this new behavior.

Cheers.

-- 
Felipe Contreras
