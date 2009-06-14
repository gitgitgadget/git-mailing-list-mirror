From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 1/3] git-sh-setup: introduce say() for quiet options
Date: Sun, 14 Jun 2009 16:16:12 -0700
Message-ID: <1245021374-8430-2-git-send-email-bebarino@gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
 <1245021374-8430-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 01:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFyw5-0001GZ-V2
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 01:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219AbZFNXQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 19:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756877AbZFNXQT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 19:16:19 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:40691 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbZFNXQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 19:16:18 -0400
Received: by pzk17 with SMTP id 17so1583525pzk.33
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=nQ/kj87913EqVxrWNZLGm+TIeqe40+8FNq8nQD41xsQ=;
        b=J91TrkD4u6t7qdS427H6E8cijk4wy+z4AFMGp8S8X49mL4DZtuW2UckMDHxvyYXWpP
         sBOdtyu1TedwHjuguvISEgDE/XS759D2UoU8WIhJjqMP1n3azH/ADd4QhQ/estUN/CI/
         mRPvXjvdoo+PJR88g/IigqMMJKgbCix9dBVr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CY9hP85U4Dimfbz4v+AuFIgCNmSkPMRFvioCgZFKjR1vABt6iGdMSV2t19ACPNYT3G
         jy84CowU9WzApkPREy9lXAvibFSaM/WE3c+JVZOB1vuY7wO2y1792yVuMfrM4yqbZ/mf
         1z73z7+Te9vIx+els84Lv04fSYik+SUDPaR9w=
Received: by 10.142.127.7 with SMTP id z7mr2702738wfc.83.1245021381262;
        Sun, 14 Jun 2009 16:16:21 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 28sm6086506wfg.25.2009.06.14.16.16.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 16:16:20 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 14 Jun 2009 16:16:17 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245021374-8430-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121567>

Scripts should use say() when they want to echo to stdout. Setting
GIT_QUIET will mute say(), allowing scripts to easily implement a quiet
option.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-sh-setup.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 80acb7d..f88184e 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -44,6 +44,13 @@ die() {
 	exit 1
 }
 
+say () {
+	if test -z "$GIT_QUIET"
+	then
+		echo "$@"
+	fi
+}
+
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
 		"$0" -h
-- 
1.6.3.2.306.g4f4fa
