Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5F34DCE2
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770550977; cv=none; b=gcOqjf7+jdXSz2Roch18m34B0M/v/da9PSLZhFnIwOYQW+Rqi4QPupqmaB1eL9TyFt2E6HDDjWJ4HDcd07bz3rvejId3ogl1uV/yzB50lGsThY1IJQ9mFRtyn9vN6mZFXU1qU1GDVJQpZqdtFjAsk4tmz2A7x8GVJeAGMPCXHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770550977; c=relaxed/simple;
	bh=w7VwIZVzPDXOtALnnrOverQ1HxrF50IG0ktdu1p7uc8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FYmXvxKkcgeBfuDUcqiR4goG3WHJl6RUS8odBQnWhpE9h98j0+JkVw5H8OPsZv9vcl9Ihq/40REfJcdO4R/E3dzmsPDJPhiLGQoEWMN5SWQ5BQrfcNFbVtH1LTVMJdbV9hwaR3jttyHjDneUh4wfT8NYjfKiX/xW3xW2oyBGQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EUjP70GI; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EUjP70GI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770550969; x=1771155769; i=l.s.r@web.de;
	bh=06JV/rYk1sLWP8G664CNufslIvJPPa82KlgGcZOaLvg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EUjP70GI27NEtYPmzs6sg90QfiA7YOe+uK+6VfQZ6zbS/ajzEUvl+nsYwPlC8pMv
	 nGnVAORcIOb/XqfsY1Rc+zuaTpLxBilZ3HFa7gi4Aj5M7qaV9d7fyw3AS0JTfw3Th
	 Fu02/SRNxD9/NVa/a+++o4e231NDYrASvXGwx+L8BFGkTboCstjoy+eqSof2GpPfE
	 c8kFwvZOubMm1ZQjbpXJ4oxzn9a3uurPMblryyFaTLvhL32ahik5EbuYVTQkNNUrK
	 5SkVAR+YaWp8fTBJSHYDvMngvvpEckcJNuhYxthw7OR/JbvPWwQkUpdf3jmX8ICZP
	 zKnvO8eZTvQns8DOJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwR05-1vYt8R1Q5l-016oOQ for
 <git@vger.kernel.org>; Sun, 08 Feb 2026 12:37:38 +0100
Message-ID: <db40d132-14ca-4749-937a-9410ecc17dde@web.de>
Date: Sun, 8 Feb 2026 12:37:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: use commit_stack
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cyiGpXQFvR1RbyS/15L3kWNUTi33VD7Sqoo16GJEYAaOrUO/oAa
 ooATxxeu08W45HJhtpfRD+Eub/ncUl8ObYIZWenwBDGPNIt+pMqCuW8FCIe4CAgv+EptMCk
 gk765rxrkTiT9sVwhB868kp2WvjlU7pxHASXdl8dPooiduZ6YZrILSN7xSLRWlOo8+CObYQ
 zEyNqz7NHnKnyJEzOJJMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:px6O8W/sqgY=;7Hwifw6GiTveU4Nxvmn00E0LkcI
 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

Use commit_stack instead of open-coding it.  Also convert the loop
counter i to size_t to match the type of the nr member of struct
commit_stack.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index 28bb5ce029..22ef0ea6a3 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -1015,9 +1015,7 @@ void sort_in_topological_order(struct commit_list **=
list, enum rev_sort_order so
 }
=20
 struct rev_collect {
-	struct commit **commit;
-	int nr;
-	int alloc;
+	struct commit_stack stack;
 	unsigned int initial : 1;
 };
=20
@@ -1034,8 +1032,7 @@ static void add_one_commit(struct object_id *oid, st=
ruct rev_collect *revs)
 	    repo_parse_commit(the_repository, commit))
 		return;
=20
-	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
-	revs->commit[revs->nr++] =3D commit;
+	commit_stack_push(&revs->stack, commit);
 	commit->object.flags |=3D TMP_MARK;
 }
=20
@@ -1060,7 +1057,7 @@ struct commit *get_fork_point(const char *refname, s=
truct commit *commit)
 	struct object_id oid;
 	struct rev_collect revs;
 	struct commit_list *bases =3D NULL;
-	int i;
+	size_t i;
 	struct commit *ret =3D NULL;
 	char *full_refname;
=20
@@ -1074,19 +1071,19 @@ struct commit *get_fork_point(const char *refname,=
 struct commit *commit)
 		die("Ambiguous refname: '%s'", refname);
 	}
=20
-	memset(&revs, 0, sizeof(revs));
+	commit_stack_init(&revs.stack);
 	revs.initial =3D 1;
 	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
 				 full_refname, collect_one_reflog_ent, &revs);
=20
-	if (!revs.nr)
+	if (!revs.stack.nr)
 		add_one_commit(&oid, &revs);
=20
-	for (i =3D 0; i < revs.nr; i++)
-		revs.commit[i]->object.flags &=3D ~TMP_MARK;
+	for (i =3D 0; i < revs.stack.nr; i++)
+		revs.stack.items[i]->object.flags &=3D ~TMP_MARK;
=20
-	if (repo_get_merge_bases_many(the_repository, commit, revs.nr,
-				      revs.commit, &bases) < 0)
+	if (repo_get_merge_bases_many(the_repository, commit, revs.stack.nr,
+				      revs.stack.items, &bases) < 0)
 		exit(128);
=20
 	/*
@@ -1097,16 +1094,16 @@ struct commit *get_fork_point(const char *refname,=
 struct commit *commit)
 		goto cleanup_return;
=20
 	/* And the found one must be one of the reflog entries */
-	for (i =3D 0; i < revs.nr; i++)
-		if (&bases->item->object =3D=3D &revs.commit[i]->object)
+	for (i =3D 0; i < revs.stack.nr; i++)
+		if (&bases->item->object =3D=3D &revs.stack.items[i]->object)
 			break; /* found */
-	if (revs.nr <=3D i)
+	if (revs.stack.nr <=3D i)
 		goto cleanup_return;
=20
 	ret =3D bases->item;
=20
 cleanup_return:
-	free(revs.commit);
+	commit_stack_clear(&revs.stack);
 	free_commit_list(bases);
 	free(full_refname);
 	return ret;
=2D-=20
2.52.0
