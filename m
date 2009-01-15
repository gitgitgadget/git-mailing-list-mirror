From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 17:32:56 +0100
Message-ID: <200901151732.57023.johan@herland.net>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 17:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVAt-0005kq-1e
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 17:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538AbZAOQdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755938AbZAOQdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:33:09 -0500
Received: from sam.opera.com ([213.236.208.81]:58140 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755869AbZAOQdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 11:33:08 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n0FGWvaF003830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Jan 2009 16:32:57 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105850>

On Thursday 15 January 2009, Johannes Schindelin wrote:
> Hi,
>
> On Thu, 15 Jan 2009, Johannes Sixt wrote:
> > Thomas Rast schrieb:
> > > Let git-checkout save the old branch as a symref in LAST_HEAD,
> > > and make 'git checkout -' switch back to LAST_HEAD, like 'cd -'
> > > does in the shell.
> >
> > /me likes this feature.
> >
> > git rebase (-i or not) calls checkout behind the scenes if the
> > two-argument form is used:
> >
> >    git rebase [-i] master topic
> >
> > and 'topic' is not the current branch. You may want to add a test
> > that ensures that rebase sets LAST_HEAD in this case.
> >
> > You must make sure that commits referenced by LAST_HEAD are not
> > garbage-collected. (I don't know if this happens anyway for symrefs
> > in .git.)
>
> Note: if you used reflogs for that feature, the garbage collection
> could not have killed the commit.  However, it is quite possible that
> the branch was deleted.

I also like this feature, but as this is only a _convenience_ feature, I 
would prefer if it didn't keep the previous branch/commit alive (if 
otherwise unreachable). In any case, this new feature will _have_ to 
handle the case where there simply is no previous branch/commit (e.g. 
after a git clone or git init).

I suggest that "git checkout -" looks at the reflog, and if there is no 
previous entry in the reflog, or that entry is unreachable, then fail 
in the same manner as "git checkout garbage"


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
