From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] archive: disregard .gitattributes on working directory
Date: Wed,  8 Apr 2009 20:05:32 +1000
Message-ID: <1239185133-4181-8-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
 <1239185133-4181-5-git-send-email-pclouds@gmail.com>
 <1239185133-4181-6-git-send-email-pclouds@gmail.com>
 <1239185133-4181-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUjH-0005yX-CF
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763076AbZDHKHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757790AbZDHKHY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:07:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761697AbZDHKHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:07:20 -0400
Received: by rv-out-0506.google.com with SMTP id f9so37692rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uINkNFyJ21qHtxgq4VZmfOPuAJwf16Q4tgIxugOvKTg=;
        b=ElHCOfYmArRipEz55aAfVCyJxb34aqGsWTV7O39qst4RFO71bFGp/L1D3Pao9n0SZQ
         jxh4GK5O/hawkF7v/pBqOzbzTjySJlUNBf1vHbWiSQjJyfA2u1/ZsKFaOOUymY0Jc4B+
         2vvrF9w9JmXsEYaVBtbghVd6LEfCnq6tKHfWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OX5CRWi2YoV6dD9JkQ50Z9U54aJfocamYrK3K+hE4qIP7JDWqHuDgkRukDRIGegSqA
         QpMadS1y3KV7TDhyXORWqaIHfU0lGVcOAc+lofFyjE5Sl1HlJRi/0QS6N4ekIxlG+DzK
         WngWtG7qhOaALi1Xm6C+6k//vWam1gc1qoMX0=
Received: by 10.141.151.18 with SMTP id d18mr465865rvo.134.1239185240586;
        Wed, 08 Apr 2009 03:07:20 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id g31sm3504582rvb.38.2009.04.08.03.07.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:07:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:07:14 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116073>

Some tests in t500-tar-tree.sh depends on in-worktree
=2Egitattributes. Fix them too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 We could make an option to keep old behaviour. But is it worth it?

 archive.c               |    1 +
 t/t0024-crlf-archive.sh |    2 +-
 t/t5000-tar-tree.sh     |    6 +++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index 402f6d4..1ce644e 100644
--- a/archive.c
+++ b/archive.c
@@ -138,6 +138,7 @@ static int write_archive_entry(const unsigned char =
*sha1, const char *base,
 	path_without_prefix =3D path.buf + args->baselen;
=20
 	setup_archive_check(check);
+	git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
 	if (!git_checkattr(path_without_prefix, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 1cbe511..bf531fc 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -69,7 +69,7 @@ test_expect_success UNZIP 'zip archive' '
=20
 '
=20
-test_expect_failure '.gitattributes in workdir should not be consulted=
' '
+test_expect_success '.gitattributes in workdir should not be consulted=
' '
 	echo "sample -crlf" > .gitattributes &&
 	git archive --format=3Dtar HEAD |
 	( mkdir untarred2 && cd untarred2 && "$TAR" -xf - )
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7641e0d..420e7ad 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -56,6 +56,7 @@ test_expect_success \
     'add files to repository' \
     'find a -type f | xargs git update-index --add &&
      find a -type l | xargs git update-index --add &&
+     git update-index --add .gitattributes &&
      treeid=3D`git write-tree` &&
      echo $treeid >treeid &&
      git update-ref HEAD $(TZ=3DGMT GIT_COMMITTER_DATE=3D"2005-05-27 2=
2:00:00" \
@@ -140,6 +141,8 @@ test_expect_success \
 test_expect_success \
     'create archives with substfiles' \
     'echo "substfile?" export-subst >a/.gitattributes &&
+     git add a/.gitattributes &&
+     git commit -q -m new &&
      git archive HEAD >f.tar &&
      git archive --prefix=3Dprefix/ HEAD >g.tar &&
      rm a/.gitattributes'
@@ -165,7 +168,8 @@ test_expect_success \
      'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEA=
D \
       >g/prefix/a/substfile1.expected &&
       test_cmp g/prefix/a/substfile1.expected g/prefix/a/substfile1 &&
-      test_cmp a/substfile2 g/prefix/a/substfile2
+      test_cmp a/substfile2 g/prefix/a/substfile2 &&
+      git reset HEAD^
 '
=20
 test_expect_success \
--=20
1.6.2.2.602.g83ee9f
