Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF17C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036E7613E4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFCJzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 05:55:23 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:36530 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCJzX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 05:55:23 -0400
Received: by mail-oo1-f52.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so1259560ool.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bewtFeHpDpdww0yLgAwhKuJZKZ116pgfGiiM6Wfk4T4=;
        b=byhZ3M5imDYqVHuU5KgUQyvgLOuykePoKUf9+GfXXMNWO6tKA0P31qzw5/z/RyJVVc
         ua3Z0rjvj5ZtwfhyD8ROf8ON1vsXqH3OFcGlEmW3iB8l33IqoVZaET7f+9cJk+SN4+4J
         2LiwElmOwIa4AvHI6Pzizo7vToLp6qPtpFZW+bpZK087oDZZaJ9uaooj21sPF2KIUOG0
         5wpe3DEcpKwm4P2LxOPlGG0b/2bBYgu40Oro83JZD6X4UyOjUglOVwgKN54X25iaDU9v
         Jtpx86cNUOWgArnyP1Xlg+5MZcWT0J/5XUAXTo9nGPn2Ouvt/B/rmu4KdAQqY+phN2ui
         dtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bewtFeHpDpdww0yLgAwhKuJZKZ116pgfGiiM6Wfk4T4=;
        b=uWbxFVNg+6HYNQ9K+qzLOLFNnYVE7lTbDYL7CH6gLLPf4iW+CCfDIeVYy8cJwNTHeI
         tSUuiCt0oHK03AXMuPR1XMYe5w4MZmNJsiOae86pTS8KQM/PQ9VGyCtUd6n6AHijf98d
         2cQE2HFXoVWIf89rX9PQaDqUf1NaT+9hAzlNpnPFn1oT0zwrpZxZetowBFRXEuhrOckH
         fN7Ez1mGtXPg0tR1JSXDpENX1yp4cwymcdlXKf1NlrbuSQVNyZbdjBE9ERmnep7Zumdg
         CR8dqSJwCPVerOSn06Tfi4Vtj6Ei4p8uZMH+AclFd6Nb2lj8hovaaP4gzOfQxpHkVYVb
         L5AQ==
X-Gm-Message-State: AOAM533RQF+Ao1jN5/Hl7dzEoneocWSfkMzNmuQV6DHdFiS4AVVWTzjw
        R+yVIO8UuQsYaV7cGH5cPzs=
X-Google-Smtp-Source: ABdhPJzzjCUf2ENyPSL3IsukwG5nxNa0SfKwzvxYrHttK0OjimmfyF+MCf9YhnPKpPOWfCitkKgHXA==
X-Received: by 2002:a4a:e945:: with SMTP id v5mr28627646ood.64.1622713947254;
        Thu, 03 Jun 2021 02:52:27 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 16sm586290otm.57.2021.06.03.02.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:52:26 -0700 (PDT)
Date:   Thu, 03 Jun 2021 04:52:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60b8a659f3ff2_1a0a2d2089c@natae.notmuch>
In-Reply-To: <CABPp-BEwueg9V0PHUZ=ZUrTRpqwqN2b2b3t4owkizr75a+BDUA@mail.gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87wnrd6wqj.fsf@osv.gnss.ru>
 <CABPp-BH7f+sM_POEsSSvmz_p=oEzHQcvTk_cEhTGeb-yq9fq_A@mail.gmail.com>
 <60b832316cfa8_187c7d20826@natae.notmuch>
 <CABPp-BEwueg9V0PHUZ=ZUrTRpqwqN2b2b3t4owkizr75a+BDUA@mail.gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, Jun 2, 2021 at 6:36 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> > > On Tue, Jun 1, 2021 at 3:39 PM Sergey Organov <sorganov@gmail.com> wrote:
> >
> > > > [diff]
> > > >         algorithm = patience
> > >
> > > Any reason for patience vs. histogram?
> >
> > Is histogram better than default?
> 
> Yes, definitely.  I think diff.algorithm should default to histogram,
> personally.
> 
> See also commits 85551232b56e (perf: compare diff algorithms,
> 2012-03-06) and c8017176ac8f (merge-ort: use histogram diff,
> 2020-12-13).

Interesting. I'll give it a try after this month.

> > > > [merge]
> > > >         conflictStyle = diff3
> > > >
> > >
> > > Anyway, here's my list to join in on the fun...
> > >
> > > [branch]
> > >         sort = authordate
> >
> > Nice. I didn't know that existed.
> >
> > I have `tag.sort = -version:refname`, and after a few days without I'm
> > wondering why it isn't the default.
> >
> > > [alias]
> > >         brief = !git log --no-walk --abbrev=12 --pretty=reference
> >
> > I find it odd that you prefer `git log --no-walk` over
> > `git show --quiet`.
> 
> Why?  Both log and show require an extra flag, so why should the
> choice matter or be surprising?

Because log is to list a log, and show is to show a single commit. --no-walk
makes sense in addition to --stdin for example.

A log with a single entry doesn't seem like a log to me. But to each his
own.

> I happen to use log a lot more than show, so I think in terms of
> adding flags to git log rather than the ones I need to add to git
> show.  Not a big deal either way, though.

I'm the opposite, in fact, I barely use git log. When I want to see
history I use gitk, and when I want to see a single commit `git show`.

 9% show
 7% v # alias for gitk
 2% log

> > > [log]
> > >         mailmap = true
> >
> > Another one that I don't see why it isn't the default.
> 
> It is the default and has been for a couple years; see f3eda90ffc10
> (log: really flip the --mailmap default, 2019-08-01).  I just never
> cleaned up my config.

Ohhh, that makes sense.

-- 
Felipe Contreras
