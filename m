Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1272D1900
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415798; cv=none; b=j4HNDNOK1xjuJsdhneerEPLipr4uarox0LFgK45b1ySc6wqMTyTeK76qacgTlZnzbpCn+4LYJ+9Y51KWMR0wOxce1B8PzztesG5IwrfXe0ggBe2rUMfA3QjlzQJJc6sW2LZF3JjNnGM+QWj/GwrWvm5O9NYIBHglDN2bph1nJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415798; c=relaxed/simple;
	bh=01L+h79HPLIwlb+bUWy200boovko8D7lb3DSA4vGRPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYbr9/4NUJcnArZZaazvD6lSDeGYqXVPV/dJExxW8wZQVgQlJgVl0t6RF5JeTeOFSoRcsYM8WdqOfD77pzWUM5O6syeZYiAEZZuqeybhI3FsGrRPdv5U1DWxnvlLizs9dA0guY46tAfpwIp1oT1UkRgLH6H+AYUT8BPfdUYpkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E8FtSnsA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gR5zLW3Y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E8FtSnsA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gR5zLW3Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D678EC0F3C;
	Tue,  9 Sep 2025 07:03:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 07:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415796;
	 x=1757502196; bh=w6HsHvNaz+8wrOiM+ctEaA88+wdB+Ff8Z7nRJEQ5PQ8=; b=
	E8FtSnsAgimECPoanuahYkQdkPHDSkf3zGJVHtewtxtY+VZbTGTb8LibUs5nZt/D
	Jh1JFj74FCavc1FiHxGBVN7RfCRMQoYGlnhQCpWBi1jM+GoegJgLEezm0H4Ltheh
	qJlQpNfiBzE2UcqQ9Vmw9tPaMc+QSsHQT74hqzpAQFuLX3CKx7XJ6M49qSPcyxF8
	+JY6jmrjKF9Nl7+WxtNhD3n6DJFM/DB63qXYXVD2UZSJ57n7lHbzvq3IwcLh4zmo
	Fhpl5KAk4G2Eg6jQy/B+dPi1hTT0cq6IdY8tW7DIgyN32A+Y4phw4us+4c0cDNbu
	Cp4D/lfxXWrfirO1xEAgQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415796; x=
	1757502196; bh=w6HsHvNaz+8wrOiM+ctEaA88+wdB+Ff8Z7nRJEQ5PQ8=; b=g
	R5zLW3YmM/BmVFeiGmXXpJAlLPKAfnn4Crf9DvtsOhbMnybD+oWSRNAfcdm07oYD
	h9I3RK+X42iUlU277NVYvrvdVo1afMvti5618Z8smnIl9DZtB700e3CokUrM3WKF
	1DnECa7RxsSS6VsxORRqfgzy4/e/WpfBSWS+g686Q2tckpKkSdXHOyhMFUrhCTon
	ZBqYtFCjU9bQM0NUZ5wXXfGSIXBYVtv+1y7TLjDkKvdTQMQGGDReGBWE2TwAp0FJ
	RU7KzFU2loLzMFMkhSbBEoP4tZel57QGtPkzTeWUr82WxqMyus6gxVl0ooShsm22
	5h2ma4TJbH31KHKQorbqQ==
X-ME-Sender: <xms:cwnAaHKMJeDN6051nG6mgjXRb03NCbe0arUcJHG9Ey5Dpez3jliSWg>
    <xme:cwnAaGrLVSQPEW4h0hjEDQyZP1U4-EX3LoXM0TEsksW1JjQS3UKAeE7bqHLaUDq1Y
    eIYz3rXnz39osLUEQ>
X-ME-Received: <xmr:cwnAaGICooRtRz9sAPE-ruoB2OTqGUW84n_dDS4zKJLox-RIebPCnSPjYBV7I1wTH8fGqKIBc3EcHI1OzAmlfiLkUD6xqjtMUGNpfdP7oHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:cwnAaLTMjGpPsjHBUVi3fN0dZMN4fuALK98f9KkpzRHImD3KtQnMHQ>
    <xmx:cwnAaFs6ya-IIkO8nqdzAOeN8psXekn8xYtVKCOIol-GAF6LIN_47Q>
    <xmx:cwnAaMbiOK9NcMKh7rEbtNzJhxp-GsYxnsfpypyAg3MrBlqDnmWBig>
    <xmx:cwnAaLGz73C5W8T22UYwmucZw_lko8Ouja3f_oImEHXg-QnAvGe7ow>
    <xmx:dAnAaOc2CruBHYXLmRmAHbbNFzPxf3Ld-wE-SbLr7USG9VsK8sAca8QJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d707de4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:02 +0200
Subject: [PATCH v4 03/15] odb: move initialization bit into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-3-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The object database knows to skip re-initializing the list of packfiles
in case it's already been initialized. Whether or not that is the case
is tracked via a separate `initialized` bit that is stored in the object
database. With the introduction of the `struct packfile_store` we have a
better place to host this bit though.

Move it accordingly. While at it, convert the field into a boolean now
that we're allowed to use them in our code base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 6 ------
 packfile.c | 6 +++---
 packfile.h | 6 ++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb.h b/odb.h
index 22a170b434..bf1b4d4677 100644
--- a/odb.h
+++ b/odb.h
@@ -169,12 +169,6 @@ struct object_database {
 	unsigned long approximate_object_count;
 	unsigned approximate_object_count_valid : 1;
 
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-
 	/*
 	 * Submodule source paths that will be added as additional sources to
 	 * allow lookup of submodule objects via the main object database.
diff --git a/packfile.c b/packfile.c
index e467948d28..711ccd95f1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ static void prepare_packed_git(struct repository *r)
 {
 	struct odb_source *source;
 
-	if (r->objects->packed_git_initialized)
+	if (r->objects->packfiles->initialized)
 		return;
 
 	odb_prepare_alternates(r->objects);
@@ -1038,7 +1038,7 @@ static void prepare_packed_git(struct repository *r)
 	rearrange_packed_git(r);
 
 	prepare_packed_git_mru(r);
-	r->objects->packed_git_initialized = 1;
+	r->objects->packfiles->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1060,7 +1060,7 @@ void reprepare_packed_git(struct repository *r)
 		odb_clear_loose_cache(source);
 
 	r->objects->approximate_object_count_valid = 0;
-	r->objects->packed_git_initialized = 0;
+	r->objects->packfiles->initialized = false;
 	prepare_packed_git(r);
 	obj_read_unlock();
 }
diff --git a/packfile.h b/packfile.h
index d7ac8d24b4..cf81091175 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,12 @@ struct packfile_store {
 	 * the store.
 	 */
 	struct packed_git *packs;
+
+	/*
+	 * Whether packfiles have already been populated with this store's
+	 * packs.
+	 */
+	bool initialized;
 };
 
 /*

-- 
2.51.0.450.g87641ccf93.dirty

