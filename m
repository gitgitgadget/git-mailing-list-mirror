From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 2/4] git-sh-setup: introduce say() for quiet options
Date: Mon, 15 Jun 2009 19:05:03 -0700
Message-ID: <1245117905-19351-3-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245117905-19351-2-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 04:05:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGO3N-0000LG-JU
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 04:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbZFPCFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 22:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbZFPCFS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 22:05:18 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:55333 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbZFPCFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 22:05:13 -0400
Received: by pxi27 with SMTP id 27so601057pxi.33
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 19:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=o8C8RNPlIkEhYxNdiZWhj4ti2Omz7xUNr8YaJ/anv2w=;
        b=OblDrJiaLfjgMVcEOrkiBF/vf2ohCTmCvYQU88D+1lnHWBVEfchnEI9yY0yCG+5gSC
         Rjx9sEeyXEGrSt2uGnVqJ/v3PBNOoBaNOSghfuQYdj8YtiGYUCLIj7DPd1QNS03sgiFV
         pcJSbxUWHs5SPLpnJpq6LTAJQq0oFwD2TBuos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LL6xA++sI2RuhUWpFCizllUYr3W6VaVtCvzg6qvWb1fP+kEO703EUSB7gU69DAnvul
         j/DoGBTtShYm/qhdyaKc5zXbuFC6RnElYaICGMbVU76lv/XAuEMme6nPlNiMG8HBiYWB
         CpMfcOnVAb0IXta7udSBgJu5D9F7FG9M1KqZw=
Received: by 10.142.144.9 with SMTP id r9mr3780851wfd.106.1245117915805;
        Mon, 15 Jun 2009 19:05:15 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id 9sm1397921wfc.36.2009.06.15.19.05.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Jun 2009 19:05:15 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 15 Jun 2009 19:05:12 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245117905-19351-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121647>

Scripts should use say() when they want to output non-error messages.
This function helps future script writers easily implement a quiet
option by setting GIT_QUIET to enable suppression of non-error messages.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-sh-setup.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 80acb7d..33513d2 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -44,6 +44,16 @@ die() {
 	exit 1
 }
 
+GIT_QUIET=
+
+say () {
+	if test -z "$GIT_QUIET"
+	then
+		printf "%s" "$*"
+		echo
+	fi
+}
+
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
 		"$0" -h
-- 
1.6.3.2.306.g4f4fa
