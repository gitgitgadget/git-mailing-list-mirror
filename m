Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A984418FC
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926468; cv=none; b=U8J4aCSPFmiGDh+gpP6vB8CjC037Qw4C1d9ZW6z8x9FVIs4uyz+EFksFTVTFSAy3myV75qcfoWelq5BuaAZlRgsO6YOYrGO5IvzzMR5qj543AAJXHUxKSrbiY5xNavThQdEMMwSsKhjP1WFuWrWS69jfUhUERT5sLwsE5UqT5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926468; c=relaxed/simple;
	bh=8EUl15QyV7GZtH3A+JbxTWkmBeHdcVIwvo3deNwG1PQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bcSt7hw2dqxP5aHppGmKJsEpAKWu/oAIJknZGsjGNWQBXOA2aicEF6AbVYiX98FAgXGKmbq4WzwfoRXPRhxNT8dZfjqZz8nORj62GBKkq5Sy1A3b7amMQFUMucVbu1VTvcbLt+/yYbi+i4YGM3qeEFDyPlheE099zCoLwtmmkU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ba0eRIUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJl3Hycz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ba0eRIUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJl3Hycz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5299C14000F3
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 03:34:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 03:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790926465; x=1791012865; bh=xgGNbAx7yT
	zqjfhKTYPpIHpjxUF+L0/+8drFFDAXZo4=; b=ba0eRIUMQkE3MsQEYomALMBnRN
	IQg+dIuhLZPEJMWb3qW6ZIOI1IXxNCFCdfCXnDPQFszGhUkUBz6y6/L7/+NUoT/B
	xamyjIE1MBqf5RiHmNMxHu08yoqy7eXzg37O+NAgYoNtSKy6vLdgfJTmSCmRQrRu
	CNmzqdVkTUiMKDFxByamwcINYzVMZp5MqNXg63wCy4/bLWl+DxkT7u96/tMF5EOB
	PwtjbRGqacCsXbPOhXp5w0j+JkAOOGp2hS987uXp1DyJAuJQZ/Cm1s8t13J/80Y4
	sf1R7pW3fvY9qdFvpOYwMfA6CP/ePigqz/gPP2hCn704JIo6Rqa88wSItjHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790926465; x=1791012865; bh=xgGNbAx7yTzqjfhKTYPpIHpjxUF+
	L0/+8drFFDAXZo4=; b=fJl3Hyczoa1ivE2t9bP2KBPWVHm/93M5Kl16XJru0RuG
	Tfz7i5UMSrjIG0H4/ryUmpwvmjnSQ1ZpZqPuCR+vyt3N6dLUWsUkZ4Od1EywSsYM
	7jX5rkx5XUIlXJE3X6aAJPFUdnicbSHWjKur3MOkin+7gH5hjyOEsHfGpSbJvFbf
	BVN2iXdSGhq7lCnbiYWISOS+q6pJxF1g+kIXVtg6HRx20cPFC9OGrJrpwptjKCYe
	gmlXvEoaUjaN5c2Wrdmg3HH93/LsWKX6VewbFcmtxzfjqV0Bpl2QxsB4SKrT0ETi
	8eKzvuZVoRRwv391ZCDlI2BU20IkEw5/61y6w+Epnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790926465; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:moVMCLgB+VwYEO4WVpqJzLklfFTgbVQE5oKNNxXBLkWLyWB
	LiEPol6ZhcMD48dBD5FCieDejYo8UAoZmWt5RXr0SGPQD8iAS+Jzo05mBkE/BQR4
	dIHJIwWclq1NwAb7BHW96BiNaq72l4SnOUDmQsevRYpAgVkC4P6ZkwS+g+gmkWDx
	w0KswAHOWW2ncT+EXsb1FAaGxbZYAua0TlOog8VKhtOFvHB/mNt0L3VAbjp+aS6q
	Yffx+SjbVVpZRKthH6BS18UHUjy3DMffgCrG0kMPlZJrKC14WbynOgq386nGdm27
	KBV6RQaM3kI0ulidj7i2dPj8mITrgIN7DPebthQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:5/f3EifAlUyUREsopxIPB1bYo3GCA5CuG23HEUb2oKI=:8EUl15QyV7GZtH3A+JbxTWkmBeHdcVIwvo3deNwG1PQ=;
X-ME-Sender: <xms:gV6_arL6qDDc-QoplNL4Y-nUpq21GHEY_8OsIs9A8C6MGxekrVDpVA>
    <xme:gV6_ammhGLO7SZ_RA3kMqOhvEgvd6U4R9fDQkpjMeWd-MaD16hvFibp4pLnA4duHF
    07Ja_aQvFkt0ymaCoWpNHXgm3JAY1vTO4kkvNpHFkV91xEkO-LoRB8>
X-ME-Received: <xmr:gV6_ahEYy3GKCGtHhZTElw26BUUjbRPcjbGAlmvh5O7AmXk_IGKlMw>
X-ME-Proxy-Cause: dmFkZTFumxFinNjhEzCwACfDeCE1kmf8QydOA1h2BpX/+LVHo4CUNGDiLPG6Cb1/607Uwr
    ujo1dGyOamnkeUm/GekHJixGzYTzrai3UO9Hfr9GM/Wzj9KecKzkpXXLfjZKky+z70w3+/
    8Nk/SS2iZcgyhZZYMpDJGYb31/DnSnEXKPwEKolZw/yBIPDkGMnA59f4o4X7y38n7kOHZK
    ClEYaFg6qbF2/2NhPIWoXJ3d9uSr6cQrJIV5zcfGnMBXBVDLRcRYU6RzjuVgpFbs0NLRog
    AOgSyxSzPM/jBLl34dAuKVIo8u/JnE40oL+TVGm4hrDE9IdLqojd1FvqwEpiLWEnlktyqQ
    ymep62nK7MOVrfT2aTJxeVDLGjvajJujTea+BJ61EHMkwKyZgecg6qe+cbrkEgvXKBIjQm
    vdGxFOioLlCV7EIUJvBq6H2E+L6o0WHYSqNG1NS03Y3MVj2SHAnsUcIwdGZi2hyNLu584y
    qs8JPg3iD+M/VPxWEXi/CuUSJyFCRIeKC4c5tUdfisATlF2x8uSrmZd0vktAi79b19AOaF
    2aG+JUAYCTs/gPi+9c8eD0z6xtrD2zUhEyIIRo4pG0UYUD8UZeNXXXruQUZRiaIPHVE4Py
    fvmAcIu/gGltmWVHxnI1VysO2nr60k3JtDv4CRO/s4/mcDC0VevhRZeI3q3A
X-ME-Proxy: <xmx:gV6_auEIj8GaWF9f2HWkSU6wf1YpkGchxAUAdq3i8wQFGYcg3RrKUA>
    <xmx:gV6_amNprqMFeDhCz67J4ZoljvC9_AuZ6S1uctDW16QP_wu8JMn1Og>
    <xmx:gV6_alFSx28V27iq5JmFrCvjm2-pNzEkYYVexZ9DZ21SGduoMM76Wg>
    <xmx:gV6_alPcUTpICr7yLZtGV7frWsWq-Y0_WjqoL7qf0Uw0ZI9SCpV0PA>
    <xmx:gV6_akCo9kKG-FK96OWfv0xhgXFycodnGRxjf4_tNAK9KvW3QGgkmKb8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 03:34:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9ea67529 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 07:34:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] packfile: fix corruption due to stale delta base cache
 entries
Date: Fri, 02 Oct 2026 09:34:05 +0200
Message-Id: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQqDMBCF4avIrDsQY9DSq5QuxmSsU8WGTCwF8
 e5NdfPg2/xvA+UkrHCrNkj8EZX3UlBfKvAjLU9GCcVgjW1rYyzGSTGSnwaZGTVT2cBzJuxJGT3
 5kdEE1zXGXbvWNVBKMfEg3+Pl/jita/9in/9p2Pcf1JmCJocAAAA=
X-Change-ID: 20261002-pks-packfile-stale-delta-base-cache-0d4730487643
To: git@vger.kernel.org
Cc: Guillaume Chauvel <guillaume.chauvel@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series fixes the bug reported in [1].

To summarize: we never evict delta base cache entries when closing the
owning pack. The cache may thus contain stale entries which are keyed by
by the memory address of `struct packed_git` and the offset of the entry
in the packfile. Now when allocating a new pack that happens to have the
exact same address and that has entries sitting at the same offset, we
may try to use these stale entries and thus yield corrupted data.

This all sounds very unlikely, but the interesting part is that this can
be reproduced by using recursive merges with submodules, as we open and
close the object databases of each respective submodule. And if they
have similar packfiles, then we may trigger the bug.

The series is built on top of v2.56.0.

Thanks!

Patrick

[1]: <CAP4DsUexEmm1qo6jH+Qzy+n3dQs_OCJ8yg=ReF+aVrcTrC7NeQ@mail.gmail.com>

---
Patrick Steinhardt (2):
      packfile: move around `close_pack()`
      packfile: fix corruption due to stale delta base cache entries

 packfile.c                 | 33 ++++++++++++++++++++++----------
 t/t6437-submodule-merge.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 10 deletions(-)


---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20261002-pks-packfile-stale-delta-base-cache-0d4730487643

