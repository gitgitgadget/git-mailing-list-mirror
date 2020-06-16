Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85257C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C9F21475
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323466;
	bh=knKBQBuxD+cXNXTIaHeY/a2PRWlZKBBf0IQEl1ARTjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bV8GrqCAOEE9YW+33cEruidVqTlHQnDEnWazZwUVHSRDyhV5oOjTWuktpnMMBXvNr
	 djqBmWhCOwyWzbaX61z0JehvDlx4VTe+rikaJLxESuj157e4V2Np/W73DjuMoxb0DA
	 TunEaNw4X7YkyJ/0TjOPtG7h8WdM50P7vLTqY0/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbgFPQEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732545AbgFPPtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 11:49:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F6C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:49:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w3so19589037qkb.6
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=DGUcfWoyiObYknq49F53cxiwG7vqBWtEaCiV6/i9Vfo=;
        b=C1ikx+2TR3szW3tcsvm3WXZe8iZHf1Ca//pY8JlLnw1zQ/fLwSofa9AWSvyxa6xJui
         hqyyIqGsdmuCwP+u6V3gUmwB4rtU3C8SFbbcLjtREJH3zMubTGG19GSd/xeX+klH10MF
         Nb2MxbYov9qtMsNSYUUS1AzGpRQL+UnZoCmlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DGUcfWoyiObYknq49F53cxiwG7vqBWtEaCiV6/i9Vfo=;
        b=a4DGP3HXTUgtP93TEK5ziNfumRM1UlaeXWg4r6HONHSXFIvOtRyInfBHGG+2z/7luP
         Bf/K2NQlZYVjMyAFYEqFoKVbeCbXYBzOgtmmQCtBbRjqDzk79P2GDfbB4Ymt/s7q/0nn
         fe4Y6ZjERlowwzjK2cKtXe3AZhcOJ43y4CRAoW2oQ1+NZlkxkTDU8TlFf6qK/uIlzPOz
         lkFqKbb7Far5JcVyZ5G8UBiPEi5MBHorxcD0HxYtQfSacM7KSRLK9ufzZO61oKwzTdgu
         jDL0PzktYnxNAGJUdQ9pp/FsMFtFMQ1aA1Ru0pdqHdCwm89YEjVuSpXHFIy30/IFNyBa
         x5tw==
X-Gm-Message-State: AOAM530TzlW9SJ+os2wO93c1qMLcC/uTqRhkKwP01phEwno+JWIf4qcp
        uwSbLu4BXTj4Kl6/0o0uThhhwA==
X-Google-Smtp-Source: ABdhPJxJ69wx98xro1Iu+CigSGuL8bjBFws4qwZk7PjEUl4MuqlHZy2cYV7DUxEzT4Yptzt+i6Tveg==
X-Received: by 2002:a37:6150:: with SMTP id v77mr229995qkb.173.1592322585213;
        Tue, 16 Jun 2020 08:49:45 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id d14sm14632342qkg.25.2020.06.16.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 08:49:44 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 11:49:42 -0400
Date:   Tue, 16 Jun 2020 11:49:42 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     John Turner <whinis@gmail.com>
Cc:     Whinis@whinis.com, alexsmith@gmail.com, don@goodman-wilson.com,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616154942.z75uo34wsbcvphe5@chatter.i7.local>
Mail-Followup-To: John Turner <whinis@gmail.com>, Whinis@whinis.com,
        alexsmith@gmail.com, don@goodman-wilson.com, git@vger.kernel.org,
        gitster@pobox.com, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com
References: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <834b0165-61c7-1313-6bc9-387d8a31ef76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <834b0165-61c7-1313-6bc9-387d8a31ef76@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 09:55:29AM -0400, John Turner wrote:
> 
> > 1. Git is distributed software. It's not a central service and it does
> >     not manage any code hosting platforms. It has no control over what
> >     Github, Gitlab, whatnot or other decide to do. If you don't like what
> >     they are doing, take it up with them and keep it off this list.
> Being that the talk of changing the default name has been said to match up
> with their efforts how can it be kept off the list? Even the initial start
> to this pointed to other projects as a reason why this should happen. Seems
> kind of an odd fence to setup whenever nearly everything about this starts
> with github and other projects.

Github is an equal partner in this conversation and their opinions weigh 
about as much as anyone else's. However, they are certainly one of the 
larger users of Git, so if they ask to make it possible to change the 
default branch name without any negative effects on how Git works, this 
is a valid request and a valid discussion.

> My understanding is you can already delete the master branch and force-push
> that. So back to this topic why does anything need to change?

It doesn't work perfectly. The goal is to improve it so it does.

> They may be wrong but being while Git is not a central service is is used in
> millions of organizations and by millions of organizations through central
> services such as Github. Through this distributed use some things are
> assumed whenever creating new repositories and yes the master branch is one
> of these. Nearly every tutorial on Git or using get will reference the
> master branch and its is how many people learn. 

This is true for all technical documentation, though. 10 years ago I 
could reasonably expect "print foo" to work in Python, but now it will 
return an error. Most documentation written for the Linux kernel is 
woefully outdated a few years after its publication.

Documentation has never prevented projects from implementing changes 
that would require docs to be updated.

> Its already been shown in
> the patch how these changes might break on existing repos due to assumption
> of the main/master/primary/<insert word here> branch is no longer what it
> used to be leading to a need to fix all configs on all repos.

As this change would be made by individual repository maintainers, this 
is out of scope of this discussion. None of the changes being discussed 
would in any way force existing repositories to rename their branches.

> Requiring every organization or individual who uses Git to entirely retool
> due to changes in a base assumption is the exact opposite you want of any
> stable software.

"Entirely retool" is not a fair statement for "set a single config value 
in a single file".

> Being that this is not a security
> issue and as you have pointed out people can already name their branches
> whatever they like its adding complexity to an already complex system. Being
> that we are as you say detaching this from "emotionally charged rhetoric"
> and being "reasonable human beings." what good reason is there to introduce
> such complexity if users appear to overall not want it and those that do
> already have an alternative?

You can't avoid the following facts:

1. Projects are already renaming their branches to whatever they want
2. There are parts of git where this breaks internal logic
3. We should fix internal logic so it doesn't break

The fact that Git doesn't 100% work with arbitrary branch names is a bug 
that needs to be fixed. Introducing a config variable that designates 
the primary branch name is the way to fix it.

> I have seen no one in this email chain nor the one asking for what the
> default name should be even entertain the idea that it should be left at
> all.

Nobody is preventing you from being that person.

> I leave with this, if we are to leave out the emotions what good 
> reason is there to push through this change?

Most software development is reactive to emergent situations. In my 
view, making it possible for someone to have an arbitrary collection of 
branches in their repository is reason enough to push this change.

-K
