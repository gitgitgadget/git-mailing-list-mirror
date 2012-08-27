From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 5/7] Fix tests under GETTEXT_POISON on pack-object
Date: Mon, 27 Aug 2012 13:36:53 +0800
Message-ID: <a2e20a1e1ae4be42b763904177cf634a6e291f15.1346045253.git.worldhello.net@gmail.com>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
 <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
 <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com>
 <d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s18-00031a-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab2H0Fhc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:37:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47886 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2H0Fh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:29 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2294471dad.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=0hbN3KgmrzfkA+EJVBuuR9sh9DsjxTK469ffwcWfHgs=;
        b=v/QcuqFdBQZyJcdv2KQpgRM0ZXBje2DvM5fyChgyDm+jeX0KvTh50xWqQiFkfCm/3J
         L4sHumOqnS1z3gJLiBQF4JN3BSWmV3V5CNqXY2sq0pq8tpOQjcJAxpLXL6mnSTCYQlo/
         GFjWEhelLOsiH4RvwAiEJzQeU/uqWLdNeEo8L1oFpLFsvY/nweiRto6+9p88qbKAOLRj
         LxeCOF7tX7CLJFQwiSKAA/atbiMtl6n7BrJxDjR/q+VcRqdlrhiinj3DBh87m6fh7IXc
         l7Y/z/wuwe0orBxXt+LUGl93uKK8JbcsuP/ryR9uVi+2gd2IGdA6w3Qk3ImnYNmpDpAs
         6BKA==
Received: by 10.68.200.227 with SMTP id jv3mr31383739pbc.162.1346045849724;
        Sun, 26 Aug 2012 22:37:29 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.37.25
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:37:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204325>

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
1.7.12.92.gaa91cb5
