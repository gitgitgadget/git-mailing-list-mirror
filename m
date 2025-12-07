Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDD2D73A0
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765130179; cv=none; b=QWZKM0hqUey0kkpp3MzhtG/EtzRGwHEKKXVxV1FlqSrjasb7vZ5JO7izlXU70GWu7vVKYJE5N+fjlVIvrrU77oiEV+sX8DmN4D7YMT2KhrYw/puYryiF9hD91F41w/dvU1lg/nDjLfjqwY+DiaAqr6N78MlnXQf1ZufgF9jUaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765130179; c=relaxed/simple;
	bh=gbHxILgfO5tJBnSJ4CJwUIpsswz+WlSSRrP8ue8Nonw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHO/ERE7tCUEHFiTJ9DKyF1Q54NgKfvjEs8E8ROKZPGHd/eH1IUFp4V4tWIEir2ibmhmsplsvA5JL21+a1CeaS5B2KVII1CabCkwMtdJVqjo8QVcBImKHcAhjJ1+GKQA4EqkSwb0H67W6dbAuCRbZ5HoG0fWoXl9IAkZOfHA6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hO5Rr/Hv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/uTBJvd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hO5Rr/Hv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/uTBJvd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 399EA14001E4;
	Sun,  7 Dec 2025 12:56:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 07 Dec 2025 12:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765130176; x=
	1765216576; bh=E9p8rPVRba4NSwuHBuA5TLsPvOorrl53xC6hMK7nCqk=; b=h
	O5Rr/HvjoE3XT9bo2PkpU9FTFs5rRgtyV5MhdwBRQXQJociKuLuX6MSWfoJ3K9GF
	krL9sgmtIzBxQ2RDkoQLMTakZhlVlTIJA+7B1OE80dUUtfOThQYiLCUXjTRnPzSp
	VZ/OaiIIRLEXGShZgYQuCb6/UbpWOdjLCStvuqXhBlhp5XOmAwBFKsUOQX0MIYKW
	In4vEr9+HiAxVlC20f96vZcn/63iKQZ2E50bN61SxNxjY1wj+ne5OgjHfYeUdgW0
	77ny2UYOil67eiqTwRhaYcXqsar7EXs4gvWieoPPEx3AzVLKrh0PQm1N1cnKF/fF
	zd9vgFyt6d9hhaCdOUiiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765130176; x=1765216576; bh=E
	9p8rPVRba4NSwuHBuA5TLsPvOorrl53xC6hMK7nCqk=; b=G/uTBJvdmBD+Q58mj
	erKwGwnoQdCw54V691c2eNfpOwSo+MlX7RUZl5NZ5aRUtbA9Un/uxOgW9oW8d8lN
	9rU4DlTk1hcnR1d6gQ5PW3AEaoe986s56UHkHGxiLTse3Gn8A6DVRlirHQ+NjgCR
	CKn37vAVr0jwGhaio5uiDsF3uizZjzbQJ8IkU/tKLIqDOPD+VYq6ZsUeMbgXh7Qd
	6+fjf14yNeWhahEHksL/mfwd6IWvJHW89HCqdd7LLvmj1fC8B4FG/d5chT2MjJ/k
	5VyZboydo2qLX33SEQhZH3X6aYPCIMcqg8ZaDvZTijFlO6XuqZ4cs/e6rcTpkR4E
	JQSwg==
X-ME-Sender: <xms:wL81aVfgcOMSLq0mu5zxFsYvVZWG2Zt4oRdNzbyAsW1ZMQ2Ccnc3dJw>
    <xme:wL81aaGV_p2cBMzTLP9S2070O1kfYxCThUeuPM1VeU6xtLAxOlrOLJTm4ZnOBPvsm
    TW6nzwPT2vx02AiKntVWTpBwph3QNAy9t0Q9gcTpyC-_EdYNEYb>
X-ME-Received: <xmr:wL81aW3uUjF1ax5G9LXoLdoJ3TufBzV_YV6UoJsTGcxMUF4bg3NKEti-RiX_R6Oced8hlqKIB33HkTALBkBmXEmjASF6pp3urBPbKZKh7D7tzYlrHHxGmDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdev
    hefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:wL81aamcolopzRg0UajmfNhAouEaMTnpWlfENzNgHRBjiOuFXfidBg>
    <xmx:wL81ae9G3t7sVHxksEea8Nuek-3umqfOhfDun4_1fdmA0jURCS-hdQ>
    <xmx:wL81aXpHr0KqHYSUPAvhF4f6nBRU4Bwy-vY6p5T-Zsdq1VhcE6JVyg>
    <xmx:wL81aflSiuV7CVN3FBoheQce46U7fY4cfZ83gK3Q9WaV8k4oIqN7Jw>
    <xmx:wL81aR0MG4g2hjN2vDzkjlh7pvRu5oDK80F9JCf69lEfJnM9BRQy-sAW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Dec 2025 12:56:14 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 2/3] doc: replay: document --contained
Date: Sun,  7 Dec 2025 18:55:10 +0100
Message-ID: <doc_replay_--contained.103@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <CV_replay_conflict.101@msgid.xyz>
References: <CV_replay_conflict.101@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Copy the text from `replay_options` in `builtin/replay.c`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-replay.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 6fbb527b9d8..1b8661185bb 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -42,6 +42,9 @@ The history is replayed on top of the <branch> and <branch> is updated to
 point at the tip of the resulting history. This is different from `--onto`,
 which uses the target only as a starting point without updating it.
 
+--contained::
+	Advance all branches contained in <revision-range>.
+
 --ref-action[=<mode>]::
 	Control how references are updated. The mode can be:
 +
-- 
2.52.0.10.g08704017180

