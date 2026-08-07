Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF242FCCA
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099544; cv=none; b=Cwv3YMNJ+l1tWs907Rm1jVh+OEsJm+IlfU4CHPp3q0BY/SyDLJi0idXL3Gi1du4fI6E9EkNeiC4ndhLTZpq0tbPoysAVG//ZIsEjmuQlRfYWsupoc8RZRqPrlj8q0WrV/eG5DV/W2ryBrNkSNH82Bt4ZRNdhnoPVqbIFwn7Zbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099544; c=relaxed/simple;
	bh=+ovm9t7MHg66lx31ACMLzVsUOsMiqJRWTJHfhMFE+sM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i5ORDmdNfCgJTBf7HRm0wjpOTMgi698o3NpCwKfRlIEh0BKK4sqtA+mhSNkz3/beo8BEIE2caaHGqDOQ0Nq0wcrF6DxHVpvcnIRjFgHxHTv4kYcCDr4UUFrlCqQZs3SObbEKv5KMrKf3qMXXxCgme7iGn9j56VbiEmz9ubBdLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZUCSYYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H51GhWXr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZUCSYYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H51GhWXr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D2862EC0171
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:45:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Aug 2026 06:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1786099541; x=1786185941; bh=kkqwdiOLEm
	N0A/l4z7C8TlLbvZP4YZ2+ocKseTJgNjk=; b=jZUCSYYUVsaySS8n/k5fjZ1ICP
	sGSAP97u32JUw7ltwaNpeMl4R5i4magUyfAdHw1kwvib245iL5w/x5UmET4X8NLi
	pDPhgT9c0sIreHeQf5NoGfZW2nCkXs4e63cY5Yt3hUgPPp6dyDOIo8HOZOMEkVAG
	KvHygaB87GtVQ6nc6YMrjcdrm8E+gBqs/I5dsI9EuK1zYSXfz+mUJwbwuin5Zd3K
	qeIu3PQOIPeOoTncwApLRgZ4FE3uPJY1BfAT8jAaw3hcby+4ZnrvNy3Hk7KIV/AQ
	i0S+9f+qPh3B7kR8ttqRrB5vdWQ3/eooMjAXAD27YPql/g2k6Lko/FYm4umw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786099541; x=1786185941; bh=kkqwdiOLEmN0A/l4z7C8TlLbvZP4
	YZ2+ocKseTJgNjk=; b=H51GhWXryM38WwX264LIBU/sGz+0PkrpexH3mHrYrmBv
	zWJzy52P3iLZlL6AYvV32KXs7sIOMET7kYe2MP+MEJK884agKkyv7xZjgj7B+XUp
	EyQGvaG1rBZNRXlcZFcj4yZXXRVV0EokgvPF9wc7XZs+N4IcqiHrKzjuMffWJgRX
	N2aM7/5fvDZsdeo7e/t6hWubU3EasRjxp24NogciHCDnEONIKCcRfxUILtJ7+aOw
	5jkW0Du61CPG4T4QadFY7V91Xy5HxOb14ZkxD7VwSGYJAvmO860Q40ZRx6wB9+Ru
	atm/+xM74r+1X7DC0YdVYwHZe2gHasij5Q6SfBdqhA==
X-ME-Sender: <xms:Vbd1alwR4D3YCp4mDnLmRCQlKgT-JUNd04tI2APVzFTnT-pE525kkA>
    <xme:Vbd1asMgcBfbQgvxlRP-j-a-m8E4oTedOdwyPHDAM5zNlxkbHiNhda5obAlDCdGHP
    lAAC7vXoUe_1XDgla3jxnIMzw1AH9CU1tuNFb04cy2rzvxTvAPNsg>
X-ME-Received: <xmr:Vbd1ak-QE4I41e2Ytx7RqC74lYk6qAzBKAyt0xPdPvLqsQo5KBRXBqmPpO9M0DyhRRc4Tf2ULAbNE3bk1udol9rggdHdhRbCAMKtl2MXF4lyvg>
X-ME-Proxy-Cause: dmFkZTEasdwVJOn4K++jV/+SAWtAmBPK2gQlnJvBVZIc4N8syPY5OJuSe0gUr0AmJsAQu1
    uI9ioZI91Me1Km54GBFFt/5frYS2itksH+YU7f438hEs24epk6TM93tVXrkKOkKN5ufWQ7
    BnKTF2Opeww3t4IKorNu3hzigq+3DEn4OzElObusc0oYKJ1n6yhhZ57klPgsflvZ40o/z9
    arz4ezCHKveU2gC7ZX/uAaHm5ygncOTVYPk/hGtLG1C7pevRqXolZMrqloEELjIqO6RXQg
    O5Ddk16RU0VD620nJaR1uew3kvZNUSwwyrKBxJJv6yvX3qx3jCPueAHEyly17HL8EDAZfL
    impZAkruL6p7CR9ErgtwnXSPQBIvPPNcgbGCUdfjib7vrkhcAAEcGORvDm9Mt+avSmNZt2
    HoaN4yn8TJ92mEZ23ARH1tdMWFvo2BbaZ38fEOpn3cu3xVr8wxITSrgSk4aUvvlPesfskL
    szugyhsGXfV5c9+xm/avuMLkud7GO8dZJO3GAEY73OhiOscZgLeuBZJJHYgZxIozzwIXmn
    TufRnlAC7lp76EajqXh1FDBRb69dgrHKu+nJn9w2UfkVNpCRGZ3jhtSRchWbkt8dIVf7vN
    Dg9CBxf2wBcNRBlkaDQUx+9PQ6Ivqgf/XOihhsZRPuN73TWOoEBNR3D5ZeXg
X-ME-Proxy: <xmx:Vbd1asrsROmFjs3rMWzgdVR5WPJv7T-EI6lHg3LZLEI3mMvxcjlN0g>
    <xmx:Vbd1am5Dc1a8ULxqL-57SGP1OZdpr2g5tBGhXOmm309Hv5PwE39dDw>
    <xmx:Vbd1asN2u6yFhZupsesIqcP-em5HlUuwwE298RyWvQmhXPZrgdhiiA>
    <xmx:Vbd1aoPMR502mje3_x30eVaZP1ldu8o0c598Eb1DaWE8KYIXucDuow>
    <xmx:Vbd1arwC1jHyT2cFTDJLpn_CehuLn75OsyyXUK7XMjn8KJe7b0whBV9q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:45:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b21f1754 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:45:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] odb: make packfile generation pluggable
Date: Fri, 07 Aug 2026 12:45:06 +0200
Message-Id: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTsQW1HxKuIimfxTYyENmSpC6
 d2NuvwW761kqAlGl26lileyNOeG/a4jufs8glNspt71R3d2Jw4HLpPxHAOPyKh+ARcvE+vgNEi
 EDirU8lKh6f1bX29/2zM8IMv3R9v2AdYsi6t8AAAA
X-Change-ID: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series makes packfile generation pluggable.

Note that this series only makes those parts pluggable that are required
for the transport layer. The other parts that relate to packfile
generation as required by our repository maintenance is kept as-is, as
there is a bunch of options there that are way too specific to the
"files" backend to be portable. This should ultimately not be much of a
problem though, as maintenance itself is already pluggable in the first
place.

It's a bit of a shame though for git-pack-objects(1), which still isn't
usable with alternate backends. I tried several times to find good
solutions for making it fully pluggable, but due to the backend-specific
options it's an utter mess. I want to eventually address this though:
same as with git-refs(1), I want to introduce git-objects(1) to care
about all things ODB. And as part of that command we can also introduce
a command that generates packfiles in a generic fashion, without all the
cruft that git-pack-objects(1) has. This is part of a future patch
series though.

The series is built on top of 2c78326f81 (The 11th batch, 2026-08-05).

Thanks!

Patrick

---
Patrick Steinhardt (5):
      odb: introduce interface to generate packfiles
      upload-pack: generate packfiles via the object database
      send-pack: generate packfiles via the object database
      builtin/bundle: refactor option handling for progress meter
      bundle: generate packfiles via the object database

 builtin/bundle.c      |  31 ++++------
 bundle.c              |  68 +++++++++++-----------
 bundle.h              |   3 +-
 odb.c                 |  21 +++++++
 odb.h                 | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-files.c    | 144 +++++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h          |  33 +++++++++++
 send-pack.c           | 101 +++++++++++----------------------
 t/t5516-fetch-push.sh |  12 ++--
 upload-pack.c         | 125 +++++++++++++++--------------------------
 10 files changed, 482 insertions(+), 208 deletions(-)


---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc

