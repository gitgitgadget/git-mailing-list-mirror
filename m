Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9F31F461
	for <e@80x24.org>; Fri,  6 Sep 2019 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394397AbfIFOSS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 10:18:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39688 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391133AbfIFOSR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 10:18:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so6781354wra.6
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VnK2NrlOHdDJVBTBPXUSNNe/vRFESw2GlaRZGNEPydA=;
        b=VSnBTu8TFz+KdyvIOdR+mFsLXPlWYOvasDzvnyR84/+3+wPayR7z5iIlClMSYmh9Vh
         VZMlBKTkU+74SLGX5kJccYda2sefdQNRkF+gfMqpGunxUoq+AhaWUJo2lzGcSCeKoA3S
         8BrVLjwtZk3bmAc2iKpQO453JBeQs14uqMch0Qti2sXZtn6FUtMlQtccnLgroCxXyvZk
         7/bPMZnjDeQQoFxRMvSx6OaHdaa+bDysNa+p8nJ41AwiznxlT0//Cwka3WK+SshOmY8U
         S9ycXzUWCK2cjToX/Z9E3VogFT7Tu1jOzUU2ir37JUfZcoLxb7AMxfncZdJRflRIfy8p
         q/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VnK2NrlOHdDJVBTBPXUSNNe/vRFESw2GlaRZGNEPydA=;
        b=jPIQD1TRP1fRFHWyMAlM2DNi0pAZyJLwbcwpy50FtRiiuse8ckUWent/XaDALyM4FM
         SOfCA3tcLzz4l63K9scLW2BX+Dg03Xx0LN7xTVNLZ3+9obZzOBwP569gbfU8X8UXFrPF
         f4ua8OwwEJfeaYh+UQUTkSnudm5hAHri0bcPDYMuBTskPu0IwINVgp5hXhHTcvuiosWn
         rlHcxcsb24zTYi6eAoKdCPRTcZW5C2tcOc+sJhtRkyU6eriw9u0Wjbf9ve8HxfI47o1S
         0Od9U42mdeMRu88spBlearBZlMPd6c5+/VxaPwxyQz5Y/JoQqe5mx+txBaJJRGNNybax
         6TTw==
X-Gm-Message-State: APjAAAWu2EJSuG1X0dWfLimqJc2cvAhnlJf6XAdbC7MKjce7ls/y09P2
        Oke9Dg/GHQt+Us0sUN5+d4o=
X-Google-Smtp-Source: APXvYqxwBC1ypLHhgviUIG2Z5bh1SNIm0vLL+ocPyIWT5T/WAoSBUYB5hNKI1LrFgEWKZzdVjJljeg==
X-Received: by 2002:adf:f709:: with SMTP id r9mr7872862wrp.228.1567779494741;
        Fri, 06 Sep 2019 07:18:14 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id b144sm6257475wmb.3.2019.09.06.07.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 07:18:13 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:18:12 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 1/3] factor out refresh_and_write_cache function
Message-ID: <20190906141812.GA128436@cat>
References: <20190829182748.43802-1-t.gummerer@gmail.com>
 <20190903191041.10470-1-t.gummerer@gmail.com>
 <20190903191041.10470-2-t.gummerer@gmail.com>
 <xmqqwoemo131.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwoemo131.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Getting the lock for the index, refreshing it and then writing it is a
> > pattern that happens more than once throughout the codebase, and isn't
> > trivial to get right.  Factor out the refresh_and_write_cache function
> > from builtin/am.c to read-cache.c, so it can be re-used in other
> > places in a subsequent commit.
> >
> > Note that we return different error codes for failing to refresh the
> > cache, and failing to write the index.  The current caller only cares
> > about failing to write the index.  However for other callers we're
> > going to convert in subsequent patches we will need this distinction.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  builtin/am.c | 16 ++--------------
> >  cache.h      | 16 ++++++++++++++++
> >  read-cache.c | 19 +++++++++++++++++++
> >  3 files changed, 37 insertions(+), 14 deletions(-)
> 
> I think this goes in the right direction, but obviously conflicts
> with what Dscho wants to do in the builtin-add-i series, and needs
> to be reconciled by working better together.

Oops, I didn't realize there was another series in flight that also
introduces 'repo_refresh_and_write_index'.  Probably should have done
a test merge of this with pu.

> For now, I'll eject builtin-add-i and queue this for a few days to
> give it a bit more exposure, but after that requeue builtin-add-i
> and discard these three patches.  By that time, hopefully you two
> would have a rerolled version of this one and builtin-add-i that
> agree what kind of refresh-and-write-index behaviour they both want.
>
> The differences I see that need reconciling are:

Thanks for writing these down.

>  - builtin-add-i seems to allow 'gentle' and allow returning an
>    error when we cannot open the index for writing by passing false
>    to 'gentle'; this feature is not used yet, though.

Right, and if gentle is set to false, it avoids writing the index,
which seems fine from my perspective.

>  - This version allows to pass pathspec, seen and header_msg, while
>    the one in builtin-add-i cannot limit the part of the index
>    getting refreshed with pathspec.  It wouldn't be a brain surgery
>    to use this version and adjust the caller (there only is one) in
>    the builtin-add-i topic.

'pathspec', 'seen' and 'header_msg' are not used in my version either,
I just implemented it for completeness and compatibility.  So I'd be
fine to do without them.

>  - This version does not write the index back when refresh_index()
>    returns non-zero, but the one in builtin-add-i ignores the
>    returned value.  I think, as a performance measure, it probably
>    is a better idea to write it back, even when the function returns
>    non-zero (the local variable's name is has_errors, but having an
>    entry in the index that does not get refreshed is *not* an error;
>    e.g. an unmerged entry is a normal thing in the index, and as
>    long as we refreshed other entries while having an unmerged and
>    unrefreshable entry, we are making progress that is worth writing
>    out).

I'm happy with writing the index back even if there are errors.
However I think we still need the option to get the return code from
'refresh_index()', as some callers where I'm using
'refresh_and_write_index()' in this series behave differently
depending on its return code.

There's two more differences between the versions:

 - The version in my series allows passing in write_flags to be passed
   to write_locked_index, which is required to convert the callers in
   builtin/merge.c.

 - Dscho's version also calls 'repo_read_index_preload()', which I
   don't do in mine.  Some callers don't need to do that, so I think it
   would be nice to keep that outside of the
   'repo_refresh_and_write_index()' function.

I can think of a few ways forward here:

 - I incorporate features that are needed for the builtin-add-i series
   here, and that is rebased on top of this series.

 - We drop the first two patches of this series, so we only fix the
   problems in 'git stash' for now.  Later we can have a refactoring
   series that uses repo_refresh_and_write_index in the places we
   converted here, once the dust of the builtin-add-i series settled.

 - I rebase this on top of builtin-add-i.

I'm happy with either of the first two, but less so with the last
option.  I was hoping this series could potentially go to maint as it
was a bugfix, which we obviously can't do with that option.

Dscho, what do you think? :)

> Thanks.
> 
> > +int repo_refresh_and_write_index(struct  repository *repo,
> > +				 unsigned int refresh_flags,
> > +				 unsigned int write_flags,
> > +				 const struct pathspec *pathspec,
> > +				 char *seen, const char *header_msg)
> > +{
> > +	struct lock_file lock_file = LOCK_INIT;
> > +
> > +	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
> > +	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg)) {
> > +		rollback_lock_file(&lock_file);
> > +		return 1;
> > +	}
> > +	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
> > +		return -1;
> > +	return 0;
> > +}
> > +
> > +
> >  int refresh_index(struct index_state *istate, unsigned int flags,
> >  		  const struct pathspec *pathspec,
> >  		  char *seen, const char *header_msg)
