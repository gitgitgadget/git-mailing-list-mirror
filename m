From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/4] Spend more effort in git-fetch-pack finding common
 revisions
Date: Sun, 23 Oct 2005 03:35:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510230334410.21239@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Oct 23 03:37:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETUmF-0007C7-Gh
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 03:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVJWBfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 21:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJWBfa
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 21:35:30 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62610 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751275AbVJWBfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 21:35:30 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1B1AC13F0B6; Sun, 23 Oct 2005 03:35:27 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 00FF79EF7D; Sun, 23 Oct 2005 03:35:27 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DC39190236; Sun, 23 Oct 2005 03:35:26 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 92CE613F0B6; Sun, 23 Oct 2005 03:35:26 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10482>

This series of 4 patches extends the fetch-pack/upload-pack protocol such
that more than just one common revision is used to find out which objects
are needed by the client.

This means that the client spends more time on enumerating candidates, and
the server just acknowledges those it knows about. That is done until the
client runs out of candidates, or the server got HAS_MAX common revisions.

While it does not make much of a difference when you are tracking one linear
branch on one repository, this change should make it more efficient (and
also ease the burden on the server) to work with several repositories having
several branches, and intertwined development.

Next thing I'll do is write some nasty test cases.

Flame on,
Dscho
