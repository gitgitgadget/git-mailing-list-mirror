From: Michael Krelin <hacker@klever.net>
Subject: [RESEND][PATCH] git-svn: honor ~/.subversion/ client cert file settings.
Date: Fri, 22 Jun 2007 11:15:03 +0200
Message-ID: <118250370348-git-send-email-hacker@klever.net>
Cc: Michael Krelin <hacker@klever.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 11:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1fS6-0007v1-72
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 11:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbXFVJ3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 05:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbXFVJ3K
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 05:29:10 -0400
Received: from argo.arachnion.zzZZzz.net ([62.27.45.185]:44761 "EHLO
	argo.arachnion.zzZZzz.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbXFVJ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 05:29:09 -0400
Received: from pd953b8a8.dip0.t-ipconnect.de ([217.83.184.168] helo=olympus.klever.net)
	by argo.arachnion.zzZZzz.net with esmtpa (Exim 4.42)
	id 1I1fFo-0005UO-88; Fri, 22 Jun 2007 11:16:32 +0200
Received: from hacker by olympus.klever.net with local (Exim 4.60)
	(envelope-from <hacker@olympus.klever.net>)
	id 1I1fEN-00008e-1k; Fri, 22 Jun 2007 11:15:03 +0200
X-Mailer: git-send-email 1.5.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50684>

	Currently, whenever svn repository http server requests client
	certificate, prompt provider is invoked, ignoring any
	ssl-client-cert-file settings in ~/.subversion/servers. Moreover, it
	happens more than once per session, which is quite irritating.

Signed-off-by: Michael Krelin <hacker@klever.net>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 50128d7..9dfea97 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2925,6 +2925,7 @@ sub new {
 	    SVN::Client::get_ssl_server_trust_file_provider(),
 	    SVN::Client::get_simple_prompt_provider(
 	      \&Git::SVN::Prompt::simple, 2),
+	    SVN::Client::get_ssl_client_cert_file_provider(),
 	    SVN::Client::get_ssl_client_cert_prompt_provider(
 	      \&Git::SVN::Prompt::ssl_client_cert, 2),
 	    SVN::Client::get_ssl_client_cert_pw_prompt_provider(
-- 
1.5.2.2
