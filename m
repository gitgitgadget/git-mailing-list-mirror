From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 4/4] t/README: Add SMOKE_{COMMENT,TAGS}= to smoke_report target
Date: Sun,  8 Aug 2010 14:49:27 +0000
Message-ID: <1281278967-31376-5-git-send-email-avarab@gmail.com>
References: <1281278967-31376-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 16:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi7Ca-00055O-O5
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 16:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259Ab0HHOtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 10:49:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59084 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab0HHOtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 10:49:49 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so10744882wwj.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5+pXS9X9RgOKD2auI+3idPJ6CPrCYg26C0TLCOtFmZQ=;
        b=xwGVtWF0T5YdCBayAdoyVtiv1vJOl+zLHDBHZdQacBKM2rvmW3AdZajAWsqoDAJGrg
         kZhN9cOQdPdAZhY2eZ08W5qDs8SGEP9St1KQOGkMLDNSlgSEgGgzEI+kuLOUcXezNCme
         WCT7hwsxDYOuG8pA+dQ8utj6mSCvuGzS+OotQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ktg+dyQQqSrkwLfmA8dqxAGbe1Nd+SATkyEKqOcBZUVClmpFpcpULxXr1DYCEoA9Q/
         8MKsMA1VQPZOuuuER8aww4JiUZZr4dwDDs4XEtf6JMHtXROUU9gJTJX9tQm2v/8X+Q4b
         1CHCR1XbMsWZMG1IBE2Gt4+aBYbUucixQKo90=
Received: by 10.216.59.205 with SMTP id s55mr12744368wec.61.1281278987706;
        Sun, 08 Aug 2010 07:49:47 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k83sm2005995weq.38.2010.08.08.07.49.46
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 07:49:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1281278967-31376-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152914>

The smoke server supports a free form text field with comments about a
report, and a comma delimited list of tags. Change the smoke_report
target to expose this functionality. Now smokers can send more data
that explains and categorizes the reports they're submitting.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/Makefile |    6 ++++++
 t/README   |    7 +++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 00f6482..b81fb91 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -69,6 +69,12 @@ SMOKE_UPLOAD_FLAGS =3D
 ifdef SMOKE_USERNAME
 	SMOKE_UPLOAD_FLAGS +=3D -F username=3D"$(SMOKE_USERNAME)" -F password=
=3D"$(SMOKE_PASSWORD)"
 endif
+ifdef SMOKE_COMMENT
+	SMOKE_UPLOAD_FLAGS +=3D -F comments=3D"$(SMOKE_COMMENT)"
+endif
+ifdef SMOKE_TAGS
+	SMOKE_UPLOAD_FLAGS +=3D -F tags=3D"$(SMOKE_TAGS)"
+endif
=20
 smoke_report: smoke
 	curl \
diff --git a/t/README b/t/README
index 69af05f..9f676d7 100644
--- a/t/README
+++ b/t/README
@@ -620,6 +620,13 @@ and password you'll be able to do:
=20
     SMOKE_USERNAME=3D<username> SMOKE_PASSWORD=3D<password> make smoke=
_report
=20
+You can also add an additional comment to attach to the report, and/or
+a comma separated list of tags:
+
+    SMOKE_USERNAME=3D<username> SMOKE_PASSWORD=3D<password> \
+        SMOKE_COMMENT=3D<comment> SMOKE_TAGS=3D<tags> \
+        make smoke_report
+
 Once the report is uploaded it'll be made available at
 http://smoke.git.nix.is, here's an overview of Recent Smoke Reports
 for Git:
--=20
1.7.1
