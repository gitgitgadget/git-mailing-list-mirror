From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: gc and empty packed-refs
Date: Sun, 15 Jun 2008 19:27:12 -0400
Message-ID: <20080615232712.GA28979@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 01:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K81dq-0004Y0-JR
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 01:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbYFOX1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 19:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbYFOX1Q
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 19:27:16 -0400
Received: from aeol.lifeintegrity.com ([209.135.157.90]:41455 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbYFOX1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 19:27:14 -0400
Received: from vent.lifeintegrity.com (pool-71-174-251-18.bstnma.fios.verizon.net [71.174.251.18])
	by submission.lifeintegrity.com (Postfix) with ESMTP id B8DFDD5C84B
	for <git@vger.kernel.org>; Sun, 15 Jun 2008 23:27:13 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id F1DF330434E; Sun, 15 Jun 2008 19:27:12 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85154>

So I ran `git gc` as a user with group write access to my repository, then
noticed that remote clients complaining:

allan@vent:~/var/git/www$ git pull
You asked me to pull without telling me which branch you
...
allan@vent:~/var/git/www$ fatal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly

which appears to be related to the packed-ref file being empty (as well 
as info/refs) on the server.  I copied the two files from my client to
the server to get things going again.  No idea if this is a sane thing 
to do, but at least my clients will pull again.

`git fsck` gives me dangling blob files:

dangling blob 9b08c9937daee703d97aa487d258f93ab92eb691
dangling blob 7361898075e647e47c8835320e5481e94d8ef275
dangling blob 359e9687e64d8f7a9fd039131fd733a9726a1bad
dangling blob a64f34e998ae9db80ef8ea33cb30e2486829d308
dangling blob a913d295a26ccda2fac7fc051f2e23400f187035
dangling blob e6773de701ef3b7a9e8c80e2319dcd4629702220

It seems gc is causes corruption.


/Allan
