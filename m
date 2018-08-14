Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00061F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeHNUw1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:52:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42793 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbeHNUw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:52:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so9583741pff.9
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iTu7G6s8GDeJAq0sNKG4qHALISaeF9mKWEKo8eKM27M=;
        b=Kzp8nSuob7Hh/nnHqQJ/0W0zYXNSPQQpaToavQay0zdxCccxETJewHFXBdM9mL5AOr
         z+k9YJlpUQ8DKWgG87slLGJVGfJySreb1YcLp8HM5EvXQLKXp6o59GtDKKTdCTPEcgUV
         LAEX8GP1GYcfr4M4UZ6OOe3AOjA3vjfHOBBc7Pr6qM8jXKxDkrBvWBn9BGdL+E4M9kJb
         kN13TfAn8mX7F//Z0sAp1cBvQVA3BBI5gX6bfKohW7N/Dm4IXsLtSDer+l/w8dB7vMe0
         YudWcJzt+jkVGtlDZ3pwrlwwJ4ixv3bLk2HW4hxoMFgQ0SleZm2SCmZuMxLEJovqs05G
         tsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iTu7G6s8GDeJAq0sNKG4qHALISaeF9mKWEKo8eKM27M=;
        b=L+6wPR574nY9QbuJYmpAcECO5hXO8yF7AdOEOX310IRhVM0E4MsQWhCZc57sgSMgGI
         SAJ2D3twrTSSlFxIQRJz8aLBJaYuR7zc3KPgOM/a8L7K3ylsIoxyBODq5E0xs7boHNSz
         eKwZBWrUOKWJW9DfRc1qFoofdqAGWi2qv8Xr6ScdykHDy4EJFkEOjWaI7M0gYTchdj9w
         jMP8Dj1Ucofu8pxsIwMUGWlVbcGtpLHY9vZtXWO+8sIiFxbYdoM/tW1DjXFUoNBySB8H
         vgSMO6W05CQoy7slEvdcIfokfJrO1V/OMJT9r1brX8JFaFrNBXGvh6wHsGR2gSiq1pj7
         dCTw==
X-Gm-Message-State: AOUpUlEfgf9+L9+NZsjOfsq/66FeeXyWXUmSNFxlUnt+ogWMaB7FqHEr
        EX1m9uavUJHUylH0+FIY905l0DnLBg8=
X-Google-Smtp-Source: AA+uWPw15SHzrN0F66km0OXLV6ljmVJ7JZcFjX6DkaSpR3PGZHlLCS3HCW6whYdO2CQG5yL+MK/aaw==
X-Received: by 2002:a63:de4c:: with SMTP id y12-v6mr21899368pgi.435.1534269848510;
        Tue, 14 Aug 2018 11:04:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z2-v6sm19676359pgv.12.2018.08.14.11.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 11:04:07 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:04:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180814180406.GA86804@google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809212602.GA11342@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09, Jeff King wrote:
> On Wed, Aug 08, 2018 at 03:33:23PM -0700, Brandon Williams wrote:
> 
> > Commit 0383bbb901 (submodule-config: verify submodule names as paths,
> > 2018-04-30) introduced some checks to ensure that submodule names don't
> > include directory traversal components (e.g. "../").
> > 
> > This addresses the vulnerability identified in 0383bbb901 but the root
> > cause is that we use submodule names to construct paths to the
> > submodule's git directory.  What we really should do is munge the
> > submodule name before using it to construct a path.
> > 
> > Teach "submodule_name_to_gitdir()" to munge a submodule's name (by url
> > encoding it) before using it to build a path to the submodule's gitdir.
> 
> I like this approach very much, and I think using url encoding is much
> better than an opaque hash (purely because it makes debugging and
> inspection saner).
> 
> Two thoughts, though:
> 
> > +	modules_len = buf->len;
> >  	strbuf_addstr(buf, submodule_name);
> > +
> > +	/*
> > +	 * If the submodule gitdir already exists using the old-fashioned
> > +	 * location (which uses the submodule name as-is, without munging it)
> > +	 * then return that.
> > +	 */
> > +	if (!access(buf->buf, F_OK))
> > +		return;
> 
> I think this backwards-compatibility is necessary to avoid pain. But
> until it goes away, I don't think this is helping the vulnerability from
> 0383bbb901. Because there the issue was that the submodule name pointed
> back into the working tree, so this access() would find the untrusted
> working tree code and say "ah, an old-fashioned name!".
> 
> In theory a fresh clone could set a config option for "I only speak
> use new-style modules". And there could even be a conversion program
> that moves the modules as appropriate, fixes up the .git files in the
> working tree, and then sets that config.
> 
> In fact, I think that config option _could_ be done by bumping
> core.repositoryformatversion and then setting extensions.submodulenames
> to "url" or something. Then you could never run into the confusing case
> where you have a clone done by a new version of git (using new-style
> names), but using an old-style version gets confused because it can't
> find the module directories (instead, it would barf and say "I don't
> know about that extension").
> 
> I don't know if any of that is worth it, though. We already fixed the
> problem from 0383bbb901. There may be a _different_ "break out of the
> modules directory" vulnerability, but since we disallow ".." it's hard
> to see what it would be (the best I could come up with is maybe pointing
> one module into the interior of another module, but I think you'd have
> to trouble overwriting anything useful).
> 
> And while an old-style version of Git being confused might be annoying,
> I suspect that bumping the repository version would be even _more_
> annoying, because it would hit every command, not just ones that try to
> touch those submodules.

Oh I know that this doesn't help with that vulnerability.  As you've
said we fix it and now disallow ".." at the submodule-config level so
really this path is simply about using what we get out of
submodule-config in a more sane manor.

> 
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index 2c2c97e144..963693332c 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -933,7 +933,7 @@ test_expect_success 'recursive relative submodules stay relative' '
> >  		cd clone2 &&
> >  		git submodule update --init --recursive &&
> >  		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
> > -		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
> > +		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir%2fsubsub" >./sub3/dirdir/subsub/.git_expect
> 
> One interesting thing about url-encoding is that it's not one-to-one.
> This case could also be %2F, which is a different file (on a
> case-sensitive filesystem). I think "%20" and "+" are similarly
> interchangeable.
> 
> If we were decoding the filenames, that's fine. The round-trip is
> lossless.
> 
> But that's not quite how the new code behaves. We encode the input and
> then check to see if it matches an encoding we previously performed. So
> if our urlencode routines ever change, this will subtly break.
> 
> I don't know how much it's worth caring about. We're not that likely to
> change the routines ourself (though certainly a third-party
> implementation would need to know our exact url-encoding decisions).

This is exactly the reason why I wanted to get some opinions on what the
best thing to do here would be.  I _think_ the best thing would probably
be to write a specific routine to do the conversion, and it wouldn't
even have to be all that complex.  Basically I'm just interested in
converting '/' characters so that things no longer behave like
nested directories.

> 
> Some possible actions:
> 
>  0. Do nothing, and cross our fingers. ;)
> 
>  1. Don't use strbuf_addstr_urlencode(), but rather our own munging
>     function which we know will remain stable (or alternatively, a flag
>     to strbuf_addstr_urlencode to get the consistent behavior).
> 
>  2. Make sure we have tests which cover this, so at least somebody
>     changing the urlencode decisions will see a breakage. Your test here
>     covers the upper/lowercase one, but we might want one that covers
>     "+". (There may be more ambiguous cases, but those are the ones I
>     know about).
> 
>  3. Rather than check for the existence of names, decode what's actually
>     in the modules/ directory to create an in-memory index of names.
> 
>     I hesitate to suggest that, because it's obviously way more
>     complicated, and may perform worse if you have a lot of modules
>     (since you have to readdir() and decode the whole directory just to
>     look up one module).
> 
>     But I think it also gives a more elegant solution to the
>     backwards-compatibility problem, since we could recognize both new
>     and old-style names. There's some ambiguity (e.g., is "foo%2fbar"
>     "foo/bar", or did somebody really have a name with a percent in
>     it?),. but in theory you could respect either name (giving
>     preference to new-style in case of a conflict).
> 
>     And I think the result would be immune to any directory-escape
>     vulnerabilities, because we'd always start with what actually exists
>     in $GIT_DIR/modules/, which we know _we_ will have written.
> 
>     Again, I'm not sure if it's worth the effort, but I thought I'd
>     throw it out there.
> 
> -Peff

-- 
Brandon Williams
