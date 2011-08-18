From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] decoration: do not mis-decorate refs with same prefix
Date: Thu, 18 Aug 2011 19:29:34 +0700
Message-ID: <1313670578-2939-2-git-send-email-pclouds@gmail.com>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 14:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu1jT-0001Lc-U0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 14:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab1HRM3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 08:29:53 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41218 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab1HRM3x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 08:29:53 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so2928610pzk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0qkP49ISUxTbsucx+CUq18P+tBPWsd6rswtTqOt4oK8=;
        b=UGkgdJwYP+hYaX6YZsEfMxMHeJYwVsc6YSYHI8DJLBcmsFR3M0bqShAxm3BoWv4Ii4
         oqVGSrk+2ihB5FigsNDG9yUqpRkzC9HPu+8Yai+A3NLGpl33Vq1hZOjIMCtuor5Etm4j
         c7Eoqk8j9lA1dWRUbZQzKXC2xO4p3vtck26+Q=
Received: by 10.143.77.8 with SMTP id e8mr394993wfl.130.1313670592928;
        Thu, 18 Aug 2011 05:29:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id e6sm1441200pbm.39.2011.08.18.05.29.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 05:29:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 19:29:46 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179590>

We definitely do not want to decorate refs/headsandtails the same as
refs/heads/*, for example.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index e945701..344f734 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -95,11 +95,11 @@ static int add_ref_decoration(const char *refname, =
const unsigned char *sha1, in
 	if (!obj)
 		return 0;
=20
-	if (!prefixcmp(refname, "refs/heads"))
+	if (!prefixcmp(refname, "refs/heads/"))
 		type =3D DECORATION_REF_LOCAL;
-	else if (!prefixcmp(refname, "refs/remotes"))
+	else if (!prefixcmp(refname, "refs/remotes/"))
 		type =3D DECORATION_REF_REMOTE;
-	else if (!prefixcmp(refname, "refs/tags"))
+	else if (!prefixcmp(refname, "refs/tags/"))
 		type =3D DECORATION_REF_TAG;
 	else if (!prefixcmp(refname, "refs/stash"))
 		type =3D DECORATION_REF_STASH;
--=20
1.7.4.74.g639db
