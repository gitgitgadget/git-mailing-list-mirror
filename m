Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27056440A34
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668218; cv=none; b=pJVc9N0pS4lsj+L+PZ0pDaAKmQgmRvlfdqT5WIDlGu8Ih5BVRNuUzWWfRMfCG8o2xRnOY7zhsSa/rTJAHfNorPirPjY8AOyG0bLk6ZYeaw8QoRYxkzoXJyu5rx8RK009BfGZVezEtSz51wZfmg6Z640/zFT/+h24Dpz3SdCJfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668218; c=relaxed/simple;
	bh=aF6OoVtlGXalC/GGs2TVAecSzWJb1RMZiD8u4McwZT8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CrpCVLjImWMccEYuqpmD9KuFCmKEiDT7/2VJpR6CUcxJtCtwU+DCjdYARn5fPu1tglnM1inYyKmQpSxfoarsW/UvIJGboLhNtFf7JXKUxJOdEufDIwdFuiRNMLoOoT80S+CRWccaUvKXXi4olS4T2EdMG03IxLtOvqXY4E1fdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m2IdSXYb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFJyBNtL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m2IdSXYb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFJyBNtL"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5556B7A00E2
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 25 Aug 2026 10:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1787668216; x=1787754616; bh=Db+8IL5DEW
	dWzSBy13ZL3/UkdC9SCP0iWj6bb8D0dac=; b=m2IdSXYb0o5GByjbs19CGmLh6O
	zvkQpJDgmZbkGJ2hsB689Pd4whybmw025JMw3c9UAVbGExoDD5aqENUXjmwFpEnh
	vGSdryNSS/ZYq/PhQlE4uNBSeJG/cuBgqSw2xmkpeCNvoObkbYPJ4IRQpQBBfeBJ
	DqloJaK/HjMX2XaQUcZzvFWYsXn1jbOvY6GDVZIwl9yqPZj9OiSTww9gklCpObxL
	ueaEV9Fjk2tWAAoY8fIPG50NTnmTeHCITM393gGzJYAe0BUM/shdKtf5OekTNZf9
	xYngSyrL7ezk6wJVQliR46iVZKguT+GnCEyAORITA/t3vNO4ndfDUeEDqapQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787668216; x=1787754616; bh=Db+8IL5DEWdWzSBy13ZL3/UkdC9S
	CP0iWj6bb8D0dac=; b=TFJyBNtL1Q81h3gVWFZlhgliTxCzYQi23Py9pUwXLS4L
	ejNs8s1RDw5ASSdGfZ02f657//MwOcjukkDscj/sJgTjbObE+U8ocZnbtKqf5Itr
	kall4do4avgTfQOBh9DgwIL+kbqXKtMyTx66gb8AGQXbcfte4fn1X76d22gAUBw5
	XcsvV0AP0L/WuZgsFS0b1h9TmA7tKnwikZ1QLrAs9COgxa8OkcpgwY6l7Uuez9ND
	ObcupefDzUOFnQwWle8TdUPw3k5S7QeHw+T7RIXkhOeuKLXgGmy9zqTjYYxUzxca
	AWDa+O7b0svfZBHy9K2gDNS1kSFYZ9lsGvoO5JjTqQ==
X-ME-Sender: <xms:-KaNag41OJ5laVOMtNkYAnUpxIhwv-7N2mQV1XPgY6PHJf2PZ-Dp8g>
    <xme:-KaNao0_IZE3pJGKRV6iN20yt-k8GW9LZWdX-wF2lDbokNDQfivGZsfyUjVFpis6I
    qxSeyEuSuK3OrnzjFU_z3LR_cOJbK7oe5UmTMRZFpNajL6ItohPJig>
X-ME-Received: <xmr:-KaNalEoXwJSTDSJVheQbj_3BK2Qjz-WacS4ZPs4WkKALctaOhLBdebPhRW2OEBy3IoM9Y3bZo8H43shXZu8Ki0EuCkHYpbMOAEumXh2YQ>
X-ME-Proxy-Cause: dmFkZTEYr40wNtBQWcDJSe0UNekzAAUSiWyB6ed2QP6hrMFQBPAe1l8rpkkJbOJLCOw3lR
    FWXcxv0pAJrC4Z/X1XOKmH3Inw5dmiExextMzAoL/m9qkP2SwTvnZ2+ZhgWdzywMu4UiYG
    uvX7jIDh0OXbVjRGBIVABx1mHKKCXFJQTtv4jiud7KT1XvhsyOzGuRvFXUTifY7ohaIdxh
    0e87j095HI6Wmo5n5CrdeqP1dI06blytj8rhvRnKhd6AsBvqbUJs8T4FDwv/BJi2Zrrp8e
    yw/mIqV7d+LLi5WMvzyV4hqySQvMO+HGoLAoRihDOT8e0KgXzEd1+yFzsj4ZWrsVhBA+hV
    ygDXrxIAXutXtRpom7So8JQayZpmKNZPJfUccMiXu3RQau0YZAdwDtkfvl8zba5JmzrMXG
    Ynorrqc0XOn4WpX0kNrZ7Q1u6sPiEVPKo5za3owfaxVHQW7gLC46F9snOPzmmtzpGNosOd
    w0VL+LgScwghIX669YVw3aUNsgY0DN4O/SLtzE33bm78+Fh5g6t/BqL8NxMFkWuKHZ+9nn
    Vq9079WJHR2km7+S9iB0dOeMZ8zic1X4L1nGXkVrBXgtmnH4RF6vtQeFXLLZCSbcDhkRW4
    HhbbG5ky6iSe7EjiAYlZcdi4wROE857smRmKSFtalWYNs9nmBWfwUL1yVHqg
X-ME-Proxy: <xmx:-KaNaqRx3lEdWGw9Hw2yrblV4KkKsY-lXEQeswNoVdhprmAgege4SQ>
    <xmx:-KaNakCwJFImbFwXpqzPWK0aTKO2tyc8Nwsz9SuoDt6MGSb25jCwIA>
    <xmx:-KaNai14o6xdDLkzQaru-UUklSibVChmR-HBjALXDEO_ilqiiVYs9Q>
    <xmx:-KaNaqWiDT4zvDSgW1UyXaCLhgQHidsqExd0xntd75lg7nSoc5_8CA>
    <xmx:-KaNahZyouYhEVbHWG93iD2nmemaV9BRqNvGzvjtj_vGD9fjmAhRpLpP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea8b8fb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] odb: make consistency checks pluggable
Date: Tue, 25 Aug 2026 16:30:02 +0200
Message-Id: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJaZQar2JcyPAXBhJKOmJMC
 He3yvJbvLeRISuMbtVGGW81TXNBfapIhufcg7UrJu98466142UyTl3LltYs4GgyMZpzCF4CcIl
 UyiUj6ud/vT8O29qOkNdvRfv+BSw3YYx3AAAA
X-Change-ID: 20260810-pks-odb-source-fsck-e64772c7ee5f
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series makes object database consistency checks pluggable.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with the following two dependencsie merged into it:

  - ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
    `alternates_db` field, 2026-08-17)

  - ps/odb-pluggable-pack-generation at 5176dd3d05 (bundle: generate
    packfiles via the object database, 2026-08-21)

Thanks!

Patrick

---
Patrick Steinhardt (10):
      builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
      builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
      builtin/fsck: de-globalize option handling
      builtin/fsck: don't check alternates with "--no-full"
      odb: provide infrastructure for pluggable fsck checks
      builtin/fsck: move packfile verification into the packed source
      builtin/fsck: move reverse index verification into the packed source
      builtin/fsck: move bitmap verification into the packed source
      builtin/fsck: move multi-pack index verification into the packed source
      builtin/fsck: move loose object verification into the loose source

 builtin/fsck.c                | 296 ++++++++----------------------------------
 odb.c                         |   9 ++
 odb.h                         |  33 +++++
 odb/source-files.c            |  13 ++
 odb/source-inmemory.c         |   8 ++
 odb/source-loose.c            |  92 +++++++++++++
 odb/source-packed.c           | 117 +++++++++++++++++
 odb/source.h                  |  21 +++
 pack-bitmap.c                 |  26 ++--
 pack-bitmap.h                 |   2 +-
 t/t1450-fsck.sh               |   5 +
 t/t5319-multi-pack-index.sh   |  13 ++
 t/t5325-reverse-index.sh      |   8 ++
 t/t5326-multi-pack-bitmaps.sh |  10 +-
 14 files changed, 394 insertions(+), 259 deletions(-)


---
base-commit: 6b08999fb1b3ad0bad04d492dc206ad42839e274
change-id: 20260810-pks-odb-source-fsck-e64772c7ee5f

