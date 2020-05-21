Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C59C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE59207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdbWg1rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEUTbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUTbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 15:31:51 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163FC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 12:31:50 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r25so7223999oij.4
        for <git@vger.kernel.org>; Thu, 21 May 2020 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnMA1hD6anJuTIUybxEeiyDwJr6BoVnVh+917uqJA6I=;
        b=rdbWg1rdEU5YvAQkZH2O/5aK/HJuuVsc4fZbZqZEGl6fK+sovVeWyH2WaSyt0gkY+5
         W6RSuV4m/yrOjoJOqgcU5SurpL/vtdOTm3Gx1Lx7JY+Q3IldjKofmxEGcyENDK9L85qw
         hnxZS9yrzMuiodQci5yFqJDzowkGHNwYIMYC2BGxSDGNIOM+DCtSfQq2teYSfM2bPxBT
         N5/UUyPKzxxImcpgVhRMLcc+WOpbzYrtlLsUBJilaqCKJqHe5pltI3qZvV12/WA/47q9
         TdezUOvEn4mStK7OJekSafdtOwa3qFggMg/H/lbxZ7atD4g0E9WR6aW54Yd+nwHD9D9y
         HLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnMA1hD6anJuTIUybxEeiyDwJr6BoVnVh+917uqJA6I=;
        b=ExmbGIFFB2HzRyE9gAXIy2SkvcNCAJB9h9M7C02MQzTgs23+xe41ryV4XXYrkTDHIA
         rRiZ22zbff0ISCLD9wi4fBXqyQv2s60mKb4THWiJX1IuPKVKwTtB14sgijoHe9QU1cq+
         4evp66NKtDgBK38o4bS3igPvFZ8DJqm2s2T+jvlvCckwTKXg6/N24N1VzGeQ+y1Fpdj6
         xBlEVghp6Yi12BneI9eg4YOkUvSQ32qAm3/EpeDqcER8y93qA1jayAjMDnEqQaI4SaUI
         fxr3ibaemfi1Uhbq/0oHFJbklM40BAbf9NXDS2JoWgoEhPw9ooojOZt54nRXmyaojp/Y
         7Pjw==
X-Gm-Message-State: AOAM530LZ7K379P/sG8jlbjFAj7AlHkNSxeUiR+B+tONUqpEAnkxrvCB
        7LzFcvDcj56uGVnMQabgLWTXhcydb29gbhGLD4GhTylJ
X-Google-Smtp-Source: ABdhPJxNR0JrQtzePdRYIpokCqLWx5CjscmTmg0AUnv2z86gnOoxi2q3+UlTZwYLKt5zjBxfZkdgVUAn06DAxtQlQu8=
X-Received: by 2002:aca:220f:: with SMTP id b15mr83339oic.31.1590089508750;
 Thu, 21 May 2020 12:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFfa6q96qMUN07Dq3di6d3WuUzhyktBytbX=FGgarXgjg@mail.gmail.com>
 <20200521185753.GB1308489@coredump.intra.peff.net>
In-Reply-To: <20200521185753.GB1308489@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 May 2020 12:31:36 -0700
Message-ID: <CABPp-BG+XdbeOgaL1Th6U8g-gRON41DCwZ-RDnN7CEgk2fvwDg@mail.gmail.com>
Subject: Re: Anyone know what is creating commits with bogus dates?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 11:57 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 21, 2020 at 10:49:17AM -0700, Elijah Newren wrote:
>
> > I wanted to report that we seem to have a number of repos in the wild
> > with bogus (as in "won't even parse") dates.
> >
> > I first discovered such a repository in the wild a while ago with
> > rails.git.  It has a commit with a recorded timezone of "+051800" for
> > both author and committer.  Everything else about the commit looks
> > fine.  See https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734.
> >
> > Some google searches at the time turned up a few other examples, all
> > with the same "+051800" issue.  I put a special workaround for it into
> > filter-repo because I figured it was slightly prominent but probably
> > limited to that special timezone.  The fact that it was six digits but
> > the last two were zeros made it seem not quite as bad as it could be.
>
> I can't remember the source of the bug, but we've had a workaround in
> GitHub's incoming fsck checks to allow 6-digit zones like this since
> August 2011. I'm almost certain that it came up because of that
> rails/rails commit, but I don't remember the culprit implementation. I'm
> sure we would have dug it up and fixed it at the time.

What about 7- and 8- digit timezones (like the ones in the linked
filter-repo issue report)?  Do you currently prevent users from
pushing those to GitHub, or do you allow those too?
I'm curious about whether there is anything else out there that might
help flag these commits or if it's just filter-repo.

> Sadly our commit message for the fsck tweak gives no further details,
> nor can I dig up anything out of issues/etc.
>
> I _think_ it wasn't GitHub/grit which did this (the 0-prefixed tree
> modes you might come across are, though). I couldn't find any mention of
> the fix there, at least. I'd suspect perhaps libgit2, but I also
> couldn't find any fix.
>
> But I think it would be safe to assume the bug is long-since fixed, and
> it's nice if you can be a bit more lenient on the parsing for historical
> issues like this. Arguably fast-export ought to be normalizing it to
> something syntactically correct (just like we probably do with other
> unparsable dates), though I guess you could argue that a filter might
> want to see the broken form in order to fix it in a custom way.

If we're going to be more lenient on the parsing, does that suggest
fast-import shouldn't die on these?  Currently, fast-import is the
thing dying, not fast-export or filter-repo (though filter-repo of
course halts when it notices that fast-import has died under it).

I put in special-case code in filter-repo to munge the +051800
timezone case to keep fast-import from dying, but these new cases seem
to suggest it's not just one bad timezone that I can check for and
correct, but rather that they are completely random 7- or 8- (or who
knows how many) digit timezones coupled with bogus
(century-into-the-future) unix epochs.  I'm a little less comfortable
working around all of these than the very specific +051800 issue.  On
the filter-repo side, I think the most I would want to do here is
provide cleaner warning or error messages than "fast-import died,
here's a traceback."  But I'm unusre if there are other steps we
should take as well, such as making the fast-import parser more
lenient.
