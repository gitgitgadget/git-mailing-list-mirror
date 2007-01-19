From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 10:33:30 +0100
Message-ID: <81b0412b0701190133o70ab9da3ga0441e9ca16991a9@mail.gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	 <45B07875.9030506@fs.ei.tum.de>
	 <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
	 <45B07C26.4000008@fs.ei.tum.de>
	 <81b0412b0701190032w686c9403uacd9b3e1e44be307@mail.gmail.com>
	 <45B0898B.5040804@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Yasushi SHOJI" <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 10:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7q7s-0007GO-1S
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 10:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbXASJdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 04:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbXASJdc
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 04:33:32 -0500
Received: from hu-out-0506.google.com ([72.14.214.230]:8317 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965011AbXASJdc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 04:33:32 -0500
Received: by hu-out-0506.google.com with SMTP id 36so403191hui
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 01:33:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uh48RV/rQ271QmOzf1efmo32STrSNskbL4PantLSWVJr+zBf/SUicvt91N56fmHSfC8YndGFzAnbplYM2kvjoQXjM4Dy47OSOBTaTpeUrJ3btUxv/YUS9tT5b0GyUing5bMB9fZVFMHNSg+LXf0EA+d3aiFM7TuZ1FJ9qJWN0vU=
Received: by 10.78.181.13 with SMTP id d13mr88482huf.1169199210398;
        Fri, 19 Jan 2007 01:33:30 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 19 Jan 2007 01:33:30 -0800 (PST)
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
In-Reply-To: <45B0898B.5040804@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37166>

On 1/19/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Alex Riesen wrote:
> >> i would claim .git to be off limits and unrelated to the working dir
> >> (file-wise).  if you want to list files there, do a find . or so.
> >>  After all you wouldn't expect cd /usr && git-ls-files -o work there
> >> unless you have a /.git or /usr/.git, right?
> > Right, just see no practical point changing ls-file for that.
>
> right.  .git should be forbidden in higher layers already.

That's where I disagree. git-clean shouldn't clean it, but
git-ls-files will do no harm to the directory

> > I can imagine keeping hooks under git control.
> > In this case path(pwd) does contain .git component
> > (as in .hg example).
>
> doesn't work either:
>
> % cd .git/hooks
> % git add *
> fatal: unable to add .git/hooks/applypatch-msg to index

cd .git
git init
git add .
git commit

Works. And the path contains .git component. And git-clean
here is ok. The test should check if we are in $GIT_DIR
and probably $GIT_DIR/{objects,refs,logs}, not just below
.git (with ".git" anywhere in pwd, which the mercurial
example seem to suggest).
