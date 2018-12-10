Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6610220A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeLJXPq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 18:15:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35696 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 18:15:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so12226487otj.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/Io8IhzMMPG9tuqoHoCDmqi8SjkDx5Lt+q7zyPLasU=;
        b=hxrpxaEBvo7Plzw6SJ6iKCPzq5kJ/21m92KYU3F8xtNGe+cZRTK6daSjz9uiRARCVi
         DMZBbibht/XkbHsutjN+8gpINJAk/z6B7tGW9J17tGjnAgkq4Xd09q3HFNJNBL+ITQhO
         rgQh40XZAlBkPDjnjKpQS7SUcI1AFC1Mw3Q6TJvf438zseR1nk0T17wBWc3RKLm+2ok6
         mrgIdk/kEabOjObK03gab9hZVtotonDCJvjXJ7xm3nU7c4scap+RJ+e2TNn1AJtt93G8
         IjRUCNhcXS0LZ4adiPSxTHnoiLUDiQiCREZbY7DWlB/vgdDoK0RexOOU7HPOF+1O/yjK
         Daxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/Io8IhzMMPG9tuqoHoCDmqi8SjkDx5Lt+q7zyPLasU=;
        b=oyvtF8rGSNSjfCxQkfxzdfTDLzxUbnaEhGzqHXFWFE6H0l8IUDZzOxz8zbKaVnaW+C
         VDNvNBrQBx/9FBVhOCwqtDBPWOABhiKKH6olerKsoHwa4GKyQyISiFSLuxjFyUVVQsSg
         AkVsidYLR6m0RDKgWPyDUvuN0tmbYQGqROqw1+uA6fkpNuD16DksHeIRyCqbrGa0m+QN
         47x10t5qnxMG/g21PzL0zIVbH4ahgCAKGKIuMvwf5aX9pUYEvK+38BQoIm78yqEg88Pd
         qHSRLPtKXtDsyC6N77KuC2R+7Mvo5FgfOlcaGixFZhWDE6MwwOw8FlLquE4OjlkeY7Ou
         ncpA==
X-Gm-Message-State: AA+aEWYY1dXplAcEmA3mUVKREL9j4kTZM9I/QqigiXSAtTer+7KXeg6E
        Y9Nlu4Fj7Xku9mBg8Yw+tBm4M2mS8lRXi85q0ogt
X-Google-Smtp-Source: AFSGD/VMNGRjGkui4uPj50d5rcNOcREAgo4g7u+FK9YNybhCQZNb7+aUvBXoR2WAnYkqPzh6v6o/su8+r6OBWXfSBLQ=
X-Received: by 2002:a9d:5183:: with SMTP id y3mr9119072otg.5.1544483744278;
 Mon, 10 Dec 2018 15:15:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1539298957.git.matvore@google.com> <e340f743e6749e65525e1342dc47faaa6540f04b.1539298957.git.matvore@google.com>
 <xmqqlg706iv1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg706iv1.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 10 Dec 2018 15:15:32 -0800
Message-ID: <CAMfpvhJFtO_e99vdLiWX5W4E_7Ee27spBx6pi8dN0tUCXhftRA@mail.gmail.com>
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

I added a paragraph mentioning the "roundtrip" aspect to the commit
message, since this *may* help someone find a use for it.

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

I have reworded this to be more explicit about "stdin," and also to
avoid directly admitting that trees are allowed in the <commit>
argument, since I've dropped the s/<commit>/<object>/ patch.

Here is the new paragraph:

The form '--filter=tree:<depth>' omits all blobs and trees whose depth
from the root tree is >= <depth> (minimum depth if an object is located
at multiple depths in the commits traversed). <depth>=0 will not include
any trees or blobs unless included explicitly in the command-line (or
standard input when --stdin is used). <depth>=1 will include only the
tree and blobs which are referenced directly by a commit reachable from
<commit> or an explicitly-given object. <depth>=2 is like <depth>=1
while also including trees and blobs one more level removed from an
explicitly-given commit or tree.

> > +                                     _("expected 'tree:<int>'"));
>
> We do not accept "tree:-1", even though "-1" is an int.  Is it too
> obvious to worry about?  I do not think we want to say tree:<uint>
> even if we do want to make it clear we reject "tree:-1"
>
> I am wondering if "expected 'tree:<depth>'" would work better.

Yes, I agree, <depth> is more helpful and not ambiguous in a
significant way. Fixed.

> > +     unsigned long tree_depth_limit_value;
> >  };
>
> This change gets it right by adding "depth" in the field name and it
> is not a comment on this patch, but someday not in too distant
> future we should rename the "blob_limit_value" to make it clear that
> it is filtering by number of bytes, as other filtering criteria on
> blobs that can be expressed in ulong are quite possible.

Agreed.

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
It means "this and anything larger are rejected." The documentation
words it similarly:
"
The form '--filter=tree:<depth>' omits all blobs and trees whose depth
from the root tree is >= <depth> ...
"

There is no intuitive phrase to mean "distance from root tree minus
one" (left operand) and I don't want to change the filter option field
to something different from what the user entered (right operand), so
I think we'd best use ">=" and I've renamed the field to
"exclusion_trigger_depth".

> There may be other examples.  One existing violator I noticed was
> the "reject blobs that is this size or larger" in this file; it is
> called "max_bytes", but it is apparently not "maximum allowed",
> which we probably would want to fix.
>

That's not ideal. The documentation suggests it means "maximum
allowed," and JGit apparently is interpreting the value as "maximum
allowed," so we should probably fix the semantics in Git. Or were you
suggesting to keep the behavior the same but fix the naming and docs?

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

That's true, and it points out the fact that we can't use
LOFR_MARK_SEEN even if we do LOFR_DO_SHOW, since subtrees may or may
not be within the limit in the future. I've fixed that for v+1 of the
patch, and added a corresponding test. I'm also refactoring the
filters_tree_depth function to not use goto. I think it is easier to
follow that way.

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

You are reading the code right - when the tree is too deep, we
sometimes return LOFR_ZERO, sometimes _SKIP_TREE - the latter if we
are collecting omits. But as you observe, we don't need to traverse an
omitted tree *if it has already been marked as omitted*, since that
suggests that its children have also been marked as omitted. So I've
added a new commit to this patchset which optimizes this case. The
next patchset will have 2 commits (subtracting the documentation
rewrite one and ones that are already scheduled to merge):

Patch 1/2 - implement tree:<depth> for positive depths
Patch 2/2 - stop iterating through trees for collecting omits if the
omits are already marked
