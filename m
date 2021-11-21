Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74087C433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 01:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhKUBfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 20:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbhKUBfx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 20:35:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2F4C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 17:32:49 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y12so59917027eda.12
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 17:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxNInZzdYclZiibPpQ5VSvNIk62K7i55NUnRDsAws4Q=;
        b=Wuj6Qr+lIKsbsartxGGga5n/nHq4kiCTcOoru55oq2gx0qLKeP3s/wIXgued5v9RT2
         hP/xzuMqK0JTZ1OzJZcrYAim3BUIXr2uVvT56euGYn5R+zMO9IiDjD4NWEy7a9wl7bz0
         vgkPhGExPLvfHI6TQD2orTM6kwzE/NKmSdiGTCK6U8Y1uRF3J08vKRuPtMo7u8MJ9fGL
         B1OFXEaKX+p0VC6Dh3XHFxtC1NaMB9dxG4N20yYfPXgH82FZjpaaw7E6J4H+ojEGBe8y
         ze5syLDnunN/4v/QpbtmblP+8wDVk02Z/+wMUK/qysE6jFm7o0P79gUeoAYWP3EAGHhq
         ESow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxNInZzdYclZiibPpQ5VSvNIk62K7i55NUnRDsAws4Q=;
        b=WHGfiMsz83OlUhOR9fBHoMLFc9XnPoAJmXOXsxGSZrmFCQ81wjTkxo7NAkd2VTfYu1
         9AN25loWTbyjUeZVZ1ewIdMBFQ+YmE83sgTWx+p9L/1yQYmx65yG/DXqka8JsjRcXTiI
         oBY5MgZdObKVLQ5Il/k5VvsmkBBr7hdgkc2FbGvwwPf5gSsRBtBlhwCg0TRbjcO7+1Hr
         hTSDmbrG2m3oz2o0ijyine7DlWTsPuVsoUislsV14z7zBGPt1a+IKLu6vYWb9iUKLQ5V
         wgYADFFRldzkoFHknvwAi/ySXFw2ajGb7H2MCbRCJq1xNrDP7ledRjTXfWmNMkX3P8gW
         95DA==
X-Gm-Message-State: AOAM530qlOTfl2XhXIWZr2wHFpJf7Q4wKN8LCCP+tQgG/Cd6zVammYsN
        7JvjTcG92yAKYSVqpCPMc1EMAT/BiDtqMdBVz1pN0K2J
X-Google-Smtp-Source: ABdhPJyDKpvF6aQFkN/dk/62rPAJhpT07Ipr1oDUz4D7DOpazTqvsFzLRfQA0ovecQwSQ2kvolhRGT8yc77nd2MbA5I=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr44172293edv.62.1637458367633;
 Sat, 20 Nov 2021 17:32:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
 <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com> <a0b6a152c754862323e9a5b89ad43ab34b6548f7.1634332836.git.gitgitgadget@gmail.com>
 <YXcZPxYlRLEEwU16@nand.local> <086ad119-0739-5ce0-af99-0b1ab1c3d484@gmail.com>
In-Reply-To: <086ad119-0739-5ce0-af99-0b1ab1c3d484@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 17:32:36 -0800
Message-ID: <CABPp-BFSOyGZom-Cf_7++8Yecw76e+E6O7iYA7okkfCwwXXpCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blame: enable and test the sparse index
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 9:17 AM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
> On 10/25/21 1:53 PM, Taylor Blau wrote:
> > On Fri, Oct 15, 2021 at 09:20:35PM +0000, Lessley Dennington via GitGitGadget wrote:
> >> From: Lessley Dennington <lessleydennington@gmail.com>
> >>
> >> Enable the sparse index for the 'git blame' command. The index was already
> >> not expanded with this command, so the most interesting thing to do is to
> >> add tests that verify that 'git blame' behaves correctly when the sparse
> >> index is enabled and that its performance improves. More specifically, these
> >> cases are:
> >>
> >> 1. The index is not expanded for 'blame' when given paths in the sparse
> >> checkout cone at multiple levels.
> >>
> >> 2. Performance measurably improves for 'blame' with sparse index when given
> >> paths in the sparse checkout cone at multiple levels.
> >>
> >> The `p2000` tests demonstrate a ~60% execution time reduction when running
> >> 'blame' for a file two levels deep and and a ~30% execution time reduction
> >> for a file three levels deep.
> >
> > Eek. What's eating up the other 30% when we have to open up another
> > layer of trees?
> >
> I'm not sure to be totally honest. However, given these are both pretty
> good time reductions I don't think we should be terribly concerned.

It's not something eating up more time in the sparse-index code; let's
look a bit closer...

> >>
> >> Test                                         before  after
> >> ----------------------------------------------------------------
> >> 2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
> >> 2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
> >> 2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
> >> 2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
> >> 2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
> >> 2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
> >> 2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
> >> 2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%

Time was ~0.55s for the full at two levels deep, and dropped by just
over 0.3s in sparse-index.
Time was ~1.05s for the full at three levels deep, and dropped by just
over 0.3s in sparse-index.

So, the sparse-index enabling saves us the same amount of time, it's
just that the overall execution time for the non-sparse-index
comparison point goes up.  Saving the same amount of time for the two
cases seems intuitive to me; both cases get to avoid looking at the
same number of index entries outside the sparsity paths.
