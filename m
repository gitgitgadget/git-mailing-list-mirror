From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] sha1_file.c: make parse_sha1_header_extended() static
Date: Thu, 16 Apr 2015 13:25:25 +0100
Message-ID: <552FAA35.4050806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: karthik.188@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 16 14:25:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiirP-0004fl-6e
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 14:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150AbbDPMZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 08:25:31 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:36088 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752367AbbDPMZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 08:25:29 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A7971384092;
	Thu, 16 Apr 2015 13:25:27 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 63F33384084;
	Thu, 16 Apr 2015 13:25:27 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 16 Apr 2015 13:25:26 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267281>


commit 9e1f5bc0 ("sha1_file.c: support reading from a loose object of
unknown type", 15-04-2015) added a new externally visible function
which does not require more than file scope. This causes sparse to
issue a warning message about this symbol. In order to suppress the
warning, add the static qualifier to the function definition.

[An alternative solution, if this symbol should have external scope,
is to add an external declaration for the function to the "cache.h"
header file (next to the one for parse_sha1_header()).]

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Karthik,

If you need to re-roll your patches in the 'kn/cat-file-literally'
branch, could you please squash this, or something like it, into
the relevant patch.

Thanks!

ATB,
Ramsay Jones

 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 267399d..2b81534 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1642,7 +1642,7 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
+static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 			       unsigned int flags)
 {
 	struct strbuf typename = STRBUF_INIT;
-- 
2.3.0
