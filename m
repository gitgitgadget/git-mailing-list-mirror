From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/8] config: Trivial rename in preparation for parseopt.
Date: Sun, 15 Feb 2009 11:00:53 +0200
Message-ID: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 10:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYcuC-0000wm-9y
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbZBOJBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZBOJBG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:01:06 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:50285 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbZBOJBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:01:05 -0500
Received: by bwz5 with SMTP id 5so2522291bwz.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/SJOS6xWmBvOujB41XPheGr7XYuWWNmjZvwWEjizAOI=;
        b=oKCco/z16AzDrNkgdXGLYMNjfJhClgstAqSN7UptPSEzUfz5pffjS4yOcVA3p2q/P9
         NHC2iFsc/05MKLy3JQMExrlJf/wZtO2hs890orrwBoFPiQ7qLRj5pfnsllJQTjJVmknq
         89altXAFMmKahOZWPDWyycDvUsIwF71i2dwkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Rhzor4yu02XLQQXOHQQrry9mfYuKsnM5i1HkTqExXIgqk+Pk969NAk4Z3pkNIUXckr
         5CR1K1EAj9aOxaX8SolGDtKxEEbg8jLZerIE6x3D6PSdR7Cr8mxT2JpMeefv3x49nt2K
         1ScoMLLX+R0o9hRciItOOy+Upb/XE/j+AvNoc=
Received: by 10.181.36.9 with SMTP id o9mr369046bkj.148.1234688462094;
        Sun, 15 Feb 2009 01:01:02 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 13sm5637431fks.27.2009.02.15.01.01.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 01:01:01 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109979>

As suggested by Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 6937eaf..bf8df58 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -178,6 +178,7 @@ static char *normalize_value(const char *key, const char *value)
 
 static int get_color_found;
 static const char *get_color_slot;
+static const char *get_colorbool_slot;
 static char parsed_color[COLOR_MAXLEN];
 
 static int git_get_color_config(const char *var, const char *value, void *cb)
@@ -231,7 +232,7 @@ static int get_diff_color_found;
 static int git_get_colorbool_config(const char *var, const char *value,
 		void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	if (!strcmp(var, get_colorbool_slot)) {
 		get_colorbool_found =
 			git_config_colorbool(var, value, stdout_is_tty);
 	}
@@ -263,11 +264,11 @@ static int get_colorbool(int argc, const char **argv)
 		usage(git_config_set_usage);
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
-	get_color_slot = argv[0];
+	get_colorbool_slot = argv[0];
 	git_config(git_get_colorbool_config, NULL);
 
 	if (get_colorbool_found < 0) {
-		if (!strcmp(get_color_slot, "color.diff"))
+		if (!strcmp(get_colorbool_slot, "color.diff"))
 			get_colorbool_found = get_diff_color_found;
 		if (get_colorbool_found < 0)
 			get_colorbool_found = git_use_color_default;
-- 
1.6.1.3
