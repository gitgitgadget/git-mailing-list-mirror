Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D2BC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D2A61351
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhGJIfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhGJIfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:35:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A38C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:32:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h2so17700308edt.3
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9bJlGy1Q4DE8hLw4KpaxSOGCe5PvQZnE0LJVm+hbY5A=;
        b=p2dKw3Inf00iUix0v7U7ZhaRFxUux2bAuTzq9wNeHcRXw+LtAsPHpr2C88BLC2UhPj
         kU2NllPu9kW5iJIPbHWYCCe5sh69dTF+1oebTib6+izMdzqqBJNqqOtrcGbkmZdyAilO
         W/+9Xlk8cxbzAzdT6oTzPOqKaqdiZIPkAEBWgnEehTqX4/MMG9MarLvucJgkZ/oc5tdz
         nxxFlgP8vczkl2y1y8/bftkhZRIdQ7czZ0qvxd5zayU1CJYnzK0jw5XwumK/703v/oL1
         ks1lDSbBNKDpFu7JMVEXexRDwyphHnT61laYmxBe0tWzRnIJNVgBJy5oafZf+lAeOADg
         91xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9bJlGy1Q4DE8hLw4KpaxSOGCe5PvQZnE0LJVm+hbY5A=;
        b=oj4T0egAZazbjvlppODFhPM6vysdDwmgkx+oxuS1GUN7Q9lxtPnamUh0uvOaYZkqvK
         wZVuPlWIcWrpqRQISWLrprj1enFV3s6+VT/FLAcLY/JtY+1vyF9DYNt2afkxUzRLTX/c
         ksyHK1vD3c7yv1C/jPG3RMaWjRon+bof+0eN1qdKqghJ8EdKEvoVN5ktOOCj/FidyqMR
         zYCiiuacj5ayfanVsv2m6KYxcMQH4J2ceNO7nFIsXc5ozilHRn2s4JcGoM5oS/U9eDiO
         oAPKle6T1ZDk0XZHu4ADI5OU0WmitdoYC7pjVYqXzGo2whdvEn6dtOLO6XHkrlMDNJVl
         oi4g==
X-Gm-Message-State: AOAM532cR+nEYxE4udnzc4QBgM5hb9KDqtkcyt2wK54G5oOOzhJnOB5t
        PpYU/UvZdHjiJekQgQHMPR4=
X-Google-Smtp-Source: ABdhPJwLZBNVsu5O+Ikh1rmThGvKWWoxUpOFKpF4NgX89py6hgooShwmyw4GT8wt8v7JL+PLOA+C8g==
X-Received: by 2002:a50:c111:: with SMTP id l17mr38754770edf.56.1625905956210;
        Sat, 10 Jul 2021 01:32:36 -0700 (PDT)
Received: from evledraar ([109.36.149.59])
        by smtp.gmail.com with ESMTPSA id d9sm3395660eje.34.2021.07.10.01.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:32:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     grizlyk <grizlyk1@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: Pro Git book: concerning data lost due to ".gitignore"
Date:   Sat, 10 Jul 2021 10:23:25 +0200
References: <3957861622848346@myt5-a5512e99e394.qloud-c.yandex.net>
 <87a6o459bh.fsf@evledraar.gmail.com>
 <4458411625892760@myt6-ab88f6e23eb0.qloud-c.yandex.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <4458411625892760@myt6-ab88f6e23eb0.qloud-c.yandex.net>
Message-ID: <87zguu4li5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 10 2021, grizlyk wrote:

> hi
>
>> On Sat, Jun 05 2021
>> It's way too common of a pattern to e.g. have a *.o file made from a
>> corresponding *.[ch] file(s) in the same directory.
>
> The patterns were common for old times (before VCSes was involved). To
> deal with temporary files (like .o), generic OS tools like "make
> remove_compiled" can help to clean directory before stage. To keep
> derivative persistent files (like the same .o) separated directory can
> be used.

It's still a very common pattern, e.g. the project whose ML you're
posting to uses it, anecdotally most free software C or C-like projects
I look at / work on use it.

In any case, git as a project can't say "you should fix your code". This
VCS has to deal with the real world, people do use this pattern in the
wild, and we can't willy-nilly eat their data.

It's not a good approach to advocate a change in git behavior to say
"people should do X, not Y, to avoid this problem", when a cursory look
at real-world use reveals that "X" is in wide use, and unless you did
"Y" a proposed change in behavior would be detrimental to your use of
git.

What is more productive is to either find out how we can support both
without harming the other, or make new behavior opt-in, hence the
thread(s) I linked to about "precious" etc.

>> git already does a good job of supporting it. 
>
> Sure, the light message: "There are ignored files (%u<number of
> files>) not placed into repo.\n\t(use git status --ignored to view)";
> will improve the activity. Otherwise some files somethimes will not be
> placed into repo unexpectedly for user.
>
>> You'd e.g. compile all your 
>> assets outside of the repo via your build system, and just not have
>> anything in .gitignore.
>
> Do you suggest to copy desired src files into separated repo directory
> (the repo directory placed under VCS control) by generic OS tools
> (i.e. by cp command) and stage the separated directory?

I'm not really being serious here, as should be clear from the linked
threads I think the current behavior has sucky edge cases and does eat
people's data in some cases, that's bad, the problem is finding a way to
change it that doesn't cause badness for other use-cases.

I am saying that if your proposed "Y" solution is effectively "other
people should mostly/entirely rewrite their build systems to deal with a
new default I'm proposing", then in this case you'd also approximately
what you wou want if we keep the current behavior and you rewrite your
build system(s), no?

Anyway, maybe I misunderstood some of what you're saying...
