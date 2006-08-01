From: David Miller <davem@davemloft.net>
Subject: git-ls-files prefix superset problem
Date: Mon, 31 Jul 2006 22:13:27 -0700 (PDT)
Message-ID: <20060731.221327.26966465.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 01 07:14:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7ma7-0003pn-Bd
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 07:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWHAFOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWHAFOL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 01:14:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1953
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161040AbWHAFOK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 01:14:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 89988AE43B1
	for <git@vger.kernel.org>; Mon, 31 Jul 2006 22:13:27 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24573>


I had been previously using git-1.1.3 on my local repositories
and I upgraded to the current git head:

b63fafdfd844c2037fba53b9944431c1378b4135

git commit stopped working, specifically it dies on
git-ls-files:

davem@sunset:~/src/GIT/net-2.6$ ../git/git-ls-files -- net/ipv4/tcp.c
fatal: git-ls-files: internal error - cache entry not superset of prefix
davem@sunset:~/src/GIT/net-2.6$ 

I added some debugging:

Trying get_pathspec([(null)],[net/ipv4/tcp.c])
prefixlen(0)
prefix_path() gives [net/ipv4/tcp.c]
ERROR: pathspec(net/ipv4/tcp.c)
verify_pathspec: len(9)
ERROR: len(9) ce_namelen(ce)(7) ce->name(COPYING)

Is something wrong with my index file?

I tried to rebuild it using:

git read-tree master
git checkout-index -f -a
git update-index --refresh

but I keep getting the same problem.

It happens on all of my local 2.6.x kernel GIT trees.

Any ideas?

Thanks a lot.
