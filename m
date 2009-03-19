From: Andreas Gruenbacher <agruen@suse.de>
Subject: gitk-git/Makefile install: mkdir missing
Date: Thu, 19 Mar 2009 14:46:41 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903191446.41738.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 14:50:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkIdM-0005vl-GG
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 14:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbZCSNsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 09:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbZCSNsW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 09:48:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:46021 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbZCSNsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 09:48:21 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id BFE4293A00
	for <git@vger.kernel.org>; Thu, 19 Mar 2009 14:48:18 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113770>

I needed this change to get "make install DESTDIR=..." to work here:

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..3021be0 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -40,6 +40,7 @@ endif
 all:: gitk-wish $(ALL_MSGFILES)
 
 install:: all
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
 	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 
$p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true

Andreas
