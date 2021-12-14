Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF01AC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 14:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhLNOF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhLNOFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 09:05:25 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Dec 2021 06:05:25 PST
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net [IPv6:2001:888:0:108::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A77C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 06:05:25 -0800 (PST)
Received: from ox-appsuite2.xs4all.net ([194.109.29.135])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id x8PimewBmhsVfx8PimBmSl; Tue, 14 Dec 2021 15:04:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1639490658; bh=nMhaBNNt8y1vi3e+oStwgbbfNfxCnXtjQNW1aX+DSvY=;
        h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:From:
         Subject;
        b=gicoHumNhnIaQeoWFcHmar65TjQBeE0k04870F5PWHpD8dvL/bvhACMwXJdps9i3A
         ibmLHRF/SYwnhMFoLTUdlNFPZ3RIZwn3B5j5mXimWSGIyaJDwf6K35lUgv0bViLf3E
         d8ZszeyZHslVKYY8UA+DqlsFiqocqNfjY1359K58VvNpR7Vj9YEBeaOIOSzuUlqFq5
         tB9icm21nMNsPLv514ADVW/GyNlV7yFdm1jUayw1rs/F5H+ygwwifC9C/gERykdKwj
         aw6M+N5+IeQKCDxj7CxAMIbtOt0Y7JowgXPvLtTs/RqHAXgF/MOnBOy+1qwqwPQd1V
         mSkxbXfp475qg==
Date:   Tue, 14 Dec 2021 15:04:18 +0100 (CET)
From:   Henk Smit <hhwsmit@xs4all.nl>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <1042563381.1916955.1639490658310@ox-webmail.xs4all.nl>
In-Reply-To: <9ee85cd2-3783-d077-11c1-5a779a325a0a@gmail.com>
References: <763856358.299504.1636971571656@ox-webmail.xs4all.nl>
 <9ee85cd2-3783-d077-11c1-5a779a325a0a@gmail.com>
Subject: Re: A bug or issue with "git rebase --autostash" not popping the
 stash automatically
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev27
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfOuy8/jRH1p9LGUaGumpVfM0sc0HrvlUIpg/k488a/MVZ9u9tePfAMMAxKPWFnUBNjtbhRkVwBWGCAvv5mRJ/lgKmMw2Qo5JA4KFR29yD2Ofqr68Ondv
 c4YsXr5Ur+wVj9JfT02JQuCOoF8oREmMyaOElWyNdDR1lPgRBcGvD/YenJdRTZpsPYXqStxZo8OOzOY1Og7HHYqWbKoF8Xs/ngu5HROwfJuIRSbK53SK7YmH
 P7dOw/ZGpJ82gbYwP5GHcA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

> You may, but I might not answer, or even receive your email. It is always
> a better idea to write to the mailing list, and CC people that you want to
> be made aware of your message :)

I was fighting inside my company to get people to realize how most of the
programmers try to stay away from git. They still work with our old versioning
system. And only clone a git workspace right before committing. It's a bit sad.
But all our git-experts kept telling me I was wrong. They expect everyone
to become a git-expert from day 1.

> > 6) PROBLEM: the stash is not automatically popped.

> Yes, that's the correct behaviour. If there are conflicts in the rebase, we do not apply the stash,
> since it could make the situation even worse if the modifications in the stash also conflict with
> the same lines as the rebase conflict. That fact, I realize, is missing from the documentation [1].

Maybe when there are problems with the rebase. But not when applying the stash back to your workspace.
I've tried 2.34, and there git works exactly like I expect! Even if there are conflicts with the stash,
they get applied (with the <<<< and >>>>).

> So, the stash does not apply automatically, there are conflicts. As noted in [2], this is
> the correct behaviour for 'git stash drop' [2].

OK. It's fine that when there are conflicts the stash is applied and then kept.
But what happened before 2.34 was that the stash wasn't even applied. Now it is. So my problem is solved.

> What you describe is working as it should,  I think.

Well, it changed in 2.34 to behaviour that I expect.
I've had some discussion with our internal git-experts. And they all told me different things.
And when I asked very explicit things, like "what is the correct behaviour", they all admitted
that they didn't know. :) No problem, but it drove me a bit mad. That's why I wanted to ask
someone outside my company.

But now I have the answer. I was not crazy. And what I expect (apply the stash, even when there
are conflicts), is what should have happened.

> > Is this related to the issue you point out on the git mailing-list?
> No, I was describing a case where the stash should have been applied automatically,
> but it was not. This bug was fixed in Git 2.33.0 [3].

Understood. The behaviour was changed again in 2.34.

> As I wrote above, the behaviour you are seeing is not a bug. When applying the stash would fail
> due to conflicts, Git tells you about it:
> 
>          Applying autostash resulted in conflicts.
>          Your changes are safe in the stash.
>          You can run "git stash pop" or "git stash drop" at any time.
> 
> So it's up to you to remember to do it :)

Yep. But in 2.34 that changed again. Now the stash always gets applied.

> If you want to have an "always-on" reminder that you have something stashed, you could use
> 'git-prompt.sh' [4], and set GIT_PS1_SHOWSTASHSTATE in your shell environment [5].

Thanks for the suggestion, I'll have a look at that.

> > So my question again: "is git rebase --autostash" supposed to always pop the stash or not?
> > If it is, is the current git behaviour a bug?
> 
> It's not, not when the rebase has conflicts, or when applying the stash results in conflicts.

Well, in 2.34, git thinks differently. :)

Anyway, thanks very much for your reply.
In 2.34, git behaves like I want.
This is behaviour I can tell my colleagues about (the ones who are not git-experts, like me).
"git fetch && git rebase --autostash" is now an easy and reliable way to update our workspaces.
That's all we need.
I'm happy.

Have a nice day,
henk.
