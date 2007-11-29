From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: To push into a non-bare repository, or not to push into it...
Date: Thu, 29 Nov 2007 01:33:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711290122440.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 02:34:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxYHy-0000CQ-4X
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758659AbXK2Bdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761407AbXK2Bdh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:33:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:39728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761167AbXK2Bdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:33:36 -0500
Received: (qmail invoked by alias); 29 Nov 2007 01:33:34 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp036) with SMTP; 29 Nov 2007 02:33:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HKA0VJSZHnADxqH0h8NavOkqtrjkeVwpUjutCbe
	AA23bkHbRpajwH
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66490>

Hi,

how about resolving this recurring subject of discussion by introducing a 
config variable, say "branch.allowPushingIntoHEAD".  We'd teach git-init 
to set it to "false", and receive-pack would refuse to update HEAD if it 
is "false", _unless_ core.bare = true.

Of course, we would default the value to "false" to leave existing setups 
functional.

However, if it is "true" (and core.bare is not true) -- which would need 
user interaction to explicitely set it -- receive-pack would also make 
sure that the working tree is clean (locking the index for the complete 
operation), and call "read-tree -u -m HEAD" in the end.

By refusing the update we would be able to give users a severe *WARNING*, 
but a hint how to put their HEAD in the noose.

I'd do a patch, but I am 1) tired, and 2) more thinking about that 
git-repack enhancement for repo.or.cz.

Ciao,
Dscho
