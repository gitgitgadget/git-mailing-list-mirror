Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4976315D2A
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791299; cv=none; b=U/rgtuKxTEwiaSJc8izg5YaQ0rINo0ZvObT1QC3zjJHRqpJw3c0ZV1KccSTsRdxx4LQmM8y4bwZlnBZueFn9hLasqXUoslkfF6x3uQbsmdlNUr8KpsBARAhufY19y9XNF5A8PtrSY8Bp7jLN3vN5yArZ2or1QAOVgEohwqO0mcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791299; c=relaxed/simple;
	bh=+Hq21bmNsk2fwuLDyljrz7UYvJFuIM+4zgcx2iqIjwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=h/Jrl1jk8JPsyMSy9EcldM30O/IcT3+qV9Ol6YkG/Swa4gJuye2Teimffv66hzsaqtjF41J613skWsFBLbSvPqcqC8Arm2cBUBIHVJVWzAlnIHzkGjXQdfAMszPh+z74TX2KcvjCIqifLpbmVLCmBIprI+VcufkefRWEhGDytAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fhYCvkmo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UYI7Furu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fhYCvkmo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UYI7Furu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A87D2EC026E;
	Wed,  7 Jan 2026 08:08:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 08:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791295;
	 x=1767877695; bh=+WMtFnxRMfVEVK/NgYgjRmeeS0O1ctHZY6MmXWL+ISc=; b=
	fhYCvkmolm4cpIRRiJ/aX9NELpX0mFf4TvfyYXQsR/ugcOumnWINNvmuj7ouDkAC
	EcrPCndzUMKYhHA9gvMmW9soll1/oXG9ePfEXt+zI8OhB8rScENxq4BtRkw0m9SX
	q02yI+j/+DUku1sf3DNRlF+LLpiH/WpPmieAyBqhYH8o5ei0e0m/tTuqo1MYee9j
	S5QwdqFcoZ4886Sy8/vQeFd6dsVMNqxSCOnmAM87ZrOnizo0QadnQuO7n3Xn82Fc
	Cd2f8khm7bhhY7bvJsRswLVU0ReYm3Hc4Cz2RrUhuoX4tBBP/LR+y6MxiYAJ1Vog
	s+nvJhr4Waqu7J0SI6xrFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791295; x=
	1767877695; bh=+WMtFnxRMfVEVK/NgYgjRmeeS0O1ctHZY6MmXWL+ISc=; b=U
	YI7FuruasWBUN74ZCRHmdDG3HOiFcVAZQzTv64dAsM5zVZCc1+YrgSvZMoZql4as
	d5F7z9pM/pfdBNemq5JFg4NLLcuPUt+K3gEvS9YpA1s1kQvOjyA47xJAJHwWLdri
	WVi1al+kfUF41ANX/Ac2tkll83qBpJy/0/bzAGUm9oO5IwsppCLppq7kWUMyYt38
	cl0iJFZmuijEpVAcAfGeVJOJix4ZQCbXtJcxD3yjMv2UjGQgbE+Mw/3mNOr2S7Dv
	Igdsjm2+aDebl0OHcADxdgukjNhqIGraEW1y40pVOzIdBQTjSmPfmqeMueN9N4px
	pJD1hu8ttfyzLRzC3SdYQ==
X-ME-Sender: <xms:vlpeaYhMuVEy-i4qYLatyaeIb0lJMT0WiyN_i1MWrrxo0MG7N63GRg>
    <xme:vlpeaUsHebtJaOPfzy8GEjybfPwMY_U6ztyKWwMAqV5T3iWl6W9rOBmJ_2gZAkSYa
    m26ivjlRtv966dfXevlKbBQsfDUjOhRQqdCT1oTEBi3T9smMs8b>
X-ME-Received: <xmr:vlpeaZ7X_JrWNWBMvxPuh9-okelBuRVHGByO3GROegir3CH8o3uNbGX8ZAk6fG5wZoo8hyB497DPlCORly3WDEewTJov4w_dQnO5CS8quC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvih
    guihgrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vlpeaQMy9dQPHwc2T3fzasHkRaodnSlV_vwX_xUjpsNvHx4UOSg-vg>
    <xmx:vlpeaXvMjhItJFB8r7gOcFit_UyieSUQzt8otG5IHktxI7HoQlYfkA>
    <xmx:vlpeaTaxF-1_xa5FFkn2ykSEN8huyfc_meAHW65J764YjeYqYSbmxg>
    <xmx:vlpeaZxuHXybSxFwe74OT41j21C-xpK0XftLOwm2cXlMriCjh-u5kA>
    <xmx:v1peaZAoqW9bk6VZviaqz8UrZd0VrsclxuodFe6ZmtjDuAC9mpwRRzQC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12b7e581 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/7] Improvements for reading object info
Date: Wed, 07 Jan 2026 14:07:59 +0100
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK9aXmkC/53NwW7CMAzG8VdBOePJcdoSOO09Jg5N6wwPtamSK
 mKq+u4LSEziBhw/S/79F5U4Cid12CwqcpYkYSyj2m5Ud2rHbwbpy1aEVGvSNbgKpnOC0DuI3PY
 Q3A93M8joA8gwxZB54HFOgIxGs7e060kVbors5XJLfR3LPkmaQ/y9lbO+Xu8R+3wka0CwurOms
 dWeHH+Wvw8Z1LWQ6V2VitoQG672uCPXPajmrjaosXlBNUV1NSP5lrV3+K+u6/oHZfl+WIkBAAA
 =
X-Change-ID: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains various small improvements for reading object
info for either loose or packed objects. These improvements were split
out of a larger patch series where I'm about to introduce a new generic
`odb_for_each_object()` function.

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
 8 files changed, 124 insertions(+), 79 deletions(-)

Range-diff versus v3:

1:  5c67d9abe8 < -:  ---------- object-file: always set OI_LOOSE when reading object info
-:  ---------- > 1:  7708b50c2a object-file: always set OI_LOOSE when reading object info
2:  8b106feb28 = 2:  a96ac5b351 packfile: always declare object info to be OI_PACKED
3:  adbd3e5ae5 = 3:  8e3193a06e packfile: extend `is_delta` field to allow for "unknown" state
4:  218c64c9a5 = 4:  e718161286 packfile: always populate pack-specific info when reading object info
5:  dcae7be795 = 5:  217bec7e3b packfile: disentangle return value of `packed_object_info()`
6:  beac514592 = 6:  2aaacfd639 packfile: skip unpacking object header for disk size requests
7:  dacccf1cb4 = 7:  a9e37b7e00 packfile: drop repository parameter from `packed_object_info()`

---
base-commit: 7df68b50e49b6a1b576abb19b2e5d457749bc28b
change-id: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2

