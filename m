From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git reset --hard and uncommitted files in index
Date: Fri, 22 May 2009 08:43:53 +0200
Message-ID: <4A1649A9.5090606@viscovery.net>
References: <gv52s4$e7h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Guyot-Sionnest <dermoth@aei.ca>
X-From: git-owner@vger.kernel.org Fri May 22 08:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7OUl-0001GM-Jn
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 08:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbZEVGn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 02:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZEVGn7
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 02:43:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65253 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbZEVGn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 02:43:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M7OTx-0004JZ-Oh; Fri, 22 May 2009 08:43:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 77E136B7; Fri, 22 May 2009 08:43:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <gv52s4$e7h$1@ger.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119713>

Thomas Guyot-Sionnest schrieb:
> Today I was working on a script that modify many files on a repository,
> therefore during testing phase I needed to reset --hard to get back to
> the last commit. This operation does not affect untracked files.
> 
> Since i was going to commit the script, at some point I decided to add
> it to the index so I could track/revert changes to it. On the next reset
> Git deleted the script.
> 
> Fortunately "git add" creates an object that I could easily recover
> (thanks to wereHamster on #git for pointing that out), however I was
> wondering if it's really the desired behavior to *delete* a file that
> have been added to the index but isn't on the previous commit? Shouldn't
> git just unstage it?

No, the behavior is by design. Its purpose is to return the working
directory to a clean slate. For example, after a conflicted merge the
merged branch may have brought new files, but you wouldn't want to keep
them around after the cleanup.

'git reset --hard' is "do what I say", not "do what I mean". ;-)

-- Hannes
