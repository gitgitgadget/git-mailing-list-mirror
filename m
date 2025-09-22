Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073D27FB2A
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575437; cv=none; b=reSt4Qfv2gVaXaox1Bz7mVNDgn4U/hWXmPazaEnfOVQu0SKYNNpTENRWzfNKsL6jFXEAtYqPhdXk5F7UxWiAKU504aBpS33LxunVjTRUpTqhYqYo1TzzJK5Ds+PR+DNMxGoK8z82NgNcsdWmsRJcPhE/mRbUCVDC3n1QNttqNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575437; c=relaxed/simple;
	bh=qGNwm6ScUZx+tv77HcwcLhJxZ2FAU3llwEce/sWkdh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rL9q2qakTpH4VNZ5mUQV2KmRKWmPOH1QM/hYJ80lGkFTTVjPeUmPKZC5Oak+Jn+fcayPiU2qTBvQ5eFRaitlJmmOIRKEECTK+DYMzpCKtGMDLJBXseLiuRJd/YCd5Xp20UTRwfTheN7X24YXykLF7AB18jgZ+02wIdEyaV5cbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KaLI5A89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bfvh9I2K; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KaLI5A89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bfvh9I2K"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E220F1D0029B;
	Mon, 22 Sep 2025 17:10:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 22 Sep 2025 17:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1758575434; x=1758661834; bh=vZ
	F4TrvoIFVzYLxbmX/eymmreEO/aiwcKn7scOPim0Q=; b=KaLI5A89l38O9CRYdB
	IR28Kgq3p7Nn2Guy4F5yjlHxhvVYgARnxgHPZLmjQ0Cif+OoBa6O9hWicSUDNAJc
	PHxl8pZ50ZqlIjULuwDqaPX9KZYGJvJcenIZa+gUCU/gxiL6QlZSAZAbkwr2DgxT
	Vim68LMe/fiJLd+q1P35B501MVIJyZJXSGkRIH2Y9LvDDO/L4vxqYN604bkL4Tqc
	84oQgBUqLsnf2ryb+7lzL4Gq45Fy1P50Qau+PsS9ycFYq603gQ+QzwBl8l3Mr45W
	BLITgzqqfZUjX67YI+viTA5jEWJ9a4vCW/cPF3LWPnsIIBmigpV9n8ghGdb6Ry9K
	YMQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758575434; x=1758661834; bh=vZF4TrvoIFVzYLxbmX/eymmreEO/
	aiwcKn7scOPim0Q=; b=Bfvh9I2KW4tDGL8nyxN4yBoGiwUmRRwPdfN1dzJu0vwi
	zcQcjwHiFSOATSxB3via6GtCQ0OT2puHS9Nk362+Wh14LOLZMDS41sGkCGSepJp8
	9GRJScSYrrLuC2VdEAAKcliip4G7Vr+EIF7tKiBGBZfVv5susZn9AI29u4DHWjej
	gThCY2+jOD6hkAcphnm2t5El+Zze+Vs+39VP73gPsp8fSCboW6mW3GGNnrAxGwID
	Udvd//3811x5I/JX9jrO/gp8z+0hIRVY5HxCR67op0WgJXZkIuiSW6T6piFvAVhS
	ZRPH622k3P8Kpj/KkSDUt8W7ufy7SaR9ZmWX2/voww==
X-ME-Sender: <xms:SrvRaJbda-i75fuuz_AjIYHB7TX1MTUWcsn9M5nWgr6Imy1mVszTAMk>
    <xme:SrvRaGa83RGeZiEh2KinX42DczhWur_pcKfrB1djzdyXgJN-LNSA7xuj20LI1dGIW
    HDDoKnq4niWC3CJkoptTtOtr_kFqd8TsF_CXbzvziPSbHWWSdxXCw>
X-ME-Received: <xmr:SrvRaJnR_SjzNnWBumSAdoHax2OKXdxtxvjHt9-Sgx_b3uwg9VLRZ8-aZsTQ8NQtowPw3I_TlrkUv1e6HQ3HatrcJWFYXLps4sGsQfpJgvm0Ah4Jm53UB_lFMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertd
    ejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhenucggtffrrghtthgvrhhnpeetgfekjeffudeffeffgeekvefgvedvgeffue
    ejjeelgeduhfdtffeikeelfefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtoh
    guvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:SrvRaCz9R40yjPzYb6Z5Bs6DNFal134YkBnvum0UhD_kADt2-pJGuQ>
    <xmx:SrvRaHPRcktPtLqcvkGrAwmsZT-I0TXvPSZniRDbLbBfH6GjEq1JAg>
    <xmx:SrvRaGRrrLWystjnoHoKDyELzzvTA8c3D_H7g5U8YTP7mRCdiuEyVw>
    <xmx:SrvRaFZEqtY_D3oyBbTLF4N_QhVu__-TEMBFEB2ha6suam-VCXjDDA>
    <xmx:SrvRaMxu3bF7T8c3reAVO6uRw7r6MkktVNBP9Gvxnat0TrR98AMBF0wW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 17:10:33 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/2] format-patch: handle range-diff on notes correctly for single patches
Date: Mon, 22 Sep 2025 23:10:21 +0200
Message-ID: <cover.1758574974.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.270.gdb73cbc1bc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) does not handle Git notes correctly in the
range-diff output for single-commit series.  It reverts to the
default behavior of git-range-diff(1), which is to act like git-log(1).

Fix that notes handling to always output the same notes (namespaces) in
the two positions:

• beneath the commit message; and
• in the range-diff.

Do that by (patch by patch):

1. Refactoring to use a new `ref_info` struct member
2. Using that in `log-tree.c`

§ Testing

I have (for once) tried to check for leaks by running the test suite
with this `config.mak`:

```
DEVELOPER=1
DEBUG=1
CC = ccache gcc
CFLAGS+=-O0
CFLAGS+=-ggdb3
USE_ASCIIDOCTOR=true
SANITIZE=leak,address
```

Kristoffer Haugsbakk (2):
  revision: add rdiff_other_arg to rev_info
  format-patch: handle range-diff on notes correctly for single patches

 builtin/log.c         |  7 +++----
 log-tree.c            |  3 ++-
 revision.h            |  1 +
 t/t3206-range-diff.sh | 16 +++++++++++++++-
 4 files changed, 21 insertions(+), 6 deletions(-)


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.270.gdb73cbc1bc1

