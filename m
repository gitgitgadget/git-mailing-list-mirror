Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2CDC636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 11:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBDLcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDLcX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 06:32:23 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF66333476
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 03:32:21 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f10so8291138qtv.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uGPc4DQIUpXxxnllgkSU6+DGCR1reh+ODRR0nbsACqA=;
        b=nC4Gx1R6gzu3FowMQi5zLbq1mbCdfPKRsWAOgwtkYN99eBhyprofQ6DZU1ENoI8KTG
         iKKZUmXhqJ4Gs1f48ayeo6HYSyeU/Ccmr6/MtC5S9ZUGTuVojePI4u8aLFVOIf3yzHga
         Snkyjxg5YXAbgWdfosbx7UKcMMtQMlQ5+MNklR7TvD+kfQJGoTzzihZLiYDlfXng0aHp
         dCBIBWmDCjxcK5wxIrMZE8tzX3TRyC+PE+pEDt+whr+rVWIsuLnreAG4ow6HpTwV7071
         KwvQj626SpWC+W2yWieiYvDuggp9mVSnS/rWQfuih6vkUrN6ibA+7Eysbet4wfhGqxrv
         VsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGPc4DQIUpXxxnllgkSU6+DGCR1reh+ODRR0nbsACqA=;
        b=fpDWWGgGzg1EH/p28u+d3f5mKEYDJy47SYqPJO9pW2hoR0qtpIYSO7qemHKFGk4ss3
         TQVW6pl1oO7JaTCnUfdxZqy90DDSVhHWoflvGaGlZlJxgxepyC9Qd9P+x2NlGG9gUMzL
         9vnTcCchYtCE1FnYK05c1iN74VyO780RCZFKNd0b6yf7zvmCEFLiyx4Yfb1L7pHfDbXv
         Qm5KeZ1gRkLgTjeAMcCug5t6lcIhgmvU8hGfUReA/aQKGjTB1U2de0RTSxGl6uIJXUm0
         qbhm4zaUTA9tXefApVI4lKNEs3yhXxnRmIcJsdC4flvbiFknQTsdG5vEYLHk9cYClkz7
         uMDA==
X-Gm-Message-State: AO0yUKX6CRwF5cyLc/NgApeFJriEWFmb4NShfzE9Njh3Iw4dJn0sBFoU
        KrJJ28gkfRFyeUxh7kowJrz+C2qthg83FCAZiKzcbss0xWpU0g==
X-Google-Smtp-Source: AK7set/AMFw7vuUmSvpXsr5f+bz2n2kvsesrap9ocwq5I5apMONCfawaEzDAK87DCzl/bCMzde41gehFc3tqTsqk/ck=
X-Received: by 2002:ac8:5a81:0:b0:3b9:b778:da62 with SMTP id
 c1-20020ac85a81000000b003b9b778da62mr1395080qtc.268.1675510340835; Sat, 04
 Feb 2023 03:32:20 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net> <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
 <Y9098dyaTtiNk506@coredump.intra.peff.net>
In-Reply-To: <Y9098dyaTtiNk506@coredump.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 4 Feb 2023 12:32:09 +0100
Message-ID: <CANgJU+UJ-p54MDmQWYTEsdh_ss-q8TUEcqHFm568Lpfsy2dU+w@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     Jeff King <peff@peff.net>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Feb 2023 at 18:01, Jeff King <peff@peff.net> wrote:
>
> On Thu, Feb 02, 2023 at 05:22:37PM +0100, demerphq wrote:
>
> > I've been lurking watching some of the regex discussion on the list
> > and personally I think it is asking for trouble to use "whatever regex
> > engine is traditional in a given environment" instead of just choosing
> > a good open source engine and using it consistently everywhere.  I
> > don't really buy the arguments I have seen to justify a policy of "use
> > the standard library version"; regex engines vary widely in
> > performance and implementation and feature set, and even the really
> > good ones do not entirely agree on every semantic[1], so if you don't
> > standardize you will be forever dealing with bugs related to those
> > differences.
>
> I think this is a perennial question for portable software: is it better
> to be consistent across platforms (by shipping our own regex engine), or
> consistent with other programs on the same platform (by using the system
> regex).

Personally I think that while this seems to be an impartial reading of
the question at hand I think it frames the debate in a way that has
the potential to bias[1] the discussion in favour of a particular
policy outcome[2]. It implies that all other things are equal between
the two options presented, and frames the question as something that
comes down to personal preference between one form of consistency and
another.

But I am not sure that all other things are equal here, at least as
far as regex engines go. I think there is evidence that suggests that
depending on the system regex engine introduces long term recurring
costs that would not be incurred if git chose to link to a specific
library everywhere. I think it ignores the implications on the wider
ecosystem and toolchains. For instance if the behavior of git grep
differs by platform then scripts that might want to use git grep to
automate git become less portable, or more expensive to maintain to
work around the inconsistencies.  It overlooks the costs of training
humans (arguably low) versus the costs of training computers (arguably
high). It also assumes that being consistent with other programs on
the same platform is inherently beneficial, when that doesn't seem to
be clearly established[2]. It also assumes that there are only two
options. Maybe there are more. Maybe there is a third or fourth option
as well. One would be to use a specific library for internal regexes,
and let the command line use the system library by default. Another
would be to make the default engine be one that ships with git, and
that users that want "platform compatibility" should use an option to
get it, much as they would with -P to enable PCRE. You mentioned that
there is already such an engine, but it isn't well tested. Maybe that
should be changed.

I think that if you look at other broadly ported projects there is
evidence that owning your own dependencies makes a project easier and
cheaper to port to new platforms. The more platforms you target the
more room there is for inconsistencies and the more costs there will
be to deal with them. If portability of git is a goal and minimizing
the cost of doing so is a secondary goal then I would say that using a
specific library will make achieving that goal easier and lower cost
than depending on the system libraries. There would be a high initial
cost to do the switch, and then a low cost in the long run.  As far as
I know Perl is more broadly ported than git, based on the fact that
when we migrated to git a number of the Perl maintainers could not use
git on their platforms (Vax comes to mind), and Perl definitely adopts
the view that it is better to own your dependencies, and wraps and
hides system inconsistencies as much as possible to make porting as
easy as possible. So that is one precedent to consider. No doubt there
are many other long running projects with precedents in this area.
What does Vi or Vim do? What does Emacs do? Etc.

Anyway, my opinion on these things doesn't matter that much, I am just
a git user who happens to have a passion for regular expressions and
regular expression engines and I am happily served by the PCRE support
in my git build. So I can't answer these questions for the project.
But I do think the questions that need to be answered are more complex
and nuanced than deciding which of two forms of consistency is more
important.

Thanks for hearing me out.

cheers,
yves
[1] PS I do not mean to imply that you are *intending* to bias the
discussion. I think your writing and measured approach indicates
strongly that you intend to be impartial, but nevertheless I think
this way of framing the question does bias the debate.

[2] My thinking about the framing of this question is probably pretty
strongly influenced by a recently released report from the BBC on
journalistic bias in presenting questions of economic debate. The
report presents some interesting perspectives on how framing questions
and data can bias the discussion even though the person presenting the
data or asking the question actually intended to be impartial.
Regardless of your position on what regex engine git should use I
think it is a good read. Especially in this day and age of austerity
politics and debt-ceiling debates around the world.
https://www.bbc.co.uk/aboutthebbc/documents/thematic-review-taxation-public-spending-govt-borrowing-debt.pdf

[3] Personally I use git grep with patterns and the -P flag far more
than I use grep with anything other than a constant string. These days
I barely ever use grep, so to me what it does is entirely irrelevant
to what git does.  I suspect I am not alone in this.
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
