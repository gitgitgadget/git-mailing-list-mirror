Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77E18EAB
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097561; cv=none; b=fcpTmlkn9juBfaQhNacNwuUSabJT0oS49sYGdKpeeA8gVLvekFsAv3IwJ+zGh2ly9rMFYtz4PT3rO7cVioNWEUJ6df9lLl4YwthgxCYU1gGwvY6CYBl6yf/GUOl/3VOAoZXnTReyP6kLuKiz65A93Pv+IVGGybMhtF+zPcb8uIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097561; c=relaxed/simple;
	bh=U2BWaVQ+tcz06cCGFt9LjjomatcFXD0IRbzG3+P7BtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qup1aPjsoUcuyRduLJzQsafWGURRsRwBAqzMPR/pdwZBKjlf057SqdXuuy9AGIzqPuy4aHDSKb+V1ATbRW3hK+wRYeqfwj9l/pHKeAyh4LKQxAYv18fePLXT55MXyGNDORs7PWQ8LqkVSAHLlMBQZT5fm+vfwGC8zPGaeWJkGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kNh/Qpnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XicZ5KMa; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kNh/Qpnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XicZ5KMa"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id B7CC21800115;
	Tue, 11 Jun 2024 05:19:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Jun 2024 05:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097558; x=1718183958; bh=egDpKvY10G
	PAW7igig2HWNbggXwJzj8X/7dX6V1nQfg=; b=kNh/QpnnZKtjYiYncFtEsGAiG6
	HlgUi4qhLfDjArkMGgwXn5t3/SEzSDduv75CeOVSgIHEbl1kV3HOYJCXvZ39vh9n
	Htl3f13SRC7wfTqDSNFbi8jTO5crZnOVGRh7blraUBaX6Bc5EjNpReWe+akzfH8H
	ZbDRkAsG/io3yczrIkSRUO/Mr7GaDotRwvTb59SjsdLOKJubb4bAFarT5tH9V+uw
	091MXV5n5qrj5o0Op2c7Kdho7/QItgx8H4CVAFICh7jZ4yAv7gUH+69aGkrUICEY
	USZTs33ooanTGRjGiC82Fx3Y+XsbjCGSlUuoWZ1IvvK1hHEYH7vgqjFy0bxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097558; x=1718183958; bh=egDpKvY10GPAW7igig2HWNbggXwJ
	zj8X/7dX6V1nQfg=; b=XicZ5KMaPD9L51nU8iYcxTvhjUP4DwVdMTJ9Nok51x4t
	wj+dSfqMlhlu12FYw9aWn6lRuzE9/gF0RHht1YO5ySkVXFhe6JA3APkZcR0+MvL2
	tEkuCk0Iiafbor3Fn9DGQGrnFX56zQcitFSyNSxlVZakPPD0NmDXHZ0GiSCtF83i
	6zwKDpXuJo21Qg3I8V6R/ZBMc9UjT3Xjitc5gAysoR77jqpsGPYV44uvYphcyYAw
	zC8qt+VYeNs0Hf9Mfdf79z5K7X4Dr7GNhgCYzyPICdljubyyhfuD2edoeH7OHfq0
	EH4ICwA+gc685Hqra421GSrF06aZg03OK9aHLkLmcg==
X-ME-Sender: <xms:lhZoZmvlLLXKPsK-VOJKMqRVssRt3irg9knyZbmATNJCMiO1HIz2JA>
    <xme:lhZoZrfs1QowMlj_VaXvntW2Buz5CAzp-IQyOvxagSr_gfI3sB77qOd7hvnntYiV8
    _qmXBtJLa39uVnB4g>
X-ME-Received: <xmr:lhZoZhyM1rHnK_kvHV3J3WJhFgWk7oJipFiIRxoOJI3Qbjb0JSAjETa29-WICJewFBtgYSv_9xd0HYKIEiGDzypWzd2i7Glu8NZ_MLKZOZUFrMxjYop1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lhZoZhM87jA62jJ2YTyPymcKBr_rojGTx6L7NP2RF0V-4-i5coPSew>
    <xmx:lhZoZm9qMPdbnHisUvba52H3bQ_5F32GpgakgGtyc0DjKeIgQYVAfw>
    <xmx:lhZoZpWnd6C9IafzKy0qvwJowcqpAtyMdg3Ibl718jbjbQhlQDuW7A>
    <xmx:lhZoZvfJe_kPZRW6ttFSMau8NaqVgwOCot8EyrgobUBqhpEpUi3HIg>
    <xmx:lhZoZtaKs6lkFUAJtTNLNwnKAdnb0pXy4pL6NwqM39uo11gdkU-_QfUR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0d9f9252 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:06 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/29] Memory leak fixes (pt.2)
Message-ID: <cover.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H/RiGodDDrE2SE3t"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--H/RiGodDDrE2SE3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that fixes various memory
leaks in our codebase.

Changes compared to v1:

  - Fix various typos in commit messages.

  - Refactor patch 20 such that we do not have both `ret` and `res` as
    local variables, which was confusing.

Thanks!

Patrick

Patrick Steinhardt (29):
  revision: fix memory leak when reversing revisions
  parse-options: fix leaks for users of OPT_FILENAME
  notes-utils: free note trees when releasing copied notes
  bundle: plug leaks in `create_bundle()`
  biultin/rev-parse: fix memory leaks in `--parseopt` mode
  merge-recursive: fix leaking rename conflict info
  revision: fix leaking display notes
  notes: fix memory leak when pruning notes
  builtin/rev-list: fix leaking bitmap index when calculating disk usage
  object-name: free leaking object contexts
  builtin/difftool: plug memory leaks in `run_dir_diff()`
  builtin/merge-recursive: fix leaking object ID bases
  merge-recursive: fix memory leak when finalizing merge
  builtin/log: fix leaking commit list in git-cherry(1)
  revision: free diff options
  builtin/stash: fix leak in `show_stash()`
  rerere: fix various trivial leaks
  config: fix leaking "core.notesref" variable
  commit: fix leaking parents when calling `commit_tree_extended()`
  sequencer: fix leaking string buffer in `commit_staged_changes()`
  apply: fix leaking string in `match_fragment()`
  builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
  sequencer: fix memory leaks in `make_script_with_merges()`
  builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
  merge: fix leaking merge bases
  line-range: plug leaking find functions
  blame: fix leaking data for blame scoreboards
  builtin/blame: fix leaking prefixed paths
  builtin/blame: fix leaking ignore revs files

 apply.c                                   |  88 ++++++++++------
 apply.h                                   |   2 +-
 blame.c                                   |   4 +
 builtin/am.c                              |   7 +-
 builtin/archive.c                         |   7 +-
 builtin/blame.c                           |   8 +-
 builtin/cat-file.c                        |  17 ++--
 builtin/clone.c                           |   3 +-
 builtin/commit-tree.c                     |  11 +-
 builtin/commit.c                          |  10 +-
 builtin/difftool.c                        |   3 +
 builtin/fmt-merge-msg.c                   |   4 +-
 builtin/grep.c                            |   4 +-
 builtin/log.c                             |  16 +--
 builtin/ls-tree.c                         |   3 +-
 builtin/merge-recursive.c                 |   6 +-
 builtin/merge-tree.c                      |   1 +
 builtin/merge.c                           |  18 +++-
 builtin/multi-pack-index.c                |  13 ++-
 builtin/replay.c                          |  14 ++-
 builtin/rev-list.c                        |   2 +
 builtin/rev-parse.c                       |  55 +++++-----
 builtin/shortlog.c                        |   5 +-
 builtin/sparse-checkout.c                 |   1 +
 builtin/stash.c                           |  23 +++--
 bundle.c                                  |  29 ++++--
 commit.c                                  |  28 +++---
 commit.h                                  |  12 +--
 config.c                                  |   1 +
 diff-lib.c                                |   2 +
 diff.c                                    |   8 +-
 help.c                                    |  12 +--
 help.h                                    |   2 +
 line-range.c                              |   2 +
 list-objects-filter.c                     |   2 +
 log-tree.c                                |   1 +
 merge-ort-wrappers.c                      |   2 +-
 merge-ort-wrappers.h                      |   2 +-
 merge-ort.c                               |  12 ++-
 merge-ort.h                               |   2 +-
 merge-recursive.c                         |  68 ++++++++-----
 merge-recursive.h                         |   4 +-
 notes-merge.c                             |   1 +
 notes-utils.c                             |   9 +-
 notes-utils.h                             |   2 +-
 notes.c                                   |  21 ++--
 notes.h                                   |   5 +
 object-name.c                             |  40 ++++++--
 object-name.h                             |   2 +
 rerere.c                                  |   3 +
 revision.c                                |  59 +++++++----
 sequencer.c                               | 116 +++++++++++++++-------
 t/helper/test-parse-options.c             |   1 +
 t/t1004-read-tree-m-u-wf.sh               |   1 +
 t/t1015-read-index-unmerged.sh            |   2 +
 t/t1021-rerere-in-workdir.sh              |   1 +
 t/t1512-rev-parse-disambiguation.sh       |   1 +
 t/t2500-untracked-overwriting.sh          |   1 +
 t/t3301-notes.sh                          |   1 +
 t/t3306-notes-prune.sh                    |   1 +
 t/t3308-notes-merge.sh                    |   1 +
 t/t3309-notes-merge-auto-resolve.sh       |   1 +
 t/t3400-rebase.sh                         |   1 +
 t/t3401-rebase-and-am-rename.sh           |   1 +
 t/t3403-rebase-skip.sh                    |   1 +
 t/t3406-rebase-message.sh                 |   1 +
 t/t3407-rebase-abort.sh                   |   1 +
 t/t3417-rebase-whitespace-fix.sh          |   1 +
 t/t3418-rebase-continue.sh                |   1 +
 t/t3420-rebase-autostash.sh               |   1 +
 t/t3421-rebase-topology-linear.sh         |   2 +
 t/t3424-rebase-empty.sh                   |   1 +
 t/t3428-rebase-signoff.sh                 |   1 +
 t/t3430-rebase-merges.sh                  |   1 +
 t/t3434-rebase-i18n.sh                    |   1 +
 t/t3500-cherry.sh                         |   1 +
 t/t3504-cherry-pick-rerere.sh             |   1 +
 t/t3505-cherry-pick-empty.sh              |   1 +
 t/t3508-cherry-pick-many-commits.sh       |   1 +
 t/t3509-cherry-pick-merge-df.sh           |   1 +
 t/t3907-stash-show-config.sh              |   1 +
 t/t4061-diff-indent.sh                    |   1 +
 t/t4131-apply-fake-ancestor.sh            |   1 +
 t/t4151-am-abort.sh                       |   1 +
 t/t4153-am-resume-override-opts.sh        |   1 +
 t/t4208-log-magic-pathspec.sh             |   1 +
 t/t4253-am-keep-cr-dos.sh                 |   1 +
 t/t4255-am-submodule.sh                   |   1 +
 t/t5150-request-pull.sh                   |   1 +
 t/t5300-pack-object.sh                    |   4 +-
 t/t5305-include-tag.sh                    |   1 +
 t/t5407-post-rewrite-hook.sh              |   1 +
 t/t5605-clone-local.sh                    |   1 +
 t/t5607-clone-bundle.sh                   |   1 +
 t/t5612-clone-refspec.sh                  |   1 +
 t/t6000-rev-list-misc.sh                  |   1 +
 t/t6001-rev-list-graft.sh                 |   1 +
 t/t6013-rev-list-reverse-parents.sh       |   1 +
 t/t6017-rev-list-stdin.sh                 |   1 +
 t/t6020-bundle-misc.sh                    |   1 +
 t/t6115-rev-list-du.sh                    |   2 +
 t/t6130-pathspec-noglob.sh                |   2 +
 t/t6402-merge-rename.sh                   |   1 +
 t/t6427-diff3-conflict-markers.sh         |   1 +
 t/t6430-merge-recursive.sh                |   1 +
 t/t6432-merge-recursive-space-options.sh  |   1 +
 t/t6434-merge-recursive-rename-options.sh |   1 +
 t/t6436-merge-overwrite.sh                |   1 +
 t/t7006-pager.sh                          |   1 +
 t/t7010-setup.sh                          |   1 +
 t/t7012-skip-worktree-writing.sh          |   1 +
 t/t7201-co.sh                             |   1 +
 t/t7501-commit-basic-functionality.sh     |   1 +
 t/t7505-prepare-commit-msg-hook.sh        |   1 +
 t/t7512-status-help.sh                    |   1 +
 t/t7600-merge.sh                          |   1 +
 t/t7606-merge-custom.sh                   |   1 +
 t/t7611-merge-abort.sh                    |   1 +
 t/t8002-blame.sh                          |   1 +
 t/t8003-blame-corner-cases.sh             |   1 +
 t/t8004-blame-with-conflicts.sh           |   1 +
 t/t8006-blame-textconv.sh                 |   2 +
 t/t8008-blame-formats.sh                  |   2 +
 t/t8009-blame-vs-topicbranches.sh         |   2 +
 t/t8011-blame-split-file.sh               |   2 +
 t/t8012-blame-colors.sh                   |   1 +
 t/t8013-blame-ignore-revs.sh              |   2 +
 t/t8014-blame-ignore-fuzzy.sh             |   2 +
 t/t9500-gitweb-standalone-no-errors.sh    |   1 +
 t/t9502-gitweb-standalone-parse-output.sh |   1 +
 130 files changed, 591 insertions(+), 272 deletions(-)

Range-diff against v1:
 1:  a88a6fa266 =3D  1:  f602bb5444 revision: fix memory leak when reversin=
g revisions
 2:  ecabbb74e1 =3D  2:  84f2f56b71 parse-options: fix leaks for users of O=
PT_FILENAME
 3:  17a8f53275 !  3:  c5f49bf930 notes-utils: free note trees when releasi=
ng copied notes
    @@ Metadata
      ## Commit message ##
         notes-utils: free note trees when releasing copied notes
    =20
    -    While we clear most of the members of `struct notet_rewrite_cfg` in
    +    While we clear most of the members of `struct notes_rewrite_cfg` in
         `finish_copy_notes_for_rewrite()`, we do not clear the notes tree.=
 Fix
         this to plug this memory leak.
    =20
 4:  0c8c97cded =3D  4:  5a1eae2cc9 bundle: plug leaks in `create_bundle()`
 5:  620814fb99 =3D  5:  91eefcf64a biultin/rev-parse: fix memory leaks in =
`--parseopt` mode
 6:  0052d60ee8 !  6:  f16c29a20a merge-recursive: fix leaging rename confl=
ict info
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    merge-recursive: fix leaging rename conflict info
    +    merge-recursive: fix leaking rename conflict info
    =20
         When computing rename conflicts in our recursive merge algorithm w=
e set
         up `struct rename_conflict_info`s to track that information. We ne=
ver
         free those data structures though and thus leak memory.
    =20
         We need to be a bit more careful here though because the same rena=
me
    -    conflict info can be assigned to multiple structures. Accomodate f=
or
    +    conflict info can be assigned to multiple structures. Accommodate =
for
         this by introducing a `rename_conflict_info_owned` bit that we can=
 use
         to steer whether or not the rename conflict info shall be free'd.
    =20
 7:  8c55370b8e =3D  7:  b9c3a34ae1 revision: fix leaking display notes
 8:  17671dc9cf =3D  8:  3ea5e5c6bd notes: fix memory leak when pruning not=
es
 9:  5e01c39e35 =3D  9:  a0242359b7 builtin/rev-list: fix leaking bitmap in=
dex when calculating disk usage
10:  2ac24bf942 =3D 10:  bdb7389328 object-name: free leaking object contex=
ts
11:  8349f6acbd =3D 11:  e6ff9a3f1c builtin/difftool: plug memory leaks in =
`run_dir_diff()`
12:  5d9fb78e63 =3D 12:  fb30a254ab builtin/merge-recursive: fix leaking ob=
ject ID bases
13:  930de11911 =3D 13:  b6540e4aff merge-recursive: fix memory leak when f=
inalizing merge
14:  3e3243f884 =3D 14:  7cb4f75178 builtin/log: fix leaking commit list in=
 git-cherry(1)
15:  a754800fd1 =3D 15:  99f4f3d341 revision: free diff options
16:  8bde010d1d =3D 16:  707d798f78 builtin/stash: fix leak in `show_stash(=
)`
17:  cadeb09b95 =3D 17:  7d73c50872 rerere: fix various trivial leaks
18:  cff6303ce1 =3D 18:  1700ec8d21 config: fix leaking "core.notesref" var=
iable
19:  8ada8864d8 =3D 19:  c1a1eb34ab commit: fix leaking parents when callin=
g `commit_tree_extended()`
20:  48bcd0ac80 ! 20:  144eb23617 sequencer: fix leaking string buffer in `=
commit_staged_changes()`
    @@ sequencer.c: static int commit_staged_changes(struct repository *r,
      			/*
      			 * If a fixup/squash in a fixup/squash chain failed, the
     @@ sequencer.c: static int commit_staged_changes(struct repository *r,
    + 				 * We need to update the squash message to skip
    + 				 * the latest commit message.
    + 				 */
    +-				int res =3D 0;
    + 				struct commit *commit;
    + 				const char *msg;
      				const char *path =3D rebase_path_squash_msg();
      				const char *encoding =3D get_commit_output_encoding();
     =20
    @@ sequencer.c: static int commit_staged_changes(struct repository *r,
     =20
      				p =3D repo_logmsg_reencode(r, commit, NULL, encoding);
      				if (!p)  {
    -@@ sequencer.c: static int commit_staged_changes(struct repository *r,
    +-					res =3D error(_("could not parse commit %s"),
    ++					ret =3D error(_("could not parse commit %s"),
    + 						    oid_to_hex(&commit->object.oid));
    + 					goto unuse_commit_buffer;
    + 				}
    + 				find_commit_subject(p, &msg);
    + 				if (write_message(msg, strlen(msg), path, 0)) {
    +-					res =3D error(_("could not write file: "
    ++					ret =3D error(_("could not write file: "
    + 						       "'%s'"), path);
    + 					goto unuse_commit_buffer;
      				}
    ++
    ++				ret =3D 0;
    ++
      			unuse_commit_buffer:
      				repo_unuse_commit_buffer(r, commit, p);
     -				if (res)
     -					return res;
    -+				if (res) {
    -+					ret =3D res;
    ++				if (ret)
     +					goto out;
    -+				}
      			}
      		}
     =20
21:  ebed18717f =3D 21:  8e1cf8a18b apply: fix leaking string in `match_fra=
gment()`
22:  4f4ae5ea96 =3D 22:  8090891bd0 builtin/clone: plug leaking HEAD ref in=
 `wanted_peer_refs()`
23:  713531c6f1 =3D 23:  1cdd988c45 sequencer: fix memory leaks in `make_sc=
ript_with_merges()`
24:  eeef280dd5 =3D 24:  be9bccc853 builtin/merge: fix leaking `struct cmdn=
ames` in `get_strategy()`
25:  5441f1e2ef =3D 25:  6f6456494c merge: fix leaking merge bases
26:  ba9c2b4ea7 =3D 26:  67f8637dc6 line-range: plug leaking find functions
27:  5f2b0adc56 =3D 27:  bd6db56a3f blame: fix leaking data for blame score=
boards
28:  7ee8734437 =3D 28:  c1291025fa builtin/blame: fix leaking prefixed pat=
hs
29:  5b5fdfc6cb =3D 29:  5d7007e724 builtin/blame: fix leaking ignore revs =
files
--=20
2.45.2.436.gcd77e87115.dirty


--H/RiGodDDrE2SE3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFpAACgkQVbJhu7ck
PpQvlRAArpfNNkI268DeYY+nhwnCeYqyuVNwYQhlzWztrjp7M2D18OrfM7IUXKo9
jpDI8EwwKDhqOJEfiumeORdMNHS/n/6qADWyyAgwz1QfrrURtX+3JKlA78u8Ngq/
8UV6wX88YJEOZTaQ1WvzYqchurV/rqI9nwUa5l6rtdWxHDfU4cxJsnpNUoN1uxJe
IHmxwVbAvEmojeT1NDhHKqT3RFJhiuAvZOF8K9BnVeXoW42p8DOKwJd5S5yqeeL1
VGnFixA1SODENIqtSz1KtcTtormG54Q1B6OvbgeK5GceugxwTHGUr0Z/C2c8aGUa
jjnGXH2HnTFVVBX5lU+TNQ3yqBV5FCIUXXSHDWB9JQgI+k92nQqXox9alMkzUEI2
tPg2Zl9E5zh7Jlt1oPTdINM60eayxRlXP0w8szNTBaEyxj5QyvAb15qFchjWuf5Z
xu4hPXaDrfvorjT7W/v4bLWkGOkBbMkYUGXTIL1adz/ZLou1IjtvlI8GAonxBhb3
TRCh2nxIg6o6BmHVc8ekKceuVqiBlA15T6DTamRDgxPd41mMXxjKLZ4SSBOxV1DB
+tk1rypgjtnYygDFf0/4Gv/2AFFx7o3JUTuivz06zGDrWU9eqHcUeU4o/TN8uGl0
bURNsh+V17MAl1gPB5xIYNyItFaJwSRxTdXwBE0YqP4AIbOIFgg=
=f1Y8
-----END PGP SIGNATURE-----

--H/RiGodDDrE2SE3t--
