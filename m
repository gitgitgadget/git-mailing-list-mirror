Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2361FDE
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877919; cv=none; b=S5uFjUcNSUvt3c4qVWNUsPIniJciTLnJP8lCZUAaiS6mWb8c5Yk6nB6rMkKlG2q0tv4Z6BhQyW1NpAjFl2Bkl/Qy0tAtV4VZoI0U3Ai63KgFokdx/oaq7BmIcsHWBdvD+VuT0DVFFOCkq6aKPLY+Q0YKa6zT4eMZhaPKzlQXW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877919; c=relaxed/simple;
	bh=KYxgWFQd2yEOFbxkf5/aGx4ojecxXw9HDziYxW2OeSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFo6lZQAG8z46VuuO1Tmy/2pLTDravm2fSJwmUsr9IDD0xaqyqa5G6x0xhzIk9Rd3vxKw7tIV4pZpiCjPbMpjtcMkNGxs0DSbfyDE3CWk0TowguFCB+nNkl5V/XWyTjRAr3jdg3mYP6NBhHXdXml4APgYQA8wmjEFGqFEwTP7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BdTmKemX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1A5+rG3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BdTmKemX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1A5+rG3"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 83F241380085;
	Tue, 28 May 2024 02:31:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 May 2024 02:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877917; x=1716964317; bh=jAhxTsekDL
	tmz80IOvYM50ZSR7YylkE5W7o9nE97oqk=; b=BdTmKemXY120oQ6IYtPd9vSj+o
	o25KBIzcltOqRbvJ3i5Ag7nwVMA8OXkX34hpqCa65JlWEvhtl9Sb4EpMu898Boz9
	MHuHHtxZjpxzyRZ+D4EfVXVjMv4AT+7Bh9zsk6elr5rXbjFwu9LRxy9SPLqpGq/V
	NBdiOGWWT8e9oHo+4znCK3KYVqb4EghOn8GbLzpp3r4P5LviTTydOpjSe1tG65Ns
	OpUmvJrQ+3dhmmAtCFi2lBajAdSmSqph82t6JD8kfXsj7KsIvOvOzzdSXBBW9Ctv
	wUMA5t5dPPH29HK4DMPCGSjw4H2BcbkfTiZ7gdEUkgJ87JRKfgOadikJwtPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877917; x=1716964317; bh=jAhxTsekDLtmz80IOvYM50ZSR7Yy
	lkE5W7o9nE97oqk=; b=R1A5+rG3eF6WuZI/cwDKLOlw0L/Q4Zvo48Vw0l8/lKTX
	XxitV1EwdlbAG8oJ73rnyLZK4eZex3rYju9xoPTfuUIFE9aHYluvP35jSnexbaZh
	aiD9xen30WBmb6KgTIAFRrDDjmSZfA4IZg+e22R4+MISz9gxW2meo5eNjFj9A0u4
	Ujwnyfs45WHShxZly/iD66FwNNuZVcWIGADPM4tSUkTAfqKXlqdQBFAMV11FaZ0L
	Cis57fZceevlnLoS4Js91gizHCdoB41zzzYoM8faZuWDK5qX+rKx3qD6FOZAfM2R
	cGeAgRbY+rH1197bjovd/iSaRCJUHvuVY1ESKl+wMw==
X-ME-Sender: <xms:XXpVZiqeI3_dlMkCSA-uGUczCV6_xUvK63_wu7213dZw1wE6GVyLFA>
    <xme:XXpVZgow8qQToT50yF7-kaQkKQ0Z8ULw9NyoaBTNebORtJfpUBULGtt2n3a3HvDF_
    qkMyZrB3f4Jsu9VYQ>
X-ME-Received: <xmr:XXpVZnPI374iefkMnoVRugYwyADNBMtZbDzgS-LEheqJjbnbnZmTkH0OZpuZfnfOrYTx6OIyQmyE_D_Jl8qjlNrjsx6PhFpa0c48U8FH-zojwbuf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XXpVZh4XRxxFuKwTrZQqvxt4jgc73tDtowTAyuv0Jh3DJpv666qiHA>
    <xmx:XXpVZh6Q9Xjjq0kYLNRc-0mrRBazS32_UIANKA8ZT9We79dNpu-ezQ>
    <xmx:XXpVZhjtl4CfrrqcwsfMyNv3l3k6dewd9ebdrypbJOzk2qTWgn7WbA>
    <xmx:XXpVZr4UcRTB2eUY4hQn3qk67kgGKLR6h2BWuzVjJmZz0R0Ocij5bw>
    <xmx:XXpVZvQ9i8QBFUlTaDwYC347_YcwMPSXKOMiMtmNvRH44b7M23GJ1cM8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4afbcb45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:43 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 09/12] worktree: don't store main worktree twice
Message-ID: <7a89aae51526faefc0ccce0a73cbd54aec8e8879.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RcbjBso/h5E+38+u"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--RcbjBso/h5E+38+u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_worktree_ref_store()` we either return the repository's main ref
store, or we look up the ref store via the map of worktree ref stores.
Which of these worktrees gets picked depends on the `is_current` bit of
the worktree, which indicates whether the worktree is the one that
corresponds to `the_repository`.

The bit is getting set in `get_worktrees()`, but only after we have
computed the list of all worktrees. This is too late though, because at
that time we have already called `get_worktree_ref_store()` on each of
the worktrees via `add_head_info()`. The consequence is that the current
worktree will not have been marked accordingly, which means that we did
not use the main ref store, but instead created a new ref store. We thus
have two separate ref stores now that map to the same ref database.

Fix this by setting `is_current` before we call `add_head_info()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/worktree.c b/worktree.c
index 12eadacc61..70844d023a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -53,6 +53,15 @@ static void add_head_info(struct worktree *wt)
 		wt->is_detached =3D 1;
 }
=20
+static int is_current_worktree(struct worktree *wt)
+{
+	char *git_dir =3D absolute_pathdup(get_git_dir());
+	const char *wt_git_dir =3D get_worktree_git_dir(wt);
+	int is_current =3D !fspathcmp(git_dir, absolute_path(wt_git_dir));
+	free(git_dir);
+	return is_current;
+}
+
 /**
  * get the main worktree
  */
@@ -76,6 +85,7 @@ static struct worktree *get_main_worktree(int skip_readin=
g_head)
 	 */
 	worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
 		is_bare_repository();
+	worktree->is_current =3D is_current_worktree(worktree);
 	if (!skip_reading_head)
 		add_head_info(worktree);
 	return worktree;
@@ -102,6 +112,7 @@ struct worktree *get_linked_worktree(const char *id,
 	worktree->repo =3D the_repository;
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
 	worktree->id =3D xstrdup(id);
+	worktree->is_current =3D is_current_worktree(worktree);
 	if (!skip_reading_head)
 		add_head_info(worktree);
=20
@@ -111,23 +122,6 @@ struct worktree *get_linked_worktree(const char *id,
 	return worktree;
 }
=20
-static void mark_current_worktree(struct worktree **worktrees)
-{
-	char *git_dir =3D absolute_pathdup(get_git_dir());
-	int i;
-
-	for (i =3D 0; worktrees[i]; i++) {
-		struct worktree *wt =3D worktrees[i];
-		const char *wt_git_dir =3D get_worktree_git_dir(wt);
-
-		if (!fspathcmp(git_dir, absolute_path(wt_git_dir))) {
-			wt->is_current =3D 1;
-			break;
-		}
-	}
-	free(git_dir);
-}
-
 /*
  * NEEDSWORK: This function exists so that we can look up metadata of a
  * worktree without trying to access any of its internals like the refdb. =
It
@@ -164,7 +158,6 @@ static struct worktree **get_worktrees_internal(int ski=
p_reading_head)
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] =3D NULL;
=20
-	mark_current_worktree(list);
 	return list;
 }
=20
--=20
2.45.1.246.gb9cfe4845c.dirty


--RcbjBso/h5E+38+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVelgACgkQVbJhu7ck
PpTv4g//ZZ4y0pYvbNuBEcWWNp1i4PGVsDvbIaxsAtSyovslWpuYrFu8HDviOF+n
bNK0NgtZ1krRugvS945UvX1IwEL/NznQQH5kG4FHHsryr5Q/SgXXs7DXfarIkQAH
NWnCMDxZRjxkUURw69aB3c4br7NWCAdL50U0GzlopZB64WroG4mABcwLuZbrEtIR
K2QPkyQTnLGJze1W0zdCMmc/DbWCKvPHJphEB+44AjNlQy3ze1pGKK8icbQZNwTA
HfV6QbMNa83D+HucbUfONlBUIyWSYjyXJnN2Mzzr0uLqSR0YQLH4gVbCZQ4P/Byi
iyaVURyQHj6ISl5WjpYftP50Ekrxg40f72RvHrY3h6wAh6cYOr9VIxSKNvOPyu4d
RWabaPGajaVOsNylfU9QCphsDL95zymC6EOQes1C8uk5MFiakE7nsMH/Ll2XFchX
Icmp3XnSxuRDjHmbJFc4GcYDDi5fOGgMmfACNiwwMw8CZOPjWIiQAXJxoqZUsfFJ
Hd9iXzytIjxhLGGluKIwV+VdfowWyj/duWNYAYgV/fZH2ebxUkwmX7QvYBGMhlGZ
KCnGI081F5NatMLR7mMTdwNmxXP68aOj/XfdcGbuTqRir5jZvhNjfs7i3hUh84qh
BECfRRWneiN9ARMA8e6kFR0TbYrNYWktuUausbMAmLYVX1R3lG8=
=3TZj
-----END PGP SIGNATURE-----

--RcbjBso/h5E+38+u--
