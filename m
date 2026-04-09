Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB437BE9F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719492; cv=none; b=SAnT6WTfeortgVICPwnOun+DY86/svnHzzgM8vJIb5jr1bIUBiQQtdrhsT3er2glEsC640XXq63sHrmoBL9NWmdNTMqfhvuC23rm1hOkTR9q0/3SVpv/rp0QJUikOlaUgiqtP7GXJnqriEk2/7XREK2JRXBua1Lh7hv9+XSW1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719492; c=relaxed/simple;
	bh=/yNek1BvAmbEHBfGUvVcHEvP2iIt/tSlmxOgCidK45U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2tCwO25zBIYRTUO/i6am98Ik6BgtgQHfIuvOt+n8/hZ0Llsz1XTUWEdVA5DbFnWGUFIvzy8u+ta88zmakhxrWAz0UZy4XnoIxVOFP+t34bRPQDg8Va+1yw0PtYqB6pj3MXEbydr2sravy71ZUjeV0A34Hj3D1uEPnwxgVtYMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/FKdYOe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CijLOhXN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/FKdYOe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CijLOhXN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 13189EC047C;
	Thu,  9 Apr 2026 03:24:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 03:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719490;
	 x=1775805890; bh=QSUyVRejtHmbPxSpbXgGd0QHabhyudw0qkKBRXFMS4w=; b=
	S/FKdYOef/FypbKoekPESBhedUdgHcgUeWdLZ4hhViH3jP3mmvAupyynyzciYQw1
	rPyHAISo3c8fTJlt2b1dVqmiWdbSwb/U2s8q4USfsIBqo7o/GeentlcKz57cuxil
	8AKOSzG2KnrKdNh+yjn9Qfun6UQyl1JH49EGeyV+5UlI1uuqTUriTz6nU7pt8LBW
	t1WOxLYenKvJ3Zc/Qh20CQnFRJ5p+3nV8T9uf6NyZpxEKgS5Fw9OwndiYIhjEHkC
	lAVW7dfPv/o+tUJZDYaDhbCnH1jYOltIbI3kpZMLb+a1aHm9yOlJVEe9Ppo1DUiD
	8EkfrSa6bR0B8QaZZ+Qd3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719490; x=
	1775805890; bh=QSUyVRejtHmbPxSpbXgGd0QHabhyudw0qkKBRXFMS4w=; b=C
	ijLOhXNaANbMj/KQ6/YPSTIQ6VPrFr8/0shNqS+M3wDv3dHRyJ4TcEvF6ZzJF5Td
	rj2Qru6McrZYxYlEt3zkf/4Th/AS1YF15uKqdzWuhDWoCSiVtqn+h4Gb0/9gSXAn
	ujrS7vvOHkhZ6ePMToOkOYe0RkohcYKiYhVyulYryml3Ts5puMX85cS1/fJWMXoV
	yyfAJj10QrybSG6iR2BZvkJlGCk4MilT9B650l63ZI/id6gourqjpww6Lr/VzzFv
	dRLgPe6qPYEULZoG4U6lZv9Zq6SHpFHM7YLlRtF/UGMjqhLKInoyRErq/dOWYSpR
	Cc9EI8yELPBW0+esRH2qw==
X-ME-Sender: <xms:QVTXaeY8noLMdqf9M9z87ThlZLwqidrGyBrfUhpcl3PW-EZQ2LLawg>
    <xme:QVTXaY2J8BEUQDpp6x7FWH6fGOUoCYwtzukuupEoLAex_5i2wIccIHegC-sF8rks8
    Q5UnG5U6gHIjSXk7dWZdA7GwR-MZOVP4mX5OSZo1MBdMW1bos7V>
X-ME-Received: <xmr:QVTXaWVHeQfbMWQzsDQbZTg_rF6V1JvLxZD15fZUvHrnU_JSP79FNSqnLFYJ5EV2uN2pmN4AJ9jAyqP7lQyKGUUeWq7Vnflx3yk5fUOSBZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:QVTXaaWnrnQMWemErHJv2rUDNZeDYgcntvcj7KpzyfSf3EUgRaDOtg>
    <xmx:QlTXadcaeaUgFLv5atBxVSKwBnWPjBMhu9voXDCmccxCGSQmDf60uw>
    <xmx:QlTXabUYc30eXuSQguzbuguocrj_eGJUCn7JiS_8BukacdsnSaf8ag>
    <xmx:QlTXaecs4_ziq0Wh6pafpqdUQ_cCLi2JAqSgWYY4hAgkBuZE0hqOfQ>
    <xmx:QlTXaQ3G5wazxn7jd0PIslbxZh4P72i1O5D-WIiScRmXLIUbjbvZI55w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 197b4481 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:28 +0200
Subject: [PATCH v2 07/17] odb/source-inmemory: implement `write_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-7-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `write_object()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index d2fc4c4054..96e8efd327 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "object-file.h"
 #include "odb.h"
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
@@ -112,6 +113,8 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	struct cached_object_entry *object;
 
+	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
+
 	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
 		   inmemory->objects_alloc);
 	object = &inmemory->objects[inmemory->objects_nr++];

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

