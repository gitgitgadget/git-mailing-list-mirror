From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 13/19] unpack-trees.c: generalize verify_* functions
Date: Thu, 20 Aug 2009 20:47:07 +0700
Message-ID: <1250776033-12395-14-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
 <1250776033-12395-11-git-send-email-pclouds@gmail.com>
 <1250776033-12395-12-git-send-email-pclouds@gmail.com>
 <1250776033-12395-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81L-0007ZS-1R
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbZHTNsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZHTNsb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbZHTNsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:30 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=llHhansJ8zWuzwGkZZJEqM3UUX2IupX70fyHc85RzRQ=;
        b=GS2tz2cuKMe8ywnj6VmUXYqAUaKVi3z4AjHWkbyaLZ0N0hoVFfgukhikPhLnesAi9I
         AseJmOAjv+OlZq2pea+gWOq7QorGWxBcV9N75zTLf21cL9xCPiu/GHSIajSE1f20/887
         8VOVR3+rblFZ0KFuEppfRQinlshWIpisha99s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LKVbJ4RiYVaqYzkr+ubSNThPPN39AQFpzLqtPHioe7su64ckK0efMW4pxCXlhipaTu
         viGhj8+/sxTVOAH3sZ/wpA1f2VfHQ1nW8i+EF5U4k9wcc6d7VTuK4IPHhs5/yBav1PgZ
         uSnR62qanEPxZUyfGZG9U9Il+n5p0cUK/+V5M=
Received: by 10.140.125.19 with SMTP id x19mr2970513rvc.78.1250776112845;
        Thu, 20 Aug 2009 06:48:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id k2sm6784818rvb.23.2009.08.20.06.48.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:26 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-13-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126636>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6a51a69..8eb4b70 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -452,8 +452,9 @@ static int same(struct cache_entry *a, struct cache=
_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static int verify_uptodate(struct cache_entry *ce,
-		struct unpack_trees_options *o)
+static int verify_uptodate_1(struct cache_entry *ce,
+				   struct unpack_trees_options *o,
+				   const char *error_msg)
 {
 	struct stat st;
=20
@@ -478,7 +479,13 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno =3D=3D ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(ERRORMSG(o, not_uptodate_file), ce->name);
+		error(error_msg, ce->name);
+}
+
+static int verify_uptodate(struct cache_entry *ce,
+			   struct unpack_trees_options *o)
+{
+	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
@@ -586,8 +593,9 @@ static int icase_exists(struct unpack_trees_options=
 *o, struct cache_entry *dst,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent(struct cache_entry *ce, const char *action,
-			 struct unpack_trees_options *o)
+static int verify_absent_1(struct cache_entry *ce, const char *action,
+				 struct unpack_trees_options *o,
+				 const char *error_msg)
 {
 	struct stat st;
=20
@@ -667,6 +675,11 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	}
 	return 0;
 }
+static int verify_absent(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
+}
=20
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
--=20
1.6.3.GIT
