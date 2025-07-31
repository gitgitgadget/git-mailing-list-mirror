Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23EB182B4
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947720; cv=none; b=NT+JEzi05LkCzKriux03g56cCXt6byy0HiicNhhWKULYmvm+WaN+awM+Xo7JLn6cSJAXCWaxpW9RRESxlJBbbEwdrNGM9DOueCqx5AJrTKhntJt3J82c7Cs0ByH7sD4dvQxVB/U0AytCgOFWXeni0IN2MZJ9S8h1q4JiYpGiNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947720; c=relaxed/simple;
	bh=PfpQZrRURqs7OEH5SzkbdHr33kO2YUcSn/tnCFYHqeo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E+sVyJlIld5KZPHJKx6QwC2XqfZbSbeIfWF6MwhaicLrY2n/rBZ48LuHi5sYbBUEfR9nTf7yjEWE00aIZw6AFuU5J+3fDgT0FieEooyh2oF+09COBvCy1hIRDt+q1Viw7MTIHWtkO89gexyUP8R8V8dSDsnFyrlNS+eu0w4ogcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cr0/te6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PECrM3Gp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cr0/te6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PECrM3Gp"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF1D07A04FC;
	Thu, 31 Jul 2025 03:41:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 03:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1753947716; x=1754034116; bh=XvfXJrCSNWZ1+3RWDL7H5
	cZkDtI25NQADjSBhhthG2k=; b=cr0/te6UASd1zOsmX1QuHKVUawu20lmBWhE3E
	zRcW2rxm9thtoiz3CckI+xe5gs1DoYzvS8JiRsTUHF6ZrTqAvcO9fQxYVvkjmtKm
	Fjvkui5o8ASPaVOmHXZk3jJhWEMQKqjV5cLt6iiHQx/wXPwjGTuAnoeqfCJtxpmT
	csOyVWuMsh60kl/1kYrqcUrsUMbg55qdpVPtl0gX8BCp3PjBeflW9I/jRgy2t0C+
	LpGRNBmPlrwZRTuiDOI2+bh8yHhOsPKywnjiplSlfEq9TSRhqgAefnFh+KoW+xFt
	l3dGBKFsbMQWw+zIdSVVAFy3wO4RY3Ht5WRjxw7+b7s2LOqrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753947716; x=1754034116; bh=XvfXJrCSNWZ1+3RWDL7H5cZkDtI25NQADjS
	BhhthG2k=; b=PECrM3GpfbjHtDimVj8a8bDPX1BAzga9+Cv+KwfB1Qu5NMb5uVO
	RmzJLzFJzCFkgE8uHhKGclTKhM8Ej8AZkVzvXxkaVvwykTuNpggmqJJ2ZmEwx4X6
	EsK7Te2eqOe6rQkiEAndAvCAHl3AbOOMzsoQIP7MDzTUOqoLqZZU4UGvZGNDXPsy
	gMLJ0/nVq8z5fU8YDwgebRIwS1HVZxSaBNJQ0rfQRnV3NxILijqQw8JzphyAcxtF
	u5uyZ+Uy0C+Qc6v+PnH8jo4zBOSwnfm72SRNchppY4OWvfYQd+hVt2PsbKyOl+UI
	HXJTBhOz1S3GJgSWcdikpuuS3anImV2bqoQ==
X-ME-Sender: <xms:RB6LaMjBm0zHc4VdC8YaYPD5HLYq8Sf8_ZopIKSesZIwTnwjiIexBA>
    <xme:RB6LaFMoFNeASzQvO8MDWdIdEnFpeQl5xTCXewMLDsAeW8sZgmhtA-WYoM4zcRDHe
    K3zA-9qtRJmOF2T7A>
X-ME-Received: <xmr:RB6LaF4GLv5AI8nrC1kCmRwUXF4g8-mPpQZ4HzvbXIJqM5XTbXlU4tKoVZbD71EJei47MSTVOH3Ier1f1rScBszIEGcq2zllvmBd1gY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepfeelveduffeltdejgfdvueevgefgveelud
    ehtddujeetgeffieeljeeuieethffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:RB6LaL2nv9_DgBFCle5QyHuwdzol9gD-Fum164arGf2WaYcaV_3fVw>
    <xmx:RB6LaOYkIpvlFC_M5TgfoZ1-mk8znsj2Y4bMJnArX_FA8jffrnwqtA>
    <xmx:RB6LaLAMTQ67U-S44U9ZHgMORvX7U3ne_Ohhh27pczD8kNhez1lhog>
    <xmx:RB6LaI9-RlQC0kOb4wpMihW2NxqsDW8bP_Oi3JiM2TwCs5H8Qmbqew>
    <xmx:RB6LaHFBeQks-ZwG8Pm2m8GDFz4Ow2HN4AtZ_5UDTU8aqoqMigelrqh5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:41:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/9] do not overuse strbuf_split*()
Date: Thu, 31 Jul 2025 00:41:45 -0700
Message-ID: <20250731074154.2835370-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strbuf is a very good data structure to work with string data
without having to worry about running past the end of the string.

But an array of strbuf is often a wrong data structure.  You rarely
have need to be able to edit multiple strings represented by such an
array simultaneously.  And strbuf_split*() that produces result in
such a shape is a misdesigned API function.

The most common use case of strbuf_split*() family of functions
seems to be to trim away the whitespaces around each piece of split
string.  With modern string_list_split*(), it is often no longer
necessary.

This series builds on top of the other series that extends string
list API to allow string_list_split() to take more than one delimiter
bytes, and to optionally trim the resulting string pieces.

Junio C Hamano (9):
  wt-status: avoid strbuf_split*()
  clean: do not pass strbuf by value
  clean: do not use strbuf_split*() [part 1]
  clean: do not use strbuf_split*() [part 2]
  merge-tree: do not use strbuf_split*()
  notes: do not use strbuf_split*()
  config: do not use strbuf_split()
  environment: do not use strbuf_split*()
  sub-process: do not use strbuf_split*()

 builtin/clean.c      | 74 +++++++++++++++++++++-----------------------
 builtin/merge-tree.c | 30 +++++++++---------
 builtin/notes.c      | 23 +++++++-------
 config.c             | 23 ++++++--------
 environment.c        | 19 +++++++-----
 sub-process.c        | 16 +++++-----
 wt-status.c          | 31 ++++++-------------
 7 files changed, 103 insertions(+), 113 deletions(-)

-- 
2.50.1-612-g4756c59422

