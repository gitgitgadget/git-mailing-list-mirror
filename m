From: Jon Loeliger <jdl@freescale.com>
Subject: Some ASCII Art
Date: Thu, 06 Oct 2005 13:05:24 -0500
Message-ID: <1128621923.29904.30.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 06 20:07:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENa7W-0005xW-1r
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 20:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVJFSF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 14:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJFSF1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 14:05:27 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:53719 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751270AbVJFSF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 14:05:26 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id j96IDoAu010271
	for <git@vger.kernel.org>; Thu, 6 Oct 2005 11:13:50 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j96IBesY028284
	for <git@vger.kernel.org>; Thu, 6 Oct 2005 13:11:41 -0500 (CDT)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9777>

Guys,

I tend to be a visual learner.  So I made up some ASCII
art and annotated it with some Git operations and stuff.

First, I'd love to have any feedback on these drawings,
especially if it actually misrepresents things.  If there
are obvious additions to these, that'd be nice to know too.

Second, if you think they are generally useful, please
feel free to add them to whatever documentation seems
appropriate.  (If you want a patch to a certain file
and a Sign-Off, let me know!)

Thanks,
jdl


Fundamental Git Index Operations
================================

                    +-----------+
                    | Object DB |
                    |  Backing  |
                    |   Store   |
                    +-----------+
                       ^
           write-tree  |     |
             tree obj  |     |
                       |     |  read-tree
                       |     |  tree obj
                             V
                    +-----------+
                    |   Index   |
                    |  "cache"  |
                    +-----------+
                       ^
         update-index  |     |
             blob obj  |     |
                       |     |  checkout-index
                       |     |  blob obj
                             V
                    +-----------+
                    |  Working  |
                    | Directory |
                    +-----------+


Git Index Operations
====================


                    +-----------+
                    | Object DB |
                    |  Backing  |
                    |   Store   | -----------+
                    +-----------+            |
                       ^                     |
          commit-tree  |     |               |
           commit obj  |     | read-tree -m  |
                       |     | tree obj      |
                       |     |               |
                             V               |
                    +-----------+            |
                    |   Index   | <- - - - - +
                    |  "cache"  | - - - - - >+
                    +-----------+            |
                       ^                     |
                       |                     |
         update-index  |     read-tree -m -u |
             blob obj  |            tree obj |
                       |                     |
                                             |
                    +-----------+            |
                    |  Working  |<-----------+
                    | Directory |
                    +-----------+



Git Diff Types
==============


                      diff-tree

                       +----+
                       |    |
                       |    |
                       V    V
                    +-----------+
                    | Object DB |
                    |  Backing  |
                    |   Store   |
                    +-----------+
                      ^    ^
                      |    |
                      |    |  diff-index --cached
                      |    |
          diff-index  |    V
                      |  +-----------+
                      |  |   Index   |
                      |  |  "cache"  |
                      |  +-----------+
                      |    ^
                      |    |
                      |    |  diff-files
                      |    |
                      V    V
                    +-----------+
                    |  Working  |
                    | Directory |
                    +-----------+


Commit DAG Revision Naming
==========================

Both node B and C are a commit parents of node A.

    G   H   I   J
     \ /     \ /
      D   E   F
       \  |  /
        \ | /
         \|/
          B     C
           \   /
            \ /
             A


    A = rev    = rev^0
    B = rev^   = rev^1     = rev~1
    D = rev^^  = rev^1^1   = rev~2
    G = rev^^^ = rev^1^1^1 = rev~3

Is there a way to name node C, E, F, H, I or J?
Is A also called rev~0?
