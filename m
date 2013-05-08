From: Luke Diamand <luke@diamand.org>
Subject: Re: 3 way merge during git p4 rebase is attempting to reapply past
 commits
Date: Wed, 08 May 2013 06:35:42 +0100
Message-ID: <5189E42E.8050107@diamand.org>
References: <CAG4Fb8f8vxbqwnCn1B9EfZu3sM-3-wQ2dqcR+BezPaf_XEy5Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, simon@lst.de
To: Christopher Yee Mon <christopher.yeemon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 07:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZx2d-00028J-65
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 07:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab3EHFfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 01:35:47 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:50401 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3EHFfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 01:35:46 -0400
Received: by mail-wg0-f54.google.com with SMTP id x12so1504795wgg.9
        for <git@vger.kernel.org>; Tue, 07 May 2013 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+ngUJkAHrgovEelgpB3lyQs+x0gvuKzjaQz0matRilI=;
        b=WclDqXuAhcyeLMFhTrEVtGTPel2Ok0R+yu/lvo5QWeGWHJAX39tI2Fw2V/qqiSn3m1
         xoEQTqfMDdY7+AnpJrttEmUmNbNCCm5CrRjvfx1eS1Kpg2d5/Vc0/jgd8a1vbd6DemBs
         nZsE9Q2QrMd3Kf6lxwZ5VfjxHpEJjSB8VhQGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=+ngUJkAHrgovEelgpB3lyQs+x0gvuKzjaQz0matRilI=;
        b=UI58lomy1gK2eu7N5BTRhZ9IDYdC6PHDsuNWGajdP7iZiFjrmdDNOEuXI5erdzQqmq
         ruALbQxh+tZ9QBLFzYAJQmoiNWRfwKBrBo4sUCzNBE9C3hpMCcsgxub3c2AG6tGTLWDq
         JfFE93srT9F5/QSFm7EjhC1PCf2y1nRtZQFBD2NOPGAJ+v3TvuxBYgqOhu+1ylCpayxk
         eHwHvF45OFzcCMGigFCElUUD8r5cpPQ6g6AjD2vUwU9lae9AjTaeIaDmTk7osnI34T3w
         M89J43HJbX485hYpY8LhylBh2XNLe8Nt6XxFC1Ee7s2lXyaPri3QQJbLmDAXfLQn4N1H
         pGQQ==
X-Received: by 10.180.86.99 with SMTP id o3mr7611845wiz.10.1367991344312;
        Tue, 07 May 2013 22:35:44 -0700 (PDT)
Received: from [86.14.230.179] (cpc14-cmbg17-2-0-cust690.5-4.cable.virginmedia.com. [86.14.230.179])
        by mx.google.com with ESMTPSA id nf9sm6829153wic.3.2013.05.07.22.35.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 May 2013 22:35:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <CAG4Fb8f8vxbqwnCn1B9EfZu3sM-3-wQ2dqcR+BezPaf_XEy5Xw@mail.gmail.com>
X-Gm-Message-State: ALoCoQl3fQ1ynbxOhlJlek9DOqIwIp2CL2LE4bxZTbwBDRr7wQXXdGirecVipADLJJsWLlAG8bgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223638>

On 08/05/13 00:12, Christopher Yee Mon wrote:
> Hello,
>
> I have a setup where I have a remote non-bare repo cloned from a
> perforce workspace. It is used as a remote repo that people clone into
> their own user repos, make commits to, then push back into the remote
> repo.
Why is your p4 clone non-bare? I thought pushing into a non-bare repo 
tended to cause problems?

 > Then I periodically run the following commands in a script to
 > push those changes back to perforce.

% man cron

:-)


>
> git checkout -f
> git clean -f
> git p4 rebase --import-labels
> git p4 submit -M --export-labels
> git checkout -f
> git clean -f
>
> Sometimes, always after commits from one user's machine specifically,
> I get the following error below when pushing back to perforce at the
> remote repo. It seems to happen randomly, or at least intermittently,
> since I often can't discern any major error during git committing to
> the remote repo that precipitates this error. It does happen pretty
> reliably when I get a file conflict that I resolve and fix during
> committing though.
>
> Performing incremental import into refs/remotes/p4/master git branch
> Depot paths: //depot/sub/folder/
> No changes to import!
> Rebasing the current branch onto remotes/p4/master
> First, rewinding head to replay your work on top of it...
> Applying: A commit that has already been made previously
> Applying: A second commit that has already been made in a previous commit
> Using index info to reconstruct a base tree...
> <stdin>:15: space before tab in indent.
>                              a line of text
> <stdin>:24: space before tab in indent.
>                  another line of text
> <stdin>:25: space before tab in indent.
>                  a third line of text
> <stdin>:33: trailing whitespace.
>          a forth line of text
> <stdin>:71: trailing whitespace.
>
> warning: squelched 1 whitespace error
> warning: 6 lines add whitespace errors.
> Falling back to patching base and 3-way merge...
> Auto-merging file from second
> CONFLICT (content): Merge conflict in
> a/file/in/the/second/pre-existing/commit/file.php
> Auto-merging a/file/in/the/second/pre-existing/commit/file.php
> Failed to merge in the changes.
> Patch failed at 0002 A second commit that has already been made in a
> previous commit
>
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To check out the original branch and stop rebasing run "git rebase --abort".
>
> Traceback (most recent call last):
>    File "/usr/lib/git-core/git-p4", line 3373, in<module>
>      main()
>    File "/usr/lib/git-core/git-p4", line 3367, in main
>      if not cmd.run(args):
>    File "/usr/lib/git-core/git-p4", line 3150, in run
>      return self.rebase()
>    File "/usr/lib/git-core/git-p4", line 3167, in rebase
>      system("git rebase %s" % upstream)
>    File "/usr/lib/git-core/git-p4", line 183, in system
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command 'git rebase remotes/p4/master'
> returned non-zero exit status 1
>
> The patch is usually one that is already in the remote git repo and in
> perforce. At that point I have to run git rebase --skip, to skip the
> patch, then rerun the commands in the script again. Sometimes it's
> multiple patches that cause this problem and I have to run git rebase
> --skip repeatedly. When I check the working copy of the remote repo, I
> don't see any changes, no conflict markers, just the file.
>
> The real problem happens when I run git rebase --continue. Usually I
> end up with repeated submits in perforce when I do that, which is
> obviously a corruption of data.
>
> It sounds a lot like this error, except I don't know how git p4 is
> branching, so I don't know how to diagnose it.
>
> http://stackoverflow.com/questions/4033009/git-rebase-conflicts-keep-blocking-progress
>
> I also asked stack overflow and someone there said it's probably the
> perforce user being different from the git user info, so I had all the
> git users switch to having the same info as the perforce user info and
> that did NOT solve the problem.
>
> http://stackoverflow.com/questions/16106900/git-p4-rebase-attempts-to-reapply-past-commits
>
> I'm not sure what could possibly be causing this or how to fix it.
> Does anyone have any ideas?
>
> Thanks
> Christopher Yee Mon
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
