Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75F020286
	for <e@80x24.org>; Thu,  7 Sep 2017 20:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756043AbdIGUiu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 16:38:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35511 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755747AbdIGUit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 16:38:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so444298wmi.2
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hhaKphv8j2rkmC7s5Rha5IrG9+OaTtg78S88qtqBPso=;
        b=AZWe07eu86VSge1nZp/YGSHfMQPAciBszkyohsa3JSeUxU+EP8phiJxsEiMni4mBuE
         I3ls6HDtJpGL4zpbNF+57hdumVm9HdNonL4GV9T8HgHGXpFGT/mjs0Pd3Xewpzni3WrY
         S+6ryaKOl9yJDmLPDpfg6xKW5eh4JfE3FX8Dr4ymbIOBKfVYwAeTm6B6EhETuiMg27Cc
         dw9DMoEPqMTR+ywnvu7S+IWmidCipjFYBbr4ZbHg4dDA733adeP+DX1p+M+a3bpq0w5u
         XSiWHEh5lpN7OpTNbNQ5GsmPO7UNBlM27Pks/znzfqPxHD5cila85vd4Tk5GRp/NkKid
         +PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hhaKphv8j2rkmC7s5Rha5IrG9+OaTtg78S88qtqBPso=;
        b=MtLzUWlLMeVTRAr5PYTJalm7MYVsQVE4WFE1NrVghjYCr9FPA2R8/f034CyvJTJmzh
         Vq+5mtCKnISKGMc9eTVqYpd/OcFz5qAZ43xR5sFBDCwzSi2ndWXrbFsZDiBFPz68u6Hu
         vrNc8Wk48U1Q6FkeM8aILAJ10tzPCb+UtrrlswN4CHX1sid1Rs5EyLS4H5truzyJQluB
         uI7PrFJRGW/PTY20vYImoErtJAPQQf69jKKFCzNc4xS7lMeytHYQsKTO92oBwiviDmNq
         Vk0vhbDxjZmt1L3aH2m3u5nDhf+Wpa50bixg2IWfJC5VN19FHI1atodAN6qAghZ5uHlK
         JxxA==
X-Gm-Message-State: AHPjjUjadln+BmqdjrqpXJEpsdAF7nvVl2F2DktRIPJUqla78nEpmP4C
        8jH7ZTRA9IKDR46+XeZ2+eM=
X-Google-Smtp-Source: AOwi7QDRh61Mj5lHnPq2QtocPIwu8YVrU6x/g4lc9xaNm4/R/sAmHMtayZLxJjTDQFXEUdeBq04K3A==
X-Received: by 10.28.236.194 with SMTP id h63mr101200wmi.159.1504816727795;
        Thu, 07 Sep 2017 13:38:47 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id z51sm382193wrb.22.2017.09.07.13.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Sep 2017 13:38:46 -0700 (PDT)
Date:   Thu, 7 Sep 2017 21:39:14 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] refs: make sure we never pass NULL to hashcpy
Message-ID: <20170907203914.GA26081@hank>
References: <20170904200504.15249-1-t.gummerer@gmail.com>
 <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
 <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07, Michael Haggerty wrote:
> On Wed, Sep 6, 2017 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >
> >> gcc on arch linux (version 7.1.1) warns that a NULL argument is passed
> >> as the second parameter of memcpy.
> >> [...]
> >
> > It is hugely annoying to see a halfway-intelligent compiler forces
> > you to add such pointless asserts.
> >
> > The only way the compiler could error on this is by inferring the
> > fact that new_sha1/old_sha1 could be NULL by looking at the callsite
> > in ref_transaction_update() where these are used as conditionals to
> > set HAVE_NEW/HAVE_OLD that are passed.  Even if the compiler were
> > doing the whole-program analysis, the other two callsites of the
> > function pass the address of oid.hash[] in an oid structure so it
> > should know these won't be NULL.
> >
> > [...]
> >
> > I wonder if REF_HAVE_NEW/REF_HAVE_OLD are really needed in these
> > codepaths, though.  Perhaps we can instead declare !!new_sha1 means
> > we have the new side and rewrite the above part to
> >
> >         if (new_sha1)
> >                 hashcpy(update->new_oid.hash, new_sha1);
> >
> > without an extra and totally pointless assert()?
> 
> The ultimate reason for those flags is that `struct ref_update` embeds
> `new_oid` and `old_oid` directly in the struct, so there is no way to
> set it to "NULL". (The `is_null_sha1` value is used for a different
> purpose.) So those flags keep track of whether the corresponding value
> is specified or absent.
> 
> Four of the five callers of `ref_transaction_add_update()` are
> constructing a new `ref_update` from an old one. They currently don't
> have to look into `flags`; they just pass it on (possibly changing a
> bit or two). Implementing your proposal would oblige those callers to
> change from something like

Thanks for the explanation!

> > new_update = ref_transaction_add_update(
> >         transaction, "HEAD",
> >         update->flags | REF_LOG_ONLY | REF_NODEREF,
> >         update->new_oid.hash, update->old_oid.hash,
> >         update->msg);
> 
> to
> 
> > new_update = ref_transaction_add_update(
> >         transaction, "HEAD",
> >         update->flags | REF_LOG_ONLY | REF_NODEREF,
> >         (update->flags & REF_HAVE_NEW) ? update->new_oid.hash : NULL,
> >         (update->flags & REF_HAVE_OLD) ? update->old_oid.hash : NULL,
> >         update->msg);
> 
> It's not the end of the world, but it's annoying.
> `ref_transaction_add_update()` was meant to be a low-level,
> low-overhead way of allocating a `struct ref_update` and add it to a
> transaction.
> 
> Another solution (also annoying, but maybe a tad less so) would be to
> change the one iffy caller, `ref_transaction_update()`, to pass in a
> pointer to the null OID for `new_sha1` and `old_sha1` when the
> corresponding flags are turned off. That value would never be looked
> at, but it would hopefully reassure gcc.
> 
> I did just realize one thing: `ref_transaction_update()` takes `flags`
> as an argument and alters it using
> 
> >         flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
> 
> Perhaps gcc is *more* intelligent than we give it credit for, and is
> actually worried that the `flags` argument passed in by the caller
> might *already* have one of these bits set. In that case
> `ref_transaction_add_update()` would indeed be called incorrectly.
> Does the warning go away if you change that line to
> 
> >         if (new_sha1)
> >                 flags |=REF_HAVE_NEW;
> >         else
> >                 flags &= ~REF_HAVE_NEW;
> >         if (old_sha1)
> >                 flags |=REF_HAVE_OLD;
> >         else
> >                 flags &= ~REF_HAVE_OLD;
> 
> ?

Indeed that fixes it, great catch!  gcc is indeed smarter than we gave
it credit for, this makes a lot of sense.

Interestingly stripping away the flags fixes the compiler warning:

diff --git a/refs.c b/refs.c
index ba22f4acef..2e6871beac 100644
--- a/refs.c
+++ b/refs.c
@@ -921,6 +921,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
                return -1;
        }
 
+       flags &= ~REF_HAVE_NEW;
+       flags &= ~REF_HAVE_OLD;
+
        flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
 
        ref_transaction_add_update(transaction, refname, flags,

while checking that the flags are not there in the first place still
leaves the compiler warning (whether I use "die()" or just "return -1"
doesn't matter in this case):

diff --git a/refs.c b/refs.c
index ba22f4acef..62ff283755 100644
--- a/refs.c
+++ b/refs.c
@@ -921,6 +921,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
                return -1;
        }
 
+       if ((flags & REF_HAVE_NEW) != 0 || (flags & REF_HAVE_OLD) != 0)
+               die("BUG: passed invalid flag to ref_transaction_update");
+
        flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
 
        ref_transaction_add_update(transaction, refname, flags,


> This might be a nice change to have anyway, to isolate
> `ref_transaction_update()` from mistakes by its callers. For that
> matter, one might want to be even more selective about what bits are
> allowed in the `flags` argument to `ref_transaction_update()`'s
> callers:
> 
> >         flags &= REF_ALLOWED_FLAGS; /* value would need to be determined */

Interesting idea, would we just strip out the flags in this case, or
should we check that the flags are not there in the first place and
error out if they are?

I guess with the second option we would make sure that every caller
cleans up the flags before calling the function in the first place,
but also have a small risk of missing something if we don't test a
particular codepath.  I stripping out the flags might actually fix the
compiler warning as well, so that might be the better option here.
I'm happy to try and patch this based on the suggestion above, but
most likely it won't happen before next week, as I'm traveling over
the weekend :)

> Michael
