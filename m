From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 15/19] unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
Date: Thu, 20 Aug 2009 20:47:09 +0700
Message-ID: <1250776033-12395-16-git-send-email-pclouds@gmail.com>
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
 <1250776033-12395-14-git-send-email-pclouds@gmail.com>
 <1250776033-12395-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81M-0007ZS-GZ
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbZHTNsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754494AbZHTNsm
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:42 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:62823 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbZHTNsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:41 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so3269349pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=of3/95CJ4CPIK2ISXQOQLO88p9is3/A639TqY7ipdjQ=;
        b=jzYgDDRpVI41F0JmkdXzKK/gOB7I5/2R63RTqi+A/waNQB8mQP/oUYcl7CbdiptkQr
         V7OVEGRSJTFgZd2UgwFr/1RL2qi9yvyV/4BHIBZ4uMIoorVA4yw4iw1Q8LY5KNoGV02D
         5Y+lp1gd7Kxn78DSDS3f6sj2+/1m8TR9GSW48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=c5T0oJnx6NtOf6DWX4fS0HmYNI1jDCtUbFduq7YtaKdpa9BOtzoAUw47u/nZjnSoZc
         3MsOc4FJSSJGQbyOTYH2+at3GjQRoiClAcfu2Y0r1xx7d0l9KASZc4MNgw3v6/YAu+Yu
         hWM/2+UbmA2MKTb+Z/axBxvZj3N/JHQqcxJMQ=
Received: by 10.115.115.12 with SMTP id s12mr9377897wam.126.1250776123661;
        Thu, 20 Aug 2009 06:48:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 21sm186110pzk.3.2009.08.20.06.48.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:37 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-15-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126635>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 unpack-trees.h |    2 +
 2 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 44f8fdf..2d8ecb7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -32,6 +32,12 @@ static struct unpack_trees_error_msgs unpack_plumbin=
g_errors =3D {
=20
 	/* bind_overlap */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
+
+	/* sparse_not_uptodate_file */
+	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+
+	/* would_lose_orphaned */
+	"Working tree file '%s' would be %s by sparse checkout update.",
 };
=20
 #define ERRORMSG(o,fld) \
@@ -125,6 +131,57 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	return errs !=3D 0;
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce, struct unpac=
k_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion, struct unpack_trees_options *o);
+
+static int will_have_skip_worktree(const struct cache_entry *ce, struc=
t unpack_trees_options *o)
+{
+	const char *basename;
+
+	if (ce_stage(ce))
+		return 0;
+
+	basename =3D strrchr(ce->name, '/');
+	basename =3D basename ? basename+1 : ce->name;
+	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, o=
->el) <=3D 0;
+}
+
+static int apply_sparse_checkout(struct cache_entry *ce, struct unpack=
_trees_options *o)
+{
+	int was_skip_worktree =3D ce_skip_worktree(ce);
+
+	if (will_have_skip_worktree(ce, o))
+		ce->ce_flags |=3D CE_SKIP_WORKTREE;
+	else
+		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
+
+	/*
+	 * We only care about files getting into the checkout area
+	 * If merge strategies want to remove some, go ahead, this
+	 * flag will be removed eventually in unpack_trees() if it's
+	 * outside checkout area.
+	 */
+	if (ce->ce_flags & CE_REMOVE)
+		return 0;
+
+	if (!was_skip_worktree && ce_skip_worktree(ce)) {
+		/*
+		 * If CE_UPDATE is set, verify_uptodate() must be called already
+		 * also stat info may have lost after merged_entry() so calling
+		 * verify_uptodate() again may fail
+		 */
+		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+			return -1;
+		ce->ce_flags |=3D CE_WT_REMOVE;
+	}
+	if (was_skip_worktree && !ce_skip_worktree(ce)) {
+		if (verify_absent_sparse(ce, "overwritten", o))
+			return -1;
+		ce->ce_flags |=3D CE_UPDATE;
+	}
+	return 0;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
@@ -376,7 +433,7 @@ static int unpack_failed(struct unpack_trees_option=
s *o, const char *message)
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_tree=
s_options *o)
 {
-	int ret;
+	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
=20
@@ -440,6 +497,17 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 		goto done;
 	}
=20
+	if (!o->skip_sparse_checkout) {
+		for (i =3D 0;i < o->result.cache_nr;i++) {
+			struct cache_entry *ce =3D o->result.cache[i];
+
+			if (apply_sparse_checkout(ce, o)) {
+				ret =3D -1;
+				goto done;
+			}
+		}
+	}
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -512,6 +580,12 @@ static int verify_uptodate(struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce,
+				  struct unpack_trees_options *o)
+{
+	return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_uptodate_file)=
);
+}
+
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
 {
 	if (ce)
@@ -705,6 +779,12 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
 }
=20
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_orphaned=
));
+}
+
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
 {
diff --git a/unpack-trees.h b/unpack-trees.h
index 5c9e98a..95ff36c 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -15,6 +15,8 @@ struct unpack_trees_error_msgs {
 	const char *not_uptodate_dir;
 	const char *would_lose_untracked;
 	const char *bind_overlap;
+	const char *sparse_not_uptodate_file;
+	const char *would_lose_orphaned;
 };
=20
 struct unpack_trees_options {
--=20
1.6.3.GIT
