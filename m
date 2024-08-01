Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDE184557
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508832; cv=none; b=LNNBNQ0V/9TulrDsYt+j5nTN2y1CmFcELoE1YOBgGs9f4h8k834/4iMdSIwUDUkUBsCOiNnHfcNmFkxlGczhrng8uPwYGSbbWfctwTSoC9MxUuPflrk2jA9FVAwuwAmc+lP6d/TM2Wx7k3c1+9qeHbVStj0ocuzHXjxUOh/qnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508832; c=relaxed/simple;
	bh=aD4gKYdSCRdZqHM4ldZE8WWVQqVM4nExvEMDOUej5ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7fymeIpVRNEZY2Vwv7BIKyNDPDSkzf9kQL9Anr4XAC0lsKxOUYAszIz8mTymBwVa16GOQjAr9UfDy+2uL9pX4aUAEYyIyowj+z8AMajQSe/R0spcM3uT6C4UJCn+q7Ra7HfGv7h/a42xDqP4Vjie4UCYEhO5i8yl9ekMthVpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XsJMrVra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pqRBbSxP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XsJMrVra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqRBbSxP"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8A7851388071;
	Thu,  1 Aug 2024 06:40:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 01 Aug 2024 06:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508830; x=1722595230; bh=eM2BI1+g22
	fBnNfLtyVDuJyfrz8KW8hHjJ72M3hISAY=; b=XsJMrVraPpXeT2z/Av4VBlx9R8
	Fp1oXeI7VmLWxtbNsnEeP9BfweIadEuajUpqaq14m772dVcTlcY5rPrVfgjFcQJe
	ymopG4Z4yu7d4ZM/j0+F3l7uTK75pZGJdAxgK5Zx6iXvGHQKY+BwcLlgVyToE+JD
	HxZWOYSCZcutCWVlQjb0Lkfg5TLf66415YFoh3BxxOxFmFvRRAiheIZEYsNa+ksQ
	gkdOHL9XAw7tfTT1sHkkEG3yRS3w/CcPOLXYgsyw+XdVY/tW/4iAjRFMFVD4gijq
	b9oCkW3ZGs8uGzgQyGdIz5EWgNjnytxvNk6V6am5yUTwyFriRJNoZHnZ4mDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508830; x=1722595230; bh=eM2BI1+g22fBnNfLtyVDuJyfrz8K
	W8hHjJ72M3hISAY=; b=pqRBbSxPgUNUTGQBXS+zI0TmGgvP/tIQJ/ErB1Z/ZUvR
	Aacs6KnUktQSNLJX7GnjnzrhtRxtrNABYVlkUUWyHPHG88tALNrHo8hRw5f8UJhr
	39Hk8PIpN95By23OfwfbOsvGpw0Z8OxU/F9nqd3y1lG16K7PZa5MjFSh283Iz9tR
	03pgvjvVWC57Fyed+jma0vakEzG4aShkSTy0HgFXtuVXWMQ9vHvfqXlmwKkp2Qm9
	U8ynhu76b7DkLZkbs5pHy6ZJ7Qhon188KJbzQnsO5gTk40uZwlF2juyseSBiwTkw
	0Tugwm+ovGOqB3NVSPZLPLLt4/t0muOPxMtyiuARzQ==
X-ME-Sender: <xms:HmarZtcObrHc2SBeJWBVwibzCe5XX7MFoKkhxysC9dr16STyHmTLcw>
    <xme:HmarZrOXW9VqpnGeL2X17igYvhuBYYFcFafEpvUofjuU4KXqacd-UVm5HbUf_6jSV
    U8iuQGIkNvYd5SXMQ>
X-ME-Received: <xmr:HmarZmjBriy7ivXskzyLjlyFrt6wCAP4ZZDatYsqZwRw_QhkB_zoFZGZHdG8Q40BExQCh29dJu5ZOXJJHyiyKyFRuqLe__FbdPzM99Ua5w4VKJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:HmarZm8178iYr6JZ6gj7fIoN23JTvNhI19ZBUwL1To4bsc6m8pCb3A>
    <xmx:HmarZps-czgHkgG76yJHTt451tvjZdhrUPeq9Pt-Tds300d2o-6PZQ>
    <xmx:HmarZlGGGzXKmB7AqeYgKp36aDSnAY2h9JPdYbbMTp18Jlwl5dwZfg>
    <xmx:HmarZgOIrtqRURckdCAdc8FiMIEcN1TGF5JbNLyoVCEYLlN_-iZWIw>
    <xmx:HmarZnXbEsMbVel_EonYSp3ARry4EV9Gh5Si3eQ39VFiEhvEqJf8QgjH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 36972b5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:38:57 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 14/24] builtin/show-branch: fix several memory leaks
Message-ID: <20a40e2fd49468f3c406a3124c06cd2b4a9f58eb.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xVcW+9rSCen5Str4"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--xVcW+9rSCen5Str4
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
2.46.0.dirty


--xVcW+9rSCen5Str4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZhkACgkQVbJhu7ck
PpQPzg//QIVTjV622s2JexRTCB5/bgTbF9CkwnATeUhbsSZbOlR7RW8eFyc2Fv0h
1CZWp9kIdhkiyLycHxUtIqez+3Cnps7VNQ610GDo/GG3SLu6vjN9lJ5sIWmTWm9I
ipk7aMFqZxGk6zwGw37yJmedRcdVwlgrlKH5lx7t0Y2Dgs6dDN9ac4OJf8sEroyP
StvbdoG6Q/OEzMuAB+CEUKQOPmwyFfdh6bgEGg3oHQkvIWTO8tFKvsnsWDF1ZDgb
t9yVQOf/l/UfTCFP9moevnkGP7iiQ+JQsTHpibLjtwHVVQnMjex8cRbojW0wXbky
G0UqqGxPNUO1u87cGsRsrObwGqmwM6+mS12dGSx3HHHkGvBd4lzuUeR8kFke9aCl
xQNB5INMMGqbvf0anhbkYvwoDzvGrd8YK7qf9Z+FwqGWCg0lcxRG9JYR9pLnbZAc
OZUAT39lz+XIZ/2FxZoBLNJcZjolmtV0X33Tok2m289++IV56LhKspTXeyMLntg/
n+QHKgiwS6c54vUztFqh6ycIDP07x/5tROIJXF8NleXXAJKlyuK4ZGnVGMRD3Qv0
LIjtE8BQsD7q9Q+DNFxav1Ua9cN22EarQYJsIDMMPiVN9ZtJzzffZwvlr+m3C0nB
GomN3636ipvw/gXrV5WGXEoejyUCOBrhx+MtiKeR2sSQXmIFoHg=
=pxOj
-----END PGP SIGNATURE-----

--xVcW+9rSCen5Str4--
