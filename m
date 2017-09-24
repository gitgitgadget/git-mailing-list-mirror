Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF00B2047F
	for <e@80x24.org>; Sun, 24 Sep 2017 20:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbdIXUpC (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 16:45:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36870 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933222AbdIXUo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 16:44:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so5567929wmh.4
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=higtPZMbLk+LCJ1vgLf006irWiqfQvM0agYj9/GUM9E=;
        b=ihqGMYMdrrOmwSj5w3ScDXH0QKGgtGN0mPKmWdTylG9GavaoHE25IUec1M/g1jN47j
         QxgVnrRycEVR+vDhVdJ/O/nb4bAC/+s12DJybdq0vbG40FdEpM1h2pwSvnr5XqKMY6m+
         JL0+E3MGJ8nIWE84PDggDEEOATeOcB/oWC3phV+uQJNHTjZgrsVas/Yi2h2ks4K96S7c
         EKAIzKJIilB+CAOMbi6hlGOvC4d7EbEsmzOaGA/DyYPVlAHyhQEDr20GF57SFs38vsQo
         X9uUDz4jvdo7PwKcm/MTnB+ZGvPzrtg/67/1NqLSZGNs6ZxTqzhURlUROSYx3E3OHzpb
         tq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=higtPZMbLk+LCJ1vgLf006irWiqfQvM0agYj9/GUM9E=;
        b=WEkK2fpLMZaGzdQEcKtrJWOTqLDbZFYZsyO8OldDtuP1ru8Z4WPlPpz70jjasIzkCx
         phWGFxou2du3QiRi5g07i5O3amtlUJd41PUz1sXwjTCWBrUhDlGu5o3a9evpgE+WulfL
         TdAYwJpPowzTZ4/yVdDVX2wAJjfu93+m2yES8SkVYzJbACGBvXYb37HrK3NvvvrJ9eGk
         NX0AZ4B7mm8+kDIJyLH2ECs3uogi0RhCkSesiAEMrNTSsRA2ZARpHrVu1FvxDDNXX4fm
         qG44KkYmHNr66J++tzwSrOeCbCa6KBENj6wl9dLTWUmz+4vOHEk91sFtVZ2LriVfWbwW
         BnUQ==
X-Gm-Message-State: AHPjjUjqkORUuq9GcXgY9/hHGpZ5V12V+VGd9/J+gFczSkqZRz/t3DbA
        t0NU3ov0UeMzNdPR9qaoN+o=
X-Google-Smtp-Source: AOwi7QDvNDnyc4qSVhzTIBdoIhHyoFxFCx4/MgnA5jaJJ5fLNt6CWdZMR8EaTF1cCMUZi3kmPTwGpw==
X-Received: by 10.28.184.151 with SMTP id i145mr7752597wmf.14.1506285897238;
        Sun, 24 Sep 2017 13:44:57 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c78sm2679513wmd.7.2017.09.24.13.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Sep 2017 13:44:55 -0700 (PDT)
Date:   Sun, 24 Sep 2017 21:45:41 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC v2] refs: strip out not allowed flags from
 ref_transaction_update
Message-ID: <20170924204541.GA2853@hank>
References: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
 <20170912225921.27705-1-t.gummerer@gmail.com>
 <4ae6cb35-ecf4-e2a2-302d-95e1442cf101@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ae6cb35-ecf4-e2a2-302d-95e1442cf101@alum.mit.edu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/21, Michael Haggerty wrote:
> On 09/13/2017 12:59 AM, Thomas Gummerer wrote:
> > Callers are only allowed to pass certain flags into
> > ref_transaction_update, other flags are internal to it.  To prevent
> > mistakes from the callers, strip the internal only flags out before
> > continuing.
> > 
> > This was noticed because of a compiler warning gcc 7.1.1 issued about
> > passing a NULL parameter as second parameter to memcpy (through
> > hashcpy):
> > 
> > In file included from refs.c:5:0:
> > refs.c: In function ‘ref_transaction_verify’:
> > cache.h:948:2: error: argument 2 null where non-null expected [-Werror=nonnull]
> >   memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from git-compat-util.h:165:0,
> >                  from cache.h:4,
> >                  from refs.c:5:
> > /usr/include/string.h:43:14: note: in a call to function ‘memcpy’ declared here
> >  extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
> >               ^~~~~~
> > 
> > The call to hascpy in ref_transaction_add_update is protected by the
> 
> s/hascpy/hashcpy/

Argh thanks, good catch.  I see Junio got my original version already
in next, so I guess fixing it now is not really an option anymore :(

> > passed in flags, but as we only add flags there, gcc notices
> > REF_HAVE_NEW or REF_HAVE_OLD flags could be passed in from the outside,
> > which would potentially result in passing in NULL as second parameter to
> > memcpy.
> > 
> > Fix both the compiler warning, and make the interface safer for its
> > users by stripping the internal flags out.
> > 
> > Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > 
> >> This might be a nice change to have anyway, to isolate
> >> `ref_transaction_update()` from mistakes by its callers. For that
> >> matter, one might want to be even more selective about what bits are
> >> allowed in the `flags` argument to `ref_transaction_update()`'s
> >> callers:
> >>
> >>>         flags &= REF_ALLOWED_FLAGS; /* value would need to be determined */
> > 
> > Here's my attempt at doing this.
> > 
> > The odd flag out as the flag that's advertised as internal but can't
> > stripped out is REF_ISPRUNING.  REF_ISPRUNING is passed in as argument
> > to 'ref_transaction_delete()' in 'prune_ref()'.
> > 
> > Maybe this flag should be public, or maybe I'm missing something here?
> > Having only this internal flags as part of the allowed flags feels a
> > bit ugly, but I'm also unfamiliar with the refs code, hence the RFC.
> > If someone has more suggestions they would be very welcome :)
> 
> I wouldn't worry too much about this anomaly. `REF_ISPRUNING` is an ugly
> internal kludge, but allowing it in the mask doesn't make anything worse.

Makes sense, thanks!

> >  refs.c | 2 ++
> >  refs.h | 8 ++++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/refs.c b/refs.c
> > index ba22f4acef..fad61be1da 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -921,6 +921,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
> >  		return -1;
> >  	}
> >  
> > +	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
> > +
> 
> I would advocate considering it a bug if the caller passes in options
> that we are going to ignore anyway:
> 
>         if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
>                 BUG("illegal flags %x in ref_transaction_update", flags);
> 
> Would this also squelch the compiler warning?

I thought about this, and I agree that it would be nicer to do this
way.  However unfortunately the compiler is not smart enough to
realize that this is gives the same guarantees as stripping the flags
out, and thus still emits the warning.  This is why I went with just
stripping them out.

I'm not sure if it's worth additionally adding this check?  I think it
would read a bit weirdly to check whether the flags are there and to
then "strip" them out when we already know they are not there.

> >  	flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
> >  
> >  	ref_transaction_add_update(transaction, refname, flags,
> > diff --git a/refs.h b/refs.h
> > index 6daa78eb50..4d75c207e1 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -354,6 +354,14 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags);
> >  #define REF_NODEREF	0x01
> >  #define REF_FORCE_CREATE_REFLOG 0x40
> >  
> > +/*
> > + * Flags that can be passed in to ref_transaction_update
> > + */
> > +#define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
> > +	REF_ISPRUNING |                      \
> > +	REF_FORCE_CREATE_REFLOG |            \
> > +	REF_NODEREF
> > +
> >  /*
> >   * Setup reflog before using. Fill in err and return -1 on failure.
> >   */
> > 
> 
> Thanks for working on this.

Thanks for the review!

> Michael
