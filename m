Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8BC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA43F21D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMHCq8Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLRL0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46211 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLRL0m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so1330651edi.13
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYcXoacavxrFV+jgaS7M+6cGCNE0X9k9dydwuHooLdI=;
        b=HMHCq8GzOvQvg4HQiPjUYVtUFM3ErN/5IFg8mHfO79FIr1a07VOsIyAacA5kkO52bp
         yUJnSotpOWqxNT4LuoxjX12nrNCUjDkjFyKatlwouu6++Ca6XqujuBL3ozGCBINyyEu4
         g1qzN5S8cB72C2TqIFmTWyOP2WJ9BYfioDU6nUraaiyANq+JzAUjJKN2VqsvlcjlBkn4
         ZTCD7DD4Wzz0BWEbsXJCDwiz2a6gcneDKALF9fmG9lt3l6+npRe/rzwfYybrjMahaO43
         YZKk4mQBmb5CR9lYG/sYA/tQFzSg4owwzT7nlDIgq3JOWL6JLokSd86Am6CfblLkUaAd
         J+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYcXoacavxrFV+jgaS7M+6cGCNE0X9k9dydwuHooLdI=;
        b=Z4/DayY9uCfV5yk7m5LMscfOh1dHU8L59IlVO82xJ0c74VCMVRYqOCk6Zzq8RSIzzE
         HJW8cvNTmUeXTXOxbRKt+BSiu8sAQmizs2sUCsvdMlbc3Ieo7VXkH7z0ZxI6Nhfz+d04
         ORhchKnitLz4wxwU57RSdfKF0YCvODxbErZ4Ehr047q6l0mGqYHi1/bDcwVzq2R4705/
         beGNNsPcywkuqupVNCwyeMCFWABUTsh8wETr8JpMR8P4VFwPFuI/cu83ZHc8S4YRNK0y
         z794rwZLXbIchFE6bLHvgTojD1rLu80CP8eKYRIHirtPdiq4vbvaXdB//lmZULOC5NuB
         0Z9A==
X-Gm-Message-State: APjAAAVLa83XvqQ7evToIS+ElsxTXx/38JH/tCLWBWlcx9Vck3IbSRtF
        gheeBPg7RoTp0XNr221QQH0mH2nZjzE9Ly9AEvA=
X-Google-Smtp-Source: APXvYqxFkHgFLsrymbz22ivKNg+sDZkx8+0iIP+I4APqILdPqRO7B16PYFw1Wj42EY2YArEK4SN8M5wVbSF0xEsZuRE=
X-Received: by 2002:a17:906:aec7:: with SMTP id me7mr2020961ejb.81.1576668399713;
 Wed, 18 Dec 2019 03:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-10-chriscool@tuxfamily.org> <20191209081129.GA1546451@coredump.intra.peff.net>
In-Reply-To: <20191209081129.GA1546451@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 18 Dec 2019 12:26:28 +0100
Message-ID: <CAP8UFD3k0QFFCpjjOhgvqd11TqFbfKWsEnt6b_egB0bDrVZnwA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] pack-objects: improve partial packfile reuse
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 9:11 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 15, 2019 at 03:15:41PM +0100, Christian Couder wrote:
>
> > The old code to reuse deltas from an existing packfile
> > just tried to dump a whole segment of the pack verbatim.
> > That's faster than the traditional way of actually adding
> > objects to the packing list, but it didn't kick in very
> > often. This new code is really going for a middle ground:
> > do _some_ per-object work, but way less than we'd
> > traditionally do.
>
> This is a good intro to the general problem, but...
>
> > For instance, packing torvalds/linux on GitHub servers
> > just now reused 6.5M objects, but only needed ~50k
> > chunks.
>
> What the heck is a chunk? :)
>
> I know, because I wrote the patches, but I think we need to sketch out
> the solution a bit for the reader.

Ok with sketching it out.

> I think the flow here is:
>
>   - we want to do some per-object work (i.e., your intro above)
>
>   - the general strategy is to make a bitmap of objects from the
>     packfile we'll include, and then iterate over it, writing out each
>     object exactly as it is in our on-disk pack, but _not_ adding it to
>     our packlist (which costs memory, and increases the search space for
>     deltas)
>
>   - one complication is that if we're omitting some objects, we can't
>     set a delta against a base that we're not sending. So we have to
>     check each object in try_partial_reuse() to make sure we have its
>     delta (actually, that third big comment in that function is
>     incomplete, I think; it talks about sending the object later, not as
>     part of the reused pack, but we might not send it at all!).

Are you talking about this comment:

        /*
         * And finally, if we're not sending the base as part of our
         * reuse chunk, then don't send this object either. The base
         * would come after us, along with other objects not
         * necessarily in the pack, which means we'd need to convert
         * to REF_DELTA on the fly. Better to just let the normal
         * object_entry code path handle it.
         */

?

I don't see how it's talking about sending the object later, so I have
left it as is. Maybe you can check it again in the v4 series I am
going to send.

>   - another complication is that when we omit parts of the packfile,
>     that screws up delta base offsets. So to handle that, we have to
>     keep track of which chunks we send (which is the bits you included
>     below about chunks)
>
>   - and then we can talk about performance; worst case we might have
>     interleaved objects that we are sending or not sending, and we'd
>     have as many chunks as objects. But in practice we send big chunks,
>     so that's where the 6.5M objects vs 50k chunks comes in.

Ok, I have added your points above to the commit message.

> > Additional checks are added in have_duplicate_entry()
> > and obj_is_packed() to avoid duplicate objects in the
> > reuse bitmap. It was probably buggy to not have such a
> > check before.
> >
> > If a client both asks for a tag by sha1 and specifies
> > "include-tag", we may end up including the tag in the reuse
> > bitmap (due to the first thing), and then later adding it to
> > the packlist (due to the second). This results in duplicate
> > objects in the pack, which git chokes on. We should notice
> > that we are already including it when doing the include-tag
> > portion, and avoid adding it to the packlist.
> >
> > The simplest place to fix this is right in add_ref_tag,
> > where we could avoid peeling the tag at all if we know that
> > we are already including it. However, I've pushed the check
> > instead into have_duplicate_entry(). This fixes not only
> > this case, but also means that we cannot have any similar
> > problems lurking in other code.
>
> I think this part could go in its own commit. If we introduce
> reuse_packfile_bitmap early, even if it's always an all-or-nothing chunk
> at the beginning of the file with the existing code, then we can
> introduce the extra checks in have_duplicate_entry() on top of that.

Ok, I have extracted this part into its own commit.

> And then it would be safe to do the cleanup in show_objects_from_type()
> that triggers the test failure in patch 4.

Ok, I have eventually moved patch 4 at the end of the series.

> >  builtin/pack-objects.c | 222 ++++++++++++++++++++++++++++++++---------
> >  pack-bitmap.c          | 150 ++++++++++++++++++++--------
> >  pack-bitmap.h          |   3 +-
> >  3 files changed, 288 insertions(+), 87 deletions(-)
>
> It might be worth having a perf test here. The case this is helping the
> most, I think, is when somebody cloning wants all of the objects from
> the beginning of the pack, but then there's a bunch of _other_ stuff.
>
> That could be unreachable objects kept by "repack -k", or maybe objects
> reachable outside of heads and tags. Or objects that are part of other
> delta islands. This last is the most plausible, really, because we'll
> put all of the root-island objects at the beginning of the pack. So
> maybe a good perf test would be to take an existing repository add a
> bunch of new commits in refs/foo/,

Not sure how I could do so. How would you do that?

I think it would be best to add completely new realistic commits that
are changing the main code base.

> and then repack with delta islands
> such that refs/heads and refs/tags are in one (root) island, but
> refs/foo is in another.
>
> The old code should fail to do the pack-reuse thing, but we should get
> pretty good reuse with the new code (and less CPU and peak RAM,
> hopefully, though the perf suite doesn't measure RAM directly).

I haven't added a perf test. I may do it if I get an idea about how to
add new commits in refs/foo/.

> Answering some questions from Jonathan's response in the last round
> (some of the quotes are his, some are yours):
>
> > I still don't understand this part. Going off what's written in the
> > commit message here, it seems to me that the issue is that (1) an object
> > can be added to the reuse bitmap without going through to_pack, and (2)
> > this is done when the client asks for a tag by SHA-1. But all objects
> > when specified by SHA-1 go through to_pack, don't they?
>
> No, if it's part of the reused chunk, we'd avoid adding it to to_pack at
> all (and I think the commit message should make that more clear, as I
> described above).

I used your description above to improve the commit message, so I
guess it now answers his question.

> > >> No tests, because git does not actually exhibit this "ask
> > >> for it and also include-tag" behavior. We do one or the
> > >> other on clone, depending on whether --single-branch is set.
> > >> However, libgit2 does both.
> >
> > So my wild guess sould be that maybe the reason is that some of this
> > code was shared (or intended to be shared) with libgit2?
>
> No, the question is how the client behaves, and how we on the server
> react to it. Git as a client would never ask for both include-tag and
> for the tag itself by sha1. But libgit2 will, so a libgit2 client
> cloning from a Git server would trigger the bug.

Ok, I have made it explicit in the commit message that the bug would
be triggered by a libgit2 client but not a Git client.

> > > +     if (pos >= bitmap_git->pack->num_objects)
> > > +             return; /* not actually in the pack */
> >
> > Is this case possible? try_partial_reuse() is only called when there is
> > a 1 at the bit location.
>
> Yes, it's possible. The result of a bitmap walk is larger than a given
> pack, because we have to extend it to match whatever objects the caller
> asked for. E.g., imagine we have commit A, repack into into a bitmapped
> pack, and then somebody pushes up commit B. Now I want to clone, getting
> both A and B.
>
> Our bitmap result represents the whole answer, and so must include both
> objects. But since "B" isn't in the pack, it doesn't have an assigned
> bit. We add it to the in-memory bitmap_git->ext_index, which gives it a
> bit (valid only for that walk result!). But of course for pack reuse, we
> only care about the objects that were actually in the bitmapped pack.

Not sure if these explanations should go into the commit message or a
comment in the code. So I haven't added them for now.

> > > +     /* Don't mark objects not in the packfile */
> > > +     if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
> > > +             i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
> >
> > Why is this necessary? Let's say we have 42 fully-1 words, and therefore
> > i is 42. Shouldn't we allocate 42 words in our reuse bitmap?
>
> This is the same issue as above. Imagine instead of two objects, imagine
> we have 42 words worth. But if only 20 words worth are in the packfile,
> then we have to stop there.
>
> Now we _could_ figure this out for each individual object through the
> similar logic in try_partial_reuse(). But we try to take an even faster
> path for the initial chunk of objects. We don't even walk over them
> looking to see if they're deltas or not. We just send that chunk of the
> pack verbatim.
>
> I don't have numbers for how often we hit this path versus the
> individual try_partial_reuse() path. Possibly the stats could
> differentiate that.

Also not sure if these explanations should go into the commit message
or a comment in the code. So I haven't added them for now.

> Thinking on it more, though, I wonder if there's a bug hiding here. We
> know that we can send the whole initial chunk verbatim for OFS_DELTA
> objects, because the relative offsets will remain unchanged (i.e., there
> are no "holes" that trigger our chunk code). But if there were a
> REF_DELTA in that initial chunk, we have no certainty that the base is
> being sent.
>
> In practice, this doesn't happen because the objects in question have to
> be in a pack with bitmaps, which means it was written ourselves by
> git-repack. And we'd never write REF_DELTA objects there.
>
> But I wonder if it's worth being a bit more careful (and what the
> performance impact is; it would mean checking the type of every object
> in that initial chunk).

I haven't done anything related to that. Maybe something can be done
in a follow up patch.

Thanks a lot for the review!

Christian.
