From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Is my repository broken?
Date: Tue, 8 Apr 2008 23:02:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 00:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjLuy-0002iq-EH
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 00:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbYDHWCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756553AbYDHWCu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 18:02:50 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:47115 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754864AbYDHWCs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 18:02:48 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4C469144BF2
	for <git@vger.kernel.org>; Tue,  8 Apr 2008 23:02:47 +0100 (BST)
Received: (qmail 19759 invoked by uid 103); 8 Apr 2008 23:03:30 +0100
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.029249 secs); 08 Apr 2008 22:03:30 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 8 Apr 2008 23:03:30 +0100
X-X-Sender: jp3@kaos.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79036>

Having just converted a subversion repository to git using a custom 
fast-import based script, I realised that I had forgotten to add some 
users to the mapping table - so I thought that filter-branch would save me 
from having to redo the 72hr import.

At which point I discovered that I had a number of commits that git didn't 
like.  In particular I had a number of commits with an empty ident, and a 
number with more than 16 parents (actually mostly these are the same 
commits - but I don't think that's relevant).  When filter-branch tries to 
process these commits it can't commit them - and so I end up losing a 
number of refs.

I can fix the empty ident using the msg-filter in filter-branch, and I can 
work around the 16 parent limit by building a custom git with MAX_PARENT = 
32.  However - will having commits with more than 16 parents break things 
for un-modified git?  The commits in question were originally created in 
CVS, so the parenting is kinda 'real' for some value of real - but we are 
talking revision 4000/40000, so I don't mind arbitrarily limiting the 
commits to 16 parents, but I would prefer to avoid redoing the 72hr import 
if possible.  (Perhaps I can also 'fix' the parenting in filter-branch?)

Also, shouldn't fast-import be imposing the same restrictions on what you 
are allowed to commit that the main git tools do?  If not, are such 
restrictions documented so that I can apply them in my conversion script?

(28G Subversion repository to 7.1G git repository (before repacking) ... 
not bad :D)

-- 
Julian

  ---
Agnes' Law:
 	Almost everything in life is easier to get into than out of.
