Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD31C433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE09E238D7
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 02:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbhAPCvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 21:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbhAPCvC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 21:51:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F12C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 18:50:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r5so11635353eda.12
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 18:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBXbVzMJMplcbJoqwU5XZQzfh8j0NxH9CKWnruZHIMc=;
        b=eqEJ5N7iAJ4F7au/bLOz/jE1F+z6rvTL7ufKVhdR6a6xjQCHhN+czyGjvoSyJiVUHv
         Ce/PwiLN388+R2sbG+9/X0URMFNOLKzFgED4EF3joi23PgqUF52tkzuO556oKh7ShCzL
         dVhy15KBEV/1ZyarbiVcQc+Ej8eFrXqdls6RhCoV9sj/hSPZdPtYqF1uPSOfnYdPlbum
         Rnnql17F2/ISSG5GRnl7G7/iWtMLtTVYkvjUYtp/iR06WHp/pbMs0JgiH1BDAaSoZrvX
         9lrL6WpPyXK0DzF6e/FJAAXFNidAV9QRloBo9GufR38Ljum+MTgEYgPSmclxHumLaem7
         5sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBXbVzMJMplcbJoqwU5XZQzfh8j0NxH9CKWnruZHIMc=;
        b=uTn9s13fvJW3F93u0mM5OBol7n2GfUeBn6FOFW3S9S7sPxjKbQ/NKqpnx3eRObAeNT
         z7G0vWtFCwd6x4uXpmyeJOdDyPC8ODWYmErV/pA8gc986TRk8/KbJHiLRcdBulVSumST
         yJEQoMfs9m5UrhupTNFjpUtyM2xWuWcSegd/O5UogxmAMaEEsNIHkq0C9in/OhaE1/kM
         4B57dZDLqvNzaShtV23Fjwc+rfhUTQRur/w0FYCMoj2U9i3xT6VEKRqol0xDirPpkRXr
         15rsnhGWYcidAWtsHZyJgraAFbFDhimeBJOk0heR3WVwGmbb4BIkPU9IopNP497gIkhf
         MD1w==
X-Gm-Message-State: AOAM533K5Q79WDWZjELB9cRnJm8pHM6Y3+FOQ0h3pZ+40o8yPJoowKLw
        wPkKiyejDegGUgs48DiDoh5715vzGRp68lmjqDjrEOcll2EHIA==
X-Google-Smtp-Source: ABdhPJw6GVAEPn7jqEHhwf76T8nLoWN+FAZAGpDJtXxU1eQS7W86+m9lEp1XRaGPpApXcJTfHwLdVnmSrj7Ja/MHd5w=
X-Received: by 2002:a05:6402:b5a:: with SMTP id bx26mr11669637edb.339.1610765420721;
 Fri, 15 Jan 2021 18:50:20 -0800 (PST)
MIME-Version: 1.0
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org> <20200722074530.GB3306468@coredump.intra.peff.net>
 <xmqqmu3r5umr.fsf@gitster.c.googlers.com> <20200723182549.GB3975154@coredump.intra.peff.net>
In-Reply-To: <20200723182549.GB3975154@coredump.intra.peff.net>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Fri, 15 Jan 2021 16:50:08 -1000
Message-ID: <CANiSa6iV3WbS9VQdUQ-eF=dcz-mmQXvyckGJL8ZhpgFYc7U_TQ@mail.gmail.com>
Subject: Re: Improving merge of tricky conflicts
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 8:27 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 22, 2020 at 10:26:04AM -0700, Junio C Hamano wrote:
>
> > > The big downside here, of course, is that it's showing the diff for the
> > > whole file, not just one hunk (on the other hand, I often find the
> > > trickiest conflicts are ones where the changes unexpectedly span
> > > multiple hunks).
> >
> > Yup, I often find myself comparing the base part (lines between |||
> > and ===) with our part (lines between <<< and |||) and their part
> > (lines between === and >>>) while looking at the diff3 output to see
> > what unique change each side did, in order to come up with a
> > conflict resolution.
> >
> > I do this often enough to wonder if I should write a small "filter"
> > that I can pipe a whole "diff3" <<< ... ||| ... === ... >>> region
> > to and convert it into to diffs, but not often enough to motivate
> > me to actually write one ;-).
>
> I would definitely have found that useful before (usually when one side
> made a tiny one-line change and the other side deleted or drastically
> changed a huge chunk).

FYI, I added something similar to Mercurial recently. Instead of two
diffs, it shows one snapshot and one diff. See
https://phab.mercurial-scm.org/D9551 for details. I've used it for a
few weeks and it seems to be working pretty well. The drawback is
mostly when you want to keep the side with the diff and ignore the
other side, since you'll then have to drop the lines prefixed with "-"
and then enter column-selection mode or something and delete the first
character on each remaining line.
