From: Steven Penny <svnpenn@gmail.com>
Subject: [PATCH] gitk: Avoid issues with script path format
Date: Sun, 16 Mar 2014 01:12:22 -0500
Message-ID: <1394950342-1580-1-git-send-email-svnpenn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Penny <svnpenn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 07:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP4KO-0008Eb-9F
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 07:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbaCPGNk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 02:13:40 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42024 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaCPGNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 02:13:40 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so4317527obc.31
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=dS8GE73bCSNxj9S8R9Dnn1Fbv8V3e4pVivpTtZYAbk8=;
        b=IDZS9XLGa7rd/nH1osPY8UNJn95JPvIveWwZF0yJWfU+PUnBFtLhTSwGOX3pbaX/vt
         m5CwGl0QWpLXfVIjzUaS+PV+M1XnzBnNArhOXs8dZ0Yc9QV3rQUXE2IoL4Kg5cheUL2q
         cyfFmaVc7+yeHZ1QkmDNT7tByLMgCdRrErpQhf6fiEVUX2ZNnEJ7g9Moql/RFpBngD4b
         eTknSwOb+hU2/dY8pHHNddEWSSM6VcB00ptNc6U2Jf8w2O8GgjglAE4UsRX48mt2ZZXf
         BAdcQEFfsuBB9cj46a3s+Su+p96KIOgjg2kTeFltR0BM2TTObJbjY3/ae2dD/5rJ61j4
         /pkg==
X-Received: by 10.182.28.7 with SMTP id x7mr15025099obg.43.1394950419481;
        Sat, 15 Mar 2014 23:13:39 -0700 (PDT)
Received: from localhost (99-109-97-214.lightspeed.rcsntx.sbcglobal.net. [99.109.97.214])
        by mx.google.com with ESMTPSA id lg8sm20611797obc.14.2014.03.15.23.13.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 23:13:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244180>

Tk=E2=80=99s "wish" for Windows can be built two ways

win   this provides a "wish" that uses GDI; it only understands Windows
      paths such as C:\foo\bar
unix  this provides a "wish" that uses X11; it understands Windows and =
Cygwin
      paths such as C:\foo\bar or /foo/bar

Some Cygwin users will prefer to use the "win" version, as it avoids th=
e large
X11 dependency. However Cygwin passes the path "/bin/gitk" or similar a=
nd the
"win" version of "wish" will not understand this. However "wish" does u=
nderstand
STDIN. Options such as "--all" will still work using this method as wel=
l.

Signed-off-by: Steven Penny <svnpenn@gmail.com>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 90764e8..64a125d 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Tcl ignores the next line -*- tcl -*- \
-exec wish "$0" -- "$@"
+exec wish < "$0" -- "$@"
=20
 # Copyright =C2=A9 2005-2014 Paul Mackerras.  All rights reserved.
 # This program is free software; it may be used, copied, modified
--=20
1.8.5.2
