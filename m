Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE54C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27D62222C
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mulQqJGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJNR6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJNR6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:58:03 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D746C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:58:03 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x1so61614ooo.12
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BksVEocPZzmr/dBGOyL+SYRTCQA0JxBY2cfF7dsqi0s=;
        b=mulQqJGVQ2g/Ev/o4i0aLOfuEK1D6eZyzI8QhjqvsHEQ9SJAFT3EToc4FR1VzwLLW3
         +6DOFDIZI1KTSdcoWvjCfHesN97gLlvEBuSmP5drvtBEhz/pgk2snLENa0xa8S+Cejiz
         drF4InNjLh18aWxwJXXt4XCIY4ljpTBGtOE6jkC7gCtUqFbVKs9W1AeVxiCtWbvz9cC1
         ANh9iFXckZnO7DQ0gConlLXU3a7H9t+FZrHq8Y85blE4Ri0rbXNZ+iUKNfBSmk5oirVH
         135VVJbhnCwdFpnQqFjl4MiOhnRP2jwxCRpkmC/32VRV0qayXjcLVu+4qVm5MpOFDCS6
         7B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BksVEocPZzmr/dBGOyL+SYRTCQA0JxBY2cfF7dsqi0s=;
        b=sKPbdAdqghKWIq0E8YTZO39NFHjRwQHuqX66LgfM/AfP7RayL77I+EVJ54JHNKN0R/
         L/ctUq6QQaDzxKmIsy8wOXd/nGeU7JMF0UxmoEUQtXh3e6NIuU4yAsp39UHLQPpc/TvE
         FtbNzLi/qOa4vX8cncckP+lhGqOhrBNxq4fPUEE3JDC7HobYh8az/4E2Rh/CijRKB9sw
         BkYg6Lb/1Zl5HG+eYqaStuADRJnEKu1L0yIe3aqFxxBGlxo54h7o6c/yGEQ6xQFfYnPX
         Au/e4xEXcrvcOpVEK4WUmNa2guhBKUo16GjYjoPVxHsuScAjqyCwtxDG6AACn09yY991
         bN+w==
X-Gm-Message-State: AOAM530IY81k1wBx/eQfSV7aBCrRp9KKFhFs/ltq+FHBWBeb7+RlJidI
        G6AsWb6asisXEgydetPNHKO3K+2NyBvqB4bEUFc=
X-Google-Smtp-Source: ABdhPJw0XmhTmaOj0D8o1i1mrBVJZbBoviFFFv/7yQ/wZ8W+wwFkcKC/II+Wu5DmZexydx/S0gt/S5alPXcdOb1bMcQ=
X-Received: by 2002:a4a:1e43:: with SMTP id 64mr320976ooq.7.1602698282971;
 Wed, 14 Oct 2020 10:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <85a4ca164a9f665016d4aad0f29cbef6f62f36b0.1602616786.git.gitgitgadget@gmail.com>
 <20201014165329.GA21687@coredump.intra.peff.net> <CABPp-BERKaLTLFjXYSo2mbT+3RSMR+5M7pzPmHH-0hNP2KFMOA@mail.gmail.com>
 <20201014175512.GA24279@coredump.intra.peff.net>
In-Reply-To: <20201014175512.GA24279@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Oct 2020 10:57:51 -0700
Message-ID: <CABPp-BHM3PdYGv12wAVuo22V2L97=9Sp3mpWPbqFeKDbGV24Ng@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test-lib: reduce verbosity of skipped tests
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 10:55 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Oct 14, 2020 at 10:39:01AM -0700, Elijah Newren wrote:
>
> > On Wed, Oct 14, 2020 at 9:53 AM Jeff King <peff@peff.net> wrote:
> > >
> > > On Tue, Oct 13, 2020 at 07:19:46PM +0000, Elijah Newren via GitGitGadget wrote:
> > >
> > > > From: Elijah Newren <newren@gmail.com>
> > > >
> > > > When using the --run flag to run just two or three tests from a test
> > > > file which contains several dozen tests, having every skipped test print
> > > > out dozens of lines of output for the test code for that skipped test
> > > > adds up to hundreds or thousands of lines of irrelevant output that make
> > > > it very hard to fish out the relevant results you were looking for.
> > > > Simplify the output for skipped tests down to just showing the one-line
> > > > descriptions.
> > >
> > > This last sentence is inaccurate in this version, isn't it?
> >
> > Maybe I could make it clearer, but I think that it is accurate[1].  If
> > this wording seems confusing, though, I could simplify the commit
> > message by reducing the sentence to "Simplify the output for skipped
> > tests."
>
> Yeah, I wondered if you might have been thinking that. It makes sense in
> the context of the other discussion, but the single-line TAP output is
> not even mentioned here. And it might be worth doing so, because the
> real reason it is OK to delete this line entirely is that it is
> redundant with that line.

Makes sense; I'll update it to mention that, once the discussion on
how we want to handle regexes/globs/subshells for patch 1/3 is
resolved.
