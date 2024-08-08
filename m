Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A29EEA9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122275; cv=none; b=PRWivoKlHARve/q6eo0L+jvH9LSTu0FH49pug2QxUjvkKFHtN475s/pIBp4spTps3N06/GmojeP69j5CZ4YGcPhuaoK+cSvDB2Fvk0VYXqPOxFiYL8JQ5GuVnE3YaUD+VCcfwSLpJYgTO9aoLJ5mdIT1qoJC4OXCyqhS3k7r7EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122275; c=relaxed/simple;
	bh=9Ub0VLkdP5IrKA4C+FGs+z1lqtq3mwuI5cemRP6VOkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ4dGqFr68dPJpTj63QAJLX+qYxLU8I3UFxnJGQXhQX2bd4iQf9jCXsr86pugwS7F3QUQdGLlW4l93sZLh2W+vjCBB6uz6cBwbHuM9i7AtlzBEfGAbHoNczaR4Zck9uP96I/yjGxEcUqX0Jm8odVwwBu1jqbuRAroh64IaxCbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Air+OGlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SykzxSxm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Air+OGlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SykzxSxm"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A3EB7138FBFE;
	Thu,  8 Aug 2024 09:04:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122272; x=1723208672; bh=sKsrPcW2TL
	nxTddcRyh4q6IjtnPLcZUvWAnDKJBK/hE=; b=Air+OGlQQx6d5y4bIBQCgOarg1
	XHKpsSCUBgXvgWf4hsd02pOpEvzetMl0Ouxz2bGJ/dgsBgkzl1OLUjQC3rq+6hUZ
	Di3biAjMwRKptSiswThXaCmhd+tJ6Mf+KOFhKKMuh3gCOloSGru9wfqY9JUbPOC9
	cpuAB7S6a4GAKXXKmTJzr38UJ9Dv7tN4exIHxtkSR1o8uIllC0Wx3ROg/WC2re1P
	VUgk/mj+rKirWjtIgrz4Bp1KP35XL3mKxfC6H0aTTyCXNudRxX007LkgcfvuoKxN
	H6IdFHF8ErcTcCeU8pPmG3z1eW2HQIesor3aHvtMxpoABoTsyEwdk78t+EWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122272; x=1723208672; bh=sKsrPcW2TLnxTddcRyh4q6IjtnPL
	cZUvWAnDKJBK/hE=; b=SykzxSxm7HLBG3W5tRUxjbwS/Kq1inPhXyK2E7LJeoeg
	FwNfJJkkLJfoQS1yyE6wuUoSMG/5m2mcRbro6DTL5tUviBdevRxFDXD2jqmiKsiX
	DRv9tl41I+24kzja7wSC93DgcpTACb3RHE1Jmnn6Alr0g6yLE4qWH/QuliFke5mL
	TMrjJFNvKKjMUBYz41p5bUOKYSSASXP0L4Lcx/YphbJ3eoiUTl00B/aXn9DcYb0k
	V6tBUL8aeoQf4unSwL4uQsXPZSudu8MssMcHoX051k8PuxqOXyQlC0QRGII8WkmW
	KBiclP2P5f/QHR53d2WCtT2ViJ9gKoNhAglSHejXeA==
X-ME-Sender: <xms:YMK0Zt1cN9No1hBo12vGQwRmsDnMjbwRBplDE7Q9jdKuwSeWBckZxA>
    <xme:YMK0ZkE0szUDEpfzEGd5SYLSOVI2OfcvnuLiYE7uMOIrlALpUEqVj79BSQw5p1uuu
    WuhBY_QtiQdwzPP0Q>
X-ME-Received: <xmr:YMK0Zt79i19N7gU5-dIMcwzBv15f7CEYZUD7TPOQegj1JHty7jzl_46sfeB7v-LFHg6jFb6qDDzyqQ4iyEUrWBtFnlRJ6CXZ1NBUnQ2QqlhWArUh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:YMK0Zq33O0Z3o9KHm86Yh24kivZ1S0zAjJwvGD3c8JKr7l5TjsF3-Q>
    <xmx:YMK0ZgGnzV3Hubvk9WuFPDDv20H0HIhh-zkoY0WoRp1VrshZEuBtGA>
    <xmx:YMK0Zr-dbQiCDEQJusBmb88gkF_zeRhD5MHENXmaWlD6wzPX4L8b7Q>
    <xmx:YMK0ZtlVF5OX-6bS5Yf-n92hOmwmhoNuqdogg74aFrqj1iYWOuwI0w>
    <xmx:YMK0ZkBcXn402ncy4dxWLIxOc4w06ah2O7QE23v-ekh0sEh3aXdSfFAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:04:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b3f889f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:23 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:04:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 00/22] Memory leak fixes (pt.4)
Message-ID: <cover.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cPDobvDeqDZVGAHR"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--cPDobvDeqDZVGAHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my fourth batch of patches that fix
various memory leaks.

Changes compared to v1:

  - Adapt the memory leak fix for command characters to instead use a
    `comment_line_str_allocated` variable.

  - Clarify some commit messages.

  - Drop the TODO comment about `rebase.gpgsign`. Turns out that this is
    working as intended, as explained by Phillip.

Thanks!

Patrick

Patrick Steinhardt (22):
  remote: plug memory leak when aliasing URLs
  git: fix leaking system paths
  object-file: fix memory leak when reading corrupted headers
  object-name: fix leaking symlink paths in object context
  bulk-checkin: fix leaking state TODO
  read-cache: fix leaking hashfile when writing index fails
  submodule-config: fix leaking name enrty when traversing submodules
  config: fix leaking comment character config
  builtin/rebase: fix leaking `commit.gpgsign` value
  builtin/notes: fix leaking `struct notes_tree` when merging notes
  builtin/fast-import: plug trivial memory leaks
  builtin/fast-export: fix leaking diff options
  builtin/fast-export: plug leaking tag names
  merge-ort: unconditionally release attributes index
  sequencer: release todo list on error paths
  unpack-trees: clear index when not propagating it
  diff: fix leak when parsing invalid ignore regex option
  builtin/format-patch: fix various trivial memory leaks
  userdiff: fix leaking memory for configured diff drivers
  builtin/log: fix leak when showing converted blob contents
  diff: free state populated via options
  builtin/diff: free symmetric diff members

 builtin/commit.c                      |  7 +-
 builtin/diff.c                        | 10 ++-
 builtin/fast-export.c                 | 19 ++++--
 builtin/fast-import.c                 |  8 ++-
 builtin/log.c                         | 13 +++-
 builtin/notes.c                       |  9 ++-
 builtin/rebase.c                      |  1 +
 bulk-checkin.c                        |  2 +
 config.c                              |  4 +-
 csum-file.c                           |  2 +-
 csum-file.h                           | 10 +++
 diff.c                                | 16 ++++-
 environment.c                         |  1 +
 environment.h                         |  1 +
 git.c                                 | 12 +++-
 merge-ort.c                           |  3 +-
 object-file.c                         |  1 +
 object-name.c                         |  1 +
 range-diff.c                          |  6 +-
 read-cache.c                          | 97 ++++++++++++++++-----------
 remote.c                              |  2 +
 sequencer.c                           | 67 ++++++++++++------
 submodule-config.c                    | 18 +++--
 t/t0210-trace2-normal.sh              |  2 +-
 t/t1006-cat-file.sh                   |  1 +
 t/t1050-large.sh                      |  1 +
 t/t1450-fsck.sh                       |  1 +
 t/t1601-index-bogus.sh                |  2 +
 t/t2107-update-index-basic.sh         |  1 +
 t/t3310-notes-merge-manual-resolve.sh |  1 +
 t/t3311-notes-merge-fanout.sh         |  1 +
 t/t3404-rebase-interactive.sh         |  1 +
 t/t3435-rebase-gpg-sign.sh            |  1 +
 t/t3507-cherry-pick-conflict.sh       |  1 +
 t/t3510-cherry-pick-sequence.sh       |  1 +
 t/t3705-add-sparse-checkout.sh        |  1 +
 t/t4013-diff-various.sh               |  1 +
 t/t4014-format-patch.sh               |  1 +
 t/t4018-diff-funcname.sh              |  1 +
 t/t4030-diff-textconv.sh              |  2 +
 t/t4042-diff-textconv-caching.sh      |  2 +
 t/t4048-diff-combined-binary.sh       |  1 +
 t/t4064-diff-oidfind.sh               |  2 +
 t/t4065-diff-anchored.sh              |  1 +
 t/t4068-diff-symmetric-merge-base.sh  |  1 +
 t/t4069-remerge-diff.sh               |  1 +
 t/t4108-apply-threeway.sh             |  1 +
 t/t4209-log-pickaxe.sh                |  2 +
 t/t6421-merge-partial-clone.sh        |  1 +
 t/t6428-merge-conflicts-sparse.sh     |  1 +
 t/t7008-filter-branch-null-sha1.sh    |  1 +
 t/t7030-verify-tag.sh                 |  1 +
 t/t7817-grep-sparse-checkout.sh       |  1 +
 t/t9300-fast-import.sh                |  1 +
 t/t9304-fast-import-marks.sh          |  2 +
 t/t9351-fast-export-anonymize.sh      |  1 +
 unpack-trees.c                        |  2 +
 userdiff.c                            | 38 ++++++++---
 userdiff.h                            |  4 ++
 59 files changed, 288 insertions(+), 106 deletions(-)

Range-diff against v1:
 1:  6e2fcd85c7 =3D  1:  2afa51f9ff remote: plug memory leak when aliasing =
URLs
 2:  9574995a24 =3D  2:  324140e4fd git: fix leaking system paths
 3:  f7e67d02d2 =3D  3:  43a38a2281 object-file: fix memory leak when readi=
ng corrupted headers
 4:  a9caaaed55 =3D  4:  9d3dc145e8 object-name: fix leaking symlink paths =
in object context
 5:  794af66103 =3D  5:  454139e7a4 bulk-checkin: fix leaking state TODO
 6:  2810cada0a =3D  6:  f8b7195796 read-cache: fix leaking hashfile when w=
riting index fails
 7:  03f699cf39 =3D  7:  762fb5aa73 submodule-config: fix leaking name enrt=
y when traversing submodules
 8:  a34c90a552 !  8:  8fbd72a100 config: fix leaking comment character con=
fig
    @@ Commit message
         without free'ing the previous value. In fact, it can't easily free=
 the
         value in the first place because it may contain a string constant.
    =20
    -    Refactor the code so that we initialize the value with another arr=
ay.
    -    This allows us to free the value in case the string is not pointin=
g to
    -    that constant array anymore.
    +    Refactor the code such that we track allocated comment character s=
trings
    +    via a separate non-constant variable `comment_line_str_allocated`.=
 Adapt
    +    sites that set `comment_line_str` to set both and free the old val=
ue
    +    that was stored in `comment_line_str_allocated`.
    =20
         This memory leak is being hit in t3404. As there are still other m=
emory
         leaks in that file we cannot yet mark it as passing with leak chec=
king
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## builtin/commit.c ##
    +@@ builtin/commit.c: static void adjust_comment_line_char(const struct=
 strbuf *sb)
    + 	const char *p;
    +=20
    + 	if (!memchr(sb->buf, candidates[0], sb->len)) {
    +-		comment_line_str =3D xstrfmt("%c", candidates[0]);
    ++		free(comment_line_str_allocated);
    ++		comment_line_str =3D comment_line_str_allocated =3D
    ++			xstrfmt("%c", candidates[0]);
    + 		return;
    + 	}
    +=20
    +@@ builtin/commit.c: static void adjust_comment_line_char(const struct=
 strbuf *sb)
    + 	if (!*p)
    + 		die(_("unable to select a comment character that is not used\n"
    + 		      "in the current commit message"));
    +-	comment_line_str =3D xstrfmt("%c", *p);
    ++	free(comment_line_str_allocated);
    ++	comment_line_str =3D comment_line_str_allocated =3D xstrfmt("%c", *p=
);
    + }
    +=20
    + static void prepare_amend_commit(struct commit *commit, struct strbuf=
 *sb,
    +
      ## config.c ##
     @@ config.c: static int git_default_core_config(const char *var, const=
 char *value,
      		else if (value[0]) {
      			if (strchr(value, '\n'))
      				return error(_("%s cannot contain newline"), var);
    -+			if (comment_line_str !=3D comment_line_str_default)
    -+				free((char *) comment_line_str);
    - 			comment_line_str =3D xstrdup(value);
    +-			comment_line_str =3D xstrdup(value);
    ++			free(comment_line_str_allocated);
    ++			comment_line_str =3D comment_line_str_allocated =3D
    ++				xstrdup(value);
      			auto_comment_line_char =3D 0;
      		} else
    + 			return error(_("%s must have at least one character"), var);
    =20
      ## environment.c ##
     @@ environment.c: int protect_ntfs =3D PROTECT_NTFS_DEFAULT;
    -  * The character that begins a commented line in user-editable file
       * that is subject to stripspace.
       */
    --const char *comment_line_str =3D "#";
    -+const char comment_line_str_default[] =3D "#";
    -+const char *comment_line_str =3D comment_line_str_default;
    + const char *comment_line_str =3D "#";
    ++char *comment_line_str_allocated;
      int auto_comment_line_char;
     =20
      /* Parallel index stat data preload? */
    =20
      ## environment.h ##
     @@ environment.h: struct strvec;
    -  * The character that begins a commented line in user-editable file
       * that is subject to stripspace.
       */
    -+extern const char comment_line_str_default[];
      extern const char *comment_line_str;
    ++extern char *comment_line_str_allocated;
      extern int auto_comment_line_char;
     =20
    + /*
 9:  05290fc1f1 !  9:  e497b76e9c builtin/rebase: fix leaking `commit.gpgsi=
gn` value
    @@ Metadata
      ## Commit message ##
         builtin/rebase: fix leaking `commit.gpgsign` value
    =20
    -    In `get_replay_opts()`, we unconditionally override the `gpg_sign`=
 field
    -    that already got populated by `sequencer_init_config()` in case th=
e user
    -    has "commit.gpgsign" set in their config. It is kind of dubious wh=
ether
    -    this is the correct thing to do or a bug. What is clear though is =
that
    -    this creates a memory leak.
    +    In `get_replay_opts()`, we override the `gpg_sign` field that alre=
ady
    +    got populated by `sequencer_init_config()` in case the user has
    +    "commit.gpgsign" set in their config. This creates a memory leak b=
ecause
    +    we overwrite the previously assigned value, which may have already
    +    pointed to an allocated string.
    =20
    -    Let's mark this assignment with a TODO comment to figure out wheth=
er
    -    this needs to be fixed or not. Meanwhile though, let's plug the me=
mory
    -    leak.
    +    Let's plug the memory leak by freeing the value before we overwrit=
e it.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const st=
ruct rebase_
      	replay.committer_date_is_author_date =3D
      					opts->committer_date_is_author_date;
      	replay.ignore_date =3D opts->ignore_date;
    -+
    -+	/*
    -+	 * TODO: Is it really intentional that we unconditionally override
    -+	 * `replay.gpg_sign` even if it has already been initialized via the
    -+	 * configuration?
    -+	 */
     +	free(replay.gpg_sign);
      	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
    -+
      	replay.reflog_action =3D xstrdup(opts->reflog_action);
      	if (opts->strategy)
    - 		replay.strategy =3D xstrdup_or_null(opts->strategy);
    =20
      ## sequencer.c ##
     @@ sequencer.c: static int git_sequencer_config(const char *k, const c=
har *v,
10:  4f5d490074 =3D 10:  c886b666f7 builtin/notes: fix leaking `struct note=
s_tree` when merging notes
11:  798b911f77 =3D 11:  d1c757157b builtin/fast-import: plug trivial memor=
y leaks
12:  660732d29d =3D 12:  fa2d5c5d6b builtin/fast-export: fix leaking diff o=
ptions
13:  64366155de =3D 13:  d9dd860d2a builtin/fast-export: plug leaking tag n=
ames
14:  b12015b3c3 =3D 14:  8f6860485e merge-ort: unconditionally release attr=
ibutes index
15:  df4c21b49f ! 15:  ea6a350f31 sequencer: release todo list on error pat=
hs
    @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
      									&oid,
      									NULL);
     -				return error(_("%s: can't cherry-pick a %s"),
    +-					name, type_name(type));
     +				res =3D error(_("%s: can't cherry-pick a %s"),
    - 					name, type_name(type));
    ++					    name, type_name(type));
     +				goto out;
      			}
     -		} else
16:  1f8553fd43 =3D 16:  2755023742 unpack-trees: clear index when not prop=
agating it
17:  c6db8df324 =3D 17:  edf6f148cd diff: fix leak when parsing invalid ign=
ore regex option
18:  bf818a8a79 =3D 18:  343e3bd4df builtin/format-patch: fix various trivi=
al memory leaks
19:  ef780aa360 =3D 19:  be2c5b0bca userdiff: fix leaking memory for config=
ured diff drivers
20:  f3882986a3 =3D 20:  7888203833 builtin/log: fix leak when showing conv=
erted blob contents
21:  a49bb2e0cc =3D 21:  245fc30afb diff: free state populated via options
22:  fb52599404 =3D 22:  343ddcd17b builtin/diff: free symmetric diff membe=
rs
--=20
2.46.0.46.g406f326d27.dirty


--cPDobvDeqDZVGAHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wlsACgkQVbJhu7ck
PpR2rRAAhqbceVL071U5fvWT3U5I3mukj229G/MADSAu0V3g+ZtkcxYy82gatQNS
AfHFJH43W0XciDyJx+yOzw7DeLuayGvGQ7w80dwHRH0TKvKC67ME3cmO4uKkKJ3k
BurntC1Ty+LcEjEGBX7h4wrYGW/Y5HHNCVXa9556bnUvuuGjherAe2tt8cNcPim7
IFkFn1yVXxFdWILc1sKy6lP4QgEWu8J3ANNbKS7XzsI3JjnL4/0yUH1JS8trnyj4
RGlZyFmDec+Hdzed1OM+OzwVL8/vxdPu0yRo6Of9/IXJQq6Zz/AH+0IuujrmBsJ5
6+0r9SjSXHfZYsUoMyxR4VGr4vyqmoj+CndaT7YDDUcSqhuXHMJje+xEsbufm8vg
ULHht6L3WBg/M8vx5H85Of7n+2bYjTZ/8H+TB9CGo9mqCe8/UC/yyUbfxFyitybL
WGpiC6LwmbzNM6s5ywLo/iEF9qQj+F84mAFrNMkmgNDBfcudtoUCU2gkL8Fg8rPf
p2UYE+fLcnoVESSqqO7Us8lROd/km4tZdHKBEQoqj8hLxwdDYRAMR1Fjp56/PQDM
faxCavUm3n54xpdun68yU/JwyOk0fy8QfyLduKvrRv8jra2HjGl+Mvmmuto13bQC
BbolxVTm9Ozm8WvO97sOcfPPjSolkUpw7JdJcpRkPsntqJzuTE0=
=7AN7
-----END PGP SIGNATURE-----

--cPDobvDeqDZVGAHR--
