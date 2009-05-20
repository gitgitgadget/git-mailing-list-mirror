From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Reverting an uncommitted revert
Date: Tue, 19 May 2009 20:34:40 -0600
Message-ID: <4A136C40.6020808@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 04:41:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6bkI-0003bU-47
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 04:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbZETClW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 22:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZETClV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 22:41:21 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33770 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZETClU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 22:41:20 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2009 22:41:20 EDT
Received: (qmail 10977 invoked by uid 399); 19 May 2009 20:34:40 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@24.10.200.9)
  by hsmail.qwknetllc.com with ESMTPAM; 19 May 2009 20:34:40 -0600
X-Originating-IP: 24.10.200.9
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119578>

I had an interesting experience the other day I'd like to share.  It is 
a story of my stupidity plus a bug in the latest version of the Mac OS X 
'git gui'.

I had spent several evenings working on a piece of source code.  It was 
basically working, but I hadn't committed anything yet. Yes, I know I 
should have made a branch and performed incremental commits, but I 
didn't.  This is why I was stupid.

Because of a busy week, it was many days before I could get back to what 
I was working on.  By then, I had forgotten what I was doing, and so I 
pulled up the handy 'git gui' to show me my diffs.

'git gui' showed me a single whitespace change in the diff.  The scroll 
bar extended from top to bottom in the diff window and wouldn't move.  
(This is the bug, which is easily reproducible.)  I thought, "Gee, 
that's weird.  I thought I'd made more changes."  Not wanting the silly 
whitespace change, I chose Commit->Revert Changes from the menu.

A couple hours later, I was pulling my hair out trying to find the 
change that I knew, deep down, I had reverted.

I also knew there was no support for putting a reverted change in the 
reflog, but hey, the reflog has saved me before.  I looked.  It wasn't 
there.

So here's the idea: What if Git, upon a revert change (or git reset 
--hard HEAD), "committed" the changes to be reverted and then did the 
revert with a 'git reset --hard HEAD^'?  The reverted files would be 
disconnected from a branch, but they would be available in the reflog to 
retrieve.

Or do I just not 'get it'?

Thanks!

Josh
