From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Use compatibility regex library also on AIX
Date: Thu, 11 Sep 2008 10:14:44 +0200
Message-ID: <48C8D374.9050007@viscovery.net>
References: <20080907184537.GA4148@regex.yaph.org>	 <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>	 <20080910100301.GA27748@regex.yaph.org>	 <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com> <e2b179460809110059i2eca8b07x6d263f06cc8e5d32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>
To: Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 10:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdhLO-0007zn-3h
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 10:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbYIKIOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 04:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbYIKIOu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 04:14:50 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62553 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYIKIOt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 04:14:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KdhK8-000822-P7; Thu, 11 Sep 2008 10:14:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 654DCAFCC; Thu, 11 Sep 2008 10:14:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2b179460809110059i2eca8b07x6d263f06cc8e5d32@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95592>

This augments 3632cfc24 (Use compatibility regex library on Darwin,
2008-09-07), which already carries a "Tested-by" statement for AIX,
but that test was actually done with this patch included.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
Tested-by: Mike Ralphson <mike@abacus.co.uk>
---
Mike Ralphson schrieb:
> 2008/9/10 Mike Ralphson <mike.ralphson@gmail.com>:
> Junio, sorry, I should have made this clear, but as above in the
> thread, Johannes Sixt's 'patchlet' is required to be squashed into
> 3632cfc24, and I think Arjen was going to re-roll the patch.
> 
> I can submit the required follow-up, but it really should have J6's S-o-b.

Here it is. Disclaimer: This patch submission was hand-crafted. ;)

-- Hannes

diff --git a/Makefile b/Makefile
index 98d67f1..0637419 100644
--- a/Makefile
+++ b/Makefile
@@ -702,6 +702,8 @@ ifeq ($(uname_S),AIX)
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
+	COMPAT_CFLAGS += -Icompat/regex
+	COMPAT_OBJS += compat/regex/regex.o
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
