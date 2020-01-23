Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4315C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CB821569
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6L/fGS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAWW3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:29:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41073 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAWW3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 17:29:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so137928eds.8
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thsGqvmN7rGRkXJBGUrVnUjvoZ3EFzfQDLQDRbGYjmc=;
        b=g6L/fGS814OVE62JgmVIfdGn+VG6R3lt/rdTtw42XFn9sAIBSRRlXksZXDFUcW3odC
         KZTpn9GOTWsfoZiVLbzzYsx8G7XIhqh4ljTv6onNv4zkHpRBXCXeMz5nb9TnHAUXa48E
         jDIze6PgFuv7FwlgqRaWbv4IF+4UfJBk/hXMyzJmnGJAoTzLqRyYsPRgR5xDNCd3CObf
         mpVmSOQCyoy00n+cztGgxpD0sHM+Q9bp+w7c1LVvNU6rSLy7JFvO9FwYHlnMACPKYxl2
         SsngwEjVzBvJLDt7FKg3LDvmAiKpJBOgUtyO+NaxVUFs9+Yu3rHByYk834lVq4UBbUXd
         dr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thsGqvmN7rGRkXJBGUrVnUjvoZ3EFzfQDLQDRbGYjmc=;
        b=MCNXcIQuraJS3gG3zPSPTpZuqqGkWFqiXaSxnN/mYaEyISfF1qPjjzhEXhJQrdlvAo
         mVE49jax/SMMdtRl4knnnN30COvir2v2SWO7S9MwbHofZy+EyOKBNidsz9a0u6i/0LLz
         aZ+JsF4x6gFuGYsrPEFrVzqoa6szgad3kQa1k+pCDczLoKWg3/iY+wJvB5Jv4FhuDRMH
         68RmqTowp8BahqV+xotYLU2YcKMLsWo8EVyYRTn5CHeo05ic8K3Tpo7qNmoL1CzKOT52
         d9bi2ELqau9QUvUoxL3OuRwoMKFLi9MrKV0i+jcg+yLhPuZFyBj9Q/s2tVDiyYhhYI+U
         CuIw==
X-Gm-Message-State: APjAAAUMSLhb+7ZNupCTgdedgUR/I2dC8o+FS594Kxf8SElXzHXz3e0w
        02qv80mfeiUHhzvo65OMulB8ZpAqy5B3RPQSUSI=
X-Google-Smtp-Source: APXvYqyFXdM2E/nk0oFD3Nn+noLjxEE8hkbnUyU3Vc1Y6Rb7nKZWjt1tD1Jc9hpkHU50dByXRpozT+1pi8LTvGj7PM0=
X-Received: by 2002:a50:fb13:: with SMTP id d19mr55157edq.87.1579818575343;
 Thu, 23 Jan 2020 14:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-10-chriscool@tuxfamily.org> <20191209081129.GA1546451@coredump.intra.peff.net>
 <CAP8UFD3k0QFFCpjjOhgvqd11TqFbfKWsEnt6b_egB0bDrVZnwA@mail.gmail.com> <20191219004232.GA24434@coredump.intra.peff.net>
In-Reply-To: <20191219004232.GA24434@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Jan 2020 23:29:24 +0100
Message-ID: <CAP8UFD0h1TFVNqH7g823psaQzmEmzoz200CkZuDOV8GqNV7mrQ@mail.gmail.com>
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

On Thu, Dec 19, 2019 at 1:42 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 18, 2019 at 12:26:28PM +0100, Christian Couder wrote:
>
> > >   - one complication is that if we're omitting some objects, we can't
> > >     set a delta against a base that we're not sending. So we have to
> > >     check each object in try_partial_reuse() to make sure we have its
> > >     delta (actually, that third big comment in that function is
> > >     incomplete, I think; it talks about sending the object later, not as
> > >     part of the reused pack, but we might not send it at all!).
> >
> > Are you talking about this comment:
> >
> >         /*
> >          * And finally, if we're not sending the base as part of our
> >          * reuse chunk, then don't send this object either. The base
> >          * would come after us, along with other objects not
> >          * necessarily in the pack, which means we'd need to convert
> >          * to REF_DELTA on the fly. Better to just let the normal
> >          * object_entry code path handle it.
> >          */
> >
> > ?
> >
> > I don't see how it's talking about sending the object later, so I have
> > left it as is. Maybe you can check it again in the v4 series I am
> > going to send.
>
> Yes, that's the comment. It says "the base would come after us". That
> could be true, but it also could be that we are not sending the object
> at all (in fact, that seems more likely in practice). The outcome is the
> same, though: we don't verbatim reuse the delta'd object if its base is
> not also being reused.

In the V4 (https://public-inbox.org/git/20191218112547.4974-11-chriscool@tuxfamily.org/)
there is now the following in the commit message:

One complication is that if we're omitting some objects,
we can't set a delta against a base that we're not
sending. So we have to check each object in
try_partial_reuse() to make sure we have its delta.

Would you also want the comment to be improved to something like:

         /*
          * And finally, if we're not sending the base as part of our
          * reuse chunk, then don't send this object either. Because we
          * should not send the object at all. Or because the base
          * would come after us, along with other objects not
          * necessarily in the pack, which means we'd need to convert
          * to REF_DELTA on the fly. Better to just let the normal
          * object_entry code path handle it.
          */

> > > It might be worth having a perf test here. The case this is helping the
> > > most, I think, is when somebody cloning wants all of the objects from
> > > the beginning of the pack, but then there's a bunch of _other_ stuff.
> > >
> > > That could be unreachable objects kept by "repack -k", or maybe objects
> > > reachable outside of heads and tags. Or objects that are part of other
> > > delta islands. This last is the most plausible, really, because we'll
> > > put all of the root-island objects at the beginning of the pack. So
> > > maybe a good perf test would be to take an existing repository add a
> > > bunch of new commits in refs/foo/,
> >
> > Not sure how I could do so. How would you do that?
> >
> > I think it would be best to add completely new realistic commits that
> > are changing the main code base.
>
> I agree that would be the most realistic for the "forked repository
> network" case that we originally wrote this for. But I think a more
> mundane (and possibly easier to generate) example might be having a
> bunch of refs/notes.
>
> So perhaps something like this:

[...]

Ok, I will add this test to my patch series if I need to resend a V5.
Otherwise I will send it separately.

> From my limited prodding, it doesn't trigger pack-reuse with the current
> code, but would after your series. On linux.git, it produces:
>
> Test                          origin              origin/jk/packfile-reuse-cleanup
> ----------------------------------------------------------------------------------
> 5312.3: clone without notes   14.16(14.26+4.84)   10.80(10.40+0.44) -23.7%
> 5312.4: clone size                       1.4G                1.4G +0.0%

Yeah, nice improvement.

> though I suspect the more interesting savings is in RAM (since we don't
> have to allocate a "struct object_entry" for most of the objects). I
> don't know how hard it would be to collect that data in the perf suite.

I don't know either.

> Running the final pack-objects manually with massif, I get peak heap
> usage dropping from ~1500MB to ~380MB.

Very nice!

> For git.git it seems less impressive (very little CPU saved, and the
> resulting pack is slightly larger, perhaps due to not re-considering
> some deltas whose on-disk versions had to be thrown away):
>
> Test                          origin            origin/jk/packfile-reuse-cleanup
> --------------------------------------------------------------------------------
> 5312.3: clone without notes   1.22(3.60+0.16)   1.20(3.56+0.16) -1.6%
> 5312.4: clone size                      65.3M             67.0M +2.5%

Yeah, I think this is acceptable.

> > > > Is this case possible? try_partial_reuse() is only called when there is
> > > > a 1 at the bit location.
> > >
> > > Yes, it's possible. The result of a bitmap walk is larger than a given
> > > pack, because we have to extend it to match whatever objects the caller
> > > asked for. E.g., imagine we have commit A, repack into into a bitmapped
> > > pack, and then somebody pushes up commit B. Now I want to clone, getting
> > > both A and B.
> > >
> > > Our bitmap result represents the whole answer, and so must include both
> > > objects. But since "B" isn't in the pack, it doesn't have an assigned
> > > bit. We add it to the in-memory bitmap_git->ext_index, which gives it a
> > > bit (valid only for that walk result!). But of course for pack reuse, we
> > > only care about the objects that were actually in the bitmapped pack.
> >
> > Not sure if these explanations should go into the commit message or a
> > comment in the code. So I haven't added them for now.
>
> I think this is really outside the scope of this series, even, and gets
> into how the bitmap traversal works in general. I'm sure the
> documentation for that could be a bit better.

Ok, I will take a look at improving the documentation, either in this
patch series if I resend it, or in a follow up small series.

> > > Thinking on it more, though, I wonder if there's a bug hiding here. We
> > > know that we can send the whole initial chunk verbatim for OFS_DELTA
> > > objects, because the relative offsets will remain unchanged (i.e., there
> > > are no "holes" that trigger our chunk code). But if there were a
> > > REF_DELTA in that initial chunk, we have no certainty that the base is
> > > being sent.
> > >
> > > In practice, this doesn't happen because the objects in question have to
> > > be in a pack with bitmaps, which means it was written ourselves by
> > > git-repack. And we'd never write REF_DELTA objects there.
> > >
> > > But I wonder if it's worth being a bit more careful (and what the
> > > performance impact is; it would mean checking the type of every object
> > > in that initial chunk).
> >
> > I haven't done anything related to that. Maybe something can be done
> > in a follow up patch.
>
> Hmm.  I was thinking the problem was introduced in this series, but the
> old code should suffer from this as well. I wondered if it might simply
> be that the old code did not trigger often enough for anybody to notice,
> but we have been running the code in this series for several years at
> GitHub. So probably my reasoning above is sound (but it might still be
> worth addressing).

Ok, I will take a look.

Thanks,
Christian.
