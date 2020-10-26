Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F7C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8838207F7
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P78h+sLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgJZVS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:18:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40213 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbgJZVS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 17:18:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id f97so9345066otb.7
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGy80/MGsM6XIggDc0J/AXIUbuatTzbNVPzg6c86jfs=;
        b=P78h+sLZaoybHudBb/1UsEytGyk5rYbKcjL3I+j12DXo0PVt5aGSCyeotuL01YLnDc
         XjacSRLm2IQVAQKx3Q5+/2cY3C16zgQN6lyElwV7BPWOBMpFLT8UwD1y3ZeONkPdZE0Y
         HB7poP3Hp1Qo7QPegEONjGpTrXicF0KXZqSSkQ81ou0z0qAguYoXSv61Vp+V5USAwtUy
         zTLa1z3gUR3ndGI6oAtdeX/W/Sh2re/cHD8YJeCPINEIH1orRbtA/ZRaqv9OD5CFKi62
         hhMXOnQktVJ1YJjqEyqc0FRy/4UCtOnJQxW9JD55FTC4hpYlkU/kZgGYCNVba6KQYtne
         +AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGy80/MGsM6XIggDc0J/AXIUbuatTzbNVPzg6c86jfs=;
        b=ZHY7Ku6KGMEFsJErdWE66LCeYKI54v8DK+1+H43zoaiaJgG3NpQEror0A/XRlWrUkN
         Qz60Ux1YWNFxCSuIfkRXv6Hu81Rw15xrfY3xZXfKcvuHnegWG5gOVuN8sDsKdVqzoi/h
         83FCzi/Udwe1ZY+In/DCLLVLDCXvNqHf7MswW5UpSP3WHtpU9ABm+GsaH59tQaPtAGAr
         5JHdtFSUgJgq7gnDLLVaYVI9YNAHty5Zx+EPX0UV9FN9Tk5ME8LJqQPNcZKCIWVniLsm
         1yNXLvJApXdviA4y0kJHYlLRgQvO1HBIWoI8CuDsRPirNQ4UMkbMBa5s6sbtX6caIfsJ
         ln1Q==
X-Gm-Message-State: AOAM532epRg3mkLRdjZHVUoQaGh2IKEiwzM27E5V/VydFy3mPamek9qw
        +1NaPNqo3BYGrz/Uj8xhCrS8tdabpg0XIywIrag=
X-Google-Smtp-Source: ABdhPJw16OOktgtayeGrgwyKEuRvybJO4h2Savro6bj9p+hM7qLwtx3xzKwdS0WjNSD8zRPadhKB34KZseKidDzbKjI=
X-Received: by 2002:a05:6830:2389:: with SMTP id l9mr16733825ots.316.1603747137782;
 Mon, 26 Oct 2020 14:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
 <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com> <b9e73975eab1f349be678779ff57155feb4c3501.1603731448.git.gitgitgadget@gmail.com>
 <xmqqa6w8emxn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6w8emxn.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Oct 2020 14:18:46 -0700
Message-ID: <CABPp-BFtzeOHS=ptgzkrpOL3gwvE6bSaRgxLO1QJ284J08i-mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] merge-ort: barebones API of new merge strategy
 with empty implementation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 1:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > + *   git merge [-s recursive]
> > + *
> > + * with
> > + *
> > + *   git merge -s ort
> > + *
> > + * Note: git's parser allows the space between '-s' and its argument to be
> > + * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
> > + * "cale", "peedy", or "ins" instead of "ort"?)
>
> One thing that is quite unpleasant is "git grep ort" gives us too
> many hits already, and it will be hard to locate ort related changes
> with "git log --grep=ort", as the name is too short to serve as an
> effective way to limit the search.

Suggestions for an alternative name?  merge-pandemic.c since it was
mostly written during the pandemic?

I'm really not good at naming things...

> > diff --git a/merge-ort.h b/merge-ort.h
> > new file mode 100644
> > index 0000000000..47d30cf538
> > --- /dev/null
> > +++ b/merge-ort.h
> > @@ -0,0 +1,49 @@
> > +#ifndef MERGE_ORT_H
> > +#define MERGE_ORT_H
> > +
> > +#include "merge-recursive.h"
> > +
> > +struct commit;
> > +struct tree;
> > +
> > +struct merge_result {
> > +     /* whether the merge is clean */
> > +     int clean;
> > +
> > +     /* Result of merge.  If !clean, represents what would go in worktree */
> > +     struct tree *tree;
>
> Curious.  Because there is no way for "struct tree" to hold an
> in-core pointer to a "struct blob" (iow, for a blob to be in a
> "struct tree", it has to have been assigned an object name), unless
> we are using the "pretend" mechanism, which has its own downsides,
> we are committed to create a throw-away blob objects with conflict
> markers in them, and write them to the object store.

This is something merge-recursive already does (and I've copied some
of that code over, around merge_3way() and the call to
write_object_file() with the results).  I thought the reasoning behind
this was memory -- we're okay assuming any given file fits in memory
(and perhaps up to three copies of it so we can do a three-way merge),
but we're not okay assuming all (changed) files from a commit
simultaneously fit in memory.

> If we were writing a new merge machinery from scratch, I would have
> preferred a truly in-core implementation that does not have to write
> out to the object store but if this makes the implementation simpler,
> perhaps it is a small enough price to pay.

I thought about that early on, but I was worried about out-of-memory
situations if we attempt to do truly in-memory, at least for large
changes in large repositories.

And as you have seen above, I do rely on being able to create trees.

> > +     /*
> > +      * Additional metadata used by merge_switch_to_result() or future calls
> > +      * to merge_inmemory_*().  Not for external use.
> > +      */
> > +     void *priv;
> > +     unsigned ate;
>
> I'd prefer to see this named not so cute.  Will we hang random
> variations of things, or would this be better to be made into a
> pointer to union, with an enum that tells us which kind it is in
> use?

I don't understand the union suggestion.  Both fields are used.

Would you object if 'ate' was named '_'?  That was my original name,
but Taylor didn't like it.  It is used on about 4 lines of code, I'm
99.9% sure it will never be used in additional locations, and callers
shouldn't mess with it.  I just don't have a good name for it.  I
guess maybe I should just call it "properly_initialized" or something.

> > +};
>
>
> > +/* rename-detecting three-way merge with recursive ancestor consolidation. */
> > +void merge_inmemory_recursive(struct merge_options *opt,
> > +                           struct commit_list *merge_bases,
> > +                           struct commit *side1,
> > +                           struct commit *side2,
> > +                           struct merge_result *result);
>
> I've seen "incore" spelled as a squashed-into-a-single-word, but not
> "in_memory".

I can add an underscore.  Or switch to incore.  Preference?

> > +/* rename-detecting three-way merge, no recursion. */
> > +void merge_inmemory_nonrecursive(struct merge_options *opt,
> > +                              struct tree *merge_base,
> > +                              struct tree *side1,
> > +                              struct tree *side2,
> > +                              struct merge_result *result);
> > +
> > +/* Update the working tree and index from head to result after inmemory merge */
> > +void merge_switch_to_result(struct merge_options *opt,
> > +                         struct tree *head,
> > +                         struct merge_result *result,
> > +                         int update_worktree_and_index,
> > +                         int display_update_msgs);
>
> To those who have known how our merge works, a natural expectation
> for an "in-core" merge is that when the "in-core" merge finishes,
> the index would hold the higher stages for the conflicted paths, and
> cleanly merged paths would have the result at stage 0, and there is
> an extra thing that we haven't had that represents what the working
> tree files for conflicted paths should look like (historically we
> wrote out the conflicted result to the working tree files---being
> in-core operation we cannot afford to), so that (1) cleanly merged
> paths can be externalized by writing from their stage 0 entries and
> (2) contents with conflicts can be externalized by that "extra
> thing".
>
> But this helper says "working tree and index" are both updated, so
> the "in-core" merge it expects must have not just the working tree
> result (in result->tree, as the comment in the structure says) but
> also how the higher stages of the index should look like somewhere
> in the result structure.  How the latter is done is not at all clear
> at this point in the mock-up.  Leaving it opaque is fine, but the
> function, and the result structure, deserve clarification to avoid
> confusing readers by highlighting how it is different from the
> traditional ways (e.g. "we don't touch the index at all---instead we
> store that in the priv/ate fields", if that is what is going on).

Yes, your reading is correct.  We don't touch the index (or any index,
or any cache_entry) at all.  Among other things, data that can be used
to update the index are in the "priv" field.

I'll try to add some notes to the file.
