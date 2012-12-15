From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t3070: Disable some failing fnmatch tests
Date: Sat, 15 Dec 2012 19:19:18 +0000
Message-ID: <50CCCD36.9020001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:28:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxPM-0004LJ-GU
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab2LOT2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:28:03 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41601 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2LOT2B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:28:01 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 1383D384081;
	Sat, 15 Dec 2012 19:28:00 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 61DAC384080;	Sat, 15 Dec 2012 19:27:59 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat, 15 Dec 2012 19:27:58 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211562>


The failing tests make use of a POSIX character class, '[:xdigit:]'
in this case, which some versions of the fnmatch() library function
do not support. In the spirit of commit f1cf7b79 ("t3070: disable
unreliable fnmatch tests", 15-10-2012), we disable the fnmatch() half
of these tests.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This is against next (branch 'nd/wildmatch'). As an alternative solution,
I could build with NO_FNMATCH, since the compat version does support the
POSIX charater classes.

ATB,
Ramsay Jones

 t/t3070-wildmatch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 3155eab..d5bafef 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -120,9 +120,9 @@ match 0 x '1' '[[:digit:][:upper:][:spaci:]]'
 match 1 x ' ' '[[:digit:][:upper:][:space:]]'
 match 0 x '.' '[[:digit:][:upper:][:space:]]'
 match 1 x '.' '[[:digit:][:punct:][:space:]]'
-match 1 1 '5' '[[:xdigit:]]'
-match 1 1 'f' '[[:xdigit:]]'
-match 1 1 'D' '[[:xdigit:]]'
+match 1 x '5' '[[:xdigit:]]'
+match 1 x 'f' '[[:xdigit:]]'
+match 1 x 'D' '[[:xdigit:]]'
 match 1 x '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
 match 1 x '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
 match 1 x '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]'
-- 
1.8.0
