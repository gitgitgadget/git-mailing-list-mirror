Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66A30AAA6
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863487; cv=none; b=us2j6paVGSWYZIIFbx47eTleZoZxL/hqS+BaWqp3ESQolCV3qBdhRwKf+IlABF5xTUbJo7Xme1lJk5AZGxF+5znN79OB7Jk6FUnm7f7l2UHr8ukUcVH33FIoXWgVRlYqqgZ2/+lWNT+FZA4EqN56K4EOujhyEhwi55R9InIUETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863487; c=relaxed/simple;
	bh=RojgPePljW7tlHw8+/warEUquWycIoSq4nWniC/PIlw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pNXUrRIJZn41EfZycMM1QAge/xVnBRueFTWUt2Zsaaq2HuujDkez9R+csZ1J9fTmf5BayiXm6fjlqbkHS18fEXX2HbcXV5M8GohLeCMI7xCKEwgcTAShNVfBcqIeRK0xQmd8oOURGjyt2QcWvoB87t1PDIBWQqdnOqacQvJVin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tTo2U1zY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HuvYTa4F; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tTo2U1zY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HuvYTa4F"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 4844DEC05AB
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 23 Feb 2026 11:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1771863485; x=1771949885; bh=14BDOFEn90
	Hj9iH2Ly29p3neac6Tcnz5Ry0z+zDNP/U=; b=tTo2U1zY2DD2WibL3ZkBsf3kFI
	MZsBR6j9za46wpUyv8GZPr2H96OPpc2N2mYoibZ6YBIWxPk0R5xVyq3qOLkjzZB8
	u15OL2C8BKbRIehOgVfLQfk3QzE6Y1V0FopZX+ybKfU73S+gxBF/eRR2Y+ZnQ4GO
	mCaUxBxFMrTmMRPAIxS+EFbUy5QW9IHQnt1D84Rg41J06AI5PKxhmATQGPmc6F3s
	cm+tS96EXOVSrFhUYxtHVeZWMNeEMyA4qWyv6x4NnyAjm0IlGcJuXPyI3oLBB4FB
	ZLMBpSkDvIIGKiPESVyFWXQLYh1a1kFgMOe/vlMDXn5VQke231hAIe2ok2/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771863485; x=1771949885; bh=14BDOFEn90Hj9iH2Ly29p3neac6T
	cnz5Ry0z+zDNP/U=; b=HuvYTa4FinaKvdwzugsz1vir4Ys6nCc40QTVpyqjVqFz
	UHGmu36vsqz5CsCwvtxqDXZXrevZAARTbqkz8wLUeJJmH0wNwNIXHKqlGvU1OLPR
	IX5oClhmMkjHmdUK1Pc4EpHlVyFkZX+wF5O48wzsM/MjOsn3IcWdmtqW8s8I+gEk
	9A9IxUwr7q6LMVy5kxN3Hb9oS1dH5QxvoFaOAV9pnK72LKDsL51O7Y/bipJCNb2T
	YfWdzC8ANlNq/CEnpbi+zbJEa+UM82i05K2fOm3+B7BeybJDa2/p3WLwVunF2ObZ
	u4g5OZ9MlA+tKal7k5YhHVWNQ/RAf/Ekzqetj3Ka1w==
X-ME-Sender: <xms:vX2cabdga1CHBSV-VPYBZHxCWaLNaN1tJnn6ZnvF7zT3wT5NerbZbA>
    <xme:vX2caTMDcw2m5xP_9Z3LnR9VcalfnSeCjksgy7owrJJPfX-h9QxoYFzo3ANUHemwa
    paxh3GN7jHqMfohwnqzBwBvg8lr3AfhutjmOI40p-4rw0P3h_heQw>
X-ME-Received: <xmr:vX2cad6vUaSqQy0q0G4CFeEqVKWkNB6dyBhvxFxUDQrE-8WPxQ6-Vzknmr9d9xPEUT_OzXZl7EKkVLghYE4GIhY4mAPS6VSOXCyt7GgfBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeffkeeuuedthfevteefuefhtdefudehkeejueekveejfeeigeevffevvdfhlefg
    vdenucffohhmrghinheptgdvfedqmhgvshhonhdrsghuihhlugenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vX2cafJKlqDPetwkK4uxFwe8yw9G6deTqXS_Krkvk_15_g7C6BDLUQ>
    <xmx:vX2cafdBFhyInofXW3_6bPDodgTjDgYunHM26P42YzezJwsfqBDVNA>
    <xmx:vX2caacJcQU1oBYbb8PeQbUpDIDLOiN1utzYO6eDvcRmPy7pjtpv-A>
    <xmx:vX2caaPFVHCIK_UexQ1vsfvUj1M6uJb_Hkg_7RUlSZ_lHgNZHxa73w>
    <xmx:vX2caWEQknpb20RB48rZ3bgNq4aNtJPCRpq8LkoR9p3zqdn1l0AK45iv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66287d2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/17] odb: make object database sources pluggable
Date: Mon, 23 Feb 2026 17:17:51 +0100
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALB9nGkC/x3MSwqEMAwA0KtI1gZq/Ix4FXFha6aGEVsaFEG8u
 2WWb/NuUE7CCkNxQ+JTVMKeUZUFuHXePaMs2UCGOlORQdtg/CmGxaKGIznGuB3ez3ZjbN2HGmq
 NrV0PeYiJv3L993F6nhco88vMbQAAAA==
X-Change-ID: 20260120-b4-pks-odb-source-pluggable-5c724250b3c8
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series finally makes the object database source pluggable.
This is done by moving backend-specific logics into callback functions
that are part of `struct odb_source` and providing thin wrappers that
call those functions.

To set expectations: this is only a start, there is still functionality
missing that needs to be made pluggable. Most importantly:

  - Counting of objects.

  - Abbreviating object IDs and finding ambiguous objects.

  - Consistency checks.

  - Optimizing the object database.

  - Generating packfiles.

These will all happen in later patch series. That being said, with this
patch series one already gets a lot of the basic functionality, and it's
almost possible to do local workflows. Only "almost" though because we
rely on abbreviating object IDs in a lot of places, but once that part
is implemented in a subsequent patch series you can indeed work locally
with an alternate backend.

Furthermore, what I didn't include as part of this patch series just yet
is the introduction of the "objectStorage" extension. I mostly wanted to
focus on the mostly-trivial parts without introducing any change in
behaviour.

Thanks!

Patrick

---
Patrick Steinhardt (17):
      odb: split `struct odb_source` into separate header
      odb: introduce "files" source
      odb: embed base source in the "files" backend
      odb: move reparenting logic into respective subsystems
      odb/source: introduce source type for robustness
      odb/source: make `free()` function pluggable
      odb/source: make `reprepare()` function pluggable
      odb/source: make `close()` function pluggable
      odb/source: make `read_object_info()` function pluggable
      odb/source: make `read_object_stream()` function pluggable
      odb/source: make `for_each_object()` function pluggable
      odb/source: make `freshen_object()` function pluggable
      odb/source: make `write_object()` function pluggable
      odb/source: make `write_object_stream()` function pluggable
      odb/source: make `read_alternates()` function pluggable
      odb/source: make `write_alternate()` function pluggable
      odb/source: make `begin_transaction()` function pluggable

 Makefile               |   2 +
 builtin/cat-file.c     |   3 +-
 builtin/fast-import.c  |  12 +-
 builtin/grep.c         |   6 +-
 builtin/index-pack.c   |   8 +-
 builtin/pack-objects.c |  13 +-
 commit-graph.c         |   6 +-
 http.c                 |   3 +-
 loose.c                |  23 ++-
 meson.build            |   2 +
 midx.c                 |  26 +--
 object-file.c          |  40 +++--
 odb.c                  | 191 +++-----------------
 odb.h                  |  86 +--------
 odb/source-files.c     | 239 +++++++++++++++++++++++++
 odb/source-files.h     |  35 ++++
 odb/source.c           |  38 ++++
 odb/source.h           | 464 +++++++++++++++++++++++++++++++++++++++++++++++++
 odb/streaming.c        |   8 +-
 packfile.c             |  36 ++--
 packfile.h             |   7 +-
 tmp-objdir.c           |  42 ++---
 tmp-objdir.h           |  15 --
 23 files changed, 950 insertions(+), 355 deletions(-)


---
base-commit: 197ce3527e423304844fef02ea067a85c0c75e70
change-id: 20260120-b4-pks-odb-source-pluggable-5c724250b3c8

