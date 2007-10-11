From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: yet another workflow question...
Date: Thu, 11 Oct 2007 16:37:57 +0200
Message-ID: <470E3545.4060005@viscovery.net>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfzAy-0007qO-Bf
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbXJKOiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 10:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbXJKOiC
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:38:02 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:60580 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbXJKOiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 10:38:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfzAc-0006dv-DD; Thu, 11 Oct 2007 16:37:50 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 207F8A33B; Thu, 11 Oct 2007 16:37:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60601>

Patrick Doyle schrieb:
> I've been working on my project and I realize that I have 3-4 files
> modified with two orthogonal sets of changes.  (I didn't realize this
> until I said to myself -- "Self, I should really check in these files
> before I go too much further down this path".)  So I start "git
> diff"-ing the files and I find that most files have differences
> related to only one change or the other, but one file has differences
> related to both changes.
> 
> What do others do in this situation?
> a) Not allow themselves to get into this situation in the first place
> by careful planning?
> 
> b) Copy the file to "file.bothchanges", edit out one set of changes,
> commit that with one log message, edit back in the other set of
> changes, edit in the other set of changes, commit that with another
> log message?
> 
> c) Use some sort of automation to do option (b) for them?
> 
> d) Something else?

Use git-gui.

Stage the files relevant for the first change. In the file where you have an 
overlap with the second change, you can right-click in the diff pane and 
select "Stage Hunk for Commit" on the hunk relevant for the first change.[*]

Commit with a message.

Stage the remaining changes and commit again.

At this point, I usually check out HEAD~1, i.e. the state *without* the 
second change, and compile and test to make sure I have a bisectable history.

[*] Of course, this works only if the changes are not in the same hunk. If 
there are at least 3 unmodified lines between the changes, you can choose 
"Less context" until they are in separate hunks.

-- Hannes
