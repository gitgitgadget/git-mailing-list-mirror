From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 31/33] Don't use "git log -p" in the test suite.
Date: Mon, 19 May 2014 00:00:07 +0200
Message-ID: <1400450409-30998-32-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=latin-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9LW-0003zD-EG
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbaERWOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 May 2014 18:14:14 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:32928 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbaERWON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:14:13 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3495446lab.3
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zByDQLfAzv0Dz5VTL0diAKqenkRo5k8VItrN2IjRA1E=;
        b=fH+Tdy3Ef6agA/255NSnkcb/xVf12DoTfD5XuRHCIIJElCNfq+8FwTRE2xonHF2S6u
         ctQradk1HqDnRIbS8o04gGVaRQbjcXiC1Lcrz2sWQBnPDopoDMDaDN/aihom5Y8w65CQ
         lwKG2aSlg6JpRiptJrHs34e8zXb+Cwq1vuQlfbCwvHFKC5FdF25/mzl5iXIVUcn1H5at
         mfBM5T9m4JcrELKGNVhoJKiBMko5BMhJs4XiuW0jLVi336N+eLOUfpJGUzmGoQA8AdIe
         u9PJdtbjctVcTr6x4GNkROp/wtGyC5+46nCcS3VzMB84NDYq+JCKywzW4SyiSgG6sxoM
         foAA==
X-Gm-Message-State: ALoCoQnIb+gFMbg5SShir6fOgmaVxsEQk/v3rY3Gpr3mNw5vEZI1A5H4h99WYHgnPwsU6OHpINF3
X-Received: by 10.152.4.137 with SMTP id k9mr13239031lak.46.1400451251654;
        Sun, 18 May 2014 15:14:11 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.14.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:14:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249546>

The exact format of "git log -p" may change due to user configuration,
and even if the test suite can try to set all configuration that
influences the format explicitly it is hard to guard against future
changes in git.  Since we already run "cmd list_files" immediately
before all instances of running "git log -p", we are still assured
that the history contains what we expect.

There was one instance in t-021.sh where "cmd git log -p" were not
preceded by "cmd list_files".

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/t-020.out | 1000 ------------------------------------------=
--------
 regression/t-020.sh  |   16 -
 regression/t-021.out |  899 +-----------------------------------------=
---
 regression/t-021.sh  |   10 +-
 4 files changed, 16 insertions(+), 1909 deletions(-)

diff --git a/regression/t-020.out b/regression/t-020.out
index bcb8797..5d7c918 100644
--- a/regression/t-020.out
+++ b/regression/t-020.out
@@ -14,36 +14,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/pat=
ches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push
 Applying patch..add
 Patch applied.
@@ -60,51 +30,6 @@ f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/pat=
ches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
-% git log -p
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push
 Applying patch..remove
 Patch applied.
@@ -122,66 +47,6 @@ f f322f08d907e3737a4321b0ec90bc545f71af7cf  .git/pa=
tches/master/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push
 Applying patch..mode
 Patch applied.
@@ -200,76 +65,6 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/re=
fs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push
 File series fully applied, ends at patch mode
 % guilt push -a
@@ -289,76 +84,6 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/re=
fs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push
@@ -376,36 +101,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push
@@ -423,36 +118,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push
@@ -470,36 +135,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push
@@ -517,36 +152,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push
@@ -564,36 +169,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push
 Applying patch..add
 Patch applied.
@@ -610,51 +185,6 @@ f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/p=
atches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
-% git log -p
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push
 Applying patch..remove
 Patch applied.
@@ -672,66 +202,6 @@ f f322f08d907e3737a4321b0ec90bc545f71af7cf  .git/p=
atches/master/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push
 Applying patch..mode
 Patch applied.
@@ -750,76 +220,6 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/r=
efs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push -n -2
@@ -835,22 +235,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 No patches applied.
 % guilt push -n -1
@@ -866,22 +250,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 No patches applied.
 % guilt push -n 0
@@ -897,22 +265,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 No patches applied.
 % guilt push -n 1
@@ -930,36 +282,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push -n 2
@@ -980,51 +302,6 @@ f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/p=
atches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
-% git log -p
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push -n 3
@@ -1048,66 +325,6 @@ f f322f08d907e3737a4321b0ec90bc545f71af7cf  .git/=
patches/master/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % guilt push -n 4
@@ -1134,76 +351,6 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/=
refs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop --all
 All patches popped.
 % list_files
@@ -1236,28 +383,6 @@ f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/=
patches/master/series
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty.=
patch
 f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
 r c7a139f532a43c3c8b0e068cac04f8f6af0f94e1  .git/refs/patches/master/e=
mpty.patch
-% git log -p
-commit c7a139f532a43c3c8b0e068cac04f8f6af0f94e1
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch empty.patch
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % git config guilt.diffstat true
 % guilt refresh
 Patch empty.patch refreshed
@@ -1280,28 +405,6 @@ f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/=
patches/master/series
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty.=
patch~
 f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
 r c7a139f532a43c3c8b0e068cac04f8f6af0f94e1  .git/refs/patches/master/e=
mpty.patch
-% git log -p
-commit c7a139f532a43c3c8b0e068cac04f8f6af0f94e1
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch empty.patch
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % git config guilt.diffstat false
 % guilt pop
 All patches popped.
@@ -1322,35 +425,6 @@ f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/=
patches/master/series
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty.=
patch~
 f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
 r 8ed27228b117c0c88abf3d586bcc43c68e975cea  .git/refs/patches/master/e=
mpty.patch
-% git log -p
-commit 8ed27228b117c0c88abf3d586bcc43c68e975cea
-Author: Per Cederqvist <ceder@lysator.liu.se>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    Fix a bug.
-   =20
-    This commit fixes a serious bug.
-   =20
-    FIXME:
-        - add a test case
-        - track down the bug
-        - actually fix it
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % git config guilt.diffstat true
 % guilt refresh
 Patch empty.patch refreshed
@@ -1373,35 +447,6 @@ f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/=
patches/master/modify
 f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
 f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
 r 8ed27228b117c0c88abf3d586bcc43c68e975cea  .git/refs/patches/master/e=
mpty.patch
-% git log -p
-commit 8ed27228b117c0c88abf3d586bcc43c68e975cea
-Author: Per Cederqvist <ceder@lysator.liu.se>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    Fix a bug.
-   =20
-    This commit fixes a serious bug.
-   =20
-    FIXME:
-        - add a test case
-        - track down the bug
-        - actually fix it
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % git config guilt.diffstat false
 % guilt refresh
 Patch empty.patch refreshed
@@ -1424,35 +469,6 @@ f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/=
patches/master/modify
 f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
 f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
 r 8ed27228b117c0c88abf3d586bcc43c68e975cea  .git/refs/patches/master/e=
mpty.patch
-% git log -p
-commit 8ed27228b117c0c88abf3d586bcc43c68e975cea
-Author: Per Cederqvist <ceder@lysator.liu.se>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    Fix a bug.
-   =20
-    This commit fixes a serious bug.
-   =20
-    FIXME:
-        - add a test case
-        - track down the bug
-        - actually fix it
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt delete empty.patch
 Cannot delete an applied patch
 % guilt pop -a
@@ -1470,19 +486,3 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/=
patches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
diff --git a/regression/t-020.sh b/regression/t-020.sh
index 3f70c26..2f2aa10 100755
--- a/regression/t-020.sh
+++ b/regression/t-020.sh
@@ -21,8 +21,6 @@ guilt series | while read n ; do
 	cmd guilt push
=20
 	cmd list_files
-
-	cmd git log -p
 done
=20
 #
@@ -34,8 +32,6 @@ cmd guilt push -a
=20
 cmd list_files
=20
-cmd git log -p
-
 #
 # pop all
 #
@@ -49,8 +45,6 @@ guilt series | while read n ; do
=20
 	cmd list_files
=20
-	cmd git log -p
-
 	cmd guilt pop --all
 done
=20
@@ -61,8 +55,6 @@ guilt series | while read n ; do
 	cmd guilt push $t
=20
 	cmd list_files
-
-	cmd git log -p
 done
=20
 #
@@ -80,8 +72,6 @@ for n in `_seq -2 $npatches`; do
=20
 	cmd list_files
=20
-	cmd git log -p
-
 	cmd guilt pop --all
 done
=20
@@ -91,14 +81,12 @@ cmd list_files
 cmd guilt new empty.patch
 fixup_time_info empty.patch
 cmd list_files
-cmd git log -p
=20
 # Ensure we can push the empty patch even when guilt.diffstat is true.
 cmd git config guilt.diffstat true
 cmd guilt refresh
 fixup_time_info empty.patch
 cmd list_files
-cmd git log -p
 cmd git config guilt.diffstat false
=20
 # Let the patch have a commit message, but no data.
@@ -117,7 +105,6 @@ EOF
=20
 fixup_time_info empty.patch
 cmd list_files
-cmd git log -p
=20
 # And once more, with an empty diffstat.
=20
@@ -125,20 +112,17 @@ cmd git config guilt.diffstat true
 cmd guilt refresh
 fixup_time_info empty.patch
 cmd list_files
-cmd git log -p
=20
 # Restore the diffstat setting and remove the empty patch.
 cmd git config guilt.diffstat false
 cmd guilt refresh
 fixup_time_info empty.patch
 cmd list_files
-cmd git log -p
 # (Cannot delete an applied patch)
 shouldfail guilt delete empty.patch
 cmd guilt pop -a
 cmd guilt delete -f empty.patch
 cmd list_files
-cmd git log -p
=20
 # FIXME:
 #   --all
diff --git a/regression/t-021.out b/regression/t-021.out
index 58be12f..32dae17 100644
--- a/regression/t-021.out
+++ b/regression/t-021.out
@@ -8,76 +8,21 @@ Applying patch..remove
 Patch applied.
 Applying patch..mode
 Patch applied.
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
 % guilt pop
 Now at remove.
 % list_files
@@ -94,66 +39,6 @@ f f322f08d907e3737a4321b0ec90bc545f71af7cf  .git/pat=
ches/master/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop
 Now at add.
 % list_files
@@ -169,51 +54,6 @@ f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/pa=
tches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
-% git log -p
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop
 Now at modify.
 % list_files
@@ -228,36 +68,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/pa=
tches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop
 All patches popped.
 % list_files
@@ -271,22 +81,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/pa=
tches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop
 No patches applied.
 % guilt push --all
@@ -314,66 +108,6 @@ f f322f08d907e3737a4321b0ec90bc545f71af7cf  .git/p=
atches/master/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..mode
 Patch applied.
@@ -392,51 +126,6 @@ f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/p=
atches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
-% git log -p
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..remove
 Patch applied.
@@ -456,36 +145,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..add
 Patch applied.
@@ -506,22 +165,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..modify
 Patch applied.
@@ -547,66 +190,6 @@ f f322f08d907e3737a4321b0ec90bc545f71af7cf  .git/p=
atches/master/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop
 Now at add.
 % list_files
@@ -622,51 +205,6 @@ f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/p=
atches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
-% git log -p
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop
 Now at modify.
 % list_files
@@ -681,36 +219,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt pop
 All patches popped.
 % list_files
@@ -724,22 +232,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/p=
atches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..modify
 Patch applied.
@@ -766,76 +258,6 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/r=
efs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 File series fully applied, ends at patch mode
 % guilt pop -n -1
@@ -855,76 +277,6 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/r=
efs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 File series fully applied, ends at patch mode
 % guilt pop -n 0
@@ -944,76 +296,6 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/r=
efs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch mode
-
-diff --git a/def b/def
-old mode 100644
-new mode 100755
-
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 File series fully applied, ends at patch mode
 % guilt pop -n 1
@@ -1032,66 +314,6 @@ f f322f08d907e3737a4321b0ec90bc545f71af7cf  .git/=
patches/master/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
-% git log -p
-commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch remove
-
-diff --git a/abd b/abd
-deleted file mode 100644
-index fd3896d..0000000
---- a/abd
-+++ /dev/null
-@@ -1 +0,0 @@
--=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..mode
 Patch applied.
@@ -1110,51 +332,6 @@ f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/=
patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
-% git log -p
-commit 37d588cc39848368810e88332bd03b083f2ce3ac
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch add
-
-diff --git a/abd b/abd
-new file mode 100644
-index 0000000..fd3896d
---- /dev/null
-+++ b/abd
-@@ -0,0 +1 @@
-+=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
-\ No newline at end of file
-
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..remove
 Patch applied.
@@ -1174,36 +351,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/=
patches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
-% git log -p
-commit 33633e7a1aa31972f125878baf7807be57b1672d
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    patch modify
-
-diff --git a/def b/def
-index 8baef1b..7d69c2f 100644
---- a/def
-+++ b/def
-@@ -1 +1,2 @@
- abc
-+asjhfksad
-
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..add
 Patch applied.
@@ -1224,22 +371,6 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/=
patches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
-% git log -p
-commit d4850419ccc1146c7169f500725ce504b9774ed0
-Author: Author Name <author@email>
-Date:   Mon Jan 1 00:00:00 2007 +0000
-
-    initial
-   =20
-    Signed-off-by: Commiter Name <commiter@email>
-
-diff --git a/def b/def
-new file mode 100644
-index 0000000..8baef1b
---- /dev/null
-+++ b/def
-@@ -0,0 +1 @@
-+abc
 % guilt push --all
 Applying patch..modify
 Patch applied.
diff --git a/regression/t-021.sh b/regression/t-021.sh
index e0d2dc1..2873234 100755
--- a/regression/t-021.sh
+++ b/regression/t-021.sh
@@ -9,7 +9,7 @@ cmd setup_repo
=20
 cmd guilt push --all
=20
-cmd git log -p
+cmd list_files
=20
 #
 # incremental pop by 1
@@ -18,8 +18,6 @@ guilt series | _tac | while read n ; do
 	cmd guilt pop
=20
 	cmd list_files
-
-	cmd git log -p
 done
=20
 #
@@ -41,8 +39,6 @@ guilt series | _tac | while read n ; do
=20
 	cmd list_files
=20
-	cmd git log -p
-
 	cmd guilt push --all
 done
=20
@@ -53,8 +49,6 @@ guilt series | _tac | while read n ; do
 	cmd guilt pop $t
=20
 	cmd list_files
-
-	cmd git log -p
 done
=20
 #
@@ -72,8 +66,6 @@ for n in `_seq -2 $npatches`; do
=20
 	cmd list_files
=20
-	cmd git log -p
-
 	cmd guilt push --all
 done
=20
--=20
1.8.3.1
