Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9D3D811D
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956421; cv=none; b=WHMhW/XQhmqFZmHIu78FkO+1nPkIRaJQw1K3xV+eXS5ATSG0Uazxw+PTu4YxvrfwWst1C7iYtRVYasRugG0Ujrpkz3+wi8K8YSPAt3sodsRSBErUynqLVuOQDboo8EB8BpdrslTzy0jVKLPyA2FWA8ru7mQzbuiwF2+WnGiiifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956421; c=relaxed/simple;
	bh=EvuvtOBqFqUsMFCq3fsrfLRYi5AWDRe5gGAnOBWB6aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anzKME+ixsuFWsBgoMkQooB2eLI9g9tEYuEXKaaUmkrY656RdI0yibIIaudZ4oqKv44CMnIJ1bhh6Ts+xfDq7nHByzt52pQ3z4hfxdusFEYtaHTGaGR5vC/Vrp/MstKeCgzs8nW+Ur9n4A1HIbqe6rAkDQ9nakbip7UKTo9dy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ol20s81h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdli2TAw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ol20s81h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdli2TAw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 291DEEC00C5
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:26:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 07:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774956419;
	 x=1775042819; bh=Sr7r0+KeTqYA0KelR4SkagPB9zLJXfKxC/Tcho+bLq8=; b=
	ol20s81hi86l9Pa6rDfUKe60ZCaTyBwfCtqED6wBTJQGPT8ZiJ840GEIINkFfL/S
	kkrawAGkvYfgjH6/Pw5cbcBRE+3RecnUcojPgUm9YxOhOfETJaoruDQFCTzun5J/
	eyG1hjTgdbZdmBKb3RBrviUG09P+LKRcYc61G9PI1axIw7UC3eHJSZEQF9Gb7W5+
	risyI2fYwpUNGx3U5a5H5RKcrz0vqCPgJCWft+609KDkf56S7zpMtM5YsSg775al
	3vIKVxqwLrBeVYYQ5W9Ika59O4fBIezwp5DaL7vgJg54DVIX8XghZ+TIOZBPE9se
	T84om0+GZwBBewq1b3jyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774956419; x=
	1775042819; bh=Sr7r0+KeTqYA0KelR4SkagPB9zLJXfKxC/Tcho+bLq8=; b=g
	dli2TAwb8MNlvpUJmHsmN75fChGRcftED8xqVhXigAfilE/RCFacF7d/XfkrlFXY
	ZQhcTCQVM44hIB2euK7NmLIkuqw9YUb45jG+TFHFNteY3HVy0JvQT3lNR3N8u7HN
	IxEsiIYskpXHcru9X9yIAR5IAQVr67kASM07H1m3pWeS+15fiK9W4sDALeX31+Jh
	M+04R7o3BDgH/hBhNe9O8Lvv2FLiozptz9oehcNhzfoOZrB3ct+U76bwx0PMLHWm
	4T8Ec6gLvObpMzzzxXJ8gZ3sSOVfl5hIBL04YVtk1MGTJ5neG031qFl6Zn6guwTx
	1afqSeuDvgeSfC/xZ801A==
X-ME-Sender: <xms:g6_LaT3SC_CovavlETfpKr8gP5RFy9cUJKVKPIV20ZSboBNhcXTPFQ>
    <xme:g6_LaZBmxzC1HE26dY9kAtmVWX3JPSAqWIQUCyvgOnQm5SuOuKvk3INTP1NffWi1q
    ZiteTC2en-2X_w-NZxoXTujp-dAlOe97X3JTMHauJwZyoabbkHg9iw>
X-ME-Received: <xmr:g6_LaZh27tNHLWBUWzhG3gLFapQu_sHxYRuPsHMWpyu6on8FikJCktPDAqE9QYOnSXf9wHBRql0smOLIK7_ukKSwl4sEyJVdE05RjgVvUJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekud
    ehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:g6_Lad-Pqgd4V4fo5dK0FATR5qc28jX981R0vq79gLDJEs0XHQ9juw>
    <xmx:g6_LaV-RmiV8h88jejW6ZrMOGm0KvNQOp7oVx6LcqK3nzSL8CBbO-Q>
    <xmx:g6_LaWAsqggfGXkb-VxSetq8H3YYaLDHWwUew2khMCEZONZsLEfV_w>
    <xmx:g6_LaVwu0stviLBB_1E2gRU24zLlbP51zOHshZ29QNd72f1KnL3HIw>
    <xmx:g6_LaRGVbnp-Wxu1j5-4IKZAXe3Pnnip7zStxym5Gs3x0VJsbKXav_i->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 07:26:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09a5bf58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 11:26:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 31 Mar 2026 13:26:48 +0200
Subject: [PATCH 2/6] reftable/stack: don't call fsync(3p) unless provided
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-pks-reftable-portability-fixes-v1-2-46bfae55c68c@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Users of the reftable library are expected to provide their own function
callback in cases they want to sync(3p) data to disk via the reftable
write options. But if no such function was provided we end up calling
fsync(3p) directly, which may not even be available on some systems.

Drop the call to fsync(3p) and rely on the callback function
exclusively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1c9f21dfe1..f9ae832e3a 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -33,7 +33,7 @@ static int stack_fsync(const struct reftable_write_options *opts, int fd)
 {
 	if (opts->fsync)
 		return opts->fsync(fd);
-	return fsync(fd);
+	return 0;
 }
 
 static ssize_t reftable_write_data(int fd, const void *data, size_t size)

-- 
2.53.0.1185.g05d4b7b318.dirty

