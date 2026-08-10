Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFA306768
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368828; cv=none; b=uSCT/01uJfbzs3v/DtA/5DItwz5ARiXLkuLQYSYB+acl8KohvDuSHUuY0iM20dtQyIeL7g8wDXmDuWAoboAqd6Vc0GkvLWaO5xbxwohd08ORfokc0AnP94gkliaUL6NnmSHXsJhzIvueWLljNoF5zetiYkrtb3BJ9DVRxoVnoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368828; c=relaxed/simple;
	bh=CtxgEUJfzytz3d/oayPEqOpqOucT5oS/oE359CwqA+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVb6dRmnDjW80TMNYhWF3frVEFIsQNd5J4ZdFQ0hiRLp6okYehX4UxgzXtGOaC/2fkWZSbERFJnxibMTOCrrE7agjsm2vUsz/OfwZlXlhFegShAsoweDjjY9ujhWHRwq2/isCNcWY2O/ZITxWvHiVd+iKVZ1nzhDeQ1qMtjkDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YCvJclOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gb7haQi7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YCvJclOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gb7haQi7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 938A514000DE
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Aug 2026 09:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786368826;
	 x=1786455226; bh=JeL/8uoy/DEIzIUDzFycr2SDbkXumgRvbI8JHkaDa5I=; b=
	YCvJclOj0OS9v4JTvKdQ+qVoNo2zeITaJiRfa0bU+CogKvPgBIihOoo8MK8Yai8w
	h1/rRQ2x1vH4RbPIZbzWLPYMFF+qyX26bqs9WYzZzYaf+HOYYZJ7w0xmNtdfGOpQ
	N32EhsckkgcibdYZRER9u5OGFBofoa/xQ/M8zeGzfPSbQAe0Y2VmS6iXnwTVgE2b
	EtmvDyZlMqlMjCXRQTsXrhydmYGamZAfvBQ+DGVm+6hjAkvxMgkmMwBygMrvj/fw
	GOPx0WQ1yKp+3LTZfhtzZaPPDt7slYa/hUUVOqnBBpSDB7rsfbZHAGgbMdxNx2I9
	2Ln1/qO8dZcYHCpuc3V8mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786368826; x=
	1786455226; bh=JeL/8uoy/DEIzIUDzFycr2SDbkXumgRvbI8JHkaDa5I=; b=G
	b7haQi7P1aQIf7RH/JfvXmNMi9u/rySE/WZJXD3aEXCN0LCZdYzUv+lOwVub3rcv
	NRmoVAtqNWieaPtWsm+fkvwBd9rj/Vx3ROVp8uMtFycJJ+0iGhyNLpAGd310JYhP
	TbBKf3SXnDoMYaX3n5U6Ke8me0HswJIJfUDX+ZlaKhokJ3ukqHvHniaPKqMPciC8
	kn5UZAXqkmXK5Tsk32ACH7n+e/fh5nmEAqWNyp+QVSJgW5mEWtkKwWifazhQVmyE
	8p/VyZOoGu91zQ3hbGpfqBhjsL7iMv05Bg5tOQLpxeRSLJW7tgv1pv4+qmDxhaul
	q/bMMyc9hYAmqbS8B6LWw==
X-ME-Sender: <xms:OtN5aoetUPJI5TKWuPFTmtWMW3U37W0lc7eydj1sCFsAiaP568zeKQ>
    <xme:OtN5ahJBVVk76GOPq68JLavlnYYX11OnAZtxLGznm4UfnqwAg1h7yfQneptGEKZC-
    RF2EaUebtIiXoMYJuC1eF3k35i5Wy3Pcb1NJhPztAY_My025iVP5g>
X-ME-Received: <xmr:OtN5avJLfbb29DqmSnrY3psLZVKaMveQyN__kDRDPJXRZaTk3ijRZuhxR2GCrgjenRQMLm1WZ7lltMInNCUan-_Mvv1SmbLUXt7ee4xVqg>
X-ME-Proxy-Cause: dmFkZTFsfWpSbx/CDox6Jnsy6e0UoN/85ZstWLXW8a93XVOT8RRdhP+REPoA32d0vQVvAa
    /DhK5xYXyMcLSUeZ6V2YmN1a+udAdWCOK0aZu38tPcyNF3xQGtDoaLANxRlOYZnTs8qUh3
    uJU1aVt6gLYMfSn5x2DJPzy/riPc54gt3pQr4SufpueN3tnQz5etjMdJXIIhouENaYJ4f6
    bhHP53UVrDvBcyoZWPOQwpQVYlcl8al8vGBpDRDGdEv0SbYM5jYJE7HxqmaKOu9v3R7oSt
    y4LVLcVX+rz9jOo3jYjY9szEdlk1EVO5N/gJyudhTE7Y9XqeJXqrV2z/6Wgf+s/gxC8Unu
    QFmRAN4bDBhJmgIX5/5kAYNrxfZjAH6NXOYTh3Pk6Q/atgXMp0xyTj4wvHeRWzPx3RoUzq
    DzcuRnFhzG/liDQWE4D23lr8Nnv4BzbOuwQtdVEeH/MbPUxjuSqN/O4DLv6g75qYK9DCPC
    ZNyWmmoxb8NvBC362HmOZRBDYWDQicfen18weIP3vUrwCHIXCKwR1KGn3KZ4an2CP9Jmmy
    6JNg+Ij9lQXd8eMUEJA1NpWWWjoG9XVIcukdjd0Yj4BjaIcR/sIgKM92CLRDnnu/a80/cb
    sEGJLdwIwDXWlSNEfFhAo/aK7zQWNJUrDqObKiTk/yYuwDOPEiiWbMJPJ1kQ
X-ME-Proxy: <xmx:OtN5ajFDIo2lg-KUOSUMxQAbB3Swqs1JuXVTlbi3RKj6bSIG2SL6fg>
    <xmx:OtN5akmXRfA6Oir0nTZmPcZND_M7ahaan4F_FkmpfQVfi4HoEw0gBw>
    <xmx:OtN5agLtg1pskvo40Jv82xX-WhL9U3n4JicgFrVZ-Ll94MES8v-iyA>
    <xmx:OtN5ala_8llxfoA-0ZgKmO-6QODAbjb9NnuggGhQ1IwDBq6aiLyFRA>
    <xmx:OtN5auPAYU4i_dtV7s5o8xghIRkOY-NQtS0-NdACjZEuXKelNZodPowy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b8a45fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 10 Aug 2026 13:33:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Aug 2026 15:33:30 +0200
Subject: [PATCH 3/4] odb: drop `loaded_alternates` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pks-odb-eagerly-prepare-alternates-v1-3-f0fa4a4004e1@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct object_database::loaded_alternates` field tells us whether
or not alternates have been loaded already. This field was useful before
the preceding commit as we were indeed lazy-loading alternates. But now
that we started to eagerly load them we can assume them to be loaded
after `odb_new()`, and hence the field does not serve any purpose
anymore.

Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 9 +--------
 odb.h | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/odb.c b/odb.c
index 2ae8228dd2..2eb37a2f44 100644
--- a/odb.c
+++ b/odb.c
@@ -230,8 +230,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	int ret = odb_source_write_alternate(odb->sources, dir);
 	if (ret < 0)
 		die(NULL);
-	if (odb->loaded_alternates)
-		odb_add_alternate_recursively(odb, dir, 0);
+	odb_add_alternate_recursively(odb, dir, 0);
 }
 
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
@@ -495,16 +494,11 @@ static void odb_prepare_alternates(struct object_database *odb)
 {
 	struct strvec sources = STRVEC_INIT;
 
-	if (odb->loaded_alternates)
-		return;
-
 	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
 	odb_source_read_alternates(odb->sources, &sources);
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
-	odb->loaded_alternates = 1;
-
 	strvec_clear(&sources);
 }
 
@@ -1132,7 +1126,6 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 	 * the lifetime of the process.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES) {
-		o->loaded_alternates = 0;
 		odb_prepare_alternates(o);
 		o->object_count_valid = 0;
 	}
diff --git a/odb.h b/odb.h
index fbafee174b..aefb34213f 100644
--- a/odb.h
+++ b/odb.h
@@ -69,8 +69,6 @@ struct object_database {
 	 */
 	int source_paths_icase;
 
-	int loaded_alternates;
-
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will

-- 
2.55.0.679.g6767b8d81c.dirty

