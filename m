Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A11FF045
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786062; cv=none; b=r34FcHEmy0210zeS7FSEUmCUZZn4Zsm1Lmfxsp0lXxMb5B2HdDAAp6E8r+tITW4Xzm2wxRsaYCwt7qHKxEwXoqkicrNZ0chWDhMVbWXMVl4UgYRK5HIVXM+ohyP54gMD0xJv5e80QqwuvdraSVAxsP4HD+qjfTMYgkUFmn/5c4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786062; c=relaxed/simple;
	bh=aVIJ/MYzcOhioHIEgo0SpU28eSF7BIkocdd1VPWVeZQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UGx4wdSiRuZUeoNeFNE/Ma9cFNcg+2EWP3icwCEd82DiwQmKGJkzVnD296k/ZhcA00IvtsQMuxy1Dk0g9bmejpL1sOIhtbsKf+TyDjFo71oXQm89th1X3APIsj7BXiC7MG9LCkUg+8Z3bPfa9Q53jxsFhurgYNYDNZkbxkG3xro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gOS6jqjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6PRR4yg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gOS6jqjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6PRR4yg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E5C911401E2;
	Tue,  5 Nov 2024 00:54:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 05 Nov 2024 00:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1730786058; x=1730872458; bh=6DsMXhQdrtM2pPgYlanUGgBdx6Cty5lz
	jAnsrHTwGcI=; b=gOS6jqjzA+noOLuvBMtbjh7Z2xL3tfIYqib1r7Z25dJg3i75
	Iz9SYmIzsBmdp4BCH6COb6gzEkVRyQDk2meIPf5fhV539TWu9hSQaT1JcgCir5dM
	uqzpKlEI/+md4jS9YX5lDJlTrTAgjXwT7X9CvvqVWrqTZASl11Z/OV/Nx/4/E+s4
	dXVE3MVda160XjJfa+154QT+9v2CrJALurkpnuOIQHSOivFjdflW8hFmGxO2u2Hb
	/Ywxdt6Gj5snDXjqsMiYrwvA5OaQ79c2077L1C+XLnywlO5pMi5hXu51VK3NAiHg
	7P4ut1iJ+yPK7yYcvofG8ovmAwuWjY/3LvKwvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730786058; x=
	1730872458; bh=6DsMXhQdrtM2pPgYlanUGgBdx6Cty5lzjAnsrHTwGcI=; b=Y
	6PRR4ygBckWd4P+KPlr5ZNI9pt0vuJDRtzjtUwzfx0bRZ/iowAVzcZ6XzKnR6mE8
	rEiPUpenPcOrHvI5S9j/zHPOlY3WsKDQHDzl/6n5KaiQobDKvE3R1RSNiUe4GcFe
	tpwExMq3gel2nJ/KP+QrZz/f4gyaJIWxfMd3TQrAyUgR+VePcAcD1oscH6P7w/zV
	IcdAnUyJckBLH+BPVK9g4FwlXuWdbORdXu8gU2EXZSRihMrS4JF1gbIXLrui4vWS
	glSf9rhGYxO1O24O1VvNelbFFbENxTYtCMCVLQDp1FadpahGseW/o9qWyBMDwkqQ
	1+C4e597leIY4TOa6/zWA==
X-ME-Sender: <xms:CrMpZ6uOMJClkg9wQffCtNxQJ0yLR0k2JOlLKF1VtkCtF-40DLhcOA>
    <xme:CrMpZ_d8dByOy7H-d1Q8hFylAQq-KdjwdIiVE2r9YScywJVCJyQYLv8Zz8WnT4tFi
    bSxLN4uSUlNmpQr2Q>
X-ME-Received: <xmr:CrMpZ1x38yI9BkBHrc3R0_z7COfPR9qLqpziHDBKSZF1LXGNbnFSTyeUP-iGqFkG-qZboGOlwGYS0ekb6aPdb2zaWELSEkYT49wZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepiedtffeike
    egleeltdelleegffeiueehhfehvdettdejkedtvdffueeigeevieetnecuffhomhgrihhn
    pehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CrMpZ1PmmbR_0TmNYfpbXtoro1f3Iv-lY9DQSu7gtLIeKcqNO9alGA>
    <xmx:CrMpZ69nPbVi9BvKiWSeG9ZZmwlZG761dEC-7COUfi4o3ikRX3y4Ug>
    <xmx:CrMpZ9X7hi4ung3cXSS_TJkb7xQDt2zw54XGM9tHOsnpvE9ITNI9dw>
    <xmx:CrMpZzcptGbGU_KFQo9jJCy6-J-qY5hBYsDo93fIKfsJTL21K59SgA>
    <xmx:CrMpZxYnQWyOJhjPZD3kOS6a8MpOs25rix411X012HWQtp5pKJffYhxd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 00:54:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: What's so special about almalinux-8?
Date: Mon, 04 Nov 2024 21:54:16 -0800
Message-ID: <xmqqbjyuted3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Everybody else seems to pass tests, but not this one

  https://github.com/git/git/actions/runs/11677884048/job/32516504151#step:6:1995

I am not (yet) so familiar with the topics in flight at this point,
but there are a few topics that deal with packing, lazy fetching,
and commit-graph and object database being out of sync, which were
handled by a few topics by Jonathan, so I am CC'ing this if it rings
bell for him.



failure: t5616.22 use fsck before and after manually fetching a missing subtree 
  	# push new commit so server has a subtree
  	mkdir src/dir &&
  	echo "in dir" >src/dir/file.txt &&
  	git -C src add dir/file.txt &&
  	git -C src commit -m "file in dir" &&
  	git -C src push -u srv main &&
  	SUBTREE=$(git -C src rev-parse HEAD:dir) &&
  
  	rm -rf dst &&
  	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
  	git -C dst fsck &&
  
  	# Make sure we only have commits, and all trees and blobs are missing.
  	git -C dst rev-list --missing=allow-any --objects main \
  		>fetched_objects &&
  	awk -f print_1.awk fetched_objects |
  	xargs -n1 git -C dst cat-file -t >fetched_types &&
  
  	sort -u fetched_types >unique_types.observed &&
  	echo commit >unique_types.expected &&
  	test_cmp unique_types.expected unique_types.observed &&
  
  	# Auto-fetch a tree with cat-file.
  	git -C dst cat-file -p $SUBTREE >tree_contents &&
  	grep file.txt tree_contents &&
  
  	# fsck still works after an auto-fetch of a tree.
  	git -C dst fsck &&
  
  	# Auto-fetch all remaining trees and blobs with --missing=error
  	git -C dst rev-list --missing=error --objects main >fetched_objects &&
  	test_line_count = 88 fetched_objects &&
  
  	awk -f print_1.awk fetched_objects |
  	xargs -n1 git -C dst cat-file -t >fetched_types &&
  
  	sort -u fetched_types >unique_types.observed &&
  	test_write_lines blob commit tree >unique_types.expected &&
  	test_cmp unique_types.expected unique_types.observed
  
  ++ mkdir src/dir
  ++ echo 'in dir'
  ++ git -C src add dir/file.txt
  ++ git -C src commit -m 'file in dir'
  [main 957c60b] file in dir
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 dir/file.txt
  ++ git -C src push -u srv main
  To file:///__w/git/git/t/trash directory.t5616-partial-clone/srv.bare
     129c8a2..957c60b  main -> main
  branch 'main' set up to track 'srv/main'.
  +++ git -C src rev-parse HEAD:dir
  ++ SUBTREE=bc1967ebf96a4e914801c7ef8328140456a10f41
  ++ rm -rf dst
  +++ pwd
  ++ git clone --no-checkout --filter=tree:0 'file:///__w/git/git/t/trash directory.t5616-partial-clone/srv.bare' dst
  Cloning into 'dst'...
  ++ git -C dst fsck
  ++ git -C dst rev-list --missing=allow-any --objects main
  ++ awk -f print_1.awk fetched_objects
  ++ xargs -n1 git -C dst cat-file -t
  ++ sort -u fetched_types
  ++ echo commit
  ++ test_cmp unique_types.expected unique_types.observed
  ++ test 2 -ne 2
  ++ eval 'diff -u' '"$@"'
  +++ diff -u unique_types.expected unique_types.observed
  ++ git -C dst cat-file -p bc1967ebf96a4e914801c7ef8328140456a10f41
  ++ grep file.txt tree_contents
  100644 blob d2cebd4f0a9e97a48a6139d09cafdb513ad8fee3	file.txt
  ++ git -C dst fsck
  dangling tree bc1967ebf96a4e914801c7ef8328140456a10f41
  ++ git -C dst rev-list --missing=error --objects main
  fatal: You are attempting to fetch 957c60b67968d2ab4144e7e2fbba99d6ad864e4e, which is in the commit graph file but not in the object database.
  This is probably due to repo corruption.
  If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object.
  fatal: could not fetch 3246c304205324149983025431c5211438f41931 from promisor remote
  error: last command exited with $?=128
  not ok 22 - use fsck before and after manually fetching a missing subtree
