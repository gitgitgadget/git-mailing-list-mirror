Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F15155C97
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784349564; cv=none; b=iXaRjvJWkuge8JtEIpkUi4oLtfnkymwRncbpDulSu5/zFHKKzWhG+JYVfCG27s0PmWYZq9/NV/YuGtToL9k1dqQHbrmGGv+cOaENYKn6K0XDNVOg2Sq0+Zz5dEGiDO/BsL+GC2MIztCs8981swoIWRX3ZJedh6b8x9/h+JFjMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784349564; c=relaxed/simple;
	bh=WN2dcDhJxNxV6IFRpsljfbRiAQsA9a3EncY5VFp/I5o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hsCNiabeN070k5Cn8dn1R4cvjEfTEcj4+WTGqPbsebvL8XqxHakYGuNzLWwX0tSIuPzjbzUjjqsScoJv8XKXT3VInMp1sH4MkC/VL1UFeiwYpGb4dHkFChhtQ1VazQiayzb66UUdzZ86lExa0PwY+s9U5i19Pu8DLybHGKWc2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rlIju8+8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rlIju8+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784349558; x=1784954358; i=l.s.r@web.de;
	bh=XoN+N+7Vajirgo555m4l11EU1HG64uACpBSwQ8BX44U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rlIju8+8zSvViJtbVfvtlxG2DGOgfN4du3c5L8mFwSoTk+VyY/tNZWF9YSOHRlbH
	 ho+B3sNlw/EQ5B3u2K8c7ZowT0lxeQsaVJ2lRHIilXHyZoJnrV1SvysADcebYvfQT
	 TZumMxwfD73vX+DaknwupdYXAcNZjVQeW/jp0lLFDafdsZ6DL6Gdf3bHxUs82MhxE
	 /RFFETgVXHP2BIYs8qvWn2zin1pdHr3I5ZBbEQ/8mhK5ZqYM9HEZ5j9I9C7ayrYvW
	 JWpH3Nes7ckOYuerkM6no473ybLrJxa/Uuo/Vi8YGg3mGcdHX3TEc4gKacjbGMIB9
	 SvBn5DB+PdhM4WKckw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1xBJKx2lPd-00tdNI; Sat, 18
 Jul 2026 06:39:18 +0200
Message-ID: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
Date: Sat, 18 Jul 2026 06:39:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: stsp <stsp2@yandex.ru>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] branch: report kind of checkout when rejecting delete
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fMX4l2VWqHynZiW/WalFyKOiPYoU03e/vwtLuMqIXwxYAnIcvIU
 ZKozqtEpvnySCP8JIENSS9ciZ24DzhOlXijmUm8Kb5dalk0PRyyAd91QMqbluO98JcXREQY
 jUpOsBRsu94aq0NMPNV93hCeWLRoZx1dj1UlNBr/ER+JiVRFn+EkmwAhg19YFZsDC0zLbx4
 U815ykydT76NyMxk+4zuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oz/nBpK8KW4=;syDxjgVBd0xf0Vny2OKJrbDH/GG
 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
 2JKqQM1etlX7

git branch refuses to delete branches that are currently checked out
with a message like this: "error: cannot delete branch 'foo' used by
worktree at '/path/of/worktree'".  This can be confusing with internal
checkouts, e.g. if one tries to delete a branch associated with an
active bisect run.

Mention the kind of internal checkout, if any, to spare the user from
remembering that they might have forgotten a bisect or rebase.  To do
that, register the checkout reason in a strintmap alongside the existing
strmap that stores the worktree path.

Suggested-by: stsp <stsp2@yandex.ru>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Original message:
https://lore.kernel.org/git/cae34516-5437-49d3-8d39-16f4059a81a8@yandex.ru=
/

 branch.c          | 48 ++++++++++++++++++++++++++---------------------
 branch.h          | 15 +++++++++++++++
 builtin/branch.c  | 31 +++++++++++++++++++++++++++---
 t/t3200-branch.sh |  4 ++--
 4 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..aaa54f1b62 100644
=2D-- a/branch.c
+++ b/branch.c
@@ -384,6 +384,16 @@ int validate_branchname(const char *name, struct strb=
uf *ref)
=20
 static int initialized_checked_out_branches;
 static struct strmap current_checked_out_branches =3D STRMAP_INIT;
+static struct strintmap current_checked_out_branch_kinds =3D STRINTMAP_IN=
IT;
+
+static void register_checked_out_branch(const char *refname, const char *=
path,
+					enum branch_checkout_kind kind)
+{
+	char *old =3D strmap_put(&current_checked_out_branches, refname,
+			       xstrdup(path));
+	free(old);
+	strintmap_set(&current_checked_out_branch_kinds, refname, kind);
+}
=20
 static void prepare_checked_out_branches(void)
 {
@@ -397,7 +407,7 @@ static void prepare_checked_out_branches(void)
 	worktrees =3D get_worktrees();
=20
 	while (worktrees[i]) {
-		char *old, *wt_gitdir;
+		char *wt_gitdir;
 		struct wt_status_state state =3D { 0 };
 		struct worktree *wt =3D worktrees[i++];
 		struct string_list update_refs =3D STRING_LIST_INIT_DUP;
@@ -405,22 +415,17 @@ static void prepare_checked_out_branches(void)
 		if (wt->is_bare)
 			continue;
=20
-		if (wt->head_ref) {
-			old =3D strmap_put(&current_checked_out_branches,
-					 wt->head_ref,
-					 xstrdup(wt->path));
-			free(old);
-		}
+		if (wt->head_ref)
+			register_checked_out_branch(wt->head_ref, wt->path,
+				BRANCH_CHECKOUT_KIND_CHECKOUT);
=20
 		if (wt_status_check_rebase(wt, &state) &&
 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) =
&&
 		    state.branch) {
 			struct strbuf ref =3D STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.branch);
-			old =3D strmap_put(&current_checked_out_branches,
-					 ref.buf,
-					 xstrdup(wt->path));
-			free(old);
+			register_checked_out_branch(ref.buf, wt->path,
+				BRANCH_CHECKOUT_KIND_REBASE);
 			strbuf_release(&ref);
 		}
 		wt_status_state_free_buffers(&state);
@@ -429,10 +434,8 @@ static void prepare_checked_out_branches(void)
 		    state.bisecting_from) {
 			struct strbuf ref =3D STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
-			old =3D strmap_put(&current_checked_out_branches,
-					 ref.buf,
-					 xstrdup(wt->path));
-			free(old);
+			register_checked_out_branch(ref.buf, wt->path,
+				BRANCH_CHECKOUT_KIND_BISECT);
 			strbuf_release(&ref);
 		}
 		wt_status_state_free_buffers(&state);
@@ -441,12 +444,9 @@ static void prepare_checked_out_branches(void)
 		if (!sequencer_get_update_refs_state(wt_gitdir,
 						     &update_refs)) {
 			struct string_list_item *item;
-			for_each_string_list_item(item, &update_refs) {
-				old =3D strmap_put(&current_checked_out_branches,
-						 item->string,
-						 xstrdup(wt->path));
-				free(old);
-			}
+			for_each_string_list_item(item, &update_refs)
+				register_checked_out_branch(item->string, wt->path,
+					BRANCH_CHECKOUT_KIND_UPDATE_REF);
 			string_list_clear(&update_refs, 1);
 		}
=20
@@ -462,6 +462,12 @@ const char *branch_checked_out(const char *refname)
 	return strmap_get(&current_checked_out_branches, refname);
 }
=20
+enum branch_checkout_kind branch_checkout_kind(const char *refname)
+{
+	prepare_checked_out_branches();
+	return strintmap_get(&current_checked_out_branch_kinds, refname);
+}
+
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise=
.
  * 'force' can be used when it is OK for the named branch already exists.
diff --git a/branch.h b/branch.h
index 3dc6e2a0ff..d1073fe1cd 100644
=2D-- a/branch.h
+++ b/branch.h
@@ -15,6 +15,14 @@ enum branch_track {
 	BRANCH_TRACK_SIMPLE,
 };
=20
+enum branch_checkout_kind {
+	BRANCH_CHECKOUT_KIND_UNSPECIFIED =3D 0,
+	BRANCH_CHECKOUT_KIND_CHECKOUT,
+	BRANCH_CHECKOUT_KIND_REBASE,
+	BRANCH_CHECKOUT_KIND_BISECT,
+	BRANCH_CHECKOUT_KIND_UPDATE_REF,
+};
+
 /* Functions for acting on the information about branches. */
=20
 /**
@@ -106,6 +114,13 @@ void create_branches_recursively(struct repository *r=
, const char *name,
  */
 const char *branch_checked_out(const char *refname);
=20
+/*
+ * If the branch at 'refname' is currently checked out in a worktree,
+ * then return the kind of checkout, i.e. whether it was done by an
+ * actual checkout or a rebase etc.
+ */
+enum branch_checkout_kind branch_checkout_kind(const char *refname);
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index dede60d27b..3223347129 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -266,9 +266,34 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
 		if (kinds =3D=3D FILTER_REFS_BRANCHES) {
 			const char *path;
 			if ((path =3D branch_checked_out(name))) {
-				error(_("cannot delete branch '%s' "
-					"used by worktree at '%s'"),
-				      bname.buf, path);
+				int kind =3D branch_checkout_kind(name);
+				switch (kind) {
+				case BRANCH_CHECKOUT_KIND_CHECKOUT:
+					error(_("cannot delete branch '%s' "
+						"used by worktree at '%s'"),
+					      bname.buf, path);
+					break;
+				case BRANCH_CHECKOUT_KIND_REBASE:
+					error(_("cannot delete branch '%s' "
+						"used by worktree at '%s' "
+						"for rebase"),
+					      bname.buf, path);
+					break;
+				case BRANCH_CHECKOUT_KIND_BISECT:
+					error(_("cannot delete branch '%s' "
+						"used by worktree at '%s' "
+						"for bisect"),
+					      bname.buf, path);
+					break;
+				case BRANCH_CHECKOUT_KIND_UPDATE_REF:
+					error(_("cannot delete branch '%s' "
+						"used by worktree at '%s' "
+						"for update-ref"),
+					      bname.buf, path);
+					break;
+				default:
+					BUG("invalid checkout kind %d", kind);
+				}
 				ret =3D 1;
 				continue;
 			}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e2682a83a0..e5df493b66 100755
=2D-- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -930,7 +930,7 @@ test_expect_success 'deleting currently checked out br=
anch fails' '
 	git worktree add -b my7 my7 &&
 	test_must_fail git -C my7 branch -d my7 &&
 	test_must_fail git branch -d my7 2>actual &&
-	grep "^error: cannot delete branch .my7. used by worktree at " actual &&
+	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktree a=
t '"'.*'\$"'" actual &&
 	rm -r my7 &&
 	git worktree prune
 '
@@ -941,7 +941,7 @@ test_expect_success 'deleting in-use branch fails' '
 	git -C my7 bisect start HEAD HEAD~2 &&
 	test_must_fail git -C my7 branch -d my7 &&
 	test_must_fail git branch -d my7 2>actual &&
-	grep "^error: cannot delete branch .my7. used by worktree at " actual &&
+	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktree a=
t '"'.*' for bisect\$"'" actual &&
 	rm -r my7 &&
 	git worktree prune
 '
=2D-=20
2.55.0

