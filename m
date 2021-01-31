Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645D1C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 23:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3598864E3C
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 23:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhAaXLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 18:11:49 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:44956 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhAaXKK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 18:10:10 -0500
Received: by mail-ej1-f44.google.com with SMTP id w1so21412758ejf.11
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 15:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSP+zsXI/yk2TddLagVzu10kbxRYJpHHuJ9ry/tE/Hs=;
        b=rztNSGFU1P30fxMjHx+ryNIHe0ov4+PhUBpkqW/raniylc1hFzD79c2A5p0APhWLDM
         235J7nowIro/fT458F7lPmfYPEK1dxpLDh5c2/7gZblST5/wYCF3Zhw7MGDjXUPKLtok
         id7GAd2n60lL697sDIhhPT/qnOjZX4F/2SjnzcZehL9G56FntGRmFTtpoQRkF7tavuZC
         cgXySuTH2J9HMCt3MEqkvMFHteF9gmUkPWlPFIQDLwBJCChP6bS2ffnPoiY23MXeu/ia
         NScsbEQ4eKjB4ffMPplvILmMTXp67rVLOqAv5MG5BtVQJFb5v55tZRXRrBYW43wxVSI6
         +tMg==
X-Gm-Message-State: AOAM533pxVth6yZeelHlqYcrKbzzI450edxmxjsvrphyiPQ+qfe1zAyk
        6/RQNF7C2nUTqbc+ruo0TdO71csNTpeg6bUgK+U=
X-Google-Smtp-Source: ABdhPJzpfEp9DpKBRDmQxziJJZhanbn9V4pgNHAc4HmvF8NIgLnS6bpn1VZMlbhd/40wRnz4fSWs0KS36YIebi194eo=
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr14452018ejk.311.1612134567715;
 Sun, 31 Jan 2021 15:09:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
 <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com> <CACPHW2X2UGAVmNM+cHXs6dwVfZbgLFZ0iUGU89h04H5czAt1Ww@mail.gmail.com>
In-Reply-To: <CACPHW2X2UGAVmNM+cHXs6dwVfZbgLFZ0iUGU89h04H5czAt1Ww@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 31 Jan 2021 18:09:15 -0500
Message-ID: <CAPig+cS-hnwp2HjkkFPeJ4aibFHnJ0VZq0DSVgdWB0H_q5=oXw@mail.gmail.com>
Subject: Re: [PATCH] status: learn --color for piping colored output
To:     Lance Ward <ljward10@gmail.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <ericsunshine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+junio +peff +duy +dscho +rene]

On Sun, Jan 31, 2021 at 1:49 PM Lance Ward <ljward10@gmail.com> wrote:
> On Sun, Jan 31, 2021 at 1:31 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, Jan 30, 2021 at 10:51 AM Lance Ward via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > diff --git a/diff.c b/diff.c
> > > +void set_diff_color(int use_color)
> > > +{
> > > +       diff_use_color_default = use_color;
> > > +}
> >
> > This new API for setting `diff_use_color_default` feels a bit too
> > quick-and-dirty and assumes that the caller has intimate knowledge
> > about when it is safe/correct to call the new function. Did you
> > consider the alternate approach of having wt-status functionality set
> > the appropriate diff_options.use_color value at the time it drives the
> > diff machinery? For instance, as a test, I added:
> >
> >     rev.diffopt.use_color = s->use_color;
> >
> > to the functions wt-status.c:wt_status_collect_changes_worktree(),
> > wt_status_collect_changes_index(), and wt_longstatus_print_verbose(),
> > so that the `use_color` value from the `struct wt_status *` supplied
> > by commit.c:cmd_status() is automatically applied to the diff options.
>
> Originally I tried to use what I thought would be a much more appropriate
> method which is to simply let the --color flag set things the same way
> as the config option status.color=always does, but I noticed it does
> not work the same when piped.

I'm not quite sure what you mean. How exactly did you originally
implement --config to accomplish this?

> For example the following produces full color output:
> git -c status.color=always status -v
>
> However, running this colors only the status, not the diff:
> git -c status.color=always status -v | cat
>
> Right now I can only get what I expect by running:
> git -c status.color=always -c diff.color=always status -v | cat
>
> This appeared to me to be inconsistent behaviour [...]

At an implementation level, this behavior makes sense, but I can see
how it might be confusing and unexpected from a user's viewpoint. I
think the approach I suggested of patching those wt-status.c functions
to use:

    rev.diffopt.use_color = s->use_color;

would fix this inconsistency, wouldn't it?

> [...] and lead me down
> a path trying to figure out where the color was being disabled which
> made me realize that the status command shares code paths with
> the commit message and porcelain output.  I wanted to be very
> careful not to do anything which might break either of these in some
> unforeseen way which is why I created the function.

I see where you are coming from and understand the desire to isolate
this behavior change, however, I can't shake the feeling that this
sledge-hammer approach is going in the wrong direction and that the
fine-grained approach I suggested in my review is more desirable.
Having said that, I'm not particularly familiar with this area of the
code -- and had to spend some time digging through it to find those
functions in wt-status.c to make the fine-grained approach work -- so
it would be nice to hear from people who have spent a lot more time in
that area of the code (I Cc:'d them).

> If you feel existing unit tests would mitigate any issues with commit
> messages and porcelain output I can try going the route you
> suggested instead?

I doubt that anyone on this project feels that the unit tests have
sufficient coverage to make any guarantees. However, for changes such
as the one I proposed which might have unforeseen side-effects, Junio
tends to let the changes "cook" for a while in his 'next' branch
before promoting them to the 'master' branch so as to give time for
unexpected fallout to be discovered.

> Also if you agree the behavior of status.color should be the same for
> both piped and not piped output I could add that to this patch as well?

I'm not quite sure I understand your question. Are you asking if
`color.status` should imply `color.diff`? If so, I haven't thought a
lot about it, but I can see how the present behavior may have a high
surprise-factor for users, so it might be worthwhile.

In fact, I can envision this patch being re-rolled as a two-patch
series which (1) patches the wt-status.c functions to do
`rev.diffopt.use_color = s->use_color` which should make
`color.status` imply `color.diff`, and (2) adds a --color option to
`git status` which sets `wt_status.use_color` (which would then be
automatically inherited by the diff machinery due to the first patch).

(By the way, `status.color` is a deprecated synonym for `color.status`.)
