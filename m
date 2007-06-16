From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] cvsserver: Actually implement --export-all
Date: Sun, 17 Jun 2007 01:52:50 +0200
Message-ID: <20070616235250.GA3231@steel.home>
References: <11818693133210-git-send-email-frank@lichtenheld.de> <11818693133098-git-send-email-frank@lichtenheld.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 01:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzi4h-0005k4-OJ
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 01:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbXFPXwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbXFPXwy
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 19:52:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:60373 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbXFPXwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 19:52:54 -0400
Received: from tigra.home (Fc9d7.f.strato-dslnet.de [195.4.201.215])
	by post.webmailer.de (klopstock mo15) (RZmta 7.3)
	with ESMTP id U01368j5GNi1Va ; Sun, 17 Jun 2007 01:52:51 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 76E92277BD;
	Sun, 17 Jun 2007 01:52:51 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 101B8C164; Sun, 17 Jun 2007 01:52:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11818693133098-git-send-email-frank@lichtenheld.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAcmG5c=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50325>

Frank Lichtenheld, Fri, Jun 15, 2007 03:01:53 +0200:
> +test_expect_failure 'req_Root failure (export-all w/o whitelist)' \
> +  'cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1
> +   || false'

This does not work, at least for bash in current Ubuntu:

    GNU bash, version 3.2.13(1)-release

You have to put "||" on the previous line:

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index b442b5d..0331770 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -180,8 +180,8 @@ test_expect_success 'req_Root (export-all)' \
    tail -n1 log | grep -q "^I LOVE YOU$"'
 
 test_expect_failure 'req_Root failure (export-all w/o whitelist)' \
-  'cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1
-   || false'
+  'cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 ||
+   false'
 
 test_expect_success 'req_Root (everything together)' \
   'cat request-base | git-cvsserver --export-all --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
