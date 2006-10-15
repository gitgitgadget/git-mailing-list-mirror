From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 15 Oct 2006 15:49:08 -0400
Message-ID: <9e4733910610151249m37c9f6abv37e07d7a801758bc@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egrgqe$1i9$1@sea.gmane.org>
	 <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
	 <20061015182303.GW20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 21:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZBz0-000116-7v
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 21:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbWJOTtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 15:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWJOTtK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 15:49:10 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:18531 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422883AbWJOTtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 15:49:09 -0400
Received: by py-out-1112.google.com with SMTP id n25so2028247pyg
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 12:49:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xmgtet+flqkXSwai5QuHJGGVlylsjZneJ72POVvguglgieAK0wBmiTBAUYCWBjaDd02ntrSyAxG4zJuZEkVrBc98Y1UaM/YX10QZ+/c92uwVCwEziWWAOkE4U9ALH5yC/dGAC8rp04+3gaajqyq+laU+r9cL3704KbMwdy2PVjo=
Received: by 10.35.113.12 with SMTP id q12mr11171971pym;
        Sun, 15 Oct 2006 12:49:08 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 15 Oct 2006 12:49:08 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20061015182303.GW20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28931>

On 10/15/06, Petr Baudis <pasky@suse.cz> wrote:
> > I am still working with the developers of the cvs2svn import tool to
> > fix things so that Mozilla CVS can be correctly imported. There are
> > still outstanding bugs in cvs2svn preventing a correct import. MozCVS
> > can be imported, but the resulting repository is not entirely correct.
> >
> > Once they get the base cvs2svn fixed I'll port my patches to turn it
> > into cvs2git again.
>
> So what exactly is the cvs2git status now? AFAIU, there's a tool that
> parses the CVS repository and that is then "piped" to git-fastimport?
> git-fastimport is available somewhere (perhaps it would be interesting
> to publish it at repo.or.cz or something), is the current cvs2git
> version available as well?

cvs2git is a set of patches that get applied to cvs2svn. The patches
modify cvs2svn to output things in a format that git-fastimport can
consume.

The problem is that there are issues with cvs2svn and how it converts
CVS into change sets that are not getting fixed. These issues are
annoying for SVN users but they are fatal for git. The exact problem
is a bug in the way CVS symbol dependencies are dealt with in cvs2svn.
The bug results in most branches and symbols being based off from 5-7
different change sets instead of a single change set. SVN then copies
from the 5-7 change sets to build the branch base or symbol base.
Copying from the 5-7 change sets is addressing the symptoms of the bug
instead of fixing the underlying problem which is incorrect ordering
of the base change sets.

-- 
Jon Smirl
jonsmirl@gmail.com
