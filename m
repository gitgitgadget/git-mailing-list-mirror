Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90F1EA80
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353327; cv=none; b=oSkdftkyAd7UfGkgtou4uGF2df7xy5j5wCDtH+Qq3IenTRQhUss3Z+1M04AnbykSlK/FGm4OfWnIk664D+rR7/kHEAJIB6KextZaZ6mtMcdzZkSZuHfTBiLAXjC3AtiQvIqnUVoavNeV/qzDH/TYEGHM/f67XN9RpqnFaLzxcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353327; c=relaxed/simple;
	bh=rMMml1XLAIkHRVTsQBRaJQzYpZ2u2SkV7iTWMvEv1h0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADI4+btg70xdlcHyIGgRrN36vPcn4WFpYL95wjQ+LK+neWmUZYsQ6AwN+AiL0vVzjawZQlvJRStpTx5wWtWV7PpoeviK44dWEyYDsr3jzdv+7YsTDLh5EJegO2QQ0fcM88AI3ED5nV1pMt9jHh+vldtCVb7SzHn6Ci36stQ1+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lpYcCTH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjPvybyU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lpYcCTH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjPvybyU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C70F4138010C
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Feb 2024 09:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708353324; x=1708439724; bh=XgulR84I2z
	WaRnpcRskBI9aMMkZZXW+CUF9vgct6fAQ=; b=lpYcCTH8FT7aDS4Aug6BjJQbM1
	VKHBMEFmKNAF7BWDAGkpWeYgZqrGodeU5oeglpZS1qtI0Nw4kqtkx2XD0aw6lF8B
	J9ISE5896fwMCzW4rswGq+MGbH3jWOBj/Y9Fgb1kT4VicBM7il6d/p9ElAkt/eAk
	6r4nXeJBEIukk9LBBFJP4d/mSwhlHc0Q9O8GrqZCnZLBhmPVa273tRjrCHPIL+aC
	VylCwBGPQvCnnRcygIYGexR0v00rHi1F7EIU0PU1BcBvEGAaR24/0ODThELzndwF
	PY78U6x7EtQvBaaTFAtxIiUAUjRBBTeMdfLUl+A1b2voz3eyPhLCq3UnCJZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708353324; x=1708439724; bh=XgulR84I2zWaRnpcRskBI9aMMkZZ
	XW+CUF9vgct6fAQ=; b=XjPvybyU0e/O6q0DzrNhEk+WmvZQk4XjZ2FONQPNxzJI
	mQwLWrPY1kKfWleKDW/2U5JnHDegzPHxy9WOz1ZUBOxG9gXtrpWIEUeqZlSKNG36
	PYHVD/iTabMzK/PZ5OYDcPD3DrbXrNJFM8ZIlWdk5lY0OwA7CmH7f2YA6tfK3qz3
	swBEoDG9n0nlwa4iN+1f+MQqwKmTVotACLjJ2MKsOdKFtvdFYGmO13Q7g0SMUVPI
	/DaZK+IgPsPRT7NGoKD84ORjOmzLtEZV3gXWKF4Gj7gcr0ncwfpZpqaN9S0nziC6
	jYG/DVYyYlMw8jt9M4JTdeMLuUepAfa4s09UAB1xwA==
X-ME-Sender: <xms:LGfTZax9_VXiWtz7Xdl8TFH82GelTYKbcpmrnyatR4oXtM22XUryNg>
    <xme:LGfTZWQmXaZArUZCtLdQS4wqV57vQGx0s483C9cy7KZGNlkROETKjsIX5LIXoNDD3
    stluN9VvTgC6sgDbQ>
X-ME-Received: <xmr:LGfTZcWIt5n5sd6ushA6-hWUL6Wpj97FN1qcU8JxFjqx1x1sa3ytsPEfEr6Bxv4NHlYjfR8nWMw81x4bL1M9CE4e8W5VLHv4_m3GBzGxzPuc1_Gu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LGfTZQimhYi5ZMJHaGCbQh-msz0F-pRBWXYNA7_5JyFAGUmlshpKLg>
    <xmx:LGfTZcCltm8W5jnZCgIwfqEYW5ln47zpeCgg9x0EpF803iElBKwIFA>
    <xmx:LGfTZRKvlXcHJQAIqHHsPL6vE3L2u1tyn9X69js1MLFYGLUR6-Cnuw>
    <xmx:LGfTZV5q2K3QPQ7guAVBGJmaaGM_tK-CTPZ7SUkpcoXjkbdAqvw56Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6b42fcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Feb 2024 14:31:24 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:35:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/6] dir-iterator: support iteration in sorted order
Message-ID: <8a588175dbf23d1938db45507812aad8f3793dbb.1708353264.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/u55EW0jjez5eq/E"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--/u55EW0jjez5eq/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct dir_iterator` is a helper that allows us to iterate through
directory entries. This iterator returns entries in the exact same order
as readdir(3P) does -- or in other words, it guarantees no specific
order at all.

This is about to become problematic as we are introducing a new reflog
subcommand to list reflogs. As the "files" backend uses the directory
iterator to enumerate reflogs, returning reflog names and exposing them
to the user would inherit the indeterministic ordering. Naturally, it
would make for a terrible user interface to show a list with no
discernible order. While this could be handled at a higher level by the
new subcommand itself by collecting and ordering the reflogs, this would
be inefficient and introduce latency when there are many reflogs.

Instead, introduce a new option into the directory iterator that asks
for its entries to be yielded in lexicographical order. If set, the
iterator will read all directory entries greedily end sort them before
we start to iterate over them.

While this will of course also incur overhead as we cannot yield the
directory entries immediately, it should at least be more efficient than
having to sort the complete list of reflogs as we only need to sort one
directory at a time.

This functionality will be used in a follow-up commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir-iterator.c | 87 ++++++++++++++++++++++++++++++++++++++++----------
 dir-iterator.h |  3 ++
 2 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f58a97e089..396c28178f 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -2,9 +2,12 @@
 #include "dir.h"
 #include "iterator.h"
 #include "dir-iterator.h"
+#include "string-list.h"
=20
 struct dir_iterator_level {
 	DIR *dir;
+	struct string_list entries;
+	size_t entries_idx;
=20
 	/*
 	 * The length of the directory part of path at this level
@@ -72,6 +75,40 @@ static int push_level(struct dir_iterator_int *iter)
 		return -1;
 	}
=20
+	string_list_init_dup(&level->entries);
+	level->entries_idx =3D 0;
+
+	/*
+	 * When the iterator is sorted we read and sort all directory entries
+	 * directly.
+	 */
+	if (iter->flags & DIR_ITERATOR_SORTED) {
+		while (1) {
+			struct dirent *de;
+
+			errno =3D 0;
+			de =3D readdir(level->dir);
+			if (!de) {
+				if (errno && errno !=3D ENOENT) {
+					warning_errno("error reading directory '%s'",
+						      iter->base.path.buf);
+					return -1;
+				}
+
+				break;
+			}
+
+			if (is_dot_or_dotdot(de->d_name))
+				continue;
+
+			string_list_append(&level->entries, de->d_name);
+		}
+		string_list_sort(&level->entries);
+
+		closedir(level->dir);
+		level->dir =3D NULL;
+	}
+
 	return 0;
 }
=20
@@ -88,6 +125,7 @@ static int pop_level(struct dir_iterator_int *iter)
 		warning_errno("error closing directory '%s'",
 			      iter->base.path.buf);
 	level->dir =3D NULL;
+	string_list_clear(&level->entries, 0);
=20
 	return --iter->levels_nr;
 }
@@ -136,30 +174,43 @@ int dir_iterator_advance(struct dir_iterator *dir_ite=
rator)
=20
 	/* Loop until we find an entry that we can give back to the caller. */
 	while (1) {
-		struct dirent *de;
 		struct dir_iterator_level *level =3D
 			&iter->levels[iter->levels_nr - 1];
+		struct dirent *de;
+		const char *name;
=20
 		strbuf_setlen(&iter->base.path, level->prefix_len);
-		errno =3D 0;
-		de =3D readdir(level->dir);
-
-		if (!de) {
-			if (errno) {
-				warning_errno("error reading directory '%s'",
-					      iter->base.path.buf);
-				if (iter->flags & DIR_ITERATOR_PEDANTIC)
-					goto error_out;
-			} else if (pop_level(iter) =3D=3D 0) {
-				return dir_iterator_abort(dir_iterator);
+
+		if (level->dir) {
+			errno =3D 0;
+			de =3D readdir(level->dir);
+			if (!de) {
+				if (errno) {
+					warning_errno("error reading directory '%s'",
+						      iter->base.path.buf);
+					if (iter->flags & DIR_ITERATOR_PEDANTIC)
+						goto error_out;
+				} else if (pop_level(iter) =3D=3D 0) {
+					return dir_iterator_abort(dir_iterator);
+				}
+				continue;
 			}
-			continue;
-		}
=20
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
+			if (is_dot_or_dotdot(de->d_name))
+				continue;
=20
-		if (prepare_next_entry_data(iter, de->d_name)) {
+			name =3D de->d_name;
+		} else {
+			if (level->entries_idx >=3D level->entries.nr) {
+				if (pop_level(iter) =3D=3D 0)
+					return dir_iterator_abort(dir_iterator);
+				continue;
+			}
+
+			name =3D level->entries.items[level->entries_idx++].string;
+		}
+
+		if (prepare_next_entry_data(iter, name)) {
 			if (errno !=3D ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
 				goto error_out;
 			continue;
@@ -188,6 +239,8 @@ int dir_iterator_abort(struct dir_iterator *dir_iterato=
r)
 			warning_errno("error closing directory '%s'",
 				      iter->base.path.buf);
 		}
+
+		string_list_clear(&level->entries, 0);
 	}
=20
 	free(iter->levels);
diff --git a/dir-iterator.h b/dir-iterator.h
index 479e1ec784..6d438809b6 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -54,8 +54,11 @@
  *   and ITER_ERROR is returned immediately. In both cases, a meaningful
  *   warning is emitted. Note: ENOENT errors are always ignored so that
  *   the API users may remove files during iteration.
+ *
+ * - DIR_ITERATOR_SORTED: sort directory entries alphabetically.
  */
 #define DIR_ITERATOR_PEDANTIC (1 << 0)
+#define DIR_ITERATOR_SORTED   (1 << 1)
=20
 struct dir_iterator {
 	/* The current path: */
--=20
2.44.0-rc1


--/u55EW0jjez5eq/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXTZykACgkQVbJhu7ck
PpRuXQ/+OXegWB5NOUc2XR95hZRZVjiIZqdpSrUXgHvYYvYYOWC+OZXodh6ZVG41
ymCTztWU8Vc5Y5oVXD8okD04v9tWecFrElFseQrQhVfnrWiQ5PwY1isnP0DiA3xc
Xu5APue+uIA+7PisNVXebQbg6tVdPemUdgppGa7ceo/D24s5QjzDh51IlBuo9EQ9
u1vJEZowmKKIoKAd6d0qPitwA/QNzU6+8jUV8k5vg/NHQ26D61orCeojIgHjRTlV
4lJhq4u3GJ8aJb/NSmLLLm7p7M70591mnMqa/zIKrNbBZkA6NmF6M1sDo++u0XIH
gr8V8VweY9lD+Yb4xXnwVW71K/r25NJUqlH2LV5vzMnHhwVqRBMpLd67X+jFhAzD
InV85c3zZCcaBOeqHbt9f4I0GJ5M8fPR72pBY/XhUxh8sH54l+YLp+2TBYMUetH2
gBpp+rH0wqjzVxW/C5sAN4HtnkkbhouEY2qz0qPZNUtBiRfqcQMej2WytfENpxqh
GF/X0azBLRILTEk8gz/WIF7kvNp8IDhNRmVf02o4CA/FCAVeNQZ5/R77y9IByF2c
aqtK5QIGzBptZxTqsPfwCJZVhAkPjPBczpBcl9N2b/DCVa/SOOeV6mg8lEIN81kT
UzNaHHFaQyg7N4enAx5OZ0nDbfF+gFndhs6XpI82WDN77KDjbHk=
=/9C5
-----END PGP SIGNATURE-----

--/u55EW0jjez5eq/E--
