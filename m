From: skimo@liacs.nl
Subject: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 20:04:33 +0200
Message-ID: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmo-0007La-2D
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948AbXETSFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756935AbXETSE7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:04:59 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37197 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756873AbXETSE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:04:57 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4m7V007796;
	Sun, 20 May 2007 20:04:53 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 761D57DD9F; Sun, 20 May 2007 20:04:48 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47861>

From: Sven Verdoolaege <skimo@kotnet.org>

This patch series implements a mechanism for cloning submodules.
Each submodule is specified by a 'submodule.<submodule>.url'
configuration option, e.g.,

bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
submodule.cloog.url /home/sverdool/public_html/cloog.git
submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git

git-checkout will use the first url that works.
E.g., a

git clone --submodules ssh://liacs/~/public_html/isa.git

followed by

git checkout origin/submodule

(which only works for me), will use the first url, while a

git clone --submodules http://www.liacs.nl/~sverdool/isa.git

followed by

git checkout origin/submodule

will use the second.

The cloning of submodules is now handled inside git-checkout.

I currently do not fetch after the initial clone, since
I'm not sure what ref to use for the revision I need to
fetch for the supermodule.
Suggestions are welcome.

Note that this is still WIP, so there is no need to remind
me that I still need to write documentation and tests.

skimo
