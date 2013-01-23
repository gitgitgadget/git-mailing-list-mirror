From: John Keeping <john@keeping.me.uk>
Subject: Re: Moving commits from one branch to another
Date: Wed, 23 Jan 2013 14:49:41 +0000
Message-ID: <20130123144941.GO7498@serenity.lan>
References: <000a01cdf961$bcf773d0$36e65b70$@de>
 <20130123121203.GM7498@serenity.lan>
 <000b01cdf973$cc685fc0$65391f40$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Schulze <algroth@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 15:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty1eT-0005S6-LH
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 15:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab3AWOts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 09:49:48 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46061 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab3AWOtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 09:49:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 1DD06606566;
	Wed, 23 Jan 2013 14:49:47 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id czL1zeTaLUJ7; Wed, 23 Jan 2013 14:49:46 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 977DA6064CF;
	Wed, 23 Jan 2013 14:49:46 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8501E161E4E3;
	Wed, 23 Jan 2013 14:49:46 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n-QaElNWE4Cg; Wed, 23 Jan 2013 14:49:46 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 943BB161E559;
	Wed, 23 Jan 2013 14:49:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <000b01cdf973$cc685fc0$65391f40$@de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214324>

On Wed, Jan 23, 2013 at 03:13:19PM +0100, Stefan Schulze wrote:
> > > Is there any way to move/copy commits from one branch to another
> > > without a common base-commit and without a forced push of master?
> >
> > Did you try "git rebase" with "--onto"?  You probably want something
> > like this:
> > 
> >     git rebase --onto svnbranch publishedToSvn master
> 
> I already tried this some days ago, but wasn't sure about the result. The
> resulting history looks exactly what I expected, but all the commits are on
> master after executing this commands and svnbranch only contains the
> original two commits (svn-commit creating the root directory and the
> cherry-picked commit from master)

Ah, I missed that you wanted to update svnbranch.  I don't think there's
a single command that will do that, but this should work:

    git rebase --onto svnbranch publishedToSvn master^0
    git checkout -B svnbranch HEAD

This uses a detached head to avoid modifying the wrong branch and then
updates "svnbranch" to point at that after the rebase.

> Does the current branch matter if I call git-rebase with the
> <branch>-argument?

No it will checkout that branch first.


John
