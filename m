From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH] builtin-reflog.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 18:39:48 -0600
Message-ID: <5d46db230802081639q6cca5851if63da9531984e681@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:40:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNdlX-0000Mo-Vu
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 01:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbYBIAju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 19:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755981AbYBIAju
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 19:39:50 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:18058 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbYBIAjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 19:39:49 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4246877wxd.4
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 16:39:49 -0800 (PST)
Received: by 10.150.11.6 with SMTP id 6mr26102ybk.165.1202517589063;
        Fri, 08 Feb 2008 16:39:49 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 16:39:48 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 17cb36e9a47f3367
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73179>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 builtin-reflog.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index e6834dd..03b8ab4 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -307,9 +307,9 @@ static int collect_reflog(const char *ref, const
unsigned char *sha1, int unused

 static int reflog_expire_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "gc.reflogexpire"))
+	if (value && !strcmp(var, "gc.reflogexpire"))
 		default_reflog_expire = approxidate(value);
-	else if (!strcmp(var, "gc.reflogexpireunreachable"))
+	else if (value && !strcmp(var, "gc.reflogexpireunreachable"))
 		default_reflog_expire_unreachable = approxidate(value);
 	else
 		return git_default_config(var, value);
-- 
1.5.4.36.g9af61
