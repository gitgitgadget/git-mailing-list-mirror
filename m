Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF4443C01
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929133; cv=none; b=kbWB/oayd05FFDNbaA22buYUyP9fVxUmmEo8CmeKxhYk17htA/6+tjEhehXFWVh+JWtaVdDe4kMGd7ehTBdFaadIFlv3GBqWG04T6w47LC/niuCpCFSzAd5kOpqWj3KkufEHIefvDr2maEC1nSqci2iCQULOgMhuGizIQcJjOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929133; c=relaxed/simple;
	bh=8KFJzDQ6g4c7Zv9dxzKsuhb1+MFHMBH6cWZ400ayc68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C3AVqoNV+FPuwYmQrBwLh292iHW0O5dNRD3IAEdQAnL4OrDfLtVMr08kA97/vj4PUiKI9fnh84OGUG46PlAcn9hxwF/Y8rfQMAnv9mr14BOAHnqVCIMhgmKIO2DRU7KegvNfvzMmRcVojrkCnRuLlRxe1RLGxqvGrijpyLQTZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=K1nhNFMy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fets8hta; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="K1nhNFMy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fets8hta"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C4FDEC0180
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:18:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 04:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1790929130; x=1791015530; bh=DLYo51mSkA34/7+a9Fue+
	QujNoLJpJelcosYS1Ukd8g=; b=K1nhNFMyEhS5NVaoxyPQqf6LsnTE0MrO99pRy
	kajehqWALmkwlbT7RRiEHQFPt+/GFs4nviS8cF+ceDDaMBMX224DIoKd+fBJq+h2
	RfwQZCIQi+bblIL6GeEm/ny03NjGfWReCGuhHnRKD2G4cen00iG7Q4e+w0oDHDhp
	9Gefvb/54yn+mr/Z/KiN43VWdMNgRMgu2mIGN1Aev0MWmtqX1a/z45hurnlcCuPL
	EzYAnrjnOnOyIe9NXJZoIHmfSAqhxwO7RGcLMm3sonq65piiUbXDgNWLUSsFsKNS
	Tb1MGNRSLLio7GBSkko4Y5ld4U/CjEPdbY7Jz/03JlcpOf0FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790929130; x=1791015530; bh=DLYo51mSkA34/7+a9Fue+QujNoLJpJelcos
	YS1Ukd8g=; b=Fets8hta2ktenc8xSfoNAHDuZ8yrTURvy5ZLlB8O9lwHYBu0Ut5
	sD/SY39HQACiJ93pMmpOOL2M3wlBtCIMhK3vfoCU87iNPGB50aR+pJ/8u2tuIHRJ
	SIpblZep8uBgTy/KN43/D38Z4si9BEaR8EnfiTIsrYoGoesGFUaci9yajAZbkHxj
	RfJYuiWiblCN+VXlurboveei3YlZSIgXDd5YN/dRcRZ22QkU1DmGHYTUPYGpr2FF
	4xtZ+b/AmErgTflZ/Z8iajmKT8DT5kiYEbbcaKqLef5I7pVmB+WwrbMD+3gldPiQ
	HU/+sX7sMD9Xa1Kj4Xr/E0cO33AXnyfn2GQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=gitbutler.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790929130; d=gitbutler.net;
	mf=PHNjb3R0QGdpdGJ1dGxlci5uZXQ+;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:T0O7vQlPz/bxRpTTtUKelt7afvCN05EUR/B7NteGDpdVgPq
	tjUJ30IegCuIRAKgdI4Ay/8X+z4Nw+e1SNfxwdML0DqigACj3T90nXKKuSlbytnk
	MPV/p4yZJQYQJ0HOZSfJo67u8iCkbm/xsEfPbifE48OQh/g4gTsioUjZBGj7nGk4
	hzT6tC4ZhHexBSm1v8ZoCU23vm5U1H9v03Kx/9shQbY5fxjPYWKP5ppSVvfTHF1a
	GqlHpYuQoi+G08Q3Ne4WvggF4th4aDoWwQYwk4gGWr04YHPAeQK3vEUXd7/BF63C
	B4O37ePMWt8CXCfZ/69vp+WZHbGl0O4GhDn3ngg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=8;
	hn=content-transfer-encoding,date,feedback-id,from,message-id,
	mime-version,subject,to;
Message-Instance: m=1; h=sha256:SUhqfGjFh1AG549C7KV0fRmu+G+D8vn2UC4qAB73uAE=:8KFJzDQ6g4c7Zv9dxzKsuhb1+MFHMBH6cWZ400ayc68=;
X-ME-Sender: <xms:6mi_atPDBiKfEFg5EdbQOpSkyJ9bOAZsZ2tisyDCkAn8CJwzNTyNjw>
    <xme:6mi_am4H9bdV3Pp1J9d3j51Is0OVwos7CNLavu9kshpS0xG1ITQWuqayS-FBcn7cO
    V0IEqn7c6IC0fHJg6H5jVX3hbnn6R4k6GTtWSL5mhOj1o8OzZmSnq8>
X-ME-Received: <xmr:6mi_ah5pizFz9wU8eu54QN3KfaHicc7F-bjlWlhjzjK9mN95rRcybWWfKsHFrJKU-V1WTFAobtGx>
X-ME-Proxy-Cause: dmFkZTEi26pwbeot6MEyDQaF807JCRDG8hqmIb4B9S6U9dAhHHH1snUi8gMDAxN4YxcS9h
    f30E4Nzj3ns96JZ3AhduUmmClJow0J9CAxybi9RsHQIfm/4vaVmuqjhGgjUAyjY/sNUqYo
    AW7QiEWFq4FGztqtCU1oCGXmmcrB0lg1FsSh1KlxbBtgiBz1B+aMPk7keHABkKAxE2nKEr
    pwVhaXosq22a1K4mLmI1S1QbJsOINF1Me1g69P9SO75Md+/yDSxfJj3VILYJpmxEo1Oire
    +ISTEJHWnsz+o+lexToUNoXUhmJ0Vs4aem1f/bMT4m/xzbfN/8dIX9GDMWU2/x/0oBgQbK
    5vtfpaUaHe1iSyHNpxEMxQc/AQoWFyBFqz6QSfORGt9MwUgFLfFcmcJflRFiKH4kQTpGNe
    iLFyAbEC/t12vTD2BYtypTOT861hDLtRdCz35amTJR/KhoD/HR6FxMSy/PrKsrWlJQbraa
    SPeMvMPZPLWMlPDG4S5hWQXgthgzD3yOJF9O7mLAAgS7oztSYQSxC5POzJqQJKay0s50th
    D/T9+plXUDun+d0yN6J1LMBMtLn19xFurrFT8aWOqOP4ZW+R3vIOgFIffJ6c89SUlhM286
    fVSWrC86e0g6xI1gLrAJDvDsjnBb71wsu8avDtanURA/a3u8mDlzvcTGpPNA
X-ME-Proxy: <xmx:6mi_au026qx1zG4vcU-77u47uR_WzZM5zlKmi6Z-btR8cVv4Dim_pA>
    <xmx:6mi_alVGs9ZYr29XxhUxkRHn-mzPQGG1kxRs-sjsEYr0Ff-XXszzOQ>
    <xmx:6mi_ah49jMmcrC8b9O8lRSkupfI1JhCMHzumiQk6FEci_YLOpjO6lw>
    <xmx:6mi_akIDRjo6_JKqmA2ZWiqfq2H3mYG5u3ujL7pBBxkpPUbhQtXN6w>
    <xmx:6mi_ap8bPuF8Bq6IhYPDmSRi9r_IwTKLomfh-27KuhJQ6rgXezbscw3e>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 04:18:48 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and tags
Date: Fri,  2 Oct 2026 10:18:42 +0200
Message-ID: <20261002081846.25144-1-scott@gitbutler.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm concerned about the ecosystem impact of moving the `git init` default
hashing function to SHA-256 in 3.0. I have suggested that it may be more 
feasible with similar benefits to add the ability to inject an independently
calculated and verifiable tree content sha into signed objects instead.

This RFC series is meant to demonstrate how this might work.

It adds the ability to directly rehash the full tree contents when signing a
commit or tag with SHA-256 without the repository needing to be in the sha256
object format.

In this series "git tag -s --hash=sha256" and "git commit -S --hash=sha256" 
compute a SHA-256 digest over every file in the tree (and submodules) and put
that additional hash in a header before signing:

  object 78bd45828aa36fbde3161f49da15272dff3d06f5
  type commit
  tag v1.0
  tagger A U Thor <author@example.com> 1790749714 +0200
  tree-sha256 775aff90d07c9a73f19ef83ab89bd8e95d1d835325d53cc57a2232b015783d89

  Release 1.0
  -----BEGIN SSH SIGNATURE-----

For a commit it goes after "committer", before "gpgsig". Setting
gpg.treeHash=sha256 makes it the default for everything you sign.

The digest is SHA-256 over one record per file, sorted by path:

  <hex sha256 of content> SP <path> NUL

The file mode isn't included. Submodules are followed into their own
repositories and contribute "<hex digest of their tree> SP <path>/ NUL",
so the signature covers their contents too; if a submodule isn't
available, we fail rather than sign something we can't vouch for.

Old versions of Git are fine with the new header: fsck ignores extra
headers after "tagger" by default (and always for commits), and "git
tag -v" and "git verify-commit" check the signature as before.

  - Patch 1 adds the digest, with a test-tool helper so it can be
    tested on its own.
  - Patches 2 and 3 add --hash to "git tag" and "git commit".
  - Patch 4 adds gpg.treeHash.

From a speed perspective, it's not fast but it's not slow. The default
build on my M5 is 245ms for a git.git signed tag call, ~5s for the Linux
tree. An accelerated OpenSSL build is 135ms for git.git, 1.8s for Linux.

However, this is single threaded. We could easily do parallel hashing which
should make it many times faster - my previous tests in Rust on 18 threads
on my M5 did git.git in 36ms and Linux tree in 0.5s (verified the same hash).

Not in this series, and what I'd like opinions on:

  - Any interest? Would the list find this approach a viable alternative
    to not switching the default hash function to sha-256 in 3.0? Not that
    it wouldn't be an available object format, but that it wouldn't need to
    be the default one.

  - Verification. "git tag -v" and "git verify-commit" don't recompute
    the digest yet. I'd like to agree on the format before adding that.

  - Excluding submodules. Large projects can have submodules that most
    people never check out, and they can't sign with --hash today. One
    option is an "excluded:<commit>" header that still covers the
    pinned commit but not its contents, with a header listing the
    excluded paths so that verification can report them.

  - Naming. The header is "tree-sha256", the option "--hash", and the
    config "gpg.treeHash". I'm not attached to any of them.

Scott Chacon (4):
  tree-sha256: hash the contents of a tree with SHA-256
  tag: add --hash=sha256 to sign a tree-sha256 header
  commit: add --hash=sha256 to sign a tree-sha256 header
  gpg: add gpg.treeHash to sign a tree-sha256 header by default

 Documentation/config/gpg.adoc |   6 +
 Documentation/git-commit.adoc |  11 +-
 Documentation/git-tag.adoc    |  11 +-
 Makefile                      |   2 +
 builtin/commit.c              |  46 ++++++-
 builtin/tag.c                 |  41 +++++-
 meson.build                   |   1 +
 t/helper/meson.build          |   1 +
 t/helper/test-tool.c          |   1 +
 t/helper/test-tool.h          |   1 +
 t/helper/test-tree-sha256.c   |  31 +++++
 t/meson.build                 |   2 +
 t/t1018-tree-sha256.sh        | 123 +++++++++++++++++
 t/t7032-tree-sha256-signed.sh | 169 +++++++++++++++++++++++
 tree-sha256.c                 | 247 ++++++++++++++++++++++++++++++++++
 tree-sha256.h                 |  36 +++++
 16 files changed, 720 insertions(+), 9 deletions(-)
 create mode 100644 t/helper/test-tree-sha256.c
 create mode 100755 t/t1018-tree-sha256.sh
 create mode 100755 t/t7032-tree-sha256-signed.sh
 create mode 100644 tree-sha256.c
 create mode 100644 tree-sha256.h


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.50.1 (Apple Git-155)

