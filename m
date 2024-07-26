Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D913A3F7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996228; cv=none; b=b7DyMVCbvpmjSq7LLmhe9JSp3YWzf4EXBXZp2m3Cba0L5uFKP7xzGcfEklvpsM28xXdBXyzhN0eNyQNKzA1sZeCf0swfgV08tqyY/953J9kc4JMNK84+3xZeUah5Dp80BKsyoS6yESI1JfJHUSRDXsMOyXFYNh+ChX7tbpvEirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996228; c=relaxed/simple;
	bh=ULg8dQdApo+E5PHQqXHvqZyCaYvNSp6nEXZ32Dtmorc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AppxAbaSNnfkAFfU8HWKpPe8zXM0s1Lqi6ek9kZOVTh0pGENTorFIrNXRp4ZU/2gW+GVbcwl77uS5z/HFNUKlF0n9qYD1+kgm31yfMWIpJfWLOVN6td5NhK/jo8r7/yxvgRsffHYmRjilkE/rGH3UE+H2+3z4J33DdxawaTU0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nqHVV4Uy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f1/L3peq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nqHVV4Uy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f1/L3peq"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7F2B813805DB
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 26 Jul 2024 08:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996225; x=1722082625; bh=wLZaitSLv3
	HXiKArvRvLrBAC+zItTN9WZ+pj1vr0YGI=; b=nqHVV4UyBk7SGARaR4iFEona2L
	fBnryNwY6QIa1QKj9b3JrGY05jxwGND8oi2aGvVn5PBKzeiap9A370hoMqCm3XHZ
	xpXfaFiShCdi+mBBJA/7mA8k2dfVRRnax5rWXX9660fbkMPwcYivc0SVpPMMPkGV
	5H0gql4XysGnqFBGqGTGt6Cwvohgk/EZ51xt5Wa8WBHNvnjHmQvBSB1s/4Lr4jHa
	Ss5F4S6/LBRs3HidVUk/VA8veWWzUWcUtkg2aqnV7dGFetbAcJUBW5/i0bV+YB5D
	7QSbt04yAqpgi6scE0nTfkMBZWp1f2zA8v0YxCDq/aT3yxbGeF0hiKg8lOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996225; x=1722082625; bh=wLZaitSLv3HXiKArvRvLrBAC+zIt
	TN9WZ+pj1vr0YGI=; b=f1/L3peqtVWXL7YfNIq7C/lqBGaMnd+uIhf/+Zg22M6b
	4CDCQzlwcadYrx8rGEW48l5GL9twXq83dU2U105QOmsdKdwoP5m3I9WIL665lVII
	QmW6KbpizmLkJcbOvRMEFpuI9v9hb8ID3sD/IByQtjwXrkDnJ7kSxRw7B0t2u7op
	uTD+4mzDqufSfJlJFlVNj1ruLv/zmHYpbc++9PMKE8B7zr/25DM9dOXVQozOsdze
	yAyx71uyxYtjsRxoBErx8kBLztBVxlacxfFb6+FqPa4PIpXSkfmXnFHdFU/q9U6R
	ioYjOBP1qfozCjntnGZSnUAxD5fI+SIV8iLQd6J8Pw==
X-ME-Sender: <xms:wZOjZlIYCNJeRn-PrVjDwgvzgmcrvA5BogsCs-1H3t-0x6CG3zjEOg>
    <xme:wZOjZhIj2oIHAFINLgDmeBYLE-xkF25EZQKK9eT6qk3YEJYh1c2vbFHZNa_Ly1w0c
    7K37iD-pDkaLS4nzw>
X-ME-Received: <xmr:wZOjZttyW5qj-0pVUQhyXw6iV04rmU-z3Lj1UpjEpnCda1Cl2MnP775YbE9_Ntc2sJ7_KvYBa6YtvM6LXSq0WxwzINnmtRoZOhEnlve-Ypp_LrHK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:wZOjZmYV6PKHp1-UCqKT7c4k1gerSkQuKaXxEjMl5ixOlkKfjJ-SdQ>
    <xmx:wZOjZsaEVlpFDQzlxPONnStdz8zFbm9YC7hNdoFM6PVhmKpRfXys_A>
    <xmx:wZOjZqAIj81VFD4ZruGIzokUoBD6OKRpp3T7YOksvac6bnKwWgUGlg>
    <xmx:wZOjZqb9wy3Tnm1h39ueyq07Zwxbk22ND2Kygd8U4WUkCwZ2dyt0Cw>
    <xmx:wZOjZnwnSgKJRPnbfsPn097cZoNd7yo9zMCZRI8_fW9dR2ba8UcnYMFz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ebc90a87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:15:43 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:16:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/23] builtin/show-branch: fix several memory leaks
Message-ID: <fd857efa9f95d5adfc237b7b21a922b6e55c2865.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ANx1TdvPkYFDO7h"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--6ANx1TdvPkYFDO7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are several memory leaks in git-show-branch(1). Fix them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-branch.c  | 52 +++++++++++++++++++++++++++++-------------
 t/t3202-show-branch.sh |  1 +
 t/t6010-merge-base.sh  |  1 +
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d72f4cb98d..7d797a880c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -502,14 +502,14 @@ static int rev_is_head(const char *head, const char *=
name)
 	return !strcmp(head, name);
 }
=20
-static int show_merge_base(struct commit_list *seen, int num_rev)
+static int show_merge_base(const struct commit_list *seen, int num_rev)
 {
 	int all_mask =3D ((1u << (REV_SHIFT + num_rev)) - 1);
 	int all_revs =3D all_mask & ~((1u << REV_SHIFT) - 1);
 	int exit_status =3D 1;
=20
-	while (seen) {
-		struct commit *commit =3D pop_commit(&seen);
+	for (const struct commit_list *s =3D seen; s; s =3D s->next) {
+		struct commit *commit =3D s->item;
 		int flags =3D commit->object.flags & all_mask;
 		if (!(flags & UNINTERESTING) &&
 		    ((flags & all_revs) =3D=3D all_revs)) {
@@ -635,7 +635,7 @@ static int parse_reflog_param(const struct option *opt,=
 const char *arg,
 int cmd_show_branch(int ac, const char **av, const char *prefix)
 {
 	struct commit *rev[MAX_REVS], *commit;
-	char *reflog_msg[MAX_REVS];
+	char *reflog_msg[MAX_REVS] =3D {0};
 	struct commit_list *list =3D NULL, *seen =3D NULL;
 	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra =3D 0;
@@ -692,6 +692,8 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
 			    parse_reflog_param),
 		OPT_END()
 	};
+	const char **args_copy =3D NULL;
+	int ret;
=20
 	init_commit_name_slab(&name_slab);
=20
@@ -699,8 +701,9 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
=20
 	/* If nothing is specified, try the default first */
 	if (ac =3D=3D 1 && default_args.nr) {
+		DUP_ARRAY(args_copy, default_args.v, default_args.nr);
 		ac =3D default_args.nr;
-		av =3D default_args.v;
+		av =3D args_copy;
 	}
=20
 	ac =3D parse_options(ac, av, prefix, builtin_show_branch_options,
@@ -780,7 +783,7 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
 		}
=20
 		for (i =3D 0; i < reflog; i++) {
-			char *logmsg;
+			char *logmsg =3D NULL;
 			char *nth_desc;
 			const char *msg;
 			char *end;
@@ -790,6 +793,7 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
 			if (read_ref_at(get_main_ref_store(the_repository),
 					ref, flags, 0, base + i, &oid, &logmsg,
 					&timestamp, &tz, NULL)) {
+				free(logmsg);
 				reflog =3D i;
 				break;
 			}
@@ -842,7 +846,8 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
=20
 	if (!ref_name_cnt) {
 		fprintf(stderr, "No revs to be shown.\n");
-		exit(0);
+		ret =3D 0;
+		goto out;
 	}
=20
 	for (num_rev =3D 0; ref_name[num_rev]; num_rev++) {
@@ -879,11 +884,15 @@ int cmd_show_branch(int ac, const char **av, const ch=
ar *prefix)
=20
 	commit_list_sort_by_date(&seen);
=20
-	if (merge_base)
-		return show_merge_base(seen, num_rev);
+	if (merge_base) {
+		ret =3D show_merge_base(seen, num_rev);
+		goto out;
+	}
=20
-	if (independent)
-		return show_independent(rev, num_rev, rev_mask);
+	if (independent) {
+		ret =3D show_independent(rev, num_rev, rev_mask);
+		goto out;
+	}
=20
 	/* Show list; --more=3D-1 means list-only */
 	if (1 < num_rev || extra < 0) {
@@ -919,8 +928,10 @@ int cmd_show_branch(int ac, const char **av, const cha=
r *prefix)
 			putchar('\n');
 		}
 	}
-	if (extra < 0)
-		exit(0);
+	if (extra < 0) {
+		ret =3D 0;
+		goto out;
+	}
=20
 	/* Sort topologically */
 	sort_in_topological_order(&seen, sort_order);
@@ -932,8 +943,8 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
 	all_mask =3D ((1u << (REV_SHIFT + num_rev)) - 1);
 	all_revs =3D all_mask & ~((1u << REV_SHIFT) - 1);
=20
-	while (seen) {
-		struct commit *commit =3D pop_commit(&seen);
+	for (struct commit_list *l =3D seen; l; l =3D l->next) {
+		struct commit *commit =3D l->item;
 		int this_flag =3D commit->object.flags;
 		int is_merge_point =3D ((this_flag & all_revs) =3D=3D all_revs);
=20
@@ -973,6 +984,15 @@ int cmd_show_branch(int ac, const char **av, const cha=
r *prefix)
 		if (shown_merge_point && --extra < 0)
 			break;
 	}
+
+	ret =3D 0;
+
+out:
+	for (size_t i =3D 0; i < ARRAY_SIZE(reflog_msg); i++)
+		free(reflog_msg[i]);
+	free_commit_list(seen);
+	free_commit_list(list);
+	free(args_copy);
 	free(head);
-	return 0;
+	return ret;
 }
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index a1139f79e2..3b6dad0c46 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'test show-branch'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'error descriptions on empty repository' '
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 44c726ea39..f96ea82e78 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -6,6 +6,7 @@
 test_description=3D'Merge base and parent list computation.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 M=3D1130000000
--=20
2.46.0.rc1.dirty


--6ANx1TdvPkYFDO7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk7IACgkQVbJhu7ck
PpTWlBAAlD1Zkqy9KdR+7UcK5dE2hmnoMkSbld4wbr+qXvwuPWSIw1DiPLJJS8tg
DB134IDDHNJ+b17dyiM1CMw9TGlpGf/+IXUSZSi+7Kmlx+Xr0IavYvNdexFzxPvM
Q2wni//0sZ1EI3wtUuHqDDqI9uWV+hmzn5ox/l8S5JWXK8F9jAUbxJwMCZTalI/6
G8Sg5mwStyKO57M67AqfjgbLAms3qbi1xAZaa52FsRooPvn1i7SZ5gATZIg52X/n
tP5Ha0SPg/PesBYkXfFWkDDfrZLXZYSQ+wVY08QjIlEh8dng9mC4YpKoa9N+UvYh
1MWx2/WWQhE04pyCWAoEIWz/aNnWX2T7bJGVW2CltCfWmT6F/ItD3NFu4z9ROzgH
DQKZTJEEZJopbLW+OCrFYI016d6oMXmfwULa/kkp44PGoFr9vml+Mp+FPIPaLl5Z
VBrd59pv4sEa25rBiya1ITt18J2Q0RiKQ5+4KaCxvOHjNTe8XX5IewlRsAXF9NFv
xQJdEhECRotDDj3Hml5tyg7tyylZO+T/O3ZaqzDfO/wrjl5WKSo0bJs+1DRCGPas
SCNC7SJigCaloc/1chb6ilC0FQMMW2O6uOGZpQj/Vum6+ItMKduWS1bIZ2/HrSuL
AXTAycOCW93fjvAT7ECyTmqj4aV/5khYLLxSe0wPw9fVt5R6ycs=
=rpS5
-----END PGP SIGNATURE-----

--6ANx1TdvPkYFDO7h--
