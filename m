From: Sven Herzberg <sven@imendio.com>
Subject: git-annotate - leaking hundrets of megabytes
Date: Tue, 23 Oct 2007 19:00:34 +0200
Message-ID: <471E28B2.7020508@imendio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 19:01:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkN7j-0006wA-QF
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 19:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbXJWRAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbXJWRAo
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 13:00:44 -0400
Received: from holken.mikan.net ([83.145.56.183]:60201 "EHLO holken.mikan.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbXJWRAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 13:00:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by holken.mikan.net (Postfix) with ESMTP id 210E914582
	for <git@vger.kernel.org>; Tue, 23 Oct 2007 19:00:39 +0200 (CEST)
Received: from holken.mikan.net ([127.0.0.1])
	by localhost (holken.mikan.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10344-03 for <git@vger.kernel.org>;
	Tue, 23 Oct 2007 19:00:36 +0200 (CEST)
Received: from [192.168.2.102] (p548FFF58.dip.t-dialin.net [84.143.255.88])
	by holken.mikan.net (Postfix) with ESMTP id EEDE214571
	for <git@vger.kernel.org>; Tue, 23 Oct 2007 19:00:35 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
X-Virus-Scanned: Debian amavisd-new at holken.mikan.net
X-Spam-Status: No, score=-97.544 tagged_above=-999 required=4
	tests=[AWL=0.368, RCVD_IN_SORBS_DUL=2.088, USER_IN_WHITELIST=-100]
X-Spam-Score: -97.544
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62137>

Hey,

I just started to write a small tool that's supposed to provide a
graphical annotation view. It's supposed to display the information of
git-annotate and provide a way to browse through the history (so people
can click on links that refer to older revisions, etc.). According to
the man page of git-annotate, I looked into the incremental mode to make
sure the tool can load the information step by step.

However, to make sure the user interface doesn't block while
"git-annotate --incremental" is running, I decided to take a really slow
annotation while developing and then I saw that git-annotate leaks
*lots* of memory (at least in that use-case).

In my example, it used up to 450MB:
http://people.imendio.com/~sven/massif.18740.png

Reproduce:
1. git clone git://git.webkit.org/WebKit.git
2. cd WebKit/WebCore
3. git-annotate --incremental ChangeLog

Regards,
  Sven

PS: Please CC me as I'm not on the list.
