From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] connect: use strcmp() for string comparison
Date: Sat, 21 Feb 2015 20:49:58 +0100
Message-ID: <54E8E166.7070500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:50:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPG4H-0001sj-Sk
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 20:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbBUTuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 14:50:22 -0500
Received: from mout.web.de ([212.227.17.11]:60138 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbbBUTuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 14:50:21 -0500
Received: from [192.168.178.27] ([79.253.189.194]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M1o86-1XWcHA2CB0-00toYq; Sat, 21 Feb 2015 20:50:18
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:7MjGK+BYx+Z1pB4BrLJcxEnwpLqxCFOCdDnaQ7LG/1pODw+udS5
 BiTsKsEYDMV3Vi5nA6Kct0zAzH0jxCz1HfpQrMHd4nXCndg4qqaWgQIvUYuI2hbSGzKMRyA
 wSc1JmQpPX93RLopfQZGVWM7VHhijiyiwI9GiCRBa1fi6L9/CQVA7neEXDVDpPNUbvZkeLO
 8GQc9rDomLCHUVJEX2FyQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264224>

Get rid of magic string length constants and simply compare the strings
using strcmp().  This makes the intent of the code a bit clearer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 connect.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 062e133..2a5c400 100644
--- a/connect.c
+++ b/connect.c
@@ -157,8 +157,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			server_capabilities = xstrdup(name + name_len + 1);
 		}
 
-		if (extra_have &&
-		    name_len == 5 && !memcmp(".have", name, 5)) {
+		if (extra_have && !strcmp(name, ".have")) {
 			sha1_array_append(extra_have, old_sha1);
 			continue;
 		}
-- 
2.3.0
