From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 16:42:49 -0500
Message-ID: <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil>
References: <m31w2mlki4.fsf@localhost.localdomain>	<willow-jeske-01l5PFjPFEDjCfzf-01l5zrLdFEDjCV3U> <willow-jeske-01l61=64jMFEDjCiBE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 23:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBGJ3-0006iE-2V
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 23:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYFXVnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 17:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYFXVnH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 17:43:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34470 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYFXVnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 17:43:06 -0400
Received: by mail.nrlssc.navy.mil id m5OLgoCs022925; Tue, 24 Jun 2008 16:42:50 -0500
In-Reply-To: <willow-jeske-01l61=64jMFEDjCiBE>
X-OriginalArrivalTime: 24 Jun 2008 21:42:50.0309 (UTC) FILETIME=[3FE38F50:01C8D643]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86153>

David Jeske wrote:
>> -- David Jeske wrote:
>>> - improve the man page description of "reset --hard"
>>> - standardize all the potentially destructive operations
>>> (after gc) on "-f/--force" to override
>> The thing is 'force' is not always the most descriptive word
>> for the behavior that you propose enabling with --force.
> I'm not talking about switching "git reset --hard" to "git reset -f". I'm
> talking about requiring a "-f" option to "git reset --hard" when it would
> destroy or dangle information.

I only have the same advice I gave to Boaz. I think you should try to adjust
your workflow so that 'git reset' is not necessary. It seems that for the
functions you're trying to perform, 'checkout' and 'branch' should be used rather
than 'reset'.

Again, as I mentioned to Boaz, there is really no benefit to reusing a single
branch name if that is what you are trying to do. The cost of branching in git
is 41 bytes i.e. nil. The cost of updating the working directory which happens
during the 'reset --hard' is exactly the same whether I do
'reset --hard <some_branch>' or 'checkout -b new_branch <some_branch>'.

In nearly every case where I, personally, have used 'reset --hard', I was using
it because I didn't care what the current state of the working directory or the
index were. They were wrong and I was resetting to the right state. I believe
this was the intended use for the command.

I'm not sure why you want to use reset so often. If there is something in the
documentation that led you to want to use reset maybe it can be changed so that
other users are not led in the same way.

About the reflog..
The reflog is not a storage area. It's just a log, like /var/log/messages. It is
there to provide a way to recover from mistakes. Mistakes are usually recognized
fairly quickly. If you have not realized that you have made a mistake after 30
days, it may be pretty hard to recover from since people have imperfect memories.
If we did not garbage collect the reflog it would just continue to grow appending
useless piece of information after useless piece of information.

-brandon
