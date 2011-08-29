From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] am: format is in $patch_format, not parse_patch
Date: Mon, 29 Aug 2011 17:22:06 +0200
Message-ID: <1314631326-11796-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 17:22:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy3fX-00052t-CR
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 17:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab1H2PWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 11:22:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56222 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1H2PWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 11:22:30 -0400
Received: by wyg24 with SMTP id 24so4155483wyg.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PTzibMC/YctuHSLKfwsWxvxWB8u/IcYOGZGIB+FxqXE=;
        b=MDgivOKqWoXacofqX3hxjbp3x1em6MYVnCV80g/x7A1dSj27+myaAoxtFAtR0QUusV
         EbkdjB9ToSIfto3nErmd3BSTqKq97ZdLpeh6cpOqxDyDDKCVXlGTjjwuYO1lTOC+f6Ds
         nv+rsy79aFsj0FQToMIG54IFvjDPD0GxVuJ1M=
Received: by 10.227.205.15 with SMTP id fo15mr3154855wbb.110.1314631348861;
        Mon, 29 Aug 2011 08:22:28 -0700 (PDT)
Received: from localhost ([151.54.153.147])
        by mx.google.com with ESMTPS id et16sm3826551wbb.19.2011.08.29.08.22.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 08:22:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.328.g626f7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180312>

The error message given when the patch format was not recognized was
wrong, since the variable checked was $parse_patch rather than
$patch_format. Fix by checking the non-emptyness of the correct
variable.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e78cb54..4fff195 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -312,7 +312,7 @@ split_patches ()
 		msgnum=
 		;;
 	*)
-		if test -n "$parse_patch" ; then
+		if test -n "$patch_format" ; then
 			clean_abort "$(eval_gettext "Patch format \$patch_format is not supported.")"
 		else
 			clean_abort "$(gettext "Patch format detection failed.")"
-- 
1.7.7.rc0.328.g626f7.dirty
