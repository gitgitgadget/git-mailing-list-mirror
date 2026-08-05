Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881583D5640
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956627; cv=none; b=asqDaEExTYUlV0Cenyf/m72VERWY72PqZBnrNyBQEkYkhbwd/NbV69IIoy3YVfbobIWik72zfatdpNzOLpR+qjoK55bDbi/mIecpjisbigp0JN4pLCOlRcDRYl3vsyIjggDxjzVjK6PRCcd2EvfqFYGbH+LX0o8Y3QDDmnLx+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956627; c=relaxed/simple;
	bh=J51DUlsmR0zdZixtqka5WZAYKVhat/h6qhY/PpCDUs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL2tj6jEkRUSQdRkzOAIV5axvSTTSdcP2KYtRHc3hz4B1OH3ldy/VEopLZ/5d8rWkRzm3WoaQ8TghwobtcqMMuguL35po9FjxJSG48PiDwCzGU8ev0xjbnuUlmAX090E+mH+l2Teryosf2E5t9JeVJIj+tt6et+q7cueYLQi3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z+6SoXmq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3K74/6l; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z+6SoXmq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3K74/6l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F3351D0019B;
	Wed,  5 Aug 2026 15:03:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 15:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785956622; x=
	1786043022; bh=O6Ge7TkViX4kBTjLAeHiKdy1krH45Ww5JKcBk6SULSY=; b=Z
	+6SoXmq4SU3mtFcoof1eqFGqsgDGQLjCKGU8I4LrXhyGWhgjVu+xiTvGXBfE7pby
	dzSbmP4/bHO5QD7/SmsFkwor3HwmNoJVvHsnJJeaKj2V+4n7ZjBpOIrvgRlQxCd6
	VmFWiK8c5uQWUtu5WcNygInd04BJXIWMnkBONxIHEkTkM1OPWZE7Wg1tn9h8KO8x
	QFPLP1PH1bl/+IoL4cq1FKyGbhBzjopcVe0LAfHSmb09mwxaM+8p9DLTcSaV5rLk
	ocjyhkeaqJ+WtK1uuqvhIQV24y52XQfkdHn8BTS7/xB86KSAHZ3vqa0f0AIPWz43
	p2/f79NdjmkeXOS21QYxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785956622; x=1786043022; bh=O
	6Ge7TkViX4kBTjLAeHiKdy1krH45Ww5JKcBk6SULSY=; b=N3K74/6lsz8wGJztt
	/Xc5UwxCZvleFqO95CykSp20uL7ik01XyfipsNyToBDRqodbILArTecDeDcuw8c/
	H9gpJfjFuIxpSxNMBxbzGw70YO228c8IdDjtqqPms/eIhkdmFly9RJ1MLtTWoqN8
	sMsz6B3QnnlAN3+W52rYi+/DwRWNsUR1wvsWMyLb4LV0sR7vaC8IPMvP9Sc3H/cZ
	8opaj6KYbynnDK4712KR2A0b6cVhy//579ReQI8D977oPu9123GcOoJEiPyi/iUN
	BSyP4FUDngT9T3Ycx2YAnFq0U+79fkKCVjtfJAhgeErPGhG1g+/unyX0kgzeDN8Q
	DLlng==
X-ME-Sender: <xms:DolzahtVlnjymJvp-So-ZpUpVBIyV02aHQdvMHb5eEyhqkb9R680K2E>
    <xme:Dolzahc_i6qdddCJEeLRYkTHtnk-aKkVCRcgdfSpwcbYdfO4JDTrApiEMMQ70qnrl
    TsafXhJ2SdAiqYkWzs9b4iQdmCLOGsHPpdRol46thFMZbfDOIyv>
X-ME-Received: <xmr:DolzapyUFkFyd--Y-N4IWL0zt0kkRfJ_x4b1jUdE3fo9GhCElBjdxdJQYow-xOF9OIXpkjmA7bpx2hPWen7g2rCQcH4aqQRtNPmIDS-oEIHBU4jzrsc2wis>
X-ME-Proxy-Cause: dmFkZTE3VQ3of5AqZkomAgrUFFPyxG/WAj9bY3HKEOvIfFlDEvI3anp4yQgAxF8q3GE6b0
    STd5S2nwWlcgDbvd4+GRVtLBuWQbKwLT3pwsWPmRRKI2TPKk1ci/oCOLD4cGGdVcd2anNI
    zKMkjU7tu+90mAkYBGJ07lGG6wdWYubzrS8RvggPj2En9ejYnPBS93dCpkZAa7/fjgzmEi
    DbNrwyxWl2A0I2cUBt6FOr9A6Z8ne9WIxu8LFVIwWnH1z83Sh82+NsfKwLwr7ky6s06srg
    RH4C+Nekzvh6T0r20GKqJT7NYtM/oBLFPoBqTsS7zIfu0IDjkShcsHcB3yiz91FQ4m9eCf
    eoPaMTU/bdV658/qPC+LfGvPkpNmUHJXVDd1zTdbo12/IWUVN0V0KQ9aMb4aOmiPoRIc9r
    M9fqX3YtlbCk3xWKBMHPVVj57Qh7yGixBKDAqFDi8ZxKBO/4xRZH44ua1lcl+MmvoncAbV
    5O+MoruILIR9jjSowuEMfbYQ8DXMGY2wTJ00JgADxPG+QmGfCH3Ydj/ZMdxvkBPV55LFoi
    WL4UGFGAxET6zFPTOjnZ6+Mt7heLLSKpFX0zaSJd9YZ5uT+wlxCJyc/UfSwbOPG7K4PK3K
    JTxpIYSZgYMYwV8BcfilvbWV/AnD+9qdKGsskHuBLuG+nS3akgwusMr/ZfEw
X-ME-Proxy: <xmx:DolzanF8ESFheA8hUZ-KPISect-1GOHYI0ZNQwER4U_s0LHXFWcFrg>
    <xmx:Dolzaty3rC1x5Rv5dLQkpjapt6ciKybDz0gnL3lJyC8hf5pUnh4_yQ>
    <xmx:Dolzaos-IDUdve5PQlW-8lRRLHcbudPm85kMBQnGdNSzWrPuOForbg>
    <xmx:Dolzaq2W-lCI8wDyeiuqRNW9ij2tQ_eExS1obkTLqin4p-l1IOm_wg>
    <xmx:DolzatQV6zPJQ77cooCc4SdVjV313B0FsvEbI3mzt-1AK7QJtC0o3QIj>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 15:03:40 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/2] doc: refs: linkgit to git-maintenance(1)
Date: Wed,  5 Aug 2026 21:02:36 +0200
Message-ID: <V2_linkgit_maintenance.b22@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_git_ref_migration_warning.b20@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz> <V2_CV_git_ref_migration_warning.b20@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: add Ack from previous round

 Documentation/git-refs.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 3b5af936ed6..9063892651e 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -46,7 +46,7 @@ The ref format migration has several known limitations in its current form:
   ongoing migration. Concurrent writes can lead to an inconsistent migrated
   state. Users are expected to block writes on a higher level. If your
   repository is registered for scheduled maintenance, it is recommended to
-  unregister it first with git-maintenance(1).
+  unregister it first with linkgit:git-maintenance[1].
 
 These limitations may eventually be lifted.
 --
-- 
2.54.0.22.g9e26862b904

