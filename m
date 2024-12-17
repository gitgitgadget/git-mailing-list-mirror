Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EA1DB933
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417860; cv=none; b=SfaVJB02u7ts3i2CVdBb0kk7UpdL/d/Sow4NxyK7iNVoBOfyNiQQQCO3tefezvVCiqiO5yjBkAg2UpsEkOOcPZTmeP6FavXQMtdBj68sJ61rSO+Zr0OIE1YozwfFtbwgK9jfynMFH+8zr3HRYPQQ8HjHJahLpS7Ur2iRS5n6RPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417860; c=relaxed/simple;
	bh=0G1YESgdQgTXUYkPiNzawo0Wd6ei2Qww8ECj8rcmZtE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ON3PSGj1XE5tNCyXMn/xd0TNeeRaltsN+FfJ6Xo1WKOk53x7dKWrn3rD9+9e6e77j1y8i1lSsjtH1MyiaQbi710o9aDXkfyUo+lHRWqkY08j8o2VrVwgJVOcyC0YqrTl2IwPUlRe4FfzIe+wdsUPyJnNB1XjwAWTvSGlV77aSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ehm4XzK6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmoOVb4Q; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ehm4XzK6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmoOVb4Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9365113801C7
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Dec 2024 01:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1734417856; x=1734504256; bh=PVwWNCd4ya
	xnnSSEyhd2MGIiqpifwcN+EcOiyKm0Wk0=; b=Ehm4XzK6GkOVmaz7w33PoMCnUB
	zq6oMcDljt9nagO6OwwSwMXC7TQ9+XUNme+9uVrZy48BX31D2KC5ZszDQgoZqX6a
	BaG5fn5OOi/t7c8X/a2BS/sktlJDuYrNZD7SyeK8x1zGklHV9jmexBtN12aqGqxL
	/KUv86FS1DXXUv5SE0uXvFpvm4L+e9TTvmUAM3wQs7eSp4gNZOdq4Wpce/Y+XmsT
	zvtuVvbh7XDUBIfWKByzzkGcTQQhfbdFsYUXnkjZPNGhxLD9xRKAlF3o8bqAlJE2
	Y86jWKA2siJ4HBr6Vi0McJleH5vaPQq0BsmnWZBHwcqQclFW3kdJT09CByEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734417856; x=1734504256; bh=PVwWNCd4yaxnnSSEyhd2MGIiqpif
	wcN+EcOiyKm0Wk0=; b=fmoOVb4Q869Xeu/IvTUmy6EATeDeQ5AI5PUWSe30FnFU
	jGOWdzFeXY0wFy3alv9jclWrOhM/kKi4TGStnHbrHwVQzz8/WZ6FhpKMb5iAEfew
	nvcOZ4XRmczXGDngndTPNd5nDe5s0jCILottp4AAIVsHLPaUQGRU3TJVT/kX+oUz
	9MQQth1qxawHxHj1HQ2rclijE5FyvuNWHPgo/zkQqp9C/enONZDyCBG6QaN2X6dg
	df9chHaO/EP+q0ShigMiXQiJPTJDzL8QtD68xwiqTjfz1KiIjBxb+NNLzQaWUZzV
	VaPD1yn76q9M3c7L0XC+Hnvt15ZTJh+AQRvd9nnCjQ==
X-ME-Sender: <xms:wB1hZxUTXi0wC7_dQ-a4H2QQlCaJodgHrP9f2wulCFcwuQBjZwCcVA>
    <xme:wB1hZxkahesWRAupJ_D8nqyqypn7UrBBgqHdknhgyEd61QjQfEJNWenHXPFiHppxS
    mBDXq3JTT9GwKuQLQ>
X-ME-Received: <xmr:wB1hZ9bqipGpRlxmAR5JiliAlnpvOD37q5rnWJ_tfsJDcO9OnhY2R7Yib-UtvgBhtmVVUNxVtkpUOTq-9Tm1i4iUlL1xpKywXtuMfDJvaujXsqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeige
    ejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wB1hZ0WtTR3VBVHeNI6QkPpYU7iO-tr0jo0Ip6TlVSg1SqDYS0z9rg>
    <xmx:wB1hZ7mInhGPRrXHPuZhqhgj5iL0YAhbHHNGb1wRbRK1-mrux0_UGA>
    <xmx:wB1hZxcJyeirff7nrayTGWSnJwQvWbwz3iMxXgf8TDNlSZkJeZP4Gw>
    <xmx:wB1hZ1EalYF4o4_2wnBEOvKcmhW--sRvPcPx6AEJc7kwvpbI_QZVUQ>
    <xmx:wB1hZzs88QbC8-iJImuyNuFgNkrBjxcxl2D64AnOYJAq70-lHEM7lOzy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a00d0ac1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/14] Stop using `the_repository` in some trivial cases
Date: Tue, 17 Dec 2024 07:43:47 +0100
Message-Id: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQdYWcC/yWOS47CMBBErxJ5PT1qOz8nQqO5B2JhO5XBGiUOd
 ohAiLtjwvJ1qaveQyREjyT64iEiNp98mDPIr0K4s5n/QH7ILBSrSkqlaflPdE2g9QyKWELya4h
 3cmHeEN/f5MqqMWNZag2I3LNEjP62bxxPH464XPPU+jkKa3KhC9Pk177gprQOdmTXyVZW7Ayj5
 dpZ8DjASNWiY9bNu3pCSmZ37IvDrqi42RVzklU2KYmpVjWGqu2U1fo3h99++hGn5/MFY7ToXf0
 AAAA=
X-Change-ID: 20241128-pks-use-the-repository-conversion-c346af3388ee
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series performs some refactorings to stop using
`the_repository` in several subsystems. There wasn't really any
criterium for which subsystems I picked, except that all of them have
been trivial to convert.

In this patch series I'm merely bubbling up `the_repository` one more
layer even though some calling contexts already have a repository
available. For the sake of triviality I decided not to handle these
cases though and instead let a future patch series worry about them.

This series is built on v2.48.0-rc0 with ps/build-sign-compare at
e03d2a9ccb (t/helper: don't depend on implicit wraparound, 2024-12-06)
merged into it. There's a single merge conflict with 'seen' that can be
solved like this:

diff --cc pack-bitmap.c
index 48e3b99efb,7d8f910588..0000000000
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@@ -2572,16 -2761,8 +2761,10 @@@ void test_bitmap_walk(struct rev_info *
        if (prepare_revision_walk(revs))
                die(_("revision walk setup failed"));

-       tdata.bitmap_git = bitmap_git;
-       tdata.base = bitmap_new();
-       tdata.commits = ewah_to_bitmap(bitmap_git->commits);
-       tdata.trees = ewah_to_bitmap(bitmap_git->trees);
-       tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
-       tdata.tags = ewah_to_bitmap(bitmap_git->tags);
+       prepare_bitmap_test_data(&tdata, bitmap_git);
 -      tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
 +      tdata.prg = start_progress(revs->repo,
 +                                 "Verifying bitmap entries",
 +                                 result_popcnt);
-       tdata.seen = 0;

        traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);

Thanks!

Patrick

---
Patrick Steinhardt (14):
      progress: stop using `the_repository`
      pager: stop using `the_repository`
      trace: stop using `the_repository`
      serve: stop using `the_repository`
      send-pack: stop using `the_repository`
      server-info: stop using `the_repository`
      diagnose: stop using `the_repository`
      mailinfo: stop using `the_repository`
      credential: stop using `the_repository`
      resolve-undo: stop using `the_repository`
      tmp-objdir: stop using `the_repository`
      add-interactive: stop using `the_repository`
      graph: stop using `the_repository`
      match-trees: stop using `the_repository`

 add-interactive.c            | 19 ++++++-----
 add-patch.c                  |  2 +-
 builtin/am.c                 |  6 ++--
 builtin/blame.c              |  6 ++--
 builtin/bugreport.c          |  2 +-
 builtin/commit-graph.c       |  1 +
 builtin/credential.c         |  6 ++--
 builtin/diagnose.c           |  4 ++-
 builtin/fsck.c               | 12 ++++---
 builtin/grep.c               |  4 +--
 builtin/help.c               |  4 +--
 builtin/index-pack.c         |  7 ++--
 builtin/log.c                |  7 ++--
 builtin/mailinfo.c           |  2 +-
 builtin/pack-objects.c       | 21 ++++++++----
 builtin/prune.c              |  3 +-
 builtin/receive-pack.c       |  4 +--
 builtin/remote.c             |  3 +-
 builtin/repack.c             |  2 +-
 builtin/rev-list.c           |  3 +-
 builtin/send-pack.c          |  2 +-
 builtin/unpack-objects.c     |  3 +-
 builtin/update-server-info.c |  2 +-
 builtin/upload-pack.c        |  6 ++--
 builtin/var.c                |  2 +-
 bulk-checkin.c               |  2 +-
 commit-graph.c               | 20 ++++++++++--
 credential.c                 | 34 +++++++++----------
 credential.h                 | 11 ++++---
 delta-islands.c              |  3 +-
 diagnose.c                   | 15 +++++----
 diagnose.h                   |  5 ++-
 diff.c                       |  4 +--
 diffcore-rename.c            |  1 +
 entry.c                      |  4 ++-
 git.c                        | 10 +++---
 graph.c                      |  3 +-
 http.c                       | 24 +++++++-------
 imap-send.c                  | 10 +++---
 log-tree.c                   |  2 +-
 mailinfo.c                   |  5 ++-
 mailinfo.h                   |  4 ++-
 match-trees.c                | 50 +++++++++++++++-------------
 midx-write.c                 | 11 +++++--
 midx.c                       | 13 +++++---
 pack-bitmap-write.c          |  6 ++--
 pack-bitmap.c                |  4 ++-
 pager.c                      | 14 ++++----
 pager.h                      |  7 ++--
 preload-index.c              |  4 ++-
 progress.c                   | 34 +++++++++++--------
 progress.h                   | 13 +++++---
 prune-packed.c               |  3 +-
 pseudo-merge.c               |  3 +-
 read-cache.c                 |  7 ++--
 remote-curl.c                |  4 +--
 resolve-undo.c               | 14 ++++----
 resolve-undo.h               |  6 ++--
 send-pack.c                  | 77 +++++++++++++++++++++++---------------------
 send-pack.h                  |  3 +-
 serve.c                      | 36 ++++++++++-----------
 serve.h                      |  6 ++--
 server-info.c                | 40 ++++++++++++-----------
 server-info.h                |  4 ++-
 t/helper/test-progress.c     |  6 +++-
 t/helper/test-serve-v2.c     |  7 ++--
 tmp-objdir.c                 | 15 +++++----
 tmp-objdir.h                 |  5 +--
 trace.c                      |  9 +++---
 trace.h                      |  4 ++-
 transport.c                  |  2 +-
 unpack-trees.c               |  4 ++-
 walker.c                     |  3 +-
 73 files changed, 406 insertions(+), 298 deletions(-)


---
base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
change-id: 20241128-pks-use-the-repository-conversion-c346af3388ee
prerequisite-message-id: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
prerequisite-patch-id: 39559d044bc4db5a61d8d428ba227596b6f9a572
prerequisite-patch-id: 76040d8ec266b78f698065cdc891c7a44a7deb59
prerequisite-patch-id: 6a99a5acb7d2a9d331bd2fa364c5f048c4807630
prerequisite-patch-id: f9bf8d3c7bd9ac8f1beeafc0d7bfa99809624ff5
prerequisite-patch-id: b3b09e0cc0b35176a63e768e3dae4f39ed2bbd96
prerequisite-patch-id: b2f0b893f4093ac7ac4466efe23472c381c207bf
prerequisite-patch-id: 942b24fe8f6b5a1d2fd892e4dd52b83238b2bf6a
prerequisite-patch-id: 95f28ecdf77807e7e6968c0bc75e29ea8fa5d687
prerequisite-patch-id: 58e4f31b532d41d4394654ea1de6a3d2a3c54bff
prerequisite-patch-id: 331073f51ccb93b8b02f14b6e52f8fb70651afc5
prerequisite-patch-id: c357c6e7040737739a8d5d76424348bcc9444a79
prerequisite-patch-id: d643b636c49ef0bca14fd198290ffbda331d2823
prerequisite-patch-id: aeee0e7f421acd0c5e6d8a9cd45eb22b8f52a322
prerequisite-patch-id: 88175b9418f0575a627ed6b592c61406bed0972c
prerequisite-patch-id: 95241bfd7e6798b39187c3dfc03d47ab37ca50c4
prerequisite-patch-id: 73dd2f88f2629f3a54ab01c2882962b9effd6055
prerequisite-patch-id: 291c5ec532ed3738a59ad7001ef3a84e2c43aa78
prerequisite-patch-id: 3b29840c001ec89f137b8e37796d710f60436a6a
prerequisite-patch-id: 78bd944cca8c7404feb1f54d9adfcbfea481fa96
prerequisite-patch-id: 9f34d87c5455cada6a68350daa86cb1069e7accc
prerequisite-patch-id: 798827dcb73a002d4d604472e1b1a3b64f9b159d
prerequisite-patch-id: a110e45c7f97287acbd8c69640d6f03d2e7d9bef
prerequisite-patch-id: 3ce7cd65e984c138658841e3a4802178cc9129b2
prerequisite-patch-id: 9cb10256bf2b131cf434ec078807f27be3a4d6cf
prerequisite-patch-id: a97085715ee32eaaad3bcde53e7d41582424f0f9
prerequisite-patch-id: 7a5e50bc7d49ec891a9679b1ea71575f41483187

