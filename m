Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDA181338
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986651; cv=none; b=NRO6uxh5RtP2hkA5T7JUEJwMxQrTlQ/v3mmuMPE83EvLXrxTcPkHMLVwsGeUbcS5W3KUEC21HIYYO0KSa6bzXcwiZT/bA4xy/06T5QMpjgRIytY5mnE3ZYGrkPsRDa9WLN+TIXr0qWLefXWNB5/xkemeCbQhFwAN48WdWsnncuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986651; c=relaxed/simple;
	bh=Gz4sllBosLvnqCrBcIVbeJrFLwVx6ZhNqRMr0tAHuSs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HTfXOa363ymvXfkin4QKDBQOYWzC2WBj0tHjdGqPB/2ANY0qhnbJUaNa53P/c1DNgCSEek6e/CzWIvghP38ZfDw2TF/N8+55+X574IWJ7U1jYkFFuoDyub6vfeHERT63HkHdjYG/fy5Urrrck8qyddqGAX7X/NpMtevVzP/DQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3CU1phE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MzlQr1H4; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3CU1phE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MzlQr1H4"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 815F71C00111;
	Wed, 29 May 2024 08:44:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 May 2024 08:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1716986647; x=1717073047; bh=kw6rICi2fAxfRbsCMtk8a3Gb8l0oAjbf
	Mv/KH9MKcpE=; b=V3CU1phERnbGmf+p6YIQR56pvCd3dE6U966E/DQfqKgNGyUB
	utZslC8U7X7FEC8x2sVQQEz8rnxllXAkDF4I8O9PR7C+4lXw+4hpcWW9TI2Lo6NM
	Y2/8dLGx7FLVEBMQmh8tmy6Tk5zceGIqVdJYDb3ODmS2WWyyEZb6rq1bSVzqkn6y
	5uiw4aAJ2rlLRQh4cOnD/JU6MXgD8HcPEOIEqRFQQoNwgd9CGBRVL6CWsE8IxgY4
	CkEFs7tVlJosyNpHMfswTPGaZTOX42+jAMvoEwZwCiK8457kH+mZSTVl519NV0IV
	rgZnqDsPWNEUEV1w8i+mRS4HecUPFoUIyQiBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1716986647; x=1717073047; bh=kw6rICi2fAxfRbsCMtk8a3Gb8l0oAjbfMv/
	KH9MKcpE=; b=MzlQr1H4Gzhi5Qiw3uZOzpz0i6x/skdCupnVg5PRSgKIrdP8FYc
	4qKmRiI1AMSO0Dbx88W9V11uoo/K3z4RHhGf0c+9yRWuIibzWj1vRSmFf8OKjJoQ
	ix0sNcw4588GSTzDJFnUOFyumZpiq/GKipAXrnhQi5RnkCJiuIhZ6JvsRydo+qPb
	XrAnM5ykUzDSYz2srpB9n0f0fnq16x3xEfPkhout+9h0pQynBJUKyns98kYNIo1T
	wtizDp9xcH21wTy+3Ef2Q08D7K7JKeMABNKWe2L3n/fq58w75nHNOeuxyY9t+7UK
	3WishCXaiW1hk2CJb7KRBwwviNRmKy4R6lw==
X-ME-Sender: <xms:FiNXZh75szqZitgpblzal9XPMeMVbtht2O41bmFyWsNKxSu2DYSqgQ>
    <xme:FiNXZu4hEKROwBldNBhT2iHD0DEflYn01OTKl886G8XJVetAR4xcHELmKZ6davM4u
    _Hour7CJ1Q_musK7A>
X-ME-Received: <xmr:FiNXZoeeIvxvpav_PtKDywCB122KCY_zMreRWjvP-C3w_L_60DKxBeKiovDGp0nsW7g5sK5BqKbrnvbfm9EXfOMs4zzFvbnlVhUHzzRFTqBtjkY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeiuefhveettdehkeffiefhjedvheehffekue
    ejtdeuuefhtddvteffffejhfetteenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhg
    ihhtlhgrsgdrtghomhdpmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FiNXZqI1gvDf5dCiqOcZeFrxCKG6RWrYy0DqMQKZwIBJNyihSUXQ8Q>
    <xmx:FiNXZlImPI3jLZY3vqB0cWKJlRgjDWj3PYNHbv9z7IGTIH6Wh4l2UQ>
    <xmx:FiNXZjyZiB34UAi2FXzJ3b2i5hTN-BdtoI3_Fd4hwqPDewSFqv0fIw>
    <xmx:FiNXZhK4wgps9Bo-asGTeFkihJ4NGOFx1dfFM-_r8JbNXkD9XNcSrw>
    <xmx:FyNXZsXrMsXU7srj9ejFfWwdmnKA5MXx-_mqrDLn9JEJds_h8Fdz8lfY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 22c96ab1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:43:49 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 00/19] Compile with `-Wwrite-strings`
Message-ID: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxLoxtNJPLkr2LKH"
Content-Disposition: inline


--uxLoxtNJPLkr2LKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

there were some recent discussions about compiler warnings and how to
stay on top of breaking changes in compilers in general [1] and about
string constants in particular [2]. This made me look into what kind of
warnings we should reasonably enable, which led me to the following
list of warnings that may be sensible:

  - `-Wformat-nonliteral` to warn about non-constant strings being
    passed as format string.

  - `-Wwrite-strings` to warn about string constants being assigned to a
    non-constant variable.

  - `-Wredundant-decls` to warn about redundant declarations.

  - `-Wconversion` to warn about implicit integer casts when they may
    alter the value.

This patch series adapts our code to compile with `-Wwrite-strings`.
This option will change the type of string constants from `char []` to
`const char []` such that it is now invalid to assign it to non-const
variables without a cast. The intent is to avoid undefined behaviour
when accedintally writing to such strings and to avoid free'ing such a
variable.

There are quite some cases where we mishandle this. Oftentimes we just
didn't bother to free any memory at all, which made it a non-issue in
the first place. Other times we had some special logic that prevents
writing or freeing such strings. But in most cases it was an accident
waiting to happen.

Even though the changes are quite invasive, I think that this is a step
into the right direction. Many of the constructs feel quite fragile, and
most of those get fixed in this series. Some others I just paper over,
for example when assigning to structures with global lifetime where we
know that they are never released at all.

I also have a patch series cooking for `-Wredundant-decls`. But while
that warning detects some redundant declarations indeed, it creates a
problem with `extern char **environ`. There is no header for it and
programs are asked to declare it by themselves. But of course, some libc
implementations disagree and declare it. I haven't found a nice way to
work around this issue, but may send the patches that drop the redundant
declarations nonetheless.

The other two warnings I haven't yet looked into.

I ran some test jobs on both GitHub [3] and GitLab [4] to verify that
the result is sane.

Thanks!

Patrick

[1]: <xmqqbk5bim2n.fsf@gitster.g>
[2]: <20240525043347.GA1895047@coredump.intra.peff.net>
[3]: https://github.com/git/git/pull/1730
[4]: https://gitlab.com/gitlab-org/git/-/pipelines/1310156791

Patrick Steinhardt (19):
  global: improve const correctness when assigning string constants
  global: assign non-const strings as required
  global: convert intentionally-leaking config strings to consts
  compat/win32: fix const-correctness with string constants
  reftable: improve const correctness when assigning string constants
  refspec: remove global tag refspec structure
  http: do not assign string constant to non-const field
  line-log: always allocate the output prefix
  object-file: make `buf` parameter of `index_mem()` a constant
  parse-options: cast long name for OPTION_ALIAS
  send-pack: always allocate receive status
  remote-curl: avoid assigning string constant to non-const variable
  revision: always store allocated strings in output encoding
  mailmap: always store allocated strings in mailmap blob
  imap-send: drop global `imap_server_conf` variable
  imap-send: fix leaking memory in `imap_server_conf`
  builtin/rebase: adapt code to not assign string constants to non-const
  builtin/merge: always store allocated strings in `pull_twohead`
  config.mak.dev: enable `-Wwrite-strings` warning

 builtin/bisect.c             |   3 +-
 builtin/blame.c              |   2 +-
 builtin/bugreport.c          |   2 +-
 builtin/check-ignore.c       |   4 +-
 builtin/clone.c              |  14 ++--
 builtin/commit.c             |   6 +-
 builtin/diagnose.c           |   2 +-
 builtin/fetch.c              |  11 ++-
 builtin/log.c                |   2 +-
 builtin/mailsplit.c          |   4 +-
 builtin/merge.c              |  18 +++--
 builtin/pull.c               |  52 +++++++-------
 builtin/rebase.c             |  16 +++--
 builtin/receive-pack.c       |   4 +-
 builtin/remote.c             |   3 +-
 builtin/revert.c             |   2 +-
 builtin/send-pack.c          |   2 +
 compat/basename.c            |  15 +++-
 compat/mingw.c               |  25 +++----
 compat/regex/regcomp.c       |   2 +-
 compat/winansi.c             |   2 +-
 config.mak.dev               |   1 +
 diff.c                       |   7 +-
 diffcore-rename.c            |   6 +-
 entry.c                      |   7 +-
 fmt-merge-msg.c              |   2 +-
 fsck.c                       |   2 +-
 fsck.h                       |   2 +-
 gpg-interface.c              |   6 +-
 http-backend.c               |   2 +-
 http.c                       |   5 +-
 ident.c                      |   9 ++-
 imap-send.c                  | 133 ++++++++++++++++++++---------------
 line-log.c                   |  21 +++---
 mailmap.c                    |   2 +-
 merge-ll.c                   |  11 ++-
 object-file.c                |  17 ++---
 parse-options.h              |   2 +-
 pretty.c                     |   7 +-
 refs.c                       |   2 +-
 refs.h                       |   2 +-
 refs/reftable-backend.c      |   5 +-
 refspec.c                    |  13 ----
 refspec.h                    |   1 -
 reftable/basics_test.c       |   4 +-
 reftable/block_test.c        |   2 +-
 reftable/merged_test.c       |  45 ++++++------
 reftable/readwrite_test.c    |  47 +++++++------
 reftable/record.c            |   6 +-
 reftable/stack_test.c        |  65 ++++++++---------
 remote-curl.c                |  58 ++++++++-------
 revision.c                   |   3 +-
 run-command.c                |   2 +-
 send-pack.c                  |   2 +-
 t/helper/test-hashmap.c      |   3 +-
 t/helper/test-json-writer.c  |  10 +--
 t/helper/test-regex.c        |   4 +-
 t/helper/test-rot13-filter.c |   5 +-
 t/t3900-i18n-commit.sh       |   1 +
 t/t3901-i18n-patch.sh        |   1 +
 t/unit-tests/t-strbuf.c      |  10 +--
 trailer.c                    |   2 +-
 userdiff.c                   |  10 +--
 userdiff.h                   |  12 ++--
 wt-status.c                  |   2 +-
 65 files changed, 410 insertions(+), 340 deletions(-)

--=20
2.45.1.313.g3a57aa566a.dirty


--uxLoxtNJPLkr2LKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIwsACgkQVbJhu7ck
PpRh3w/8CBMVu1iw/AcaUxJ6Kwq/LuWijeJDYXqrP17WO8HnVV1nAiwArvqubnQH
NXSS+xdtCAGg027VEj8CC33nqWE756h2TecvyPpRe3QKk/a7zGrD4ObAhaieFmHT
SVX3EaFn9/eMiCLMdpcaTMZFHXo7L1SkHcNYcmYoEL9A9ANvETcntzgIsN/gSL1E
jZwyUbFV4b/JD6NwxnrlHYK0mvNRGCgkpgVGQVz3tG/qttgdDr7yXlukr67B2axk
AHaEiyxFsMa86TjzXCnOQPR/gyQTYFhFXB938kBBeJWq//5p9rlmqHIHSNNJieHe
MWlSFracCyI9kxZ0qmd+Tu1MzwpjV2IclmRiqQXBmOrOUFEIryzVV4MEMIA+yOtO
NsF8zhyKqfFBAtDR0EFJb+Ob47kPkFmXvbo023wtxodYPjvDYzn2pz9W2yGK8v8p
7etXu3i6qfW6neajK1QC3jsPz5xqeo/z86Su/5myIDnUYm9a4C2QFf4cIgVDaUFC
hjq/KoGzmADTxyh7hFwQPLMRW+8Yk9yCPXbsWldtFLkbtYIF0sxRwIT/Hbz9h/37
RL9mFDoxjGBL+M29xluC1+SVX6HG1pbSWkYQT5B2y3Ve0vBETG10JMLVwDSN0tah
T6yo4OtFjCw3gmdeL6+4vpl5qbRQ3rVzZeGOmiiDSfCs0Ehik2c=
=aoNb
-----END PGP SIGNATURE-----

--uxLoxtNJPLkr2LKH--
