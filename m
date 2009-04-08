From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] attr: add GIT_ATTR_INDEX "direction"
Date: Wed,  8 Apr 2009 20:05:30 +1000
Message-ID: <1239185133-4181-6-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
 <1239185133-4181-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUi1-0005bq-Vu
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbZDHKHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763991AbZDHKHJ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:07:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661AbZDHKHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:07:07 -0400
Received: by rv-out-0506.google.com with SMTP id f9so37692rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=29mTyWPfMXzpu99vzRnKYkc8MS5uSd0A5pNCrdqDt0c=;
        b=i2xWkBkvTDdE8mbQjLFa0ZIAE8yHz6JYwEc1ZzC2smFVYiFGTgOCnvbdVrYfKoanbP
         pQpm9NnOaLSu7nz06d651DkQHhI6GGSM680pircykAAUFq82HECkaRF1kSaDKO3Z6FtV
         ly//qTKjFENBln9KnOlpWsyf+TYVoDwgaKhs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZflUxLG0Y/VJL6SDkDos4GkFku9NwLBpwzSF4yqgbJg5Y7iB1EegO4Y4L0tRIX96sA
         TGmsTjgsTfTFpwAOa28c10M6hN1K98CIt9uEwMsUBvoaOksYqu2VxtyrIv216/HnqR0n
         T+SfBekQnbr9GqcfXC7xouGqWaoeP45juCnpM=
Received: by 10.140.177.13 with SMTP id z13mr463884rve.202.1239185227551;
        Wed, 08 Apr 2009 03:07:07 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id f42sm24858988rvb.21.2009.04.08.03.07.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:07:06 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:06:59 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116068>

This instructs attr mechanism not to look into working .gitattributes
at all. Needed by tools that does not handle working directory, such
as "git archive".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c |    4 +++-
 attr.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 43259e5..37ca288 100644
--- a/attr.c
+++ b/attr.c
@@ -405,7 +405,7 @@ static struct attr_stack *read_attr(const char *pat=
h, int macro_ok)
 		if (!res)
 			res =3D read_attr_from_file(path, macro_ok);
 	}
-	else {
+	else if (direction =3D=3D GIT_ATTR_CHECKIN) {
 		res =3D read_attr_from_file(path, macro_ok);
 		if (!res)
 			/*
@@ -415,6 +415,8 @@ static struct attr_stack *read_attr(const char *pat=
h, int macro_ok)
 			 */
 			res =3D read_attr_from_index(path, macro_ok);
 	}
+	else
+		res =3D read_attr_from_index(path, macro_ok);
 	if (!res)
 		res =3D xcalloc(1, sizeof(*res));
 	return res;
diff --git a/attr.h b/attr.h
index 3a2f4ec..69b5767 100644
--- a/attr.h
+++ b/attr.h
@@ -33,7 +33,8 @@ int git_checkattr(const char *path, int, struct git_a=
ttr_check *);
=20
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
-	GIT_ATTR_CHECKOUT
+	GIT_ATTR_CHECKOUT,
+	GIT_ATTR_INDEX,
 };
 void git_attr_set_direction(enum git_attr_direction, struct index_stat=
e *);
=20
--=20
1.6.2.2.602.g83ee9f
