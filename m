From: Olivier Delalleau <shish@keba.be>
Subject: Re: Suggested improvements to the git-p4 documentation (branch-related)
Date: Sun, 6 Jan 2013 21:00:42 -0500
Message-ID: <CAFXk4bp0MBNxOD7w1zn7peN-ufWmV=DthMdHmjmj+Sci4MGneg@mail.gmail.com>
References: <CAFXk4bqt_pMVDtVKF-JiQuGbSpy2+_rGOg5RTTE+0pNKFcZh3w@mail.gmail.com>
	<20130105212517.GA30315@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 03:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts21Q-0003Bc-UB
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 03:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab3AGCAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 21:00:45 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:45085 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214Ab3AGCAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 21:00:44 -0500
Received: by mail-la0-f52.google.com with SMTP id fq12so14168071lab.11
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 18:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WdNimdDVQ8AZYGKY9kOPuovzm1UXSIKXaePvBT+6uMs=;
        b=BwQXhng9qfbWTUKoAhcu8KmANGPiM16ZLZ0tMR7VOqndGq3e3/hTQVont31LP/X44W
         OaSjB5a7947QJGUbHEt3FP5r2HNudHesyUYGq8lm5nQ0M2D/xcbcZlvAmYYyOCvk+OSg
         BCOhDkVGj28pR4CRPkDnVdcVGmgKANefHlsAKZYWgIbNfqEswsC6JTlFIyq1CDehTvnM
         y+7iyx5tpHNhQvjj7uTVlGuMSw/TjRlwqSJtRhHyDUFp0LJKL3+ATjU63ImJCoK2qNRq
         qMG4izFAEqYJqF6h0weHSUIIfs4DbMGNSrlQMpgy0upySB2FRixae2zOeKto7XgSJdOz
         0VVQ==
Received: by 10.112.45.232 with SMTP id q8mr24483159lbm.23.1357524042700; Sun,
 06 Jan 2013 18:00:42 -0800 (PST)
Received: by 10.152.131.10 with HTTP; Sun, 6 Jan 2013 18:00:42 -0800 (PST)
In-Reply-To: <20130105212517.GA30315@padd.com>
X-Google-Sender-Auth: 2uJwO8aSP1izASWGvJ_kSeH-J3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212865>

2013/1/5 Pete Wyckoff <pw@padd.com>:
> shish@keba.be wrote on Thu, 03 Jan 2013 15:58 -0500:
>> While struggling to get git-p4 to work properly with branches, I
>> thought the documentation on http://git-scm.com/docs/git-p4 could use
>> some improvements:
>
> Thanks, I definitely appreciate the constructive comments here.
>
>> 1. At the end of the "Branch detection" section, the following
>> commands are provided (for when you want to explicitly provide branch
>> mappings to git-p4):
>>
>> git config git-p4.branchList main:branch1
>> git p4 clone --detect-branches //depot@all
>>
>> The second command should end with a dot (".") because the first
>> command only works if you are already in a git-initialized folder.
>> Thus I would also suggest to add "git init" as first command to type.
>
> That is confusing.  I'll make it this:
>
>     git init depot
>     cd depot
>     git config git-p4.branchList main:branch1
>     git p4 clone --detect-branches //depot@all .

Sounds good, thanks.

>
>> 2. Even though having a "main" branch is standard in Perforce, it
>> would be worth mentioning what happens when you don't: there is a
>> message "Could not detect main branch. No checkout/master branch
>> created" output by the "git p4 clone" command. However, it will still
>> work if you manually set the master branch ("git checkout -b master
>> remotes/p4/my_custom_main_branch").
>
> This feels like a bug to me, and indeed I had an old patch series
> that planned to fix it.  Let me knock that into shape, instead of
> changing the documentation.  It will automatically do the
> checkout step you did.

Sounds good as well.

>
>> 3. I don't know what I missed for that one, but I haven't been able to
>> get the example for the --branch option to work. It says that after
>> "git init", we can import a p4 branch with:
>>
>> git p4 sync --branch=refs/remotes/p4/proj2 //depot/proj2
>>
>> However, after doing this, followed by "git checkout -b proj2
>> remotes/p4/proj2", I am unable to properly use "git p4 sync" or "git
>> p4 submit" from this branch, as git complains about a missing
>> refs/remotes/p4/master.
>
> Yes, also annoying.  I have a failing test case for this, but
> haven't fixed it yet.  The idea is that "git p4 sync --branch=proj2"
> will sync refs/remotes/p4/proj2.  If there is no p4/master, and
> you don't specify --branch, it will fail with a more useful error
> message.

Good too!

> For submit, there is code that walks from your current branch
> back in history until it finds a commit on a known p4 remote
> branch.  This is sort of like the merge-base calculation in git,
> but restricted to a linear history.  I haven't tested that
> recently, but will add a test and fix it if needed too.
>
>
> Please do feel welcome to to rearrange or expand the
> documentation so it makes more sense, if you are so inspired.

I'm afraid I'm not familiar enough with git documentation to dig into
it myself, but anyway that's about what I had for now. I'll send more
comments to the mailing list if I have more suggestions in the future.

Thanks for a great tool! :)

-=- Olivier
