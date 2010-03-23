From: Thomas Koch <thomas@koch.ro>
Subject: Re: rethinking patch management with GIT / topgit
Date: Tue, 23 Mar 2010 09:09:16 +0100
Message-ID: <201003230909.16414.thomas@koch.ro>
References: <201003201802.51129.thomas@koch.ro> <201003220859.41820.thomas@koch.ro> <20100322193035.GM3533@machine.or.cz>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, vcs-pkg-discuss@lists.alioth.debian.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Mar 23 09:09:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtzB4-0005B5-96
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 09:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab0CWIJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 04:09:23 -0400
Received: from koch.ro ([88.198.2.104]:40223 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822Ab0CWIJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 04:09:21 -0400
Received: from 84-72-85-88.dclient.hispeed.ch ([84.72.85.88] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1Ntz7d-0002RN-Iv; Tue, 23 Mar 2010 09:05:57 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.32-2-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <20100322193035.GM3533@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142995>

Petr Baudis:
> On Mon, Mar 22, 2010 at 08:59:40AM +0100, Thomas Koch wrote:
> > In all three cases you're free to either keep or throw away the old
> > patchset.
> 
> Yes, but to the same degree e.g. with StGIT I'm free to keep the head of
> the old patch series. That does not mean the operation *preserves* the
> history, only that the history is still around somewhere in the
> repository, however it won't be around in other incarnations of the
> repository and it will not be connected in any way to the current
> version of the patchset.
> 
> Yes, if you are lucky you can figure out the name of the previous
> version, but it's like starting development of each new kernel version
> by a clean import of the sources.

Hi Petr,

let me copy the list of methods from my last mail:

1) checkout new patch branches from the top of the old patch branches and 
merge upstream into each of them

2) recreate (like rebase) the full history of the patch branches on top of the 
new upstream

3) collapse the branch history and create one commit per patch branch on top 
of the new upstream

>From these methods, 3) loses all history, 2) loses some history but preserves 
the individual history of one patch branch on a new base and 1) preserves all 
history. Let me give an example for method 1). 
You've got a patchset identified by the prefix debian/. Now you want to 
package a new upstream but need to retain the old patchset in case of security 
updates in Debian stable. Debian stable has version 0.1, new upstream is 0.2.
So you
- rename the old patchset from debian/ to debian-0.1/
- clone/copy/recreate (pick a name) a new patchset debian/ on top of 
upstream/0.2. This is done by merging upstream/0.2 into each debian/* branch.
- Once you don't maintain version 0.1 anymore, you can delete the debian-0.1/* 
branches

After these steps, the debian/ branch still contains pointers to all commits 
from the debian-0.1/* branches.
It's an additional question, how to deal with commits that are done in 
debian-0.1/* after the new upstream merge.

Best regards,

Thomas Koch, http://www.koch.ro
