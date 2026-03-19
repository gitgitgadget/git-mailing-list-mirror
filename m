Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BC53E0B
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903189; cv=none; b=D6BEbjj7dU3h+IAG50BPbPR44+dmlVOSVDp6ON6AIupAIUf3qWVfBxuq8TgtJ3SUq8T8IWwkNfp8W0EDjhlKAoum7NIYGMsP4BT1GGmM9HDauA3ok3FhuGnq5bFdj/NB01+/sOwe18Cpj1vrw4uRI6aI9j2ZbOHqaX++7jp9G4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903189; c=relaxed/simple;
	bh=NFswty3k/7iDT/0p2SvGXH8MgwiyM0gB+9d0tTajyqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U9eHSq6LPiHNnACMNuo5mYtkxlRcVK17xDZgIuHop8RW9vvHNUhjN2y39NstScwzxrHXBI73tSm9swTLL+opVU9K2ZE1s2U5A4QOfVPonpBEveS2GXAyWMKnklXSvCR31OZYN4X7Wlp1T5vick/aKR1SQiogpjxe8UJsjkp5LnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NpfvM8O2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oRGGd/jc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NpfvM8O2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oRGGd/jc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21D111400220
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 02:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1773903186; x=1773989586; bh=V/HEj01Ob/
	9diRqnpax/2KM2ZKrEppnCmhi/ZEazyFw=; b=NpfvM8O2InlAx5QFV2pUrt1uzV
	xamHWgPggC2dyQxtTZ/EgAkbnFdnFuXqGcIEDgJuiGG2k1bp7l0e/SMSa/gXvXoU
	ZJ6vYWMn4yNdtBh6ZxdIqAF9d1FW1qSMFssC+vBSjLvNxunEYmMwzinSssF2EQNa
	QqVRygAiPbYvqd+H63olwJuvTb4Rl7J0KQilJugXUaOsHM09lC/jkB1LrTFn/f0y
	KSbbG2pA4QTdjVwNeIg82+rPbgYo7dFKkF64EK8uTSCI27mpwxGE5hXZE+jSnYjr
	WvMD7Ktmew4nywjX/Y+yv1sQW/nzCltFFHzyARx+VbYiBe0qAVV+Bwxn+YvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773903186; x=1773989586; bh=V/HEj01Ob/9diRqnpax/2KM2ZKrE
	ppnCmhi/ZEazyFw=; b=oRGGd/jcB7kcywmmFhqu2owsPuIaUhawXi7ZncXh5Ueu
	KA+f8xiEIlMiJB3Me4hrqhOW9Mi0qPw8AU65WF46sgrOdE6N5BMVuYM0yqQNzmkg
	oD2+Al6FI+8l/qkolDxX8P8N+XSDDIaBS2tYEMrIzda0L5CLtl3+hP5f5o//0ztw
	pY+oiwZOc+obcuj9hst72PNcoW9WVI8//4FpJMcSerh8wCOuViNqtqQ1Hj88c1ns
	je8HMEYkx/Z7f5sZDCKOuFuPCBB/SIFqiNLbs7nwPfnQBs/5yovLZnyAhwxFrHqk
	4JF/FsEs8yXI5NMY4iP6pOnWf0RebV9n+xADMQiQCw==
X-ME-Sender: <xms:UZ27aRiHM5I7dhjPYuY8LSvK1OIr3E_Si-qAGPKNKEst3-Z6dm5tUQ>
    <xme:UZ27ac8pEIzAgKIWqzc177ovxr3YJ1zvxUxg19xd4F9brJuGupmbOgQqt24Gz7MGB
    lvweilzgnq706upKLt_Ihu2703u34L0diPkDCL6hGvo6LMdk3jNog>
X-ME-Received: <xmr:UZ27aWsyaLEqSbxWMsoKhmGPbzxW2t3CMhaycKgfHqDeicMufrGYb7pqzvVo3MotBLC_GSwLkRg_uXeBmKrBnT1FQJUfI5nUSjr_DAAqW334>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefkeelvdfggfdufefhhfdugfelhfefleehueeftdekgfffffevtdegudevteeh
    ieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UZ27abYaw9NTqX5UJlu_y9djW3_2uhq_sD2LiSAhXXl2F-6mO_CKaQ>
    <xmx:UZ27aerY_ogqxtHpPmKY4yR-Hqo-zOHkjEAbErdM743q1UF7_VS23A>
    <xmx:UZ27aY-Ex_A2wGK6ghQvyVJAZdYFHcA4RG-kdtH9RXV-V0828ieK_w>
    <xmx:UZ27aV_03godirnWnOEQ8uacCrLMY5zbXMvGOyW8YynxPm4-5Tjb4Q>
    <xmx:Up27aaiDKwcRRqBVxS6WtQrTzIvm2VF9BrdgQpm9HJ-sWyZ07U5iAJsA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id daf97c58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/14] odb: generic object name handling
Date: Thu, 19 Mar 2026 07:52:58 +0100
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqdu2kC/x3MQQqEMAxA0atI1hNoow7iVWQWTY0aBqw0KELx7
 lNm+RfvFzDJKgZjUyDLpaZpr+FfDcQt7KugzrWBHL1d61vkDo+vYZoZLZ05CgbmKjEMXew9EXE
 MUPmRZdH7v54+z/MDD0PVEWoAAAA=
X-Change-ID: 20260313-b4-pks-odb-source-abbrev-a84c51222bca
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series refactors handling of object names to become pluggable
and thus generic. This includes:

  - Disambiguation of object names with a common prefix. This is
    required to list candidate objects in case the user has passed a
    non-unique prefix.

  - Abbreviating an object ID to the shortest prefix required while
    staying unique.

The logic to compute these operations is specific to the backend, but
not generic. This patch series fixes that by moving the functionality
into the respective backends.

This patch series may feel somewhat unexiting, but it's not. Especially
abbreviating object IDs is done in lots of places, so this functionality
is overall quite critical. So starting with this series, it is now
possible to do all kinds of local work with an alternative backend:
git-commit(1), git-log(1), git-rev-parse(1), git-merge(1) and many other
commands now work as expected. My MongoDB proof of concept [1] only
requires two commits (the object format extension) on top. And no, I
don't endorse MongoDB or propose it as a future potential backend. It
simply had a good C API that was easy to use.

Of course, other functionality, especially everything that involves
packfiles, doesn't yet work.

This patch series is built on top of ca1db8a0f7 (The 17th batch,
2026-03-16) with ps/object-counting at 6801ffd37d (odb: introduce
generic object counting, 2026-03-12) merged into it.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/454

---
Patrick Steinhardt (14):
      oidtree: modernize the code a bit
      oidtree: extend iteration to allow for arbitrary return codes
      odb: introduce `struct odb_for_each_object_options`
      object-name: move logic to iterate through loose prefixed objects
      object-name: move logic to iterate through packed prefixed objects
      object-name: extract function to parse object ID prefixes
      object-name: backend-generic `repo_collect_ambiguous()`
      object-name: backend-generic `get_short_oid()`
      object-name: merge `update_candidates()` and `match_prefix()`
      object-name: abbreviate loose object names without `disambiguate_state`
      object-name: simplify computing common prefixes
      object-name: move logic to compute loose abbreviation length
      object-file: move logic to compute packed abbreviation length
      odb: introduce generic `odb_find_abbrev_len()`

 builtin/cat-file.c       |   7 +-
 builtin/pack-objects.c   |  12 +-
 cbtree.c                 |  21 ++-
 cbtree.h                 |  11 +-
 commit-graph.c           |   5 +-
 hash.c                   |  18 ++
 hash.h                   |   3 +
 object-file.c            |  73 +++++++-
 object-file.h            |  21 ++-
 object-name.c            | 437 ++++++++---------------------------------------
 odb.c                    |  99 ++++++++++-
 odb.h                    |  39 +++++
 odb/source-files.c       |  33 +++-
 odb/source.h             |  30 +++-
 oidtree.c                |  65 +++----
 oidtree.h                |  48 +++++-
 packfile.c               | 297 +++++++++++++++++++++++++++++++-
 packfile.h               |   7 +-
 t/unit-tests/u-oidtree.c |  18 +-
 19 files changed, 774 insertions(+), 470 deletions(-)


---
base-commit: b052aca69d64d2d8e28e7ce97dcb1beb3d94515a
change-id: 20260313-b4-pks-odb-source-abbrev-a84c51222bca

