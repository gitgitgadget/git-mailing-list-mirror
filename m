From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/5] msvc: Fix build by adding missing symbol defines
Date: Thu, 31 Jan 2013 18:31:30 +0000
Message-ID: <510AB882.5060105@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0z2E-00077k-T2
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab3AaSie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:38:34 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48865 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756300Ab3AaSic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:38:32 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 3103F18C712;
	Thu, 31 Jan 2013 18:38:31 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id EA56D18C710;	Thu, 31 Jan 2013 18:38:29 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Thu, 31 Jan 2013 18:38:23 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215144>


In particular, remote-testsvn.c fails to compile with two
undeclared identifier errors relating to the 'UINT32_MAX'
and 'STDIN_FILENO' symbols.

In order to fix the compilation errors, we add appropriate
definitions for the UINT32_MAX and STDIN_FILENO constants
to an msvc compat header file.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/vcbuild/include/unistd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index b14fcf9..c65c2cd 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -49,6 +49,9 @@ typedef int64_t off64_t;
 #define INTMAX_MAX  _I64_MAX
 #define UINTMAX_MAX _UI64_MAX
 
+#define UINT32_MAX 0xffffffff  /* 4294967295U */
+
+#define STDIN_FILENO  0
 #define STDOUT_FILENO 1
 #define STDERR_FILENO 2
 
-- 
1.8.1
