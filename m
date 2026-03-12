Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649E386571
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304988; cv=none; b=sSgyFNVztT4vJxDbjiqkSOZj8TKYxoVRTUf1uRKy944QHT9t/sGMAeajRFuxJREzx2sngT3No7h7ZZleBGW9jRYkln19zJjyZaaRyXyUVuDhf11ej7uy8Tbzrlhlnrwwf20Mh47bOnpDS992jz3WRvJQjkdN8O1YfJY8f4OFC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304988; c=relaxed/simple;
	bh=X1XdSDiD1CrvzBu5U4L0dsvu4kbnEZzF9crDOzpSD8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=BseIbqUfi7hxZgCMRCqDwBb7LwmjV+u1tHlXJYzql/oAh7z05QHah9FRz3Yikgh2/NQgANxa4TPjnd8L5n1sO/TcimFAtIZsr7o7tFbZrNtxkoHVL5Vl3jKBtqq6uAIBT8cJdeCcYOCqDct+sGz+RmH+Fy/C7F1yMYpIiQlXV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Be7LTf2R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1RubxM7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Be7LTf2R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1RubxM7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 33AF3EC00DF;
	Thu, 12 Mar 2026 04:43:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 04:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773304984;
	 x=1773391384; bh=yvYp5Eh6GL+T67w4kt/ImVncwm/BRluXDQ+mHPxzrOA=; b=
	Be7LTf2RQq5odHomJ3+u2zVQp7FeQYRi2LgZAfExy9A7dK5w/pcAaY4Bk4+E6kGj
	Vzsr0JevmL8WjaytGRwQ7X5O5k8zZRo9bL7ggaDuHsHRi3p1N07kkZf/LzQ37rrH
	uXeYZtj3sNNK9fa0Ya9KW0zoEjYE8TWj8nUD+77Wm37uhRNp3HbID50fzpSRFJt3
	IDoOlUqwFimKN4vV21GhAuPiPTH09nE9/bQy+fGrffFQvhrfs92y8RKe+qS/MbtF
	sVVG8t5NDzrGk+gA7UoLl1xdMwsrQBNtymMXqt/fUiz8ux+692LrwdXdgoo8nN1r
	ArTueuljP/7HzlK5RwcjKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773304984; x=
	1773391384; bh=yvYp5Eh6GL+T67w4kt/ImVncwm/BRluXDQ+mHPxzrOA=; b=C
	1RubxM77Lu9SEL05O7yqCUOSIzs2lLR4n72sVymDmlePw2qs/6zr/zLdyd7/6THS
	v8oS3KijGUCDq/Mi/lpz2v3JTzXw1RSmgar8YoaaKCaL3roRxd2xm2KJHcPrglVg
	KWfmDf8OFNqd9lYtMG3a3zL+Obks+n/S9o7I0RhuMi7I/H6E50jQ2ghiX07eqOmq
	Uvap9eOlb9kTk1iagjiVquvMUdxenRwaQPBp15mPta/7/BMdjtccZ8kQOawCyrKd
	2/zzdioreyv7GJuEBKTjVBrlLAjxlzecu4rZX8uS0+tTOulYXAtyPuM+4up7YWQF
	aoshRELxleJyAwBQd8AhA==
X-ME-Sender: <xms:mHyyabQ8MVYxC97vTc9xMbDylh5RNLL9PQ9QKJxij_FSebI9Kl77sQ>
    <xme:mHyyaTxRn2CAgfwCMzQk4SU93GLq_2nUsu__vNYEZ9TQYuFhPrWgWQXCCB4uSTEj6
    Cf7oqU4WntAF1TaN5k1sTXgk2nGT70QGdCqt5CNnKcqhJYbysbaOec>
X-ME-Received: <xmr:mHyyaV2MC6BOb87rcSEXoSRIrrxTpk3jkF83EhXLr-Cwj2pCXfC4KKbZoYH5rHDji2wBwKIR4ztTrzgB5ujdCnGrFUu_mPPWKiYm_IcGL1A0gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhm
X-ME-Proxy: <xmx:mHyyaZ5f4mlBnN3CQdYU6P5GkVBuetZD5lmyrJXwCa_lkorUdpvVzg>
    <xmx:mHyyaQXgM07QaQoPvkrHot5NBceorgsT4WjBHsPab6sUFhKYWfcVCA>
    <xmx:mHyyaQAujRCZagQ2m-YhCtNtZAv-9DjJwVIhvFcrqcjX1N79erctmw>
    <xmx:mHyyaX6pW9Prza7PYjJlBpfTUbswkrGSJD6Z2sA6A_tRrNnwwE-GHg>
    <xmx:mHyyac12aooEhUX_izRanvmhf2ZoFAuKFtNh1l-9BKLq9TGHE9z2kjNl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 04:43:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f9d0ae6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 08:43:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] odb: introduce generic object counting
Date: Thu, 12 Mar 2026 09:42:55 +0100
Message-Id: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI98smkC/4WNQQ6CMBBFr0K6dkw7VhBW3sOwkDKV0UhJB4iGc
 HcrHsDl+/l5b1FCkUlUlS0q0szCoU+Au0y57trfCLhNrFBjrhEtNBaGh0BoG5AwRUfgwtSPEJo
 7uVHAFqWn/ITO514lyxDJ82srXOrEHcsY4nsLzua7/twHo/+6ZwMajC5JF63Fo7fndN/zU9Xru
 n4AYlicgssAAAA=
X-Change-ID: 20260224-b4-pks-odb-source-count-objects-479fe682cf6f
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces generic object counting for pluggable
object databases. The series is built on top of d181b9354c (The 13th
batch, 2026-03-09) with ps/odb-sources at d6fc6fe6f8 (odb/source: make
`begin_transaction()` function pluggable, 2026-03-05) merged into it.

Changes in v2:
  - Properly initialize `out` pointer when counting loose objects.
  - Fix a stale comment.
  - Fix a commit message type.
  - Link to v1: https://lore.kernel.org/r/20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb: stop including "odb/source.h"
      packfile: extract logic to count number of objects
      object-file: extract logic to approximate object count
      object-file: generalize counting objects
      odb/source: introduce generic object counting
      odb: introduce generic object counting

 builtin/gc.c                | 44 +++++++++----------------
 builtin/multi-pack-index.c  |  1 +
 builtin/submodule--helper.c |  1 +
 commit-graph.c              |  3 +-
 object-file.c               | 58 +++++++++++++++++++++++++++++++++
 object-file.h               | 14 ++++++++
 object-name.c               |  6 +++-
 odb.c                       | 37 ++++++++++++++++++++-
 odb.h                       | 78 +++++++++++++++++++++++++++++++++++++++++---
 odb/source-files.c          | 30 +++++++++++++++++
 odb/source.h                | 79 ++++++++++++++++-----------------------------
 odb/streaming.c             |  1 +
 packfile.c                  | 48 +++++++++++++--------------
 packfile.h                  | 16 +++++----
 repository.c                |  1 +
 submodule-config.c          |  1 +
 tmp-objdir.c                |  1 +
 17 files changed, 301 insertions(+), 118 deletions(-)

Range-diff versus v1:

1:  3d5f8733d5 = 1:  1639bb1725 odb: stop including "odb/source.h"
2:  2fe42618f4 = 2:  056b6f3ae3 packfile: extract logic to count number of objects
3:  4cbf727523 ! 3:  069c908771 object-file: extract logic to approximate object count
    @@ Commit message
         repack objects. This is done by counting the number of objects that we
         have and checking whether it exceeds a certain threshold. We don't
         really need an accurate object count though, which is why we only
    -    open a single object diretcroy shard and then extrapolate from there.
    +    open a single object directory shard and then extrapolate from there.
     
         Extract this logic into a new function that is owned by the loose object
         database source. This is done to prepare for a subsequent change, where
4:  c1a527877a ! 4:  6f293f1352 object-file: generalize counting objects
    @@ object-file.c: int odb_source_loose_for_each_object(struct odb_source *source,
     +		*out = count * 256;
     +		ret = 0;
     +	} else {
    ++		*out = 0;
     +		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
     +						       out, 0);
      	}
5:  c12d4ec401 = 5:  0bda4a3d01 odb/source: introduce generic object counting
6:  91307f205d ! 6:  89164dad76 odb: introduce generic object counting
    @@ odb.c: void odb_reprepare(struct object_database *o)
     
      ## odb.h ##
     @@ odb.h: struct object_database {
    + 	/*
    + 	 * A fast, rough count of the number of objects in the repository.
      	 * These two fields are not meant for direct access. Use
    - 	 * repo_approximate_object_count() instead.
    +-	 * repo_approximate_object_count() instead.
    ++	 * odb_count_objects() instead.
      	 */
     -	unsigned long approximate_object_count;
     -	unsigned approximate_object_count_valid : 1;

---
base-commit: 2247f478a898a7f8f8322cc51bdeb1cc773d8f4a
change-id: 20260224-b4-pks-odb-source-count-objects-479fe682cf6f

