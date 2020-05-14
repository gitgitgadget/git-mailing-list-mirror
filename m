Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E6C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ABF2065D
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U71fuplV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgENXV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 19:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENXV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 19:21:26 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A90AC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 16:21:26 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x7so629621oic.3
        for <git@vger.kernel.org>; Thu, 14 May 2020 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7nTqg5DMNCxZN4l8NEPxvmF6wpicu7FeUDEQvHSl2Y=;
        b=U71fuplVlTPuZecVn9gP318CTRxD7GZxhgbItgY3ShyLZyr55PfqO/9buiQIPzB4Gb
         Zb4vDwcEC5nAM1steX+gFnh+T7+8QEAMm8ZxZ4RpvoRQeMmA5EgqdHo3R2ZNXQpRMvbl
         kSIqWFGiAUKGQoKTYZN+HfE0wfoeChkDEpBG9y89mYt1gDJXPHO/D8AsN6HJBTP7fqiQ
         5WCL4EqGBvDTL1jS0Vh4N8dwXJ1rDGP4fbdKQ0UYibDykZ/GgdA1JXnNDn4SBDMmfkb+
         oxvPFiPgNyYj+gAHzUcB65Op0w//c6Vi4nmJWDe34S/g+iVnzoPO+Etgd05V/6rMP4X/
         MbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7nTqg5DMNCxZN4l8NEPxvmF6wpicu7FeUDEQvHSl2Y=;
        b=WSZLEc/YaCfriLoMnKmJaCCqBgzMcUvaR3xjMZrH+5K93nBoXtHBY+nloQCnyZoO1K
         EmPoZN1cTTYOjTf4hdlYI1oW+VAZRUaU1HK7vE5ICOjefleXuZeMS1XUCsbijDD9pCnT
         WruwFLxyH/CRGNo/oTYJYflQ131h4I2i/kY+quuKRw8cFDpCODR/MtJUF7OW+XTYDdcO
         8nwM/vf5i4/E1dH1TSl+e9ju12JTTnrOHg9C7Tzbko5PHEvIsV/QwpSi7njnjiAId1Q+
         OgFNVjO7JYHN5TaIcUmESfh4riw5xEPpTP9sBKyjN77RIOUVkJA60g9zWNvoVGOrXBeD
         L6hQ==
X-Gm-Message-State: AOAM533qaOq+c31zNT8/TLsmaLe5P3Jyb3rPM9+TsIwnxbJGtcmspYH5
        SYD9Qod5UXvGi9YoFaYJs78U1Ht/uCBhP9ubwdU=
X-Google-Smtp-Source: ABdhPJzX8KXdJJ9WStPyYDAg2Ve0RLT+AH1h4PN8VkAkocDAjWzcO5r3NlrmbcjyYirROJYffoUGvE/IhF7o4IP229s=
X-Received: by 2002:aca:fdd5:: with SMTP id b204mr237161oii.167.1589498485716;
 Thu, 14 May 2020 16:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.785.git.git.1589486002453.gitgitgadget@gmail.com>
 <xmqq4ksiqnbf.fsf@gitster.c.googlers.com> <CABPp-BHM8uS1yxAtjE=Frh_V7JF7-EJ8+47e-cr9TpEMZr4nfw@mail.gmail.com>
 <xmqqimgyp3ft.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimgyp3ft.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 May 2020 16:21:14 -0700
Message-ID: <CABPp-BFAR=+CxwcZz1v4n3Z53uEas5P6Y7pUT7u9dAL0hULe3w@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: also allow get_progress() to work on a
 different index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 3:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> Do we see these CE_UPDATE|CE_WT_REMOVE bits attached to the cache
> >> entries in the o->src_index array when get_progress() is fed the
> >> src_index in the first place?
> >
> > Yes, before calling check_updates(o, o->src_index), update_sparsity()
> > loops over o->src_index and calls apply_sparse_checkout() on each of
> > the non-conflicted cache entries.  apply_sparse_checkout() will set
> > either CE_UPDATE or CE_WT_REMOVE whenever items flip from or to having
> > the SKIP_WORKTREE bit set.
>
> Hmph.
>
> I thought that the whole point of splitting o->result from
> o->src_index we did long time ago was to allow us to treat
> o->src_index constant.  I hope we haven't broken anything by
> starting to do things like that X-<.

I think we're safe there.  No function started modifying o->src_index
directly; they just modify the index they are passed in.  The only
place that passes o->src_index to functions for modification is
update_sparsity(), which unpack_trees() never calls.  In fact,
update_sparsity() was split out from unpack_trees().  But perhaps I
can address your concerns a bit better with the history and from a
high level instead of the low level details...

commit 34110cd4e394e3f92c01a4709689b384c34645d8
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 6 18:12:28 2008 -0800

    Make 'unpack_trees()' have a separate source and destination index
...
    This ends up removing a fair number more lines than it adds, for the
    simple reason that we can now skip all the crud that tried to be
    oh-so-careful about maintaining our position in the index as we were
    traversing and modifying it.  Since we don't actually modify the source
    index any more, we can just update the 'o->pos' pointer without worrying
    about whether an index entry got removed or replaced or added to.


unpack_trees() has to do lots of work, including worrying about adding
and removing many cache entries.  Not having to worry about the
position pointer as you're traversing the index makes sense.
update_sparsity(), on the other hand, knows going in that no cache
entries will be added or removed; it will at most toggle some flags on
existing cache entries.  The same concerns thus just aren't relevant.
While we could make it use o->result instead of o->src_index, it would
imply cloning all the index entries before toggling some flags on the
existing entries, which seems like a waste of effort.  (In fact,
update_sparsity() never even initializes o->result, unlike
unpack_trees(), so any attempts to access it are undefined behavior.)

I agree we don't want the two mixed up, but isn't that achieved by the
fact that update_sparsity() was split out of unpack_trees() instead of
making update_sparsity() some kind of extra mode flag passed to
unpack_trees() (and which would have complicated unpack_trees() even
further)?

One thing that could possibly be improved is using o->dst_index
instead of o->src_index to make things slightly clearer, although it
wouldn't actually change things because of this sanity check from the
beginning of update_sparsity():

if (o->src_index != o->dst_index || o->fn)
        BUG("update_sparsity() called wrong");


Do any of those comments help?  Are there still other changes you'd
like to see (separate from this patch)?

> Anyway, if that is the case, this change won't make things any
> worse.  Let's queue it.

Thanks.
