Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E962D8764
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181088; cv=none; b=SCVYldutYufnvSDJOMw9Jm7VaP1erKk4aB8h/s/G++UTTVjtRWPHEkOCd0vhgVJZvj2Txm/5lwKVXMeugiPiyJBkO7MVizzmmPJ+awdrq/9ss2JHFHvxai45Ka3x8kfIf/E4fXjY3Mdvn95hrZD+A0lyWORfkVtVl9ztrsthd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181088; c=relaxed/simple;
	bh=XPufRKpAhp21lQmU9JguqiV1l/1YKGuKRvK7AOSQ9K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ByTGJX6rqWBL6XjOeioqtEQNZuKxtKJLayb7ILBC5lszcVmGxZRiRelVCfbhCcofJrjgO6a5mRJQKWGkdzrMi3sQiyaIHgnRDl+KEiQHPkP1H0Vg++ICZSEAfCO9u/iJZUdwkdk4oRSZl7Dp2H/qfO1ao1NbMJrSA/tPIXr7B0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=du7W1X94; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lw7OAV+e; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="du7W1X94";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lw7OAV+e"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C35E57A020A
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 08 Dec 2025 03:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181085;
	 x=1765267485; bh=zMX4VvQ0pTAyTRNHd1pkkucJ0bVFyGWjUh/GgBdOqDI=; b=
	du7W1X94c3HhmaYILjhshgfA/rMryDFhjxdL6y8NYwe0SbJdljqaLAvsCBfO4E8n
	AHruiStjUhkZAIYA1hr9+BbIfzq9WAwbm4PVK1UXWpTbSKJNYFV4JPxkNAlf1RKc
	joCWbHkHwJlPPLnOHq4wb3YAnv6AF0O1V+mvUfZl9ztkjLFHN8vu5OjIA4vCJFNx
	Npnd2fZialIbb0WHV7FMBvYi0jAOXv5OSTXoDvBoDpClU3RsMCJuRtjZLuIa5kaZ
	9CJmEeIoyyXm5sFn+xnaZaymJ3vEWrw3SG1HKCWS8WzeFIxOZGDP32TemOvu9RZr
	I3txWJU7cQYI2SfmsviUFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181085; x=
	1765267485; bh=zMX4VvQ0pTAyTRNHd1pkkucJ0bVFyGWjUh/GgBdOqDI=; b=L
	w7OAV+ekQlINydQN4ohH7bYsDhK7jwdG3LxLaQVBFccyw5VrANB7/qTy0ztfIjkt
	Wws8bniWXnS7fRTjVmb6okvQNRvpWsjLQdshSgF5c7CljRnvoXJLwmNknaY1uAdC
	QJKe81hLdwms3ll1a4r465YDVqWIejqdpC0AVcZdioYqo+r8fkGs7MBy71YPYmLF
	/yH+NIcFiXTvCS4PKZZGfOUHJ/DtJJhuxMaNVHgtPFXRDyAMfxgJ4lSA6vUaSWn2
	YW5QrOlz/58qkn0D0w8Xx1BF0Z0ezY3W9qG+Fm7Ut2iwmSzsquuz8m5gqT8XuNMA
	xFxgYzXID/xnBF5iiYmOA==
X-ME-Sender: <xms:nYY2aYESlAMcrdUXpOG7cSbXGC3ulNYN73EffA61SyCeGIzxdZXlyQ>
    <xme:nYY2aYTbNyLB5LdNlpNvcejLBArZs8luKKgL3ENTvz9m_G2XP-Vfm0yPx1jdFwyFH
    AkRK0LIS7ap4VFxjgmYCf0S61BxRsGx9mJh9Txj_UpuRVaizj9_-Q>
X-ME-Received: <xmr:nYY2aXx60xI8zKtQEsHSJgrAJEhj1y1qgmut0yJ--xghNpxRZaXy100UK37vZbkCUENAfuOeN5QgUpgOnMCqu0FHnJCEX2Hngkm779wSS0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:nYY2afMP3N5ftEP9sICTC4ra7B4DXMIjHmwH3zx6u2Ek9AzvLfAxfg>
    <xmx:nYY2aeMRMKmkk_4QQ49b6e9JUUa5caJbBxSJfSbsY464-2ZEEQVMkA>
    <xmx:nYY2aZR8eFIC-NpVPSOGb2oLJU2BE9BN8wUQCt55CR52Y5afrFDLeQ>
    <xmx:nYY2aYAMqZzfzzWMRKQqswWa3Mhre8jQ4QihdNpImp9pmQZlb6gcDw>
    <xmx:nYY2aSVCEAok2yNI-axrEy8_vR-MhdIkgt5m4klri3cBpApjumF9Rtl9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f87dc419 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:21 +0100
Subject: [PATCH 4/8] odb: adapt `odb_add_to_alternates_file()` to call
 `odb_add_source()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-4-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When calling `odb_add_to_alternates_file()` we know to add the newly
added source to the object database in case we have already loaded
alternates. This is done so that we can make its objects accessible
immediately without having to fully reload all alternates.

The way we do this though is to call `link_alt_odb_entries()`, which
adds _multiple_ sources to the object database source in case we have
newline-separated entries. This behaviour is not documented in the
function documentation of `odb_add_to_alternates_file()`, and all
callers only ever pass a single directory to it. It's thus entirely
surprising and a conceptual mismatch.

Fix this issue by directly calling `odb_add_source()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index 2513457a31..94cff19221 100644
--- a/odb.c
+++ b/odb.c
@@ -338,7 +338,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
 		if (odb->loaded_alternates)
-			link_alt_odb_entries(odb, dir, '\n', NULL, 0);
+			odb_add_source(odb, dir, 0);
 	}
 	free(alts);
 }

-- 
2.52.0.270.g3f4935d65f.dirty

