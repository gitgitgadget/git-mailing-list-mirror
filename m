Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711B13A3EF
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810353; cv=none; b=Sx9yRcM2mPJgD6GMkIHV/lmfguF5OICuGFl4Mz0fqZuL1BtPyKJlos1COMZbNlpDK/CYiOuuRYfMMWe4B0lahZJwL9WI1MhNUjcNC/KWikdUdqpkv7nqqLszSvM/2cadTiZFu3vkFIsEYM508sZmBrlTwPdUEQuGg+1y40g+KvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810353; c=relaxed/simple;
	bh=ZZ0J0LCyOoirgVRc4GXUKLpekErXEu15enpj8l0hwwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDcRrp2IInC5OT8CTsMNzaY08uu5JeoWnWiT1J+GWSIkEnhD8OJ9J+z53RKoJoGk6joskL42Zzpmt0Zn+/o2P4juAlRmcA9nnGLm8sdJdYh1sjs+/qmy16XHioDSNbPSJ1Hk+b5ZC6MeK0RtgAsGx5Uef748HqNNZgZV8hsdqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HyWAN+7n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iV/iU8j8; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HyWAN+7n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iV/iU8j8"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 319B018000CF;
	Mon, 27 May 2024 07:45:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 May 2024 07:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810348; x=1716896748; bh=ktNbJq2p2s
	W3fwbm72Akiq2sWMsGodC89b22AkO8/nE=; b=HyWAN+7nKTlb0gkgGxUSOFWWRo
	eFA1Pql2jG2ofuNz/4dLbHPCnKC3ZieQV5JNPSDWxqv0TG+d3cs5sT3xvcZqadmN
	OBUbMB6ahLFx/WWWvHjirqKsKbTCTLa1SmdrN/xk7ID7LmzLq3Udt65IVh657ArW
	N1da62HwPvTZYPW5UAf5SA2YPiuTYfg7cnO8QiqSthqSTkW3fTn0j26BX6B84QAW
	EwYUqh6P8HyJBz9Tg345zYCA6xiIuFUa+GhoHI0hge6niBxuGYpQ6B2RLhSANu2n
	wI8luaAaJB5vgGFLUbWbttqs399U/I0Wg/ytLCkZn5jweiHYpkIFUKOYmsiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810348; x=1716896748; bh=ktNbJq2p2sW3fwbm72Akiq2sWMsG
	odC89b22AkO8/nE=; b=iV/iU8j8sk5GtTC6CyKT2LsEBemsyOdZluvQtq0S4Hvq
	9HY8ehnIbJOvW3eQDbM5am89Q4/7nagSUwjAtD0BBJz2pbwd1y05dj0e7zmeMeoG
	CktfZZu/cab78eZkceqz4dfhlgQSLu3ykDkV66YjJCzW3e3yBvROZRRwJ6ENvRbX
	9miBK1dSAMJQ8+cuSe02WDI3ZHWnyTL9iFQwZavu/7u0NWIKjHvfDbyPEm56lEZ1
	Uae+d8uN57OOi6SSW+7gml3nJLbu2qVB1RGqUUrIfCuqQBHRFuRc30AydyHsOCAl
	2/19hrUZWzImIQpIxPSMi6jjO/5PtT9+RTozWD71Vw==
X-ME-Sender: <xms:bHJUZov8V17ZRmS2SN8mUSUzwB8y8ctNG_kFwgpRFcND8dqN_u7xWw>
    <xme:bHJUZleFddo7mx2rAyuDfogsdIrKnCK-3x8qOZcLMkXDWwz9nbChLw8BuV4O2OTJS
    MODP_ACXwC_VBViEQ>
X-ME-Received: <xmr:bHJUZjxIau8Ei93Ygd6fJxvpCRFq7YNt4zBrBUO1nDEnLz0gvSNU-gN9dtOxEqMyjsfbt5FGmcBzy4sl4kS7et4nefP9TDE2JzJbuL7MTtU1NZIoTyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdehvdeuvdeuffeileevudehtdffgeffgeelleeltddvjeetueekieejteevteel
    necuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhpqdgruhhthhdrshhhpdhhthhtph
    dqphhrohighidrshhhpdhhthhtphdqtghurhhlqdhvvghrsghoshgvrdhshhdpgedtrdhi
    thenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:bHJUZrMVWlHBTtc3b-PNoYuWI8bO_eKFGyMTJRqvgP2YptA39kfOyA>
    <xmx:bHJUZo_TIQqWAPzv641nSmQI-S8FPjEqQ9Lni1YkCsbLWqt_rgB3Qw>
    <xmx:bHJUZjUqND963DZjHOJlw1yuOdwlc7uymND-ZeeMaoLMkSlLkh5Esg>
    <xmx:bHJUZhcomxjWMBdDbnYBM826_RZUa7hlq09JZgeK9ew5Ed89oEfcxQ>
    <xmx:bHJUZnkIn6Tgd2FMeWWA13PlaE9D2smEvKY_9sv2So8-Y8WU91Qo-wnA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:45:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6145d002 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:45:34 +0000 (UTC)
Date: Mon, 27 May 2024 13:45:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 00/21] Various memory leak fixes
Message-ID: <cover.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tj5XuHrUpgOJdCaP"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--Tj5XuHrUpgOJdCaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that fixes various memory
leaks throughout Git.

Changes compared to v2:

    - Add a missing SOB.

    - Fix some typos in commit messages.

    - Explain more thoroughly why `appendwholeline()` may leak even on
      error.

    - Move removal of `const char **` cast to the correct commit.

Thanks!

Patrick

Patrick Steinhardt (21):
  ci: add missing dependency for TTY prereq
  t: mark a bunch of tests as leak-free
  transport-helper: fix leaking helper name
  strbuf: fix leak when `appendwholeline()` fails with EOF
  checkout: clarify memory ownership in `unique_tracking_name()`
  http: refactor code to clarify memory ownership
  config: clarify memory ownership in `git_config_pathname()`
  diff: refactor code to clarify memory ownership of prefixes
  convert: refactor code to clarify ownership of
    check_roundtrip_encoding
  builtin/log: stop using globals for log config
  builtin/log: stop using globals for format config
  config: clarify memory ownership in `git_config_string()`
  config: plug various memory leaks
  builtin/credential: clear credential before exit
  commit-reach: fix memory leak in `ahead_behind()`
  submodule: fix leaking memory for submodule entries
  strvec: add functions to replace and remove strings
  builtin/mv: refactor `add_slash()` to always return allocated strings
  builtin/mv duplicate string list memory
  builtin/mv: refactor to use `struct strvec`
  builtin/mv: fix leaks for submodule gitfile paths

 Makefile                                      |   1 +
 alias.c                                       |   6 +-
 attr.c                                        |   2 +-
 attr.h                                        |   2 +-
 builtin/blame.c                               |   2 +-
 builtin/checkout.c                            |  14 +-
 builtin/commit.c                              |   4 +-
 builtin/config.c                              |   2 +-
 builtin/credential.c                          |   2 +
 builtin/log.c                                 | 708 ++++++++++--------
 builtin/merge.c                               |   4 +-
 builtin/mv.c                                  | 222 +++---
 builtin/rebase.c                              |   2 +-
 builtin/receive-pack.c                        |   6 +-
 builtin/repack.c                              |   8 +-
 builtin/worktree.c                            |  20 +-
 checkout.c                                    |   4 +-
 checkout.h                                    |   6 +-
 ci/install-dependencies.sh                    |   4 +-
 commit-reach.c                                |   4 +
 config.c                                      |  52 +-
 config.h                                      |  10 +-
 convert.c                                     |  30 +-
 convert.h                                     |   2 +-
 delta-islands.c                               |   2 +-
 diff.c                                        |  20 +-
 environment.c                                 |  16 +-
 environment.h                                 |  14 +-
 fetch-pack.c                                  |   4 +-
 fsck.c                                        |   4 +-
 fsmonitor-settings.c                          |   5 +-
 gpg-interface.c                               |   6 +-
 http.c                                        |  50 +-
 imap-send.c                                   |  12 +-
 mailmap.c                                     |   4 +-
 mailmap.h                                     |   4 +-
 merge-ll.c                                    |   6 +-
 pager.c                                       |   2 +-
 pretty.c                                      |  14 +-
 promisor-remote.h                             |   2 +-
 remote.c                                      |  20 +-
 remote.h                                      |   8 +-
 sequencer.c                                   |   2 +-
 setup.c                                       |   6 +-
 strbuf.c                                      |   4 +-
 strvec.c                                      |  20 +
 strvec.h                                      |  13 +
 submodule-config.c                            |   2 +
 t/t0300-credentials.sh                        |   2 +
 t/t0411-clone-from-partial.sh                 |   1 +
 t/t0610-reftable-basics.sh                    |   1 +
 t/t0611-reftable-httpd.sh                     |   1 +
 t/t1013-read-tree-submodule.sh                |   1 +
 t/t1306-xdg-files.sh                          |   1 +
 t/t1350-config-hooks-path.sh                  |   1 +
 t/t1400-update-ref.sh                         |   2 +
 t/t2013-checkout-submodule.sh                 |   1 +
 t/t2024-checkout-dwim.sh                      |   1 +
 t/t2060-switch.sh                             |   1 +
 t/t2405-worktree-submodule.sh                 |   1 +
 t/t3007-ls-files-recurse-submodules.sh        |   1 +
 t/t3203-branch-output.sh                      |   2 +
 t/t3415-rebase-autosquash.sh                  |   1 +
 t/t3426-rebase-submodule.sh                   |   1 +
 t/t3512-cherry-pick-submodule.sh              |   1 +
 t/t3513-revert-submodule.sh                   |   1 +
 t/t3600-rm.sh                                 |   1 +
 t/t3906-stash-submodule.sh                    |   1 +
 t/t4001-diff-rename.sh                        |   4 +-
 t/t4041-diff-submodule-option.sh              |   1 +
 t/t4043-diff-rename-binary.sh                 |   1 +
 t/t4059-diff-submodule-not-initialized.sh     |   1 +
 t/t4060-diff-submodule-option-diff-format.sh  |   1 +
 t/t4120-apply-popt.sh                         |   1 +
 t/t4137-apply-submodule.sh                    |   1 +
 t/t4210-log-i18n.sh                           |   2 +
 t/t5563-simple-http-auth.sh                   |   1 +
 t/t5564-http-proxy.sh                         |   1 +
 t/t5581-http-curl-verbose.sh                  |   1 +
 t/t6006-rev-list-format.sh                    |   1 +
 t/t6041-bisect-submodule.sh                   |   1 +
 t/t6400-merge-df.sh                           |   1 +
 t/t6412-merge-large-rename.sh                 |   1 +
 t/t6426-merge-skip-unneeded-updates.sh        |   1 +
 t/t6429-merge-sequence-rename-caching.sh      |   1 +
 t/t6438-submodule-directory-file-conflicts.sh |   1 +
 t/t7001-mv.sh                                 |   2 +
 t/t7005-editor.sh                             |   1 +
 t/t7102-reset.sh                              |   1 +
 t/t7112-reset-submodule.sh                    |   1 +
 t/t7417-submodule-path-url.sh                 |   1 +
 t/t7421-submodule-summary-add.sh              |   1 +
 t/t7423-submodule-symlinks.sh                 |   1 +
 t/t9129-git-svn-i18n-commitencoding.sh        |   1 -
 t/t9139-git-svn-non-utf8-commitencoding.sh    |   1 -
 t/t9200-git-cvsexportcommit.sh                |   1 +
 t/t9401-git-cvsserver-crlf.sh                 |   1 +
 t/t9600-cvsimport.sh                          |   1 +
 t/t9601-cvsimport-vendor-branch.sh            |   1 +
 t/t9602-cvsimport-branches-tags.sh            |   1 +
 t/t9603-cvsimport-patchsets.sh                |   2 +
 t/t9604-cvsimport-timestamps.sh               |   2 +
 t/unit-tests/t-strvec.c                       | 269 +++++++
 t/unit-tests/test-lib.c                       |  13 +
 t/unit-tests/test-lib.h                       |  13 +
 transport-helper.c                            |   6 +-
 transport.c                                   |   1 +
 upload-pack.c                                 |   2 +-
 userdiff.h                                    |  12 +-
 109 files changed, 1151 insertions(+), 586 deletions(-)
 create mode 100644 t/unit-tests/t-strvec.c

Range-diff against v2:
 1:  857b8b14ce !  1:  ded220a06b ci: add missing dependency for TTY prereq
    @@ Commit message
         systems are missing this dependency and thus don't execute those t=
ests
         at all. Fix this.
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## ci/install-dependencies.sh ##
     @@ ci/install-dependencies.sh: alpine-*)
      	apk add --update shadow sudo build-base curl-dev openssl-dev expat-d=
ev gettext \
 2:  ceade7dbba !  2:  f305e4bc46 t: mark a bunch of tests as leak-free
    @@ Commit message
           - t7423: Introduced via b20c10fd9b (t7423: add tests for symlink=
ed
             submodule directories, 2024-01-28), passes since e8d0608944
             (submodule: require the submodule path to contain directories =
only,
    -        2024-03-26). The fix is not ovbiously related, but probably wo=
rks
    +        2024-03-26). The fix is not obviously related, but probably wo=
rks
             because we now die early in many code paths.
    =20
           - t9xxx: All of these are exercising CVS-related tooling and pass
             since at least Git v2.40. It's likely that these pass for a lo=
ng
    -        time already, but nobody ever noticed because noone has CVS on=
 their
    -        machine.
    +        time already, but nobody ever noticed because Git developers d=
o not
    +        tend to have CVS on their machines.
    =20
         Mark all of these tests as passing.
    =20
 3:  a96b5ac359 =3D  3:  9e946c1a83 transport-helper: fix leaking helper na=
me
 4:  9dd8709d1b !  4:  aa5cbd9d14 strbuf: fix leak when `appendwholeline()`=
 fails with EOF
    @@ Commit message
    =20
         In `strbuf_appendwholeline()` we call `strbuf_getwholeline()` with=
 a
         temporary buffer. In case the call returns an error we indicate th=
is by
    -    returning EOF, but never release the temporary buffer. This can le=
ad to
    -    a memory leak when the line has been partially filled. Fix this.
    +    returning EOF, but never release the temporary buffer. This can ca=
use a
    +    leak though because `strbuf_getwholeline()` calls getline(3). Quot=
ing
    +    its documentation:
    +
    +        If *lineptr was set to NULL before the call, then the buffer
    +        should be freed by the user program even on failure.
    +
    +    Consequently, the temporary buffer may hold allocated memory even =
when
    +    the call to `strbuf_getwholeline()` fails.
    +
    +    Fix this by releasing the temporary buffer on error.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 5:  6d4e9ce706 =3D  5:  4a6dd9b6a8 checkout: clarify memory ownership in `=
unique_tracking_name()`
 6:  141cae2de1 =3D  6:  fa91a3942e http: refactor code to clarify memory o=
wnership
 7:  ff5e761e55 =3D  7:  88babf1abf config: clarify memory ownership in `gi=
t_config_pathname()`
 8:  afe69c7303 =3D  8:  feec7e971f diff: refactor code to clarify memory o=
wnership of prefixes
 9:  eb7fce55b0 =3D  9:  dae00f1b63 convert: refactor code to clarify owner=
ship of check_roundtrip_encoding
10:  ee2fcf388c =3D 10:  02c5be27be builtin/log: stop using globals for log=
 config
11:  3490ad3a02 =3D 11:  eeba79678a builtin/log: stop using globals for for=
mat config
12:  6cfc28c7e2 ! 12:  a4fafcd079 config: clarify memory ownership in `git_=
config_string()`
    @@ config.c: int git_config_bool(const char *name, const char *value)
      {
      	if (!value)
      		return config_error_nonbool(var);
    +@@ config.c: static int git_default_core_config(const char *var, const=
 char *value,
    +=20
    + 	if (!strcmp(var, "core.checkroundtripencoding")) {
    + 		FREE_AND_NULL(check_roundtrip_encoding);
    +-		return git_config_string((const char **) &check_roundtrip_encoding,=
 var, value);
    ++		return git_config_string(&check_roundtrip_encoding, var, value);
    + 	}
    +=20
    + 	if (!strcmp(var, "core.notesref")) {
     @@ config.c: int git_configset_get_string(struct config_set *set, cons=
t char *key, char **des
      {
      	const char *value;
13:  70e8e26513 ! 13:  8b74dff678 config: plug various memory leaks
    @@ config.c: static int git_default_core_config(const char *var, const =
char *value,
      		return git_config_pathname(&git_hooks_path, var, value);
      	}
     =20
    -@@ config.c: static int git_default_core_config(const char *var, const=
 char *value,
    -=20
    - 	if (!strcmp(var, "core.checkroundtripencoding")) {
    - 		FREE_AND_NULL(check_roundtrip_encoding);
    --		return git_config_string((const char **) &check_roundtrip_encoding,=
 var, value);
    -+		return git_config_string(&check_roundtrip_encoding, var, value);
    - 	}
    -=20
    - 	if (!strcmp(var, "core.notesref")) {
     @@ config.c: static int git_default_core_config(const char *var, const=
 char *value,
      		return 0;
      	}
14:  f1a1c43e76 =3D 14:  265665fe6c builtin/credential: clear credential be=
fore exit
15:  64b92156f8 =3D 15:  b315a5bb5c commit-reach: fix memory leak in `ahead=
_behind()`
16:  cd8a992f08 =3D 16:  7c75a94756 submodule: fix leaking memory for submo=
dule entries
17:  128e2eaf7a =3D 17:  0f61ee9929 strvec: add functions to replace and re=
move strings
18:  1310b24fc2 =3D 18:  1830e2a568 builtin/mv: refactor `add_slash()` to a=
lways return allocated strings
19:  d4fef9825a =3D 19:  9eeafac365 builtin/mv duplicate string list memory
20:  797cdb286a =3D 20:  48b9d3e343 builtin/mv: refactor to use `struct str=
vec`
21:  095469193c =3D 21:  add7946446 builtin/mv: fix leaks for submodule git=
file paths
--=20
2.45.1.246.gb9cfe4845c.dirty


--Tj5XuHrUpgOJdCaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcmUACgkQVbJhu7ck
PpQVJg/+MlRRl1zUQ2E6PVgGAA2dd6upAjFWf37ZSqVi1fX5cmBV27GyNSy8LYqI
BfsVhj7neQWK2QwjSuyKbx1eMIwced2WgbaNasZRpEgy2Nkupo3idZuGZjtBefJE
gqH+qwCoOiyQIkftpoebRXrXP+7wUQabihWDlOiZSq3ldhSKi7GqhqLnWGmjrsx5
tEd9cF49Lh2/u7hBJBuz5TIv7veRn2xRkRwn48sNPQc+v0aloF46GiDkSf7bXmaq
ma09oph/ZzF3cTz4xlJqKnR15k4YQcah4GCQTIxCgBn3eUo9l3x3h9zom0ZWcICu
oCEBenq8Rcz9iuirnRID9LOY8mbVOZWqv1oD/9U13onua/hTfr7cCnFgKejDl2jK
jHIOiZCSfAx62emRlSVWbY1//V9niXf/yQcasw2LAl+EOmkAKUekBnEquxhlOhvW
5Dnu7kmeTW6tw83hVbJ5XChgoBaj7EqxzaWLVc1Uf+iM9TfTJiDrRq4lqqEf4wHr
yE7Sb8DHB88OvPFbC+rzKWHNBMv1tH1nDe96ea7I2aVtFRUO+uzhBYuj/86BA/yv
UPONZwU7DZ8oazOMh3fcIM5cJ9ah1tqHGQC4bFmKmn55DzxUfy9HKgJn8432Wsqg
Eqj9KtLSLBt81yNjDT6tqLZ6P4xxIgvlVsootFNEiyzyk3Ans4I=
=Y6ny
-----END PGP SIGNATURE-----

--Tj5XuHrUpgOJdCaP--
