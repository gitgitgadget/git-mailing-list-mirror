Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D5C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579162146E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="E3EVUM9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCJOgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:36:54 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:48909 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgCJOgy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 10:36:54 -0400
Received: from mxback25o.mail.yandex.net (mxback25o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::76])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id C5940940650;
        Tue, 10 Mar 2020 17:36:49 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback25o.mail.yandex.net (mxback/Yandex) with ESMTP id 2zf0LKWbPo-anBCEmwv;
        Tue, 10 Mar 2020 17:36:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583851009;
        bh=hUEIg0URj6e/dMeswoMR6YEZ48iejWfPTt6w87ASCtI=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=E3EVUM9+pFzynSt6mkyC/dnYlKtBKgjAULHyIbtkhFEpmCEj9ER+ZGO9rasHuVpL/
         gsULocWvsfwN5ZXGZvYOMt9MK4jo4EZmccoOw+QCGtuMD3Twao63febxbnk+HqmaPm
         MmHErNXy7Xg4/+/WaOGRF6omqEVPbZxPYvVVO8OM=
Authentication-Results: mxback25o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-d6710af5e038.qloud-c.yandex.net with HTTP;
        Tue, 10 Mar 2020 17:36:49 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CABPp-BGyz2uRtmw05uCFVACq9aXS9fwcLwEEvw4EU9toixwf2w@mail.gmail.com>
References: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
         <3165171583586403@sas1-2bf44b70450e.qloud-c.yandex.net> <CABPp-BECOarg+G-_oz83i0EuKuypJQA=wyjnfG4U0heG=0L0hg@mail.gmail.com>
         <3207561583597253@iva2-fa9fd5fad11f.qloud-c.yandex.net> <CABPp-BGyz2uRtmw05uCFVACq9aXS9fwcLwEEvw4EU9toixwf2w@mail.gmail.com>
Subject: Re: Git Merge 2020 slides and reproducibility
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 10 Mar 2020 17:36:49 +0300
Message-Id: <6997681583850484@myt6-887fb48a9c29.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



09.03.2020, 18:50, "Elijah Newren" <newren@gmail.com>:
> On Sat, Mar 7, 2020 at 11:38 AM Konstantin Tokarev <annulen@yandex.ru> wrote:
>>  07.03.2020, 19:03, "Elijah Newren" <newren@gmail.com>:
>>  > On Sat, Mar 7, 2020 at 5:38 AM Konstantin Tokarev <annulen@yandex.ru> wrote:
>
> ...
>>  >> However, when testing my previous merges which had to be done with helper
>>  >> script, I've encountered case of
>>  >>
>>  >> CONFLICT (directory rename split)
>>  >>
>>  >> Is there any way to prevent conflict in this case if files are the same, and
>>  >> merge their contents if there are differences? I think it would be reasonable
>>  >> to assume that move done in newest commit should win, and allow user
>>  >> to change strategy via command line option, provide explicit hint where files
>>  >> should be moved, or maybe even decide it interactively.
>>  >
>>  > This conflict message is known to trigger in some cases where it
>>  > shouldn't; it may be that you're just experiencing annoyance from
>>  > that. Let me fix that issue before worrying about workarounds.
>>
>>  Well, in my case a directory of files was moved path A in one of merged heads
>>  and to path B in another, so I guess it was legitimate.
>
> The point of directory rename detection is to allow new paths on the
> unrenamed side of history to follow the directory rename. So, while
> there may have been an ambiguous directory rename, if there were no
> new paths to be moved by it, then that directory rename is irrelevant
> and shouldn't be reported as a problem. (If you did have new paths on
> the unrenamed side in that directory, then yes, it's legitimate.)

In my case, both sides have different renames, but files in subject directory are
mostly unchanged. It would even work for me if merge placed it to wrong
directory in the end, just to have it merge files contents automatically.

>
>>  Are you going to continue development in the same branch?
>
> Nope, the branch exists for reproducibility of the demo. Right now,
> my plan is to work on the 'ort' branch (which the git-merge-2020-demo
> branch was a snapshot of), but I reserve the right at any time to push
> up code to that branch that doesn't even compile or is known to be
> horribly broken.
>
>>  When do you expect it to be ready for review?
>
> Good question. There's other work I've been pushing off with the
> excuse of preparing for the Git Merge 2020 conference, and working on
> those other things may limit my time on this and make it harder to
> give good guestimates.
>
> I'm hoping that _parts_ of it will be ready to review a week or two
> after 2.26 is released. That will not mean I'm done with development
> at that time, just that I'm trying to get feedback in parallel with
> doing further development. Besides competing priorities, there's
> another reason to be somewhat cautious about the timeline: I don't
> want us to replace one area of the code that only one person is
> willing to touch with a different scary beast that no one wants to
> touch. So, I need to put some work into high level algorithm and data
> structure documentation, splitting up patches nicely, etc. And the
> purpose of writing those documents isn't to put the design in stone,
> but rather to make review easier -- at which point I expect at least
> one big change or two (and dozens of small changes) to be requested
> for maintenance/performance/API-design reasons. I'll be disappointed
> if I don't get that kind of feedback, as I'll be worried we're just
> putting a new black box into place.
>
> I happen to think that the basics of the new module are nicer than the
> old merge-recursive module I'm replacing, but the performance work
> complicated things a fair amount and I want to make it more
> approachable. So, we'll see.

/me personally would at any time prefer correct renames detection over speed,
even if things become _slower_, just to resolve less conflicts manually.
However, I guess planning all optimizations up front may be necessary to choose
optimal data structures.

>
> I know this is horribly vague. Sorry.

No problem, thanks a lot for your work and this information!

>
> Elijah

-- 
Regards,
Konstantin

