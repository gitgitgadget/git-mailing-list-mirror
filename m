Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58738399A
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572344; cv=none; b=RIks2RX15+agFDjRYg18IUE796YRYWagVAKGBRz+FltKq7gHpRfjwZWllIl2OT8nN6gqYPYk77BAoJK/PRyrXuAs5xhZgiHtZRhELCZeBnLjCYiJpGTnivIZsT5pSZElblHOJL8oXa8xe+mc//WVg1SYuRdq2G3Fq8YhQxuVQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572344; c=relaxed/simple;
	bh=BeTTCSsZvpjwcEyDv81ap2M4/3xs5gv+DJ+0m+T6suM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a8K+Xb4biU8x238/UGyNO+ORtEQLiLWsY4nUNjgyOydatKpns7QfOj8GixNVdiXvgvUUHJN+qJxYrH0+Qse2B30fkFTQ6kv9S/AQy6+1DCQwvbnFe9nOvwvWU5k41iNOTbbzky0wxxXHxdItlm1FEYzGtDd5xfiEefBcnwVJtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qJWV7Kmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ucvpo5S0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qJWV7Kmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ucvpo5S0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E36A31400130
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 07:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1780572341; x=1780658741; bh=xbh0yW7ZVc
	Uv+GCk2dDLFlNdahyabVDtHNZWSf/d/bA=; b=qJWV7KmzNYsywQMzVoLrQ5DBU9
	e4QkRV9oTRPxwdhpF7Z1Vv4odn8QTbfNqvUKDuwjM+0HsIIxScZt1JuTMAiUvx6X
	2nI9T4nZwgE6yJ7SR51dakZ/ij8QDbAwHdNfHdaC/thoocSKW2SfAL6/tZSEsLAa
	/GJ0Vdr1vHfz7zpFnkuYDO6hv107wrIgdJEYggtERqcUab7tOj2voCDg/PRpOyTu
	/msxb+IPo1/WVtPcX/JWivZNG69yIatWQe6tX3GderusFD46erJHq1RqLpWJOHWH
	EaOoQ2PMwVIAQQwjVYbZwOIdBGziBt9KjptP/Zm3KnC3h2jziMe9nwAMKXbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780572341; x=1780658741; bh=xbh0yW7ZVcUv+GCk2dDLFlNdahya
	bVDtHNZWSf/d/bA=; b=Ucvpo5S0DBr85opw3l3PpVXq6CU9bBPqmMHsN5w16MNN
	R64N5icYqA8Xlky8Ma2VejCL3QL1LHt4dx+IRS0g2YxgqVuECNJ11zznXxDRYWOD
	UArHy3ax2mlv1lRZUbp6kVl6yqe3JJFyEICbPa0JwyVLAzM9bLj6wue+3MxsciX5
	pZj7fYunQpfAaFttWyq3MsT+ybpmiPJSCxvMzsSQD6q/5VF0i7mb+zHYtWvYDcv0
	a99Ys4mxBvA7UwgSKxJoPUHAG/rUbyMuMlLqa6TyW0Rybd/ofFQEnGJZVarlhRbu
	zuQsUzyoC+he656SRbze//oxm0d2Nn+1PoweK41eVA==
X-ME-Sender: <xms:tWAhal-gmqcO4U3eRhVuF0O6cBw6NeRMjCCE1s8UHetFqJwVRpZlsg>
    <xme:tWAhagq3HymIR1jTl4xxpZEg497cu4x1OmvbCx2FSwl1AuzbyKsEIodat5WxEtcEB
    L3UF59XXvOkcYDw2QpdrVJbI4vdp2MDce6K2p3DObJcK0eaSdol>
X-ME-Received: <xmr:tWAhaopWTuY9Q7pA_PxcrN-PkG8FE1acLfCu-NX82K5goradn2_qDqH4Cu2S4PkHID-5oKlmNdndh7LoLEzmK3K4v1wNiVMvQFst99_nB28>
X-ME-Proxy-Cause: dmFkZTE3vOMoReTMfFJvjRY/pDWzxJAG7tgTcevwl2qBcHztPNj+aSRFuvEw8btj5qXJSN
    oLGJmcbXSw8RaJK2bBQBl4etca/dml0lEljkvIYr3aYNxqUWCEzNONW1i2RYA9NJtiUUV7
    6+o3LSG1084Qrc9tikBEIc6tosFSQS25wbnuwcwjA9tCnvbpFxO2ZizP5ITCXsyylsaVkN
    +f/RuU6k4L4GBxxy3s/aojPz8dTY13I6HD2jmzbJKgVfTZ4EcwRmWd8rnDgRIjhu1q7/WX
    4/zpKbkwwdtHg3nkvzTsv4JL59rO2oeYYe9NMwC/MnlkGNX9kDAYCYm6foYRIZXqU7ehWa
    XURt5mfuZe52Aqw8T4fPM1OX7x1qk6CyNvwePQ4LzcV5cQRsNbhepRHqUQ/0AnA8mDHYlw
    6HWEAL+0u5iaFuPpZ/rd92yMHkjELiJSDIcsCoStY8w8vcd9sV9bxGc3Wj3D0PiLDl+9fh
    tyXCoBe/aWc3zjdILGDDy8h5e/Tj0/dgrdnweV18k56ayYDqmSb4XVPzLL6q1saWU1UEqO
    Xc/+hiRomZb83x7WhHW6FZy38gv6HfyYOpv3LnztGzWKO2SHs6TO4WowEp7cbVYQ2byGcZ
    JT9TjG9/uZVbfOz9G5X9TmZo6rCl5FzhQPLSiQ+cSAvA7EjcjR74BnfcJwfA
X-ME-Proxy: <xmx:tWAhaulVyEzDxaAePeD9AJuLmMfAqzUNxekrUl4c7Ee7U70H1OPKKA>
    <xmx:tWAhaqHfbJCIcMHCDKn0YpJ2CpbDBd4RuDBgs745KMJZO0-qjIz8pw>
    <xmx:tWAhanrKXNeIdzzGXzg7KQY0CLINEx5O58l7bL4IHS-EEuZL3vNqbg>
    <xmx:tWAham7b4pMhumx7qQNKaKEJ4-GbwfUcIMOEnXEXg9HPWHRtt2EJtQ>
    <xmx:tWAhapvxEb9MpfwgD5qt1mJsq474Ln9GDaPa2FHPb6OMEt8APGOdVIwW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a58ecd1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/16] odb: make packed object source a proper `struct
 odb_source`
Date: Thu, 04 Jun 2026 13:25:27 +0200
Message-Id: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdgIWoC/yXMwQqDMAyA4VeRnBfoIpa5Vxk7aBq3KNjSqAjiu
 6/bjt/h/w8wySoG9+qALJuaxrngeqmA3938EtRQDOTIO+8I02QYQ48W18yCqeNJAtY38lw3NLi
 mhdKmLIPuv+/j+bet/Si8fGdwnh/SXFQpeQAAAA==
X-Change-ID: 20260602-pks-odb-source-packed-3826c352f059
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series converts the "packed" source into a proper `struct
odb_source`. It's thus the equivalent to [1], which did the same thing
for the "loose" source.

This series here is unfortunately a bit bigger, mostly because I'm also
renaming `struct packfile_store` to `struct odb_source_packed`. Back
when I introduced the packfile store I didn't yet have the full vision
of how the final layout will look like, so I didn't have the foresight
yet to call it `struct odb_source_packed`. But now that the layout has
materialized I think it's sensible to adjust its naming to match all the
other sources that we have.

Also: I don't have anything else in the pipeline anymore that moves
around large pieces of our code in the vicinity of the object database.
So after this series got merged, subsequent changes should be of a more
incremental nature.

This series is built on top of 9ac3f193c0 (The 11th batch, 2026-06-02)
with ps/odb-source-loose at ef4778bcba (odb/source-loose: drop pointer
to the "files" source, 2026-06-01) merged into it.

Note that there's a trivial conflict with 8570d9ba31 (Merge branch
'wy/docs-typofixes' into seen, 2026-06-04) that can be solved like this:

diff --cc packfile.h
index ed49ab7f21,5729a37018..0000000000
--- a/packfile.h
+++ b/packfile.h
diff --git a/odb/source-packed.h b/odb/source-packed.h
index ef5a10b224..1d312f7dea 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -61,7 +61,7 @@ struct odb_source_packed {
         * that packs that contain a lot of accessed objects will be located
         * towards the front.
         *
-        * This is usually desireable, but there are exceptions. One exception
+        * This is usually desirable, but there are exceptions. One exception
         * is when the looking up multiple objects in a loop for each packfile.
         * In that case, we may easily end up with an infinite loop as the
         * packfiles get reordered to the front repeatedly.

Thanks!

Patrick

[1]: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>

---
Patrick Steinhardt (16):
      packfile: rename `struct packfile_store` to `odb_source_packed`
      packfile: move packed source into "odb/" subsystem
      odb/source-packed: store pointer to "files" instead of generic source
      odb/source-packed: start converting to a proper `struct odb_source`
      odb/source-packed: wire up `close()` callback
      odb/source-packed: wire up `reprepare()` callback
      packfile: use higher-level interface to implement `has_object_pack()`
      odb/source-packed: wire up `read_object_info()` callback
      odb/source-packed: wire up `read_object_stream()` callback
      odb/source-packed: wire up `for_each_object()` callback
      odb/source-packed: wire up `count_objects()` callback
      odb/source-packed: wire up `find_abbrev_len()` callback
      odb/source-packed: wire up `freshen_object()` callback
      odb/source-packed: stub out remaining functions
      midx: refactor interfaces to work on "packed" source
      odb/source-packed: drop pointer to "files" parent source

 Makefile                   |   1 +
 builtin/cat-file.c         |   4 +-
 builtin/grep.c             |   2 +-
 builtin/multi-pack-index.c |  29 +-
 builtin/pack-objects.c     |   7 +-
 builtin/repack.c           |   8 +-
 commit-graph.c             |   4 +-
 meson.build                |   1 +
 midx-write.c               |  34 +-
 midx.c                     | 118 +++----
 midx.h                     |  30 +-
 odb/source-files.c         |  20 +-
 odb/source-files.h         |   4 +-
 odb/source-packed.c        | 764 +++++++++++++++++++++++++++++++++++++++++++++
 odb/source-packed.h        | 102 ++++++
 odb/source.h               |   3 +
 pack-bitmap.c              |   8 +-
 pack-revindex.c            |   6 +-
 packfile.c                 | 701 +----------------------------------------
 packfile.h                 | 166 +---------
 repack-geometry.c          |   3 +-
 repack-midx.c              |   9 +-
 repack.c                   |   6 +-
 t/helper/test-read-midx.c  |   7 +-
 24 files changed, 1054 insertions(+), 983 deletions(-)


---
base-commit: 06d49cec508464ced5d42541890ce5d749542a61
change-id: 20260602-pks-odb-source-packed-3826c352f059

