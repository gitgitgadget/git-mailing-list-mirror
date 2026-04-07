Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860153AC0D7
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562787; cv=none; b=oodnqPCxvqFf/9WrhD48p0hcEqjrpplA/Pm2/+KlAkeDJ8VsUsVfjNtd1+drzGasVXCppLY6cpd8JTrdGaGgSyG8QOaPmf1/+kHnBPcXUUnDZF+9Z9fGwSr+32ozWVr9A/dF+6Xp2/2suqS01CknkUbMeCGYD2amsLwK9QFLjkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562787; c=relaxed/simple;
	bh=+PyuT9Oi396BuTjTD7O7FB6xlcZdKpUFxHwUkMu9Z5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+iDs11YHRrodWBPtDzK0v1egD9LC6PFLmN3gQd3qKaV+Q2XsvVAN+zKHZdRJcio8MEbhn6whq2JmJzjr/Ayul4DBDbqdxmepk14xwTJl0TpWP8fzRlN6VvOveT4V7r8YaVyJuv/rvnruIuIJAxSmQsSBD/wzEzQmNLZW0P6EK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbs+E4Ul; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbs+E4Ul"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so2933404f8f.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562783; x=1776167583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smbingveUMNotlTjzCuhedEUp3beCH20gzZ9eDIceNQ=;
        b=hbs+E4Ulevh0Hz6wk86xhxmeci3E1mQCVn3ZYsjQlZLzlKA2tI07rR2iIYACrdXUcG
         /vE6A2t28v4jzxEcEW7yKK99qolQRmHxx3mp0yB4g4/rqFXO54MsoQa99lU9M/Er4cZR
         eRE4MiW4OeTNUHryWc1uJCssd8cvVi8OUL63c5/I2BYe7kTC7TOAVLhFKEhx5kWMV3A1
         da1THkQe0YpxCuPCV7XG6i6JixY2LgJ2f8F1feoKxmWWMUdgsQHcM8zwvD+vcvZ9cqfQ
         Q19mrMr+wUkGcxEGk2RXfBM7XTex0x5sB/Qft0NtDWXhlBDPvpc7cC8ggnzyYC/PYB6Q
         o+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562783; x=1776167583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smbingveUMNotlTjzCuhedEUp3beCH20gzZ9eDIceNQ=;
        b=kDRtqOTz2r7A0NYCbxA/UsQ88J8z7+x/sqPvjWZF2cv+CYxl3NvZFmgDwy+oNuOfff
         LpmnjuWeevvJ8Mr+LIcdVOYu2osqRWImXe9LFMVbbOwFydT8+xLoH/5Ho9aHAIBncsGY
         x1dp5qZFAO2iXKGoTzO0jxiJU037wGnWt74E6P/Wk2PF81Vm25EMcWx7Nqky7yL9iIxq
         M1W9FisDK/JXUWLtqR+/VLhADfPLF8t5UUaY57ssALlycW5Shky+gIahGRTT45g0eq3s
         nVCYCgzs8pMu2EwDPaDQ1rIP5ECENKlKVLY9XVvEe9ZRiIqm4VzG9ULp6gbz48YZd3Ze
         IH/A==
X-Gm-Message-State: AOJu0Yz/sqw2Ba94b7LQDCbDFdsw8IXTGsQbVDQ/76OjhJRwv2brGWEC
	4pmSdR2v+HSCPnj54yk2f4EZ5+GSOFbxXwLURtlV7ZgUI27xSj2EzVdh8EzCvQ==
X-Gm-Gg: AeBDiesglQ/d8PzvLclpOFxZxJ4JyPkokSHtIQ5WEA8wJ9xPVaFNJDALbWkqQN82Mqn
	XpplCn76v5igeUr/XHS8UUodRMI43GPCrhRLJfBx4AVfD9wYhv2ePFONy/GeGb7VawzFApcSFGF
	8Nk+stdf90Uk4SyV7ITtEHx0Il/sk0NNL/R/oIdn8d47Ej+RqgSlsfFXoC3nhO06k0pxm2qSv7r
	5MJQeH9FWEnh+SlTOv+4Uqcz7dO8X4tssKGN7f1OLWDaLy/2k8WbkGrQ4RISc5JV7NgsAnbHtii
	sAMtgVOivfoyXvv2MLmsH+wIdRvujgbNrsfli9GLnhTB/7eVaDhfFlfBnjmbnUkzLlqUY3zew+j
	Ix+Gc0eS1dryk17iPKbYOF5qHYlivvqsToX2DuJqCzt1z252sgkAy0FfpT9GvaWQIWyzccGMQCT
	Pkpk/+xokwOCv0Ocsvr7qlxs4CtHIMSwjlvjoNUJPDS2f3ZvwCKK26O5HpF4pQ9eCaY6mlq1JP1
	+kJn1NhDHUuNSeXTrv4N8IO5rhWC0dTTSfMATo=
X-Received: by 2002:a05:6000:40dd:b0:43d:a58:b080 with SMTP id ffacd0b85a97d-43d292f8e6amr25956985f8f.47.1775562783267;
        Tue, 07 Apr 2026 04:53:03 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:02 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 02/10] promisor-remote: pass config entry to all_fields_match() directly
Date: Tue,  7 Apr 2026 13:52:35 +0200
Message-ID: <20260407115243.358642-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `in_list == 0` path of all_fields_match() looks up the remote in
`config_info` by `advertised->name` repeatedly, even though every
caller in should_accept_remote() has already performed this
lookup and holds the result in `p`.

To avoid this useless work, let's replace the `int in_list`
parameter with a `struct promisor_info *config_entry` pointer:

 - When NULL (ACCEPT_ALL mode): scan the whole `config_info` list, as
   the old `in_list == 1` path did.

 - When non-NULL: match against that single config entry directly,
   avoiding the redundant string_list_lookup() call.

This removes the hidden dependency on `advertised->name` inside
all_fields_match(), which would be wrong if in the future
auto-configured remotes are implemented, as the local config name may
differ from the server's advertised name.

While at it, let's also add a comment before all_fields_match() and
match_field_against_config() to help understand how things work and
help avoid similar issues.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 7ce7d22f95..6c935f855a 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -575,6 +575,12 @@ enum accept_promisor {
 	ACCEPT_ALL
 };
 
+/*
+ * Check if a specific field and its advertised value match the local
+ * configuration of a given promisor remote.
+ *
+ * Returns 1 if they match, 0 otherwise.
+ */
 static int match_field_against_config(const char *field, const char *value,
 				      struct promisor_info *config_info)
 {
@@ -586,9 +592,18 @@ static int match_field_against_config(const char *field, const char *value,
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
@@ -597,7 +612,6 @@ static int all_fields_match(struct promisor_info *advertised,
 		int match = 0;
 		const char *field = item_checked->string;
 		const char *value = NULL;
-		struct string_list_item *item;
 
 		if (!strcasecmp(field, promisor_field_filter))
 			value = advertised->filter;
@@ -607,7 +621,11 @@ static int all_fields_match(struct promisor_info *advertised,
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
@@ -615,12 +633,6 @@ static int all_fields_match(struct promisor_info *advertised,
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
@@ -640,7 +652,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
-		return all_fields_match(advertised, config_info, 1);
+		return all_fields_match(advertised, config_info, NULL);
 
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
@@ -652,7 +664,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	p = item->util;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return all_fields_match(advertised, config_info, 0);
+		return all_fields_match(advertised, config_info, p);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -663,7 +675,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	}
 
 	if (!strcmp(p->url, remote_url))
-		return all_fields_match(advertised, config_info, 0);
+		return all_fields_match(advertised, config_info, p);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, p->url, remote_url);
-- 
2.54.0.rc0.114.g05d466edb8

