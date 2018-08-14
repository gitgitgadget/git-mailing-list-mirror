Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CE01F404
	for <e@80x24.org>; Tue, 14 Aug 2018 00:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeHNDH2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 23:07:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32844 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeHNDH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 23:07:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so30610008oip.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 17:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xa+Wb1TOI0jYcwO0hbaK/HcVgi1VnPFcZo6A/1cH178=;
        b=FYxFZIoQYiJ5YANLejj9ig1GtHP5fDgnjhkSuaoWqh+hcrehF1aYQbwuQCRM8RAZSW
         MGeg3N3a3UyeN7W8Q9pI7668QQTIzoooOcVxxEuOiqKI0xy/b4t7r4XR+KMv+QnSkHS9
         xTY2g1umfcm9dSMd4n060K3O4+Wk9htuCVgcqCrbjhpdD9sDo7sD6ct944qgwzyK8Mp+
         3YjZHivBY1mktzvpbSdlzjQ1VTgUfd1eDOmx5RW8JI19BR28Q0RIAxFpYUL0iks+RnQS
         jPLvm5557W7Bsv0ujbCjQvkhI9t2CAJIU/6lqKPrHzMiThlNO3GlwEA5Ppz/L41ZvlDW
         Rdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xa+Wb1TOI0jYcwO0hbaK/HcVgi1VnPFcZo6A/1cH178=;
        b=f/LURW17zEC6Q0WoyVfZyGh7NL5WHWN4pUOaO7xkanwFcj3Gzkf99rve4hYPWG0Qjv
         XcBGlspfYM+JDVNxrHqmamLVEF0iXaskYd25Oqwe0kfsxuT8cqEicIpXaDoS7EquZ4zV
         YbFbTxnZ4+JLn7COVV0pM6qdVBkwnVqKo+XlCI2NwO677pax2LwjMbwWd6Ln1rqPPvy/
         7gEZzxyTDebHGl3PMxpt/N6HAPRgi54Hamn/SppnPlECJP8jWVHwUukzs8tsQ8hqH92Y
         Hjd9vQXPXEh+sNresSi7nFefHMMbv+SibemWQlcl/uzxaK35SyPqT2cEDxAsdnKSWDrl
         bDmQ==
X-Gm-Message-State: AOUpUlFxCliVlEyyqgRbuWj3BAga9zntS56jvzcCwqkHLoL0Incb3EVy
        AiP256K8Zg/TepxUwILSpiS1irV4og+BOyf2SKf1
X-Google-Smtp-Source: AA+uWPxyQDhPg16IIsEM5kqkT0BxauGAbcXMjbH8TZMlwC3hKEMljtQarq3edcFmxhYQsQXySYh1rD9kiu4580FzC3E=
X-Received: by 2002:aca:390a:: with SMTP id g10-v6mr21225684oia.145.1534206170238;
 Mon, 13 Aug 2018 17:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <6d6b06e870b5d6dbe9bb88bd80fcce34ba4dcccf.1533941986.git.matvore@google.com>
 <20180813182025.14229-1-jonathantanmy@google.com>
In-Reply-To: <20180813182025.14229-1-jonathantanmy@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 13 Aug 2018 17:22:38 -0700
Message-ID: <CAMfpvh+awO8kpVtxKxMDuiXx2XM0o3xGycXdSF+ZJ0NXyzv5Hg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rev-list: handle missing tree objects properly
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending this in plain-text mode so that git@vger.kernel.org won't
bounce it. Sorry for those of you receiving this twice.

On Mon, Aug 13, 2018 at 11:20 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > In list-objects.c we no longer print a message to stderr if a tree
> > object is missing (quiet_on_missing is always true). I couldn't find
> > any place where this would matter, or where the caller of
> > traverse_commit_list would need to be fixed to show the error. However,
> > in the future it would be trivial to make the caller show the message if
> > we needed to.
>
> Indeed, and I'm not sure why the message was there in the first place -
> if parsing fails when revs->ignore_missing_links and
> revs->exclude_promisor_objects are both false, we print the OID anyway
> in the "die" call, so any message printed by parse_tree_gently() seems
> superfluous.
>
> It might be better to add an additional commit that removes the "gently"
> condition (in other words, always parsing gently), with a message
> explaining the above. Also, in that commit, I prefer not to add the
> "/*quiet_on_missing*/" explanation (we don't seem to do that in Git
> code); I also know that the ">= 0" is a holdover from the existing "< 0"
> code, but we don't need to do that either.
Good idea. I've added a new commit which replaces the calculation with
a hard-coded "1"
I don't understand about the ">= 0". What should I replace it with?
Maybe you mean the return is never positive so I can change:

parse_tree_gently(tree, 1) >= 0

to:
!parse_tree_gently(tree, 1)

?

>
> > This is not tested very thoroughly, since we cannot create promisor
> > objects in tests without using an actual partial clone. t0410 has a
> > promise_and_delete utility function, but the is_promisor_object function
> > does not return 1 for objects deleted in this way. More tests will will
> > come in a patch that implements a filter that can be used with git
> > clone.
>
> is_promisor_object() should. If you still have the code you used to
> verify that, can you share it? In particular, pay attention to the path
> of the repo - promise_and_delete is hardcoded to use one particular
> path.
It turns out I wasn't setting the extensions.partial_clone config in
my test, and that's why everything wasn't working. So I've moved all
the tests feasible back to the earlier commit. Cool :)

>
> Whether you test in this patch or in the last patch, make sure that the
> following are tested:
>  git rev-list --missing=error, allow-any, allow-promisor, print
>  git rev-list --exclude-promisor-objects
>
Added --missing=print, --missing=allow-any, and
--exclude-promisor-objects to t0410
--missing=allow-promisor did some seem sufficiently interesting or
different from allow-any to justify adding it.
I had to put missing=error into the commit that introduces the tree:0
filter, since that flag causes an automatic attempt to fetch the
missing object, which t0410 does not seem to support. So added test
case "auto-fetching of trees with --missing=error" to t5616.

> Also, test when a tree pointed to by a commit is missing, and when a
> tree pointed to by a tree is missing.
Former is done multiple times already, added latter to t0410 as
"missing non-root tree object and rev-list."
>
> > @@ -152,20 +151,21 @@ static void process_tree(struct traversal_context *ctx,
> >               die("bad tree object");
> >       if (obj->flags & (UNINTERESTING | SEEN))
> >               return;
> > -     if (parse_tree_gently(tree, gently) < 0) {
> > +     parsed = parse_tree_gently(tree, /*quiet_on_missing=*/1) >= 0;
> > +     if (!parsed) {
> >               if (revs->ignore_missing_links)
> >                       return;
> >
> > +             if (!is_promisor_object(&obj->oid))
> > +                     die("bad tree object %s", oid_to_hex(&obj->oid));
> > +
> >               /*
> >                * Pre-filter known-missing tree objects when explicitly
> >                * requested.  This may cause the actual filter to report
> >                * an incomplete list of missing objects.
> >                */
> > -             if (revs->exclude_promisor_objects &&
> > -                 is_promisor_object(&obj->oid))
> > +             if (revs->exclude_promisor_objects)
> >                       return;
> > -
> > -             die("bad tree object %s", oid_to_hex(&obj->oid));
> >       }
>
> The missing mechanism (for error, allow-any, print) should work without
> needing to consult whether an object is a promisor object or not - it
> should just print whatever is missing, so the "if
> (!is_promisor_object..." line looks out of place.
Done. I considered that a missing object which is not a promisor is a
serious error, so I had it die here. But now that I've added the
do_not_die_on_missing_tree flag, it's more natural to keep the
previous promisor check as-is. Also, is_promisor_object is an
expensive check, and it would be better to skip it during the common
execution path (which should be when exclude_promisor_objects, an
internal-use-only flag, is *not* set, which means we never call
is_promisor_object.

>
> In my original review [1], I suggested that we always show a tree if we
> have its hash - if we don't have the object, we just recurse into it.
> This would be the same as your patch, except that the 'die("bad tree
> object...' is totally removed instead of merely moved. I still think
> this solution has some merit - all the tests still pass (except that we
> need to check for "unable to read" instead of "bad tree object" in error
> messages), but I just realized that it might still be backwards
> incompatible in that a basic "rev-list --objects" would now succeed
> instead of fail if a tree was missing (I haven't tested this though).
The presence of the die if !is_promisor_object is what justified the
changing of the parse_tree_gently to always be gently, since it is
what showed the OID. Can we really remove both? Maybe in a different
patch set, since I'm no longer touching that line?

>
> We might need a flag called "do_not_die_on_missing_tree" (much like your
> original idea of "show_missing_trees") so that callers that are prepared
> to deal with missing trees can set this. Sorry for the churn. You can
> document it as such:
Added it, but not with a command-line flag, only in rev-info.h. We can
always  add a flag later if people have been relying on the existing
behavior of git rev-list to balk at missing trees. (That seems
unlikely though, considering there is no filter to enable that before
this patchset).

>
>  Blobs are shown without regard for their existence. But not so for
>  trees: unless exclude_promisor_objects is set and the tree in question
>  is a promisor object, or ignore_missing_links is set (and in this case,
>  the tree in question may or may not be a promisor object), the revision
>  walker dies with a "bad tree object" message when encountering a
>  missing tree.
>
>  For callers that can handle missing trees and want them to be
>  filterable and showable, set this to true. The revision walker will
>  filter and show such a missing tree as usual, but will not attempt to
>  recurse into this tree object.
>
> [1] https://public-inbox.org/git/20180810002411.13447-1-jonathantanmy@google.com/
