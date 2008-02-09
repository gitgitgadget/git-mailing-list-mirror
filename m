From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH] http.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 18:39:04 -0600
Message-ID: <5d46db230802081639n78aab3b2s1e83ab9c4afc6a38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNdkr-000077-SJ
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 01:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbYBIAjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 19:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbYBIAjG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 19:39:06 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:17915 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbYBIAjF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 19:39:05 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4246662wxd.4
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 16:39:04 -0800 (PST)
Received: by 10.151.38.12 with SMTP id q12mr1180207ybj.124.1202517544841;
        Fri, 08 Feb 2008 16:39:04 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 16:39:04 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 02db609083eee381
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73178>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 http.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index d2c11ae..0a2c1c8 100644
--- a/http.c
+++ b/http.c
@@ -92,6 +92,9 @@ static void process_curl_messages(void)

 static int http_options(const char *var, const char *value)
 {
+	if (!value)
+		return git_default_config(var, value);
+
 	if (!strcmp("http.sslverify", var)) {
 		if (curl_ssl_verify == -1) {
 			curl_ssl_verify = git_config_bool(var, value);
-- 
1.5.4.36.g9af61
