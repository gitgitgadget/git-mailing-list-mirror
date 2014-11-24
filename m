From: Dan Wyand <danwyand@gmail.com>
Subject: [PATCH] git-sh-setup.sh: use dashdash with basename call
Date: Mon, 24 Nov 2014 18:20:48 -0500
Message-ID: <1416871248-14185-1-git-send-email-danwyand@gmail.com>
Cc: Dan Wyand <danwyand@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 00:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2wF-0002kR-VR
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 00:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbaKXXU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 18:20:56 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:37784 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaKXXUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 18:20:55 -0500
Received: by mail-lb0-f176.google.com with SMTP id p9so7437660lbv.35
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DzVZ4izBHqYG37WEGtjt1Gpm+yWy9maW5BBDDWbQ3go=;
        b=DUimNjy7qK0ZzMDZajR48T7c0fAUtUjtuFSuUVeungn375L+h1/LUuyjC5yxqfQrkM
         MnCUe306i2Cij9NQhIAWf0UH/adP18cRF8V2PGgWp8IUK7V93Q5RKNaxhBTtxYsW9k2T
         To7eNhRbN0P9N5RZ16ogjLCuKEQSDTCLCoIqxF7wF1/vxX5hO5iUldsM8uUSetZfsbhr
         IXVaUBKCV7e8eScaICmIAaUSAzSziAtOylhDaYpn5UXn0Zec6SY48/Bz/hrD6O2fE39V
         KIQEuC6vJ7Xl1yfqeMnrCPY2zL1FucCagihfNhHVP0W7ZWCugQD4Yp0irOyvnpnpicMy
         0IgA==
X-Received: by 10.152.206.67 with SMTP id lm3mr23000057lac.16.1416871254134;
        Mon, 24 Nov 2014 15:20:54 -0800 (PST)
Received: from localhost.localdomain (173-166-145-18-washingtondc.hfc.comcastbusiness.net. [173.166.145.18])
        by mx.google.com with ESMTPSA id ei11sm2765866lad.18.2014.11.24.15.20.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Nov 2014 15:20:53 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260170>

Calling basename on a argument that starts with a dash, like a login shell,
will result in an error. This patch adds '--' before the argument so that the
argument is interpreted properly.

Signed-off-by: Dan Wyand <danwyand@gmail.com>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9447980..5cdae33 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -81,7 +81,7 @@ if test -n "$OPTIONS_SPEC"; then
 		echo exit $?
 	)"
 else
-	dashless=$(basename "$0" | sed -e 's/-/ /')
+	dashless=$(basename -- "$0" | sed -e 's/-/ /')
 	usage() {
 		die "usage: $dashless $USAGE"
 	}
-- 
2.1.3
