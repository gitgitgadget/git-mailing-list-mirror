From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option
 "--ignore-submodules"
Date: Wed, 09 Jun 2010 01:49:21 +0200
Message-ID: <201006090149.22027.johan@herland.net>
References: <4C0E7037.8080403@web.de> <201006090011.14995.johan@herland.net>
 <4C0EC201.9060309@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 09 01:49:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM8Xx-0008Hx-P3
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 01:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab0FHXtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 19:49:25 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46875 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431Ab0FHXtY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 19:49:24 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3P0054YZIBUGC0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Jun 2010 01:49:23 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F09D81EA55B6_C0ED702B	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 23:49:22 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 500981EA3EC9_C0ED702F	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 23:49:22 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3P00B3QZIAJN10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Jun 2010 01:49:22 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C0EC201.9060309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148737>

On Wednesday 09 June 2010, Jens Lehmann wrote:
> Am 09.06.2010 00:11, schrieb Johan Herland:
> > On Tuesday 08 June 2010, Jens Lehmann wrote:
> >> After thinking some time about peoples expectations and troubles
> >> with the recursive scanning of submodules, I came up with this:
> >> 
> >> What about expanding the "--ignore-submodules" option of the git diff
> >> family with three parameters:
> >> 
> >> --ignore-submodules=all : Same behavior as "--ignore-submodules",
> >> 
> >>   submodules show never up as modified.
> >> 
> >> --ignore-submodules=untracked : Don't consider submodules as modified
> >> 
> >>   when they only contain untracked files, but do if the commits in the
> >>   superproject are different or tracked content is modified.
> >> 
> >> --ignore-submodules=dirty : Don't consider submodules as modified
> >> 
> >>   when their work tree is dirty, no matter why. This is the pre 1.7.0
> >>   behavior and doesn't recurse into submodules at all.
> > 
> > Pardon my ignorance: Does this make "dirty" a superset of "untracked"?
> > Or are they orthogonal. And how does "all" compare to "dirty"? Are
> > they synonyms, or is "all" a superset of "dirty"?
> 
> Sorry I didn't make that clear enough: "all" is a superset of "dirty" and
> "dirty" is a superset of "untracked".
> 
> There are currently (since 1.7.0) three reasons a submodule is considered
> dirty:
> 
> 1) It contains untracked content
> 2) It contains modified tracked content
> 3) It contains newer commits than those committed in the superproject

I guess 3) really means that the submodule's HEAD points to a _different_ 
(not necessarily _newer_) commit than what's referenced in the superproject.

> "all" would ignore 1), 2) & 3)
> "dirty" would ignore 1) & 2)
> "untracked" would ignore 1)

...and just to complete my understanding of this, 3) requires only checking 
the submodule's current HEAD, while 1) and 2) require traversing its work 
tree (i.e. the equivalent of a 'git status'), hence the potential 
expensiveness.

Also, I guess 2) includes both staged and unstaged modifications to tracked 
content?

Thanks for your help. All the ideas in your cover letter seem good to me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
