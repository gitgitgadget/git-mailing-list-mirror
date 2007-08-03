From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 09:10:35 +0200
Message-ID: <B4109CF3-A849-40C2-BDFD-DD7CA5231FA8@zib.de>
References: <46AFCF3E.5010805@alum.mit.edu> <8b65902a0708010438s24d16109k601b52c04cf9c066@mail.gmail.com> <46B1F96B.7050107@alum.mit.edu> <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org, users@cvs2svn.tigris.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:10:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGrIR-0001S8-QW
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758531AbXHCHJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758300AbXHCHJz
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:09:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:57749 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758193AbXHCHJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:09:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7379j41015947;
	Fri, 3 Aug 2007 09:09:45 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7379f07013603
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 3 Aug 2007 09:09:41 +0200 (MEST)
In-Reply-To: <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54681>


On Aug 3, 2007, at 1:08 AM, Martin Langhoff wrote:

> Is there any way we can run tweak cvs2svn to run incrementals, even if
> not as fast as cvsps/git-cvsimport? The "do it remotely" part can be
> worked around in most cases.

What I currently do with parsecvs is to run complete imports again
on the repo. For 'normal' changes to cvs the old import can be fast
forwarded to the new import. However, if you add or remove files or
tweak revision in another abnormal way (cvs admin) this might fail.

In this case I manually search the last common commit and rebase
new commits to the old, already imported branch. I need to do this if
I already publishes the imported branch. Otherwise I can as well just
reset to the newly imported branch and rebase my work on top of it.
Some careful validation (git diff-*) is included in my workflow.

A complete run of parsecvs is fine for me because it is so fast. I run
git-filter-branch afterwards anyway to cleanup some commit messages
and author information. This takes most of the time, because it spawns
off tons of sub processes.

I'd not recommend my approach for incremental imports every hour, but
you can run it every day (although I do less often). You only need to
validate the final result (fast forward or not). The rest can be fully
automated by some shell scripting.

	Steffen
