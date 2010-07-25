From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 3/7] Makefile: Split out the untested functions target
Date: Sun, 25 Jul 2010 19:52:41 +0000
Message-ID: <1280087565-24671-4-git-send-email-avarab@gmail.com>
References: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 21:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7GP-00040o-ER
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888Ab0GYTxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:53:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49624 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab0GYTxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:53:07 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so646045ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qVXMMQxZq6yk9LUL8Sa9bZDzwfaHv6M+wW6x3cQh2x8=;
        b=BRslOpN+g8Kz4wR0hkTWlubx1k5/PxN0IjJWGEOFO/4h+yrhhNPALpmdATbmM9VG3T
         pGzl7TGjyZ9jeXdBdHzjd7fPYccrbRn4kY7+a0KmowFtqXMToEjd2N7kup0c5G2G/VLh
         RT2lNC41zI4voknJQ0BDiIypuu7Fl3IgX7hC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=f6TJmPTKS3ZgyEZyfRbNtqDiJWphKA2VHDP0jJotKwLx9YaPNdan6Mriltn4TsZKKm
         5Vr0OJB668+IWQkYtOkf7ZAIneqiKI84l0ggf/VjP/R1O4p3el1UxvoTVirD5Z0VcmAU
         Z5+m5A0bfwCDs4DjxsR32622AZBWk1CFXPTo0=
Received: by 10.213.4.5 with SMTP id 5mr5597983ebp.8.1280087586401;
        Sun, 25 Jul 2010 12:53:06 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm4369452eei.19.2010.07.25.12.53.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 12:53:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151785>

Change the coverage-report target so that it doesn't generate the
coverage-untested-functions file by default. I'm adding more targets
for doing various things with the gcov files, and they shouldn't all
run by default.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b791ad5..40453f1 100644
--- a/Makefile
+++ b/Makefile
@@ -2301,6 +2301,8 @@ coverage-report:
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		gcov $(GCOVFLAGS) --object-directory=3D$$dir $$dir*.c || exit; \
 	done
+
+coverage-untested-functions: coverage-report
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		> coverage-untested-functions
--=20
1.7.0.4
