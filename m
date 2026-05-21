Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706063ACA74
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351794; cv=none; b=reL0+m6BnZv6JvY0QDAF0xOteoGY39bIj5P3c8+WF0G+V0b25CacW2WStRvtoh828DfLIF0mQe8DaBeZ809fWRTQFvZ0D+iF/E5i/NDviWuFg7os96sTb/sHKYaoAeWkQA+YDGbVWl4IRN+8UOb/KP+7VecyOVLCXUEcPrB1iBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351794; c=relaxed/simple;
	bh=HxOPWDyz0ZzX2QFjJD52vvPNTNnFsn8qq8qf2+lUCXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3Kso4pGE11ccRinJ5NHfmkvBRhHY/hdaIvzF0b6Zy9iRiNpF9cmhQj6M44YiPVUxX9pwgU8BNLMIZFQ48fUwJUqa7J4FbachoW4C4hvXGvjS8tV71D5UZj5XJIWxeiwXDBfBsqVUQ5Yqf4ahvM81xlyatCHzw/IGF8cdxJCY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aZRRn+YU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pnaByRG3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aZRRn+YU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnaByRG3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E0210EC0087
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:23:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 04:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351792;
	 x=1779438192; bh=kHhhYCfi2wNMJQOnKGAohTWPSzXMDtLTLeuLI/iUcJo=; b=
	aZRRn+YU7zdE39tRonUxn/VI/6sbhXpG/bL3L4aq0nbwHuRONfosLp2gzKqGdmAB
	UFOcd8J2gnlAIkQhQy/zakPYWSlPQSGlrtxiOBi6c8K+ja41/GGGPyk03kuFILjO
	2yq6oSpvHHtyJkvQ9RWwMv/rRabFXmuXFoa8Jxc6qPNpKKxAZrxdTRauz6y5huxo
	fU7UuqELRC/DRZFPTap0v37xXLFn+XEYeBHhiTVT0nMQTmJy8VL6DNb6ezejTBDV
	LfHJskskKKfRiVkNR1OBZpHTzE8Yr+Y/w15PSCbS3bXlcGfFKvcAlIShNzwCUxWy
	XWORhFOpnOma22TKiBfZDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351792; x=
	1779438192; bh=kHhhYCfi2wNMJQOnKGAohTWPSzXMDtLTLeuLI/iUcJo=; b=p
	naByRG3FcRotHDj7iYBbyin5jpcjV6onhUrWtetGca/kaL2UCTXF8nY+gMPHS3VB
	0U7bHg32MIIqjaXChQuRAuDdTRvsuHKGmvWlEAYm0p0QB2dTXuySRDJy/NQmsAuf
	8OCpe6NdOiXpKYMrf0azxzvXWnv1NuXZ7nyPe5+erXuUCNyL7XwSNIf/lDcsK5qU
	FzhM/LEmpnV2cd6srQTZj29e+Nr6tC+ki3IaI0QBuMWS751zu1ISGf4CqWj3TySr
	j4K/5rbohGK6P3qg3z2ZnbCvKEQWzZl6dw+wKDOEl4k/qCvenVqi6AONe3hDdHwb
	Yml4nmRd1yOnGxPiCLJeQ==
X-ME-Sender: <xms:8MAOat4hQbI-XMJvstsmhkTBALdeddzGG5l0dBgXDqAYd6l0PjDeWg>
    <xme:8MAOah30cM3VZuFkbtegmndyyF99VLd-0rH88PaQ1hIsK19tJbn8pqQUwOkkrOqq2
    f6zp4Rp9pdr6NysyaDBZuf4wSzqaVnwj6D16tWf9uVwP3DfTJIYHqc>
X-ME-Received: <xmr:8MAOaqFpSKHMLPdSDksuDuABF6Z_oTd4APUAv2FjY8f5DPTJaBTOh5yhKWAmU2K6_Oh_QQDuMP9iAxPaZjc3nLs5CZ1RDiFz2gOuHmIUgiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:8MAOarQgnSHvrKTff550XkbYpfaHSnYb7Z41ZJgQCab862ac5D_wLg>
    <xmx:8MAOahCaXVpe5fkGzeGPp6O3ZmvUar_4azVnj26w671rShxA9RSBpQ>
    <xmx:8MAOar3lrzpd29Qd9NOzf2xSji0cY25b-6EXyzqqVVsC8qE7G3-mGg>
    <xmx:8MAOavWoh8RIoxBoSZ-U0HNAWESYRENwTcZ7D-r5dLG7MA7B_IJ_dQ>
    <xmx:8MAOaiYFq3ZDaiB-NgDJzuj7Lf-M5z74xak5b1cyW_84Ts3yy9DZQ7KD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:23:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c1a6792 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:23:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:36 +0200
Subject: [PATCH 16/18] odb/source-loose: wire up `write_object_stream()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-16-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Wire up the `write_object_stream()` callback.

Note that we don't move the implementation into "odb/source-loose.c".
This is because most of the logic to write loose objects is still
contained in "object-file.c", and detangling that requires us to do some
refactorings as explained in the preceding commit. So for now, the
implementation of writing an object stream is still located in
"object-file.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.h      | 12 +++++++++++-
 odb/source-files.c |  3 ++-
 odb/source-loose.c | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/object-file.h b/object-file.h
index d30f1b10b2..b864351372 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,7 +23,17 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-int odb_source_loose_write_stream(struct odb_source_loose *loose,
+/*
+ * Write the given stream into the loose object source. The only difference to
+ * the generic implementation of this function is that we don't perform an
+ * object existence check here.
+ *
+ * TODO: We should stop exposing this function altogether and move it into
+ * "odb/source-loose.c". This requires a couple of refactorings though to make
+ * `force_object_loose()` generic and is thus postponed to a later point in
+ * time.
+ */
+int odb_source_loose_write_stream(struct odb_source_loose *source,
 				  struct odb_write_stream *stream, size_t len,
 				  struct object_id *oid);
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 2ba1def776..83f8066c67 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -7,6 +7,7 @@
 #include "odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
+#include "odb/source-loose.h"
 #include "packfile.h"
 #include "strbuf.h"
 #include "write-or-die.h"
@@ -175,7 +176,7 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 						struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	return odb_source_loose_write_stream(files->loose, stream, len, oid);
+	return odb_source_write_object_stream(&files->loose->base, stream, len, oid);
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index da8a60dba1..e52fc289a2 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -632,6 +632,19 @@ static int odb_source_loose_write_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_loose_write_object_stream(struct odb_source *source,
+						struct odb_write_stream *in_stream,
+						size_t len,
+						struct object_id *oid)
+{
+	/*
+	 * TODO: the implementation should be moved here, see the comment on
+	 * the called function in "object-file.h".
+	 */
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	return odb_source_loose_write_stream(loose, in_stream, len, oid);
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -692,6 +705,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.count_objects = odb_source_loose_count_objects;
 	loose->base.freshen_object = odb_source_loose_freshen_object;
 	loose->base.write_object = odb_source_loose_write_object;
+	loose->base.write_object_stream = odb_source_loose_write_object_stream;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

