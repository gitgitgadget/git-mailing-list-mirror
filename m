Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B31198A32
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013811; cv=none; b=kdB4Pi88aDeRNAWi5vlVm/+WXKKI6fQogbnhlRDqEG96/0rrAC5UTH9YSZly1jTMIp845Rk3OBnZ3KifuF7toJBfzr9H4zgtc5kq0xcqb2iyIRWo6a/kDl+fsFG4s758xFi2R6b5F7jXqgiHSnNoYe0slj2UVWZJSm+5m0loOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013811; c=relaxed/simple;
	bh=1lvzzgyAmiGn9+Vd/xLokbyY/UVV/yMyhzzBDcycrYU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kjhkhKjyLu9bliReRMFxewC9qm4vbuKQVCX3H16ElfNWf3pknOpc3TrvqRTU9ur/AaE1LqQpPhJ8G4LqOpn0EWCtM0Ax06JjEQJUR4KoTG8HjGjg9S8MBmZ5AD4d82d63oLMJhbr5xdc7WQJ/RECiwiEpH/oWd9KSLxXe/2WaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q729hhNr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GU+UcGhc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q729hhNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GU+UcGhc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 85560138CDF7
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:56:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1723013807; x=1723100207; bh=+gryIF20qWjwLvm6mqOPgQ1BteRQ+ls7
	hBlJUXyxeiE=; b=Q729hhNrSYLnyGUYyIKKSxMF/sCnS7bZwup2lIxz27mAq/Gu
	oZkeBKTBh+ApZtUKRsqEjVrMLyQiETh9IadwJ55TMCtf9CrmiHHs36Z/pw4epJ5b
	36cPfvoLSy9ykMk30uzkFhaeL7AMdNYm6MaGV23gZ/OiUFP7O6PA9JR0b/lC9zXy
	zwdqJxSsORlmBHpF5g8aLUxb4gab3Aouu1gP3cEtQohJomR0Bipv8EMUW690SWse
	ezdGNUeNEzvIaqk43ObVarOQWFRJGsX0B9ZUgQ0Kd/NyZOilJ8U2YTbL7IfnIFSV
	yqJoADliUTfLGfCV4yMuq2yT5S2W3C7KKfMXYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1723013807; x=1723100207; bh=+gryIF20qWjwLvm6mqOPgQ1BteRQ+ls7hBl
	JUXyxeiE=; b=GU+UcGhcHSQRuc5KEa6EpGJrvBNFTsMhBV6IEVMEr1PfNSNF7M7
	CRklkRJDANX8Z4zbI/aWXHJZr5C4ghsKnPdLEK8s7CKYIIZHwfrBz5Yh2i+vk0h2
	DkVzCMHWFaBf7wyQI2+XVE3z04xA7m0zEtmmqFgkz3+gHR01I1RS4NA8SPyoXH7N
	oojKTynDoWVcnwkzxlg6llnrd32BLcRZVRjTZGfZbm6oG75twhfWhYRyh1UMrYui
	FNqhULdHxbzXvqGHV8xFJ5bs82ubeEVsGO7n6M3GBuqw4zXT9MR8jwq/OSzjp7s8
	Rx9hgzXNlgGGTQyF5dUOxauX1lJ/o69EBsA==
X-ME-Sender: <xms:rxqzZvinv2ezjkNqrtWL1MFRhPPQlSvCnpvKbGc5eSyVe7hnkKIi3A>
    <xme:rxqzZsBwGY5Qt1E6Jun4ceBY_OlV4g1hKAMIaxqfrZgWFpw7Rvag9o2-P0SQqM0Z-
    E4epVbtAIHN824T1g>
X-ME-Received: <xmr:rxqzZvHZgcRiyu3ijTg9RUUF7VGiT-Gkf2mmYiF2KrTPkLn6jO73LVYR1uHAe36eeGLA9_2Qew_cRWzmSlPZdbFlkgvwXWwvMONelmzuGOXBbmLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:rxqzZsS9J4JKXqGKMGCepsUG5hZq-v3ShBOBrZ3tCn-KyTKttDj_0w>
    <xmx:rxqzZsyoXUTwUG3-blq2EMw7xOvT-kin1eq8-vqY-Q1DSSqYg0ByFw>
    <xmx:rxqzZi7DfkYdC8oFM6YUTEfeQEWpLk11gCytzTDYRQZGQGYG_saCmA>
    <xmx:rxqzZhwAWixMO5DTTVX7UZGnMVQASohFJbh2vx4M19DZ8ksoCO-1NA>
    <xmx:rxqzZpo9p7oNfd6h2fayUdGQYwG4gUPsktKFBkfEesTtsX75DMGOG0F5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:56:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 542a595c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:56:40 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:56:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/20] Stop using `the_repository` in "config.c"
Message-ID: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kcn+gO5LGPwA7tJh"
Content-Disposition: inline


--Kcn+gO5LGPwA7tJh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I found that there had been a bunch of callsites in code
not marked with `USE_THE_REPOSITORY_VARIABLE` that still implicitly
relied on `the_repository` due to calling interfaces of "config.c".
This patch series has the goal of fixing that and making the dependency
implicit. This is done by making "config.c" stop using `the_repository`
while moving its interfaces that do use it into "config.h", guarded by
the `USE_THE_REPOSITORY_VARIABLE` macro.

The series is structured as follows:

  - Patches 1 to 7 adapt "path.{c,h}" to become `the_repository`-clean.
    This is required because "config.c" relies on the "path" subsystem
    quite a lot.

  - Patches 8 and 9 introduce functions that take a `struct repository`
    where we didn't yet equivalents for the repo-less variants.

  - Patches 10 to 16 adapt various functions to take a `struct
    repository` as input.

  - Patches 17 and 18 fix up some functions that take a `struct
    repository`, but still rely on `the_repository`.

  - Patches 19 and 20 then hide config functions that rely on
    `the_repository` behind `USE_THE_REPOSITORY_VARIABLE`.

The series is built on top of `master` at 406f326d27 (The second batch,
2024-08-01) with ps/refs-wo-the-repository at 9d36dbd1ff (refs/reftable:
stop using `the_repository`, 2024-07-30) merged into it.

Thanks!

Patrick

Patrick Steinhardt (20):
  path: expose `do_git_path()` as `repo_git_pathv()`
  path: expose `do_git_common_path()` as `strbuf_git_common_pathv()`
  editor: do not rely on `the_repository` for interactive edits
  hooks: remove implicit dependency on `the_repository`
  path: stop relying on `the_repository` when reporting garbage
  path: stop relying on `the_repository` in `worktree_git_path()`
  path: hide functions using `the_repository` by default
  config: introduce missing setters that take repo as parameter
  config: expose `repo_config_clear()`
  config: pass repo to `git_config_get_index_threads()`
  config: pass repo to `git_config_get_split_index()`
  config: pass repo to `git_config_get_max_percent_split_change()`
  config: pass repo to `git_config_get_expiry()`
  config: pass repo to `git_config_get_expiry_in_days()`
  config: pass repo to `git_die_config()`
  config: pass repo to functions that rename or copy sections
  config: don't have setters depend on `the_repository`
  config: don't depend on `the_repository` with branch conditions
  global: prepare for hiding away repo-less config functions
  config: hide functions using `the_repository` by default

 add-patch.c                       |   3 +-
 builtin/am.c                      |   9 +-
 builtin/branch.c                  |   7 +-
 builtin/bugreport.c               |   2 +-
 builtin/checkout.c                |   2 +-
 builtin/clone.c                   |   2 +-
 builtin/config.c                  |  16 +-
 builtin/count-objects.c           |   2 +-
 builtin/fast-import.c             |   4 +-
 builtin/fsck.c                    |   2 +-
 builtin/gc.c                      |   8 +-
 builtin/hook.c                    |   2 +-
 builtin/merge.c                   |   2 +-
 builtin/notes.c                   |   2 +-
 builtin/rebase.c                  |   2 +-
 builtin/receive-pack.c            |  10 +-
 builtin/remote.c                  |   4 +-
 builtin/submodule--helper.c       |   2 +-
 builtin/update-index.c            |   4 +-
 builtin/worktree.c                |   6 +-
 commit.c                          |   2 +-
 compat/fsmonitor/fsm-ipc-darwin.c |   2 +
 compat/precompose_utf8.c          |   1 +
 config.c                          | 225 ++++++++---------------
 config.h                          | 285 +++++++++++++++++++++---------
 connect.c                         |   2 +
 credential.c                      |   2 +
 daemon.c                          |   2 +
 editor.c                          |  14 +-
 editor.h                          |   3 +-
 fsmonitor.c                       |   2 +
 gpg-interface.c                   |   2 +
 graph.c                           |   2 +
 hook.c                            |  21 +--
 hook.h                            |  13 +-
 imap-send.c                       |   2 +
 mailinfo.c                        |   2 +
 merge-ll.c                        |   2 +
 parallel-checkout.c               |   2 +
 path.c                            |  97 +++-------
 path.h                            | 167 +++++++++++------
 protocol.c                        |   2 +
 read-cache.c                      |  22 +--
 refs.c                            |   4 +-
 refs/packed-backend.c             |   2 +
 refs/reftable-backend.c           |   2 +
 rerere.c                          |   4 +-
 reset.c                           |   2 +-
 revision.c                        |   2 +-
 sequencer.c                       |   6 +-
 sideband.c                        |   2 +
 submodule.c                       |   2 +-
 t/helper/test-advise.c            |   2 +
 t/helper/test-config.c            |   2 +
 t/helper/test-userdiff.c          |   2 +
 trailer.c                         |   2 +
 transport.c                       |   2 +-
 versioncmp.c                      |   2 +
 worktree.c                        |   2 +-
 wt-status.c                       |  14 +-
 60 files changed, 564 insertions(+), 455 deletions(-)

--=20
2.46.0.dirty


--Kcn+gO5LGPwA7tJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGqoACgkQVbJhu7ck
PpQnUg//UpUDHPTC+Xd9tZWUncTN1/17Se3ra4OSKLmGEak6zaN9bZI8oL5BKu9F
mJRh7hQV16O+zDYx0JnRZJ3yx8QdKRbSCJpGqT46UwCGWI0Upo4M/eqbhcxmsfGz
BWc9niOoYKaXUroWl+IFietSMOi9RZ1t7i46LnymoBmu0Auba0XH+HynTYhHRX4h
x/sJiTD9oZCI+TrO6QsFC+el8QSz4WzF5Nl991FPKTg6ZAVsmhP6zhpT5PCDvJim
xwYmD7vA/W14Gprs+eRSHlDjSYvOb6fdDYKqqR5bxbXwknQp6cg+0cleRfSy4Fc+
SGfXbs4pbVI6v3dgtlMUIB6BYMi2Ht1nAGkAgGhUyxycCgi5MUXtiRGzyCEZpgo3
i+pH+Gx8IiafVSEn+j94K4h7zxfbBto8qYVXcU8s3JamQEvUdK/slOZXDO+XjizK
wKaBJMUYN8BhgWuaFLuV9hEcYmv/CvP4fHqR66hUZ0x6Xkxy7Fe9CS/t/bJu2pSQ
Qmh+Tfd7TLaQRauwQKmDbMMD/Lu4DpvfL0NegAQsGTh3ohMR/Rihd/8hvWDgV+zd
n90/4MQIs4zXHam6uQgeRcl761+DJJSBkkgoQADH1Vm1YeCQ4KwQZ3LcjjMG0AaJ
npHozzmhBSQuXD62bp6YOz60izpXSZlMkf0GUxKf/gUv1kyi3Ls=
=gOpl
-----END PGP SIGNATURE-----

--Kcn+gO5LGPwA7tJh--
