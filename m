Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA55C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F4F2192A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjO+uTVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394956AbgAPSBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:01:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37344 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgAPSBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 13:01:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so20226791otn.4
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 10:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Na/O/h9BB2J641e0Aq7ZUueBpc1V/82sjeD9Y0iqbyo=;
        b=mjO+uTVMl+KMdNEwcozH9FRFfalCUAr58uliKxHDIO8HH1NRxOdEcgvonIm0fa1uPU
         zww8NcnO9euwkKrfA8rrVCiZGZEDy7Sp/aJhdqcHo3DVAZGKqO7wOScrt2ZZ6A6V/TaV
         3+TjKzpFsCMAGPrl4M6/CNs3wK9B0aklrUdBFMzywKD6HShI4EI/s9CoIBzHuIpd6Ll7
         y9hAhrAweUZEg7pOHtjGCbWZFAZVHVRRoq5qN2F61oqU1r/IkfgbPYlISU6XJBElZlIj
         qACPyjdfSeYLrbHNoGgicAoL/xL9v+erQGFuqZ4jXZE0agC1DZRZQSn70I4JFfEh18vZ
         tTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Na/O/h9BB2J641e0Aq7ZUueBpc1V/82sjeD9Y0iqbyo=;
        b=ACz5nvgyMxSuQ948sSj79mwbcSPpoyU1CDg5Pa/PqS03813woBCDDFSOxl+l2WbGvb
         Y0BQzPuERlJMNJW2sZfXOQAcU3HKL4OEG6DnQmQkzWKMh+WXzbq9t+KSv9kW2To6jpuK
         W/sCRTljqq0QGYMZxyGigYDV59Ge4RAwNiFZu39g/+tT4gz0jgxdn55hx5PVZC3PQlhn
         134Md9RCrr2AhzdGKywbK1fZGK1aeGY1kL6TDnTXMS0ZwB1TGk1bDOpRP4km1j4RUxVX
         7RgQ8TFtlrmI4Df3F9ddlYVuEJkz/TZd9CfLJEqa2rdMxBsTowd6DtBIlMgpCwgGWY0P
         tv6Q==
X-Gm-Message-State: APjAAAWpLfMeCDoL4ZEWNQqmKXOUilt7xeVE5989KH16EwK5USmn+6if
        xyajIDr3rE+WeRZHV2LXYrpbse43BAttFd4+up4=
X-Google-Smtp-Source: APXvYqz/V3x+HfvUTz1sXvjjtV09YTUqyRcZ2vwTCgEPPqggnsW/mD7R6ZT5A4Uz7lyA4ta/PDphN0aiN9LLi+RzYu4=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr3077245otp.316.1579197695356;
 Thu, 16 Jan 2020 10:01:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
 <CABPp-BHywo5Js0YGwDykV8G+=Y6-M_Wh3sE5BvC-7zArJd1rLw@mail.gmail.com> <e008da66-defe-d2b0-410b-64b7754b9c6e@gmail.com>
In-Reply-To: <e008da66-defe-d2b0-410b-64b7754b9c6e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Jan 2020 10:01:23 -0800
Message-ID: <CABPp-BFX2ER9aqaHi=sbaSppGobCOisR2a8z1mTGqbQ8xS_WCA@mail.gmail.com>
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 5:23 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/15/2020 7:38 PM, Elijah Newren wrote:
> > Is there an inverted phrase corresponding to "the gift that keeps on
> > giving", something like "the punishment that keeps on punishing"?  If
> > so, it would be a very appropriate description of dir.c.
>
> At least we will continue adding tests until we converge towards
> correctness, and the behavior issues are even more contrived and
> special case (like this one).

This doesn't seem any more contrived or special case than most my
previous fixes for dir.c...

> > Yeah, I still have context.  I even think I've got an idea about what
> > the fix might be, though with dir.c my ideas about fixes usually just
> > serve as starting points for debugging before I find the real fix.
> > I'll try to dig in.
>
> Thanks! I'll try to review it carefully when it arrives. Good luck.

Man, I'm such a bozo.  It turns out, for once, that my idea for the
fix was correct but after digging a bit I realized that it was
essentially a bug I fixed not that long ago once already -- and that I
myself re-introduced it (for a slightly different case) in some
commits where I used some strongly worded disgust that "this bad code
structure is going to cause someone to mess up in <this way>" and then
I made that exact kind of mistake I was complaining about in the
commit message...as part of that EXACT commit, to boot.

At least it'll make for a fun new commit message explaining it all...


Anyway, I'm going to pull your commit into my series so I can put my
fix on top, and lump it in with Peff's two patches over at
https://lore.kernel.org/git/20200115202146.GA4091171@coredump.intra.peff.net/
since all these patches are basically "more fill_directory() fixes".
Let me know if you have any concerns with that.

Elijah
