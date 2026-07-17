Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81D3C278B
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280758; cv=none; b=Rh/NXlOyt3wM7QqJqNo4K1bUHkkVyPJc1JYZssTsi4EyedaQJR2UNQQFre2tQ3b8QxbFlKZZQBhYYvCxTmn6pLAxkqexrUD8PM/7epzIT44m4gnKvV4PaFnNzbXxCWyoXRENxYZcGUlAo0VMqvVmWIE+H5M7PArc2ogbz5arB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280758; c=relaxed/simple;
	bh=IIp0xntvXZrLPo5muWVaVl5kiF9HuF6tzcwqWVHy7a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZBvGlt8cfhW/AdW7l//ldmYzQ7YREMLFng6GYJ/SYPVxoo+ki+PaPUWzpvWvmKh1Dln0V/83XSRw2cEKPt4Tjad31w8rbGXD4S24UOzUCEr1dGmOGeRlHzYxRhweH4ZQpxuuMNLvSgr+xEeJSL8rPPxayLaGRQpxsggu3yScJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EshKnUSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZfjQ/pB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EshKnUSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZfjQ/pB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32A457A0097;
	Fri, 17 Jul 2026 05:32:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 05:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280756;
	 x=1784367156; bh=FU3lJ0BS5NxFDvLYJnsWImxEqoDvYwL32bgx7WQW4RI=; b=
	EshKnUSp6bppQ0HO0ZsRttLASCxJUzO7TRJIt3GYt9OUkLvkVfJsauGzg0FfdL3H
	bTqUJvShS/NCox1lCH5iD7lS+O1T5+azZRk3o4a7iRHLFmE5CtWm/1ZxA7ik2cGR
	K6eX8rbR0hK2TZGWMl6CKEwbybYn7UTPCKWuuTEbo8viiqz9WNwti1SHr+vrIhLP
	SOBQXF6xouyz/UNByUtdKRN+GIQ5AMju53ArlUDjSzvF0tgEZjTgh3x9ElfbUPlu
	Z5n3QAPfHpfvE3mGhxtHymIhGLAvn4vK5WrgPX1K9fjbOTO3RFwJnUrPph8I/woj
	YMi1qWjATBqXfgftvnq7iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280756; x=
	1784367156; bh=FU3lJ0BS5NxFDvLYJnsWImxEqoDvYwL32bgx7WQW4RI=; b=W
	ZfjQ/pBQbOrENswRMN6AAkmcSusuNcosev5baXndBgf5lb7vqJs6wXa/WevpJQPv
	E7+UQQ7yAIjuhPrUzPtkUNaeOYFKdSjNK5ICiDK2+xdkv1ZanR7nUYipWjZDP80J
	knB2if2Uz3jtQdoBzZDrihM6VPGB8fmnh+5ywmS8ivYxmzX7PQMhkXTq5zT21Xd7
	gml2VWaD4KiOT7Fy3/HYhQXQnl4NvK+DDwzxY279Wy4keniguwjAN0c5xC9yREKe
	mHazoljddRr/nlc+04avvjA5BS2o1X0xT7ouzxFzvI5F224G4LWfgglsgZHGOntH
	AiFimxSv3ppbo9TaMyDUw==
X-ME-Sender: <xms:tPZZajUM_4HHgKg6cnbqre0Gd3U-wHv9ZcSOhUzEyF1nbOHnnlYHFw>
    <xme:tPZZahlw_4088_9qRl3Ak4Xg3WyAe34nRsxU-ogKWdvEGgWoMtudvz9Zu_CPTaHLA
    pv-w8VdzLP947u2xeffZTBLApSjBFnjtpLS37WGwu_40vWj4-bf>
X-ME-Received: <xmr:tPZZatAmzi0gkHagjaW12Zp0BhHb471fK_i3fxI2PDuC7xxvuecvlf44cqLoOoc9pNYbr67NEC5nQhQLzaZtBwVC9hTk0mt9QD9jtfv3Y8o>
X-ME-Proxy-Cause: dmFkZTGAjh6BdWTVqzaF88ulSCJquC6NOw6UUiO5I72vQ7mX8nWiEoDJbWlq0hEowNH1uO
    uBFO8VfJQrynzcRjMT9GhHw/ZWT0uVwl10dcEAYtRLejcG9k/wmtZHume01VNzEvqrewa4
    m/rIFh+MJUiNxD6zxJBr4cyTELl4kuW08CHtpvIuz93Chp1Dbb7L4pk4WQh31wMnmH3rkm
    KrWv1Gv4zneQjloLU00vcvWSQSG2wAQAHQVdUOqxte9aTMMQFflkzrWiuu1Zzwk2WNGCO0
    hJILUEA0xlv8JRDswWZgg9JThdx4qSWdp9P6dWJfQ4IjEbWh7alHDyMNEQmlbV/oGKv0YR
    x02p9K7ZdSIMlCfc586Vw9eQicL/ACXzoPzD/yJYJOF6JdGXZ4R9ba0kjziXteJOulKnrx
    7hQTOLf61gq3JpHAioJy9OYzjQxgI6aNYh1zl406eP8qVQ4jRq2Okc/bHjrcjKe0ZBsrx6
    GZzPHEdgIgzTVhgdqb2kzSIcb6So8dKRmDVvPhRSNzt3Bxt+UdxpLfvj3dCPGNxmljbtFr
    gzzoDwagTRx8RWuloZpTFeZPsZytENxkBcoSGbW522dWGckgLgmwbZYusWLtr1fxIQ17mJ
    RAq391be2B/mbQocdS/cCTIKZ7AmuFhvvRch9GxKi0gqQ98AFz6pLyQsCurQ
X-ME-Proxy: <xmx:tPZZapevPweS2WdsHP2-_XXufNREfUZcCYzWM3ArpSJa-VB1rHjLuA>
    <xmx:tPZZagLr2Qi7WK74eKUMmewmQvVLsJaghqCOwcoCoEXwYksWtraqIg>
    <xmx:tPZZakfHXI2o900F5XC7DMSGtqYUdkHhAE8SaLqGJxns0J0zqjLmqA>
    <xmx:tPZZav1Vk64o_pGV2QkAuKJz_2lk5ic-rf6MrWO6ZAiirFRCAojvzQ>
    <xmx:tPZZaoECYZXpG3Tbmu_cXqLB4MGMDU8U7DyCGp666uloazyH4E_wMgAe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1064e195 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:15 +0200
Subject: [PATCH 7/9] object-file: force objects loose via generic interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-7-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When repacking objects we may end up "loosening" objects via
`force_objects_loose()`. The implementation of this logic still sits
with "object-file.c" even though it is ultimately an implementation
detail of the "files" backend.

Moving this logic around is non-trivial though as we depend on
`write_loose_object()`, which is an internal implementation detail of
how we write loose objects. Until now it wasn't possible to use the
generic function `odb_source_write_object()` though, because the "loose"
implementation thereof would skip writing the object in case it already
exists in any other source.

This restriction was lifted over the preceding commits though, where
this object existence check is now handled on the object database level
and not on the individual source level anymore. Consequently, it is now
possible to use generic interfaces.

Refactor the code accordingly so that we can move the logic around in a
subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/object-file.c b/object-file.c
index 067a63a4f1..89825feed0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -898,13 +898,11 @@ int force_object_loose(struct odb_source *source,
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
-	void *buf = NULL;
-	size_t len;
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct object_id compat_oid;
+	struct object_id compat_oid, *compat_oid_p = NULL;
 	enum object_type type;
-	char hdr[MAX_HEADER_LEN];
-	int hdrlen;
+	void *buf = NULL;
+	size_t len;
 	int ret;
 
 	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
@@ -927,15 +925,12 @@ int force_object_loose(struct odb_source *source,
 				    oid_to_hex(oid), compat->name);
 			goto out;
 		}
-	}
 
-	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
-	ret = write_loose_object(files->loose, oid, hdr, hdrlen, buf, len, mtime, 0);
-	if (ret)
-		goto out;
+		compat_oid_p = &compat_oid;
+	}
 
-	if (compat)
-		ret = repo_add_loose_object_map(files->loose, oid, &compat_oid);
+	ret = odb_source_write_object(&files->loose->base, buf, len, type, oid,
+				      compat_oid_p, mtime, 0);
 
 out:
 	free(buf);

-- 
2.55.0.407.g700c83d4f3.dirty

