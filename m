From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Moving commits from one branch to another (improving my git fu!)
Date: Tue, 22 Oct 2013 17:00:30 +1100
Message-ID: <CAGyf7-EDtNPhAGm21YmPSZfWmdjhKejhmoWNG3Au5LaorOodCw@mail.gmail.com>
References: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>
To: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 08:00:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYV1I-0003FA-1h
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 08:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab3JVGAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 02:00:32 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53789 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750868Ab3JVGAb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 02:00:31 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]) (using TLSv1) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUmYUfy61e1aIkOfc04tXqygzf4L0Nbr6@postini.com; Mon, 21 Oct 2013 23:00:31 PDT
Received: by mail-ob0-f181.google.com with SMTP id va2so6865235obc.26
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 23:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lRECkp35FmFGzaahUggy1XiQV3frgdBc6wlr4/YRrXE=;
        b=YxgOLHQHIbjql5nOeLCbTe21sEqSTt7AVyvLmK+b1QM9GCU3smLhs2MhAvO5+SAcS6
         zkV7Fq5gELVmiVGf/u4Ot/aKefvL2rduWIZkCGrz3FAyI8xuqInS6Dl3DDL0mQ0x3l6j
         422dQh5FRS3YmOaCwDt1cztiiUVzrWRI+d0I/OIJYsl33m5QD19C5CNWeYu+kcUyB21u
         Vx31y0mLxslp5Y9XR2uTOfnIPs3gwHpCqqYYvgu+VWi4vaUFrIEp9Lra+tuvib5SxuCq
         0MP6DzzIuE1tsPf3ympJBmt96YsTZUg553xhTuaskDyDI3jrDmZ+wkUXtzVodmllJzw7
         G0iA==
X-Gm-Message-State: ALoCoQmxbBGHrSDq5TGdZqe1tRtVw45Ok7uXNfEZpM8abPw7fiec3XX7WmsFjj38iuAth3CcnTQOlOfUEqVBHc5J74epS6vapmwcrQkTWJsEdhvmOnrAoCT8ZrDDxVhvX9qh0aNCQ2mv/xhIOx7pPWtlrAYIE+yMDQ==
X-Received: by 10.182.213.97 with SMTP id nr1mr397653obc.48.1382421630813;
        Mon, 21 Oct 2013 23:00:30 -0700 (PDT)
X-Received: by 10.182.213.97 with SMTP id nr1mr397625obc.48.1382421630277;
 Mon, 21 Oct 2013 23:00:30 -0700 (PDT)
Received: by 10.182.92.114 with HTTP; Mon, 21 Oct 2013 23:00:30 -0700 (PDT)
In-Reply-To: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236456>

A quick glance at your command line and the man page for git rebase
suggests the problem was you didn't actually use --onto. I believe the
correct command would be:

git rebase --onto dev stable topicA


That should start by determining which commits are one topicA but not
stable and then checkout dev and apply those new commits.


Hope this helps,
Bryan Turner

On 22 October 2013 16:38, Mandeep Sandhu <mandeepsandhu.chd@gmail.com> wrote:
> Hi All,
>
> I'm in a bit of a pickle! :) So I've come to ask for help from the guru's here.
>
> My story is not unique but somehow the various suggested solutions
> don't seem to work in my case.
>
> * I was working on a feature which was supposed to be done off our
> 'dev' branch. But instead I forgot and branched out my topic branch
> from master (or as we call it 'stable').
> * I did 2 commits and finished off my work. Only later realizing that
> it had to be done off 'dev'.
> * Now I want to move my 2 commits (which are the top 2 commits on my
> topic branch) to a new branch which is branched off 'dev'.
>
> $ git branch
> * topicA
> * stable
> * dev
>
> topicA was based on stable. But now I want to base it dev.
>
> So I did what was most suggested, i.e use 'git rebase --onto'.
>
> Here's what I did when I was in topicA:
>
> $ git rebase dev stable topicA
> (this was suggested in the manpage as well).
>
> This started off a massive rebase operation, because the 'dev' branch
> is vastly diverged from stable, and a lot of conflicts started
> appearing.
>
> I'm not sure if I'm doing it right here, so can anyone suggest whether
> this is right or do I need to do it differently?
>
> PS: Please CC me (mandeepsandhu.chd@gmail.com) in your reply as I'm
> not currently subscribed to the list.
>
> Thanks for your time.
>
> Regards,
> -mandeep
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
