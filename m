From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] lib-httpd.sh: print error.log on error
Date: Sun, 12 Jun 2016 17:41:54 +0700
Message-ID: <20160612104154.31446-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:42:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC2qL-0003FD-0H
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbcFLKmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:42:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35849 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbcFLKmB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:42:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id 62so8473902pfd.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xIOpOV+kLl57qmaqM/xxeRzZXHQiN0erLQWUoqZ9ls=;
        b=den2y/UJzofNWh9g8xlch3MrJU68W0wCIm1o75AigOZY5iFrDDT0tvIU2gIBM/qCGA
         x4555S6aMllKfuvho4Y7xsgA0szrO/1b7swLFk5VJZN31846lQUDEbu0guDgZbCJE2DO
         4kEBPmlEPLZD32rBRRz6vqSjdsph7atANcYDmRuUqW+RvjFc3ba/EkD4OBQH7nCvk/GS
         wBngziwsEPXZ/8yrLgfvFt4suk6Clh6m5BX6jgX1C26UT/UanaH7oRiR4j0D8lnAIykn
         gGCf/TPfHBJ1ufQQL+iHVlMCof4jIpf20LHj7sqqjmTjzdKSdAukmZIOzn+ElnncHWqi
         XYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xIOpOV+kLl57qmaqM/xxeRzZXHQiN0erLQWUoqZ9ls=;
        b=WFXVF86qa9IcWIJuIZXDXlB+v/j7tkxE03ob2eZZ6cLVDRSSaKh27DanPQMx70o5EU
         9m5qslREHPr9LgW3AkL5+fQP24j98thfXrrbOwXP1IK8ngHpSIblvE3qQL4hnn6SiH0J
         8dkmaZOEmZjApzJ3CfVsRjcAhbhv5DNHwHABTWd2AgrprKeDYJwcHlKvBD6R8kf1JcQb
         WGTFXmq72uYFCnsNqp5ozsG6jUfulWttu53LqNXt9NcNmamUiBQf6X64Swu6E9FKIxXl
         axx0RSAlPXT+oe9fl7cURY42jDuTvtg3mLui9W8XFvD1axGxZHAC+CGtpqTRjpV07c5F
         1QHQ==
X-Gm-Message-State: ALyK8tIcwITcd/euTBNRa3E2awyppL1alRipsu+WJ+9/iVMW9h02IupMZGh3+XmBVbRepw==
X-Received: by 10.98.1.132 with SMTP id 126mr14421256pfb.27.1465728120926;
        Sun, 12 Jun 2016 03:42:00 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id vb6sm29736897pac.16.2016.06.12.03.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:41:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:41:56 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297104>

=46ailure to bring up httpd for testing is not considered an error, so =
the
trash directory, which contains this error.log file, is removed and we
don't know what made httpd fail to start. Improve the situation a bit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/lib-httpd.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index f9f3e5f..5b8de38 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -180,6 +180,7 @@ start_httpd() {
 	if test $? -ne 0
 	then
 		trap 'die' EXIT
+		cat "$HTTPD_ROOT_PATH"/error.log 2>/dev/null
 		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
 	fi
 }
--=20
2.8.2.524.g6ff3d78
