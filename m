From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: preventing destructive operations to central repository
Date: Thu, 15 Apr 2010 18:03:44 -0700
Message-ID: <20100416010344.GB6181@spearce.org>
References: <j2yef38762f1004151739x497106eeo190b97f3eecc153f@mail.gmail.com> <t2q76718491004151758p8862970bua5e7d60ccda8cdae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 03:04:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ZyX-00022v-WF
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 03:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab0DPBDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 21:03:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34146 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab0DPBDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 21:03:48 -0400
Received: by gwaa18 with SMTP id a18so1060450gwa.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 18:03:47 -0700 (PDT)
Received: by 10.101.137.3 with SMTP id p3mr1805049ann.178.1271379827294;
        Thu, 15 Apr 2010 18:03:47 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id b10sm6765267ana.16.2010.04.15.18.03.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 18:03:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <t2q76718491004151758p8862970bua5e7d60ccda8cdae@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145043>

Jay Soffian <jaysoffian@gmail.com> wrote:
> On Thu, Apr 15, 2010 at 8:39 PM, Brendan Miller <catphive@catphive.net> wrote:
> > Let's say you have a bare git repository writeable by a number of
> > different people. How do you prevent them from borking the central
> > repository?
> 
> Depends what you mean by borking, but you might consider starting with
> reading the "git config" man page for the following entries:
> 
> - receive.denyDeletes
> - receive.denyNonFastForwards
> 
> > Also, is there an automated mechanism to ensure that the timeline
> > stays clean? Say, force people to rebase their repositories before
> > merging into the shared repository?
> 
> In order to prevent merges, you will need to use a a receive-pack hook such as:
> 
> http://lists.gnu.org/archive/html/bug-gnulib/2008-10/msg00221.html
> 
> You might also consider something like gitosis/gitolite/gerrit
> depending upon how formal you want to be.

I think his only choice is to install a gitosis/gitolite/gerrit
solution.  Basically he needs to completely remove write access
to the repository, so developers can't muck with it directly.
That requires one of those 3 tools to provide secured proxy access.

On top of those, yea, you would then also want to configure the
receive.denyDeletes and denyNonFastForwards you mentioned above,
as well as maybe also write a custom update or pre-receive hook to
prevent merges from entering the repository.

Though preventing merges is a bit pedantic.  Eventually you'll want
to use a merge rather than a rebase (e.g. merge in a maintenance
branch to pick up its bug fixes into the main development trunk).

-- 
Shawn.
