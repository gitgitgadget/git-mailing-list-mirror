Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8461F462
	for <e@80x24.org>; Tue, 21 May 2019 23:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEUXwU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 19:52:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39713 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEUXwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 19:52:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so276063pfg.6
        for <git@vger.kernel.org>; Tue, 21 May 2019 16:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljek3ytFFn+bfG29j+KZIIzCwe3sfDssnGvnhL789d8=;
        b=dqZ6MU08s0zki2mHTvYkzLTnR1F41hHEft0xkCIWi0Oj1y/FSK0hFvJv03Uw1MkQaF
         b8/DkTeiYKk6GY1ZfYLNsFPoZrYPo2dmNEZjM7aJ8Wo2x9YD35xKhxMZosGdDk4Cx3E2
         zAjXfw9i4oaBLmkWQLcUNoFeJgjD6tgPLtLGxmoSfXeaglX28rzmccpcFY4OR3kBFrrV
         WzKVibT+7/AX9pWK1zb/+tdNduCCc9CJM88GVkmpMEaCb80lqoMjWiq3nA8827h49Ra2
         yISCcVHyuqmYo+z8hszkSo3GH+6MfuT7lrzKfQd6IeOPEXYF4Wf8Lsb5hSKNVFDHOjF5
         IkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljek3ytFFn+bfG29j+KZIIzCwe3sfDssnGvnhL789d8=;
        b=f5DEck9ZrpjXvjn405qiBRrcjSYjk2P/1Fdxrbwpu9SmXh9L55OHczTMAtUjfXda7A
         hz+75yhekNRGwiYJK3rWrOUR2veTZv6WeQdGRHCGYEcu0Myck+kbSX9giRn9yzkBkaDO
         JD6UvjWC6lc261LlzPzXPq3LCGogSRPGRha8k8rr6DUwQNZVAa9lBoSM+BsVH8kNqRHh
         Tg6a85vSSg5n355ZsAQDWm4ifvNoZTGqUWxSG3//w8D06k2PlTFiHsvDFzefDzeu/8mq
         hX4FYWXt0Mx4IvS7xWBT8PvFAX1mMPusGBTmwTZwuzmHzDONl0AwY+fACU7yHd4sfc7i
         CRpQ==
X-Gm-Message-State: APjAAAXYF5D/3BA3C0vn0FfLduLHVvM8iYTfXyRmi8E46PxwLIfO0j4I
        jpxLBmZgBcnGIGovL3nu8mp5TtCPqmmDcQ==
X-Google-Smtp-Source: APXvYqyS9vNf9o/G6AHrmpe6QMNdSw8gLewi5Wcefe5ckhy0VT0bBZPQHpVx9zEEWH28x1fFdEJIKQ==
X-Received: by 2002:a63:1726:: with SMTP id x38mr31007750pgl.365.1558482738198;
        Tue, 21 May 2019 16:52:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id a3sm24730045pgl.74.2019.05.21.16.52.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 16:52:17 -0700 (PDT)
Date:   Tue, 21 May 2019 16:52:12 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrn@google.com
Subject: Re: [PATCH v2] grep: provide sane default to grep_source struct
Message-ID: <20190521235212.GA46998@google.com>
References: <20190516020023.61161-1-emilyshaffer@google.com>
 <20190516214444.191743-1-emilyshaffer@google.com>
 <20190516220254.GG10787@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516220254.GG10787@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 06:02:54PM -0400, Jeff King wrote:
> On Thu, May 16, 2019 at 02:44:44PM -0700, Emily Shaffer wrote:
> 
> > grep_buffer creates a struct grep_source gs and calls grep_source()
> > with it. However, gs.name is null, which eventually produces a
> > segmentation fault in
> > grep_source()->grep_source_1()->show_line() when grep_opt.status_only is
> > not set.
> 
> Funny wrapping here.
> 
> > This seems to be unreachable from existing commands but is reachable in
> > the event that someone rolls their own revision walk and neglects to set
> > rev_info->grep_filter->status_only. Conceivably, someone might want to
> > print all changed lines of all commits which match some regex.
> > 
> > To futureproof, give developers a heads-up if grep_source() is called
> > and a valid name field is expected but not given. This path should be
> > unreachable now, but in the future may become reachable if developers
> > want to add the ability to use grep_buffer() in prepared in-core data
> > and provide hints to the user about where the data came from.
> 
> So I guess this is probably my fault, as I was the one who factored out
> the grep_source bits long ago (though I would also not be surprised if
> it could be triggered before, too).
> 
> I think adding a BUG() is the right thing to do.
> 
> > I've added the BUG() line to grep_source(). I considered adding it to
> > grep_source_1() but didn't see much difference. Looks like
> > grep_source_1() exists purely as a helper to grep_source() and is never
> > called by anybody else... but it's the function where the crash would
> > happen. So I'm not sure.
> 
> I agree it probably doesn't matter. I'd probably stick at at the top of
> grep_source_1(), just with the rationale that it could possibly catch
> more cases if somebody ever refactors grep_source() to have two
> different callers (e.g., imagine we later add a variant that takes more
> options, but leave the old one to avoid disrupting existing callers).

I think this combined with needing a history lesson to know not to call
grep_source_1() makes a pretty strong case for moving it. I'll put the
BUG() line at the top of grep_source_1() instead.

> 
> > I also modified the wording for the BUG("") statement a little from
> > jrn's suggestion to hopefully make it more explicit, but I welcome
> > wordsmithing.
> > [...]
> > +		BUG("grep call which could print a name requires "
> > +		    "grep_source.name be non-NULL");
> 
> It looks fine to me. The point is that nobody should ever see this. And
> if they do, we should already get a file/line number telling us where
> the problem is (and a coredump to poke at). So as long as it's enough to
> convince a regular user that they should make a report to the mailing
> list, it will have done its job.
> 
> > diff --git a/grep.c b/grep.c
> > index 0d50598acd..6ceb880a8c 100644
> > --- a/grep.c
> > +++ b/grep.c
> > @@ -2021,6 +2021,9 @@ static int chk_hit_marker(struct grep_expr *x)
> >  
> >  int grep_source(struct grep_opt *opt, struct grep_source *gs)
> >  {
> > +	if (!opt->status_only && gs->name == NULL)
> > +		BUG("grep call which could print a name requires "
> > +		    "grep_source.name be non-NULL");
> >  	/*
> >  	 * we do not have to do the two-pass grep when we do not check
> >  	 * buffer-wide "all-match".
> 
> Minor nit, but can we put a blank line between the new block and the
> comment?

I made sure to include blank lines surrounding this block in its new
home.

> 
> > @@ -2045,7 +2048,11 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
> >  	struct grep_source gs;
> >  	int r;
> >  
> > -	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
> > +	/* TODO: In the future it may become desirable to pass in the name as
> > +	 * an argument to grep_buffer(). At that time, "(in core)" should be
> > +	 * replaced.
> > +	 */
> > +	grep_source_init(&gs, GREP_SOURCE_BUF, _("(in core)"), NULL, NULL);
> 
> Hmm. I don't see much point in this one, as it would just avoid
> triggering our BUG(). If somebody is adding new grep_buffer() callers
> that don't use status_only, wouldn't we want them to see the BUG() to
> know that they need to refactor grep_buffer() to provide a name?

For me, I'd rather have *some* functionality available without doing a
large refactor. The line now isn't inaccurate, and `git grep --fixed
"(in core)"` shows it's the only instance of that string in the
codebase, so it's easy to track down where it's happening. Though the
BUG() line is pretty easy to track down too.

Having a default field like this might help folks move quickly if they
just want proof of concept that their idea works without adding a
bunch of plumbing. But then, they could add it on their own if they're
that early in their feature....

Can we think of a reason anybody would want to be able to use it this
way with the placeholder string?

> 
> -Peff

Thanks for your comments Peff.

- Emily
