From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add a notice that only certain functions can print color
 escape codes
Date: Fri, 27 Nov 2009 08:42:25 +0100
Message-ID: <4B0F82E1.80402@viscovery.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net> <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net> <4B0EA06A.1050101@viscovery.net> <7vy6lt6rh3.fsf@alter.siamese.dyndns.org> <4B0F78F1.4040101@viscovery.net> <7vzl68v2zb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 08:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDvTO-0007xa-Hw
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 08:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbZK0HmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 02:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbZK0HmW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 02:42:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39644 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZK0HmW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 02:42:22 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NDvTF-0006Nm-Gg; Fri, 27 Nov 2009 08:42:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4682B1660F;
	Fri, 27 Nov 2009 08:42:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vzl68v2zb.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133871>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Like this?
> 
> Yeah, and in addition to "puts", "write(2)" is also not supported, right?

Correct, good catch!

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Add a notice that only certain functions can print color escape codes

We emulate color escape codes on Windows by overriding printf, fprintf,
and fputs. Warn users that these are the only functions that can be used
to print them.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 color.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/color.h b/color.h
index 7d8da6f..3cb4b7f 100644
--- a/color.h
+++ b/color.h
@@ -4,6 +4,11 @@
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 #define COLOR_MAXLEN 24

+/*
+ * IMPORTANT: Due to the way these color codes are emulated on Windows,
+ * write them only using printf(), fprintf(), and fputs(). In particular,
+ * do not use puts() or write().
+ */
 #define GIT_COLOR_NORMAL	""
 #define GIT_COLOR_RESET		"\033[m"
 #define GIT_COLOR_BOLD		"\033[1m"
-- 
1.6.6.rc0.43.g50037
