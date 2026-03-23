Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007835F167
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253156; cv=none; b=PpxaotfDLBhJbbI5vWyZNfV8M25ECp3jLL6sVKwSJleHWYqWkehVpOlvPUW1DmjuERhufzV3/wjtf1jZT0jOzMdUHz8QbW97hlL+TmVE7AIlXhVejjqYVOO4kcCbGIYlKopSTr7EXZGjc74SdnoyzvO9GTDB8ok+81DQ6PuSeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253156; c=relaxed/simple;
	bh=FiBFbnkhGaYMbGsBwIpUVUq1BP+P1jrRf8I1e5Xl/T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJbsFL2DUKERHJvrrxmD82SVgr0sIOwd7+hVXw52j5AbT+3WN7RacMSiVS+3BP2Hvbkj+piqiYKelVtTuLHmh2WT830mXXhHvrI87e1TJMH3emKL7OaIAiV0VOSsthgtc5q/YjO2kbzsEdCbcyDbpZMtMJf7stTzPHrOUznFICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdmyw/gN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdmyw/gN"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1685294f8f.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253152; x=1774857952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVxhH4F9Ommp2ran3hnmOlePDKFvX5LgI9uMv9/dyKQ=;
        b=Fdmyw/gNgMPB91H3eZbb5zO/8+Yn0jGMz5dj+fTyhWdN+kz2yqg94VTZxRSvx6Z31i
         B/NEsqRYO19dwPplKuMrN5jJwX48SkzAg/rxfULIdoGq+XLHOn1j++995z6DGGgp3VGU
         SvkFxOCTs20ZWqGHORYr4FTPNRaFN490JlmnaomDI8zwLgcgyQsjQ5ZPBwpL/ukrBEAY
         diwICmAIAzRMLTAV44X1tdYHnjWOWwpB1V1ng3gMUqGVr+i4LQjNpoaZgGDUm5SiZbKP
         TBSz7u4+tKXwc378ZaY9xhKtTHXGTUB4vXJJ/VvEZmC8mL2fhCX+CiQU1xC6qa2ly+RI
         UqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253152; x=1774857952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IVxhH4F9Ommp2ran3hnmOlePDKFvX5LgI9uMv9/dyKQ=;
        b=ZOwA8BTj2sZU9XzxSm6jjVCHIDYGpqGxsF9S07wNKwC3ggDX/Zh8XxVj43ruQRP9/I
         NjlaRCO4+YOiwTpeXRTdp2ckG+BbWAQ4wrzm4+y3kL4ixG0EcqYvsfVaFzYLKiAABga8
         b02MMuvBArsg4KEOSjyyNlhFeQHwwixrHFraL0yFaFP1Hr7jZ6tm2atOHAskrblbT0MD
         ECQ/rC8fWhvUcgnMnB5gna6wcDr/xwqqt+ObGUMAU4zI7vcyK2xTUhkDksSsHU8E7d8u
         Sfm8dwcGojS4yVJV2ucTc1/MYJ8HCC1KNvWye6d8spMggfQfpZAESQWwyaM6F9NaIDL5
         NKCw==
X-Gm-Message-State: AOJu0YzHl5INQ1rshbrWtZtgUn23YCDbbe8teGtomeQvpvDb1Lmv7V78
	MlGhDApx+nbigNl8GBy13NnCQa/jipQvuXXsDCOn4odsFgWAGiVD/FyxGfnTLQ==
X-Gm-Gg: ATEYQzyoKBpZOl3UELHhVYMiVV+3LXQf9eh0XkZPt/vvuKvjPjY+WGFJ9VAfYsqDy3g
	xMUwNBJuSeNV1znd1Z5chE8CK6zKxl3DxcHdsQKxXSCtj/UxcN+xE7iXXwhP470TVzdzcaVE4O+
	r1k7C5XFDhsX+LW3c5H2O3DKClPhBWmCASdxCpsOUPuc57EdBzdGzo9qf6AbSRIprdqAcMDhTai
	qFJEzlq6lRvGhLeki27MoN2OYnT6d+cm39wgU9xK1r3Ge55GJQhpaIRZTmuhaVkn30XBwgCNnFS
	Bkta9HT6cTALx6VZwsei43W9X3uiTpTtjrPjd2SZPKq7i71/ZIEnIr6+GSYJV8Qo+Fj1Gzs/MBF
	FTqTU6MpYMpNbrthtTOWH2gQSj4iLJPB3tq7h6E/623YaD37Ads9kb84BtWrtLZ5FoDZwoxoola
	B/BXWz1ZG1M9FhcAT50GYJFuAIpy6GgwSHtrqcts0tDW4zPTZ5BEgcgXqfnrLJM4Qbbp1O5qVXT
	kp1MdS7FyficR1jMVy9FFFfG/PL6PqrmQ3W0Bw=
X-Received: by 2002:a05:6000:4013:b0:43b:4960:60f2 with SMTP id ffacd0b85a97d-43b64291854mr16694940f8f.47.1774253151716;
        Mon, 23 Mar 2026 01:05:51 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:50 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/16] promisor-remote: pass config entry to all_fields_match() directly
Date: Mon, 23 Mar 2026 09:05:13 +0100
Message-ID: <20260323080520.887550-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `in_list == 0` path of all_fields_match() re-looks up the
remote in config_info by advertised->name, even though every
caller in should_accept_remote() has already performed this
lookup and holds the result in 'p'.

To avoid this useless work, let's replace the `int in_list`
parameter with a `struct promisor_info *config_entry` pointer:

 - When NULL (ACCEPT_ALL mode): scan the whole `config_info` list, as
   the old `in_list == 1` path did.

 - When non-NULL: match against that single config entry directly,
   avoiding the redundant string_list_lookup() call.

This removes the hidden dependency on `advertised->name` inside
all_fields_match(), which would be wrong in the following commits when
auto-configured remotes will be implemented as the local config name
may differ from the server's advertised name.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index da347fa2dc..8f2c1280c3 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -598,9 +598,18 @@ static int match_field_against_config(const char *field, const char *value,
 	return 0;
 }
 
+/*
+ * Check that the advertised fields match the local configuration.
+ *
+ * When 'config_entry' is NULL (ACCEPT_ALL mode), every checked field
+ * must match at least one remote in 'config_info'.
+ *
+ * When 'config_entry' points to a specific remote's config, the
+ * checked fields are compared against that single remote only.
+ */
 static int all_fields_match(struct promisor_info *advertised,
 			    struct string_list *config_info,
-			    int in_list)
+			    struct promisor_info *config_entry)
 {
 	struct string_list *fields = fields_checked();
 	struct string_list_item *item_checked;
@@ -609,7 +618,6 @@ static int all_fields_match(struct promisor_info *advertised,
 		int match = 0;
 		const char *field = item_checked->string;
 		const char *value = NULL;
-		struct string_list_item *item;
 
 		if (!strcasecmp(field, promisor_field_filter))
 			value = advertised->filter;
@@ -619,7 +627,11 @@ static int all_fields_match(struct promisor_info *advertised,
 		if (!value)
 			return 0;
 
-		if (in_list) {
+		if (config_entry) {
+			match = match_field_against_config(field, value,
+							   config_entry);
+		} else {
+			struct string_list_item *item;
 			for_each_string_list_item(item, config_info) {
 				struct promisor_info *p = item->util;
 				if (match_field_against_config(field, value, p)) {
@@ -627,12 +639,6 @@ static int all_fields_match(struct promisor_info *advertised,
 					break;
 				}
 			}
-		} else {
-			item = string_list_lookup(config_info, advertised->name);
-			if (item) {
-				struct promisor_info *p = item->util;
-				match = match_field_against_config(field, value, p);
-			}
 		}
 
 		if (!match)
@@ -660,7 +666,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
-		return all_fields_match(advertised, config_info, 1);
+		return all_fields_match(advertised, config_info, NULL);
 
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
@@ -672,7 +678,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	p = item->util;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return all_fields_match(advertised, config_info, 0);
+		return all_fields_match(advertised, config_info, p);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -684,7 +690,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	}
 
 	if (!strcmp(p->url, remote_url))
-		return all_fields_match(advertised, config_info, 0);
+		return all_fields_match(advertised, config_info, p);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
 		  "ignoring this remote"), remote_name, p->url, remote_url);
-- 
2.53.0.625.g20f70b52bb

