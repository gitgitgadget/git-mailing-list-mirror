Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C603A7F66
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999851; cv=none; b=OrlACHeZuVeX5heUA+wytamWk29VIbOWXreJrU5Yb3jqCjd3wlOgb0PeNWFbWOEaRZb55GSA7gSaKoxboI9r+NoVKoyBKa73O5ci6KcyvPDn8FUDluiQXkts+fkazVTz8DBUba3cdl91H/4MmhasPrjcJ+ggEJAvrwdMx9VyjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999851; c=relaxed/simple;
	bh=JSPXN7NwtWe59uhrDwxDVCrg7YXPTIS2BLkkjSb0KPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ve3/BxDEbbWdYPI2lTRqIDqjNiM8I4zRrJobKkPlqENh5XEFgnuWI3PWlvSGO/1kLZ50SVFJt+usnk/ZX/eTYkrWPUGYgoFN2H4ExBHGusjAaw30nLXVky2T6ulD1Wp3Uxn45WRteKeCpoJRASVk1TSx6PzgpJRVxtid3nKWvMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CUbXHQPX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLjaJ7yF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CUbXHQPX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLjaJ7yF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 24D401D00125;
	Wed, 21 Jan 2026 07:50:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 07:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999848;
	 x=1769086248; bh=xFLiACMEoR3j+fYNLETlBjk6t4qJHRDIsQSXzI9xGg8=; b=
	CUbXHQPX8bzPlsVE8NdGt4w/hlptBX9cWulWoGNvrMKdh7UFuCjTEjaEFpZxRwap
	fabeHdHt4f+ZWDDipVsRHqqdvzBfHq8JwwSDc+0/dNOt3BZEm0bBsnL9E0MSqjGi
	zl3okNertqP/PwtJp+7u6KPeNqfuAlLjn+YQkgGgKSwu4WuE+Ls3AKxxHzFUpFM+
	ApEXSyIT4IJ7WSN4jPrEeLePn13eqBtCmO5hmF6BAEnuQ2J4PjABSph/AuZ1LptV
	fdxaKjsezqXp4RH+ZYvfwbhyo+rnDlrwEkdcNfKI/x/zoihoX/wCS5EFvi5GR0V3
	R9Tw32Y3i5z89t+vB5U2Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999848; x=
	1769086248; bh=xFLiACMEoR3j+fYNLETlBjk6t4qJHRDIsQSXzI9xGg8=; b=j
	LjaJ7yFftEPfIXR37ISSiF3jx0IHzh/6ZT9XQkbpFZK70UIyjhq92jjMREqlUq0I
	5VCE8yRFASnL+b0x2/tuYOJTjigQ/AS6Uwz0QPTYQsXbOOiu2qxXGLR7JLpO4MxL
	BsU4hE3/0s7UNgAcILrvOI84eNwtvOOp6nhh8sCCaJE87BlPLC3XA4c4bciJcYQ4
	O4NsB8YbXCcQ3o4vo7xUkcxHWcQldZQ9jCwqnhCKRElvcYe1M4Nzfj8ZXQJ6yVH/
	q0w+ZYFAbG2wrSDy63AHQX2m5irZwmcoz7zOAHUH4P0COtZ6dnSKTkHacU8g+yv4
	2KUx4VG3uyCdD1na2sNhw==
X-ME-Sender: <xms:qMtwaa1H2b6C045RKjuooMkQfpu2QF5b3MuLDV6hxfXoHpj7WLnhxQ>
    <xme:qMtwaUGzk_U-xO2I_Ra1vKEK3pY_mmqoyS_5hLjmbUb7r42oM8nM7DjHIdmbWewez
    Zz1GoHgO8jxdNxebXn60xgc5prGv9DAzI5UwtrzKGZHYPxwygIb>
X-ME-Received: <xmr:qMtwaX7GxU5gWcmnHMwpAnchykLwsy89EVpr4SkKUDNTnTgr7xF3jReRqWZnoqXAcU9QuWe-XYk9rHAyUk_GHPysfLl2w6LcBLw2l8zmc0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qMtwaavF0lPNmzJkaTjf9HZuf3LKDYIFr8ulwXk5oGZE7f3h_AfNdQ>
    <xmx:qMtwaY4BOz-_oUzJrLN5nJV_RCkvewIrgtXQgxUnqWw7pJBTkJHMWQ>
    <xmx:qMtwaVWLA9Hq9kmSrpxG10xYKL8XxXaiEpxFFic4hpWIfmzCgxF95A>
    <xmx:qMtwaa_E993TwchLTfsH6IeMY_cVpZu-VnVbLPrS-PL0zvZNZC7rrw>
    <xmx:qMtwaTWXpvg9fVoT0leR3dg_y5Vo_Y77X-X9Iytku3EMS1nDvn2j3FZs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7fc759f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:22 +0100
Subject: [PATCH v3 06/14] packfile: introduce function to iterate through
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-6-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Introduce a new function `packfile_store_for_each_object()`. This
function is the equivalent to `odb_source_loose_for_each_object()` in
that it:

  - Works on a single packfile store and thus per object source.

  - Passes a `struct object_info` to the callback function.

As such, it provides the same callback interface as we already provide
for loose objects now. These functions will be used in a subsequent step
to implement `odb_for_each_object()`.

The `for_each_packed_object()` function continues to exist for now, but
it will be removed at the end of this patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h | 14 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/packfile.c b/packfile.c
index d15a2ce12b..cd45c6f21c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2360,6 +2360,54 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	return ret ? ret : pack_errors;
 }
 
+struct packfile_store_for_each_object_wrapper_data {
+	struct packfile_store *store;
+	struct object_info *oi;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
+						  struct packed_git *pack,
+						  uint32_t index_pos,
+						  void *cb_data)
+{
+	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
+
+	if (data->oi) {
+		off_t offset = nth_packed_object_offset(pack, index_pos);
+
+		if (packed_object_info(pack, offset, data->oi) < 0) {
+			mark_bad_packed_object(pack, oid);
+			return -1;
+		}
+	}
+
+	return data->cb(oid, data->oi, data->cb_data);
+}
+
+int packfile_store_for_each_object(struct packfile_store *store,
+				   struct object_info *oi,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags)
+{
+	struct packfile_store_for_each_object_wrapper_data data = {
+		.store = store,
+		.oi = oi,
+		.cb = cb,
+		.cb_data = cb_data,
+	};
+	int pack_errors = 0, ret;
+
+	ret = packfile_store_for_each_object_internal(store, packfile_store_for_each_object_wrapper,
+						      &data, flags, &pack_errors);
+	if (ret)
+		return ret;
+
+	return pack_errors ? -1 : 0;
+}
+
 static int add_promisor_object(const struct object_id *oid,
 			       struct packed_git *pack,
 			       uint32_t pos UNUSED,
diff --git a/packfile.h b/packfile.h
index 447c44c4a7..ab0637fbe9 100644
--- a/packfile.h
+++ b/packfile.h
@@ -343,6 +343,20 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 			   void *data, unsigned flags);
 
+/*
+ * Iterate through all packed objects in the given packfile store and invoke
+ * the callback function for each of them. If given, the object info will be
+ * populated with the object's data as if you had called
+ * `packfile_store_read_object_info()` on the object.
+ *
+ * The flags parameter is a combination of `odb_for_each_object_flags`.
+ */
+int packfile_store_for_each_object(struct packfile_store *store,
+				   struct object_info *oi,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

