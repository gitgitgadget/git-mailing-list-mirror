From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/6] config.c: Fix a sparse warning
Date: Sun, 06 Oct 2013 21:48:29 +0100
Message-ID: <5251CC9D.9040309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 22:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvFj-0006Wc-Gg
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 22:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab3JFUsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 16:48:32 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:37811 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754271Ab3JFUsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 16:48:31 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C79E26FB8FE;
	Sun,  6 Oct 2013 21:48:30 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 9AEE36FB8F2;
	Sun,  6 Oct 2013 21:48:30 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun,  6 Oct 2013 21:48:30 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235745>


Sparse issues an "'git_parse_unsigned' was not declared. Should it
be static?" warning. In order to suppress this warning, since this
symbol only requires file scope, we simply add the static modifier
to its declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 6588cf5..e1d66a1 100644
--- a/config.c
+++ b/config.c
@@ -498,7 +498,7 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 	return 0;
 }
 
-int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
+static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 {
 	if (value && *value) {
 		char *end;
-- 
1.8.4
