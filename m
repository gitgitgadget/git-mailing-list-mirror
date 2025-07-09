Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588D5383
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047721; cv=none; b=amSntoNsjk9kq0LBL57AIwQa+MiUXqN1AURQgaeCJNS4DivdEhkYBnJKE4vqyz/7flnsP0578Ywt3VTf3d6J/hTg0ncyk1pKkMWWjlORpxuur3Zocol3zDUNyz8UjE2jRUcuKVwqtMOyWUn0uGrzrLkU2mpT0lVPyZer7ECvZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047721; c=relaxed/simple;
	bh=wO2EERqe1XC3pKXMt1A3XmpQPz45k5I8Gi0gPmD2hoU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b6EsIiEJtllslUOq4pe+/5I4IkRkJZqTiXu0sOASuxBK50F7VznSncKCXr/iLFVW5l5+nwGeU8IY+ihZ+8MJUyWAdJe9qBOxFagyX8wOdLjW2mb2D3FFF1CngikzCI51rSpfS6XJtIk2PLUTsUFqtaYA2PQEI9fqwum+ka2YRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uzQ+yfhu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WX8f4Vgd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uzQ+yfhu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WX8f4Vgd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB5511400231
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 03:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1752047718; x=1752134118; bh=De24GmpxPO
	MtiD6b0GX7f74ShV2SE34BSxwfbq8CRBk=; b=uzQ+yfhuP391H4PVFiHh7HB8PU
	YxfXPAqs/KEhlcdiFiWKPWyUW1vrjiVJA7tIDFfaXB+AzggUfEUk1Pni8uMJx6oV
	OG7r1sckZlbuLoAsznFLmPWng/Bfz8FbpRAP7eb6PBJlNEPvnRHTYQry4yb0OoHg
	8ARG9umNjlzSGlRNLoKNGH5NQVA1c57UDZj2GYnj7KJaW054s9fv3XupD1xmo7Al
	yZ9MY6RY4MHFxDAEZld8a1YoEFrhloDebvlfAR2d9K7Wgwjh6V9NvjBehnHgq6Xl
	6hq0fp4yWar3APwIZ6XQtTuUxAe2PSC2/ua/qq8zWni0ytgtO0gBimjBm98w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1752047718; x=1752134118; bh=De24GmpxPOMtiD6b0GX7f74ShV2S
	E34BSxwfbq8CRBk=; b=WX8f4Vgdr20nWI0AKM6r+on+avU8jcEzgaTvb3SSvx8M
	0AkR81oq2I1yQ+1hO3oZObwVeGDkgGZROue4zKJL1/5kf2/4ho/s68OJjJoYCxDe
	cSTfrxcHOXor2mbLCR9F8TZTXIynYfzR4zrljlHcN9ZjZc0YQ5zKIWaOsu+90pt5
	kv9BZCZquQua2L6sozcgn9qtOjsxWL4gCkNLHVRnIB2vGZbJdAwZKIjX8TKzfBx8
	9tudbXTPeycnw6bBUBZ19Eof5yOdKQIyszbEBfkxVD9Jj/zFjsaNow0zeY2mkOrB
	wpUMZFdxWoVUtrAwEY5W+TIxRv1FLciuwyG8uT31fA==
X-ME-Sender: <xms:ZiBuaKEMIE48DKMbh6pohZyN_xElw3HWAMqC1yUdChx3-GVhGGHAYQ>
    <xme:ZiBuaNVxjM04iYIFlvRUSESSjlqkAxQ03K5DgnEP5v1uZlVAzd-AT8l281QHvb8-s
    OHkn91IkY80OTnfPw>
X-ME-Received: <xmr:ZiBuaNhW48FYywWT6bAVycq80757LGr8pewYfkfRs5XYuF3xMno90iKeMyI8X-_M1XKK7JcfVG7PsxOvGPqTwvb5KiSTxowAX797Ws8pjt5FlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZiBuaGT_Fs48RXXselrF8HzxyoBf392EorUqazyRROvYStWDxwAiCg>
    <xmx:ZiBuaIGCGVMPXiAT070R3cgNK79duQXbwnOGs0gONsg2IOf-QoM2ow>
    <xmx:ZiBuaGmAB4mMfLOuEHj9PDqpMY-YB9icqPvI_uQG1-wWNqqpMqrcgg>
    <xmx:ZiBuaD2i71xOXb73hzUBy7Sq_2VIrlnhHu6UWJZqfkVevauUIoOfJQ>
    <xmx:ZiBuaFPFUI3AKJwFkqeSmz89FCzgF622363Et3CtQfPJAsE0C8khEDz8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c1b8c36 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] odb: track multi-pack-indices via their object sources
Date: Wed, 09 Jul 2025 09:54:48 +0200
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEggbmgC/x3MwQqDMAwA0F+RnA3U2oLzV8RDaqKGbVVaEUH89
 5Ud3+XdkCWpZOirG5KcmnWLBU1dwbRSXASVi8Ea641vWgwO93fGr/KFpxJuHJA+h6RIhyC74F/
 OkO0mhnLsSWa9/v8wPs8P/x+EH28AAAA=
X-Change-ID: 20250513-b4-pks-midx-via-odb-alternate-d4b5940a28cd
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

multi-pack-indices are tracked via `struct multi_pack_index`. This data
structure is stored inside `struct object_database`, which is the global
database that spans across all of the object sources

This layout causes two problems:

  - Multi-pack indices aren't global to an object database, but instead
    there can be one multi-pack index per object source. This creates a
    mismatch between the on-disk layout and how things are organized in
    the object database subsystems and makes some parts, like figuring
    out whether an object source has an MIDX, quite awkward.

  - Multi-pack indices are an implementation detail of how efficient
    access for packfiles work. As such, they are neither relevant in the
    context of loose objects, nor in a potential future where we have
    pluggable backends.

This patch series thus refactors the codebase to stop tracking MIDX's
globally. Instead, they are being pushed down one level so that every
`struct odb_source` has an optional MIDX itself. This simplifies some of
our code and will make it easier in a future iteration to move the data
into a packfile-specific object source backend.

This series is built on top of a30f80fde92 (The eighth batch,
2025-07-08) with "ps/object-store" at 841a03b4046 (odb: rename
`read_object_with_reference()`, 2025-07-01) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      midx: start tracking per object database source
      packfile: refactor `prepare_packed_git_one()` to work on sources
      midx: stop using linked list when closing MIDX
      midx: track whether we have loaded the MIDX
      packfile: refactor `get_multi_pack_index()` to work on sources
      packfile: stop using linked MIDX list in `find_pack_entry()`
      packfile: stop using linked MIDX list in `get_all_packs()`
      midx: remove now-unused linked list of multi-pack indices

 builtin/pack-objects.c |  9 ++++--
 builtin/repack.c       |  4 +--
 midx-write.c           | 22 ++-----------
 midx.c                 | 38 +++++++++-------------
 midx.h                 |  9 +++---
 object-name.c          | 21 ++++++++-----
 odb.h                  | 19 +++++------
 pack-bitmap.c          | 20 ++++++++----
 packfile.c             | 85 ++++++++++++++++++++++----------------------------
 packfile.h             |  3 +-
 10 files changed, 105 insertions(+), 125 deletions(-)


---
base-commit: 1ad11c8963b6902bb6a98f5071591ad358329fe4
change-id: 20250513-b4-pks-midx-via-odb-alternate-d4b5940a28cd

