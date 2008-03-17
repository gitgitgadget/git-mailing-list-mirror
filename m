From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: git-describe only works on full tags
Date: Mon, 17 Mar 2008 01:41:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803170137300.14822@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 01:41:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb3Q9-00048a-Pf
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 01:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYCQAlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 20:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbYCQAlG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 20:41:06 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:36308 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYCQAlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 20:41:05 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id D56161803165B; Mon, 17 Mar 2008 01:41:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id C8C811C00E25E
	for <git@vger.kernel.org>; Mon, 17 Mar 2008 01:41:03 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77407>

Hi,


For some reason, git-describe only prints a description relative to 
the last tag that was a tag object (and not just a ref).
This is kinda a bug to me, what do others think?

$ git-rev-list --all
0d00ac11e0927e6d50d565a30344a00ce1f6b0e7
c5137b6f2f0c7b6715c9508bdaeb464da93d036a
5afc6395e0051d1bb1d37f17592a5eb7f4ac6f2d
$ git-tag v0.1 5afc6395e0051d1bb1d37f17592a5eb7f4ac6f2d
$ git-describe
fatal: cannot describe '0d00ac11e0927e6d50d565a30344a00ce1f6b0e7'
$ git-tag -m "0.2" v0.2 c5137b6f2f0c7b6715c9508bdaeb464da93d036a
$ git-describe 
v0.2-1-g0d00ac1
$ git-tag v0.3 0d00ac11e0927e6d50d565a30344a00ce1f6b0e7
$ git-describe
v0.2-1-g0d00ac1
$ git-tag -f -m "0.3" v0.3 0d00ac11e0927e6d50d565a30344a00ce1f6b0e7
$ git-describe v0.3
