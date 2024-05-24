Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EC84E09
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545000; cv=none; b=RohIr1k49WyHOvq0+xdJ4xdstIockTpx1Fwyw6jud8YalEVwKL/gxxJgqzPPRMF4x69wdveMcW2I3N8kklFa1DpLYlEeMx9+BXWlw7eduJ6ZwZdbM32rSl8gXOxiigYC+ooQjh3KHBiG9lJ4VGMdosSKgRYx2Q0gZC6wKWtJmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545000; c=relaxed/simple;
	bh=I7RHJVWMxFeCGwhf5IsoLP7fJvjtiPm35n7lWuTZQ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0HeCzin7Nz6ER22EKn9h3lILwWo/VjNS6ALj5gqk9Df9eiKR7zZiZzuTodDAlEjkS6f1RPOsDfWCI3ZRRO2/0hPxbghJjRfIfwITmp7zaDbaVi6XUOO5ph6tW8Wlq4luYM4F6hdzCQJjkGMPBz2KciYYJ2LIBFJiEPrSAC1SLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LPnJfkub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btfw8CWn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LPnJfkub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btfw8CWn"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8BB7F1140195;
	Fri, 24 May 2024 06:03:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 24 May 2024 06:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716544996; x=1716631396; bh=HNqRK9HNM+
	rhZ9O+AfGFLOAWwD/hmddkwN/vWxhXXaU=; b=LPnJfkubsvyKHFECF1gbWKmPiZ
	/bnxKr49Ax8+vOyuH/toezyX7xycpKzbnimNGXqy5cfbmazV5E7b6WbOoKvLBFqY
	59dd9tCvvCj3oGYdgI6aVLrjqMI4FqICP6lqjPaxv3HFAj311/fyjY/dGpyR2kw1
	pDZrIV2WERt3wv9oJwNmOT7u3DMYQLIJdQFYjtEzTUtDPVST0aqF7nk0gBlhy9Xf
	T6eNtPkP6JSGInJpznbougfU6LhZSKbCpRL2/rD07ISQ11SM4/uT+iZvFTO0vrCU
	2zIPnWVPTpgD58NNPhRS+0bfHg932nmLPClPmY3mNE1ZWIGsVMYGgRvPcuvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716544996; x=1716631396; bh=HNqRK9HNM+rhZ9O+AfGFLOAWwD/h
	mddkwN/vWxhXXaU=; b=btfw8CWnHvsvYXiU+tr3uLPTy/Xpxob0hUQ2TvT/HPtR
	R+yfobpfz/P398fPxfi5Sa+OefvvS1T6B0uPSDklXBQAQlNqu9e6KkqCp5mb1WSU
	42OgCwORnjZOIwZlVxzEWh7V/w1DrJuRmrOMZ4cRgacnKylhbotuiyS83GI7MRL0
	mKK6pjVnA588lJ2oVSt211qn7vDY+9x33Mja57sRqYtoIAExFjzuRxl7x3vqgkxt
	t2v4i3G9mNGmzcllqUd9awUq5HleM+2420/3pd5xTQvwyvpHYfQGvqFTinGvs5lV
	8A+pleKQB2UOLJ0BDUL4PWYFEh3XUFT9Jv96pt+70Q==
X-ME-Sender: <xms:5GVQZjx6mP4KpeUbPhRQot0Jx0XZjcB4lwKhlhUZTgOvrlZOGTprkw>
    <xme:5GVQZrQPBGRU49Vnj5mhipXS8TTXv7QOhbN08LZiWGe_Tel6lg3qNoDIfyNpyOz6L
    FEcCvJjXxvhWxqj1A>
X-ME-Received: <xmr:5GVQZtW_JsVPB7DxuOzh7PetBp_A9gA6pL0xE6R0Qm3hzCCd21PX0hl4hcde8htFfn2MXCjtdaOusMBGZTm1Lbh3fIpX7bym-_YWjXhprgTx4K8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepudejteduvdeiffejheevfeeijefhtedtffdvkedutdduleefgfetfffgveevtdef
    necuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhpqdgruhhthhdrshhhpdhhthhtph
    dqphhrohighidrshhhpdhhthhtphdqtghurhhlqdhvvghrsghoshgvrdhshhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:5GVQZth3GJWeOlyVgSIJvvffldSyLNXoEQlGqls4NeoDWCv2D1dvmQ>
    <xmx:5GVQZlDben6VZSxHm1d6hIVud_g8Qud9UiytJO06olN2bULBkPLbYA>
    <xmx:5GVQZmLd_0lV9AM6av52IhJ48dDiEvUDsWwiQR_d1x9kKyDQKyxuuQ>
    <xmx:5GVQZkDgzOd1_-9FBd1F035bgX_ok4gs0JuYBBDVVfaDKhkzTwJGpQ>
    <xmx:5GVQZkPNTTe2fLNQ_EuTjCr_NV6Pwu27EVnkd9d4m6q0tJhQvl1sUx9F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 71da8cfe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:09 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/21] Various memory leak fixes
Message-ID: <cover.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SAZEvFtw1akq3/lZ"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--SAZEvFtw1akq3/lZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that fixes various memory
leaks in Git. Changes compared to v1:

  - t4153 and t7006 aren't marked as passing anymore. I thought they
    pass because most of these tests were skipped because of a missing
    TTY prerequisite both on my local machine, but also in our CI.

  - Add another patch to install the Perl IO:Pty module on Alpine and
    Ubuntu. This fulfills the TTY prerequisite and thus surfaces the
    memory leaks in both of the above tests.

  - Add another unit test for strvec that exercise replacing a string in
    the strvec with a copy of itself.

  - A bunch of commit message improvements.

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

Range-diff against v1:
 -:  ---------- >  1:  857b8b14ce ci: add missing dependency for TTY prereq
 1:  0e9fa9ca73 !  2:  ceade7dbba t: mark a bunch of tests as leak-free
    @@ Commit message
           - t2405: Passes since 6741e917de (repository: avoid leaking
             `fsmonitor` data, 2024-04-12).
    =20
    -      - t4153: Passes since 71c7916053 (apply: plug a leak in apply_da=
ta,
    -        2024-04-23).
    -
    -      - t7006: Passes since at least Git v2.40. I did not care to go b=
ack
    -        any further than that.
    -
           - t7423: Introduced via b20c10fd9b (t7423: add tests for symlink=
ed
             submodule directories, 2024-01-28), passes since e8d0608944
             (submodule: require the submodule path to contain directories =
only,
    @@ t/t2405-worktree-submodule.sh: test_description=3D'Combination of su=
bmodules and m
     =20
      base_path=3D$(pwd -P)
    =20
    - ## t/t4153-am-resume-override-opts.sh ##
    -@@
    -=20
    - test_description=3D'git-am command-line options override saved option=
s'
    -=20
    -+TEST_PASSES_SANITIZE_LEAK=3Dtrue
    - . ./test-lib.sh
    - . "$TEST_DIRECTORY"/lib-terminal.sh
    -=20
    -
    - ## t/t7006-pager.sh ##
    -@@
    -=20
    - test_description=3D'Test automatic use of a pager.'
    -=20
    -+TEST_PASSES_SANITIZE_LEAK=3Dtrue
    - . ./test-lib.sh
    - . "$TEST_DIRECTORY"/lib-pager.sh
    - . "$TEST_DIRECTORY"/lib-terminal.sh
    -
      ## t/t7423-submodule-symlinks.sh ##
     @@
     =20
 2:  05fbadbae2 !  3:  a96b5ac359 transport-helper: fix leaking helper name
    @@ Commit message
         ownership of the name, nor do we free it. The associated memory th=
us
         leaks.
    =20
    -    Fix this memory leak and mark now-passing tests as leak free.
    +    Fix this memory leak by freeing the string at the calling side in
    +    `transport_get()`. `transport_helper_init()` now creates its own c=
opy of
    +    the string and thus can free it as required.
    +
    +    An alterantive way to fix this would be to transfer ownership of t=
he
    +    string passed into `transport_helper_init()`, which would avoid th=
e call
    +    to xstrdup(1). But it does make for a more surprising calling conv=
ention
    +    as we do not typically transfer ownership of strings like this.
    +
    +    Mark now-passing tests as leak free.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 3:  d76079797f =3D  4:  9dd8709d1b strbuf: fix leak when `appendwholeline(=
)` fails with EOF
 4:  ffd9eb795f =3D  5:  6d4e9ce706 checkout: clarify memory ownership in `=
unique_tracking_name()`
 5:  d4bf3c1f95 =3D  6:  141cae2de1 http: refactor code to clarify memory o=
wnership
 6:  1702762772 =3D  7:  ff5e761e55 config: clarify memory ownership in `gi=
t_config_pathname()`
 7:  18dce492df !  8:  afe69c7303 diff: refactor code to clarify memory own=
ership of prefixes
    @@ Metadata
      ## Commit message ##
         diff: refactor code to clarify memory ownership of prefixes
    =20
    -    The source end destination prefixes are tracked in a `const char *`
    +    The source and destination prefixes are tracked in a `const char *`
         array, but may at times contain allocated strings. The result is t=
hat
         those strings may be leaking because we never free them.
    =20
 8:  667eb3f8ff =3D  9:  eb7fce55b0 convert: refactor code to clarify owner=
ship of check_roundtrip_encoding
 9:  11eed8cea7 =3D 10:  ee2fcf388c builtin/log: stop using globals for log=
 config
10:  d8cd9a05f8 =3D 11:  3490ad3a02 builtin/log: stop using globals for for=
mat config
11:  a857637e61 =3D 12:  6cfc28c7e2 config: clarify memory ownership in `gi=
t_config_string()`
12:  b2f8878b55 =3D 13:  70e8e26513 config: plug various memory leaks
13:  23e2cf98b7 =3D 14:  f1a1c43e76 builtin/credential: clear credential be=
fore exit
14:  a11ce6a0ed =3D 15:  64b92156f8 commit-reach: fix memory leak in `ahead=
_behind()`
15:  24362604b2 =3D 16:  cd8a992f08 submodule: fix leaking memory for submo=
dule entries
16:  c43c93db3b ! 17:  128e2eaf7a strvec: add functions to replace and remo=
ve strings
    @@ t/unit-tests/t-strvec.c (new)
     +	strvec_clear(&vec);
     +}
     +
    ++static void t_replace_with_substring(void)
    ++{
    ++	struct strvec vec =3D STRVEC_INIT;
    ++	strvec_pushl(&vec, "foo", NULL);
    ++	strvec_replace(&vec, 0, vec.v[0] + 1);
    ++	check_strvec(&vec, "oo", NULL);
    ++	strvec_clear(&vec);
    ++}
    ++
     +static void t_remove_at_head(void)
     +{
     +	struct strvec vec =3D STRVEC_INIT;
    @@ t/unit-tests/t-strvec.c (new)
     +	TEST(t_replace_at_head(), "replace at head");
     +	TEST(t_replace_in_between(), "replace in between");
     +	TEST(t_replace_at_tail(), "replace at tail");
    ++	TEST(t_replace_with_substring(), "replace with substring");
     +	TEST(t_remove_at_head(), "remove at head");
     +	TEST(t_remove_in_between(), "remove in between");
     +	TEST(t_remove_at_tail(), "remove at tail");
17:  97470398ad =3D 18:  1310b24fc2 builtin/mv: refactor `add_slash()` to a=
lways return allocated strings
18:  7a2e5e82cc =3D 19:  d4fef9825a builtin/mv duplicate string list memory
19:  b546ca4d62 =3D 20:  797cdb286a builtin/mv: refactor to use `struct str=
vec`
20:  bba735388d =3D 21:  095469193c builtin/mv: fix leaks for submodule git=
file paths
--=20
2.45.1.216.g4365c6fcf9.dirty


--SAZEvFtw1akq3/lZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZd0ACgkQVbJhu7ck
PpTv3w//aFXXEmHi+HRT12TpfJ83HNcIImE097sua+bpMOiQYI6aM8VOJiPXiNNx
a0pCosXo+ColzD4xIrhb58WNFcMVOSOotTORGgsUargibgVcShS7ggoEF1A2IGb2
iMIIj1e0M+oEusDDJAk6fma9kNKB/vaBYkfR2z5AwmvczJANEEoE7sNCn4VoQLqc
EC+zlJDo8fqf1GxGiArVTcK2pVgDJ0deZcbhrMOgsOdB4qgJEIF4uo6Lyola1JrA
a6iO6J+Zw9Zcu+xVLMSbO6fTxuCF+iiKBXm5X/gKsnZpI9+glKbCyVE2ctwQKcOo
PkP3Ikr8IXt1u3ujsdNXi3oCYcBZNRQVg7iHotQPb/8i7oimuNeclROM0ffvnVBo
44PnAXurkMZG4T15YaEj+s2qcm5+nlYEpgz5cOamfBomk76ASy/aAa3xI6aiNywx
ar/GiDIin1jikZGA5GkgvJyJKlCIzHBUugTbYLtk+G2ZLGh0OkmjkUlNpXsZkGvp
CSaFkkpSDh9AD/f4Y0OwoIk2pvG8UI2Fp2Zk0EKhwM3w26FmZOAn84VPfV3bxLJ/
xPMopRGKMpyvVMq3I/jIQYbuhD4BCMy2G6dxVyYOAa4iIfTVp/G66R634FQsOI+v
EB0kR2eMwe3U0O2sJCQqZLC02e/809JFeBSshrPsR2MRUjianws=
=vj/K
-----END PGP SIGNATURE-----

--SAZEvFtw1akq3/lZ--
