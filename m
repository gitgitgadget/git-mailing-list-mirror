Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD620459A
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968843; cv=none; b=VzH3DVV2/VqGSfLb/hM/yJtdUWVaHxGt0QJE0QVCBt9R4+UQrosmQXEv42yCB0B53U8jrMS3fKGQLsvNXWcV/sg6bLjM5Um2Gm+CwH5fevVFnXWnbwR5ze4kSreG9R2a1QC8m1Arz7wOsOWmUIUcEl/+hNomvOoKWFJAEUZHQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968843; c=relaxed/simple;
	bh=P8AwBeDGypgkh2jVyPZUmT2PrdjuokEDhAM76wzlDDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL0dja3vP6znY0IYNXfvG9JA6e7x8wk7gcfNrBiYYxnLSn3bSFYrhPY8de2G+wVOztpUo+dlT+Zqfjr+rgtRCDzBbNNhj2VA55OfCYxRBg8jx6C83uT/oPDKCgsATiFtPyU2WhClUJFNPsXklc5hk86F8WBpvZjf1jjE9GeMiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GszHwy0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rX18gWda; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GszHwy0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rX18gWda"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E26747A00B5;
	Fri,  9 Jan 2026 09:27:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 09:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767968841; x=
	1768055241; bh=v4kzGNON7kPX83bOGRDCHGecxfmlUzKSad+JxI2wRWg=; b=G
	szHwy0IDC78bQtxH9nG+Uw68qAxb/DpOccVgWpGCdVuMGMekfg0acHpDhMNXqqvU
	xMuIlqPvKbo/YLzdblLk94WmrweqNNmoh7u/qdPs0edvJY9CxOP8ZRqxHj4hiEmj
	+DLHETkQdP6q5/h/IzCS7XZGtLzib481i7/zF02LzVes1Hm0qyyAguSSxAm6jeyE
	M4lBRPfgRLeQ/v+8lhz9CPYAFfgSP6BDW+/QEA2orDDudYkSi8npx33SKH15Mowu
	B6SLhGyfgxFJke3O1qReJDNw+t8YKSAiVGIFDarKMsxRUDQaWFKvZYD1bdsycQ9N
	LVuUS95tER1ZeQKyOsMuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767968841; x=1768055241; bh=v
	4kzGNON7kPX83bOGRDCHGecxfmlUzKSad+JxI2wRWg=; b=rX18gWdaSQuGOSKTA
	EOA2rauggTvvfvASBfNQBHfh5O48/FokpOWQgxbUaKBoKGVS34qxEIbdnRLu04go
	9kxbTeD5VTUPjZm/ccmtkIbuzSFuQfggvdl2F6k0Zz6Gng9VgofW7KGaHzLHYoIC
	scwFjVcU/BNPCJ3jpc0kWOMRuiS1lmi+AshybL7TGWYWsbnM2bnUj1rm3Ku/i/AH
	pXZrO6atGdLAS5ljUk89DkLh7SVlMBkB0wimpLFhEaBBndq8cYLwtkQbuMC4gmIJ
	5WG3Y/YKGkXpRJbKRDZRbTgPlXbn1E4G6VSXXIjIdDnytkXDrmx/eD5HUyMGGHi/
	+CYqA==
X-ME-Sender: <xms:SRBhaRZPR-I831kKeWRI7BxFM9zMMxa_XJoqLBrDqAd8tmLUGYE0DL4>
    <xme:SRBhafYw4ciTGYwIk4yTzVmHSU8J7F6Xx41J25bfsQqNkXlKm3OMTyu3JQR2BbMQk
    2x2RQwSgzxefGRKQ5QDPzeKqW-YbluO0XJsnUOMNHGKoZKZAuk0qt8>
X-ME-Received: <xmr:SRBhaY_qkL7ioKDMiNHmhLJtjZa6jXdEkYvFarkA9e0TWwlQm1ZcknAxiiJcY4JSh2PtoEf-p6p6v07Nw7eiNKmglpypVtHYxHAskuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpuhhshhhkrghrkhhumh
    grrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:SRBhaehmZG3-EfXjQYcs5NgMfZWIf8qa4cxXj8cx4dl22khVpQjW6w>
    <xmx:SRBhaYd2VYNX7mHMWd-q143pqtoIJ-9-iuKRfu71boitKQ2DSiCqgA>
    <xmx:SRBhaVoP61ib-2bYwetMiJO8H5Bom6E1Zk1IoyQSvuXROQCKoXS2-A>
    <xmx:SRBhadB4w8bHq9q04gf3py_GHAn_cz6H5weYFpcoiJxqNQPuRTpvRg>
    <xmx:SRBhaYc5nl2IYm650kPcD6G0zAw9ObMIDp1Yfb9fuACM6wpaQICm8vW3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:27:20 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/6] doc: patch-id: capitalize Git version
Date: Fri,  9 Jan 2026 15:25:58 +0100
Message-ID: <V2_capitalize_Git.1b4@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Git versions are always capitalized.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index bac37db09d4..82992e35fc1 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -47,7 +47,7 @@ This is the default if `patchid.verbatim` is `true`.
   as a key to index some meta-information about the change between
   the two trees.
 
-- Result is different from the value produced by git 1.9 and older
+- Result is different from the value produced by Git 1.9 and older
   or produced when an "unstable" hash (see `--unstable` below) is
   configured - even when used on a diff output taken without any use
   of `-O<orderfile>`, thereby making existing databases storing such
@@ -61,8 +61,8 @@ This is the default if `patchid.stable` is set to `true`.
 `--unstable`::
 	Use an "unstable" hash as the patch ID. With this option,
 	the result produced is compatible with the patch-id value produced
-	by git 1.9 and older and whitespace is ignored.  Users with pre-existing
-	databases storing patch-ids produced by git 1.9 and older (who do not deal
+	by Git 1.9 and older and whitespace is ignored.  Users with pre-existing
+	databases storing patch-ids produced by Git 1.9 and older (who do not deal
 	with reordered patches) may want to use this option.
 +
 This is the default.
-- 
2.52.0.421.gc32ead4fc78

