Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536A52035B
	for <e@80x24.org>; Tue, 11 Jul 2017 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755690AbdGKSB0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:01:26 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34276 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754057AbdGKSBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:01:25 -0400
Received: by mail-pg0-f47.google.com with SMTP id t186so3374730pgb.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJ31U0t1ICYg7xDQnVP7Yu1HkZy2UJgYtD3WCjgen2k=;
        b=uE10c3UWNm3um5zWkyAXz55P0+6kFcsoEznrTfsYtxn1Rgw2KjMMNJWNZPhAuAyyGj
         Bczunp5VqNGD3f43MjJ5JFiaWDHlS3GyOeI1K/LlyKwxbOX2LaPxggh7RGglfHDRrepF
         l9jO3PYqXHcVrzeK3714JJuJah+6L4iEZnn21XM5cEFaN/kuDXQ8XDTjCh4T7/WuJOOH
         ncfgigI+fuqzWGsZoKJTyJwP4h2r8yY6d3aXG7Qd9zhodsWRU7dKUfDYnBTmD5mnS3on
         rp8XDrwB3aK0pV5NiMzd1MC6GW28BsA7TBFjvFNVokRbfAH9fTTfhKcCbHLAZwKP7HZ7
         tq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJ31U0t1ICYg7xDQnVP7Yu1HkZy2UJgYtD3WCjgen2k=;
        b=lGjSDq0tLc5q23nIMTDk4N1uYhdRXSldn1aATe/cpOvVRlMMtv2rY1ydl6rvSMJw0N
         R1Gmugw2OA8LrRFcEA3xrDXFmAlimvoT8h1etE6s6oQTCoCeaU6iJLokqVKNQq1GAAmQ
         RidfDEjSrHF5DIm7UVn6HA4+zElKvUpyk2dEO8me+llM8qDfAQtZQyynpqTtLjIMsxk/
         hzQ6p84m+pxEvXZjMQcSrMxDx3071Le9SzIkr7YjzqAEccnqDXiA0nFbaipLfOOlzkfg
         LgQHszbL710Ei+CV2mEurJIU2rZWaAbfljRWaBE/GfgedOC8t3/bMvYf00S9CloOYTEF
         nWHA==
X-Gm-Message-State: AIVw111Z1TbRsbEVRWy3yMvl/zt9FBG9Kyff9WFh/5x8JlEzs3YVmCqg
        SKKWFxxnHkbFzspu
X-Received: by 10.98.87.29 with SMTP id l29mr51769819pfb.3.1499796084914;
        Tue, 11 Jul 2017 11:01:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3402:2400:d1c0:8987])
        by smtp.gmail.com with ESMTPSA id y205sm838710pfb.124.2017.07.11.11.01.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 11:01:23 -0700 (PDT)
Date:   Tue, 11 Jul 2017 11:01:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH] object store classification
Message-ID: <20170711180122.GG161700@google.com>
References: <20170706202739.6056-1-sbeller@google.com>
 <xmqq7ezldlhe.fsf@gitster.mtv.corp.google.com>
 <c9a6f3f0-e338-a200-6b57-48b5d926d31c@gmail.com>
 <xmqq4luochtv.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbTzZLD5FDidDG8SUrKpgRGvA7f9HAu77w+iW8A8zLMAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbTzZLD5FDidDG8SUrKpgRGvA7f9HAu77w+iW8A8zLMAw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10, Stefan Beller wrote:
> On Fri, Jul 7, 2017 at 9:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Ben Peart <peartben@gmail.com> writes:
> >
> >> For more API/state design purity, I wonder if there should be an
> >> object_store structure that is passed to each of the object store APIs
> >> instead of passing the repository object. The repository object could
> >> then contain an instance of the object_store structure.
> >>
> >> That said, I haven't take a close look at all the code in object.c to
> >> see if all the data needed can be cleanly abstracted into an
> >> object_store structure.
> >
> > My gut feeling was it is just the large hashtable that keeps track of
> > objects we have seen, but the object replacement/grafts and other
> > things may also want to become per-repository.
> 
> This is similar to the_index which is referenced by the_repository.
> But as we do not have anything like the_object_store already, we are
> free to design it, as the required work that needs to be put in is the
> same.
> 
> With the object replacements/grafts coming up as well as alternates,
> we definitely want that to be per repository, the question is if we rather
> want
> 
>   the_repository -> many object_stores (one for each, alternate, grafts,
>       and the usual place at $GIT_DIR/objects
>   where the object_store is a hashmap, maybe an additional describing
>   string or path.
> 
> or
> 
>   the_repository -> the_object_store
>   but the object store is a complex beast having different hash tables
>   for the different alternates.

After looking at the patch and some of the comments here I think that
this is probably the best approach with a few tweaks (which may be
completely unfounded because I'm not familiar with all the object store
code).

In an OO world I would envision a single object (let's say 'struct
object_store') which is responsible for managing a repository's objects
no matter where the individual objects came from (main object store or
an alternate for that repository).  And if I understand correctly the
single hash table that exists now caches objects like this.

I also think that such a 'struct object_store' should probably be an
opaque type to a majority of the code base.  This means that it probably
shouldn't have its definition in 'repository.h'.

As far as API, I think it should be similar to the new repo_config (old
one too, though it was implicit) API in that the code base doesn't need
to know about 'struct configset', it just passes a pointer to the
repository and then the 'struct configset' which is stored in the
repository is operated on under the hood.  This way the code base would
just query for an object using the repository as a handle like:

  get_object(repo, OID);

  and not:

  get_object(repo->object_store, OID);

Of course under the hood it would be preferable to have the functions
operate on the object_store struct explicitly.

> 
> or
> 
>   the_repository -> the_object_store_hash_map
>   which is this patch that would try to put any object related to this
>   repository into the same hashmap and the hashmap is not special
>   for each of the different object locations.
> 
> 
> >
> >> One concern I have is that the global state refactoring effort will
> >> just result in all the global state getting moved into a single
> >> (global) repository object thus limiting it's usefulness.

I think we do need to think about this, but it shouldn't be too much of
a concern right now.  The first step is to get enough of the object
store object oriented such that you can have two object stores
corresponding to two different repositories working in parallel.

> >
> > I actually am not worried about it that much, and I say this with
> > the background of having done the same "grouping a set of global
> > state variables into a single structure and turning them into a
> > single default instance" for the_index.  Whether you like it or not,
> > the majority of operations do work on the default instance---that
> > was why the operations could live with just "a set of global state
> > variables" in the first place, and the convenience compatibility
> > macros that allow you to operate on the fields of the default
> > instance as if they were separate variables have been a huge
> > typesaver that also reduces the cognitive burden.  I'd expect that
> > the same will hold for the new "repository" and the "object_store"
> > abstractions.
> 
> Sounds reasonable to expect.
> 
> Thanks,
> Stefan

-- 
Brandon Williams
