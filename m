Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487063A5E99
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351797; cv=none; b=JX7mNiyuxsSiOloMef7VhvVSG4ErUKZ5l7NYw183a9DUR52ISHqxojeqyALHi/N+iXKlH5s6+ZIAl2IqgSvmVIcc7ZwO9txHue0qdJPCrzeVSFB0FX4BvIEZ5T0726OW1KzQHeE0gH85MGCtXDk8LMZIiFBH6KVzsUYTSiwBS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351797; c=relaxed/simple;
	bh=7elxCxgPmTi6OKZJP+FDvHcGcrIvU43do/cKWgLL5tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAVAxJVA3/1Pf+qArwf6r8lWRHHIytEzS4ZnqMo+4G29GwFchAo9wfsTdvNB56lxbpPw1TsMsaBj5SfmKIG6FoH+5kaMUBnlIWFD8HPvB/PxwxGq8dtaUv0XK46W6Gx2gJ99Z45kVhd8VIqwuEeDc6C4z5pfHFQ7ebGrXP2mJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mvi+8tdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMVOWA+q; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mvi+8tdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMVOWA+q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 927B5EC0087
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:23:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 04:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351795;
	 x=1779438195; bh=ScUz3GEUKTtgj+JRMn+pbhjw9tDF0XEYtSzUksFA7So=; b=
	Mvi+8tdAZB7bchY8qjC3lLYhedo+iSlYK3kqNnsVLo2g6kLcFHVFZG5iFviFxv4M
	Z/zCTYp9OhRf6oqpfpOkIFT8czQphzTTkGeayl7OgDEpkEulvxuE8gVYN7lKNuCr
	F7AVQhpSvSOV3BhTEUaFsSOm1RMY/MoIlPaLjRm5QsF34xBbqwa5SDJnKaoDqTch
	Ne1fCnN2YjG4Ml/j+WYXba31qFEPNkUDIZFrfKEiq01FHPQKEXS5sFB000CGFJMa
	e+FypLkthlOwFtK2yYCJYDj/Kekg69k5bCIo80TC+cO4pfxch2duwNiVnrMs+Cuc
	rBtTCxSft/T6+Uw7LpuWmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351795; x=
	1779438195; bh=ScUz3GEUKTtgj+JRMn+pbhjw9tDF0XEYtSzUksFA7So=; b=v
	MVOWA+qVxrJYt6CeFH6nRpWGHQDJZsht6q7LPgnVUeJpWQqI4hygB51PHw96axxQ
	UUpgSRS+tlKHZLUlvfihK8t1jnsfGbeEPvtg7EgE9VseYUfQAbESd4xL7Dl4FsSt
	JiskJtFfRayH2aRM5s/yoA0A1rOz7m+ebiIWsVohMtqDbA9VxnX6fxYPzMhF7yjS
	jmkgU96r8xx9bAdx/PXfylNaEwG8S3AWaAkw36E9RP0SbHgeuEPGWyPcF0W7sqzg
	kaJWWGyWscyV3w1rEN6WSt326GVg9cbcfTGCLBrRw5WXAEyVWgsbCJK3Ypq81Lr+
	QAwipg2UnCcNCTE9b/67w==
X-ME-Sender: <xms:88AOapOqkUDQx6nR9g5z3xHZIYH0ZqqxGuWbfs-E1g-5tu1iYFJizA>
    <xme:88AOai7Hab3SqQBbp0XpaMQ1TPBSsCjs2sgcOqNmSOWEsVkjzWGsKkLdxFOVqdBqw
    tNuEzAsxTVz-c2yr-9zzhWTZO2V1vjY8erExAZav2ta3sSI71XmPg>
X-ME-Received: <xmr:88AOat6Nh629NSUlJv6ig_ATD6H1RElSxEOlSZQGbN4u-Xu9LvH7PcG4iCJRa_f3-aP7VR0dHNEC40OF4gSu7bKwuzgi-Ty8qXLc7sxTho0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:88AOaq1cSmF6mFd2zxxQUDfjpYTTb23QlDURtATA9wmfSBstKV4FgA>
    <xmx:88AOahXZjVIrgN4iBJ_slk6WDY2fCcAHYxEQJjsSgGeJgDANyZm3vw>
    <xmx:88AOat44da7j6rb8mvkcjDzgvYi0lRWrSC_a8qNlu9ekW-LLwHxZvw>
    <xmx:88AOagK0p5jtEKwgZUk0H01g7NCsSOVGetx1uIrYySziU-jzYOUkBw>
    <xmx:88AOal8x84iZVHV_jtkCTtErK9xg1KUYpU7hnNChMgcw5a-AjmTpVVkm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:23:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd72e566 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:23:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:37 +0200
Subject: [PATCH 17/18] odb/source-loose: stub out remaining callbacks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-17-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Stub out remaining callback functions for the "loose" backend.

Note that we also stub out transactions for loose objects. In fact, we
already have the infrastructure in place for those, and we could in
theory implement those, as well. But there are separate efforts ongoing
to polish up transactional interfaces, and doing so now would likely
result in some messiness. This omission will thus be worked on in a
subsequent patch series, once the dust has settled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-loose.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index e52fc289a2..e174941318 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -645,6 +645,25 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	return odb_source_loose_write_stream(loose, in_stream, len, oid);
 }
 
+static int odb_source_loose_begin_transaction(struct odb_source *source UNUSED,
+					      struct odb_transaction **out UNUSED)
+{
+	/* TODO: this is a known omission that we'll want to address eventually. */
+	return error("loose source does not support transactions");
+}
+
+static int odb_source_loose_read_alternates(struct odb_source *source UNUSED,
+					    struct strvec *out UNUSED)
+{
+	return 0;
+}
+
+static int odb_source_loose_write_alternate(struct odb_source *source UNUSED,
+					    const char *alternate UNUSED)
+{
+	return error("loose source does not support alternates");
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -706,6 +725,9 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.freshen_object = odb_source_loose_freshen_object;
 	loose->base.write_object = odb_source_loose_write_object;
 	loose->base.write_object_stream = odb_source_loose_write_object_stream;
+	loose->base.begin_transaction = odb_source_loose_begin_transaction;
+	loose->base.read_alternates = odb_source_loose_read_alternates;
+	loose->base.write_alternate = odb_source_loose_write_alternate;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

