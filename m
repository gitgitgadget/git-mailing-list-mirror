Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58F51F463
	for <e@80x24.org>; Sun, 22 Sep 2019 19:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfIVTFR (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 15:05:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46938 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbfIVTFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 15:05:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3so10825802edw.13
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZNy0WK2foLeyKhsG4P8Z5Ij5aElk6tOSripZr8euWn0=;
        b=A+UUP0P9E3gWili20OJdy5xqrV/ttCVSzHMBVvsMVksfieNFaDntXx/npSVG/jvY2v
         JqfR9xAK6GGijPAxpPL7+ad8521hy5ycr5uxXDQrXxXrPQV+CmiXdG1e7Vrn7KbgRTJo
         1jmckSetMwRYEUOaOUUFmm/MNCEh3f9v/Hl3nDy0cLEBmzGzBTf/5xaNVhyS4sdozV2Z
         DalXgscc5349HfNKgnNif+LrPHDjuSaLzcvfF6bOEoJuM8mc2KUrR2ImTP30Oee+N6VO
         YsgirgRw0jEdmjeWFC6vD8KI9AYPNPoWcxf6ljDRWdQfxkbBY3MUTW41SvMdlIL5RH91
         J4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZNy0WK2foLeyKhsG4P8Z5Ij5aElk6tOSripZr8euWn0=;
        b=FjKJ5c1WgLuidECOGVssrSuTjl2jJhZdZzyM9kMvcm01qbEHvMha8pdGiZ/pHhcUw8
         3l/qC2Xw++GUpa9+5OtpSyzZqob51i9GBgaKgjm0sMHIAmaKgWlNgaXCCzEihHmQSSP8
         RXTRG+m+OYvHAOg10GZDoyOLh/LBd+knxPS38V8faKkDRhV7IzKCt/Ga79iJbxc4vRzR
         0rVD4rp4+gL87URb2QQ23UQOO+WKO3vEyCAkS2/wkNSvJ9F0UJUzd9pTJy3O6pTqbxxP
         ji6/fTaIX4Wr+ag6DN+9iFASrK0hM6dthNA3h53B+nF5GIsYtUghb1mXnkfl5RyZmoBR
         MpdA==
X-Gm-Message-State: APjAAAUDD4p4XugmvsB7WzpG8JkoAqpqgEiDeJNJ70MI/TNukqunMyK9
        NDfCsdCPOrd2zUHqoJI5O/g=
X-Google-Smtp-Source: APXvYqymbtQYE0Pr6kTgciJ+XR1e3S8pP0uN6pcFhqcT65/4zdrPVrmGJWce8F6wkrldjdUOcolJUA==
X-Received: by 2002:a17:906:7e06:: with SMTP id e6mr9540139ejr.149.1569179114131;
        Sun, 22 Sep 2019 12:05:14 -0700 (PDT)
Received: from szeder.dev (x4dbd3787.dyn.telefonica.de. [77.189.55.135])
        by smtp.gmail.com with ESMTPSA id a3sm875942eje.90.2019.09.22.12.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 12:05:13 -0700 (PDT)
Date:   Sun, 22 Sep 2019 21:05:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190922190511.GB10866@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
 <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
 <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 21, 2019 at 02:37:18PM +0200, René Scharfe wrote:
> Am 21.09.19 um 11:57 schrieb SZEDER Gábor:
> > On Fri, Sep 20, 2019 at 08:14:07PM +0200, SZEDER Gábor wrote:
> >> On Fri, Sep 20, 2019 at 08:13:02PM +0200, SZEDER Gábor wrote:
> >>>> If the (re)introduced leak doesn't impact performance and memory
> >>>> usage too much then duplicating tip_name again in name_rev() or
> >>>> rather your new create_or_update_name() would likely make the
> >>>> lifetimes of those string buffers easier to manage.
> >>>
> >>> Yeah, the easiest would be when each 'struct rev_name' in the commit
> >>> slab would have its own 'tip_name' string, but that would result in
> >>> a lot of duplicated strings and increased memory usage.
> >>
> >> I didn't measure how much more memory would be used, though.
> >
> > So, I tried the patch below to give each 'struct rev_name' instance
> > its own copy of 'tip_name', and the memory usage of 'git name-rev
> > --all' usually increased.
> >
> > The increase depends on how many merges and how many refs there are
> > compared to the number of commits: the fewer merges and refs, the
> > higher the more the memory usage increased:
> >
> >   linux:         +4.8%
> >   gcc:           +7.2%
> >   gecko-dev:     +9.2%
> >   webkit:       +12.4%
> >   llvm-project: +19.0%
> 
> Is that the overall memory usage or just for struct rev_name instances
> and tip_name strings?

It's overall memory usage, the avarage of five runs of:

  /usr/bin/time --format='%M' ~/src/git/git name-rev --all

> And how much is that in absolute terms?  

git:     29801 ->  28514
linux:  317018 -> 332218
gcc:    106462 -> 114140
gecko:  315448 -> 344486
webkit:  55847 ->  62780
llvm:   112867 -> 134384

> (Perhaps
> it's worth it to get the memory ownership question off the table at
> least during the transformation to iterative processing.)

I looked into it only because I got curious, but other than that I
will definitely play the "beyond the scope of this patch series" card
:)

> > git.git is the exception with its unusually high number of merge
> > commits (about 25%), and the memory usage decresed by 4.4%.
> 
> Interesting.
> 
> I wonder why regular commits even need a struct name_rev.  Shouldn't
> only tips and roots need ones?  And perhaps merges and occasional
> regular "checkpoint" commits, to avoid too many duplicate traversals.

The 'struct rev_name' holds all info that's necessary to determine the
commit's name.  It seems to be much simpler to just attach one to each
commit and then retrieve it from the commit slab when printing the
name of the commit than to come up with an algorithm where only a
sleect set of commits get a 'struct rev_name', including how to access
those when naming a commit that doesn't have one.

> That's not exactly on-topic, though, and I didn't think all that
> deeply about it, but perhaps switching to a different marking
> strategy could get rid of recursion as a side-effect?  *waves hands
> vaguely*

I suppose a topo-order-based history walk should be able to name all
commits in a single traversal, and, consequently, be faster.  However,
'git rev-list --all --topo-order' doesn't seem to be that much faster
than 'git name-rev --all', so it might not be worth the effort.

> >  --- >8 ---
> >
> > diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> > index 6969af76c4..62ab78242b 100644
> > --- a/builtin/name-rev.c
> > +++ b/builtin/name-rev.c
> > @@ -88,6 +88,7 @@ static struct rev_name *create_or_update_name(struct commit *commit,
> >  		set_commit_rev_name(commit, name);
> >  		goto copy_data;
> >  	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
> > +		free((char*) name->tip_name);
> >  copy_data:
> >  		name->tip_name = tip_name;
> 
> I would have expected a xstrdup() call here.

But then we'd needed to release the results of all those xstrfmt()
calls at the callsites of create_or_update_name(), so instead of those
strdup() calls that you deem unnecessary we would need additional
free() calls.

> >  		name->taggerdate = taggerdate;
> > @@ -106,21 +107,19 @@ static void name_rev(struct commit *start_commit,
> >  {
> >  	struct commit_list *list = NULL;
> >  	const char *tip_name;
> > -	char *to_free = NULL;
> >
> >  	parse_commit(start_commit);
> >  	if (start_commit->date < cutoff)
> >  		return;
> >
> >  	if (deref) {
> > -		tip_name = to_free = xstrfmt("%s^0", start_tip_name);
> > -		free((char*) start_tip_name);
> > +		tip_name = xstrfmt("%s^0", start_tip_name);
> >  	} else
> > -		tip_name = start_tip_name;
> > +		tip_name = strdup(start_tip_name);
> 
> This would not be needed with the central xstrdup() call mentioned above.
> 
> >
> >  	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
> >  				   from_tag)) {
> > -		free(to_free);
> > +		free((char*) tip_name);
> >  		return;
> >  	}
> >
> > @@ -139,7 +138,6 @@ static void name_rev(struct commit *start_commit,
> >  			struct commit *parent = parents->item;
> >  			const char *new_name;
> >  			int generation, distance;
> > -			const char *new_name_to_free = NULL;
> >
> >  			parse_commit(parent);
> >  			if (parent->date < cutoff)
> > @@ -159,11 +157,10 @@ static void name_rev(struct commit *start_commit,
> >  					new_name = xstrfmt("%.*s^%d", (int)len,
> >  							   name->tip_name,
> >  							   parent_number);
> > -				new_name_to_free = new_name;
> >  				generation = 0;
> >  				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
> >  			} else {
> > -				new_name = name->tip_name;
> > +				new_name = strdup(name->tip_name);
> 
> ... and neither would this.
> 
> Sure the xstrfmt() result would be duplicated instead of being reused, but
> that doesn't increase memory usage overall.
> 
> >  				generation = name->generation + 1;
> >  				distance = name->distance + 1;
> >  			}
> > @@ -174,7 +171,7 @@ static void name_rev(struct commit *start_commit,
> >  				last_new_parent = commit_list_append(parent,
> >  						  last_new_parent);
> >  			else
> > -				free((char*) new_name_to_free);
> > +				free((char*) new_name);
> >  		}
> >
> >  		*last_new_parent = list;
> > @@ -313,7 +310,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
> >  		if (taggerdate == TIME_MAX)
> >  			taggerdate = commit->date;
> >  		path = name_ref_abbrev(path, can_abbreviate_output);
> > -		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
> > +		name_rev(commit, path, taggerdate, from_tag, deref);
> >  	}
> >  	return 0;
> >  }
> >
