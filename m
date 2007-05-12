From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [BUG] git config gets confused
Date: Sun, 13 May 2007 01:52:31 +0200
Message-ID: <20070512235230.GE7184@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 01:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn1OI-00079J-Kp
	for gcvg-git@gmane.org; Sun, 13 May 2007 01:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXELXwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 19:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbXELXwi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 19:52:38 -0400
Received: from planck.djpig.de ([85.10.192.180]:2518 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbXELXwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 19:52:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id E85F2274014;
	Sun, 13 May 2007 01:52:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QzS0LqmdpESp; Sun, 13 May 2007 01:52:31 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 2A3B4274013; Sun, 13 May 2007 01:52:31 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47110>

While working on test cases for git-cvsserver, especially the config
file handling I noticed the following bug in git-config:

$ git-config gitcvs.enabled true
$ git-config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite
$ git-config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite

expected result:

[gitcvs]
        enabled = true
        dbname = %Ggitcvs2.%a.%m.sqlite
[gitcvs "ext"]
        dbname = %Ggitcvs1.%a.%m.sqlite

actual result:

[gitcvs]
        enabled = true
[gitcvs "ext"]
        dbname = %Ggitcvs1.%a.%m.sqlite
        dbname = %Ggitcvs2.%a.%m.sqlite

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
