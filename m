Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60EAC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 18:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B30661934
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 18:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGCSSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhGCSSy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 14:18:54 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33490C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 11:16:19 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s17so15719767oij.0
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zeIicGb0TDyeLogabQGzotz3nuXpRlLW/1k8jELSEX8=;
        b=pjLLf3hme+8wZ3a/cBh1FU7eGc88VwTjUDvHzGc/hcn2+mFnxty6Oe/GvWBYBwAhRV
         50W//ALJSKrvdoEKCfJbW1OK9TeMrSdFzKH7JQGYqPFEpKTKjA8JTXrPIBE47cJerItI
         xXPFVktB/cNdjeyKqnmy2RFaKNJf/J/VAB8XZ7xg4da/5b/hw/UbaHumRGmA0WxDUK9R
         KQ7d+QXZiUpl0jazm6npP8/D0F1sB/cmPygG0zmos5Y2GWpHRGt4WE54PjHn9mgjnyf3
         NJmaHG33j814GM3sj0TSMTZcIDwnsLm82tPSoEczq+HXOKQRXRoTBQWFizD/7MdRsdH4
         bT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zeIicGb0TDyeLogabQGzotz3nuXpRlLW/1k8jELSEX8=;
        b=jUT9L/YWiItGxDOlqTi6lB0ytmKj4m8iW+rluePJvJRfMWZOfq7t0b71Ndot57ir6K
         LBIjl0cMf+ookzIfzIW4X2FwjVIVlyBDGMmuC6G3MCPX7MMUy7JuWoLCa7umS2NVaKxS
         l9KnFwXz6qspTYwl17l+gL5xF2i/oirgkK0f5/amka1oDwJbs0MfFqCaK5gbnaUOShj5
         D/rEDNf3Xyf0AAjBhcEePqaWJDJrtDcW/infJMVSrA+tUBYEOlimt+36PLTpDvGTkg4l
         3YEqZ5rS9p0+00CONFv5kl+a++J9z2eW8ynqP7sCeDMXJVajg0pZ+p3w3gcHCVvctQhG
         lPKw==
X-Gm-Message-State: AOAM5322R9Ry8Ucnv+xG7euJoFj3gGumAdxWlQwy0cFSEOOur4+k3GOM
        0U9mhO8n620U+TPVo0T9s5w=
X-Google-Smtp-Source: ABdhPJwyBAM5HfzqZK/CtAaW6T5MeJhTA+h2YG57anx2RCP98wvy1URNTHFC0VsZgT1isYIorpF/cw==
X-Received: by 2002:a54:488b:: with SMTP id r11mr2370605oic.116.1625336178309;
        Sat, 03 Jul 2021 11:16:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 6sm1552306oip.9.2021.07.03.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 11:16:17 -0700 (PDT)
Date:   Sat, 03 Jul 2021 13:16:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Message-ID: <60e0a9707e09a_2f7208f2@natae.notmuch>
In-Reply-To: <C19D6C61-D62A-4344-BA1C-A532EB4FEFFE@gmail.com>
References: <60df97ed24687_34a92088a@natae.notmuch>
 <C19D6C61-D62A-4344-BA1C-A532EB4FEFFE@gmail.com>
Subject: Re: The git spring cleanup challenge completion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar wrote:
> On 03-Jul-2021, at 04:19, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > 
> > [...]
> > Other than that, it's fair to say that *everyone* needs some command
> > aliases to use git. This past month shell completions have saved me, but
> > not completely. I can't imagine how a newcomer must feel using git
> > without any alias.
> 
> TLDR: I don't think young, first-time learners of Git would mind the lack
> of aliases. I cannot speak for people coming from other VCS's.

That's not the same thing. Of course a user wouldn't mind the lack of
certain feature if he doesn't know he is missing that feature in the
first place.

Humans went for thousands of years using luggage without wheels, does
that mean they "didn't mind" luggage without wheels? They had nothing to
compare it to, so they of course didn't complain, but that doesn't mean
they were "fine".

In order for them to know if they mind it or not they would first need
to try them.

> ------ Long Version -------
> 
> Hi, maybe I can help bring some perspective on how newcomers view and use
> Git. I help run an Open Source club in my University, and one of the first
> things we help a lot of new contributors with is teaching Git.
> 
> I have conducted multiple workshops over the last two years, so I have
> some idea of what the usual struggles and pain points are. I also have
> some recollection of what it's like being a new user.
> 
> Most of these new users have never used any kind of VCS before, so half
> the problem is the overload of all these new concepts of branches,
> checking out, staging area, committing, pushing, pulling, etc.

Sure, that's understandable.

> Users are not able to properly map the name of these commands with what
> it actually does. Most of the issues stem from trying to memorise these
> commands as a series of mantras and applying them without knowing what
> is actually happening.

I recall using git that way a long time ago.

> Users are confused about why there is an "add", and then a "commit".
> It seems conceptually similar to them. The difference between reset,
> restore, revert (and even rebase) is also a pain point, because those
> words sound very similar.

Yeap, I remember that.

> Combine the lack of understanding of what Git is actually doing, with the
> fear of losing work, and you get the perfect storm of a difficult
> experience.
> 
> For most new users Git is unusable, unless you explain to them the right
> mental model of Git being a graph of immutable commit objects with
> pointers to access their contents. In my opinion, trying to make this
> model more transparent to a new user is the best way to improve their
> experience.

Sure, I see those pain points, and I have sent plenty of patches to
improve that experience, but none of them have been applied.

> What new users do not have a problem with is a lack of aliases, because
> they carry no previous expectation from other VCS's, as Git is always their
> first one.

Sure, when they are learning git they don't need aliases, but after they
become fluent and can do some basic workflow without looking to cheat
sheets they *immediately* would benefit from them.

> I can imagine aliases like 'co' only adding to the overload of
> information if an instructor is not careful. FWIW, I have never seen a new
> user complain about the length of the typing, it's usually with the plethora
> of unintelligible (to them) options that each command has when they open the
> Git man pages, which adds more fear.

This is one of the reasons I suggested to split git into two binaries:
git for normal users, and git-tool for all the plumbing not many humans
use.

> I do not have an opinion about default aliases, I only had a narrow point,
> ie, on the list of impactful things that helps Git newcomers around my
> circles, aliases would not score very high. Those who love the command
> line among the more enthusiastic learners will set those aliases themselves
> anyway.

Sure, initially aliases would not help them very much, but after the
initial learning period when they actually start using git for real,
then aliases help tremendously.

Cheers.

-- 
Felipe Contreras
