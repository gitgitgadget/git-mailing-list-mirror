Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D7C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 22:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDDB206CD
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 22:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX43fPJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCLWG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:06:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45460 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgCLWGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 18:06:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id e9so802897otr.12
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpREGZLXjJnxxq/6yqXD0/SV+94rl6883IqKHzdvXzM=;
        b=BX43fPJbH78rTOyMGpEbdMfXuNU70+ZH1BIyWA7dHcI6P53NaU9nFsskt1SP9qXaDF
         yWixWBT1xsxC56FmeAvwX7z5ERekmMCE+nBtUUQOShGF/AHcRv4GX1Pwt2/J/B/jowEw
         8jBzmSQe0VffWRYG08DN6SXyqMWrW5pBGv0EtLLM2CohevYwtKKpsuPIqLVSGPCwuRhB
         HQ7gJPjainJQmW73Sxbh1EQB9lCIDru6KxteEy+yWWTVOQepLSUyGdt6Edmkx6BBu/yC
         iqrARVQKlROxlYyd/Rh1I2Gwau/pjcdavfoVRshmN0weZuzoSsVT3BqsCArxaPr5zgUF
         uY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpREGZLXjJnxxq/6yqXD0/SV+94rl6883IqKHzdvXzM=;
        b=rSceJJSkKFY+hePIe9bqJ0W4S+jTG1c9aTm0YxzCnCJ1Fren8wWLLvqm0Bz7lGKdcC
         Wgo50DigHgrzLfNEPxb9p+Fdm0ciYzMcMT+6fJa7eTc4qDfLNMWq2bRQjdrqfI14zo2z
         A/dr3/Z+9n8a70Kw71LcRhwZv3uZxHaVxg3E5sx+RjWszOv3HPyPYfPcW+k9Cq6JKlHb
         o9zvqvBaQK7WnUmqarUfCxgKbSllbB50fOOq1JwsdotK1wwNwJnOdQtncZXIEndjLC1M
         Q0zOUaQY7zYEX073edwcvm/upYfHrf4Es65u4398c0ZIT0yBrksm+XHVJ6usDBzYH/lh
         sP8g==
X-Gm-Message-State: ANhLgQ1Rh+g6Yk7uI5RMhSyv43bYT5rnIV0mxDa7q/0WvIgOZsww1uMD
        O140XTtcaDgpXAYcUqeFKHlD/qv3UyC4m74EHbRk/A==
X-Google-Smtp-Source: ADFU+vstXcWBfXM899o1chUzddlAkYb9wv3TPhISaHirbk2uvAeM2UTnJ/rzLfgRmpRnm5qk+eSMiSyihihCT1xIGE4=
X-Received: by 2002:a05:6830:1ad4:: with SMTP id r20mr386678otc.316.1584050785043;
 Thu, 12 Mar 2020 15:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com> <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com> <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <xmqqftedfkvy.fsf@gitster.c.googlers.com> <CABPp-BGvqUEDoj6_mUAsSVeS8+h5ruCFcMTENtf5LY2XWKVj-g@mail.gmail.com>
 <20200312203718.GA870787@coredump.intra.peff.net> <xmqqo8t1e01r.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8t1e01r.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Mar 2020 15:06:14 -0700
Message-ID: <CABPp-BGQ0anV7P19PF6NgosF4psQ=TQp=8B6dt2U+ENE2Ubjew@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 2:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Though in this particular case, I don't mind too much just leaving "am"
> > as an alias for "apply" (it was actually the first thing I tried when
> > writing my earlier emails, but I'm probably not a representative user
> > there). Putting that in a release, though, may mean supporting it
> > forever. :)
>
> Yeah, I agree that what used to exist only in 'next' and we chose to
> remove it before it its 'master', does not deserve to be supported
> forever.  So let's scrap the "am is taken as a synonym for apply".
> It would not help the old version taken from 'next' grok a new
> configuration file that uses "apply" anyway ;-)
>
> > I guess like your email I'm going back and forth between the two
> > options. I think that means it probably doesn't matter _too_ much either
> > way.
>
> OK, let's avoid screwing it up even further by doing no more damage
> than merging just the three fix-ups we discussed recently.
>
> The fact that jrnieder runs 'next'+patches for his $DAYJOB users
> makes me hope that there may be other organizations that do the
> same, and cooking in 'next' would mean somthing, though.
>
> We may want to think of a way to strongly encourage those who are in
> charge of choosing and maintaining the versions of Git that is used
> in their organization, whose operation depends on the healthy future
> versions of Git, to run 'next' or at least 'master', to stay ahead
> of the released versions.  Some education and advocacy is needed?

I agree, it's super cool that Emily and Jonathan distribute 'next' to
their users at Google and provide us lots of early feedback.  I wish
we had something similar; currently, the only control I have is
requesting that some documentation file that includes a recommended
minimum git version be bumped to something newer, and I usually need
to provide a reason (I can't just say, "It's the newest release").
Other than that, developers install whatever version of git they like,
possibly unaware of what's in that documentation file.

In fact, not having a way to control git versions is leading to
discussions of spending my time to not only fix issues in git (e.g.
the read-tree -mu HEAD problems with sparse-checkout) but also writing
some separate program that does that piece independent of git so that
we can work with a variety of git versions.  Such a pain...does anyone
know how to educate me to advocate to the company that we come up with
some more controlled git version?
