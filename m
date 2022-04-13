Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC1C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiDMQjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiDMQjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:39:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730A64BC2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:36:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x200so4697053ybe.13
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szfkdt4Uqqw2xQbqFifZmGOqd3H8V0v0a2fl6ch0nwA=;
        b=ak4p4FloYx/orZs8LMftXnCf9s/AEAwQKom5LoRrHX/gB2Sb+Sz4aAWaTJUe8HRQ/l
         FyL36dCcE7QyeXjnJu1WZ8Y+Vbj5QqhqDab6VgFI53zRGlf4vaeJcsYrV8T7sSqKwBy7
         GXklGs4qBC6elRcPxHO/To//z6QKpco9XPAhgfMiJWP+HTwaFXs+sbtyc6DQ6pQ/P7H8
         XwJgcQEzKFum5ubanx7nslGsXUbXDYvIDcCN8FtcDvXDlYrBerXUd5B+vg8fRrr3uPq/
         D8MX5bPCPBW2Ub3iI6AyRzpE/pZKEFf2GsNoFNpAHf6Audp8UTEmHTDDCAe/HU9v9T+k
         B0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szfkdt4Uqqw2xQbqFifZmGOqd3H8V0v0a2fl6ch0nwA=;
        b=DxJxxa6WKcWCyJhP6lrNZsnIlxOBpqTDWHMfy31rcQiW3kJ14982wGv33IhWPpQFpU
         8cSpt24/aafAIt1/3fzI74aVcC5gZLNG/yItG2E15UQuA5RyaVzvKkWmjgzeMeeDP99H
         G3GJb/2FShiMRGNOtkHrXHqp6TRwE6Jy9yWaqLxG0XdlH+NyUtF0lqSB5Z95RaXMpj9G
         z35u3cJ9wZ5Jh6ZIca539YxypvXuGlwioztsIGg6cN6wPhrok4Fu2J8i1mHzAvguWMaj
         ATeupNzCAEyf0qMclm7fjytqk2Gf+Ypkzu4mfwFrAfpvNmi0+JVg1/ZY4aP18FeFrkAv
         D2vQ==
X-Gm-Message-State: AOAM531XwtH5faLLQ5QfQFw8Tr6wbygMbD1wnpXwMjsxDPQiJ6/2Vm9B
        mLZxeQ4cNnH/pwT663jp14FffFbxsZLJJak4t0/w7WhKJSMeexAg
X-Google-Smtp-Source: ABdhPJyu7ZFMCuSLk5uac6u45iGqVuAcjD7Y+KghMrp/yQWWTSgzvyMDVSr4MNQF9+ZB9OS0T6gkCBH6+AFhEppMWS4=
X-Received: by 2002:a25:b982:0:b0:640:df8e:fb76 with SMTP id
 r2-20020a25b982000000b00640df8efb76mr18456742ybg.0.1649867813708; Wed, 13 Apr
 2022 09:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220412202557.32101-1-cogoni.guillaume@gmail.com> <CAJyCBOS=xCEmX3yPduDEQfkVYUUiawQ7sYgNHi2dGe-R2W5r-g@mail.gmail.com>
In-Reply-To: <CAJyCBOS=xCEmX3yPduDEQfkVYUUiawQ7sYgNHi2dGe-R2W5r-g@mail.gmail.com>
From:   Guillaume Cogoni <cogoni.guillaume@gmail.com>
Date:   Wed, 13 Apr 2022 18:36:42 +0200
Message-ID: <CAA0Qn1tZxGR0cUi2JSJtTFYe2Nk9xoGuHkruji1-53-Fhokmig@mail.gmail.com>
Subject: Re: [PATCH 0/1] documentation: guide of best practices for GIT developer
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Jonathan Bressat <git.jonathan.bressat@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        guillaume.cogoni@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 4:36 PM Shaoxuan Yuan
<shaoxuan.yuan02@gmail.com> wrote:

> Wouldn't there be a possibility that this doc can degrade into a list of
> personal taste?

Of course, it could end like this, if someone writes something in this
document, it's because that person likes it. People are not going to
recommend something they don't use. But, I also think that it's not
really bad because the purpose it's to have a bunch of tools that
might interest others.

> The tools that people use can vary in an incredible way, thus the workflow
> defined by multiple tools can go even further. I think a workflow here is highly
> opinionated, and such a thing may disturb newcomers?

Yup, you got a point, it's a bit complicated to recommend a workflow
because there is a lot of variety. But, about tools, it's possible
because you just say how this tool can be useful for the project. In
my first recommendation I propose the built-in debugger of VS Code and
say that "It can be used to isolate certain parts of code, with this
you may be able to ask more precise questions when you are stuck.". I
think that recommendation may not disturb newcomers or other Git
developers because it's only a tip, use the tool or not, you have the
choice.

> Wouldn't it be better to let people decide on their own tools and Git
> should stay respectful?

It's just a tool recommendation, and I don't force anyone to use it.
Is it the name of the file "WorkingOnGit" that makes you think it's a
mandatory thing? Maybe "HelpToolForGit" is better?

> Let alone most people come into the community as
> developer, if they are going to be "WorkingOnGit", so they may already be
> well-suited in their own workflow?

Yes, naturally, but even if people have their own workflow with this
tool or this tool, maybe if you recommend a tool that is "better" for
working on Git, will they change their habits? But, as I said it's
just a recommendation, the final choice of whether to use it or not,
is up to them.

Thanks, I appreciate your answer and I hope I've answered your questions.
I think simply recommending tools is a good thing, because, as you
mentioned, recommending a workflow is complicated.

SIncerely,

COGONI Guillaume
