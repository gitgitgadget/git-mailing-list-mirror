From: Keith Amling <keith.amling@gmail.com>
Subject: Re: GIT: cherry-picking includes changes from a different commit
Date: Fri, 5 Dec 2014 19:17:37 -0800
Message-ID: <20141206031737.GB12663@gmail.com>
References: <02f801d010c6$ad32a1d0$0797e570$@hispeed.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 04:17:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5sU-00020w-S1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 04:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbaLFDRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 22:17:41 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34439 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaLFDRk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 22:17:40 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so1814166pdi.31
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 19:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=t2+w12aStWUFwgeO49Pv7+c7jNOCgsBxl/KKcC8wO00=;
        b=xbckJzTqmpnGimdpVuIBJ7Mt0bD8WmnVzCuaBrzIQu8yqiqUH4qtqnIHuG6isn0NWD
         Myw57uHNiCn33bH1PshOOws44cMlXvoCiW34RkJtP3ZyVWmZCR95TAJLq7iM1JVNLFYW
         TTSmTzuXPETvZQ66VuQqiudXK6REiCpL0biwmIOseBYNDXobX8xWq/9ZcXAos2tMc4Yl
         xWChoHipqRdmtQlyUJ3/EJELb4NhJxDlVCcMAXdhJ1dwBOiZH9S2fErNC14IbZJshOW0
         +jaCZ6L8CIFchpPowWWSQ54jTGqx4RPj044bqDA/8IKZD9eXhU2QdAVslosBfABt17aJ
         UyEA==
X-Received: by 10.66.120.47 with SMTP id kz15mr33857181pab.71.1417835860176;
        Fri, 05 Dec 2014 19:17:40 -0800 (PST)
Received: from shujo (adsl-75-36-167-121.dsl.pltn13.sbcglobal.net. [75.36.167.121])
        by mx.google.com with ESMTPSA id ty7sm24122719pac.1.2014.12.05.19.17.38
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 19:17:39 -0800 (PST)
Received: by shujo (sSMTP sendmail emulation); Fri, 05 Dec 2014 19:17:37 -0800
Content-Disposition: inline
In-Reply-To: <02f801d010c6$ad32a1d0$0797e570$@hispeed.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260934>

If you're referring to what 86ff53a7a178 has it has resolved the merge
conflict in a way that is almost certainly wrong.  If you turn on diff3
markers you can see that LHS deleted clone_test while RHS added a
function right after it.  The correct resolution is to include RHS's new
stuff but not that function whereas 86ff53a7a178 includes everything
from the RHS side of the conflict marker (thus including/adding
clone_test).

Keith

Thus spake Ruud Huynen, at Fri, Dec 05, 2014 at 09:04:28PM +0100:
> From: Ruud Huynen <ruud.huynen@hispeed.ch>
> To: git@vger.kernel.org
> Subject: GIT: cherry-picking includes changes from a different commit
> Date: Fri, 5 Dec 2014 21:04:28 +0100
> 
> I noticed when cherry-picking a commit it includes changes from this commit
> and also changes from a different commit as the one I was picking.
> 
> I was in contact with "jast" on IRC, who noticed the issue, but didn't had
> time to look further.
> 
> For a description of my problem, please read
> http://stackoverflow.com/questions/27220638/git-cherry-pick-info-about-picke
> d-commits
> 
> 
> git clone git://github.com/MythTV/mythtv.git
> git checkout fixes/0.27
> 
> git cherry-pick 30df98ce5d11b69d0b5c5114a9007cdfc79a7e9b
> # from master
> # commit also picked: 17f17e1fc51b3b4017e08f5ea35c8a7b5a64eeec
> # resulting in a conflict
> 
> For the commits and before/conflict files, see
> https://gist.github.com/FritzHerbers/4f9b0990b6bca15a70eb
> 
> As nobody could believe me, that changes from another commit are included,
> is something wrong, or is it new behavior? Why did it happen?
> With which command, can I have a listing of "intermediate" commits picked?
> How can I automate such situations?
> 
> Fritz
> git version 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
