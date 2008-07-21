From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 10/9] git-gui: git.git now uses $(gitexec_instdir) to point to the exec-path
Date: Mon, 21 Jul 2008 21:26:12 +0200
Message-ID: <200807212126.12212.johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-9-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-10-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL12R-0004m0-HV
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbYGUT0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbYGUT0Q
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:26:16 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:47018 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYGUT0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:26:15 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 5A04F97374;
	Mon, 21 Jul 2008 21:26:12 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A42861D0CD;
	Mon, 21 Jul 2008 21:26:12 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1216667998-8879-10-git-send-email-johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89395>

In git.git the Makefile variable $(gitexecdir) can be relative. It now
exports the actual install location in $(gitexec_instdir).

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b19fb2d..c8660fb 100644
--- a/Makefile
+++ b/Makefile
@@ -30,8 +30,12 @@ ifndef SHELL_PATH
 endif
 
 ifndef gitexecdir
+ifdef gitexec_instdir
+	gitexecdir := $(gitexec_instdir)
+else
 	gitexecdir := $(shell git --exec-path)
 endif
+endif
 
 ifndef sharedir
 	sharedir := $(dir $(gitexecdir))share
-- 
1.6.0.rc0.18.g6aef2
