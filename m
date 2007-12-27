From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: Anomalous conflicts during git rebase
Date: Thu, 27 Dec 2007 23:57:03 +0100
Message-ID: <20071227225703.B33A25A709@dx.sixt.local>
References: <m3ir2ju5ce.fsf@euroclydon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: adr3nald0s@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 23:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J81fY-00065W-7S
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 23:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbXL0W5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 17:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbXL0W5I
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 17:57:08 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:47476 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbXL0W5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 17:57:07 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id EA76B33D32;
	Thu, 27 Dec 2007 23:57:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B33A25A709;
	Thu, 27 Dec 2007 23:57:03 +0100 (CET)
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69271>

adr3nald0s@gmail.com wrote:
> On a clone of linux-2.6:
> 
>     git checkout -b topic/test v2.6.15
>     touch drivers/a-file.c
>     git add drivers/a-file.c
>     git commit -m 'Add a file'
>     git checkout -b temp0 v2.6.16
>     git rebase topic/test
> 
> I get the following:
> 
>     Applying [ACPI] handle ACPICA 20050916's acpi_resource.type rename
..
>     CONFLICT (content): Merge conflict in drivers/char/hpet.c
..
> Is this a bug, or is there a reason I am seeing conflicts in files
> I've never touched?

You are using the rebase the wrong way round.

The (first) argument to git rebase tells *where the current branch* will be
moved to, and not *which branch to move*.

So, instead of last two commands (git checkout...; git rebase...) you say

    git rebase v2.6.16

and you don't need the branch temp0.

-- Hannes
