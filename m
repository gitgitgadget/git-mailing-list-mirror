From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 14:03:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0504151340221.27162@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050414002902.GU25711@pasky.ji.cz>  <20050413212546.GA17236@64m.dyndns.org>
  <20050414004504.GW25711@pasky.ji.cz>  <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
  <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
  <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
  <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>  <20050414121624.GZ25711@pasky.ji.cz>
  <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
 <1113556448.12012.269.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 14:00:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMPUC-0005GE-QM
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 13:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVDOMDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 08:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVDOMDR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 08:03:17 -0400
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:7909 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261805AbVDOMDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 08:03:14 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0F366E10FC; Fri, 15 Apr 2005 14:03:13 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EA4A599EF4; Fri, 15 Apr 2005 14:03:12 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D6E328CDC3; Fri, 15 Apr 2005 14:03:12 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4BC23D857D; Fri, 15 Apr 2005 14:03:08 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113556448.12012.269.camel@baythorne.infradead.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 15 Apr 2005, David Woodhouse wrote:

> On Thu, 2005-04-14 at 11:36 -0700, Linus Torvalds wrote:
> > And "merge these two trees" (which works on a _tree_ level)
> > or "find the common commit" (which works on a _commit_ level)
>
> I suspect that finding the common commit is actually a per-file thing;
> it's not just something you do for the _commit_ graph, then use for
> merging each file in the two branches you're trying to merge.

I disagree. In order to be trusted, this thing has to catch the following
scenario:

Skywalker and Solo start from the same base. They commit quite a lot to
their trees. In between, Skywalker commits a tree, where the function
"kazoom()" has been added to the file "deathstar.c", but Solo also added
this function, but to the file "moon.c". A file-based merge would have no
problem merging each file, such that in the end, "kazoom()" is defined
twice.

The same problems arise when one tries to merge line-wise, i.e. when for
each line a (possibly different) merge-parent is sought.

The concept here is a *transaction*: when going from one tree to the next
tree via a commit, a sort of integrity is maintained, which is breached
when only looking at files and commits.

Ciao,
Dscho

