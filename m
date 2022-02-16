Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182FBC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 13:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiBPNYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiBPNYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 08:24:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB04235
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:24:20 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d17so2181027pfl.0
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ka00Myd3GUyejFOo8or206N4snoSy2t9f+ggqrxXLzQ=;
        b=IERGnAfT/gHNJtJPWKwLyB7Fh9d/GH+tXoEZyQI4WUD4+c4q37eUr2WkYQvr9MTWCx
         8/dSRlS+rBclJUKiF/fUoWqLqZVIg5soLPWZTiyFHD3pKcf07f0se5G+feb0lqDZoMtA
         YtXLHqDndDJtLtY3Ki3MpKL/mwS7QnIxAjYSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ka00Myd3GUyejFOo8or206N4snoSy2t9f+ggqrxXLzQ=;
        b=u9x5MG1bQ95ikJtuQAH5vZfbEZFYgvDvt4RV3liOxWlPxNB3TvpkSH8PKxQq6eB3qQ
         xbBvBP6QWJBiUTQaaHyffcHI/LyyYYLfxtzN16UUT2OrblrAgBhHnxJptNFj5dPZ6Mzi
         QYR4rA4p2EeqlRqgQUKp/5JxguWiiIbzirQg5liErb/ocE+rvJQqQsz8bkXK5mDFAULC
         WKFL7JBDJoUb/DusB+Qd+ySActVow9Qhf6M67WLTQeYB8Au28jogzvKT6WzpFXfRJo2L
         ELTahkW7ey0BF128Cggzf0IDfQScBSRywhIO4T1S1YjRZ1ibApzpAYQSDVyEs/CvPwkr
         EBeQ==
X-Gm-Message-State: AOAM531j77PF7zvLKJLjHVHjfWC45ZsMzmgL8/OOAuMl2tnl1dfAudLD
        H3FvhM4d0A+zjyaS4jt+XhCqcTxYMeQib4dAXuhNAJq8lWfvGSLi
X-Google-Smtp-Source: ABdhPJyvaYA9X8MAzrwwE9npbJH6hYESiJUC3aI5XTEdXKm1HmHDAwG7Rb4ftCi8qlJlLtYmEcvEn5ioMXSli0khIiE=
X-Received: by 2002:a63:5f0f:0:b0:370:1db0:5766 with SMTP id
 t15-20020a635f0f000000b003701db05766mr2286447pgb.532.1645017859955; Wed, 16
 Feb 2022 05:24:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <xmqqk0eecpl9.fsf@gitster.g> <CACf-nVdmWyDnhJC=ikx85UST=u2ENAc4DhJJCp5c030Vb9=4+Q@mail.gmail.com>
In-Reply-To: <CACf-nVdmWyDnhJC=ikx85UST=u2ENAc4DhJJCp5c030Vb9=4+Q@mail.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 16 Feb 2022 13:24:08 +0000
Message-ID: <CACf-nVfX-R6wDc+YVVOzQsm9werTON1zjwitScr-Kh4yUvc6VA@mail.gmail.com>
Subject: Re: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with
 expanded filter
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Wed, 2 Feb 2022 at 15:02, Robert Coup <robert@coup.net.nz> wrote:
> On Tue, 1 Feb 2022 at 20:13, Junio C Hamano <gitster@pobox.com> wrote:
> > "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >  1. This will produce duplicated objects between the existing and newly
> > >     fetched packs, but gc will clean them up.
> >
> > Hopefully, at the end of this
> > operation, we should garbage collect the duplicated objects by
> > default (with an option to turn it off)?
>
> I haven't explicitly looked into invoking gc yet, but yes, it'd be a bit of
> a waste if it wasn't kicked off by default. Maybe reusing gc.auto

Just looking into this: after a fetch, run_auto_maintenance() is called, which
invokes `git maintenance run --auto` (being the successor to `git gc --auto`)...

In the refilter (repair) case, we'll have a new pack which substantially
duplicates what's in our existing packs. I'm after some advice here: I'm not
sure whether I want to encourage a gc pack consolidation, an incremental
repack, both, neither, or something else?

My current train of thought is it invokes `git maintenance run --auto` with
gc.autoPackLimit=1 to force a gc pack consolidation if it's not currently
=0 (disabled), and with maintenance.incremental-repack.auto=-1 if it's not
currently =0 (disabled) to force an incremental repack if someone doesn't
want to do pack consolidations.

In all cases the various enabled-ness settings should still be honoured to
skip tasks if the user doesn't want them ever happening automatically.

Implementation-wise I guess we'll need run_auto_maintenance() to be able
to pass some config options through to the maintenance subprocess.

Does this sound like a reasonable approach?

Thanks,

Rob :)
