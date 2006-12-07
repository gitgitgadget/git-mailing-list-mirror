X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Drake <ddrake@brontes3d.com>
Subject: git-svnimport breakage as of git-1.4.4
Date: Thu, 07 Dec 2006 10:26:33 -0500
Message-ID: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 15:26:52 +0000 (UTC)
Cc: sashak@voltaire.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: OK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33591>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsL8x-00075R-2q for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937984AbWLGP0g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937985AbWLGP0g
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:26:36 -0500
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:49834 "EHLO
 smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937984AbWLGP0f (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 10:26:35 -0500
Received: from [10.20.253.243] (host34.155.212.242.conversent.net
 [155.212.242.34]) (Authenticated sender: ddrake@brontes3d.com) by
 relay5.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id A9C316459E6; Thu, 
 7 Dec 2006 10:26:33 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

git-svnimport broken between git-1.4.3.5 and git-1.4.4

I have found that commit 83936a29e275bc0c04f60d3333e4951a9e16b1fc is the
cause of this.

I am using git-svnimport to work with a repo with this layout:

https://server/repo/trunk
https://server/repo/tags/x.y.z
https://server/repo/branches/somebranch

Starting a fresh import:

# git-svnimport -v -i -C repo -r https://server repo

Fetching from 1 to 10707 ...
Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 1:/ 2004-12-22 22:53:27)
Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Commit ID 2614c05ac4c5f24eb89cea056a7d46c909084d8c
Writing to refs/heads/origin
DONE: 1 origin 2614c05ac4c5f24eb89cea056a7d46c909084d8c
RA layer request failed: PROPFIND request failed on '/trunk/.cvsignore':
PROPFIND of '/trunk/.cvsignore': 405 Method Not Allowed (https://server)
at /usr/bin/git-svnimport line 358


According to the server logs, git is requesting /trunk/.cvsignore rather
than /repo/trunk/.cvsignore

I'm happy to test patches and whatnot but don't have time to investigate
further right now.

Thanks!
-- 
Daniel Drake
Brontes Technologies, A 3M Company
