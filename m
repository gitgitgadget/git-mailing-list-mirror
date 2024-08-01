Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F86183CC0
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508867; cv=none; b=Nn+lk4TKj8g3Z/ISVHD06EolcyfsTRquZ04gAlyjsYLp90bUHHmPoMlnS6xN5STYQwmXf995ZIQh/igg50wo7iz0omakQnrvMfXPZ8RQLdv/+t5kyZq+G98Y/+EeJT6dkesVXGgey0RZmqMopZbAXwZLQ1NmK2dtTrbaHDJb2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508867; c=relaxed/simple;
	bh=fI3pKMg5rmabeFEID0rRloWFpj4N+OpKHnQVKVYX7kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGMZRJpx3Yd70DYOPI/vGHHEwy8xc36hKVoagQC/tWtik0JslQIFu6AGm1+fs+Ei+rWWJmjvRMKsxB/HzBlQ3HF3IVfAzLGMekRHuiPv3I8HgxkmQJajzsfmxqxasZaAaxxA0HyrKhx1Pz3YnZyW3olKHt/RiE0o2UoUbEH8o2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K3Q8gf+J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oOUl4y5o; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K3Q8gf+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oOUl4y5o"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3FE8F1388078;
	Thu,  1 Aug 2024 06:41:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 06:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508865; x=1722595265; bh=QdfFBOUwLJ
	5J8xW8G7NrjwOqRyJx3J33+8PiHt+vRD8=; b=K3Q8gf+JIhJSICxwmpgc9Mcqid
	vSqRzAduqF+RxA+kDsRwRBHeqHbnTM59w+CDlI4IbVaxPPfahMToZ/qRYgG/y9U3
	amZuAmZa63nSsExw/iDwbRsM6pgQU+rQZwMVDOu+u2ijhVHxKpJJnoA8aoy63Jrz
	UfM0w/NlHtSLymEKcX1NsnDvkcrKlMAmvb9aYeQeOih8FxFTXi6zRfn+gpHmvEby
	JYxBFriIxOmS42TNx1QWlleiwJGLFaRainCsU/XH/k5AIOAfTIXNDp1PONCefXYu
	JHkeTnlhcQxlYQW92B9T5LaRaNN2q9NiO5UUBjvV0zUUuLBBEHoJYOxRVlpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508865; x=1722595265; bh=QdfFBOUwLJ5J8xW8G7NrjwOqRyJx
	3J33+8PiHt+vRD8=; b=oOUl4y5otZE0Pqo5/nVCCLAMM6q7FouJHkTsTcxw5fh9
	blvS47hBAbFg+rjO0oHvzu6qDgFlpyY5Bf0ClggBFZNXCp31LvzhMW+sekDWNnJ0
	G38VHENLlgDien0tSdDRhFqF7XdoNygJiUbUlwe1Tfqf7dmG2HY80ejUnx6A7oVG
	tcY+XMExsZt4APsJjXc8UhnYwbz56S7soH/rJUxD/LzneuhDH0XdQsMQovoiFtuY
	BvBfCftPmCHkL0RUgpU7fsQXYp/V6GYkawexHAL1Oeoeqw0xdCJICp64r/bAbsPh
	NmeQipoaPFalUsD9azoe6D2rpaJpdP/oLVfoAaoSKw==
X-ME-Sender: <xms:QWarZjJSm7lH9Q2OFgbLCztj6eTIILint0AnriSrJydBr88RxtLxxw>
    <xme:QWarZnIHCf1m84I12LOUpRKH8fZU7rHZq4YiyqUX_Dc6cgVvfP8M_IaqmoFDyN9wL
    DB9ve0yvITBSSe1_w>
X-ME-Received: <xmr:QWarZrvvAIquGL8DIZTmbXq7hfhcIkFu5TwxUk0WIUPafd4rg8mBUhU6hixjTFDVVHtnytShEIaBcXHTuPsHIETRcrlRVG4Ymesms81cQ3P47NY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:QWarZsaADwkj2anUJpKKuXjTOOXCjpnSNwYXZCCPeMtZsmPhDo6ynw>
    <xmx:QWarZqZ8F3A_jExJmNcgMRkXAhirKdams921fNU9yQVwT7yQGxiZQQ>
    <xmx:QWarZgDT6zEDVQTHC3mDUJuXKwwiwB7LwXLl3L8JOg5tpwjvN5C60A>
    <xmx:QWarZoZomBcLi7GLDOpbIuC0K3weoHn38rg9TLeXj2jBbd5GWWD7hg>
    <xmx:QWarZhz3f8kvfU8-NBd7NaP8KXQv3VvVNRKpQuzhUDvITxXP6FA-Ds65>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:41:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d77d6cff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:32 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:41:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 21/24] object-name: fix leaking commit list items
Message-ID: <fa95a67ccd968aa87e24f34b77b30861ff346777.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XjfPz3xhFSJeQ8VV"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--XjfPz3xhFSJeQ8VV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `get_oid_oneline()`, we pass in a `struct commit_list` that
gets modified by the function. This creates a weird situation where the
commit list may sometimes be empty after returning, but sometimes it
will continue to carry additional commits. In those cases the remainder
of the list leaks.

Ultimately, the design where we only pass partial ownership to
`get_oid_oneline()` feels shoddy. Refactor the code such that we only
pass a constant pointer to the list, creating a local copy as needed.
Callers are thus always responsible for freeing the commit list, which
then allows us to plug a bunch of memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c                | 26 ++++++++++++++++----------
 t/t1511-rev-parse-caret.sh   |  1 +
 t/t6133-pathspec-rev-dwim.sh |  2 ++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/object-name.c b/object-name.c
index 527b853ac4..240a93e7ce 100644
--- a/object-name.c
+++ b/object-name.c
@@ -27,7 +27,8 @@
 #include "date.h"
 #include "object-file-convert.h"
=20
-static int get_oid_oneline(struct repository *r, const char *, struct obje=
ct_id *, struct commit_list *);
+static int get_oid_oneline(struct repository *r, const char *, struct obje=
ct_id *,
+			   const struct commit_list *);
=20
 typedef int (*disambiguate_hint_fn)(struct repository *, const struct obje=
ct_id *, void *);
=20
@@ -1254,6 +1255,8 @@ static int peel_onion(struct repository *r, const cha=
r *name, int len,
 		prefix =3D xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
 		ret =3D get_oid_oneline(r, prefix, oid, list);
+
+		free_commit_list(list);
 		free(prefix);
 		return ret;
 	}
@@ -1388,9 +1391,10 @@ static int handle_one_ref(const char *path, const st=
ruct object_id *oid,
=20
 static int get_oid_oneline(struct repository *r,
 			   const char *prefix, struct object_id *oid,
-			   struct commit_list *list)
+			   const struct commit_list *list)
 {
-	struct commit_list *backup =3D NULL, *l;
+	struct commit_list *copy =3D NULL;
+	const struct commit_list *l;
 	int found =3D 0;
 	int negative =3D 0;
 	regex_t regex;
@@ -1411,14 +1415,14 @@ static int get_oid_oneline(struct repository *r,
=20
 	for (l =3D list; l; l =3D l->next) {
 		l->item->object.flags |=3D ONELINE_SEEN;
-		commit_list_insert(l->item, &backup);
+		commit_list_insert(l->item, &copy);
 	}
-	while (list) {
+	while (copy) {
 		const char *p, *buf;
 		struct commit *commit;
 		int matches;
=20
-		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
+		commit =3D pop_most_recent_commit(&copy, ONELINE_SEEN);
 		if (!parse_object(r, &commit->object.oid))
 			continue;
 		buf =3D repo_get_commit_buffer(r, commit, NULL);
@@ -1433,10 +1437,9 @@ static int get_oid_oneline(struct repository *r,
 		}
 	}
 	regfree(&regex);
-	free_commit_list(list);
-	for (l =3D backup; l; l =3D l->next)
+	for (l =3D list; l; l =3D l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
-	free_commit_list(backup);
+	free_commit_list(copy);
 	return found ? 0 : -1;
 }
=20
@@ -2024,7 +2027,10 @@ static enum get_oid_result get_oid_with_context_1(st=
ruct repository *repo,
 			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
-			return get_oid_oneline(repo, name + 2, oid, list);
+			ret =3D get_oid_oneline(repo, name + 2, oid, list);
+
+			free_commit_list(list);
+			return ret;
 		}
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index 6ecfed86bc..e7e78a4028 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -5,6 +5,7 @@ test_description=3D'tests for ref^{stuff}'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
index a290ffca0d..6dd4bbbf9f 100755
--- a/t/t6133-pathspec-rev-dwim.sh
+++ b/t/t6133-pathspec-rev-dwim.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test dwim of revs versus pathspecs in revision parser'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.dirty


--XjfPz3xhFSJeQ8VV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZjwACgkQVbJhu7ck
PpR0gQ//TrhCPZZmfZirDcc7Cy4Tj0JYReVOKoJSqhrGydj49cxvxRptJtPoRusi
j5DR07GYchd/qOj/d0543RcTmz+oWGdqdb529mfV+WBpUNyrTCvHPrF4yO2HiWsf
UO1fYejQ6CjjKnw6BIIv7mx7ROBnkboE/kL8P1XX4kh5d847Sg2j25/qyHRXRPcr
x6gSKJkmzWcnY64U+R5mX/+WcCdilOv9ofTVtI6KwHMn7WZJNF5Kn3gQf7iy7GX8
vXgdw3MTwgg8a8KGFE2jsVQPQId3HoerfBq/4rkOum8DSIftSR4X6gNMHUl7cmi3
uiH8P0IVYVmB2u57KsL/eIZ9Nj9cRLOzqgpQsCOTng9R5e4deIMvpQRB09I2zkgt
imL349AXm7Lw3kX28EPnNgucbK2lYiJvRn3s7MHWXwwgNjvFOUxtub6JI2FVmXG0
FYzHgsWTVh0QsCxPmb7afOT64+1wvkvvROj30tTlLdCgIQFI4oeIBKPxLVBCS9qT
GfamUIXmnsF0cImmRu7niVOkrqV6S+JPouJrA08QfVlJIsDs4tEWWDzYLKlKhduG
QIyLDIOCamax+oVwX+XQ/knLbHtbZjqBS0kggUxGKHtp4oIjsPqRZwYSvPiOFMLF
CMOmgH7OKuiZqpuXVH8TtQ/5DzuwugTib/CAF+Z/WzK4gagt2Ds=
=LL6O
-----END PGP SIGNATURE-----

--XjfPz3xhFSJeQ8VV--
