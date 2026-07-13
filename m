Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B2276038
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953697; cv=none; b=Pb8H5CaC6yhW2fwlCo+6OTadzrWoApTCZrln5NVdVn+RjzbW+mhgDQK6SiDJUZX/DUb+O6CeRNgwOaZxA4zAGJ6fPgDyN47WePr2C6pvYmJj+ON+q1u7GC/JEVxweQ8QPMqh4ghzSwy2BdTGp7F/tKtm6iLaXU3sRFDp5/2u2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953697; c=relaxed/simple;
	bh=u55JSlCLUKGWUJr9BndZOCnTo4oFSryBihKy7RKKHLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=WCY0MN9wUywibYHf6xtLX8XHpTxQVtDn3rnDvezmwtVkHT1qQ4bKZhQSVDs8Gt1HSyNU38teNrLq/ZLc/Uc3YWOgwtq0/cy81Yo9Qltw2SpW2wfO3mf+3VXlPTC9EQ44PHkYje7+ViLb3eD1qWJVHT0RnpAJA962g96YJc5qfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BeUI5gVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxbx9NG+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BeUI5gVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxbx9NG+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B3BD7A0042;
	Mon, 13 Jul 2026 10:41:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 10:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953693;
	 x=1784040093; bh=Ru+OuMwTRgeIsq8iVZPOp3f8Da3lHw+gPafX84f222c=; b=
	BeUI5gVa5z5ngB3BfCCLViBz42KhP8BdG/n/ZB0Vm6K2wNlw6FTEkDXoeerKG4ec
	unNlk7xs3g2HnT0VeWGIV5GUuPggwAO6PKNsIDwqX0M4O1x59hMOTuSrD1q/K8HZ
	5WCY8G0I6OqXzZRAO+DniIB4dnxjt8GZhVzVUNsM18gKXDXG2isfOZFpQydNMSJi
	TExbL0c/t+IpmlmYJOltzI4ugvd4VG2c7LMDV+C2SXdfE+eCT4xwR4ZeLflS2iTZ
	YHeMUaCQeoJZtyQKSAJhXb/fyT9SmyIg2HvMm0R6pxTdlYZI2m65PfSDjwXIiNEl
	pFBZze1RkNfMy7IeyjtDgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953693; x=
	1784040093; bh=Ru+OuMwTRgeIsq8iVZPOp3f8Da3lHw+gPafX84f222c=; b=f
	xbx9NG+tTC7kBCTKJdj0zh4W9LbH06sk53MZc0HWyjSwFjBya/uhKWYO6wdLy1o4
	TbFdSKyMUhB3/8pPfX39o/EKQbn5tC7Cx4CEkU9B6xBRImkM5zEGiGWUiBH0uYtm
	rN/4k2t5c5AYuMAM0HyQugAfkS5OOTfCBDZvIcivPbjSfYRB6vmVql6NeTeAZmmB
	mcoreubA1jbO0U6dF+/9dtw/oc71Iwnw0lKbJDkzCYn3DkRU8TFY0KLVnG8IZT93
	qPYIyXWQFplnt5oSVL8MYVBjxpCxKWqN9VR4ffgudpa6ScPDUGhAAj1vZ1EmJSbz
	b/4kAmxa0ygAf4yTdDOmQ==
X-ME-Sender: <xms:HflUagOVXRDO143z5YNkryIXY2ErdRL_5u7EqDPyEyVcPGioSxkjYA>
    <xme:HflUat0Kqh8Ei7Q8M13opHNrWMDw-kMzdn5jgSh519R_IhcFa8iHZbrncKDPyZ-Iw
    qUl_W-gnCQHv7g69txdqA1FL6PggdpTwIbDH1ElEzxxohPGR0senww>
X-ME-Received: <xmr:HflUavnA942b839faloauz7qQHKx__UW2J7GI7iwO5bfaiqq-CkHHOGUxXNe5rmpk2RQ6fL2jDszoifFF_jjII-1Uj0W7dawvkEoUjd1>
X-ME-Proxy-Cause: dmFkZTF5sKcG50b18tDlCuyiQS9rLMg25TAnByyzukGN9SarjvNV8mvcv4nvyU+UMMFTwj
    VEcFN67a2/jw7fo9RXLwbDJdCubDF13OmP8DEiHNSM3pdfcqXPDNRfEWPJ4Q+ORRblM5ab
    sb+bSXtU0H8A5qtMzq3fxZ4PdBk+WpO2qHYL7FXtXCkBISKoD4J/++5ArK+YtQMzNmj/UI
    baeoTFSOO5Y7Axqjj8o7elaLr46/GT4ImWLT98I09MZwe8FHOlB5dX6OYyUsarF6Ph2wgf
    eykHy22l6WiHHMC1cRqYFPtySQyvn2yhzsjnD6sUGLD6hiXZnPmQE9F1i4ZC7MxbvJUnRR
    71EPZGoeS2jOnUNBttmEJshvAYHu8IfZ6P0zfbqPvPR4d/pmjc5CBiYLIU97tfRR/zvVcy
    pEvee6zOrSRaw7qM3HG7flT8ogn5Rw1O2N5o0u2M+pqlNi4sQl1+01vy3KkIb+1wKtUbEb
    1GWaxvQlbMLp6911bFNKw3aTSwgQUaLgXXUuUYx88Cj9eaNaQU/xdmXORQgKcLktQZBKjW
    P25kOYrmdEHsyzN37R8OPtueySQKwe3Pwi41N3kI7DlKxNHqCLPjKLkMr1ce926LJsMPXp
    yBrS39u0KAz5OyHiuXluPXOeQBEvaxQcXhKG1NEi7l7PQHvLrpYMLY+PdTLg
X-ME-Proxy: <xmx:HflUakUKCmOUXanX8n1vWBQi2t29V5aRsYF09jVXdvLu8oAx_1t1vg>
    <xmx:HflUalsaMrPz-zDNNQeq0SbLqTfYWxanHlMKrlPHcXbwbZTx5qOtUA>
    <xmx:HflUanZU44lUq9rJGVzUShcKnhut1fcd-cz2si_IMGb4jgIgn4nDwQ>
    <xmx:HflUakVCrnrPcNd2v807hdvE1imYKqZT5QZ0CZKHBhFysEzdQ6fH8A>
    <xmx:HflUaiqX02kvvH-3MaLng0JhDZnmffEAXY_TWAK9MMzZgmkOTdb2J86L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5fc9426e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/9] odb: introduce object filters to
 `odb_for_each_object()`
Date: Mon, 13 Jul 2026 16:41:24 +0200
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw7CIBREf8Ww9hoetrau/A/jAujF4qM0UImm6
 b8LNRp3XU4yc86MJKC3GMh+NRKP0QbruhTEekV0K7szgm1SJpzyku5oBf01gGsUGOcBpW7BqQv
 qAYy9DeiBCV6VRoqCi4YkSO/R2OcsOJ4+OTzmRabmRmvD4PxrfhBZ7n1l9ZIsMqBQcYOUbRXjS
 hzSYGPvJJsi/2MxusjiiSVSUdZas7KQP9Y0TW/bIYVwJwEAAA==
X-Change-ID: 20260708-pks-odb-for-each-object-filter-13286fa3523d
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
X-Mailer: b4 0.15.2

Hi,

this patch series introduces object filters to `odb_for_each_object()`.
The intent of this is to make `git cat-file --batch-all-objects` work
with pluggable object databases. Right now it doesn't because it reaches
into internals of the "packed" backend to efficiently handle bitmapped
objects.

The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
info fields, 2026-07-02) merged into it.

Changes in v3:
  - Weave Peff's patch into the patch series.
  - Link to v2: https://patch.msgid.link/20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im

Changes in v2:
  - Add another patch to drop the `_1()` prefixes that aren't required
    anymore.
  - Change the approach in `open_bitmap_for_source()` to also use a
    `found` boolean instead of a confusing integer.
  - Add some more explanations to commit messages.
  - Link to v1: https://patch.msgid.link/20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im

Thanks!

Patrick

---
Jeff King (1):
      pack-objects: drop unused return value from add_object_entry()

Patrick Steinhardt (8):
      odb/source-packed: improve lookup when enumerating objects
      pack-bitmap: mark object filter as `const`
      pack-bitmap: allow aborting iteration of bitmapped objects
      pack-bitmap: iterate object sources when opening bitmaps
      pack-bitmap: drop `_1` suffix from functions that open bitmaps
      pack-bitmap: introduce function to open bitmap for a single source
      odb: introduce object filters to `odb_for_each_object()`
      builtin/cat-file: filter objects via object database

 builtin/cat-file.c     |  76 +++--------------------------
 builtin/pack-objects.c |  11 ++---
 builtin/rev-list.c     |   2 +-
 odb.h                  |  12 +++++
 odb/source-packed.c    |  77 ++++++++++++++++++++++++++---
 pack-bitmap.c          | 129 +++++++++++++++++++++++++++----------------------
 pack-bitmap.h          |  10 +++-
 7 files changed, 175 insertions(+), 142 deletions(-)

Range-diff versus v2:

 1:  baf2adb012 =  1:  7c0dc1be0d odb/source-packed: improve lookup when enumerating objects
 2:  57eecf3031 =  2:  2e5908c9c3 pack-bitmap: mark object filter as `const`
 -:  ---------- >  3:  f4d66ccfc6 pack-objects: drop unused return value from add_object_entry()
 3:  92dd6a6f6e =  4:  af475654b8 pack-bitmap: allow aborting iteration of bitmapped objects
 4:  92fe41577d =  5:  6ca42587c9 pack-bitmap: iterate object sources when opening bitmaps
 5:  e5d59959e3 =  6:  f62c3bbc81 pack-bitmap: drop `_1` suffix from functions that open bitmaps
 6:  ab3547ac2b =  7:  b2d25b6e9b pack-bitmap: introduce function to open bitmap for a single source
 7:  026f21f522 =  8:  a5bf309bec odb: introduce object filters to `odb_for_each_object()`
 8:  534b25c817 =  9:  600b15a907 builtin/cat-file: filter objects via object database

---
base-commit: 3c8e2790f2ce15e8b5d4b4e6ced711b12649f32a
change-id: 20260708-pks-odb-for-each-object-filter-13286fa3523d

