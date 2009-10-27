From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] help -i: properly error out if no info viewer can be found
Date: Tue, 27 Oct 2009 13:31:33 +0000
Message-ID: <20091027133134.28975.qmail@34dfe9cde77152.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 14:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2mGA-0000iG-0L
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 14:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbZJ0NiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 09:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbZJ0NiN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 09:38:13 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:1665 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754293AbZJ0NiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 09:38:12 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2009 09:38:12 EDT
Received: (qmail 28985 invoked by uid 1000); 27 Oct 2009 13:31:34 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131333>

With this commit, git help -i <cmd> prints an error message and exits
non-zero instead of being silent and exit code 0.

Reported by Trent W. Buck through
 http://bugs.debian.org/537664

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-help.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index e1eba77..e1ade8e 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -372,6 +372,7 @@ static void show_info_page(const char *git_cmd)
 	const char *page = cmd_to_page(git_cmd);
 	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
 	execlp("info", "info", "gitman", page, NULL);
+	die("no info viewer handled the request");
 }
 
 static void get_html_page_path(struct strbuf *page_path, const char *page)
-- 
1.6.5.2
