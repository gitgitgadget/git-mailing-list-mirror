Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB317BD5
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651741; cv=none; b=WRjAnmzwUuXVrk8eKf0wd4yHQ06sY0F6QYTYdahDCUKGYs+FuUC+ofdtpbXVjliyhlC/42NuqRF0Kb+dzgPVFMLhQCrA+v6O+F3iqo5wx9RnnQBysJ2oeBUjn3YjNV0Kmc/uw6mcVtxUG96Sdwr5OHHW3PO8eo9wEAcDI/HvEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651741; c=relaxed/simple;
	bh=vrTy7VoiB+o0UXs5VL9vtR/9ffimyYhFum7Y5ROe0kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk4p6Y+1Ipcda9cqOLTFtp9VcQvxQ8OggsIMct8LyAwI0UdAytpxB5Iq5eBHPrt4wtwixMhueoMe7UcQEAGFIoWlKsKSnSCHy5uMe/sOxQn5LoYq5Wrf1Nl6m5K3wu4ikWSXnm0Q7JmiiHVBkTJGpr78iRRhjfVsiBKb9FYBc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T0Nzi21p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gkfgqPKh; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T0Nzi21p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gkfgqPKh"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 3C5481C001CF;
	Thu,  6 Jun 2024 01:28:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 01:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651737; x=1717738137; bh=qrABjiyGSq
	kvnOxDn8ueit/5eZ57PeNbrRHf3g8BfOs=; b=T0Nzi21pH6EX93v07T6tguiXWN
	DH6FULCnJG/16rG6X2Uf2sKkjsIsCFOTGtRel4JV4ucRA+VO9l6H64A+p6VxUKge
	0CqxsbgFhawkHNIqEQmfgzM6JyoKk+rONHlFEe/EflEt9bVxgw1JSxRhjiz97bt4
	62jjEmNdWz4ruWG2hNjZw+hr1vX28zIV9gPzPJUaJq2iExU1HG32x8m/yC6QsvlJ
	rU/d3ySE+g7HvhQtYFf+0uYe8DbDqU9D5xuhh5M1ub6oagN/r6Ougz+LvmkjIiAF
	MIlIorypLuM3zXVT5T+O42YIihGLNWHzkeHWKy9rtgpmQvaQ/egawzmZOFMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651737; x=1717738137; bh=qrABjiyGSqkvnOxDn8ueit/5eZ57
	PeNbrRHf3g8BfOs=; b=gkfgqPKh4i1ds3c5dkpw/WwG311RG25pzkyF3xJX7r++
	O2fXwxb/9GHirG5aRmXAMruSDk691NZ//6tPuFERMrH3MeLs6YHUUqqMiYMpni0G
	GjGFVz7PAZmkMuhj204L2nH1GXDKIh/oFQZ30y0G30ZSoOTKBB9aCNX8yYng1F1p
	hB/lBqxV7c3BGdWpwfKIUeFEtR1SaiCeGMunfOjZRrWznuaO5/8vQ3zpCJlsAHc0
	eqsUz3xqSpc4Ssgp9tqWOS/9kB7lExMIKgFDbFPbJQHM5HX9A8+1OzivgZvbv8v+
	KRHPyACiMnLrznLXwcE/hPG+vFnGhxMWf0Hi66IL1w==
X-ME-Sender: <xms:GUlhZrr690iiZGzlVOCB_frFKn5XnwtAABi14MpyvuNyXysaPEzm1w>
    <xme:GUlhZlr5RpTP7EkV75dXgKAq4Y93eoyfQgs6oo04fWaju02N_8-FU9dwlRM7vr8mt
    nWlWhCAIGuuJL3MvA>
X-ME-Received: <xmr:GUlhZoNfl8j-hDL5K7-bp_iFkFyqi5v418VraQzyhg7KUDqez71YG_CVBjzT1dv6nIMmUXfKenC1sCm1ZR1ZE3JkK8nBynM2aAuOiheLvjz7o98g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GUlhZu7I6lM9ya58YuPCMwX7BQaZMW63z7hjEq6qvV5bRuzWaWjW-g>
    <xmx:GUlhZq4lKYcIdOsBYyTM2S09ha57RR5uULa79Z_9tn6aH5mNredW3A>
    <xmx:GUlhZmj7raV6ekURT17Uh0jYwpgWiZYc04uQ5So87nzmKF0UWQqeAw>
    <xmx:GUlhZs4McUGOnRMH6o7XtZMEdEVGCZaiQAtf0oz6kVoxPwxeI7HyXQ>
    <xmx:GUlhZhaOKeN2FTdbSnKTC3ZgTDGJmSSVCQfctSy8ZranP5-3iuwUNjNg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:28:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 721d6800 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:24 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:28:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 00/12] refs: ref storage migrations
Message-ID: <cover.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QiFnynuL5pasmbbD"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--QiFnynuL5pasmbbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the ref storage migration was merged to `next`, but got reverted due to
some additional findings by Peff and/or Coverity.

Changes compared to v4:

  - Adapt comment of `ref_store_init()` to the new parameter.

  - Fix use of an uninitialized return value in `for_each_root_ref()`.

  - Fix overwrite of ret code in `files_ref_store_remove_on_disk()`.

  - Adapt an error message to more clearly point out that deletion of
    "refs/" directory failed in `reftable_be_remove_on_disk()`.

  - Fix a leak when `mkdtemp()` fails.

Thanks!

Patrick

Patrick Steinhardt (12):
  setup: unset ref storage when reinitializing repository version
  refs: convert ref storage format to an enum
  refs: pass storage format to `ref_store_init()` explicitly
  refs: allow to skip creation of reflog entries
  refs/files: refactor `add_pseudoref_and_head_entries()`
  refs/files: extract function to iterate through root refs
  refs/files: fix NULL pointer deref when releasing ref store
  reftable: inline `merged_table_release()`
  worktree: don't store main worktree twice
  refs: implement removal of ref storages
  refs: implement logic to migrate between ref storage formats
  builtin/refs: new command to migrate ref storage formats

 .gitignore                 |   1 +
 Documentation/git-refs.txt |  61 +++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/clone.c            |   2 +-
 builtin/init-db.c          |   2 +-
 builtin/refs.c             |  75 ++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 refs.c                     | 345 +++++++++++++++++++++++++++++++++++--
 refs.h                     |  41 ++++-
 refs/files-backend.c       | 124 +++++++++++--
 refs/packed-backend.c      |  15 ++
 refs/ref-cache.c           |   2 +
 refs/refs-internal.h       |   7 +
 refs/reftable-backend.c    |  55 +++++-
 reftable/merged.c          |  12 +-
 reftable/merged.h          |   2 -
 reftable/stack.c           |   8 +-
 repository.c               |   3 +-
 repository.h               |  10 +-
 setup.c                    |  10 +-
 setup.h                    |   9 +-
 t/helper/test-ref-store.c  |   1 +
 t/t1460-refs-migrate.sh    | 243 ++++++++++++++++++++++++++
 worktree.c                 |  29 ++--
 26 files changed, 979 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/git-refs.txt
 create mode 100644 builtin/refs.c
 create mode 100755 t/t1460-refs-migrate.sh

Range-diff against v4:
 1:  afb705f6a0 =3D  1:  afb705f6a0 setup: unset ref storage when reinitial=
izing repository version
 2:  7989e82dcd =3D  2:  7989e82dcd refs: convert ref storage format to an =
enum
 3:  7d1a86292c !  3:  26005abb28 refs: pass storage format to `ref_store_i=
nit()` explicitly
    @@ Commit message
    =20
      ## refs.c ##
     @@ refs.c: static struct ref_store *lookup_ref_store_map(struct strmap=
 *map,
    -  * gitdir.
    +=20
    + /*
    +  * Create, record, and return a ref_store instance for the specified
    +- * gitdir.
    ++ * gitdir using the given ref storage format.
       */
      static struct ref_store *ref_store_init(struct repository *repo,
     +					enum ref_storage_format format,
 4:  d0539b7456 =3D  4:  053f1be657 refs: allow to skip creation of reflog =
entries
 5:  7f9ce5af2e =3D  5:  29147da2b9 refs/files: refactor `add_pseudoref_and=
_head_entries()`
 6:  f7577a0ab3 !  6:  86cf0c84b1 refs/files: extract function to iterate t=
hrough root refs
    @@ refs/files-backend.c: static void add_root_refs(struct files_ref_sto=
re *refs,
      		strbuf_setlen(&refname, dirnamelen);
      	}
     +
    ++	ret =3D 0;
    ++
     +done:
      	strbuf_release(&refname);
      	strbuf_release(&path);
 7:  56baa798fb =3D  7:  6b0aaf2ac8 refs/files: fix NULL pointer deref when=
 releasing ref store
 8:  c7e8ab40b5 =3D  8:  0690d5eae9 reftable: inline `merged_table_release(=
)`
 9:  7a89aae515 =3D  9:  89699a641d worktree: don't store main worktree twi=
ce
10:  f9d9420cf9 ! 10:  7b5fee2185 refs: implement removal of ref storages
    @@ refs/files-backend.c: static int files_ref_store_create_on_disk(stru=
ct ref_store
     +	}
     +	strbuf_reset(&sb);
     +
    -+	ret =3D for_each_root_ref(refs, remove_one_root_ref, &data);
    -+	if (ret < 0)
    ++	if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
     +		ret =3D -1;
     +
     +	if (ref_store_remove_on_disk(refs->packed_ref_store, err) < 0)
    @@ refs/reftable-backend.c: static int reftable_be_create_on_disk(struc=
t ref_store
     +
     +	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
     +	if (rmdir(sb.buf) < 0) {
    -+		strbuf_addf(err, "could not delete stub heads: %s",
    ++		strbuf_addf(err, "could not delete refs directory: %s",
     +			    strerror(errno));
     +		ret =3D -1;
     +	}
11:  1f26051eff ! 11:  893d99e98e refs: implement logic to migrate between =
ref storage formats
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +{
     +	struct ref_store *old_refs =3D NULL, *new_refs =3D NULL;
     +	struct ref_transaction *transaction =3D NULL;
    -+	struct strbuf buf =3D STRBUF_INIT;
    ++	struct strbuf new_gitdir =3D STRBUF_INIT;
     +	struct migration_data data;
     +	size_t reflog_count =3D 0;
    -+	char *new_gitdir =3D NULL;
     +	int did_migrate_refs =3D 0;
     +	int ret;
     +
    ++	if (repo->ref_storage_format =3D=3D format) {
    ++		strbuf_addstr(errbuf, "current and new ref storage format are equal=
");
    ++		ret =3D -1;
    ++		goto done;
    ++	}
    ++
     +	old_refs =3D get_main_ref_store(repo);
     +
     +	/*
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	 *
     +	 *   6. Change the repository format to the new ref format.
     +	 */
    -+	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
    -+	new_gitdir =3D mkdtemp(xstrdup(buf.buf));
    -+	if (!new_gitdir) {
    ++	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.X=
XXXXX");
    ++	if (!mkdtemp(new_gitdir.buf)) {
     +		strbuf_addf(errbuf, "cannot create migration directory: %s",
     +			    strerror(errno));
     +		ret =3D -1;
     +		goto done;
     +	}
     +
    -+	new_refs =3D ref_store_init(repo, format, new_gitdir,
    ++	new_refs =3D ref_store_init(repo, format, new_gitdir.buf,
     +				  REF_STORE_ALL_CAPS);
     +	ret =3D ref_store_create_on_disk(new_refs, 0, errbuf);
     +	if (ret < 0)
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +
     +	if (flags & REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN) {
     +		printf(_("Finished dry-run migration of refs, "
    -+			 "the result can be found at '%s'\n"), new_gitdir);
    ++			 "the result can be found at '%s'\n"), new_gitdir.buf);
     +		ret =3D 0;
     +		goto done;
     +	}
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	if (ret < 0)
     +		goto done;
     +
    -+	ret =3D move_files(new_gitdir, old_refs->gitdir, errbuf);
    ++	ret =3D move_files(new_gitdir.buf, old_refs->gitdir, errbuf);
     +	if (ret < 0)
     +		goto done;
     +
    -+	if (rmdir(new_gitdir) < 0)
    ++	if (rmdir(new_gitdir.buf) < 0)
     +		warning_errno(_("could not remove temporary migration directory '%s=
'"),
    -+			      new_gitdir);
    ++			      new_gitdir.buf);
     +
     +	/*
     +	 * We have migrated the repository, so we now need to adjust the
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	if (ret && did_migrate_refs) {
     +		strbuf_complete(errbuf, '\n');
     +		strbuf_addf(errbuf, _("migrated refs can be found at '%s'"),
    -+			    new_gitdir);
    ++			    new_gitdir.buf);
     +	}
     +
     +	if (ret && new_refs)
     +		ref_store_release(new_refs);
     +	ref_transaction_free(transaction);
    -+	strbuf_release(&buf);
    -+	free(new_gitdir);
    ++	strbuf_release(&new_gitdir);
     +	return ret;
     +}
    =20
12:  83cb3f8c96 =3D 12:  ec0c6d3cf1 builtin/refs: new command to migrate re=
f storage formats
--=20
2.45.2.409.g7b0defb391.dirty


--QiFnynuL5pasmbbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSRMACgkQVbJhu7ck
PpSgFg//UhPSMiQ4bDIQCM0I8dumIUc6+oi2JmBKYIFtkjRs9fA9Fes3WChBPrbY
SILgNgV8DIM6IaOzVklVjlwKWPRQE8xyDuHEY0dvCqhnlmYbHwwrx9rtn8QoDvWM
BUen0TrXQz6PtRWbY2FjWogQMV8apTEe49LSLCN9rVMq/GxdwbdOKFKDMZ/n7Ko9
K5MU7fBM5F3HulBVZzhy9neA1kTued1ug8+TJEYQwy2e4CGNg5JrJpI6CqMSQnr7
5qgtTmv36GuTVpjC8qIImj4M9/j8lX7BCvkRLvjYwZi7PDplgyffwRDNA1DB0O75
9D2spLxHOpBYhJAH5xXde+me2JKPETge+eXBPprRwjJFiGkcLHN3znCjJlL67ghF
+ffVdLw0dYbzEkzoT58aVBZW3kYAAVEvndPtbYCcwP62z2Wj/f2COh3vZ0BFc6Qa
wQQZ8mg4yNFxh0v5ETNRlHt7mmlafc14yjdKy11XRZiyMrThWIDHzo2pvg40YwS/
0h4IEm9n1WcMJpwmqSfc7pBTu3e2d/OeoaTIgYAgu6miY+Kramt+z+gbed/yNH/d
C+KzuB2zrwnsPhkktAiDb4G1XhCAmQ7H+VQwf933xTIunSkTgNCXsWCpvJAf33dl
5r0z2/UdipbE+lOFcb/misQ86URkkBm/ileIdvoM6/DmDq7kMfk=
=kKGD
-----END PGP SIGNATURE-----

--QiFnynuL5pasmbbD--
