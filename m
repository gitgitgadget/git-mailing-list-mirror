Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E413B5B1
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467118; cv=none; b=q2OKb1Mo+2WNFaclxGebjNaAgRRbOCgln+mS4QyfBypYWWJHmEmHVl9Iqgkm7p7iyrRcE62qRa6vt3Ncyu7+vkfg7wBES7U/p8TW9WRQBTpe4SFLs27aCbjOI6EYREiohy27GZOQ5f+oHtYCgKlgkbDVCVeQQ3wgkctWcUoaaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467118; c=relaxed/simple;
	bh=JX6lUt55TW2aL171yh+ygAZoGZ/1opY67AansrFnyPY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pe1N3JNIBFbh5W3MNoG/nqSqr8DvcKur0FULLdYNVzibC/E4PbVMkpQoH/f24P6B1g8AYqG1krd7d+Y9JVhSKx9FKCSSGFziMo5x4iho0Dr64gzM1PDS64yt0h1ydgYw+i6kirMIFd3XTZgVjGE0RyK+iYmrWNAonlGJjzF5hPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e12hIydL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eavn04WX; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e12hIydL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eavn04WX"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 40DC81C0012D
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 May 2024 08:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1716467114; x=1716553514; bh=2/cm5APjPGhQ/Mo3urvgIWlSMZczll0d
	WkhaLj6ezPM=; b=e12hIydLNWDR3vdVav3O93LFfO6IXynwWc0Ip7cOUtsdxqA/
	HYSXh6VzSELuW/lq67wHQMX11IxeRSCyuk4YD1o03OqYxo9IUWrN7xBngn43J6xv
	sjvZSI4zNGGWCg4qpstQoyCkfKMF/Y/oyHrYyOP2D55eVpjwZH4onV/NGwFFw9Jj
	wSYRxpuaxDtfTHjsl43g01833an4qjOnfjMXlvIYEue3jsINbGfC5brUhQacPI+C
	h5INmP7HxusYukz9ASSjSkLyRrfttb0j7HIuMdG8xsoUS2S5pxjaHegU0r94deuJ
	lWWNLTAyhaZ1AcyVuVGIUqn6jeHJDvcxJlDd4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1716467114; x=1716553514; bh=2/cm5APjPGhQ/Mo3urvgIWlSMZczll0dWkh
	aLj6ezPM=; b=eavn04WXoOXXfrFP8GiQ0Pp6tF40NmW/p4m3kdRGtlX9CrtV0nC
	POgLMUQuPpOUSpeRBIfj0SNj2BPRwbEwE54DrjPokCQBPlVg2yCPw9Ls8qtld8pd
	lYYTxvhG6OVkDcGAfOig7fI6M7zh2PSsEWoSZ5tgGVJJFUSM2EBJjS/LrqKl43ZO
	QEdj0Xms2F4P4ON4+OaOw+UhWdi15tRlawk6k/5eBMiTurxehB6rosiOZ+7HqTO1
	H9TQmjxA1bkVhLZPZ5zg4duUk8UxKx0jnOF3Jz3fOq8bTohsetDHEEet9/mRIS+K
	EPaU1tYFpivXMaHzLii/l8RbASBW7MwNw/A==
X-ME-Sender: <xms:qjVPZqo1zHUgyClR0UrXgpXZCCqYBYgSIYu0fHta1GMkmgQLwcrDxA>
    <xme:qjVPZoqx18w_MCvplM0S5BsXA4iL1vsFPuyXCikjo_oscPYtdEvLJI1rXauXh3N2G
    WGYjAw7lbIc3nQH8g>
X-ME-Received: <xmr:qjVPZvPr8E_aDD6GDD6UzIRYYVHQI6iydaD894lNGflbjp8aIwPtVzhtiCrjdsoLouME_upES5l9e-DrkVJJ6N5QGuhSTjTTbcvc3sbPrRpfW1NGfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeefteefgedtheekgeejheeuheelieekledvve
    dvgfetueeluddvledvleetgedtnecuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhp
    qdgruhhthhdrshhhpdhhthhtphdqphhrohighidrshhhpdhhthhtphdqtghurhhlqdhvvg
    hrsghoshgvrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:qjVPZp40eADes_qNH99gPZI7QhQe9yTFVmzBtbEZQPXpJOsjcUE3pw>
    <xmx:qjVPZp4fYPRmFVebjt65bWV5szJAPsfYaFK4WuONWWmIpNrcA9FkEA>
    <xmx:qjVPZpgG5BNToMKDDfMnzHGvrA_eujrdo7AnhMJq_lWBciKrsXIOLA>
    <xmx:qjVPZj7wwKyCr0ciagm2pRw5dOXhAE6lYvlHoSgAFRiQmnD0GtdAqQ>
    <xmx:qjVPZrT1WZDyu6Nil2CYtlOtk_dIaJ_qaL_8bbAilUuFRFjRdJkMC-7b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1dacf882 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:05 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/20] Various memory leak fixes
Message-ID: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BIzuCUL3Pfc2HCcM"
Content-Disposition: inline


--BIzuCUL3Pfc2HCcM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

my mind had a couple of minutes where it was roaming, and of course it
immediately searched for and chased down the next rabbit hole. The
result is this patch series which fixes a bunch of leaks all over the
place. There isn't really any structure to the leaks that I did fix --
it's mostly things that I stumbled over. In the end, this series makes
another 56 test suites pass with leak checking enabled, 13 of which have
already been passing without any changes.

While most things are unstructured, there are two topics that stand out:

  - Patches 5 to 12 address a shortcoming of our config API. Both
    `git_config_string()` and `git_config_pathname()` have a `const char
    **` out parameter, but they do in fact transfer memory ownership to
    the caller. This resulted in a bunch of memory leaks all over the
    place.

    These patches thus refactor a bunch of code and then ultimately
    switch the out parameter to become a `char *`

  - Patches 16 to 20 have the goal of making git-mv(1) memory leak free.
    I had a very hard time understanding how it tracks memory. I think
    this wasn't only me, or otherwise there wouldn't be calls to
    `UNLEAK()` in there. In any case, I decided to rewrite the arrays to
    use a `struct strvec`, which makes tracking and releasing of memory
    a ton easier.

    It does come at the cost of more allocations because we may now
    duplicate strings that we didn't before. But I think the tradeoff is
    worth it because the number of strings we may now duplicate is
    bounded by the number of command line arguments anyway.

Thanks!

Patrick

Patrick Steinhardt (20):
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
 t/t4153-am-resume-override-opts.sh            |   1 +
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
 t/t7006-pager.sh                              |   1 +
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
 t/unit-tests/t-strvec.c                       | 259 +++++++
 t/unit-tests/test-lib.c                       |  13 +
 t/unit-tests/test-lib.h                       |  13 +
 transport-helper.c                            |   6 +-
 transport.c                                   |   1 +
 upload-pack.c                                 |   2 +-
 userdiff.h                                    |  12 +-
 110 files changed, 1141 insertions(+), 584 deletions(-)
 create mode 100644 t/unit-tests/t-strvec.c

--=20
2.45.1.216.g4365c6fcf9.dirty


--BIzuCUL3Pfc2HCcM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNaAACgkQVbJhu7ck
PpR83hAApuEzXrs+F2PlE1fAENDq30PIRjLkYy1CxOuRKhlZIsTCyFh35rESD4Zk
RXRLshxw/FvDWv+uKvMdKDeulZshGLLTQPkO12pAiCSnHrOUjorqzP0p4erSO0DU
tdPdWJZCv+UPWVP8A+Y7RX5qZ024w9NFbCLSFf+J2yy684N1TdciIYgPia9ZyN2D
RDBGSC5RcIiBoCg8lA0lnGWvNaZ++KRKNjLhf8NtEYbipPznpQxaD21qdzS9LAcL
IrsHgPucoSJTkISaW0xeY45D4Pbyl6uzGsxn6T5uEGUMLZNt0/nqCkzwANQvvfPS
URLOk4wKPRv71kMxqx0IzPYWARMIGB5BVbe2/2GFe+ZQ2ckDP85ELjt/UZB4gvGo
JwMIzWRoDVG3QIf3NIcBPSVyNSff2i/YQeh+lWwas6K8lcs30GSB3F/GVBR2ep9N
ZnPgGyP/89Z5vPtelMGzjsOfpYXWeP3j4BstHxy06l8CRWIDTyIrgbvFN6knqhVb
GjlglIvWmqYk7rwVJiWyl3lAHUwVBcVlLpsI1M8SLDvTJZWjv89NPDVIyKLM0UVA
KVuCSZ2w14LaIdzqO8P+mArC0x+1U3WnnPgYEc0r1n/0KZ9lMqfBWHQEx1DYrJ/q
rRHTRj6fLhvtonRaFrOt75qNkTKSlenMUFQeHlBp6T6gtfcXtVY=
=+Dgn
-----END PGP SIGNATURE-----

--BIzuCUL3Pfc2HCcM--
