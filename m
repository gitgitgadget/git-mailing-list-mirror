Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015CC3BE15E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280741; cv=none; b=frop+mIpzIf1gpbNpYpCN99c3UNO5Bxhn+za2ChQ2DeFZ4T8mpItGEuKUD3Z77aV4/TwbE4wGeyd6yDXa3xHfkk69ezitk7EhtzrVhZluasXS08kTApocnMyhBF3KmSTr1PAl/epXE5JANy+Jg/V4/UnUg1HN2vDJKU6pBwNuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280741; c=relaxed/simple;
	bh=3hYdb9YJ2PDcRLKUBiG1CW9JbtuUFfvDrNHNaYyZuTQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZIH5ebe6SuZejK2By2znlQTyzQk+hTRqZnk+xKOkKOFJgC94WN51Z/ldX6ejhdC/bnU5BXMNQ+DSrRziwAqH5dbolJ04lVJ+fV8dhL8kx5Jgbuv9OqJC7l8d1G87eOJUHvWLI2WTJ4QhFQqxS8SKAEg5Wei6S0j+bgBxwaAo+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RYGFNzNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DnkvQ5v+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RYGFNzNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DnkvQ5v+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 477D77A00B7;
	Fri, 17 Jul 2026 05:32:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 05:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1784280739; x=1784367139; bh=dbnPcBaPSF
	WV4prLxtk3QY4sidcJAhiTRncmSCaeeUM=; b=RYGFNzNvNn1IUcYTpy6yMso6Wj
	AdjnNu3gce1QwtQQ/uHyFJpaQX7fJ+u0Agh2qy/Lqb56LSBse2B9aOXUGQhAn6yi
	n9fGrkCiNGQP1vaN+CS2isDgTzmjq20OQFoNUF+0He76Xzv5fFH10ciNIVooL6hT
	BYuIDahwqK11ZX6qviAWt8H7EI6R0kzOH3N43n8I7OhUO6aEbgHUy6qtW8dOzR4l
	VW5DY7XdZh7xAI8n4GrailS3d2DZ7VQE+tnOKYzmJc+q8aKWyY1CDGdxmU6w3GQ1
	4koeoA9pQ/NBgJ6L3SWljMwRdukhgJTJ5VGtIlfIKMXVv9IWVg24B05LkthA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784280739; x=1784367139; bh=dbnPcBaPSFWV4prLxtk3QY4sidcJ
	AhiTRncmSCaeeUM=; b=DnkvQ5v+A3od2BWpDobTwl/taDPQ0eZ5igiD930sZgkn
	lxQAKODch5p0iRI9Dkg+llJw1SNiJVbNUb/ozqfDo1d7Al6qU1FnZCbhyDducjY4
	INmE4dh7TMzVsuG3FiIUzjVe2PnP/OiRKMqppuVx4sZssGmuHw88kMdWl9lHCnDD
	KtMbuxgzFwxVKGtUoBTv4+AbCdho0foSL2TOLCdRFUAyffKOgqGw0JxAikRzPmzI
	/xN7NS5A7PY7vhLeV6x1zXJKsRpQO7gQWVA/IjJv6bhCpORcyljXEqB1r+axOL2x
	T67P5WpygUge1l6xs2u5UZy8/QglT/WbwEfDGh2q6w==
X-ME-Sender: <xms:ovZZah89T1fTDBW8792c3zBgre-tlsoiLZu2KZkikXkADIgplO7j4Q>
    <xme:ovZZart_znCuEyyjVRreY1M03YZW0h6TOAkXNK0hu6Cjgch_H5SB7URV2ILzSZW5o
    LeAsiQKV1fEaw-hwRZTfh9-nDOWE7CS3HAnICbVBL2d-TvLppA>
X-ME-Received: <xmr:ovZZaspaW63ezZvbMJZh-f7YbdOqjlZBG25bXIrwVo9rAXkTZr-0sLGZbNoqJ55-VMOydj0EVGA0Fq5PcwdeOiljEz3xARjcbXzmBjIDznU>
X-ME-Proxy-Cause: dmFkZTFqxvuVIrtFfD5O470Y7bnuGQ1S334X1OT3Tur2C1/LzaMcaE2Ee+sdViSInTwyz9
    pZYYOtOJlN/DW04P4YZqY4WmlEfxUe5sNQkV/8wBgzlJ78SqKzZdlDqdz/7bEV0/VVDH/J
    Bu0qi647OKoFF8IVozrPBP/GA9T+c25kMZwIMVk+exsBLqWNrkqkyWlv1K5ElcmNFWMVpk
    APRJVqB3XbKnDfQMKgWqi0+luGyr53kuaC54c/c4hd2UdPPToAK5tz8GX8uD2XaS8ZMfX4
    FC5FPhvk7L6uyZH6ysiT5Ll9m7AxeK9AIkLbeXz2gUbxCuBs34I1ZQicO01dncXcMIdJjs
    aj3plYFHHhlMHcLgHL4MQslEVORCtZiP4j25xIqcm6NvDIaUQL0L1T50nnF5q0mxQR2HNx
    kobNsfoB/n5Drltb2lCTb6Xv/WhaVGKvMIpE8o0zB+r65V7h/RjScqoT/FIHPXv70ngQkl
    nYuSSNNzEdWB3Lem1HR0HfltQzSQvo4PNPl0lAFHVjDmJwzC1Nu3Wm+Nl3BHCy1CPR35mZ
    /PL9PiT3xvDcLhHQ8Nh9ELDY6uHBqr+WixfLD1/QdUsbw0daRE8R+42x9jQbXaLctYBBvI
    EivA/QO69HlNzEpxXBE4S9EndsxIkq8Yl0kkCzGbvLLuN7PMCtBrqJU9oREQ
X-ME-Proxy: <xmx:ovZZagltiekk08Yo_168lPDEcRvhYBXWN1HoGbELbNuaSUkZ9mJlbA>
    <xmx:ovZZaowAjCOPIqyznoPmYRGxlEfdmAE2DMz8VetnkVpclfTSAqxncQ>
    <xmx:ovZZagnvwXHY2Wzizq_ji8R523ZXkdshSJFqc1VkN9JizpCpmxsIwQ>
    <xmx:ovZZapePNbKjipJFCXrCKwF6W2Aq4cm-HpIax5I0blV0wtk6GKZ8Lg>
    <xmx:o_ZZaguy1My07dpEjKma0Ykn6R0NmFzlH8Nzol7uNSwtubTTMBj-VG_7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3150a412 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] object-file: move writing of loose objects into
 "loose" source
Date: Fri, 17 Jul 2026 11:32:08 +0200
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNyw6CMBCF4Vchs3aSFkSNr2Jc2HaK46VDOoAmh
 He34PJbnP/MoJSZFM7VDJkmVpZUYHcV+PstdYQciqE29cEcTYP9U1GCw7dMhC8RJRT3ID/gJ/P
 AqcOT89HG1jqzD1A6fabI3+3jcv1bx22yhmFZfoVMqgyFAAAA
X-Change-ID: 20260703-pks-odb-move-loose-object-writing-8bcf1f51b04d
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series refactors "object-file.c" so that we can move the
logic that writes loose objects into "odb/source-loose.c". This ensures
that the logic to read and write loose objects is mostly self-contained
within that source's implementation now.

To achieve that, this series first refactors `force_object_loose()` so
that it can work on top of the generic `odb_source_write_object()`
instead of having to call into `write_loose_object()`. This is the bulk
of the patch series.

This patch series is built on top of 44de1520f0 (Merge branch 'master'
of https://github.com/j6t/git-gui, 2026-07-16) with the following two
topics merged into it:

  - jt/receive-pack-use-odb-transaction at bdee7b3013
    (builtin/receive-pack: stage incoming objects via ODB transactions,
    2026-07-10).

  - jk/git-hash-cleanups at 9e396aa553 (hash: check ctx->active flag in
    all wrapper functions, 2026-07-07).

Note that jt/receive-pack-use-odb-transaction requires an evil merge:

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 06b31dd743..cbb06da038 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -545,7 +545,8 @@ static int odb_source_packed_write_object_stream(struct odb_source *source UNUSE
 }

 static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
-                                              struct odb_transaction **out UNUSED)
+                                              struct odb_transaction **out UNUSED,
+                                              enum odb_transaction_flags flags UNUSED)
 {
        return error("packed backend cannot begin transactions");
 }

Thanks!

Patrick

---
Patrick Steinhardt (9):
      odb: compute compat object ID in `odb_write_object_ext()`
      t/u-odb-inmemory: implement wrapper for writing objects
      odb: compute object hash in `odb_write_object_ext()`
      odb: lift object existence check out of the "loose" backend
      odb: support setting mtime when writing objects
      object-file: fix memory leak in `force_object_loose()`
      object-file: force objects loose via generic interface
      object-file: move `force_object_loose()`
      object-file: move logic to write loose objects

 builtin/pack-objects.c        |  48 ++++-
 object-file.c                 | 449 +++---------------------------------------
 object-file.h                 |  32 +--
 odb.c                         |  39 +++-
 odb.h                         |  10 +-
 odb/source-files.c            |  14 +-
 odb/source-inmemory.c         |  14 +-
 odb/source-loose.c            | 402 +++++++++++++++++++++++++++++++++----
 odb/source-packed.c           |  17 +-
 odb/source.h                  |  20 +-
 read-cache.c                  |   2 +-
 t/unit-tests/u-odb-inmemory.c |  53 +++--
 12 files changed, 551 insertions(+), 549 deletions(-)


---
base-commit: 8061f1ea286318fbf976f58df3985bd60237b8a7
change-id: 20260703-pks-odb-move-loose-object-writing-8bcf1f51b04d

