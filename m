From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Add missing #include to support TIOCGWINSZ on Solaris
Date: Mon, 11 Jan 2010 17:41:01 +0700
Message-ID: <1263206461-4960-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 11:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUHhy-0006Qh-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 11:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953Ab0AKKlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 05:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944Ab0AKKlJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 05:41:09 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61313 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0AKKlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 05:41:08 -0500
Received: by pwj9 with SMTP id 9so1285669pwj.21
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=DCBzMKTOERKIqxC/YzPQpKi0xR8Y4qYWxxh88ePGJHo=;
        b=NtYEraHvIz5b4c3rogAb/R+m0w0jsdoUjtmahr1+deK3v0l8issSVJ3ShcQUfnt7Sa
         GcOCQruSpmqJaGDwkqBLd3qmN8GqpjXWJOgwl2LXsznoY5XfAm3FoVmI6SQulv5O2SUR
         NDsyeIO9t46aEs771BGasIHu6LRiwt26CHki8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NBNDWQ0CHqVKmp4dYzN7SeCV60hno6KlsOxzt1GDzra570Ht/2CrKyxRy5q6r8KGp6
         eNIJ6gj9aF6sXrzAkk/9sAaJe81Cahq/vP7KpRNX/rvS2bAaB4hIkPmEVXaK6y7f6k8H
         C/O5a9EeUaL1UtztULxdw/1VOGhwHKN4c1mIc=
Received: by 10.141.14.7 with SMTP id r7mr4115760rvi.215.1263206466870;
        Mon, 11 Jan 2010 02:41:06 -0800 (PST)
Received: from dektop ([118.69.34.31])
        by mx.google.com with ESMTPS id 23sm21200351pzk.8.2010.01.11.02.41.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 02:41:06 -0800 (PST)
Received: by dektop (sSMTP sendmail emulation); Mon, 11 Jan 2010 17:41:03 +0700
X-Mailer: git-send-email 1.6.4.1.401.gc69a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136630>

On Linux TIOCGWINSZ is defined somehwere in ioctl.h, which is already
included. On Solaris we also need to include termios.h. Without this
term_columns() in help.c will think TIOCGWINSZ is not supported and
always return 80 columns.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Solaris noob here. Somebody should check if it affects other platforms=
=2E

 git-compat-util.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e5e9f39..de3a70e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -90,6 +90,7 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
 #endif
--=20
1.6.4.1.401.gc69a7
