From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 10:04:03 -0700
Message-ID: <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1KXf-0007VO-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 19:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab2HNREZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 13:04:25 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61556 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab2HNREY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 13:04:24 -0400
Received: by bkwj10 with SMTP id j10so221776bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kUf/7l2XV7HAEgXFwHZyzS1oHMF+q4NVhrOFKupAVPk=;
        b=gfAAv7X5JcNBo02iKA6WP9PI57MFQ1ZRcvLhX4oX0OJxqxgy8KNzD4srtEGo75OoLy
         dcvO6Cf09KmCZp5Ci7y96e5bo4RzcUN9bfXQy6biGrxd+qJLBStFkNhPSYN21Wjs1oDa
         NM6bhNy6pJrcuWp2W9XdGBzAKUzsuFE42nKylgJ5nBjCRI9pBsqZc15y+lIkwVTslR1S
         PogWkfkR4165ByFFTkjmukc+hTljYJBgWhPa3ngHYrf3MoiHNjC+rTO8z8a5AAEtGG71
         uV6AP3UtmV0kwFWsnEXJJv285mfbiXGxv4wrhpgZicv4XXrHO1qgI6fJmru3LqTuRl04
         L0VA==
Received: by 10.204.154.131 with SMTP id o3mr6533273bkw.87.1344963863259; Tue,
 14 Aug 2012 10:04:23 -0700 (PDT)
Received: by 10.204.132.72 with HTTP; Tue, 14 Aug 2012 10:04:03 -0700 (PDT)
In-Reply-To: <87zk5x6fox.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203413>

On 14 August 2012 01:27, Thomas Rast <trast@student.ethz.ch> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> # On branch master
>> # Your branch and 'origin/master' have diverged,
>> # and have 250 and 19 different commit(s) each, respectively.
>> #
>> nothing to commit (working directory clean)
>>
>> He asked me what to do and I told him to do what has always worked for
>> me in the past when something like this happened: gitk, "reset master
>> branch to here" (to a commit before the divergence and using --hard),
>> git pull origin master. Problem solved.
>
> There are several layers of pitfalls and misunderstandings here.
>
> * Is your work origin/master..master (that is, anything in master but
>   not origin/master) really so worthless as to make "scrap it all!" the
>   normal course of resolution?

Of course, it's master. Nobody should be working on master directly.

>   Or perhaps the real reason for the divergence is that upstream rewrote
>   its master (eeeek!), in which case you should get them acquainted with
>   the clue bat... and probably rebase instead of merge.

Upstream is fine. Nobody else is having any problems.

> * pull = fetch + merge!  Repeat this a few times until it sinks in.
>   Then print it on A0 and stick it up in your office or something.

Yes, I know.

>   For your case this means that the pull command is roughly equivalent
>   to
>
>     git fetch origin master
>     git merge FETCH_HEAD
>
>   The two-arg form of fetch does *not* update origin/master.  Assuming
>   you got the reset right, the merge will fast-forward to whatever
>   origin's master points to -- but origin/master is still the old state!

Ah, now we're getting to something I did *not* know. :-) So FETCH_HEAD
!= origin/master? I tried to find out more information about
FETCH_HEAD but there doesn't seem to be much. I have seen "FETCH_HEAD"
show up in the terminal but always just ignored it as a Git
implementation detail. When/how does origin/master get set then? I
always assumed that was part of git fetch and then git merge would
actually move master to origin/master.

> * Resetting to something that you think will fast-forward, only to then
>   fast-forward it to the newest state, is silly.  You can just reset to
>   the newest state instead.

:-) Well, yeah, now that you point it out... :-)

Still, just resetting ignores all the problems that led to the current
situation. Normally, when I reset and then FF I can be sure (if it
works) that things were not completely screwed up. At least, that has
always been my theory.

> Taking all of this together, I think you should stop using two-arg
> pull[*] or fetch, and replace your error-prone recipe with simply
>
>   git fetch
>   git reset --hard origin/master
>
> Assuming, as before, that your local work is worthless.  Is it?
> Otherwise it would be better to run something like
>
>   git fetch
>   git rebase origin/master
>
>
> [*] it's ok if you use it with an URL instead of a remote nickname

Why would that be okay? What is the difference? Isn't the nickname
just an alias for a URL?
