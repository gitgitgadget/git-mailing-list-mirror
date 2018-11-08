Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184B61F453
	for <e@80x24.org>; Thu,  8 Nov 2018 00:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeKHKU4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 05:20:56 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40918 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeKHKUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 05:20:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id u130-v6so15525446oie.7
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 16:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFzXCH52HV7OmYhf81EGdABKar5vZtRch+kmzYDyToM=;
        b=uRaGmO9pYFksHs3bBep1sOItq+nYW9vNuFZ0fc/ICgHRqR4eKfFhrAgoZfIincbP00
         /y2wE7bB8VcgkaYOurheRkJrsxXyKaMFZ5WY1ziDz5aqMWmSfrH9DNuZDMs8Bi54hlB3
         NlodEhk2chbnVBCycWLeJz4sTN9CREQdWu0DyC7bQ50mFOyxs28Hb32qBCbmgqqzEfvk
         LptYFehaT1byuRRAJulD0DFkbHrPkEJ3C0idep7KKacqyXerl9Yl5bUemnrson9LIHQJ
         togVeAXAAKMY2VGMd4OKXj0lP801Ns9qYvEWZqCoE1NSsNYk8fMInmxrXyhXow/j0w+0
         DSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFzXCH52HV7OmYhf81EGdABKar5vZtRch+kmzYDyToM=;
        b=Ds+/w1WcJLKBkVFrcRFSdZAX6W6s7UEz0I1jSS40GVVEl5uWVmFhObXBFe9xIGksHK
         FITnRlA52tZKuFtQtaLwgWQmCtCAl7xdl4TIGZHafufuQB4Vpz2vVqVUtc05CIfaJVHt
         tbL4HEySaUVPp0tZ2eIGfojFQ2Be+H044JbAS0Jhb/TQ2X3tU77ye8gIZ46rTm1IAczp
         n0NX/1UJhQ318ycXLnPgnyKAC2F6QhhhEMUaymm6+WDvjCd16Hu1HvjfM1L6AT69MqAb
         i4IcrQzPO2PQNtixXtdBAn5QY1cub30XpFlCvZhxtK6Yw8Uumv0GkqbfUVH00daWPFtO
         tj8Q==
X-Gm-Message-State: AGRZ1gLh1G71kyUla4bE0rcUCcd/cLozOnQF5XiPq/v+354+zYERC9Nb
        fBa6rm59YRac5yKmKIuTJTlc9A7r5/SldxI9coCz
X-Google-Smtp-Source: AJdET5eZ8MCQAVomqBPaqja5l0++bOuPDKygqe7i4YlZyBLjAgu4Uk9csAdN6S3xN4lOylL58ZYgfwlNaJyUNdZ4SVQ=
X-Received: by 2002:aca:6a4e:: with SMTP id f75-v6mr1535086oic.260.1541638080232;
 Wed, 07 Nov 2018 16:48:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1539298957.git.matvore@google.com> <e340f743e6749e65525e1342dc47faaa6540f04b.1539298957.git.matvore@google.com>
 <xmqqlg706iv1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg706iv1.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 7 Nov 2018 16:47:47 -0800
Message-ID: <CAMfpvhK7FX717Cpnce4puytLFbd4G56qnhwgy5WG7vm3C31DiA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] list-objects-filter: teach tree:# how to handle >0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A quick update: I've read Junio's comments on this patchset and
basically agree with them, but I haven't had a chance to apply them
yet. I plan to pick this patchset up again (as well as the patch
"md/list-lazy-objects-fix") once things settle down in my day job.
On Sun, Oct 14, 2018 at 7:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > The long-term goal at the end of this is to allow a partial clone to
> > eagerly fetch an entire directory of files by fetching a tree and
> > specifying <depth>=1. This, for instance, would make a build operation
> > fast and convenient
>
> This would reduce round-trip, as you do not have to fetch the tree
> to see what its contents are before issuing another set of fetches
> for them.  Those who are building virtual filesystem that let you
> mount a specific tree object, perhaps via fuse, may find it useful,
> too, even though I suspect that may not be your primary focus.
>
> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> > index c2c1c40e6..c78985c41 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -734,8 +734,12 @@ specification contained in <path>.
> >  +
> >  The form '--filter=tree:<depth>' omits all blobs and trees whose depth
> >  from the root tree is >= <depth> (minimum depth if an object is located
> > -at multiple depths in the commits traversed). Currently, only <depth>=0
> > -is supported, which omits all blobs and trees.
> > +at multiple depths in the commits traversed). <depth>=0 will not include
> > +any trees or blobs unless included explicitly in <object>. <depth>=1
>
> Here, <object> refers to the objects directly requested on the
> command line (or --stdin)?  Triggering this question from me is a
> sign that this description may want to say a bit more to avoid the
> same question from the real readers.  Perhaps replace "included
> explicitly in <object>" with "explicitly requested by listing them
> on the command line or feeding them with `--stdin`", or something
> like that?
>
> > diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> > index e8da2e858..9dc61d6e6 100644
> > --- a/list-objects-filter-options.c
> > +++ b/list-objects-filter-options.c
> > @@ -50,12 +50,12 @@ static int gently_parse_list_objects_filter(
> >               }
> >
> >       } else if (skip_prefix(arg, "tree:", &v0)) {
> > -             unsigned long depth;
> > -             if (!git_parse_ulong(v0, &depth) || depth != 0) {
> > +             if (!git_parse_ulong(v0,
> > +                                  &filter_options->tree_depth_limit_value)) {
> >                       if (errbuf) {
> >                               strbuf_addstr(
> >                                       errbuf,
> > -                                     _("only 'tree:0' is supported"));
> > +                                     _("expected 'tree:<int>'"));
>
> We do not accept "tree:-1", even though "-1" is an int.  Is it too
> obvious to worry about?  I do not think we want to say tree:<uint>
> even if we do want to make it clear we reject "tree:-1"
>
> I am wondering if "expected 'tree:<depth>'" would work better.
>
> > diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> > index af64e5c66..c1ae70cd8 100644
> > --- a/list-objects-filter-options.h
> > +++ b/list-objects-filter-options.h
> > @@ -44,6 +44,7 @@ struct list_objects_filter_options {
> >       struct object_id *sparse_oid_value;
> >       char *sparse_path_value;
> >       unsigned long blob_limit_value;
> > +     unsigned long tree_depth_limit_value;
> >  };
>
> This change gets it right by adding "depth" in the field name and it
> is not a comment on this patch, but someday not in too distant
> future we should rename the "blob_limit_value" to make it clear that
> it is filtering by number of bytes, as other filtering criteria on
> blobs that can be expressed in ulong are quite possible.
>
> > -static enum list_objects_filter_result filter_trees_none(
> > +static enum list_objects_filter_result filter_trees_depth(
> >       enum list_objects_filter_situation filter_situation,
> >       struct object *obj,
> >       const char *pathname,
> >       const char *filename,
> >       void *filter_data_)
> >  {
> > -     struct filter_trees_none_data *filter_data = filter_data_;
> > +     struct filter_trees_depth_data *filter_data = filter_data_;
> > +
> > +     int too_deep = filter_data->current_depth >= filter_data->max_depth;
>
> Does max mean "maximum allowed", or "this and anything larger are
> rejected".  The latter sound wrong, but I offhand do not know if
> your current_depth counts from 0 or 1, so there may not be
> off-by-one.
>
>  - dir.c::within_depth() that is used by pathspec matching that in turn
>    is used by "grep --max-depth=1" does "if (depth > max_depth)", which
>    sounds more in line with the usual convention, I would think.
>
>  - pack-objects has max_delta_cache_size, which also is used as
>    "maximum allowed", not "this is already too big".  So is its
>    max_depth.
>
> There may be other examples.  One existing violator I noticed was
> the "reject blobs that is this size or larger" in this file; it is
> called "max_bytes", but it is apparently not "maximum allowed",
> which we probably would want to fix.
>
> > +     /*
> > +      * Note that we do not use _MARK_SEEN in order to allow re-traversal in
> > +      * case we encounter a tree or blob again at a shallower depth.
> > +      */
>
> Hmph.  Earlier tree:0 support never even read the actual tree, so
> this was not a problem.  We wouldn't have found a tree in deeper
> places first and then at a shallower depth, as we wouldn't have seen
> any tree in any depth deeper than the surface anyway.
>
> Now we need to worry about a tree that originally gets seen in a
> deeper depth (that is still below the allowed maximum) to reappear
> at a shallower place, so a subtree within it that used to be too
> deep may now be within the allowed maximum depth.
>
> Step 1 of these three patches made sure trees are not even opened
> under "tree:0", so it was not just optimizing/shrinking the output
> of rev-list but also optimizing the traversal.  When we are
> collecting omits, however, this one now returns _ZERO which means we
> still traverse into the tree, even under "tree:0"?  I must be
> reading the code incorrectly (in general, when we are seeing a tree
> object that itself is at the maximum allowed depth, trees found by
> reading its contents will never become eligible for output, even if
> they are found at a shallower depth than their other copies were
> previously found, I would think).
>
> >       switch (filter_situation) {
> >       default:
> >               BUG("unknown filter_situation: %d", filter_situation);
> >
> > -     case LOFS_BEGIN_TREE:
> >       case LOFS_BLOB:
> > +             if (!too_deep) goto include_it;
>
> Style: on two lines, like you did below for the next if() statement.
>
> > +
> > +             if (filter_data->omits)
> > +                     oidset_insert(filter_data->omits, &obj->oid);
> > +
> > +             return LOFR_ZERO;
> > +
> > +     case LOFS_BEGIN_TREE:
> > +             filter_data->current_depth++;
> > +
> > +             if (!too_deep) goto include_it;
> > +
> >               if (filter_data->omits) {
> >                       oidset_insert(filter_data->omits, &obj->oid);
> > -                     /* _MARK_SEEN but not _DO_SHOW (hard omit) */
> > -                     return LOFR_MARK_SEEN;
> > +                     return LOFR_ZERO;
> >               }
> >               else
> >                       /*
> >                        * Not collecting omits so no need to to traverse tree.
> >                        */
> > -                     return LOFR_SKIP_TREE | LOFR_MARK_SEEN;
> > +                     return LOFR_SKIP_TREE;
> >
> >       case LOFS_END_TREE:
> >               assert(obj->type == OBJ_TREE);
> > +             filter_data->current_depth--;
> >               return LOFR_ZERO;
> >
> >       }
> > +
> > +include_it:
> > +     if (filter_data->omits)
> > +             oidset_remove(filter_data->omits, &obj->oid);
> > +     return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> >  }
