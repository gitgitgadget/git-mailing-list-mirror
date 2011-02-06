From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 28/31] rebase -m: don't print exit code 2 when merge fails
Date: Sun,  6 Feb 2011 13:43:57 -0500
Message-ID: <1297017841-20678-29-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eG-0005ZO-UO
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab1BFSqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:38 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab1BFSqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:36 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=MgEP7DhI6Rl6zoltqWruELVznbSywAbdyh//jiGYh3I=;
        b=Fwuhclcv7WOLEi5GnRUtiBocnvBUn0WAfuswbxUgR1VJVuYl/FmLztSsBYs1wr5vlI
         uJ4g0l3UFSG7fGGPSA72p0GMSTf8mSS/4Dfe7H5wViEtMDnPvzZZWoCQ8vXMIzGNkYRn
         +z56xnWoTqdwAdPIZ3zHRaEShMq4jMN15JS60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eYdatzdZHxVANrqWchsPCDd3AzP2xyQpK0GUi1SzV1j7J7sAvfbaM8VdJPCv8EVHJ8
         KWvwVXA4KNM0lZOc0+UUPpiapUrq8EStD0hakecxMDOwH8uPVTT1XF3wqkk8h5K2QtEN
         cBXzzA42DhYwQx+ViFVyFHdlbRvQQ/xZRaHAA=
Received: by 10.229.81.65 with SMTP id w1mr12367993qck.9.1297017996166;
        Sun, 06 Feb 2011 10:46:36 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:35 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166181>

When the merge strategy fails, a message suggesting the user to try
another strategy is displayed. Remove the "$rv" (which is always equal
to "2" in this case) from that message.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index eb0f7bc..26afc75 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -78,7 +78,7 @@ call_merge () {
 		die "$resolvemsg"
 		;;
 	2)
-		echo "Strategy: $rv $strategy failed, try another" 1>&2
+		echo "Strategy: $strategy failed, try another" 1>&2
 		die "$resolvemsg"
 		;;
 	*)
-- 
1.7.4.rc2.33.g8a14f
