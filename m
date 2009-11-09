From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 21:34:04 +0300
Message-ID: <20091109183404.GI27126@dpotapov.dyndns.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Z4J-0002Ln-Qj
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbZKISeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 13:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbZKISeD
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:34:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:56019 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZKISeB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 13:34:01 -0500
Received: by fg-out-1718.google.com with SMTP id d23so848917fga.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 10:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1fOdLWgrJWM7e91rMGNVPz0yzQcrZBWsq7YnXkmveuQ=;
        b=Fx5aL6cz6R1Z4nWMbAWPhFy/Y/khGo85iPS2WM1sU6jzYT8GVa0A8UuI/NpZAUH+zb
         wrAqDXaeNK8ZIe3+fH4gorbgfFKazlUja/R7zDYntNQ/XiZUavTYvanSqVi+yMHjBpeJ
         oxJuf40ku4zcMgtFwZpzUGESkXwxu4VgPVo34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Vc2jJupWd3NIz+hsiF/LYwYeHLYg/Z6o84t67qEbxSZVRMtDLnKnkN2YlpVVTmQLGG
         1ajw0QzeD/6g+akMjJeoMZ2eLS1SM8ocfFZOeYBKg2sEE3qis92csLaFYezv363dQz/p
         5wQ2Q+qv5BKyxF4JGVqJja0oYPFuV1wiWfJ/s=
Received: by 10.87.58.28 with SMTP id l28mr8466024fgk.45.1257791645426;
        Mon, 09 Nov 2009 10:34:05 -0800 (PST)
Received: from localhost ([91.78.51.65])
        by mx.google.com with ESMTPS id e20sm7414629fga.15.2009.11.09.10.34.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 10:34:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20091109T170054-451@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132503>

On Mon, Nov 09, 2009 at 04:11:48PM +0000, Dmitry Smirnov wrote:
> Dmitry Potapov <dpotapov <at> gmail.com> writes:
> 
> 
> > Actually, in most use cases, there is no reason to have more than one
> > working tree. Git is designed to work well with plenty branches and one
> > working tree. So, switching between two branches and recompiling a few
> > changed files is much faster then going to another directory and try to
> > work there, because when you go to another directory, you may hit cold
> > cache and disk is *slow*... Another thing is that you can do a lot of
> > things without checking out some branch. You can grep any revision in
> > your repository, you can insect any file from it, etc and you do not
> > have to checkout this revision in your working tree.
> 
> Shouldn't I even worry about my not yet commited changes before switching the 
> branch?

You probably want to use 'git stash save' and when you return back you
just do 'git stash pop'. Also, keep in mind that you can amend any
previous commit using 'git commit --amend'.

> 
> I would say that this approach does not work if the build and test could take
> significant time.

Yes, but then I do not see any reason to do any time consuming building
and testing in the working tree. I create a snapshot of the interesting
version using 'git archive' and then run build&test on it... In this
way, I can make sure that the archive I deliver is tested properly. If
you do your testing in the working tree, sometimes uncommitted or some
other files that are left over from previous builds may affect result.
So, if it takes considerable time anyhow, why do not do clean build and
test? And if you worry about compilation time, you can use ccache.


Dmitry
