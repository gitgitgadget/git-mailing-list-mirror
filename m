From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.xs
Date: Wed, 28 Jun 2006 21:55:18 +0200
Message-ID: <20060628195518.GE5713@fiberbit.xs4all.nl>
References: <20060628183557.GA5713@fiberbit.xs4all.nl> <7vr719159v.fsf@assigned-by-dhcp.cox.net> <7virml14za.fsf@assigned-by-dhcp.cox.net> <20060628192145.GD5713@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 21:55:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvg8G-0003hd-6x
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 21:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWF1TzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWF1TzY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 15:55:24 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:37009 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751114AbWF1TzX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 15:55:23 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Fvg86-0001c6-9v; Wed, 28 Jun 2006 21:55:18 +0200
To: Marco Roeland <marco.roeland@xs4all.nl>
Content-Disposition: inline
In-Reply-To: <20060628192145.GD5713@fiberbit.xs4all.nl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22821>

In commit 6294a10 it was noted that "on x86-64 it seems that Git.xs does
not link without compiling the main git objects with -fPIC". Set it
therefore automatically on this platform.

This patch does this only for _Linux_ x86-64, as that is the only x86-64
platform I have access to. But it might very well make sense on other
x86-64 platforms, please test and report if you have such a platform.

Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>
---
This applies to 'pu'. It is an amended version from an earlier one
with a simplification from Junio and a clarification why it is Linux
specific at the moment. The title was also slightly improved.
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2df5bd4..88cfe2b 100644
--- a/Makefile
+++ b/Makefile
@@ -254,6 +254,9 @@ # we had "elif" things would have been m
 
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
+	ifeq ($(uname_M),x86_64)
+		USE_PIC = YesPlease
+	endif
 endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
-- 
1.4.1.rc1.g3550-dirty
