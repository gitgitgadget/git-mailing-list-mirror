Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2B38911F
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302074; cv=none; b=atT2f5vtNUFRj+upWh9AJV217kjWoXwpa63GOHK5q2B747dvEWnTODeabCyYY7eOqwknGVp9oheTXeiOVMzQSwujHf+09bT6+SrdGjrWBxQPNG3ml70nPm/WJnFqzZR4iHSccJr0VkHn/aCEDavR8GvR+ln2fQHi8rCPmizQN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302074; c=relaxed/simple;
	bh=7elxCxgPmTi6OKZJP+FDvHcGcrIvU43do/cKWgLL5tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsQ3LPDvAefKpgwd0qUJt1MYd7zHtAuH6GJTJ971VgcQLgw5imQSMuvoPqRNbEJHX5E971YQh652yICYjK4G0biq3guxRgNS7YbY9rGAE6WkopvB0IFDPZzsQfM0OmDCdges6OIO0iUFQ5gwLKyNgo3ZRWOG5DknnRnfy1rACu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=geffyPNH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzTJLdbc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="geffyPNH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzTJLdbc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E25DEC008D;
	Mon,  1 Jun 2026 04:21:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302073;
	 x=1780388473; bh=ScUz3GEUKTtgj+JRMn+pbhjw9tDF0XEYtSzUksFA7So=; b=
	geffyPNHEkRCtbPFTR8yB6RGkwKE5/6VpCG2os5KrJHvB5nmVfaRrwIXo23KSRS+
	A/S4oIAiXfCzoQtugDsqXsbvJb6PykRV7ebALYnjyIWNuxzavMX78By5jRm5kKvM
	em6Ec7VkHcmtnGLcAIXyVzERrgjCHE07DW/PoLwiKryI6It0BfXQEXvTlb1vhmYF
	RFWk6cBVWHm/yQF/fk0C7czA5gQmCluZbz47OHlrbOrsq6WWeGc5TVVUz5STzGPU
	O/kWnOjSi4QgmPPUpANEBOhX7fw3vdosjBKnrV+acLEBAaOP/WBAXE2UeCV02SRM
	t87nvv6gmDxPqSRAnHKYPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302073; x=
	1780388473; bh=ScUz3GEUKTtgj+JRMn+pbhjw9tDF0XEYtSzUksFA7So=; b=T
	zTJLdbc7DBWnuHrio7jS36Z1Twei0xNwPACuyAtkiTIDM+0qaVRBzQfxDEJrRk2I
	hTSkH69elKPB8VW8X0vfhc/ZUjiRbyW4q2buEE454rPN9FOLuGsaJRe4072v2SHY
	CFePbS+CA42mg0RCnMR4rLXPSUojamC8cCovqptFwpA/a4QxyNmwpH1NDr/3N445
	TbcqcUUbIx9Hs4kfHV7sTaj4Z086W9vp836NLa2iTLhy/Lcj4Kr7WwfQJ4UYMrTA
	6c3fkxZIPnEW0DunxPrjopF/RFfTCTJHgq9DML4nennauh0JOX4wFQHaUHl4kp5Q
	UMGrZdQXAQVw3pFWog+dQ==
X-ME-Sender: <xms:-EAdatKh1IoCY-IgKCnzmEzy1TodisEwEEzPR9G4yl-FHz8Of6IdrA>
    <xme:-EAdavIxF0gTPwVoQouet2mO3c36rpQpD0KuBYmndA47M9_5jNZx0mXTMFsnFSByK
    BVyFhkn1474NrXpSgPUPq6Gwe5_BLQs8QKfGap2MH4LEMBZABV4>
X-ME-Received: <xmr:-EAdajWmIKQn0-MYDw4SeWgzBztEVfu4jpnmdpCvX2s7yxnn_31MCEAidQq7aro9JFDyXJk_mzxmtMZ54OVuPyGN9a1TVkjh8t4jswEfOnuZ>
X-ME-Proxy-Cause: dmFkZTETDGWGD5IMHpyclCfn26dIxf20YJU6aCM+91WvpYQFYDvc7Zw+JxclVgxwapDNgw
    lDX9KeH0Qm2BoMyG/W25rjCrbXgiYnW7IZMNqaa4ZmeiepffJxgwvqFSIgFZbyPmTF+cQF
    RUO5C79RNXolZXGXS+5ulYQihIYhF21pfxGiewxHlSj3qquvWjOv0rQcHvxPLs6Ohddjmp
    dgwVICF+92JEeOqVvMcfQbLgXiZsh04Ryz75lzTeuAz7l5ptTMN42dCvlC3Cjjb52/nArg
    T6ExkTSJ/PAVccZMOTj1W/JjU6+vn6SPZRAWMZxiPM3ZVo7ZCW4qb9tS82fZloMqKJafO7
    Kg0sgYZMekmQm9CxjxPYX1J5LeqamMVZKqRjVwz4be9hJ44QYTA5abWG9ZV3xeKd3xlLut
    oHMvNMq+XF0FuL/TKqq3O3NfC0nNUvmrhCKzXETe1cfpUOaajVnnL65Zq9WNjxzJXqaYso
    vCB8vp7cFpA/V/g2BeCkSRgqi0akzljSGzJqtOjRZt95pf7WF2LhxkcRt1xe+zfgjFHUO9
    BzKRG0qfbz3tJmbGlJAgFsfGbo0NLHlY/rcT9oDHAstKvHG7sJICREmHOxmjzgoPzbSxVP
    E94AjwE1L/M/dzQ1yxDHu7h00Hvxns0vy0TlRFTAICVcjBC/EpahJOoMiG5g
X-ME-Proxy: <xmx:-EAdapir8I11jGrZKOhxE-XI2sTzCzXrRLkmIxpg_T1jNIYzWNg_5A>
    <xmx:-UAdam8dipMnTEU8Bb9LfUE1FEDR1g9mNFiWAgBGdudfaptrej_pyA>
    <xmx:-UAdarAtLOoE8jgsylkRTwKXFo1CGigr5y3x3S2HAz8-xLZdm0N8IA>
    <xmx:-UAdarJGsP-rFTg1L--HXel0DUYWXIqPwxd29kDjIZ2mh-e3bmNVjw>
    <xmx:-UAdaggBibsMpc8R7xoT3r35tpvv6eY6wWRXJ4b3ya62aQ602QvLi17K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:21:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3075a251 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:21:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:40 +0200
Subject: [PATCH v2 17/18] odb/source-loose: stub out remaining callbacks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-17-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

