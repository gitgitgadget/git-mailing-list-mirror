From: Timur Tabi <timur@freescale.com>
Subject: git-apply and git-am should provide better errors when changelog
 is missing
Date: Mon, 23 Jul 2007 12:15:13 -0500
Organization: Freescale
Message-ID: <46A4E221.9050302@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 19:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID1VC-0004TZ-8c
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 19:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759125AbXGWRPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 13:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759217AbXGWRPS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 13:15:18 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:49957 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758968AbXGWRPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 13:15:17 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l6NHFEg8005381
	for <git@vger.kernel.org>; Mon, 23 Jul 2007 10:15:14 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6NHFDRq020632
	for <git@vger.kernel.org>; Mon, 23 Jul 2007 12:15:13 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53447>

I was trying to apply a patch, and I kept getting this odd error:

I'm trying to apply a patch, and I get this error message:

git-apply --stat mpc86xx.patch
fatal: git-apply: bad git-diff - expected /dev/null on line 55

When I take a look at line 55 of mpc86xx.patch, I see this:

  # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
  config MCA
diff --git a/arch/powerpc/boot/dts/mpc86xx.dts b/arch/powerpc/boot/dts/mpc86xx.dts$
new file mode 100644
index 0000000..a8a13b4
--- /dev/null					<--- line 55
+++ b/arch/powerpc/boot/dts/mpc86xx.dts
@@ -0,0 +1,187 @@
+/*
+ * MPC86xx Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.

So obviously, I was confused.  Well, I figured out the problem.  The patch did not include 
a changelog.  All it had was this:

 From b878a6b32a733e72a771fffd632f57b08808fc7f Mon Sep 17 00:00:00 2001
From: xxx <xxx@freescale.com>
Date: Tue, 19 Jun 2007 12:55:59 -0500
Subject: [PATCH] Added MPC86xx Support

Signed-off-by: xxx <xxx@freescale.com>
---
  arch/powerpc/Kconfig                        |    3 +-


Could someone please update the git-am and git-apply code to provide a better error 
message in this situation?  Thanks.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
