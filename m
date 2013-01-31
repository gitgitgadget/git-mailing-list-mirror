From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/5] msvc: avoid collisions between "tags" and "TAGS"
Date: Thu, 31 Jan 2013 18:33:57 +0000
Message-ID: <510AB915.3050209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:39:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0z2a-0007Mm-Hc
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab3AaSio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:38:44 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48894 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756368Ab3AaSij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:38:39 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 8D1A518C713;
	Thu, 31 Jan 2013 18:38:38 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id D75B118C710;	Thu, 31 Jan 2013 18:38:37 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Thu, 31 Jan 2013 18:38:36 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215146>


Commit 2f769195 ("MinGW: avoid collisions between "tags" and "TAGS",
28-09-2010) enabled MinGW to use an ETAGS file in order to avoid
filename collisions on (Windows) case insensitive filesystems. In
addition, this prevents 'make' from issuing several warning messages.

When using the Makefile to perform an MSVC build, which is usually
executed using MinGW tools, we can also benefit from this capability.
In order to reap the above benefits, we set the ETAGS_TARGET build
variable to ETAGS in the MSVC config block.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index bfb8a39..6f60c3f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -343,6 +343,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	ETAGS_TARGET = ETAGS
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
-- 
1.8.1
