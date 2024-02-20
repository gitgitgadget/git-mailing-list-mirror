Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D060DFC
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419992; cv=none; b=GQIB3Ku8gnMN/lArRhCQv00ZEe5qfQuW2d6blKRaUWIO2ES2lO6fqmj7IsFX+XPKtozBeUI8k0OdipqBNWcOZtAdiPgX/hpZzcij8Xe6ZANxZv1ROT4FtPa8jaay0izeRtHyuD87mZ7/aNgmGZi6FDTPSCKkp7ICQ7Ovlupcw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419992; c=relaxed/simple;
	bh=0lz8zuIdYdbMvgFrZUpKjAyAvf7UpX1RXhWdmyhMRJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag8+jVC0GDF3OprDq1MOSgiD+B77v0k7vSVkps7rNFUc/ySVMuuBKlcgEiM+ICPY4s8ZtsnuOk6DK94Z+Fjc1N0q8TicoWvHLaMuqBvVNm/33x4ysSigPf3YMc04MDbUGoBKrPdkLEeWYx3Ee//UIV0dQLsTq9i9zDOzeeNOOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qtRv09ZN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlUino8F; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qtRv09ZN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlUino8F"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 5BC821C0009F;
	Tue, 20 Feb 2024 04:06:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 04:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708419988; x=1708506388; bh=iVX+VFP4f1
	836w9OxLIdTwhcqgaBkj7n8lAv+1z0ggw=; b=qtRv09ZNPgKeBlxCrnVdV+L76E
	eBoeC941sOLYhxS3rKZ+tDoQ5yDQMfRGG4TNySBs/v8SFbcklD5p0dG7zfKYpZ9w
	5mFIbQCPCmm7aYfGEJNyylJWBAPf8dPOk9KiPp9w382Ta3qBRY5EmRa77KVxOEFm
	2MWs/dEmmR8P5nmdAYU1fwsl1iwWkXgpx8qETqBkuBLgIR9IKSQytDL4U8iGn8Gn
	jbfMTOTW8mZHrjBCbxgPlhr9E1XrgOL8T12yO5I469923EUmVoO7tc5hNq8eIL2m
	uPko/wqY/kGetJt9q5Y4a4OQ/iQzBDUd3NDiUfRlZTNaOaowBk9KElA4tH7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708419988; x=1708506388; bh=iVX+VFP4f1836w9OxLIdTwhcqgaB
	kj7n8lAv+1z0ggw=; b=qlUino8FZZX5YbypxjwUmUBhpT7ftk8N1r7Ua8B2uRkE
	DJQSIEneqflfwSWf5i9tBifgjmSZ69+xeYMBIWZKq5EJonUU34Fn2qOZpqL4AxMP
	j7FtyBl1p6VGZsq56TfAKJxGQxRoDVApscM6tfUygGrxMJ1L532shTKgEGit6HdY
	tTKSKH3B3VGowHSmoP0ifhvP6i1tLHxqYw7yhbcIXvoUS9YuL16g9r2zKEFF8NPt
	umk92aOvc4VI2H+GSGbZFIFufBxe3kQN8rYJITro+5zUipDYd6SIkcIUJRCzNkM0
	e3CD8Tvlur66oDBwuNoiFKOz2Sk/7gEtVwPBCezNuA==
X-ME-Sender: <xms:lGvUZfyFl9Fhu6EOTUCqsuoONEP8hatqBzky5wDKZKaFoMhyKETkbg>
    <xme:lGvUZXSQKrRCJocV2zJuMIGOddlMvtgEGTsbI5n8YmA2zK9W6owYR67ahfksXelGK
    4X0_yYHK5zzgyg8LA>
X-ME-Received: <xmr:lGvUZZUROK7JLHTE6vnhQWKYvQZtHuVLcikgIJwURsk7JvDO1U5zYtAFeu6so-iUA8rF0O2_md0oVUQEIf4UVWeM19quu7U_n8HrbLfvsqgotg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lGvUZZjG6j3z6fsjBk7f6e2jlisdydbmqaltZKE68QXq4Jv6bT0pSQ>
    <xmx:lGvUZRDjxmuJiFVM9FDKXpxwlmquBLCFB8AXfYgJwvbk8P_tx0w1rg>
    <xmx:lGvUZSKqVUejalkd1GhKLGLxHH5AMAI4iK9JPbv1fEi3dBS7FrWm8g>
    <xmx:lGvUZUNCxekJ8e8Vc52P1VuOPeNuzr4j3yNklLTWJyR5wC90iLR9IX_FNhU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d57836f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:25 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] dir-iterator: support iteration in sorted order
Message-ID: <788afce189ce7ca7cb1ddc9706acb710ca73ee80.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eVP/SSWc8itj7C/r"
Content-Disposition: inline
In-Reply-To: <cover.1708418805.git.ps@pks.im>


--eVP/SSWc8itj7C/r
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
discernible order.

While this could be handled at a higher level by the new subcommand
itself by collecting and ordering the reflogs, this would be inefficient
because we would first have to collect all reflogs before we can sort
them, which would introduce additional latency when there are many
reflogs.

Instead, introduce a new option into the directory iterator that asks
for its entries to be yielded in lexicographical order. If set, the
iterator will read all directory entries greedily and sort them before
we start to iterate over them.

While this will of course also incur overhead as we cannot yield the
directory entries immediately, it should at least be more efficient than
having to sort the complete list of reflogs as we only need to sort one
directory at a time.

This functionality will be used in a follow-up commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir-iterator.c | 99 +++++++++++++++++++++++++++++++++++++++++++-------
 dir-iterator.h |  3 ++
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f58a97e089..de619846f2 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -2,10 +2,19 @@
 #include "dir.h"
 #include "iterator.h"
 #include "dir-iterator.h"
+#include "string-list.h"
=20
 struct dir_iterator_level {
 	DIR *dir;
=20
+	/*
+	 * The directory entries of the current level. This list will only be
+	 * populated when the iterator is ordered. In that case, `dir` will be
+	 * set to `NULL`.
+	 */
+	struct string_list entries;
+	size_t entries_idx;
+
 	/*
 	 * The length of the directory part of path at this level
 	 * (including a trailing '/'):
@@ -43,6 +52,31 @@ struct dir_iterator_int {
 	unsigned int flags;
 };
=20
+static int next_directory_entry(DIR *dir, const char *path,
+				struct dirent **out)
+{
+	struct dirent *de;
+
+repeat:
+	errno =3D 0;
+	de =3D readdir(dir);
+	if (!de) {
+		if (errno) {
+			warning_errno("error reading directory '%s'",
+				      path);
+			return -1;
+		}
+
+		return 1;
+	}
+
+	if (is_dot_or_dotdot(de->d_name))
+		goto repeat;
+
+	*out =3D de;
+	return 0;
+}
+
 /*
  * Push a level in the iter stack and initialize it with information from
  * the directory pointed by iter->base->path. It is assumed that this
@@ -72,6 +106,35 @@ static int push_level(struct dir_iterator_int *iter)
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
+		struct dirent *de;
+
+		while (1) {
+			int ret =3D next_directory_entry(level->dir, iter->base.path.buf, &de);
+			if (ret < 0) {
+				if (errno !=3D ENOENT &&
+				    iter->flags & DIR_ITERATOR_PEDANTIC)
+					return -1;
+				continue;
+			} else if (ret > 0) {
+				break;
+			}
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
@@ -88,6 +151,7 @@ static int pop_level(struct dir_iterator_int *iter)
 		warning_errno("error closing directory '%s'",
 			      iter->base.path.buf);
 	level->dir =3D NULL;
+	string_list_clear(&level->entries, 0);
=20
 	return --iter->levels_nr;
 }
@@ -139,27 +203,34 @@ int dir_iterator_advance(struct dir_iterator *dir_ite=
rator)
 		struct dirent *de;
 		struct dir_iterator_level *level =3D
 			&iter->levels[iter->levels_nr - 1];
+		const char *name;
=20
 		strbuf_setlen(&iter->base.path, level->prefix_len);
-		errno =3D 0;
-		de =3D readdir(level->dir);
=20
-		if (!de) {
-			if (errno) {
-				warning_errno("error reading directory '%s'",
-					      iter->base.path.buf);
+		if (level->dir) {
+			int ret =3D next_directory_entry(level->dir, iter->base.path.buf, &de);
+			if (ret < 0) {
 				if (iter->flags & DIR_ITERATOR_PEDANTIC)
 					goto error_out;
-			} else if (pop_level(iter) =3D=3D 0) {
-				return dir_iterator_abort(dir_iterator);
+				continue;
+			} else if (ret > 0) {
+				if (pop_level(iter) =3D=3D 0)
+					return dir_iterator_abort(dir_iterator);
+				continue;
 			}
-			continue;
-		}
=20
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
+			name =3D de->d_name;
+		} else {
+			if (level->entries_idx >=3D level->entries.nr) {
+				if (pop_level(iter) =3D=3D 0)
+					return dir_iterator_abort(dir_iterator);
+				continue;
+			}
=20
-		if (prepare_next_entry_data(iter, de->d_name)) {
+			name =3D level->entries.items[level->entries_idx++].string;
+		}
+
+		if (prepare_next_entry_data(iter, name)) {
 			if (errno !=3D ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
 				goto error_out;
 			continue;
@@ -188,6 +259,8 @@ int dir_iterator_abort(struct dir_iterator *dir_iterato=
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


--eVP/SSWc8itj7C/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa5EACgkQVbJhu7ck
PpQcWBAAhyMk9c5nWglMMYACkSd9ZURI9ts4cGAPjUhc1x3/OlXmg0hmfQuXvCl1
u6iP+2dtgj7IfYJQfjf/Rn3F6db25NYIrPHII4YEFafDve7Llzz4xUdkk6w6YF+7
4fhoZmBAkz9bdbldcC13wqm4t2IkPtS+mNl+cqidITNarc9B4h2axuseR1v8+mJ4
AkqAs54HHLH1JkmZm+FjSzziY/D14MR/0oxuREpnHjeXJxt+ZwASkVKlr+nQ58gh
vtcIGFYd8DrUMBXDF/PWehDlBUcVMIaZLO5VfMmiIYH/8aVLe0Xig3dsdZgPAy2t
Ksp13xXP6FbnkWj3kmPd6BHGU7+GWfTZA96iyAcP4/bU1yeTQocI/X1mblKLXzgK
MVwzr9Kx90ubfcTwhL9si0u19cbfx0nVGNS1XzW9JKQ47MLH0ijR5lCqxlFl1KJb
bIS6D2GLGhovWra2wSf5C4cbjv2ILovzJFpL+04TY9NA28OANLETB4inmhLi7mWt
SXQLLfBzR3Hk5zMurSAoRENjYidQ+KPZDoPqJdjsruGQFpKaMVoYEIlnCe5mC2Ef
Txvyk7Z77uhBZwphlkuEw38xqpmms4MTqKxVX74T2j9mhJonIal/3UEyWeQ664vw
QivVtarsm12jp164VtbB9QfJ+sQ+0OGvY3lFXJ8yNNYky1Fnx0o=
=FFOE
-----END PGP SIGNATURE-----

--eVP/SSWc8itj7C/r--
