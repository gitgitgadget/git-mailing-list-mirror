From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 32/72] gettextize: git-fetch formatting messages
Date: Sat, 19 Feb 2011 19:24:15 +0000
Message-ID: <1298143495-3681-33-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsW1-0004Tk-20
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab1BSTaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:30:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab1BST1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:52 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=tOSfSMypyMt8IOLgaUiEW1jYiEXqrIuk+gU7AlKndTs=;
        b=jX8SrxBcU/TWftsciAJfT7Kfd6Olw7w2X5RDizArz2t0L1WA8FSfzM7LjPXbAVDIQU
         cbcR0/JlS8Cu3g2+GmU1iRloQ0yX4KouYjxvBSvtkFyC18O1Ren1pDcyt+tMTGlPsfKD
         g1tmMGRvt3bGQcDxfnAwceZ1NRF5VHvQPEd/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kk3yl/aNZ8PDH++FOyHRVssmDRQYRksF63T0y1Fp7K0NxccpgHEJDesvGwIPx5EaVN
         y6k2esQHD48ggzzmdeVzDnu68I7AXk99N3pae7QdMFKBICfBPHpa/gVejSKuHm03lpAn
         ARy/rL0oCX/BYLxKkIWQ0HDpaY/t+FE5uGXdI=
Received: by 10.213.19.5 with SMTP id y5mr2521953eba.62.1298143671957;
        Sat, 19 Feb 2011 11:27:51 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.51
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:51 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167373>

Translate some of the formatting messages that appear on git-fetch
showing how branches/tags etc. were updated.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fetch.c             |   20 ++++++++++----------
 t/t5526-fetch-submodules.sh |   40 ++++++++++++++++++++++++++++++++---=
-----
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c27c3e9..0a73dff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -242,7 +242,7 @@ static int update_local_ref(struct ref *ref,
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbosity > 0)
 			sprintf(display, "=3D %-*s %-*s -> %s", TRANSPORT_SUMMARY_WIDTH,
-				"[up to date]", REFCOL_WIDTH, remote,
+				_("[up to date]"), REFCOL_WIDTH, remote,
 				pretty_ref);
 		return 0;
 	}
@@ -255,8 +255,8 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		sprintf(display, "! %-*s %-*s -> %s  (can't fetch in current branch)=
",
-			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
+		sprintf(display, _("! %-*s %-*s -> %s  (can't fetch in current branc=
h)"),
+			TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,
 			pretty_ref);
 		return 1;
 	}
@@ -266,8 +266,8 @@ static int update_local_ref(struct ref *ref,
 		int r;
 		r =3D s_update_ref("updating tag", ref, 0);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
-			TRANSPORT_SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
-			pretty_ref, r ? "  (unable to update local ref)" : "");
+			TRANSPORT_SUMMARY_WIDTH, _("[tag update]"), REFCOL_WIDTH, remote,
+			pretty_ref, r ? _("  (unable to update local ref)") : "");
 		return r;
 	}
=20
@@ -415,7 +415,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
 			if (verbosity >=3D 0 && !shown_url) {
-				fprintf(stderr, "From %.*s\n",
+				fprintf(stderr, _("From %.*s\n"),
 						url_len, url);
 				shown_url =3D 1;
 			}
@@ -524,16 +524,16 @@ static int prune_refs(struct transport *transport=
, struct ref *ref_map)
 	int result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote, r=
ef_map);
 	const char *dangling_msg =3D dry_run
-		? "   (%s will become dangling)\n"
-		: "   (%s has become dangling)\n";
+		? _("   (%s will become dangling)\n")
+		: _("   (%s has become dangling)\n");
=20
 	for (ref =3D stale_refs; ref; ref =3D ref->next) {
 		if (!dry_run)
 			result |=3D delete_ref(ref->name, NULL, 0);
 		if (verbosity >=3D 0) {
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
-				TRANSPORT_SUMMARY_WIDTH, "[deleted]",
-				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));
+				TRANSPORT_SUMMARY_WIDTH, _("[deleted]"),
+				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a5f4585..617ce67 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -66,7 +66,10 @@ test_expect_success "fetch --recurse-submodules recu=
rses into submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success NO_GETTEXT_POISON "fetch --recurse-submodules recu=
rses into submodules: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -95,7 +98,10 @@ test_expect_success "using fetchRecurseSubmodules=3D=
true in .gitmodules recurses i
 		cd downstream &&
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules=
 true &&
 		git fetch >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success NO_GETTEXT_POISON "using fetchRecurseSubmodules=3D=
true in .gitmodules recurses into submodules" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -126,7 +132,10 @@ test_expect_success "--recurse-submodules override=
s fetchRecurseSubmodules setti
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
 		git config --unset -f .gitmodules submodule.submodule.fetchRecurseSu=
bmodules &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
-	) &&
+	)
+'
+
+test_expect_success NO_GETTEXT_POISON "--recurse-submodules overrides =
fetchRecurseSubmodules setting from .git/config: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -145,13 +154,22 @@ test_expect_success "--dry-run propagates to subm=
odules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.=
err
-	) &&
+	)
+'
+
+test_expect_success NO_GETTEXT_POISON "--dry-run propagates to submodu=
les: output" '
 	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "Without --dry-run propagates to submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success NO_GETTEXT_POISON "Without --dry-run propagates to=
 submodules: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -162,7 +180,10 @@ test_expect_success "recurseSubmodules=3Dtrue prop=
agates into submodules" '
 		cd downstream &&
 		git config fetch.recurseSubmodules true
 		git fetch >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success NO_GETTEXT_POISON "recurseSubmodules=3Dtrue propag=
ates into submodules: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -176,7 +197,10 @@ test_expect_success "--recurse-submodules override=
s config in submodule" '
 			git config fetch.recurseSubmodules false
 		) &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success NO_GETTEXT_POISON "--recurse-submodules overrides =
config in submodule: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
--=20
1.7.2.3
