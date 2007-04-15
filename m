From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Sat, 14 Apr 2007 17:02:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <Pine.LNX.4.64.0704141019290.18655@racer.site> <20070415000330.GG3778@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 02:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcspM-0006QZ-VA
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 02:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbXDOAmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 20:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbXDOAmq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 20:42:46 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:46025 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751693AbXDOAmp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 20:42:45 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 14 Apr 2007 17:42:44 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 14 Apr 2007 17:34:07 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070415000330.GG3778@curie-int.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44475>

On Sat, 14 Apr 2007, Robin H. Johnson wrote:

> On Sat, Apr 14, 2007 at 10:56:10AM +0200, Johannes Schindelin wrote:
>> Ah! Seems we finally have a user for shallow clones! ;-)
> Heh. I'm specifically looking at git, trying to resolve the deficiencies
> that were identified during by one of our (Gentoo) SoC2006 projects, on
> the potential migration of the Gentoo CVS. Git has matured tremendously
> since then.
>
> The primary Gentoo CVS module (gentoo-x86), has 234672 files tracked,
> and 1309603 CVS revisions. Between 350k and 500k changesets, depending
> on how you merge those revisions.
>
> Couple of the things that were identified either in the SoC project, or
> since then.
> - Shallow history checkouts are important to our low-bandwidth
>  ebuild-tree developers (people in places with 33.6k modems, because
>  the phone lines don't work well enough for 56k), or other high latency
>  setups.

note that for people on low-bandwideth lines, makeing too shallow a checkout can 
actually end up costing more over time (they will have to pull full revisions 
since they don't have the earlier versions to just pull a diff against)

> - Shallow tree (subtree) checkouts, for the developers that focus on
>  specific portions of large modules and have no interest in the rest of
>  the that tree. Eg. Releng does their work in gentoo/src/releng.

this could either be shallow tree or subproject, depending on how you end up 
orginizing things.

> - ACLs specific to subtree commits. Something similar to the cvs_acls.pl
>  that FreeBSD uses would be great. Eg gentoo-x86/sec-policy/ is
>  restricted to members of the security team (SELinux policies).

since git isn't designed with a single repository, it also doesn't need to worry 
about acl's (in fact, i don't think it has the concept of permissions at all). 
this is up to the people maintaining the 'master' repository to pull from the 
right people

> - CVS Keyword-like behavior, to specifically place the path and revision
>  of certain files into the file directly, for ease of tracking when the
>  file is removed from it's original surrounding. I know this one is
>  going to draw some flack, but it's a very common practice for a user
>  to copy a file out of the CVS tree, make some modifications, and then
>  post the entire changed version up, esp. when the size of the changes
>  exceeds the size of diff.

I'm not understanding why you need this. git tracks the file content, not the 
diffs betwen files. a developer does their work and git figures out when you do 
a pull if it's better to send the file or a diff (and if you are sending a diff, 
what you are doing the diff against, it may not be the file that had that name 
before)

there's no need to place the path and revision in the file itself.

David Lang
