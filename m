From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Sat, 18 May 2013 17:42:22 -0500
Message-ID: <CAMP44s2dZkRUOQmKwmP_ruXfZemjTjEapTvdt276_d+NRZ8vhA@mail.gmail.com>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
	<51968311.1020107@bracey.fi>
	<7va9ntxu3w.fsf@alter.siamese.dyndns.org>
	<51979065.4060609@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun May 19 00:42:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udppl-00056A-8k
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 00:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3ERWmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 18:42:24 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:54017 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab3ERWmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 18:42:24 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so2764807lab.13
        for <git@vger.kernel.org>; Sat, 18 May 2013 15:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=t/mGJMVESONyE2vyYNrm2aP3y638dNG/kkNLO6MEfZc=;
        b=ZCe2SCDqpnRHswoqgieG78u7UZOtQeRHACgFOsVvcJ8BZmo8gArF60d9+FbOLd2pLX
         zeq27xPiepvszIOAtVkAiBggsjtOXPmofJgaKTGpCQK04kQiMaa/foDnfNOI/3oo6Ys9
         U5+GCCSt5ny28+fQTjMFr5CynHM7QPubL0813UOKwR3zEiMOyVG9cxZHvhHiNSbnRnm3
         hz9EuwSHPLOcHYHu2aXU4bcl21bVhjG7rfyasOifMAziJa3yP8Rxmw8Vks6dflSDX7SL
         fpCQ75hLF4fVMcvCc3Pq6AO+ZceStcLMWaPdx/lmWosubP2RxlztJXXAugvVe0UNaVQq
         yCJQ==
X-Received: by 10.152.3.103 with SMTP id b7mr16145147lab.8.1368916942626; Sat,
 18 May 2013 15:42:22 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 15:42:22 -0700 (PDT)
In-Reply-To: <51979065.4060609@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224814>

On Sat, May 18, 2013 at 9:29 AM, Kevin Bracey <kevin@bracey.fi> wrote:
> On 17/05/2013 22:51, Junio C Hamano wrote:
>>
>> Kevin Bracey <kevin@bracey.fi> writes:
>>
>>> On 15/05/2013 23:34, Felipe Contreras wrote:
>>>>
>>>>    I think I'm using 'upstream' for something it was not intended to,
>>>> and
>>>> I think the current 'upstream' behavior should be split into
>>>> 'upstream' and 'base'.
>>>>
>>> I found myself thinking the same thing. It's really convenient being
>>> able to set your topic branch's upstream to another local branch, so
>>
>> What is that "another local branch"? ...  And if that is your workflow,
>> setting
>>
>> push.default to "current" (and setting remote.pushdefault to your
>> publishing repository) should be a sufficient interim solution, and
>> you do not need to set branch.$name.push to each and every branch
>> you intend to push out, I think.
>
>
> I agree that using "push.default current" covers some cases - I hadn't
> really considered it - tended to just stick with "upstream". "current"
> nearly does the job, but I will sometimes be wanting different names.
>
> What I'll often be doing is creating a topic branch based on master or
> origin/master. (I would hardly ever be updating master or pushing to
> origin/master myself, so I probably should be just doing origin/master, but
> I tend to create a local master just to save typing on all those "git rebase
> origin/master").
>
> During work, to give others visibility, and the possibility to tinker with
> the topic branch during development (as we don't have full inter-site
> sharing of work areas), I would push the topic branch up to the central
> "origin" server, often with a "kbracey/" prefix, partially for namespacing,
> and partially to indicate it's currently "private" work and subject to
> rebasing.  I guess I could create the topic branch as "kbracey/topic"
> locally, but I'd rather not have to.
>
> So I'd like "git rebase (-i)" to move my topic branch up (origin/)master.
> And I'd like "git push (-f)" to send it to "origin/kbracey/topic". And by
> extension, I suppose "git pull --rebase" to update origin/master and rebase.
> (Although I'm not much of a puller - I tend to fetch then rebase manually).
>
> The final releasing procedure for the topic branch would be to hand that
> branch over to an integrator, who would then merge/rebase it into master.
>
> And it would be ideal if the initial base and push tracking information
> could be set up automatically on the first "git checkout -b"/"git branch"
> and "git push". (For one, I've always found it odd that there's an asymmetry
> - if you check out a topic branch from the server to work on or use it, you
> get a local copy with upstream set by default. But if you create a topic
> branch yourself then push it, the upstream isn't set by default - you need
> the -u flag. This seems odd to me, and I've seen others confused by this).

Indeed, and I agree.

I've started to set branch.autosetupmerge=always, so I always get an
upstream no matter what. The only problem is that 'git fetch' now is
useless without any argument, but that can be fixed with another
configuration 'fetch.default=simple', so that it always fetches from
origin, no matter what. Then, everything is consistent, it doesn't
matter what 'branch.autosetupmerge' you have configured, and in which
branch you are sitting at, 'git fetch' will always do something
useful.

The missing problem is that you have to manually do 'git push origin
kbracey/topic', and that can be solved with the concept of a
downstream (branch.x.remotepush+branch.x.push).

If we have these two changes, everything would work perfectly, wouldn't it?

-- 
Felipe Contreras
