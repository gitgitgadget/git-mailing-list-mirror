Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7921B20282
	for <e@80x24.org>; Wed, 14 Jun 2017 17:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbdFNRTK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 13:19:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33349 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdFNRTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 13:19:09 -0400
Received: by mail-pf0-f170.google.com with SMTP id 83so3384626pfr.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Np21Q0nCw7DgkkXG9lqa+5/s35r1IYhGLNJUvRGaXsM=;
        b=PxTx9/chC1+6Gp2fTdwYokk7zddlzsS+LJd+d5kn3Imz/UWkcgYcX/dijS9nVIUegO
         2zDtcOYep0m4ljdUqdY6pDccMiF8tpJLfXujQt2cJ9BN1U+eLs40Oikik7gpWyzcab6N
         D6YnSejKLKDahc8o2xnBTuCb6TIVP8QR6qJkef0Sn4oeFQJZUPH83WAPErhYx6gWwlPo
         nw4uIKlID4nq+HVS0kvzAdO4IPmwqbXjBSL2kDJxn7SzGOZAq7QljFDl5NmxwSIGXwYG
         52iqSXlnDG5s2z+5Lih0LjSBHn1FV5Cg3rqKpambG/Ds1rslW+yu8rhbUi5nvFATuQj8
         LtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Np21Q0nCw7DgkkXG9lqa+5/s35r1IYhGLNJUvRGaXsM=;
        b=Ivo3fllMWSvg4vaN2jUi14F67kPJ98hH+srBWBvpbs/vF/G6hF8kLnm4UIL1mXIiUs
         lnwlK8bjMOeI3bX2F0EgWZvZj7moD7Fnr6B9iPNexxYcS4rsqKYW8lMlQw4ZZAJL+0GO
         XhThNbspH/BOUJ/qKZ/2HtiM2hRVXivI2j2tVzWnDJnYtB7ksbCtZviTE2nr+75hycSZ
         Z0olcQ+zDXIjSpL0BaRWxsN/HFMs0iQpL4aZGu/8kIirAAhtqBQ/bCKIYMzPLFF/eR/s
         BVk7M2v7mPJxoDx8ao/nn0RLMjDLjnlx7QCVZqPrr0IErvWQxEUWjzMLRqGp/L0C4pJv
         ayrw==
X-Gm-Message-State: AKS2vOzkuH3DRryB5joC+3cFiJ1sIpItw2UGkxE5LCJ0bPC7/gBJ84Hg
        IC+w8axBCtv1kq7F
X-Received: by 10.98.27.215 with SMTP id b206mr1036910pfb.123.1497460748368;
        Wed, 14 Jun 2017 10:19:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cd44:1c15:d824:b4e])
        by smtp.gmail.com with ESMTPSA id t11sm1134764pfl.3.2017.06.14.10.19.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 10:19:07 -0700 (PDT)
Date:   Wed, 14 Jun 2017 10:19:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 5/6] setup: teach discover_git_directory to respect
 the commondir
Message-ID: <20170614171906.GB55677@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-6-bmwill@google.com>
 <20170614061548.uqxtbmwizfdyivv7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614061548.uqxtbmwizfdyivv7@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Jeff King wrote:
> On Tue, Jun 13, 2017 at 02:03:20PM -0700, Brandon Williams wrote:
> 
> > Currently 'discover_git_directory' only looks at the gitdir to determine
> > if a git directory was discovered.  This causes a problem in the event
> > that the gitdir which was discovered was in fact a per-worktree git
> > directory and not the common git directory.  This is because the
> > repository config, which is checked to verify the repository's format,
> > is stored in the commondir and not in the per-worktree gitdir.  Correct
> > this behavior by checking the config stored in the commondir.
> > 
> > It will also be of use for callers to have access to the commondir, so
> > lets also return that upon successfully discovering a git directory.
> 
> This makes sense, and I agree is the correct path forward for handling
> the config code's needs.
> 
> > diff --git a/cache.h b/cache.h
> > index fd45b8c55..a4176436d 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -530,7 +530,8 @@ extern void setup_work_tree(void);
> >   * appended to gitdir. The return value is either NULL if no repository was
> >   * found, or pointing to the path inside gitdir's buffer.
> >   */
> > -extern const char *discover_git_directory(struct strbuf *gitdir);
> > +extern const char *discover_git_directory(struct strbuf *commondir,
> > +					  struct strbuf *gitdir);
> 
> Does the docstring above the function need updating? What happens when
> you are not in a worktree? Are both strbufs filled out with the same
> value?

Yes I'll update the docstring to reflect the change.  And yes if you
aren't in a worktree, then both strbufs would hold the same value.

> That's what I'd assume (and what it looks like looking at the code), but
> it's probably worth being explicit.
> 
> We also return a pointer. I think this still points into the gitdir
> strbuf. Which I guess is reasonable, though probably should be
> documented.
> 
> Given that the callers only ever look at whether it's non-NULL, it
> probably would be better to just return a true/false value. This might
> be a good time to do that, because the function signature is changing
> already (so if we switch to the usual "0 is success", a newly added call
> won't silently do the wrong thing).

I agree with that.  I can tweak the return value to return a success
code.

> 
> > @@ -983,6 +987,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
> >  		warning("ignoring git dir '%s': %s",
> >  			gitdir->buf + gitdir_offset, err.buf);
> >  		strbuf_release(&err);
> > +		strbuf_setlen(commondir, commondir_offset);
> >  		return NULL;
> >  	}
> 
> I'd have expected these resetting setlens to be paired between gitdir
> and commondir. And indeed, they should be; this is the same case that
> Dscho fixed in the first patch of his series.
> 
> I kind of wonder if one of you should take ownership and do a combined
> series.

Yeah I think that Dschos series has less review to still take place (as
he just sent out a v3) so I'll just rebase ontop of his series.

-- 
Brandon Williams
