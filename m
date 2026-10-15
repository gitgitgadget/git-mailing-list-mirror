Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F03D47CF
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042086; cv=none; b=LJVtD1AuHQcilERF6u1VYLovT/45JD+MA1FEabqnbbtIFxzaH/k/iePJFZmzSYfa0ilrlmqeT/cT6UEPyqLHPJBbcAY33/DL3GsgQ4uBK4hA9k6ZXrg6OBsR5E+t4a0GV75TZ14/VUQfhhByFD0iUlYK0wVk+sroMI8tsQcUK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042086; c=relaxed/simple;
	bh=WdI0qxe3AUH1wY5F8a7FdpH/Mze5zX4fNnM8dgoVvEU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cF20oJH1hM9U8n9RgjOKs9qQlwIQ1SMARaIiY8xq2QwVbSohsS48VKjJIfcIJPv6PYl5yHou4oGm7Nm6bRFAjrLL/asZoHxMe2ooCGYvRwKs6aRNmx927qTjdHWHldSTbLsYoO6vD2PKD+KS0ebShtbQESo54BhhKVYUBa+QJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tICFd9is; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KdhhyWJS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tICFd9is";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KdhhyWJS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 610061D00142
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:28:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 01:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792042082;
	 x=1792128482; bh=mUkoeaezjiijbB9mCXfxYyvkvzLBOgtOv2q++WCUdvc=; b=
	tICFd9istqIh+xZgNmIESk/wAlPbF1GuUIRUs+sjaQTWiHiSsMt3lL1qdLaeMlJz
	axN5xHRToNN7iGF7us6ESeL96ntMifBn+kS27o4exBQd8cFKE8KH6olfrcF4+pVY
	EXbpkpUj8qFpAwEAnk3ifVGAeDabDWUH1AI/0hCrJt7CN9G6OmSBD0RSrXtLXDxq
	xc1sYXaJW4//gLUOxRheCFM3uu/zrjJcMxmXLjcC/Ztcn20dSj7YqoGmj3dv92p1
	S42/7StHHcC2X8sHc95+U0PIUn/E7QUE+/ObK9HmfukZem4ubfuR89ltnUzuv9hR
	LBaUb1CTeU/eJ7BrouGOuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792042082; x=
	1792128482; bh=mUkoeaezjiijbB9mCXfxYyvkvzLBOgtOv2q++WCUdvc=; b=K
	dhhyWJSBWz3+Sl0IsIks+AdqWjgbXhi48ig8XsxOILuHtyT2jT8NmPa4N6OurhQE
	kPOTv3GlL400ynPoK2Z92RBWnO2boV/P8G6hJdZfEGfE+d/1tIC1Mrduo08fPvrS
	b/sQ0QlcuiNDF1p7gTS2gHBYoG+MwNGp96B+lVVcTB4Znv5CiHIWvr8yPXIQ8MlE
	o9Pd1c7NqiznKw4IJSPtT7LuCE+dLOxQYQcHvDds84MDKleGyVTnS6Ypgf5ndOGK
	CkkW8K4pny/vtol6Ey75QWwvROiEr4aom7P+abSUua42MbZm9y1+Ze38pQn/Dj4C
	MatPoa8PerjVAIizBsfeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042082; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aa60C8fMJGNVeaIkTRKzrN2WC1gWCeGj65KP3APpSyVoaDB
	abwlWIBmIWRhSjuCmtLGauB5ho4G1jbxoOZmuvISgXCmO7AOTCtsJuLgVbCAt9N/
	mKZWXmSMqz2RAYhF63nwjXaxxYi7Tatlx8jPgCV0vTd0cW+XFvd6TJn+sNgRlfqA
	m8UX1Fm6hewZN9GcVj4yfileK6nGOaQ8CejAz/YPrdcSVMNKQKyJWxlJMTduawVz
	YD9PR08NLN2h4SQQ2UUjF8647RZitX6/Feb70L/shVEllAG1CDFb3pSLcvXbKkqD
	2L5f09pb5BzXvsfgBweFhe8tdCtdbtQ/9VpbtyQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UksElk4sKvCLCBfqpVtwgy2M6JKfLRFgtUtgzwA4Ilo=:WdI0qxe3AUH1wY5F8a7FdpH/Mze5zX4fNnM8dgoVvEU=;
X-ME-Sender: <xms:YmTQasWPFt0-vmCXZhP2maWEcZ4GTY-6e1Jah-Hzs9Tj-kpmoSnCLw>
    <xme:YmTQancbj-LYsVpU3pzX2sPMLNgR9ZgrZYHYqUHmKtzUMAugEK6x5uSUc5-nC7n-k
    TivG5oa4oG7DWy4aWjJINBPmxrhU4hKzNoNp_n0EBLJUMqtO3z7KXQ>
X-ME-Received: <xmr:YmTQaosuYjDGeQTnTztZ_HusQalaCGtoHzmkIRMTn1QzWafOU7w2Gy5T0XaTnJTs3uWbNNg>
X-ME-Proxy-Cause: dmFkZTGdUGdnxLzyQhkH66riaGssIJS8KYBEmr52Pi1ic2E9/5kABeSCVNpD7NeYHTdHi9
    kzWXxwmgfVkKhxz8EwY5JSPrwyg+sTilWuzij/IXjOuAhp71DXafEFd/XRCnj2wGBEfk6G
    ZMtCu081S05RswoibrZF5S4W12SPGs5WZQjH+IBy/w/2sDkk3SvkAQSPLGu2E2g8n9LgtO
    n+7AiZTnROlT8cdpb68yvA1WPpdYkm093Uae7jc9QXGB+xim3yVZGyp7VSlabtZLygFEIW
    9c/B3fumQQLyQLH0KfwGQMe/9qHYylCYHKnYZ5RC1J46JxNp4k4eOmmraRi4oOuDw3lVFV
    H4AyasD7/lHQ1lqRrHiMm7cVWVJvwax3pjgzNUfct5mpdGiODmZGmRrk8eOzIyPS/pp1YC
    /Q15ubxBpXQYphAdclPxN7TJl3DiBZHWjilRs7aC26DFFCQ1CwmAr2gdTya60xkEZ/190E
    iU3CKcQU2c3XP/WBGjCPQSzW/RMPR3bfIt/+W9Hz5gXBNormXbNg1tyalzKccjxuA1aLce
    uk6LrR9VOdzTgLOWjVtSVQ7p4oAuRB4n55gX9n11+lYEBP3GvYQnTM/esY7p5MagFRfB2l
    /pWZ9foKEvqWlbdSdhk8Ke8UTZ+S8vg653uegA+qQHGnGil6jdebMiXOCiAQ
X-ME-Proxy: <xmx:YmTQam_dY8fFcB-0-1eKFQw5rhj9EayNmYgX8Jh3tJ8nwjlwFq_q4g>
    <xmx:YmTQaj2_4DeBvbIhJbkQMD26_82oldYtaq-U9Ks3MLi9ned7u3LgYQ>
    <xmx:YmTQarCUuuwUCcMh64JTpromwEB3OKdQQurwhSqhv6DCMvbKzqWiyQ>
    <xmx:YmTQave2gHXtb5jMA7j56jwnufyaicVP5Z7RFbgcX1nHTTKh0Dx97w>
    <xmx:YmTQapY0La2amI7lQf_cR_eXlFNTa2omoN1p-53ET6gAze4PBuHvu0c->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:28:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 206a79b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:27:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] odb/files: cleanups and improvements for alternates
Date: Thu, 15 Oct 2026 07:27:54 +0200
Message-Id: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oyw7CIBBFf8WwFsOjQevK/zAugA4WrbQBSjRN/
 12oxrjsbm5y7zkzoQDeQkDHzYQ8JBts73Lg2w3SrXRXwLbJGTHCBCVE4OEecN8obGwHAcsugnc
 y5lN3IN04BEypEQehdVVXDGXO4MHY5+I4Xz45jOoGOhZwabQ2xN6/licSLb2vj/IVvkQxwWpPO
 DGGKSbMKW929oGKLLF/XLUGxzLOQFMrpqXkCn64eZ7fMogiqDABAAA=
X-Change-ID: 20261006-pks-odb-files-alternates-cleanups-11f686cc4942
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>, Tyrie Vella <tyrielv@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series contains a couple of follow-up cleanups and
improvements that are now possible after having migrated alternates into
the "files" backend.

The series is built on top of 6de20f6092 (The 4th batch, 2026-10-06)
with ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
`read_alternates` callback, 2026-10-08) merged into it.

Changes in v2:
  - Add another refactoring on top to only fetch objects from a promisor
    remote in case they are missing.
  - Link to v1: https://patch.msgid.link/20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im

Changes in v3:
  - Add a regression test, supplied by Tyrie.
  - Link to v2: https://patch.msgid.link/20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb/source-files: fix performance when reading objects with alternates
      odb/source-files: fix performance when streaming objects with alternates
      odb/source-files: make the second read an implementation detail
      odb: remove read loop for found objects
      odb: don't try re-fetching corrupt objects
      odb/source: drop `local` flag

 midx.c                   |  2 +-
 odb.c                    | 63 ++++++++++++++----------------------------------
 odb.h                    | 12 ---------
 odb/source-files.c       | 26 ++++++++++++++++----
 odb/source-inmemory.c    | 10 +++++---
 odb/source-loose.c       | 17 ++-----------
 odb/source-loose.h       |  3 +--
 odb/source-packed.c      | 20 +++++----------
 odb/source-packed.h      |  7 ++++++
 odb/source.c             |  4 +--
 odb/source.h             | 20 +--------------
 repack.c                 |  2 +-
 t/t5615-alternate-env.sh | 43 +++++++++++++++++++++++++++++++++
 13 files changed, 109 insertions(+), 120 deletions(-)

Range-diff versus v2:

1:  3a7f78fc94 ! 1:  dea38443a4 odb/source-files: fix performance when reading objects with alternates
    @@ Commit message
         [1]: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
     
         Reported-by: Wolfgang Kritzinger <wkritzinger@atlassian.com>
    +    Helped-by: Tyrie Vella <tyrielv@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb/source-files.c ##
    @@ odb/source-files.c: static enum odb_read_status odb_source_files_read_object_inf
      		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
      						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
      		if (!ret)
    +
    + ## t/t5615-alternate-env.sh ##
    +@@ t/t5615-alternate-env.sh: test_expect_success !MINGW 'broken quoting falls back to interpreting raw' '
    + 	EOF
    + '
    + 
    ++test_expect_success 'packs across sources are checked before loose objects' '
    ++	# Regression test for a performance issue in which an object that
    ++	# resides in an alternate as a packed object caused a spurious loose
    ++	# object lookup (a filesystem stat) on the main object store before the
    ++	# alternate packfile was consulted. Reading such an object must resolve
    ++	# to the alternate packfile, never to a loose copy in the main store.
    ++	#
    ++	# Build an alternate whose object "B" is stored as a delta in a
    ++	# packfile. git deltifies successive versions of a tracked file, so the
    ++	# older, shorter blob "B" becomes a delta against the newer, longer
    ++	# blob "O". A loose object has no delta base, so %(deltabase) tells us
    ++	# which store answered the read: the alternate pack (O) or a loose copy
    ++	# (the zero oid).
    ++	git init alt-src &&
    ++	test_seq 1 200 >alt-src/file &&
    ++	git -C alt-src add file &&
    ++	git -C alt-src commit -q -m base &&
    ++	B=$(git -C alt-src rev-parse HEAD:file) &&
    ++	git -C alt-src cat-file blob "$B" >b-content &&
    ++	test_seq 1 210 >alt-src/file &&
    ++	git -C alt-src add file &&
    ++	git -C alt-src commit -q -m more &&
    ++	O=$(git -C alt-src rev-parse HEAD:file) &&
    ++	git -C alt-src repack -adf --window=10 --depth=50 &&
    ++
    ++	# Precondition: in the alternate, B is a delta based on O.
    ++	echo "$B" >in &&
    ++	echo "$O" >expect &&
    ++	git -C alt-src cat-file --batch-check="%(deltabase)" <in >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	# Main repo: write B as a loose object, before any alternate is active.
    ++	git init main &&
    ++	git -C main hash-object -w --stdin <b-content >/dev/null &&
    ++	test_path_is_file "main/.git/objects/$(test_oid_to_path "$B")" &&
    ++
    ++	# With the alternate active, B must resolve to the alternate packfile
    ++	# (deltabase O), not to the main store loose copy (deltabase zero oid).
    ++	GIT_ALTERNATE_OBJECT_DIRECTORIES="$PWD/alt-src/.git/objects" \
    ++		git -C main cat-file --batch-check="%(deltabase)" <in >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_done
2:  23d8dcfcdf = 2:  374cbda799 odb/source-files: fix performance when streaming objects with alternates
3:  406228ce0f = 3:  635d9ce86e odb/source-files: make the second read an implementation detail
4:  c8f4c96b77 = 4:  832852bad5 odb: remove read loop for found objects
5:  e4af3300af = 5:  a0eebb1225 odb: don't try re-fetching corrupt objects
6:  7658903430 = 6:  b4a76c5651 odb/source: drop `local` flag

---
base-commit: ea99757de7d4ef6c7727431bfd7b6726614102e0
change-id: 20261006-pks-odb-files-alternates-cleanups-11f686cc4942

