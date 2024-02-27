Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE4145327
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044071; cv=none; b=rt48ZIbfW+nNSyudqPveXtEDc+W4Dbpjaal19NF7rDlLpjvJz1kBYV2twm5p6EVyjqkJH07g/QaxSGyJTNpgiiMg1L+QlnlZM3r21NO356FTJP5Mz8R8HR+aKRaixRwmLdbHxFntbkwPPV/Lr8JsJFYLS56pjqavj6xQX5/ykpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044071; c=relaxed/simple;
	bh=5rvXtEHGCklyvCdgR3DjD5hyQzPset1mI/cXHzWJXpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH5CV5G7ZMmKys0rGvmoi2hnZX+B1475A1VZC3XxOGNcUI3DRuzAYHyqtZToivHaJswaXIiaTjj1WgiCaDbGGI7YFqpBC1Ndzkps1l6KkhwxQK/yIC1VpzfHQ6WSNE3wWyBqathmkDbJrZO8RA34z2H/M4aozlq6Jb+vgqsWqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lViuX+AZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZaqDAACy; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lViuX+AZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZaqDAACy"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 32F553200AC1;
	Tue, 27 Feb 2024 09:27:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 09:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709044067; x=1709130467; bh=fvw3cBHNRF
	l+q8Q/RiybuWLbYZJX/I75Cqh5Xv2FM6k=; b=lViuX+AZcC2iivJ8YAIEk7/MRk
	yoKJiaxsjaI7A/TwnLeKKg2VTSRJgpy72gT2SzF98dkbDdq6aWRfvx9w0oSdny/F
	JgNP14hiJH+HvKCzPseCq/tRso7H02O2/nK88/WlLYGTmAzjIcldY7rGd1Mxg6o/
	jizsNQMQjjBvp4JWkFEIBrZwbluBzt+aP9QYy3W1pUHDhHE5wAUFjL6bOR61phay
	fYUMptGaMrGghv+eXWyxm1Y0GD01wXT3WSgeh9GoSre1YCn/i7M9k80yF1hf+OzP
	iLB71JZlGMvclpCusm4yCm04kpPQn3j/InsDBxD6umgoC2J75tVE5Tp2y+BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709044067; x=1709130467; bh=fvw3cBHNRFl+q8Q/RiybuWLbYZJX
	/I75Cqh5Xv2FM6k=; b=ZaqDAACyFOTSMojAKZlsgGytRKS+fJFvbYaGyOZDLnPi
	fS3W4qpP0DQk8OOqzYslCBa3b0x0EsdoyvuIE6dTnRz0Mm8/+OIfp/koP/DOLfK9
	ytiA6Wnca4UiDU8YyPYei7PRVdMUB5+x9wapre+igQ6y7xQP99RwxbcCwdFr3gMo
	KIJyjQCOtBKBzsWY3djBV2OuucFRQmIx7pg5UHyAh3bVOJYTzW9cvhLRSuwg8lL6
	jBdUFGPl1hxK3vBxhkLsAkjkA3jwTfRfyzBjPBEjtnB/WSXAcMiLrHgDAjrCoPEH
	uUBj43fcGWzJC+nRKb/N2h7En6jidZXur//M1bq+uA==
X-ME-Sender: <xms:Y_HdZfsYBSeae1s2XuEiVRC4M3u4Bl-wNBvqmQbMuZbu32gS8w8Fkw>
    <xme:Y_HdZQdB9yqES0lCgFg8ni3hYCGXxjKuQgiOTsnf8OOVDCiQFn61RBTQDXbOK5ifw
    nEOlNDcFE0NGA9eIg>
X-ME-Received: <xmr:Y_HdZSxSh2tGYtf1dm_QF4lXWqf_n9S4sx_2PLftRyxkzjLJ1Le7m3EV27Up2FYTR7rq7YapZ7W-qrKdoncp6gWzJDg2XcZ4NsUOb2SqL_MIa4HO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Y_HdZePw5Ikpb65XWw9_Hl58bt0iNt83LnpYtMW6kXMz8N1DKScjdw>
    <xmx:Y_HdZf9Gbo7e8NYtlZ4y6oycub0tbqW2-UcPe8oZon6pwfXv0pATrQ>
    <xmx:Y_HdZeXwt87BWLRaJ4lYfvg659lkNOLUdOT0vNoubcdRsqdTZON_JA>
    <xmx:Y_HdZRKV9TpObbDvKvBbOwEugA7XX3xygcTt5hL2DjtVu3-f0LUn5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 09:27:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26b4a109 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 14:23:29 +0000 (UTC)
Date: Tue, 27 Feb 2024 15:27:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/2] builtin/clone: allow remote helpers to detect repo
Message-ID: <9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>
References: <cover.1709041721.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Bum7CMW92fTgi0X"
Content-Disposition: inline
In-Reply-To: <cover.1709041721.git.ps@pks.im>


--+Bum7CMW92fTgi0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 18c9cb7524 (builtin/clone: create the refdb with the correct object
format, 2023-12-12), we have changed git-clone(1) so that it delays
creation of the refdb until after it has learned about the remote's
object format. This change was required for the reftable backend, which
encodes the object format into the tables. So if we pre-initialized the
refdb with the default object format, but the remote uses a different
object format than that, then the resulting tables would have encoded
the wrong object format.

This change unfortunately breaks remote helpers which try to access the
repository that is about to be created. Because the refdb has not yet
been initialized at the point where we spawn the remote helper, we also
don't yet have "HEAD" or "refs/". Consequently, any Git commands ran by
the remote helper which try to access the repository would fail because
it cannot be discovered.

This is essentially a chicken-and-egg problem: we cannot initialize the
refdb because we don't know about the object format. But we cannot learn
about the object format because the remote helper may be unable to
access the partially-initialized repository.

Ideally, we would address this issue via capabilities. But the remote
helper protocol is not structured in a way that guarantees that the
capability announcement happens before the remote helper tries to access
the repository.

Instead, fix this issue by partially initializing the refdb up to the
point where it becomes discoverable by Git commands.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c            | 46 ++++++++++++++++++++++++++++++++++++++
 setup.c                    |  9 +++++++-
 t/t5801/git-remote-testgit |  5 +++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bad1b70ce8..5d7f112125 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -926,6 +926,7 @@ int cmd_clone(int argc, const char **argv, const char *=
prefix)
 	struct ref *mapped_refs =3D NULL;
 	const struct ref *ref;
 	struct strbuf key =3D STRBUF_INIT;
+	struct strbuf buf =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
 	const char *src_ref_prefix =3D "refs/heads/";
@@ -1125,6 +1126,50 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 		git_dir =3D real_git_dir;
 	}
=20
+	/*
+	 * We have a chicken-and-egg situation between initializing the refdb
+	 * and spawning transport helpers:
+	 *
+	 *   - Initializing the refdb requires us to know about the object
+	 *     format. We thus have to spawn the transport helper to learn
+	 *     about it.
+	 *
+	 *   - The transport helper may want to access the Git repository. But
+	 *     because the refdb has not been initialized, we don't have "HEAD"
+	 *     or "refs/". Thus, the helper cannot find the Git repository.
+	 *
+	 * Ideally, we would have structured the helper protocol such that it's
+	 * mandatory for the helper to first announce its capabilities without
+	 * yet assuming a fully initialized repository. Like that, we could
+	 * have added a "lazy-refdb-init" capability that announces whether the
+	 * helper is ready to handle not-yet-initialized refdbs. If any helper
+	 * didn't support them, we would have fully initialized the refdb with
+	 * the SHA1 object format, but later on bailed out if we found out that
+	 * the remote repository used a different object format.
+	 *
+	 * But we didn't, and thus we use the following workaround to partially
+	 * initialize the repository's refdb such that it can be discovered by
+	 * Git commands. To do so, we:
+	 *
+	 *   - Create an invalid HEAD ref pointing at "refs/heads/.invalid".
+	 *
+	 *   - Create the "refs/" directory.
+	 *
+	 *   - Set up the ref storage format and repository version as
+	 *     required.
+	 *
+	 * This is sufficient for Git commands to discover the Git directory.
+	 */
+	initialize_repository_version(GIT_HASH_UNKNOWN,
+				      the_repository->ref_storage_format, 1);
+
+	strbuf_addf(&buf, "%s/HEAD", git_dir);
+	write_file(buf.buf, "ref: refs/heads/.invalid");
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s/refs", git_dir);
+	safe_create_dir(buf.buf, 1);
+
 	/*
 	 * additional config can be injected with -c, make sure it's included
 	 * after init_db, which clears the entire config environment.
@@ -1453,6 +1498,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	free(remote_name);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
+	strbuf_release(&buf);
 	strbuf_release(&key);
 	free_refs(mapped_refs);
 	free_refs(remote_head_points_at);
diff --git a/setup.c b/setup.c
index b69b1cbc2a..e3b76e84b5 100644
--- a/setup.c
+++ b/setup.c
@@ -1889,6 +1889,13 @@ void initialize_repository_version(int hash_algo,
 	char repo_version_string[10];
 	int repo_version =3D GIT_REPO_VERSION;
=20
+	/*
+	 * Note that we initialize the repository version to 1 when the ref
+	 * storage format is unknown. This is on purpose so that we can add the
+	 * correct object format to the config during git-clone(1). The format
+	 * version will get adjusted by git-clone(1) once it has learned about
+	 * the remote repository's format.
+	 */
 	if (hash_algo !=3D GIT_HASH_SHA1 ||
 	    ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
 		repo_version =3D GIT_REPO_VERSION_READ;
@@ -1898,7 +1905,7 @@ void initialize_repository_version(int hash_algo,
 		  "%d", repo_version);
 	git_config_set("core.repositoryformatversion", repo_version_string);
=20
-	if (hash_algo !=3D GIT_HASH_SHA1)
+	if (hash_algo !=3D GIT_HASH_SHA1 && hash_algo !=3D GIT_HASH_UNKNOWN)
 		git_config_set("extensions.objectformat",
 			       hash_algos[hash_algo].name);
 	else if (reinit)
diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
index 1544d6dc6b..bcfb358c51 100755
--- a/t/t5801/git-remote-testgit
+++ b/t/t5801/git-remote-testgit
@@ -12,6 +12,11 @@ url=3D$2
=20
 dir=3D"$GIT_DIR/testgit/$alias"
=20
+if ! git rev-parse --is-inside-git-dir
+then
+	exit 1
+fi
+
 h_refspec=3D"refs/heads/*:refs/testgit/$alias/heads/*"
 t_refspec=3D"refs/tags/*:refs/testgit/$alias/tags/*"
=20
--=20
2.44.0


--+Bum7CMW92fTgi0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd8V8ACgkQVbJhu7ck
PpSP/w//XKikx0TZtH+GGxgyiQWq/65GU6bpIkkbXgZvgIwO3U/8lkdbM/IC8edg
705AZT1SRas67wDs7kf6UKRFzdd1gzj9kisaaYoa79siuyAWfOkCMHgC2eHiJiYo
LwSKfWdnMs9SfPyOUMsebenUsmU5BTK4KcTfr7s6Q5lFiQEBpBLLhnGypy2XRUY1
EW9d2xHWoazjbUGUSuj/gEXg4WePJZ33zH/Y0zaRrYIV95wvELqEK9mk+t/JW7Sn
yNnoFMB7NXQTDd3j+pQxxrHcqfGGfKFH6/Ypu/5H6z48Q9Q3/LSalSDkvX1Rnz1Q
tfRUxleJA7G9F9INalcaqPtIQ/XPgqygnD6cAcHpoX/7dUcjo8AIUt5Boe0rbnu0
0HGWNFlaQ/X2FSiHvTSIe3F4P2ZSnvtvupC+b/LObzHEdFu3f4+aocS3bL/GWlJO
txMMjSsrLxcsmtdXOmPEIOm+H0KE3CLJtJt6+ucRpC+6D/0rfBVHncc+W2hUWAdo
+SF2mP2ZD4u0cCYcmS3mP7amdhLxcD/ERL314DIy9JvVpIV7p8Z7l3+J7aJi8ZV0
jdiAdCmdnNHRlVjb38rm4edzl1XB6jbZsvQnt02/Q4LxXAdF0UjEsOfNUKhUpYiq
gSMTVzUJubuJn9RWEfiPr3cApw9BdHG4j6yTF5vFqLwe+DS7wPg=
=hIv7
-----END PGP SIGNATURE-----

--+Bum7CMW92fTgi0X--
