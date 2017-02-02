Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7194D1F4E2
	for <e@80x24.org>; Thu,  2 Feb 2017 20:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdBBUcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 15:32:47 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33353 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdBBUcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 15:32:46 -0500
Received: by mail-oi0-f65.google.com with SMTP id j15so2103416oih.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 12:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t4Ov+XB/lFawNbKqHLV0+HN/0u7Ga4l3boX4k9y8Hok=;
        b=qI+WY3zKxmQSirdM4DGzyr48G93XedIfTunJgu4a9qIl+M+0CBf0nNqTeM05f8cHv7
         yMmwSgpqNTdD2fEB03Y/p5AJ/0QPFVc5yCMJ3XaYQmUBgJZC9/h5Cp7ce/G0vzk3ZMqb
         5z81jg3bhl4dHufVihEUAoM9YrxxaJU1O3urVgXQqQ2hPnR+tLrqR2yWC1RadgKE35VA
         v1l8Uj+d9yKe29BJrapgaFyt2V2JInAT6xV96N/a85t5qOf6uITFTCqD2eE5LUagQMK8
         lU1qEeWw+CNWRvI2XYQTV++YpJZbEbDWX/ltvU2f+0ZUlZ5eAaEBh0Pc1U19YnExU8Wi
         pAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t4Ov+XB/lFawNbKqHLV0+HN/0u7Ga4l3boX4k9y8Hok=;
        b=UJSr5nGkBFvsKatMsVvEqkBlLMBgMuwVsmtWPATzCUye+ZUGFaFUJcYTDbpaA7ioOn
         DwpCJIWRcYWmHS4fBN9nQMentU/datBWyzMlyXRSF/RQuP6PRQU5/7VMe0/zyg/ofwpW
         kD1RkZEHSI2fcTYVdfpKbqFYYhGRiK569OaATFrpkDsBkSHC8wvGqyVeWWQJO/tZ2byP
         IfmtUhR/OviJXldc6Rm+GqtINF7qxundWugtZfUeSNhZQiJOF3raNNs+zB3hdv+F/aE9
         xLZeD71VmIeutRXCFFKVogaQfDQb1+8gU/izSj04KQpeKs0S14P94o2Sq7Fg7l6dSvlu
         o6UQ==
X-Gm-Message-State: AIkVDXIdaY8A40vxNkUTcc5VoJA7sfeHjG7nH8Vzvt/fRfsouWmk0FZHOZodGWaMRe6DMTBQh25S1zqFFHxhMA==
X-Received: by 10.202.212.79 with SMTP id l76mr5252871oig.177.1486067565458;
 Thu, 02 Feb 2017 12:32:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Thu, 2 Feb 2017 12:32:45 -0800 (PST)
In-Reply-To: <xmqqshnws6ma.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702021143470.21619@i7.lan> <xmqqshnws6ma.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2017 12:32:45 -0800
X-Google-Sender-Auth: vFdMBVezE-8Uojh3hJRKx7gXk0E
Message-ID: <CA+55aFw14UXMa6OJ6YLHjy3tzOD+VSNytw6kMpaxFEfyuO2hAw@mail.gmail.com>
Subject: Re: [PATCH] ls-remote: add "--diff" option to show only refs that differ
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 12:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Most downstream folks seem to care about refs/remotes/origin/$branch
> and I think in that context "git ls-remote --diff [origin]" that
> compares their refs/heads/* and refs/remotes/origin/* would make
> sense.

Hmm. Maybe. The main target for noise reduction for me was actually
all the shared tags.

Which doesn't have that issue.

Also, I've never ever used "git ls-remote" on origin. Do people
actually do that? Why would a regular user ever use ls-remote in the
first place?

The only reason I've ever had for using ls-remote is exactly because
the remote is somehow "odd", and the _normal_ flow didn't work, so you
want to start investigating. So by definition (at least for me),
ls-remote is not part of a good normal flow.

So I kind of see where you are coming from, but I don't really see
that as being a normal workflow for me - or really anybody.

What I think *your* use case is would be more for a workflow along the lines of

   # update the remote data
   git fetch [origin]

   # have some way to just see what branches are not the same
   git status --all

or something ("git status" already talks about the status of the
current branch vs the origin branch).

> Your has_ref_locally() seems to return true by comparing
> their value with the value of the local ref without any the fetch
> refspec mapping.

Right. Because I see the use of "ls-remote" being mostly for
maintainer pulls, and the "origin" in many ways would be the other way
around (and you wouldn't even know what the name of said origin would
be locally).

I basically don't see downstream contributor doing ls-remote, it's a
upstream maintainer command.

But that may be a lack of imagination on my part.

> When one contributor asks you to pull refs/heads/master you want to
> go and see if it is different from refs/heads/master you have?

No. What happens is that people ask me to do something like

    git pull ..some-target.. tags/for-linus-3

and the pull fails because there is no such tag. That's when I go "ok,
they screwed up, let's see what they *meant* for me to pull", and I go
"git ls-remote".

In other words, I don't see anybody ever using git ls-remote if they
already know what the remote is. That's why I don't see "origin" to be
an issue - origin is by definition somethinig you trust, and you just
fetch and pull from.

So the only reason I've ever had for using ls-remote is literally "ok,
what the hell is going on at that remote repo".

And then it is generally a bare repository, and it generally does
*not* have remote branches in it at all.  But it *does* generally end
up having all the basic branches and tags (not always, but it's very
common).

Which is why I as a maintainer then want to just weed out anything
that is already my usual branches that everybody downstream already
has.

I agree that it's a specialized case, but I also think it's the _main_
case for ls-remote in the first place (apart from some scripting to
check for updates or whatever).

But maybe more people use ls-remote than I think they do (and in
different ways than what I envision).

                 Linus
