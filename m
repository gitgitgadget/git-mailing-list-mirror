Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66821F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeKME7j (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:59:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43574 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKME7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 23:59:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id e4so8267001edv.10
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 11:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3AY6uY7xEogUiiXumKO1AhvnDhJ1Vt8GSJxBMX81wY=;
        b=hK/cQu0fhAIaIviG/NEpOyYqHQZK/hYO9pvo8aUTRKZuM37p2eI7tnmZ4elnkOa+lK
         ghQ/BYNXtjy6xxCCCD4ieTqzKhhnL5HNcHhSapIOwkZmCWwAWHRPcSyGeLhmNo1cMCso
         QxF9aKBkzaprX4YSQAZbFld3JUuQXUqYBvnU2E4FutkLQcQcmvDAGlHXLsEwdgEvDrwP
         O5w6wI8o4LIGO7ANJ55ZW5a+ki//mNILREGfnwy9zdM40PJ1L/B/QvnBCGn+cMHb8DHU
         vrutFrO2dMkoflKi8OxH+EkGzoe3RSXSIbM3aftS1+1ZEg7B2XaDQcBKWj4TSfFWyvhK
         JBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3AY6uY7xEogUiiXumKO1AhvnDhJ1Vt8GSJxBMX81wY=;
        b=WNA+OHPD26sDGweMiQDmcSpp36gJVo43vkxWTFIwRv7VuJjH2K5Wg2yct3zw/0knA1
         +PC4HyjNcyJT4B4GsfDOr6usS05ttuuLmSVwLMSScsI3QzFliqI0PzxXFiKOW7U7hV+D
         YVqhOCOrVL/i/NRkVTEYprKXRgn5DMTzNEPl6HsQ9hVAr/1YvvWuH9fAR8TQjvak3j0Z
         oYd3mPozp8sRsEIktV0i9FnhdjdCOy/3E0YkPBPx7wvL4ud0hyEMs83gzpvvUbxH690i
         g0J9Xgi386MuegEyWWlyNE8RnAqc40iopUOAjuuddp52eV0PzD6KBm5ZD1D1GkQieAF2
         tJ0Q==
X-Gm-Message-State: AGRZ1gKiPpFPw9PZMJgAPtB3UiZwOEM8f/rlXaZS7kAtbWQAiCVGhkmk
        Ip0vbrXSFkcDaLUMc6kSQIVFskg+Yrc/IHTnqS2W9Q==
X-Google-Smtp-Source: AJdET5czDGe9mSRUZvyIJi06mzhkTCtJj6M6qk5eAwqO7Q1OW6Z9IrZ+OOC8vayaaABDgSQLA2PrwMumn2Ohp+ALpWg=
X-Received: by 2002:a50:ba8b:: with SMTP id x11-v6mr5752758ede.191.1542049504295;
 Mon, 12 Nov 2018 11:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112145039.GF7400@sigill.intra.peff.net>
 <421d3b43-3425-72c9-218e-facd86e28267@gmail.com> <20181112160910.GA7612@sigill.intra.peff.net>
In-Reply-To: <20181112160910.GA7612@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Nov 2018 11:04:52 -0800
Message-ID: <CAGZ79kaH6WiSYeW2DCyZxYfg+qYuwTnF=2ZBO8rERJS_-8GeGw@mail.gmail.com>
Subject: Re: [PATCH 6/9] sha1-file: use an object_directory for the main
 object dir
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, gerardu@amazon.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, tikuta@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 8:09 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 12, 2018 at 10:48:36AM -0500, Derrick Stolee wrote:
>
> > > If the "the first one is the main store, the rest are alternates" bit is
> > > too subtle, we could mark each "struct object_directory" with a bit for
> > > "is_local".
> >
> > This is probably a good thing to do proactively. We have the equivalent in
> > the packed_git struct, but that's also because they get out of order. At the
> > moment, I can't think of a read-only action that needs to treat the local
> > object directory more carefully. The closest I know about is 'git
> > pack-objects --local', but that also writes a pack-file.
> >
> > I assume that when we write a pack-file to the "default location" we use
> > get_object_directory() instead of referring to the default object_directory?
>
> Generally, yes, though that should eventually be going away in favor of
> accessing it via a "struct repository". And after my series,
> get_object_directory() is just returning the_repository->objects->odb->path
> (i.e., using the "first one is main" rule).
>
> One thing that makes me nervous about a "local" flag in each struct is
> that it implies that it's the source of truth for where to write to. So
> what does git_object_directory() look like after that? Do we leave it
> with the "first one is main" rule? Or does it become:

s/git/get/ ;-)  get_object_directory is very old and was introduced in
e1b10391ea (Use git config file for committer name and email info,
2005-10-11) by Linus.

I would argue that we might want to get rid of that function now,
actually as it doesn't seem to add value to the code (assuming the
BUG never triggers), and using a_repo->objects->objectdir
or after this series a_repo->objects->odb->path; is just as short.

    $ git grep get_object_directory |wc -l
    30
    $ git grep -- "->objects->objectdir"  |wc -l
    10

Ah well, we're not there yet.

>   for (odb = the_repository->objects->odb; odb; odb = odb->next) {
>         if (odb->local)
>                 return odb->path;
>   }
>   return NULL; /* yikes? */
>
> ? That feels like it's making things more complicated, not less.

It depends if the caller cares about the local flag.

I'd think we can have more than one local, eventually?
Just think of the partial clone stuff that may have a local
set of promised stuff and another set of actual objects,
which may be stored in different local odbs.

If the caller cares about the distinction, they would need
to write out this loop as above themselves.
If they don't care, we could migrate them to not
use this function, so we can get rid of it?

> > > -   for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
> > > -           prepare_multi_pack_index_one(r, odb->path, 0);
> > > -           prepare_packed_git_one(r, odb->path, 0);
> > > +   for (odb = r->objects->odb; odb; odb = odb->next) {
> > > +           int local = (odb == r->objects->odb);
> >
> > Here seems to be a place where `odb->is_local` would help.
>
> Yes, though I don't mind this spot in particular, as the check is pretty
> straight-forward.
>
> I think an example that would benefit more is the check_and_freshen()
> stuff. There we have two almost-the-same wrappers, one of which operates
> on just the first element of the list, and the other of which operates
> on all of the elements after the first.
>
> It could become:
>
>   static int check_and_freshen_odb(struct object_directory *odb_list,
>                                    const struct object_id *oid,
>                                    int freshen,
>                                    int local)
>   {
>         struct object_directory *odb;
>
>         for (odb = odb_list; odb; odb = odb->next) {
>                 static struct strbuf path = STRBUF_INIT;
>
>                 if (odb->local != local)
>                         continue;
>
>                 odb_loose_path(odb, &path, oid->hash);
>                 return check_and_freshen_file(path.buf, freshen);
>         }
>   }
>
>   int check_and_freshen_local(const struct object_id *oid, int freshen)
>   {
>         return check_and_freshen_odb(the_repository->objects->odb, oid,
>                                      freshen, 1);
>   }
>
>   int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
>   {
>         return check_and_freshen_odb(the_repository->objects->odb, oid,
>                                      freshen, 0);
>   }
>

I am fine with (a maybe better documented) "first is local" rule, but
the code above looks intriguing, except a little wasteful
(we need two full loops in check_and_freshen, but ideally we
can do by just one loop).

What does the local flag mean anyway in a world where we
have many odbs in a repository, that are not distinguishable
except by their order? AFAICT it is actually to be used for differentiating
how much we care in fsck/cat-file/packing, as it may be borrowed
from an alternate, so maybe the flag is rather to be named
after ownership and not so much about it locality?
(I think "borrowed" or "owned" or even just "important"
or "external" or "alternate" may work)

Stefan
