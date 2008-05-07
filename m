From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-checkout sometimes silently fails
Date: Tue, 06 May 2008 17:19:01 -0700
Message-ID: <7v4p9bge4q.fsf@gitster.siamese.dyndns.org>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org>
 <20080506215049.GC4647@steel.home>
 <20080506171052.340d643e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 07 02:20:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXOB-0006r6-BD
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYEGATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYEGATR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:19:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYEGATQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 20:19:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BFCA925DA;
	Tue,  6 May 2008 20:19:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E12FB25D5; Tue,  6 May 2008 20:19:09 -0400 (EDT)
In-Reply-To: <20080506171052.340d643e.akpm@linux-foundation.org> (Andrew
 Morton's message of "Tue, 6 May 2008 17:10:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3A144D26-1BCB-11DD-B2B1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81391>

Andrew Morton <akpm@linux-foundation.org> writes:

> y:/usr/src/git26> git-branch -av | grep '^\*'
> * master               5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
> y:/usr/src/git26> git-checkout linux-next    
> Switched to branch "linux-next"
> y:/usr/src/git26> git-branch -av | grep '^\*'
> * linux-next           5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb

So your two local branches 'master' and 'linux-next' both point at the
same commit, 5717922.

"git checkout <branchname>" is to check out the local branch name.  You
expect "git checkout master" and then "git checkout linux-next" to check
out two different commits because linux-next _should_ have been updated to
the latest from sfr repository.  But it appears to me that that is not the
case.

Perhaps "git fetch linux-next" hasn't been run, before "git checkout" was
attempted?
