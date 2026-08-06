Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FD1D5160
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997288; cv=none; b=UZTQnjKA5X6IVXR/grHqbSPOmj5UKI7F/KCtpwTV+qnbLv+5Yz53qR54RcKzHRASCSG09h4RFoKjaMfijxHSEsMRn+a4cTWKs6aE+sk2YO+bBqzNwVbXFZPR1BfJVnSqUGzEXz/qxeicLhj2MlAeSm00h1k/LjxG8RtvZkrzz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997288; c=relaxed/simple;
	bh=J51DUlsmR0zdZixtqka5WZAYKVhat/h6qhY/PpCDUs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euQWWriR3hZEr+guecBL+XL85RsY8MAuwUs1jqlXQC3RFv/8Cizu6aakZkv2fM2qend4OUXz/8LfWGhBzcgSwY+Gjugr8g6JNnSJXn23B1dxvwakccx7ziaDU4mYy4tJAQn9BgGZROhaT37/vF4tGFtXlpGg6XV1zq6CQN/nPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Wo09gH4Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVnbQi88; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Wo09gH4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVnbQi88"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 19AB77A0029;
	Thu,  6 Aug 2026 02:21:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 02:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785997285; x=
	1786083685; bh=O6Ge7TkViX4kBTjLAeHiKdy1krH45Ww5JKcBk6SULSY=; b=W
	o09gH4QBqucrj92k1A2AT/31+sPclSO6My4OcRlDZWV2qdXwjCDvIo1YU0/Thvsr
	k0G8URY3bxyHx1doWKaXfw8Ff8BX/Hn8ZTfNuEDOOJ6HaNk6OUsYLc1iVmfAuqI6
	Rbpfy2IEMx13r3ysly/s7oi2tDEqRc2aUsnAVVDCv173t0PU/0YbwYIzWSkQHG1n
	v6fktL7d1dh/faXe4xrLVQhzsOk52yrkaUOkB5460PEvPEvxMBDpWs6vjyhT+49+
	SFPiPV7xyGHrS/x1Acu+tYUmN8FT3Nr4iQByWmdFMW8nQsg2H4pdRH7zx+BqlIvZ
	40W9xWonaQCQZXV6ydrGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785997285; x=1786083685; bh=O
	6Ge7TkViX4kBTjLAeHiKdy1krH45Ww5JKcBk6SULSY=; b=CVnbQi88dxnSkgtco
	SI3GRvAa/UCH71h7pABCpZRKy/5IrmWuCPLiR68IModAq+hvKLkcFuDkP09wcsRA
	yUVzmBeOUruX2dGNPj2oSwjr/c9y8Ny1cEYDPzMZL+Y7qTCEieYVx4GhkInsIFGD
	s4+yY9+AroBH20wRLOna5cVUr6zRHhwj/lOOtZXrrZk0Tykb0pZhjG+293ImNu7l
	v/X4oPLWBoWsRBF57kYbIR3gDwheiIsTSKH0J4aGA7Z9qsjXiUb2edj23JK4nZhw
	TtHa+TqY9xb83Ws2aZ0MD0M/kK4ttvTRXNKB+cYhOfxskgzWZ6EQz/pjY3y1FImZ
	gbKwQ==
X-ME-Sender: <xms:5Sd0ald54PKxZ43uAgUSnFPrBq_Hi_O1csJiepVrQm3FhmoMp9Iecpc>
    <xme:5Sd0aqG6-H_FVLtWZuyunIy7ffe4R6uGAnrckTJJ-4eZjZK6WP_SwQ16OXek6k7Nu
    5NCoA1W7J1a9GfMy8P6e4Fk4c5lj0gGpDivxqwg8i1XohnHwxwi880>
X-ME-Received: <xmr:5Sd0am2vEkKHI8zlpFB8Bv8xHAit_6-4TMp37zp6VMkODmGKmw5ZwWtKFIhH7eq0xLBvbYuuspbi7gIgOheS6KLMv7a7y9bt4IZxPls>
X-ME-Proxy-Cause: dmFkZTGpMY5E8ii296J3y3YObux1pNiIeiUdzm0RPJMdcsKD1gfqL0sEe1INAN7QmJXCQP
    da5QGACq3mX//fPLnl6keZVEffT0anfwjZyULYQy3O4Ty00UH5woPTVUNwGkH0WaURE8Eu
    tOhvBa6ch20hnVcyx3I++TMNqOAyN4/C+UN+3K9acBIqH8Tn5cj44Lm9oRA3yk6RTi9V5e
    nEfXtFemjXUO+kIuoiJPOqhoU/lo03a5HlK8k45Ldi0oDs/ijjqtAyCnVuNpTsfY6QpVrQ
    tzKPvCiyCoFG6baTEbdVe/KxhTSwB5k/w+1kw2XZ4Ki0Aw/ZW1hCHF45YUas9thh31OTh6
    ivhI/IUWVNSzG6eJ+dqikWvIjl5molbVF/RjOmK57sWCtfc08huOQXw3SJYPZHqivuaHNx
    jWZIqvGphKhDB9wQ8tBzVkliysKlrnUuCsNtmUyg0VwVQfrzlB7qxDR9TAkDbzwEN4iuF/
    pze7vhLh0qTPXUrHy8lRjm699D18vsGzkZ9OlOvJk3RSvipv8aKWHHy0JfWfWjqN0xtC3L
    MqZEpLvgAXdQvCVG0szXLkpyqiBava87sdGKMskk6mWPIgQZrMTdxWGRXtDXgQ4FjkWGCv
    aKH4TqpyAmD/mrjQ02EuhZULc5I5oVHDcUXe8eXtd68y5ygW1nQ3kNZ0vTRg
X-ME-Proxy: <xmx:5Sd0aqnJra8rMAa7XU8zZrW5SniFXwV48-CO4ok5MjeKK_oIv4hEBQ>
    <xmx:5Sd0au9vDpvPZenI20YDgL5Q6u0kVQSa4v_F-mU6riU7GuQiBtML4A>
    <xmx:5Sd0anq8BnTGUCXxY4gTZU-8gpgIZFfWsba_VWha2ZEbLqcxakCVQg>
    <xmx:5Sd0avkj5Vbe6-0N_JeEjnJh_K6K8Ks5OGLFRKfGC5xftvNeRVhBAA>
    <xmx:5Sd0ah15AB2Mkw56qAmJ_Ow1SGnxXsHa03mClX34P-7xbr7VHGAowzNT>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:21:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/2] doc: refs: linkgit to git-maintenance(1)
Date: Thu,  6 Aug 2026 08:20:22 +0200
Message-ID: <V3_linkgit_maintenance.b25@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_git_ref_migration_warning.b23@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz> <V3_CV_git_ref_migration_warning.b23@msgid.xyz>
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

