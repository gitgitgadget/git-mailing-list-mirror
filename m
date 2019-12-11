Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D64C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FB821556
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="Fd7R/mQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLKW3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:29:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37007 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKW3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 17:29:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so25912217lja.4
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xG2aDXbk+7lS8x5EjusgY20hYahP7LqA2MEWt2qEFQg=;
        b=Fd7R/mQucr7ymEI5OpE19vLkC9XpHLrQGo8AFOzIuXmAhENaONLae+6uwbHojSu3K4
         PYX0aXJzzwlhd/FjS+i1UQHJV4K9aU2lPBWUaEdVLJdAHEtnElW4Q8Ywfjvof4saBEui
         bp7tYICcWiY/JlGIC9jTb38aaPayy1enF6iySasvuYZU38AoruFdeCSv1ZU+V0scWs5j
         g0HvjQjCrRv8r/gXvzwpsiu/IYlWSf23xuNcJRKmXe51A3I7uH9N/cP00ui0XKIKhX7R
         t0aWRt0VYoh2Vr7I6mZ3ia4fJd4j+pga9i8M3moFd965EWGHBMWZyYE+XfHkZ24jTAH9
         xmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xG2aDXbk+7lS8x5EjusgY20hYahP7LqA2MEWt2qEFQg=;
        b=LVj6WRLcuUgVc4hTtM2se3hCb1fYmkaRYT9emt/a1z9PbeBX4EfQ86b+U97EtlIq7I
         +IdWuy8gCOONnz7pVHWwkLasmLY4KGuf3PYe1HbTsRlcPZVbfaT8z1vjHczDzCfEeFhU
         dKMMG9mqX+TTPqGaaFalwtnTJ5NVyjN44xqaeWfG2anHGNuHoYYE90XW+43OeTncVgGL
         2LBpEnnLXb3HFc9h0a8twF9+yUX6Rs0jTKxJgsCaX3qRHzCUlzHq4T3rfTNMu+2/ify0
         xzyD9x+AAoHU589wjma/W24xxbODjoc6T/XM624XvVdJ8utVrakKeAayKLKFN1uctwlj
         ZIcg==
X-Gm-Message-State: APjAAAXp8HBFVEI1UtFYBb6I3XlzMHzZMNh6+bFuPJlgFvbJMZtHqn/j
        Xf95I786hZfak/1rCwHioxgNkvRSFRDQsHFx+PiHaA==
X-Google-Smtp-Source: APXvYqwMoTFtfzAlLfm+cjZJLsFbMrlkXXbp7molX5RwDsFi3ZKE/4zf6+oFkHrUQfBuDsMUIj8tH0ZjBWtBZE/TIaM=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr3865638ljc.161.1576103348723;
 Wed, 11 Dec 2019 14:29:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <pull.463.v5.git.1575740863.gitgitgadget@gmail.com> <20191207194756.GA43949@coredump.intra.peff.net>
 <95ead4b6-21bb-1aa2-f16f-888e61a4e4c0@gmail.com> <xmqqwob2pzty.fsf@gitster-ct.c.googlers.com>
 <20191211171356.GA72178@generichostname> <xmqq1rtapwy1.fsf@gitster-ct.c.googlers.com>
 <CAE5ih78O4_ZPm1sxA=D9Ff-u3ga5Ax1CbvrFg0_E4KrRdUihDQ@mail.gmail.com> <xmqq5zimo7r3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zimo7r3.fsf@gitster-ct.c.googlers.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Wed, 11 Dec 2019 14:30:50 -0800
Message-ID: <CABvFv3L_oHqiGAcA1QyyQD-YZNeouvNVaqhp65qU2ea3TfuRRQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings
 in python3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Diamand <luke@diamand.org>, Denton Liu <liu.denton@gmail.com>,
        Ben Keene <seraphire@gmail.com>, Jeff King <peff@peff.net>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 1:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Luke Diamand <luke@diamand.org> writes:
>
> > On Wed, 11 Dec 2019 at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Denton Liu <liu.denton@gmail.com> writes:
> >>
> >> > On Wed, Dec 11, 2019 at 08:54:49AM -0800, Junio C Hamano wrote:
> >> > From what I can tell, Ben agreed to have this series superseded by Yang
> >> > Zhao's competing series[1].
> >>
> >> OK.  Let me not worry about this one, then, at least not yet.
> >>
> >
> > Oh, I hadn't seen Yang's python3 changes!
...
> > What do we need to do to get these ready for merging?
>
> Somebody needs to take the ownership of the topic---we cannot afford
> to have two independently made topics competing reviewers' attention.
>
> If Ben wants to drop his version and instead wants to use Yang's
> ones, that's OK but Ben probably is in a lot better position than
> bystanders like me to review and comment on Yang's to suggest
> improvements, if he hasn't done so.  The same for those who reviewed
> Ben's series earlier.
>
> It would make sure that the single topic a combined effort to
> produce the best of both topics.  If there is something Ben's
> patches did that is lacking in Yang's, it may be worth rebuilding it
> on top of Yang's series.

Sorry about the bit of communication mess there. I should have paid
more attention to who were chiming in to Ben's series and added CCs
appropriately. The timing was definitely a bit awkward as we were both
only dedicating part of work-time to the patchsets.

The outcome of discussion between Ben and I were that it made the most
sense to use my set as the base to rebuild his quality-of-life
changes. My patchset (plus one missing change I've not sent out yet)
will pass all existing tests. I will take ownership of this merge,
probably as a separate patchset.

-- 
Yang
