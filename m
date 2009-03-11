From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Include log_config module in apache.conf
Date: Tue, 10 Mar 2009 23:23:45 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903102320170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:27:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhF6O-0002WT-4P
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 04:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbZCKDXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 23:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbZCKDXt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 23:23:49 -0400
Received: from iabervon.org ([66.92.72.58]:40358 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746AbZCKDXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 23:23:48 -0400
Received: (qmail 7932 invoked by uid 1000); 11 Mar 2009 03:23:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Mar 2009 03:23:45 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112873>

The log_config module is needed for at least some versions of apache to 
support the LogFormat directive.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Johannes, you added the LogFormat line without this; does the test still 
work for you with this added, or do we need something clever to decide 
whether the module needs to be loaded or needs to not be loaded?

 t/lib-httpd/apache.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index af6e5e1..a0d4077 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -4,6 +4,7 @@ DocumentRoot www
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
 CustomLog access.log common
 ErrorLog error.log
+LoadModule log_config_module modules/mod_log_config.so
 
 <IfDefine Darwin>
 	LoadModule log_config_module modules/mod_log_config.so
-- 
1.6.2.77.g8cc3f.dirty
