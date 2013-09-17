From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] build: add default configuration
Date: Tue, 17 Sep 2013 08:14:10 -0500
Message-ID: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
Cc: git-users@googlegroups.com,
	=?UTF-8?q?Br=C3=A1ulio=20Bhavamitra?= <brauliobo@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 15:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLvBk-0007hv-9e
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 15:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab3IQNT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 09:19:28 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:39007 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab3IQNT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 09:19:27 -0400
Received: by mail-qe0-f45.google.com with SMTP id 6so3638250qea.18
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aeYGgFdxnMMpLwXsChnnJ+MWIFh1Wcr5eOn7Kj6XV8I=;
        b=K2YzM3vLcvZ3hWO/4VKlM8arAawKdjbDx96ble2LkheQkvB5KprfV9aClZzy1i1G2x
         Ou8aIwUvRdUDUVm99aZiiD0g+ffhR+d8jzKEfGWIjKu/uWc1L+8qbigmRqZKk9xkdvLQ
         O5Vp7uqrFcchh/RhScDZ28B4FPUZazFc4BWHHi9DMJ1+JcepxjTp0XpeF6vk5wdmXguQ
         24JhoqCu5jPQIJm3u4D//6gd78CFFiSkETkCjQnoiiXzi8OO3J4F9p9MlBwS5iwGc5PX
         IjpmhUXc+4PqqalnOSQORmeGe9DtZJKYEaHk55AgA8fGA/NMy7bd+fRcppqiy6Y/yvGl
         CQ/Q==
X-Received: by 10.224.89.1 with SMTP id c1mr2929612qam.100.1379423966901;
        Tue, 17 Sep 2013 06:19:26 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id g2sm31286685qaf.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 06:19:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234878>

For now simply add a few common aliases.

  co = checkout
  ci = commit
  rb = rebase
  st = status

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile  | 5 ++++-
 gitconfig | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 gitconfig

diff --git a/Makefile b/Makefile
index 3588ca1..18081bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1010,7 +1010,7 @@ ifndef sysconfdir
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
 else
-sysconfdir = etc
+sysconfdir = $(prefix)/etc
 endif
 endif
 
@@ -1586,6 +1586,7 @@ template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
+sysconfdir_SQ = $(subst ','\'',$(sysconfdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -2340,6 +2341,8 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)'
+	$(INSTALL) -m 644 gitconfig '$(DESTDIR_SQ)$(ETC_GITCONFIG_SQ)'
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/gitconfig b/gitconfig
new file mode 100644
index 0000000..c45d300
--- /dev/null
+++ b/gitconfig
@@ -0,0 +1,5 @@
+[alias]
+	co = checkout
+	ci = commit
+	rb = rebase
+	st = status
-- 
1.8.4-fc
