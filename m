From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Linear history *and* share a branch?
Date: Tue, 10 Apr 2012 18:54:54 -0500
Message-ID: <4F84C84E.1060602@gmail.com>
References: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 01:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHktq-0008K4-Q4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 01:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab2DJXy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 19:54:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49318 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab2DJXy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 19:54:57 -0400
Received: by obbtb18 with SMTP id tb18so461284obb.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yq2ewHIE1zy1HtYRGG2xBU+2NNI6CbS2DwiLeWyZ5hs=;
        b=tI8IJyCl3O/d4tC6ftlG2znGORQAg2yHukLhL6P2QG6hokUC7ALXtlTVQ4+8ZIP1Vm
         OYVQsTBVaDsaa0fENPHLDtW9cNp06ZGy8BO8kVQns+GC5NwYd9q4whCpdpmAEx1i+8yY
         EqasZ4ua5s2bafQYOKdyzXo0dJHs479PoHIhzECG0g+mB8HQiMbWCtahI56G3TVxTAwy
         dG37/qxEzhEFQJot+J+kqqem4c9c77UcY1rsbZw/Zfku0WcsJKJnvsWkCMc2uBpr5GxC
         igjYQdW1bzTXKPhs5epDjs+5kNwWaPfUgcwvv0xU9qOHsSFUuTsHIL+I5ffZ4PM+sST+
         gQwQ==
Received: by 10.182.127.20 with SMTP id nc20mr18613905obb.66.1334102096656;
        Tue, 10 Apr 2012 16:54:56 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id yv3sm1028551obb.3.2012.04.10.16.54.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 16:54:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195139>

On 4/5/2012 3:48 PM, Hilco Wijbenga wrote:
> Hi all,
>
> We have been using Git for about a year now in a very small team. So
> far, everyone has worked on their own local branches and been doing
> "git rebase master" to make sure their local branches stay in synch.
> This way we have a nice linear history in master.
>
> Recently, it has become useful to share one of these local branches
> between two devs. Of course, when one of the devs does his usual
> "git rebase master", he screws up the other dev's environment. Our
> solution has been to keep rebasing the shared branch but to actually
> work on a local branch that is rebased on the shared branch. By
> judiciously using "git reset" and "git pull" on the shared branch the
> two devs can keep the shared branch in synch and then use "git
> rebase shared-branch" on their local branch to keep it in synch to.
> While this works, there is probably a better/simpler solution.
>
> Should we simply do "git merge master" instead of "git rebase
> master"? And then do something at the end when we are about to merge
> the shared branch back into master to guarantee linear history? Your
> thoughts and ideas would be greatly appreciated.
>
I haven't tried this, but at the point when your topic branch is ready 
for master and the only thing left to do is make the history linear 
before publishing it you could: rebuild the branch using cherry pick. 
You could cherry pick only the merge-commits over and that would drop 
all the merge history.  You would end up with linear history.  Then you 
could further cleanup that linear history with rebase -i before you 
publish it.

I haven't tried cherry picking a merge commit so I'm assuming it only 
brings over the commit content and not the merge history.

v/r,
neal
