From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 03/14] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
Date: Fri, 21 Aug 2009 15:30:35 +0200
Message-ID: <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUEA-00012X-7P
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbZHUNbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbZHUNbI
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:08 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:45095 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbZHUNbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:07 -0400
Received: by ewy3 with SMTP id 3so637069ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=terd2aNnNOxDe8lCvxxnatprHUEL1lV9+oblz/xYDn0=;
        b=lhzUAvKpSuxjtnCGMBA6XeVDblDS7UB5LCBpddjDJGRC38KvVnCDrn61fPIkKzjBcS
         JZMDVGxf6rGaAMi6/NYQjei4P5Pmg7wsLnfmhasIvPqfIGFtx+fEqTNIQcZSBz5iDihr
         ZPM4JJsUyrVZbYotasDnlBobU2OGG7bRxdsuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=leVbdWI4CDsqAeER9aS3tmDJBaOHJ/QMCjyz6soaVE0Pm3+Accd07sq1dYoyBYJb4e
         rCEC9fegk8bHc4zZBVduIgmqFpwR1JS6mM9gFNeVMoOpng5oEmbwuMWD+YUgOxysQQco
         ltXjBcj3J5JGshPvzoTIWH+QgIwk0ujG0BhEI=
Received: by 10.210.66.18 with SMTP id o18mr1188525eba.59.1250861467817;
        Fri, 21 Aug 2009 06:31:07 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126719>

From: Frank Li <lznuaa@gmail.com>

The Microsoft C runtime's vsnprintf function does not add NUL at
the end of the buffer.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/snprintf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 6c0fb05..37b1edf 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -6,7 +6,7 @@
  * number of characters to write without the trailing NUL.
  */
 #ifndef SNPRINTF_SIZE_CORR
-#if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4
+#if (defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4) || defined(_MSC_VER)
 #define SNPRINTF_SIZE_CORR 1
 #else
 #define SNPRINTF_SIZE_CORR 0
-- 
1.6.3.msysgit.0.18.gef407
