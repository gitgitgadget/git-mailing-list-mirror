Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9B415F30
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768018; cv=none; b=qd4us1vNOYzqVwHQoiF/+VnpV4dSzt9vQjKk+rwalQ2Nh6i0SLw1mBjcrvBA6ZjSfVWUKvPkIEaofAvLhIE3vaER5v16jeRT8oCFiIck3O0NrfG4Om+KTXNndowTaNUHSyDj+6Xt5Z7gerKRxzms3VCpZfKIw+jT2DJCRPtTOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768018; c=relaxed/simple;
	bh=IDC+CnSEWPGsqda6q4SEeBCHXxO/iE4qfGHq7MgrBrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXjycFHT3/oxEmb42QZYmnHdox1kRvrFdnUxd6rw4m3RkS6osEkCMDY7V42wqhklLynUPwabsApjyutlxRwmJpMB1bYPjZha4tqyhrAYcNeeNmBk1sh57F1U/8cX+E2IUATv3i6/g2E3jQWsm1NbBkrbTJvuh4Mxn+9yy53MvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLxIO15L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLxIO15L"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso24299645e9.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768015; x=1786372815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VIWvddlcxb1/wIHtEkely5k+lWRtaSt/6hfezCNZMP8=;
        b=gLxIO15LduoiF3+gvwi3A54CiOtv3cuKF37rGYYjkq7z7ih6uDvgAdtFNaefXNPl9/
         bey5baIE5VhQEpx+oCkh0I38w522wMWRoUu6WTtqyWYLNJOj19epFfyBqK0LnIsrInuC
         sM7CllgBjv5gXKwnZcMEC/QVVRHGTHMc5Jyjwknd6hL22fs3JGMQ53EEBnMJQMnUVN2n
         NyNO6DgTS8vdbC4tTtjsie2VUL+5olwJG+v2aSCcmDZLoGgJDhAPcgLCY7hgO2wrndhm
         xCNK2u88yjZPSpbd/a6SsTwfZxDhaS1JxMXe9JBL121bmQ5raHfckFLdWX6OSPo2w/ii
         oTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768015; x=1786372815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VIWvddlcxb1/wIHtEkely5k+lWRtaSt/6hfezCNZMP8=;
        b=nkk3EJD9RUnKpe4EbGTn+006qjAIZEoPF7oVPbUVX3P33fzpTo6tUxEo5lKKl9aqH7
         ZTwc4jXHxME4dY9to0WYd5fJANeIf77bGqrjs3EDPpu7ap+ETlJ0z85v+N7FjPkjffLN
         YDqU+nQVynmbBcDjTlFVfNFf+9os9t60naWFdWWttSqoae6ErmoVlcyBtU9N6iOKMVn3
         wiR+kGITWCGwgGW5a/gGT3B/gksPMehtlu4cmrIdAM33fg23ftvW5yCEpROgLciKZab6
         LAtiq5DPFX9CiKxxGHLlFenG/NI/eNVMQQfED0rmg6+u4cquUNJWdqqgVHZ6tF6G1chT
         klxg==
X-Gm-Message-State: AOJu0YyQ8kgxHkJOUTjJlSOK6WzzCRZyiJ0v7Puw9rUisoGRsFUqT/FM
	8gsloI4HQbaNi5ap7FUl/lUxhFS/59+agi7pS3jA+Fsyo5yAMonRfBew
X-Gm-Gg: AR+sD12OPDjMx7z3yTZalu7rQNrUG22V4whZkH04UnH2aWsqfip1uyQbO0VNQWF+QOa
	eadDuvYhPvV5B5+0X4wF5E8otIg1efwqmYIqS3Tly3x6p6QEW9BKq9T/8nZpp9lxJ6BMx+W7cHu
	wfgar+Atz0LH9kNqVVbder8hmX+R37+uK4SrqSzvJRaHVQhPVZlVwk7Fc9tFLxLyn+FKq3d9uXI
	jt6UqVHjgr4125HIY0r3CN9QysfeAiLAHuIvUSVqBaIp8X4KzLcT5TOfS2Pa2ope5uBjS6A7f0D
	p0ok1VPP6fM+++OaTBhj0mDCqMBB/R5gwO/hT+Mg13Ygj/CEn98DHA2/BRuQ4rh/kdK2fSrtTKR
	6bx1aEFPXH3RIwY6z7PeCcb/86CZKTj0WzjvnOCA5QvxD8dJ6d5fIG3ikYqaYkrHgverxX20BKo
	Xfqu6YFMRDrHbw6D9TVCEKXW2MVJciFXtBkIvxjmggb0tp9iu6M5R1DjTRVRixJd7fkxjy149oW
	QD9CHdzJX6Geaf4M2UkoelNhmmZsUMaBTzL5DUux2tpV8qP+wCArTKRRshcidR/VYZwEPeAtX45
	I5cWtJ9dr+qYwuowZME0X2j1Y6eIm6JKaFtchiFOyuBareHiMddq4hIAEbN4zOtss0n8Oxrcyni
	cBKQj6KlU90hP8qzH
X-Received: by 2002:a05:600c:8b14:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4980c66d8cemr250146685e9.4.1785768014936;
        Mon, 03 Aug 2026 07:40:14 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:14 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 03 Aug 2026 16:39:33 +0200
Subject: [PATCH GSoC v3 6/8] fetch-object-info: parse type from server
 response
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-objecttype-support-v3-6-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server can handle type requests but does not advertise the
capability yet. Prepare the client to know how to parse the server
response once the server advertises the capability.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c  |  5 +++++
 fetch-object-info.c | 24 +++++++++++++++++++++++-
 fetch-object-info.h |  2 ++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index c2b88c47f3..7a3ae11a70 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -854,6 +854,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	string_list_append(&data->remote_allowed_atoms, "objectname");
 	if (results.sizes)
 		string_list_append(&data->remote_allowed_atoms, "objectsize");
+	if (results.types)
+		string_list_append(&data->remote_allowed_atoms, "objecttype");
 
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < results.nr; i++) {
@@ -872,6 +874,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		if (results.sizes)
 			data->size = results.sizes[i];
 
+		if (results.types)
+			data->type = results.types[i];
+
 		opt->batch_mode = BATCH_MODE_INFO;
 		data->is_remote = 1;
 		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
diff --git a/fetch-object-info.c b/fetch-object-info.c
index ed02c42f6b..2a67a669f6 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object.h"
 #include "pkt-line.h"
 #include "connect.h"
 #include "oid-array.h"
@@ -62,6 +63,7 @@ int fetch_object_info(const enum protocol_version version,
 	unsigned ask_size = 0;
 	unsigned ask_type = 0;
 	int size_index = -1;
+	int type_index = -1;
 	size_t wanted;
 	size_t i;
 
@@ -110,8 +112,15 @@ int fetch_object_info(const enum protocol_version version,
 				die(_("object-info: duplicate 'size' attribute"));
 			size_index = (int)i;
 			CALLOC_ARRAY(results->sizes, results->nr);
+		} else if (!strcmp(reader->line, "type")) {
+			if (!ask_type)
+				die(_("object-info: unrequested 'type' attribute"));
+			if (results->types)
+				die(_("object-info: duplicate 'type' attribute"));
+			type_index = (int)i;
+			CALLOC_ARRAY(results->types, results->nr);
 		} else {
-			BUG("only size is supported");
+			BUG("unexpected object-info option: %s", reader->line);
 		}
 	}
 
@@ -157,6 +166,18 @@ int fetch_object_info(const enum protocol_version version,
 			    object_info_values.items[0].string,
 			    object_info_values.items[size_index + 1].string);
 
+		if (results->types) {
+			const char *type_str =
+				object_info_values.items[type_index + 1].string;
+			int type = type_from_string_gently(type_str, -1, 1);
+
+			if (type < 0)
+				die(_("object-info: object %s has invalid type '%s'"),
+				    object_info_values.items[0].string, type_str);
+
+			results->types[i] = type;
+		}
+
 		string_list_clear(&object_info_values, 0);
 	}
 
@@ -172,6 +193,7 @@ int fetch_object_info(const enum protocol_version version,
 void free_fetch_object_info_results(struct fetch_object_info_results *results)
 {
 	free(results->sizes);
+	free(results->types);
 	free(results->unrecognized);
 	memset(results, 0, sizeof(*results));
 }
diff --git a/fetch-object-info.h b/fetch-object-info.h
index c472c14d7e..310325cd98 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -1,11 +1,13 @@
 #ifndef FETCH_OBJECT_INFO_H
 #define FETCH_OBJECT_INFO_H
 
+#include "object.h"
 #include "pkt-line.h"
 #include "protocol.h"
 
 struct fetch_object_info_results {
 	size_t *sizes;
+	enum object_type *types;
 	uint8_t *unrecognized;
 	size_t nr;
 	unsigned wants_size:1;

-- 
2.54.0

