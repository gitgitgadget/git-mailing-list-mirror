From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] bisect: remove unnecessary redirection
Date: Sat, 30 Aug 2014 12:30:28 -0700
Message-ID: <1409427029-65886-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 21:30:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNoLY-0002y0-Pa
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 21:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbaH3T3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 15:29:47 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64264 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaH3T3q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 15:29:46 -0400
Received: by mail-pd0-f179.google.com with SMTP id z10so2860369pdj.38
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nnLKyoxjS4+nWHXDbkhMtmFNwMKmTxjVHwTE2yU5L+w=;
        b=uI2nmBKL1FPiyZoW3IMRSvAYrTagmH0cPuYpVgJhOvbfrEifyToEMfKOMdP9eTcjjF
         9OW6SrCHkJh60KXSgk0IbJRyXAaNZdlH7x1eLJ1RsAzND3ucZ3T5pZFNqN7hIOFc/xn5
         rscBbdX0XhoGBLWOLNGDGqgaq+9Ib+YKJJvq7ikwmAlfKBZwRN580sUqlEBL+m/Xya14
         s/Or23gliQcztegjPI0b7BXyP1Su7hrCpa1UmDJI5fmpV9SL2zIlZC593a6lLswEXtZk
         UDfEP41fGjtnNgm99ThoKv2tmBY2VgQOzbHQ5dP1yITd+cldNA1sVXzzrjp4BxMsn5mH
         uuiw==
X-Received: by 10.66.182.10 with SMTP id ea10mr26123434pac.123.1409426986245;
        Sat, 30 Aug 2014 12:29:46 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dh14sm11898336pac.17.2014.08.30.12.29.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 30 Aug 2014 12:29:45 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.29.g9b751c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256259>

`git rev-parse` is being called with --quiet so there's no need to
redirect to /dev/null.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-bisect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1e0d602..c1c2321 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -365,7 +365,7 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" >/dev/null || {
+	1) git rev-parse --quiet --verify "$1^{commit}" || {
 			invalid="$1"
 			die "$(eval_gettext "'\$invalid' is not a valid commit")"
 		}
-- 
2.1.0.29.g9b751c4
