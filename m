Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902E364E99
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849638; cv=none; b=dnjPKBa0pPnI9QsCAlvM9H8idh844LJCQd5HFwVIH9gXmqOSIm03GO39X173VpzigqYiIjLePh+Tk60VwjzKXeMUIWvo+LNrXMahWvGfG1h2ZR6/aWZkVKV6hGIi7EL8PfUnL0vMh9Ln3hvK0jmBa9wJkSkT+PhGn3HqqdiTwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849638; c=relaxed/simple;
	bh=EmrXNXPpxy4HjkxXR0j8PsbqnqTW8zGNI9Opie1IIKs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uOQqPGHuM1r6VzbPQ26n1eu8bz7J4haVcEZ5MDBJqMYpHAqVdj/W9aIhDN6jw8NEnJ5Wyv1P6dPfLAhlk8uLemIF2varpzI5QC0Nc7bl0eTAUiD9irf1TgY0s59gEKErE0m92zb68mrpmYGlythgkxOCLAsjYoFZePy+0VOmYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZKc45mO; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZKc45mO"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-797d509a2f5so43908487b3.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849636; x=1772454436; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLNqBA0KdcuUKiV4oYwuFwS2S6W9VHoIGCNWJBFwSMg=;
        b=dZKc45mOfbazdxCBkUW/2IqFmglpqs3c0Tyo1pWaaQ8o60mE68Gm6s8Bnf/hJkT3tS
         lKOmd3po9sLnpUvnR7wQWYTxZIXgjsxl5C5o9BeIwvoaf5TlSFVDWa5W1gbvphuFmg9W
         +bPZFwk5no6hSBZrC7nvLzQsfeedPDCzRhwqvfKOYaegKCATdBJKBCyQE1mwvPhU0XTP
         1SkTYsGMc9uEqFJaV6mgdNn712R7CGLOdCr+rB4QBA++crPq558rjCjRdp1W+aDmsl4/
         chF6NACA27OcHBqn2+XhEuSjGPCaP/Tf8lrJ4lIbImZAhpwOjMWa1GQoLYYziJ+kxv8Z
         G9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849636; x=1772454436;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KLNqBA0KdcuUKiV4oYwuFwS2S6W9VHoIGCNWJBFwSMg=;
        b=RwAZpeOeiqdL3n+lyY3jv4vRXRrVH6jAAaBdf7UeRSeerzwds32CIynm6TCkF5bRwk
         gKw3Nn6J+GgC5wpWLE+yY//WQLtNe4ON6Yp/dsFggTxLW4OZ4ZMjRuyyurbWg9rArwFn
         3tjqZiYACO+m1LFQ270C2s4Gioeb+7I4jUp2z1wgcRPhClK8sM292pTOLowv6G4o4RNV
         ieHEotkWKqACg/9wcGpcAYbsxiFEgvfqhqHKS5x7/WLqSLW7NWLEwVnp7sXRu1TOqqfG
         BD2TFBVyhigvHj69MZ3jUAHKK0y0OOtRuGP07MO3oIRbANIXjfLQlfadqucjFr3QxJm/
         1tnw==
X-Gm-Message-State: AOJu0Yx4ydWD2roE/t4nhWxJjCMVQ1bL4YHrrHwcw25fy0LNHf40M6it
	rWN3d5tUiaotWcgST4iTBKhmWNJ4JFX4aal4DkGj+I0iGuMi4TaoUNitfSkBPQ==
X-Gm-Gg: ATEYQzw8aNNVawaO+pyB8qyjdJb3qosZcvO8Sn6IhkSpghtnbRUyyk4vkNUigR7+13D
	vZ+SyDlivUCRomksVeJosZknK/mGoHqC1VZRpYKJDyuvcPb46pX5go1O8TVOMXvmxl/21o9KgeF
	DWzfhTynF03X5aTKalchlBr8cR++Z1+6kZirqd8W0pFD+W2aahnGoLwmLaWQh1WZs643Tied0Gw
	C2AHhakx21kSjvcq1xLNweFQPBO1Avo30B4uaJCE+/1cllOpJWnViP2NQdFdy8vyAzl9Cg7EdQ1
	R76asb9YyGdgat/WjsWelY2JNcFU7+fDN31pkuL8q5u/yvpfLqvo+52yzil+ehn7abVbYOHD6Z6
	gX59D5oYYbx98clwxxR/KFyoRGU9LJ5yMKrXcTrlDjTDI8s6Cq62hcs7BQAXWNQpgdwMMwp6vR5
	SAHOJf58yxMMh6qdvlffu2wh6gLg==
X-Received: by 2002:a05:690c:6e02:b0:796:1eee:b8f7 with SMTP id 00721157ae682-79829172a41mr77690167b3.58.1771849635750;
        Mon, 23 Feb 2026 04:27:15 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd81e22sm31264107b3.33.2026.02.23.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:15 -0800 (PST)
Message-Id: <3c32c037bc9651ca5492b2e1f9f6a30dc0d9c989.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:55 +0000
Subject: [PATCH v3 13/13] config: use an enum for type
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The --type=<X> option for 'git config' has previously been defined using
macros, but using a typed enum is better for tracking the possible
values.

Move the definition up to make sure it is defined before a macro uses
some of its terms.

Update the initializer for config_display_options to explicitly set
'type' to TYPE_NONE even though this is implied by a zero value.

This assists in knowing that the switch statement added in the previous
change has a complete set of cases for a properly-valued enum.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2e8bc6590c..7c4857be62 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -86,6 +86,17 @@ struct config_location_options {
 	.respect_includes_opt = -1, \
 }
 
+enum config_type {
+	TYPE_NONE = 0,
+	TYPE_BOOL,
+	TYPE_INT,
+	TYPE_BOOL_OR_INT,
+	TYPE_PATH,
+	TYPE_EXPIRY_DATE,
+	TYPE_COLOR,
+	TYPE_BOOL_OR_STR,
+};
+
 #define CONFIG_TYPE_OPTIONS(type) \
 	OPT_GROUP(N_("Type")), \
 	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type), \
@@ -111,7 +122,7 @@ struct config_display_options {
 	int show_origin;
 	int show_scope;
 	int show_keys;
-	int type;
+	enum config_type type;
 	char *default_value;
 	/* Populated via `display_options_init()`. */
 	int term;
@@ -122,17 +133,9 @@ struct config_display_options {
 	.term = '\n', \
 	.delim = '=', \
 	.key_delim = ' ', \
+	.type = TYPE_NONE, \
 }
 
-#define TYPE_NONE		0
-#define TYPE_BOOL		1
-#define TYPE_INT		2
-#define TYPE_BOOL_OR_INT	3
-#define TYPE_PATH		4
-#define TYPE_EXPIRY_DATE	5
-#define TYPE_COLOR		6
-#define TYPE_BOOL_OR_STR	7
-
 #define OPT_CALLBACK_VALUE(s, l, v, h, i) { \
 	.type = OPTION_CALLBACK, \
 	.short_name = (s), \
-- 
gitgitgadget
