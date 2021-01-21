Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AEDC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5A923A56
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbhAUUcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbhAUUb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 15:31:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F60C0613ED
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 12:30:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id 6so4515474ejz.5
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 12:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Rl/gKTCvJ1UxSCCnMXmtXggHglVbtnoEaWuS60E+fY=;
        b=XCLaS680BpKNMPQ+OCfHfNTtt7oMVkFz0uOTVpe8cNvfagTZO+LaHraFw88+zCwP22
         UmlSfhZoEAJ9iqb0VDqkKGUdCD0g/36Kow/YABAqNL4t/dHZhgp6QFO7SQA0Nf51iZhn
         Av2Swvq6k1xJpDDLxEGUGcS2iVuTb8HGEdkPcE/6eSPp5oAZiHw28zJP6/PzN6/qVFTP
         oOKyWl/95mdNBFEtpkgqZANMPfKt/iI9pDJfSOLU/AMyFj5E0u0bsyoxuGI1f7ZInJYz
         WvOsEHhTLxjP19sETTLmJe+dP3NTPF/qXaTXq8Bj7iaEJKH4fIF3Y4grmGwoZn0GQZ2m
         +oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Rl/gKTCvJ1UxSCCnMXmtXggHglVbtnoEaWuS60E+fY=;
        b=LH9L//EI5FaWyO/xcdpCYX/PGb8Xt6yHkVNeUaHz/G8WCbf4u1ffIJaxOfzhDIgZBO
         MYRhLD58sCUg99F497bl7p1uUATDEESKdqC/3VBfW/Pvuocz335xzyVmk57DMNo+NZN8
         Y4uGPoksyxiwppXfRay2+ncrXpGdB3gfinL70TYGaNXzWkWfNKBmBzWHHWottYzahesl
         3WcD9vl3cQrCoNOcbLBhJ7B89kVsRQX/1Zd4zgTStpVwhfLyQNlzuvHEOVC51RI3H7hP
         9rJIyV+Wew65BEKwzzgf550dIX26SMg+FZYwK5oX+AUoOzNRc9WHKsZQ9HyKIggGvJqM
         1aig==
X-Gm-Message-State: AOAM533Ez5dKEztGhkV7YH+RNIrAMVe8E5toHbXSzpB4WIVzm8qVCXHM
        RIomQUd7QbUczT3Nkv2MGqelto85EM0a9tm+IkA=
X-Google-Smtp-Source: ABdhPJwAREsANnn4ij28sNFDEg/Yv8g08tinkcOqW4VBK8thB8vOuDyB62BGWGlCTUQwuqb+RioyDgvBjxG1OCXx+NI=
X-Received: by 2002:a17:907:7346:: with SMTP id dq6mr858849ejc.237.1611261047963;
 Thu, 21 Jan 2021 12:30:47 -0800 (PST)
MIME-Version: 1.0
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org> <20200722074530.GB3306468@coredump.intra.peff.net>
 <xmqqmu3r5umr.fsf@gitster.c.googlers.com> <20200723182549.GB3975154@coredump.intra.peff.net>
 <CANiSa6iV3WbS9VQdUQ-eF=dcz-mmQXvyckGJL8ZhpgFYc7U_TQ@mail.gmail.com> <YAmPnfb/KMlqimhH@coredump.intra.peff.net>
In-Reply-To: <YAmPnfb/KMlqimhH@coredump.intra.peff.net>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Thu, 21 Jan 2021 10:30:36 -1000
Message-ID: <CANiSa6jsjrm-i+T1zSBMFqpUqy-PJpai39JtH47m=v1TO_fi4A@mail.gmail.com>
Subject: Re: Improving merge of tricky conflicts
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 4:28 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 15, 2021 at 04:50:08PM -1000, Martin von Zweigbergk wrote:
>
> > > > I do this often enough to wonder if I should write a small "filter"
> > > > that I can pipe a whole "diff3" <<< ... ||| ... === ... >>> region
> > > > to and convert it into to diffs, but not often enough to motivate
> > > > me to actually write one ;-).
> > >
> > > I would definitely have found that useful before (usually when one side
> > > made a tiny one-line change and the other side deleted or drastically
> > > changed a huge chunk).
> >
> > FYI, I added something similar to Mercurial recently. Instead of two
> > diffs, it shows one snapshot and one diff. See
> > https://phab.mercurial-scm.org/D9551 for details. I've used it for a
> > few weeks and it seems to be working pretty well. The drawback is
> > mostly when you want to keep the side with the diff and ignore the
> > other side, since you'll then have to drop the lines prefixed with "-"
> > and then enter column-selection mode or something and delete the first
> > character on each remaining line.
>
> I've used the script I posted earlier in the thread several times in the
> last 6 months or so, by replacing the conflict markers in the file I'm
> resolving with the new output (basically "%!magic-diff3" in vim).
>
> It is helpful. My biggest complaint is cleaning up the diff from the
> marker after viewing it. In most cases where it's helpful, one side made
> a large change (say, deleting or moving a big chunk of code) and the
> other made a small one (tweaking one line in the moved chunk). The small
> diff is useful, but the big one is not. And then after having viewed it,
> I have to remove the whole big diff in my editor.
>
> (It sounds like yours _replaces_ the conflict marker with the diff,
> which is why you have to edit the diff. Mine is showing it in addition,
> so you have to delete the diff).

Yes, that's correct. It replaces the base and one side of the conflict
marker by a diff (and leaves the other side as a snapshot).

> I think rather than thinking of these as expanded conflict markers, it
> would probably be a more useful workflow to just look at the diff in a
> separate command (so just show the conflicts, not everything else, and
> just show the diff). I suspect it could be made pretty nice with some
> simple editor support (e.g., open a new buffer in the editor showing the
> diff for just the current hunk, or even the current _half_ of the hunk
> you're on).

At some point it seems better to delegate to a proper merge tool. You
said that you use vim, so I'm a little surprised that you use conflict
markers instead of using vimdiff. I don't use vim and I've never
really used vimdiff. I still use conflict markers, mostly out of
habit, but also because I usually run in a tmux session on a remote
machine. I feel like I should try to switch to meld.
