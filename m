X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: git pickaxe -- problems with relative filenames
Date: Thu, 02 Nov 2006 03:21:22 +0000
Message-ID: <45496432.80503@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 03:22:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30683>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfT9X-00075L-78 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 04:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752586AbWKBDWA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 22:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbWKBDWA
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 22:22:00 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:38921 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752586AbWKBDWA
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 22:22:00 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfT8r-00036h-1Z; Thu, 02 Nov 2006 03:21:21 +0000
To: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

We seem to have a difference in the handling of relative filenames
within a repository between git blame and git pickaxe.  Specifically git
pickaxe seems to always require names as if it were run in the top of
the project:

apw@pinky$ pwd
/home/apw/git/git/Documentation
apw@pinky$ git blame git.txt | head -2
7984eabe (Sebastian Kuzminsky 2005-05-19 10:24:54 -0600   1) git(7)
2cf565c5 (David Greaves       2005-05-10 22:32:30 +0100   2) ======
apw@pinky$ git pickaxe git.txt | head -2
fatal: cannot stat path git.txt: No such file or directory
apw@pinky$ git pickaxe Documentation/git.txt | head -2
7984eabe (Sebastian Kuzminsky 2005-05-19 10:24:54 -0600   1) git(7)
2cf565c5 (David Greaves       2005-05-10 22:32:30 +0100   2) ======

This seems inconsistent? Is this expected behaviour?

