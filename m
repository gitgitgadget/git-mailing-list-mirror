Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B4C433E1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAE3207C3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAMoyCDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgFPNzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgFPNzc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 09:55:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3CC06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 06:55:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w90so15477604qtd.8
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nfcdbJ2i3O7z+zKHRAEID2nYAwe0zW+NxMtlXyciJ6s=;
        b=cAMoyCDgJaY11E8lcpVZ8HvULqrKnCYb/IR1szOUqX3Oalz8STmXKEtpe0YM6NdVyF
         TcmL8qT7FgU86CO2v+GyQLVKXr7AGfFUf7zR/Ezcz+NKoYuLARtiz09EmnRxIwjUAt1G
         sz2CL4bWskFb1V56pIsLeki838J3dzOr/Yk3AFg2NxEcjhAWB5ydMG6w2NNEZMXrT7QZ
         UXLo0snuAhdvn/GeBjiTPXkngtJzdljvSajfn/eMT9uHTmDkvmG+23Q6zUaoCvTW4Giy
         Plutt52/sYAf0yprkk5vtkNvxLbeNIs3Yru6vZUrwBFy15MNmifpQAgEpJXUOAfu4Jsn
         +N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nfcdbJ2i3O7z+zKHRAEID2nYAwe0zW+NxMtlXyciJ6s=;
        b=Cs/UJNUPeSIGqVYNMCJ/UfWylfDfq2XnaMVU06B+NrOK4b76I+/XAK0ZcpVOyAFRii
         aFKgRMWWTGHSZqbf/ButC75oLofb+bVuLtqv1VkNbFszaRAZXba+xzA+y0/uLQn5fp3w
         tPTBfU2Flx1zPHCnTWxpZRPKa6FFB7k9nNzMYva4ENibGvFMO+dz1U3RZSUtoOGHBgW4
         44d+EWbCDNsY3L64oO05LoJherUt+7034t/2MOVjGTHhzAe2/p0v+YIVDcrZO9wCKQl+
         Zk4H845qj3XBKmcYIk5kfmr3ZxntM94XtU0P5k5NQGEl/YdpVJ0Zp5EhbSicfBXQxZOx
         XrrQ==
X-Gm-Message-State: AOAM53137Cf2pUUnoitH7v1OFr/h5bjlCV+Fkxx9RcFfdXqCfNiTtLrW
        3kT+TX0A9yBHDpbBfehkXi8=
X-Google-Smtp-Source: ABdhPJxoPVsf4Pe+1T4+7/qQnUAznugI8suy/lmpI8vlNk7kH4/j+7eyCYlhZXrRVq1+nqzeMke9rg==
X-Received: by 2002:aed:3b63:: with SMTP id q32mr21729498qte.1.1592315731361;
        Tue, 16 Jun 2020 06:55:31 -0700 (PDT)
Received: from [192.168.1.117] (c-73-139-109-188.hsd1.fl.comcast.net. [73.139.109.188])
        by smtp.gmail.com with ESMTPSA id a15sm13724188qkl.20.2020.06.16.06.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 06:55:30 -0700 (PDT)
To:     konstantin@linuxfoundation.org
Cc:     Whinis@whinis.com, alexsmith@gmail.com, don@goodman-wilson.com,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
Subject: Re: Rename offensive terminology (master)
From:   John Turner <whinis@gmail.com>
Message-ID: <834b0165-61c7-1313-6bc9-387d8a31ef76@gmail.com>
Date:   Tue, 16 Jun 2020 09:55:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Let's leave emotionally charged rhetoric and discuss this like
> reasonable human beings.
That would be fine except the entire thread is started on emotionally 
charged rhetoric

> 1. Git is distributed software. It's not a central service and it does
>     not manage any code hosting platforms. It has no control over what
>     Github, Gitlab, whatnot or other decide to do. If you don't like what
>     they are doing, take it up with them and keep it off this list.
Being that the talk of changing the default name has been said to match 
up with their efforts how can it be kept off the list? Even the initial 
start to this pointed to other projects as a reason why this should 
happen. Seems kind of an odd fence to setup whenever nearly everything 
about this starts with github and other projects.

> 2. Branch naming is entirely the choice of individual repository
>     maintainers. Some prefer not to have a "master" branch, and it's not
>     simply because of "political correctness" reasons as everyone
>     insists:
>     
>     - they may prefer to have "stable" and "development" branches
>     - they may want to use localized names for all their naming
>       conventions (using Cyrillic, Hanzi, Kana, whatever)
>     - they may be goofing off (there's a furry-related repository on
>       GitHub with the main branch called "yiffed")
My understanding is you can already delete the master branch and 
force-push that. So back to this topic why does anything need to change?

> 3. In your example, "millions and billions" of scripts are already wrong
>     if they assume that there is always a "master" branch. However, it
>     doesn't matter, because unless someone actively renames a branch in
>     an existing repo that they work with, they will continue working just
>     fine. Nobody is talking about banning the use of the word "master"
>     for any existing branches. I am 100% certain that Linux mainline will
>     continue to happen in refs/heads/master, because the fallout of
>     renaming that would be terrible.
They may be wrong but being while Git is not a central service is is 
used in millions of organizations and by millions of organizations 
through central services such as Github. Through this distributed use 
some things are assumed whenever creating new repositories and yes the 
master branch is one of these. Nearly every tutorial on Git or using get 
will reference the master branch and its is how many people learn. Its 
already been shown in the patch how these changes might break on 
existing repos due to assumption of the main/master/primary/<insert word 
here> branch is no longer what it used to be leading to a need to fix 
all configs on all repos. Also it has been pointed out how disconnects 
between configs between two different clones could lead to issues.

Requiring every organization or individual who uses Git to entirely 
retool due to changes in a base assumption is the exact opposite you 
want of any stable software. The claim that this only affects new 
repositories so its immaterial is an odd foot to stand on being that 
almost all of these scripts assume something about new repositories that 
will now be different.

> 4. In Git, local branch names do not need to map to remote branch names.
>     Your local branch "upstream" can track remote branch "development".
>     If the remote branch gets renamed, you simply update your
>     configuration and continue without change.
While true this is more of an advanced feature that many users don't 
know about. Saying that its ok because you can fix it with something 
more complicated sounds like the worst possible reply.


> 5. The change proposal has two parts to it:
>
>     1. Allow users of Git to designate another branch as their primary.
>        As Junio pointed out, Git treats one of the branches as special,
>        but currently that is hardcoded to "master". This change will make
>        this configurable so that projects with different naming
>        conventions can designate some other branch as their primary.
>        I've seen no objection to this from anyone.
There should be an object to any major change to the underlying code 
such as this without good reason for doing such. Being that this is not 
a security issue and as you have pointed out people can already name 
their branches whatever they like its adding complexity to an already 
complex system. Being that we are as you say detaching this from 
"emotionally charged rhetoric" and being "reasonable human beings." what 
good reason is there to introduce such complexity if users appear to 
overall not want it and those that do already have an alternative?

>     2. Consider if the default branch created during "git init" should be
>        called "master" or if it should be called something else. Options
>        are to keep it "master" for legacy reasons or to make it something
>        more descriptive like "main". Since this would be merely the
>        default configuration option, packagers and sysops can set it to
>        be whatever they like via /etc/gitconfig, and individual
>        developers can set this in their ~/.gitconfig.
I have seen no one in this email chain nor the one asking for what the 
default name should be even entertain the idea that it should be left at 
all. Nor have I seen any attempts to accept reasoning for why it 
shouldn't change. Changing the default while seemingly simple can have 
long reaching consequences as anyone in development would know. Claiming 
its merely a default is rather disingenuous for a piece of software as 
widely used as Git.

I leave with this, if we are to leave out the emotions what good reason 
is there to push through this change?

-whinis

