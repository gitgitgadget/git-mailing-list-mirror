From: Todd Rinaldo <toddr@cpanel.net>
Subject: Disabling Delta Compression on a fetch
Date: Thu, 8 Dec 2011 11:34:26 -0600
Message-ID: <070681D4-F87B-435E-8A3B-144E59DE722B@cpanel.net>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 19:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYiMK-0006Hy-Uo
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 19:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab1LHSGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 13:06:05 -0500
Received: from mx1.cpanel.net ([208.74.121.68]:59310 "EHLO mx1.cpanel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab1LHSGD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 13:06:03 -0500
X-Greylist: delayed 1894 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Dec 2011 13:06:03 EST
Received: from ng1.cptxoffice.net ([208.74.121.102]:25395 helo=[10.1.4.99])
	by mx1.cpanel.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.77)
	(envelope-from <toddr@cpanel.net>)
	id 1RYhrW-0005bN-Sy
	for git@vger.kernel.org; Thu, 08 Dec 2011 11:34:26 -0600
X-Mailer: Apple Mail (2.1251.1)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mx1.cpanel.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cpanel.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186582>

We run an internal gitorious server with many repos on it. Due to legacy issues, some of the repos are rather bloated with large binaries. When several changes happen and are pushed to the gitorious repo and then are later pulled back (fetch and pull) to other clones, we get a broken connection while the gitorious side is generating Delta compression. 

All of the git communication happens on 1 subnet all connected by a single gigabit switch. As I see it, the Delta Compression is actually a performance degradation in our environment.

The solution I've come up with is to set pack.window=0 in /etc/gitconfig on the gitorious server. 

I realize our need is uncommon. I realize by doing this, I am trading increased bandwidth in exchange for starting the send sooner. When I read the documentation for pack.window, it seems more a side effect than the original intent that this variable disables Delta Compression when set to 0.

My question is: Are there are any unintended consequences of this approach anyone can think of? 

Thanks,
Todd Rinaldo
