Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB56994C
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519049; cv=none; b=QtJO11TeufnPF/pVGz0VJ/KNsu8SK0F70l0opl14+GvCHa58/hBVCRmAiDsQh/zBH85h9vGd6DFkzaRofQfvqDHy9gLriuX5iSeXDAaRL6coB9KjEg8DS50522ZmNJYNf2OTwxg85B7QQFaJalv05jeIfXyiNS5B3NRZtBH3n64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519049; c=relaxed/simple;
	bh=gWKzqG05lKejl4ibtqOOwmXK32AtkthY/xq4y1MFeLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0EUocO+2voRzT9K70yVKWp0SwhCpwnc1c0GFjV/Pu0wk1oCeXiZYsuw0r8Lvs6CQraBSw3+X6RPVpHZ5F+BoLp+5e1/OWoofTuLzeS/x/gvqADUjGtpslF9XkZt5WcpOQCcjo6qJfektDO8o2lpm9qHDPkCpapUos0LEjeVrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BnfhsLue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LufobafL; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BnfhsLue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LufobafL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 582FE3200319;
	Wed, 21 Feb 2024 07:37:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 07:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519045; x=1708605445; bh=EoDoepf75w
	IJoGdJyhNG1WmDTNjI9Hszak0dqRZq91E=; b=BnfhsLueuTOD8PU2AHt+Dq3iff
	E2oC6f59mCWq0iJcKe6zDAgfYZPUTgul3trjHuVSAFvwE11rME+Drm6nKToBMzGd
	zQWFh5nARbQX2xcu9ABPe5uCT/FzEb271aQdOSKktJPSF6m1yMcYbnGMSU137ZO6
	WbbChfMiSs3AolGR8tzKpBywWql34ZmxIZnL265enIeb5uFgXueEFyyQ4VBP9QjT
	yPedZ/WL0qc4SN84ijzKLa2hGRL36DvaoaBQlUIqfVwci0yWQoNazDx1dfXtyOPl
	A9E1fvuuEQQ0bc1qq+5AESL9Ns4WpXVRn5QvqL1ZKgKGlSrfizzx0s86TLcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519045; x=1708605445; bh=EoDoepf75wIJoGdJyhNG1WmDTNjI
	9Hszak0dqRZq91E=; b=LufobafLJpKSUKOo98Wfp6rMG60pEWplGLYobmU8CPgV
	wYo6c3qiZvmUMA0J9wfr61O7brFgraadY9LihW5U0EkNxqXQJu8fewm3FJZmldof
	2u+JikppvGiF80wAy1lpd7l+MJTW/Gk9h4xpEq9/8wDcgZJsX80/+B2emb1O/d08
	dv2zKM6c8uc6NSNlg1EvjrA6iIpYZSbiWEfC5nvsXOImZ2DRI9oVRJnQeghABiYt
	+v1GeNPDULIs/7I60QwWFX5uEHv7gZv1ay2ZqMzRPQTtiVIlqR4Uqmmhry1tlOzP
	eaRVbzrGa05ThKWQ75SP5XJnczJ0zav1pL4sM3QmdQ==
X-ME-Sender: <xms:he7VZZGmimcmk9jbxCQ1BNm0sUXOnGtxXRugVX-U4k8ti3jX3dH_nQ>
    <xme:he7VZeVNUTv2KOPDzPBD3yxeC-fjq-r4DLlDT90fZGCoRDuyr-Kky9lpjsDfP2fEA
    4kk0LsnI2RItG2MDA>
X-ME-Received: <xmr:he7VZbJAFqp_tlUJFbrf9Z3qD-fRof2WeHoxHbvdCI8Xnpao0ERdOBR7gmPDeuzmmi2baBzfpJXeeB1OxNSB290Rau2b453wM3MZmLyTfiLK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:he7VZfHjlK5tdab2uiCx_RCg7o6GAo4iXROaGqPcjPdQJlP6DDZfvg>
    <xmx:he7VZfVXn3ZdVJ5vGX1O-yWMpn84qHkXslViaLTqNS-htSWwFbMePw>
    <xmx:he7VZaMtobfVhvIxP34T6A0b42lD35ZGpTqOiZosPs5jdbAkXcGziA>
    <xmx:he7VZWcc8LaYpto05bQ73ptkOM5WaBFjPJ-06ZLoDzAnmDVeQkLAkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cd881e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:20 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/8] dir-iterator: support iteration in sorted order
Message-ID: <89cf960d47026cc1a1527e35b1c069c6598ac3e0.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ZPuzfg6/Q6kUbw8"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--3ZPuzfg6/Q6kUbw8
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


--3ZPuzfg6/Q6kUbw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7oIACgkQVbJhu7ck
PpQ6tQ/8CQEkyqQ7bl4BNw2Y7w0Johb9t/d/WDCyYN7I5oMbFL7ggs4q7wZA0/Fy
weGhiUqaFF60b2PF7D06PdoVGxprmJc6jngAs7WQWiyG9fbBqOytyvTLMiXJ6Y+g
ggCNTiWcTvWqFUfvZ6HM4nxuM92sTZAoaHndt617pdWasHXMevCOU8BF67sz73YR
xlC9tKYGE6X34JbcvtCz6lZ/tpEQq2o+bRZYZppcJZQwKcdh54rJNMXy9sFD9r6Q
sogyBJZJv/BBrddW2bC4bU1wQnA67e2MS2jPcomcneHN7uS4R7egsf04m3UhTtY+
53PREw3PORCWD48tCp8BhFsImMeEpVM5mNr8+f/Ea2d2xo1J4TIvTVwBaEQZIhpI
tjR4GiD09v2Pvq4Stt9rapzen/+pMCqSR+K4KeCd/gDVmAGJS3QwKZMVz0EzmX9+
L/CsPdtvjlEhVGdwUzrkPJhRJEz7zSKz6GhiVJgnxt63Qt26KAWDKJ82UiKhd++f
eErsTwAxAaROjTZBq2QYx4T3cIpsiCuSQoMlx4WRuyoGHmoTS/GZLRrYRYpRKmTR
EQQUkgfTc58jU/GldfI/e+06T52B1LOoxH77AjU/7++WpDqQsti8eLYdbvqb+a6c
oc/+mUjiSIHrsOWsGFeTslvEosDHcVqOcEXcSy0zwWWRlji8sZ8=
=evYk
-----END PGP SIGNATURE-----

--3ZPuzfg6/Q6kUbw8--
