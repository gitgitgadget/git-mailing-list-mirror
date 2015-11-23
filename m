From: larsxschneider@gmail.com
Subject: [PATCH v7 1/2] config.mak.uname: Darwin: define NO_GETTEXT for OS X 10.9 and later
Date: Mon, 23 Nov 2015 09:25:07 +0100
Message-ID: <1448267108-55652-2-git-send-email-larsxschneider@gmail.com>
References: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 09:25:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0mR8-0004rY-3R
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 09:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbbKWIZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 03:25:16 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37698 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbbKWIZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 03:25:12 -0500
Received: by wmww144 with SMTP id w144so93807483wmw.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 00:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3JLZYF91HBhW874q/ibsctB2pPjZdsnonF0Id4Vk1uc=;
        b=YAcscQgvFwd9b+eyC4cz0F9UHq8q7ZCbKBoDH8HSRWcJzR/UJdEtga6E8ZV7aj6c9+
         idTirw2mln+f1Sup0/UzqyzaYKHgPsPgNiz1Q0ELUevBg/EgtY2R4kaHV3mxrM0k9Jhn
         cOv+NEvZeIlQbdhO1dgdB4FUwkRQhwX3wt88fwJiP7A4jvahIVm+9Ii3sFvDyU1Uipgg
         Saj9/aU7Cqh9YIU35f2QLs9DiS8UexUfYvzfMfMwp/bzSY88zXFV6w3hubjuULHuYjud
         JthR68c+tm9qctKDFvx4NnAPLMQeiu3hWPlAspyUYwLAN/umm/R2Efh1/PPcEclu6Tyx
         mt4Q==
X-Received: by 10.28.129.82 with SMTP id c79mr18220876wmd.80.1448267111748;
        Mon, 23 Nov 2015 00:25:11 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB6DC4.dip0.t-ipconnect.de. [93.219.109.196])
        by smtp.gmail.com with ESMTPSA id a63sm8659788wmc.5.2015.11.23.00.25.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Nov 2015 00:25:11 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281574>

From: Lars Schneider <larsxschneider@gmail.com>

At least since OS X 10.9 Mavericks "libintl.h" is not available on OS X
anymore. Disable the support with the NO_GETTEXT flag.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 config.mak.uname | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index f34dcaa..f3d98bb 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -102,9 +102,14 @@ ifeq ($(uname_S),Darwin)
 	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY = YesPlease
 	endif
+	# MacOS 10.7 Lion and higher
 	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
 		HAVE_GETDELIM = YesPlease
 	endif
+	# MacOS 10.9 Mavericks and higher
+	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 13 && echo 1),1)
+		NO_GETTEXT = YesPlease
+	endif
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.5.1
