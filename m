Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58F3128A0
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208460; cv=none; b=u7npimXSGpmx393VBvCA7lCEE74/pWXKHLOSaLro7ao+ecXOuKPWk6XXlIxfcdOI+FJ3tZlerjud8tAh7aRWHayutj1HX0QBzF+XGyGsF0e21V1ur+RPdWwWhPG3hjCKBHWw6NL/3qwD4RrGkOhDvzV6m5SBb2Tdp0XJoDGhe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208460; c=relaxed/simple;
	bh=Dxx2FUXrr0G+h8ym08pIzLYJCJ6e2aP9z7MacpJYyNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=moBrSw/rZNqhYtMQWL8xpOzr4MoJQPf4P90LEOq7NjB7kKu+tsjC+LA5MqayG2Xb8e9ygcCBDF20QUejFIZ0+A3LGdWq1nkntW1IRiq0dVZFYGEyYB84cemcy7eFbUAiol+4yKaW3vVJ8iyD3Tcp+RXoFp3UGvgLyQSNVmcCD/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ecuEQsxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HNfq01ns; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ecuEQsxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HNfq01ns"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F9627A0040;
	Mon, 12 Jan 2026 04:00:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 04:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208458;
	 x=1768294858; bh=5iWfz490eSc9JUwNMyv+a3nRN7L+QEkNukPiBeiW3xg=; b=
	ecuEQsxYRl57he0ZmDeTg0fAGnp4ihO7ts7UQ25dc1sjKJ3JpJODNfjYeOUZyOXP
	HELukOGrhmVrh/SYDLpMfHWNzP97P3Mm4FIEKnzq+ceFGIZKXQpdF/nOpbSzUju4
	5qQvcnCyHs5nrXVqhudRE6Fvc1+ult7UxTDwiCyan3+AdNuJdCJz3ZAbjcE3qEMq
	QvH9hCEKpipH8P918iWn36A3sdl4POiBO/TSSmmf0o7xSAZZeppG2Bp8VtFEnklq
	zsvikNBLugD0eexOjHr8F/+S+hYW9i8US+rPXTKonKfTMRfxts+dkzvCszGHPsV4
	tR5AOP6NldO3M+SB+FxGjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208458; x=
	1768294858; bh=5iWfz490eSc9JUwNMyv+a3nRN7L+QEkNukPiBeiW3xg=; b=H
	Nfq01nsbVyz3gQPFEflDzpSXXznPg89fvxUDYbdJw6CT7+/GbI0vpTWDwQgTRBml
	b/Iqbkeg+R4yNnQxlgwGrByRcKwYYgtePrvYbdkF9AIlTy1s3NPV6N7ZzAKLggs3
	Y7ZDPfACu588dRRlOe0HA7lyBzVH2m8P3eRQ66OVGKuhK3csvecbilY0vKpIs2NK
	M5vnolsk82jZiXqsbsQKlXGdAV/A/urqZIO+xj39Q78F2i27veblmITsfAtWmSay
	jxt9eeStWNKQbz6wzJFRDaAnClEH19PjeyeI4fioxc+YohSW+bLcDcYxOgvaZwOm
	5IZxyQ3Pr31mI2zXYcRig==
X-ME-Sender: <xms:SbhkaevaI1YTsj2VPPDwb3KNCRaiy_vxhmk99bfvIt2tK2GhWvfyxw>
    <xme:SbhkaVtcZX29Gl97s68jXth5SV2YFH1YwS3YhEYDOlyKW9qs_4Ig28pQeUyWo2afX
    T2qLGQYXKGpV6DdTv8w995qYdXvZ3DONQgeeZeI7kXv5PYdMBOuug>
X-ME-Received: <xmr:SbhkacDwSW7EMmZpJjpnb5o3DsGzPklDHRgxMO23BsD5-2SRn8G-H6oittob3Da57aHTc4jjuaW_W1p05JPbCQNWzmpUVtkDBogywjIWbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevvdfgieettdefleefleejtdehgefggfdugffhudeggfevgfektdekkeefhfen
    ucffohhmrghinhepsghighhfihhlvghthhhrvghshhholhgurdhsohdpkhgvrhhnvghlrd
    horhhgpdhprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdp
    rhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohht
    tghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SbhkafNvd2NA5t8iEvcw-nXvohPnWagPJOG6lxs09avECjuMb9BZNA>
    <xmx:SbhkadzQJ95Y3gxiEzOSsNt2hFSeqHEwAAwp_TY8-0WZ9n-j8saqcQ>
    <xmx:SbhkaXX1tgHV7KaR7m7aDyODY7GjKLh24Ch-atvzSN-ghCGQ2E5i3Q>
    <xmx:SbhkaXP8I03lqeHm1L3JkDOG5ViBwlst2nE5YLHbJwmkd2wl28-ubQ>
    <xmx:SrhkaXyfrkLCgqzWjCFHPB0MPeMwXpbCUIBi-PeIGf_CVNd-v8KY2Qe0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:00:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e107a01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:00:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/7] Improvements for reading object info
Date: Mon, 12 Jan 2026 10:00:40 +0100
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADm4ZGkC/53NwU7EIBDG8VfZcHbMMEDLevI9jIcCUxdNSwMN0
 Wz67rJN1rg31+M3yfz+Z1E4Ry7i6XAWmWssMc1tmIeD8KdhfmOIoW1BSEaSNOA0LB8FUnCQeQi
 Q3Dv7FeI8JojTklPliee1ADIqyaOlPpBo3JJ5jJ976uW17VMsa8pfe7nKy/UasX+PVAkIVnqrO
 quP5Pi5/T3GSVwKlf6rUlM7YsX6iD05f6Oqq9qhxO4OVTXVGUYaB5ajwxtV/1b7O1S9q8EYr3u
 0NPyo27Z9A5z7DhXfAQAA
X-Change-ID: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Matt Smiley <msmiley@gitlab.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains various small improvements for reading object
info for either loose or packed objects. These improvements were split
out of a larger patch series where I'm about to introduce a new generic
`odb_for_each_object()` function.

Changes in v5:
  - I discovered that this patch series incidentally fixes a segfault
    when using git-archive(1) to read deltified blobs that are larger
    than "core.bigFileThreshold". So the only change is an added test
    case that will detect this regression going forward.
  - Link to v4: https://lore.kernel.org/r/20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im

Changes in v4:
  - Extend the fix for OI_LOOSE and refactor the whole function to have
    a single exit path as proposed by Karthik. This results in a lot
    more changes, but makes the function way easier to reason about
    going forward.
  - Link to v3: https://lore.kernel.org/r/20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im

Changes in v3:
  - Fix a commit message typo.
  - Fix a function comment missing some words.
  - Link to v2: https://lore.kernel.org/r/20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im

Changes in v2:
  - Rebase the series on top of master with jc/object-read-stream-fix
    merged into it. I've also evicted the patch that fixes the same
    underlying issue.
  - Improve the commit message that drops OI_DBCACHED to explain why
    this is a safe refactoring.
  - Link to v1: https://lore.kernel.org/r/20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      object-file: always set OI_LOOSE when reading object info
      packfile: always declare object info to be OI_PACKED
      packfile: extend `is_delta` field to allow for "unknown" state
      packfile: always populate pack-specific info when reading object info
      packfile: disentangle return value of `packed_object_info()`
      packfile: skip unpacking object header for disk size requests
      packfile: drop repository parameter from `packed_object_info()`

 builtin/cat-file.c     |   3 +-
 builtin/pack-objects.c |   4 +-
 commit-graph.c         |   2 +-
 object-file.c          | 115 ++++++++++++++++++++++++++++++-------------------
 odb.h                  |   8 +++-
 pack-bitmap.c          |   3 +-
 packfile.c             |  61 +++++++++++++++-----------
 packfile.h             |   7 ++-
 t/t5003-archive-zip.sh |  34 +++++++++++++++
 9 files changed, 158 insertions(+), 79 deletions(-)

Range-diff versus v4:

1:  07f529a631 = 1:  da9d514001 object-file: always set OI_LOOSE when reading object info
2:  b547df2885 ! 2:  c7b29f3789 packfile: always declare object info to be OI_PACKED
    @@ Commit message
         Drop the OI_DBCACHED enum completely. None of the callers seem to care
         about the distinction.
     
    +    Note that this also fixes a segfault introduced in 8c1b84bc97
    +    (streaming: move logic to read packed objects streams into backend,
    +    2025-11-23), which refactors how we stream packed objects. The intent is
    +    to only read packed objects in case they are stored non-deltified as
    +    we'd otherwise have to deflate them first. But the check for whether or
    +    not the object is stored as a delta was unconditionally done via
    +    `oi.u.packed.is_delta`, which is only valid in case `oi.whence` is
    +    `OI_PACKED`. But under some circumstances we got `OI_DBCACHED` here,
    +    which means that none of the `oi.u.packed` fields were initialized at
    +    all. Consequently, we assumed the object was not stored as a delta, and
    +    then try to read the object from `oi.u.packed.pack`, which is a `NULL`
    +    pointer and thus causes a segfault.
    +
    +    Add a test case for this issue so that this cannot regress in the
    +    future anymore.
    +
    +    Reported-by: Matt Smiley <msmiley@gitlab.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb.h ##
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      
      out:
      	unuse_pack(&w_curs);
    +
    + ## t/t5003-archive-zip.sh ##
    +@@ t/t5003-archive-zip.sh: check_zip with_untracked2
    + check_added with_untracked2 untracked one/untracked
    + check_added with_untracked2 untracked two/untracked
    + 
    ++test_expect_success 'git-archive --format=zip with bigFile delta chains' '
    ++	test_when_finished rm -rf repo &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test-tool genrandom foo 100000 >base &&
    ++		{
    ++			cat base &&
    ++			echo "trailing data"
    ++		} >delta-1 &&
    ++		{
    ++			cat delta-1 &&
    ++			echo "trailing data"
    ++		} >delta-2 &&
    ++		git add . &&
    ++		git commit -m "blobs" &&
    ++		git repack -Ad &&
    ++		git verify-pack -v .git/objects/pack/pack-*.idx >stats &&
    ++		test_grep "chain length = 1: 1 object" stats &&
    ++		test_grep "chain length = 2: 1 object" stats &&
    ++
    ++		git -c core.bigFileThreshold=1k archive --format=zip HEAD >archive.zip &&
    ++		if test_have_prereq UNZIP
    ++		then
    ++			mkdir unpack &&
    ++			cd unpack &&
    ++			"$GIT_UNZIP" ../archive.zip &&
    ++			test_cmp base ../base &&
    ++			test_cmp delta-1 ../delta-1 &&
    ++			test_cmp delta-2 ../delta-2
    ++		fi
    ++	)
    ++'
    ++
    + # Test remote archive over HTTP protocol.
    + #
    + # Note: this should be the last part of this test suite, because
3:  28940ce932 = 3:  ef5ac585f0 packfile: extend `is_delta` field to allow for "unknown" state
4:  c13c74467d = 4:  2a844d61fe packfile: always populate pack-specific info when reading object info
5:  d3c17fcc71 = 5:  a23f59d530 packfile: disentangle return value of `packed_object_info()`
6:  1c598686c5 = 6:  f246dc3745 packfile: skip unpacking object header for disk size requests
7:  afc5d85991 = 7:  a0c4f59547 packfile: drop repository parameter from `packed_object_info()`

---
base-commit: 7df68b50e49b6a1b576abb19b2e5d457749bc28b
change-id: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2

