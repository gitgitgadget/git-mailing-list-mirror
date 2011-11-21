From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] convert.c: Fix return type of git_path_check_eol()
Date: Mon, 21 Nov 2011 18:42:09 +0000
Message-ID: <4ECA9B81.9070101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: artagnon@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 19:44:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSYr1-0006kA-B6
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 19:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab1KUSoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 13:44:25 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:64917 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755011Ab1KUSoY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 13:44:24 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RSYqU-0005Uv-eT; Mon, 21 Nov 2011 18:44:22 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185755>


The git_path_check_eol() function converts a string value to the
corresponding 'enum eol' value. However, the function is currently
declared to return an 'enum crlf_action', which causes sparse to
complain thus:

        SP convert.c
    convert.c:736:50: warning: mixing different enum types
    convert.c:736:50:     int enum crlf_action  versus
    convert.c:736:50:     int enum eol

In order to suppress the warning, we simply correct the return type
in the function declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 convert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/convert.c b/convert.c
index 038b0be..86e9c29 100644
--- a/convert.c
+++ b/convert.c
@@ -658,7 +658,7 @@ static enum crlf_action git_path_check_crlf(const char *path, struct git_attr_ch
 	return CRLF_GUESS;
 }
 
-static enum crlf_action git_path_check_eol(const char *path, struct git_attr_check *check)
+static enum eol git_path_check_eol(const char *path, struct git_attr_check *check)
 {
 	const char *value = check->value;
 
-- 
1.7.7
