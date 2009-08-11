From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Tue, 11 Aug 2009 22:44:06 +0700
Message-ID: <1250005446-12047-9-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
 <1250005446-12047-7-git-send-email-pclouds@gmail.com>
 <1250005446-12047-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatXI-0007BD-K9
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbZHKPpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbZHKPpC
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:45:02 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29186 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbZHKPpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:45:00 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1344620rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ufCiO8l135HP2K9PRgOb6zy65wF6XHBSK1Cw2virzZQ=;
        b=ZTT7BNk7ELkQzi5ynhKI5aaa00ul4h22flsOF0MTbIXm+M3LDFqH2pFMkiaMRbA93Q
         8dtgj6xHwTaBVNufcsekrY36gv1fQJq5RA+sQwNwSMwv2rTUP2MVb9QrA+HN9Ow3VboU
         c5YzDXWjZrAzG/5to4X8ZaklYLOH8VZd9TXbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=auHyrCXVKszjBqpBENKDl9uEjVMlwGwKOwmCFvmZ44fxLFp4k+w4Nuz/i53Lfyr62L
         KtTbvR8oKuqzdIXliMqpo6RMv8CuReJYrHxyxPyOtgcJNyabpMSrHyWEWB0VU08BJUlc
         4Hg+FUSIEY6lA4guZOerIzNTyHVVfvM+/Tejs=
Received: by 10.140.207.2 with SMTP id e2mr2622136rvg.159.1250005501916;
        Tue, 11 Aug 2009 08:45:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id f42sm1742202rvb.35.2009.08.11.08.44.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:45:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:56 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125582>

This series is useless until now because no one would use read-tree to
checkout. At least with this, you can really use/test the series.
Porcelain design was originally "if you have .git/info/sparse,
porcelains will use it, if you don't like that, remove
=2Egit/info/sparse" while plumblings have an option to
enable/disable this feature.

And I still like that behavior. How about we enable sparse checkout
by default for porcelains and make a config option to disable it?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-checkout.c |    4 ++++
 builtin-merge.c    |    5 ++++-
 git-pull.sh        |    6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 446cac7..cec21ab 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -30,6 +30,7 @@ struct checkout_opts {
 	int force;
 	int writeout_stage;
 	int writeout_error;
+	int apply_sparse;
=20
 	const char *new_branch;
 	int new_branch_log;
@@ -402,6 +403,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		topts.dir =3D xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |=3D DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir =3D ".gitignore";
+		topts.apply_sparse =3D opts->apply_sparse;
 		tree =3D parse_tree_indirect(old->commit->object.sha1);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		tree =3D parse_tree_indirect(new->commit->object.sha1);
@@ -594,6 +596,8 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
+		OPT_SET_INT(0, "sparse", &opts.apply_sparse,
+			    "apply sparse checkout filter", 1),
 		OPT_END(),
 	};
 	int has_dash_dash;
diff --git a/builtin-merge.c b/builtin-merge.c
index 0b12fb3..c14b91d 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -43,7 +43,7 @@ static const char * const builtin_merge_usage[] =3D {
=20
 static int show_diffstat =3D 1, option_log, squash;
 static int option_commit =3D 1, allow_fast_forward =3D 1;
-static int allow_trivial =3D 1, have_message;
+static int allow_trivial =3D 1, have_message, apply_sparse;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
@@ -172,6 +172,7 @@ static struct option builtin_merge_options[] =3D {
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
 		"message to be used for the merge commit (if any)",
 		option_parse_message),
+	OPT_SET_INT(0, "sparse", &apply_sparse, "apply sparse checkout filter=
", 1),
 	OPT__VERBOSITY(&verbosity),
 	OPT_END()
 };
@@ -494,6 +495,7 @@ static int read_tree_trivial(unsigned char *common,=
 unsigned char *head,
 	opts.verbose_update =3D 1;
 	opts.trivial_merges_only =3D 1;
 	opts.merge =3D 1;
+	opts.apply_sparse =3D apply_sparse;
 	trees[nr_trees] =3D parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
@@ -646,6 +648,7 @@ static int checkout_fast_forward(unsigned char *hea=
d, unsigned char *remote)
 	opts.verbose_update =3D 1;
 	opts.merge =3D 1;
 	opts.fn =3D twoway_merge;
+	opts.apply_sparse =3D apply_sparse;
=20
 	trees[nr_trees] =3D parse_tree_indirect(head);
 	if (!trees[nr_trees++])
diff --git a/git-pull.sh b/git-pull.sh
index 0f24182..ba583bf 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -20,6 +20,7 @@ strategy_args=3D diffstat=3D no_commit=3D squash=3D n=
o_ff=3D log_arg=3D verbosity=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
+sparse=3D
 while :
 do
 	case "$1" in
@@ -65,6 +66,9 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=3Dfalse
 		;;
+	--sparse)
+		sparse=3D--sparse
+		;;
 	-h|--h|--he|--hel|--help)
 		usage
 		;;
@@ -201,5 +205,5 @@ merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DI=
R/FETCH_HEAD") || exit
 test true =3D "$rebase" &&
 	exec git-rebase $diffstat $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $diffstat $no_commit $squash $no_ff $log_arg $strategy_=
args \
+exec git-merge $sparse $diffstat $no_commit $squash $no_ff $log_arg $s=
trategy_args \
 	"$merge_name" HEAD $merge_head $verbosity
--=20
1.6.3.GIT
