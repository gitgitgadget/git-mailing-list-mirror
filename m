From: Yann Dirson <dirson@bertin.fr>
Subject: Re: git-subtree:  bug, and ideas for doc improvements
Date: Mon, 13 Sep 2010 14:51:18 +0200
Organization: Bertin Technologies
Message-ID: <20100913145118.20469cda@chalon.bertin.fr>
References: <20100913135705.36f8217b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 14:58:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov8cb-0006dV-Bm
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 14:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0IMM6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 08:58:52 -0400
Received: from blois.bertin.fr ([195.68.26.9]:44006 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801Ab0IMM6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 08:58:52 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 7AC7F54358
	for <git@vger.kernel.org>; Mon, 13 Sep 2010 14:58:47 +0200 (CEST)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 58A175434D
	for <git@vger.kernel.org>; Mon, 13 Sep 2010 14:58:47 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0L8O003K1S1YD160@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 13 Sep 2010 14:58:47 +0200 (CEST)
In-reply-to: <20100913135705.36f8217b@chalon.bertin.fr>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17634.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156087>

Well, things finally seem even more complicated: in my case, the tree
is a bit more particular than what I originally thought:

* I finally understand I read the --onto description wrong.  It could
  surely be made easier to understand, by telling the user he first
  has to import the subproject history into the superproject repo
  first.  Adding an example of this would be of great use too.

* In my case the directory in which the kernel was originally located
  has since then been renamed, and git-subtree stops exploring the
  history at the rename commit, assuming the full import occured there.

  Maybe git-subtree can be taught to follow renames, but currently the
  way to handle that would seem to split in 2 steps:
  - checkout the revision before the move
  - split that part of history using the old name (without
    --rejoin, and with a different --branch name than intended in
    the end)
  - checkout the head to be split
  - split the remaining part, passing --onto the branch name that was
    passed to --branch in the first run

  However, if I try that, the root of the second split has no parent.
  I can use a graft and filter-branch - but there is either something
  else I did not understood incorrectly, or maybe a bug somewhere ?

Best regards,
-- 
Yann Dirson - Bertin Technologies
