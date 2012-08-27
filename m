From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 5/7] Fix tests under GETTEXT_POISON on pack-object
Date: Tue, 28 Aug 2012 06:59:15 +0800
Message-ID: <c89b2d6f6636e693c27ed52fb57231664a61336b.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
 <1954d94a032f1cedee953a7db5da8f6d37e4c7d9.1346108242.git.worldhello.net@gmail.com>
 <4e2f6d25bc4588f478bb3b6866290f2feabc03d0.1346108242.git.worldhello.net@gmail.com>
 <19564c3c4288172ab1cf2c7097a750f5689faba8.1346108242.git.worldhello.net@gmail.com>
 <c7c8ebb234e8bd0771cfd7d2f715f06d86e5c472.1346108242.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:59:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68HV-0007sk-D3
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab2H0W7f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 18:59:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61072 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab2H0W7d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:59:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so8239394pbb.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=L1K6CneAWNonos7oIKTf9OgHKbi+rJMXyaGAZZURd44=;
        b=X6P/sS/Y7CX8LG+gmzYxLSDBOP5HVRX0sSZUvkaP9E6VTu8IJDtd4kIN8F4vuHhBk5
         kImjuUYckv10i1yTx7xW3ezFfXF0vBM4JFmruwsvZN0ddm5wNM6agQPUnDEm2E+Com8Q
         Cft9qIee+ruse3xiXGNpf9ovPzF9Xmd+gLFx/j8MePUIQueMPZne9YQ51OqSHBepk2+2
         AiXSad4QwOKGn3GYt+qyTuWJ4W7L4k24yiUtAkjcSvZG1ZW4GcgSz42ehJ8mf9ns0JS/
         jjhAPRpzdt3SpL+pUnkxlgMDgiIUN4zVzHx2FMWglGRdYrXv0hsC1vF8862TwG5pDNky
         JdYw==
Received: by 10.68.203.34 with SMTP id kn2mr37500428pbc.144.1346108373277;
        Mon, 27 Aug 2012 15:59:33 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.151.199])
        by mx.google.com with ESMTPS id qn13sm15577687pbb.71.2012.08.27.15.59.30
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 15:59:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.g949df84
In-Reply-To: <c7c8ebb234e8bd0771cfd7d2f715f06d86e5c472.1346108242.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204380>

Use i18n-specific test functions in test scripts for pack-object.
This issue was was introduced in v1.7.10.2-556-g46140:

    46140 index-pack: use streaming interface for collision test on lar=
ge blobs
    cf2ba pack-objects: use streaming interface for reading large loose=
 blobs

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5300-pack-object.sh       | 4 ++--
 t/t5530-upload-pack-error.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2e52..a07c8 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -416,11 +416,11 @@ test_expect_success \
 test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
     'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
-     grep "SHA1 COLLISION FOUND" msg'
+     test_i18ngrep "SHA1 COLLISION FOUND" msg'
=20
 test_expect_success \
     'make sure index-pack detects the SHA1 collision (large blobs)' \
     'test_must_fail git -c core.bigfilethreshold=3D1 index-pack -o bad=
=2Eidx test-3.pack 2>msg &&
-     grep "SHA1 COLLISION FOUND" msg'
+     test_i18ngrep "SHA1 COLLISION FOUND" msg'
=20
 test_done
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.s=
h
index 6b2a5f..c983d 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -35,8 +35,8 @@ test_expect_success 'upload-pack fails due to error i=
n pack-objects packing' '
 	printf "0032want %s\n00000009done\n0000" \
 		$(git rev-parse HEAD) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
-	grep "unable to read" output.err &&
-	grep "pack-objects died" output.err
+	test_i18ngrep "unable to read" output.err &&
+	test_i18ngrep "pack-objects died" output.err
 '
=20
 test_expect_success 'corrupt repo differently' '
--=20
1.7.12.92.g949df84
