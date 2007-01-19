From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 09:32:02 +0100
Message-ID: <81b0412b0701190032w686c9403uacd9b3e1e44be307@mail.gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	 <45B07875.9030506@fs.ei.tum.de>
	 <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
	 <45B07C26.4000008@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Yasushi SHOJI" <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 09:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7pAV-0002Nf-7N
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 09:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbXASIcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 03:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbXASIcI
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 03:32:08 -0500
Received: from hu-out-0506.google.com ([72.14.214.232]:58084 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964939AbXASIcF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 03:32:05 -0500
Received: by hu-out-0506.google.com with SMTP id 36so391096hui
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 00:32:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pV4quORuBUxVuBXZe0IPsjkOka2P7+fgRngQ+iRJU50qHKWFQA7FUMtlZCoCQMZJ07+/gU6sJKMI1Fgv7s5UtebpJMQd5CLDnMkCNTGv+vIYo3Au7su28gdwsOwCHTGLnm06Peizxa4WinYManx46dHuEYNZf4lrUK3VHCIvTRM=
Received: by 10.78.17.1 with SMTP id 1mr1761440huq.1169195522843;
        Fri, 19 Jan 2007 00:32:02 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 19 Jan 2007 00:32:02 -0800 (PST)
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
In-Reply-To: <45B07C26.4000008@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37162>

On 1/19/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> >> I guess you are not serious.  I wonder, why does git-ls-files ever
> >> list files under .git?  I'd just say:  fail if you want to list $GIT_DIR.
> >
> > Not list. Clean. What's wrong with listing them?
>
> i would claim .git to be off limits and unrelated to the working dir
> (file-wise).  if you want to list files there, do a find . or so.
>  After all you wouldn't expect cd /usr && git-ls-files -o work there
> unless you have a /.git or /usr/.git, right?

Right, just see no practical point changing ls-file for that.

> >>  Maybe other tools should do so as well.
> >>
> >> % cd .hg && hg status -A .
> >> abort: path contains illegal component: .hg
> >>
> >> I think this is a sensible thing to do.
> >
> > No, it isn't. It is not unlikely to have repo in repo
> > (and some people already have them).
> > Mercurial is wrong here.
>
> what do you mean with repo-in-repo?  something like .git/.git?

Actually, I meant a/b/, with existing a/.git and b/.git, which is
obviously is not a case here (nor in mercurial). Stupid me

>  My suggestion does not break this:
>
> % mkdir foo && cd foo && git init
> % cd .git && git init
> % git ls-files -o
> HEAD
> config
> description
> hooks/applypatch-msg

I can imagine keeping hooks under git control.
In this case path(pwd) does contain .git component
(as in .hg example).

> Here the repo root is "foo/.git" and not "foo".
>
> So my suggestion still stands:  .git is off limits.
>

Ok. Have nothing strong against this
