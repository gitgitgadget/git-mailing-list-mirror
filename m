X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: git-grep misses an instance of a string (after conflict)
Date: Sun, 26 Nov 2006 15:53:58 +0100
Message-ID: <ekc9q7$36e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 26 Nov 2006 14:54:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: at00d01-adsl-194-118-045-019.nextranet.at
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32349>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoLOi-00085E-Ha for gcvg-git@gmane.org; Sun, 26 Nov
 2006 15:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935404AbWKZOyU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 09:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935406AbWKZOyU
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 09:54:20 -0500
Received: from main.gmane.org ([80.91.229.2]:28900 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935404AbWKZOyT (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 09:54:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GoLOV-00082S-6L for git@vger.kernel.org; Sun, 26 Nov 2006 15:54:11 +0100
Received: from at00d01-adsl-194-118-045-019.nextranet.at ([194.118.45.19]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 15:54:11 +0100
Received: from johannes.sixt by at00d01-adsl-194-118-045-019.nextranet.at
 with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 15:54:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've roughly had the following sequence of operations on a particular file
in my project:

1. git-cherry-pick a commit, which resulted in a conflict in in that file
2. edit the file to insert a particular string (which wasn't there before)
3. then:

$ git-grep getSibling -- kdbg/exprwnd.h    # this file had a conflict
$ grep getSibling -- kdbg/exprwnd.h       
    { return static_cast<VarTree*>(getSibling()); }
$ git-update-index kdbg/exprwnd.h
$ git-grep getSibling -- kdbg/exprwnd.h       
kdbg/exprwnd.h:    { return static_cast<VarTree*>(getSibling()); }

As you can see, the first git-grep doesn't find the string, but after the
update-index, it does find it.

This is unexpected behavior, in particular since the manual page talks about
git-grep to search the working tree. I understand that the conflict may
have influenced the behavior, but the manual page is not in line with the
behavior. Am I missing something?

-- Hannes

