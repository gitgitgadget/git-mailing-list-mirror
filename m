Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB1329E44
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538700; cv=none; b=Fji225hN+GXs9EHuqS3Iw4e8JeTrxx1HJ+i2kG69t8Mhr9i8fg5EMOlK2kguczRh4la+/BrJFEU+3L22tQ5WgsucmkV1Trk9cHCV1knGaEDcGu/Kf9l6eisrIZrUrhdXEbPS+nq6HNZYIMs9IhMLLcm4Wk48sLY9ULSrGg7UufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538700; c=relaxed/simple;
	bh=8glywOZOWDLHX2+tKkQlq2y+3VnBEZBY6zg4VQ7tVAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+9o6vs+cIENy7tpfACb1xiKx8dXIbnUGQKjhBssIIJokh+iBhZOCNdHl8fbg/J0fMlGDPO/LkqNOwMjLYwuDLGBzUQD6T4LHYndujmBIHgld15eJPtxlRpNbSAIY31XQaiD5ZivIHO7nWSRkQmy4DAGT3BKIUY78QfV7MY76ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gax+Amos; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vxtPQEOu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gax+Amos";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vxtPQEOu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38EE31400224
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538698;
	 x=1763625098; bh=KRcCChfuaR5uvcucWy17iUP9Lwz6UQc6UT7fi6kiHwI=; b=
	gax+Amos07LPiz0lIs9uLZjEHCsiLHFcMYadQ9GKD7gsAJyUZSArIlUVf0xssDp6
	t+K0VMH1IiOhHB3MVWLo5b5LpVVpaoK6hvBe1VlfGDn6EDXPOphC6CI3fvg5q3mo
	KZYVnOZJdujIR8TUg2Jx9IDy4F2LGwUJzfXP8L8xJmFgGB1Y7vyhYmHAMfW6DkCn
	SXdIg/pI3Fs0rKZxgpg0rT0YizZFS2AFfj9DFqew0w6AK/hrMa9gc9eiI4tts9gd
	slEZQCjrzVy8FTOLwbMXiDa/rHwJ+fxrHs6NfS/KdhbsGuEGMDgBL7gEWcszaEc0
	K//lHRYAa5MmpI5u1QKP8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538698; x=
	1763625098; bh=KRcCChfuaR5uvcucWy17iUP9Lwz6UQc6UT7fi6kiHwI=; b=v
	xtPQEOuz4pSfdqtW8x6sOnhxWZm/UErglTGk8pyCpeZWfeWYRb93sLf5v7EKlGhJ
	FlirMWIoMqSv+xC52zgaMm0mszU+8aC5Jr8P6tTfEN023OgJnGySUgtVKVVTV4Yq
	3XMgfz+5W5YpuzL94s0ZMUaBA40uYSalq/CXVdFCSPiJVMIkkUi69DYR2S18QAqJ
	tvZgaiXXPrkCepbvz3k0UdoBuW6z8q/ZJOtzl54jFOkSIvk1pxrntM2RiBDN3mA1
	Rfhbso4TjW7yyzDTdn8kc3EbSol+yxPCXV9n5lWSNmWRwaarxX+xtiASAdawoptD
	yLyR5rWQuS0wLv+hSOOXw==
X-ME-Sender: <xms:CncdaSIXEeymZ6R8MYETKeziwKlXv4mzA3VMJoVlCL5n4DGo_uEuZA>
    <xme:CncdaRF6B1R_T6YKeP0eW18BAZTm4QXAAeoL2PTtsdAnZvtWiLPU02LVpF3Ly8Cwc
    uxigCC89oSh1hpv6_aFmzubRgQ3TJbFN8uH0I56ynVJNFq-rpRV>
X-ME-Received: <xmr:CncdaYWqqEBUotjykI9UPGvzC1pEUKOL257IP8GxtZOKbMIgJJo6heMpTlhzLXR-0470mvFRoo3lMaTWTOuNP6m0KJ4XTBw8NuiE2YuPIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:CncdaciZFQIm7OQlxPzgChGP_wK1qlL_-oZAYNtrPIn8N5K7IfEOTw>
    <xmx:CncdaZQf4SALVGm2jG0BGt37N1cr1gardxADnnT4Ct9k-iSmG9KyHw>
    <xmx:CncdafFWVHhNpCYmxlxOOEHS_by3GOZhJbNb66gO5JlE5z1SR68yUQ>
    <xmx:CncdaRmUMDWiRzQiGxP3yGm8L8Zn9Au5B0hDtwkzEUgDrHYMVOxNbQ>
    <xmx:CncdaTrrQ8M_0pUmh9Z535CNIw6LIVOvReYIzmJ8BvO2BYqVUeyuS-x1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 638d2bae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:59 +0100
Subject: [PATCH 11/13] chdir-notify: add function to unregister listeners
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-11-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

While we (obviously) have a way to register new listeners that get
called whenever we chdir(3p), we don't have an equivalent that can be
used to unregister such a listener again.

Add one, as it will be required in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 chdir-notify.c | 18 ++++++++++++++++++
 chdir-notify.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/chdir-notify.c b/chdir-notify.c
index 0d7bc04607..f8bfe3cbef 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -25,6 +25,24 @@ void chdir_notify_register(const char *name,
 	list_add_tail(&e->list, &chdir_notify_entries);
 }
 
+void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
+			     void *data)
+{
+	struct list_head *pos, *p;
+
+	list_for_each_safe(pos, p, &chdir_notify_entries) {
+		struct chdir_notify_entry *e =
+			list_entry(pos, struct chdir_notify_entry, list);
+
+		if (e->cb != cb || e->data != data || !e->name != !name ||
+		    (e->name && strcmp(e->name, name)))
+			continue;
+
+		list_del(pos);
+		free(e);
+	}
+}
+
 static void reparent_cb(const char *name,
 			const char *old_cwd,
 			const char *new_cwd,
diff --git a/chdir-notify.h b/chdir-notify.h
index 366e4c1ee9..81eb69d846 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -41,6 +41,8 @@ typedef void (*chdir_notify_callback)(const char *name,
 				      const char *new_cwd,
 				      void *data);
 void chdir_notify_register(const char *name, chdir_notify_callback cb, void *data);
+void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
+			     void *data);
 void chdir_notify_reparent(const char *name, char **path);
 
 /*

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

