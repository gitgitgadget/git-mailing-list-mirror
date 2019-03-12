Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC75220248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCLSUs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:20:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45348 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfCLSUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:20:48 -0400
Received: by mail-io1-f65.google.com with SMTP id x9so2922229iog.12
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLducxQgdL5qWttFH2vRF69gJmiVGR+asvYDtlIvvMk=;
        b=AusTUpe5xMrgZsxIuOIX5rK+6lL1g1O6HQmgFSMRQYqB/50HBAURCVGvfJTX03vYWq
         2u16e95GXtncVNeysVMIXBBSFZioy5G8Xl/glEMI6ajxjhULv6CcqJRjs6GzEW8JVw4s
         jX7/lsx9ib+lpsrzJXkxssyoCGsS+RLdctgj2xgNf1BazeECS/WVi+u6iZORs+NeUft7
         YV+KtD/PjZbDJu0M2l5YBR87TkqqtfszQaEqT8/qt0KXODp+3BwLuvGgYwCj9mppk3iN
         uW74o4lz7F25PcGGTd40t3VhUYhgDcvNJMRdcmJ7xE6EkL/ZCdh+PgNFUxkW/9ovk/pH
         QdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLducxQgdL5qWttFH2vRF69gJmiVGR+asvYDtlIvvMk=;
        b=q109vHnusmj7tPZrs4Lr6CvGkOr5AN1CO3wRoT6xS5Rlpr9REwhl2s9LaytRzVRtu6
         yR11eCEq1J6LTyaTQYs/fg0Xt6uCg0yLOEKdMQoV9zLQS8WNLIAVyRkZe7BFPeOCzvfM
         vmBDfG7MS4fsTL5ULDaykHroMH+bNlPpsTlN5EoX82yS8htB+CWFuE2xbF67Qw0NTHo4
         VDAbQ9rcpIah5HH6ht3XY9OpNiq5IxwXO217dpotTtHllUHtyhU0+BsdNdn5M7xiIe3x
         LOrAV6UhRkPA42yCjvrco737P5fgNtPo5zMN5XdgAINTeAABKn5MsbY9htdPH4YdOgSo
         OmMQ==
X-Gm-Message-State: APjAAAW7hxbaPA35o9uTqp8TrDtjzeqdY4ZGqzEnVgK+FcdU9G4JgUV9
        CNH9o2r8t7HGF6qEl85/s8UhHtJZOiAdZOnXkkhr9Q==
X-Google-Smtp-Source: APXvYqyOxl+PXpu5reGUg74ai3rn7pUvqOgFFj/ltVpI5tBssBM7G0fYU3qpDdo8BrymeSstfL1+/v3arhi+uODjgE0=
X-Received: by 2002:a5e:d917:: with SMTP id n23mr19776653iop.182.1552414847453;
 Tue, 12 Mar 2019 11:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
 <CAGyf7-F2wCB7D_JGzd7USaTV0YfmOuFG2Z6GkWVM-JqWKaagQA@mail.gmail.com> <alpine.LFD.2.21.1903121411500.17683@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1903121411500.17683@localhost.localdomain>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 12 Mar 2019 11:20:36 -0700
Message-ID: <CAGyf7-Fb3XGwLtt3XBYK2SX0gZt1cDrA=47LJaBJvbfYWan9LQ@mail.gmail.com>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 11:14 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Tue, 12 Mar 2019, Bryan Turner wrote:
>
> > On Tue, Mar 12, 2019 at 10:23 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > >
> > >   never noticed this before ... when i do a regular "git commit" and
> > > enter my "vi" edit session and change my mind, i can bail with ":q!",
> > > regardless of what i've set up as a commit message, and i'll see:
> > >
> > >   Aborting commit due to empty commit message.
> > >
> > > however, i was just playing with "git revert" and, after i ran:
> > >
> > >   $ git revert <commit SHA>
> > >
> > >   again, simulating that i changed my mind, i just typed ":q!", but
> > > the revert went ahead, anyway. i tried again, this time completely
> > > deleting all the lines from the commit msg (as the template
> > > suggested), but the revert *still* completed after typing ":q!".
> > >
> > >   it was only after deleting all the lines and using ":wq" that the
> > > revert was cancelled:
> > >
> > >   Aborting commit due to empty commit message.
> > >
> > > that seems ... inconsistent. am i misunderstanding something?
>
> ... snip ...
>
> > When you use git revert, though, it writes a valid, usable message
> > to the file ("Revert <subject>\n\nThis reverts commit <sha>"). When
> > you :q!, that's still in the file. Since the file isn't empty, the
> > commit moves ahead.
>
>   again, this is also not true. as i think i mentioned in my earlier
> note, if you get dropped into the revert edit session, even if you
> delete all the usable commit message lines, if you type ":q!", the
> revert commit still succeeds and, in fact, with all of the
> revert-supplied usable lines that you just finished removing.

Again, unless you :w and _write_ deleting the lines, the file that Git
sees still has the default message it generated. So, delete all the
lines, then :w to write that change, and then, as a separate
operation, do :q!. It won't commit the revert.

Hope this helps,
Bryan
