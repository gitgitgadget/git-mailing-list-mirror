Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9C19E96D
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279244; cv=none; b=nlfAD+JPeNJEkCyOUl8JG87OH3dnBrj64APkw9LIiiq/UbUPSZyyGpAlS6aIq1m4m9YQa9JJKb8r1ORg5DEcARnqabK+iLSofQgACzygaF/TNMNT9yN3iLEYeSugUp1wPvlZetQTIScWYtJ6BDPEDvw7burmai1y2+VeCaO0fcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279244; c=relaxed/simple;
	bh=76CTRHW3yrCPcQfTjCPYgJTJB5e4/SE5bA70CePsH1c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GpB1WxE9FXThZ94nxYcTQXCkAMCn3AjCe4LY/8QPriGLxvOw7cpAXjsey5Hx9quAFVbCpG0pSrRbofqYoYAV0vnXjF8C1ep+z8Lq+sO6buk9tTiSeM7LnvJlQlqHTd+T2xG0bf4cFDZdkrnNtvUgGEDKmvXi4savqQhhvWWjPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS+rMvzX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS+rMvzX"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f025b94e07so40665951fa.0
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279240; x=1725884040; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee84Hm+i1/ZKmyHXKoghm6PciQLcMAPYvUvjWCynom8=;
        b=TS+rMvzXPIyGqm0LMxIrlhhAE5fq77X5RPAA4Tzq/KRcGwGS82EvaNNHSY+8dF1wJm
         sEYrjvyULZNW6coG6+T1dsUcHzk4u6bhaELxvgrKRIRaCcc46dsBAM3wqlZ9Kk2e3wQk
         tboAH0c4kEEZEWmWjhoaFmwJviWaMqAQv5my2XC8CeHwRekMq4ga8RZ50Z2s29RQ3U8m
         2lXKjvFCQYZUJL0exPzZZCKmt3OyWqYVDcA0Z0S4aO01BNgIlG4HZ4kH7qtGeUbGnk+j
         tkPgJobPtll5mm9Hv053jYeP5Pxh0X7H7Gndhn9gaL0b0pUqqwB7zphZ/gKdPJs6FUlo
         EGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279240; x=1725884040;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ee84Hm+i1/ZKmyHXKoghm6PciQLcMAPYvUvjWCynom8=;
        b=L+mSQM5TtXFHE/QbHsVCcAfp/qV2bkxzYTr3lKvNKac/oHC5xXZVwxtEXPxLkxVUJv
         Yw8ur5batmAvrq/7ykS+mxqQs5iXPiDTJNXSmwrMF8s9lf8/No2F6QfCg0kOZtYGalT9
         W4l+qAdvIkRpZ0kWUnS/UuxYisfu1vSVT9Vvo9ai3jtUK4AV9pvhTf2f5kUu3Z0PXG6L
         JcH2BToM+4pDke4PD+DvJgLDh+Iql9Mg+2F4AT75EgTmoJGOxrhKjtW0mCr/n7U0KMkI
         96nK7HBqgnlOT5Y2cYAHk/6h2sipj4fc/w9Zqdy24mJApJ4UYK7tyx8tutgm529E7R0e
         UtvQ==
X-Gm-Message-State: AOJu0Yy246fPoqbUqV83Wm3r7/UATcfyWXFyCIYLnayzmPZkCgcjbamD
	mfur5NJRZmoou/iiZSSVx0DJd5aClskHUn8dztA6WYB53SBtPjjWIMBQYQ==
X-Google-Smtp-Source: AGHT+IFFEYfZuFac73khxQKoQ59P88EnL6KdCR5vJ6HBHdO1DazDcjwb9iF/FhsyU24PD29Fe/oItA==
X-Received: by 2002:a2e:a587:0:b0:2f5:11f6:66c6 with SMTP id 38308e7fff4ca-2f6103a535bmr112268401fa.13.1725279238725;
        Mon, 02 Sep 2024 05:13:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c2507955casm2176864a12.57.2024.09.02.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:13:58 -0700 (PDT)
Message-Id: <5c8f3c166a59c9d1e6dfa3116a5403ac752efdba.1725279236.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Sep 2024 12:13:53 +0000
Subject: [PATCH 1/4] transport: add parse_transport_option() method
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
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Introduce the `parse_transport_option()` method used to parse
`push.pushOption` configuration values. This method will be further
utilized in subsequent commits to parse a newly added
`fetch.serverOption` configuration for fetches, which aligns with the
design pattern of `push.pushOption`.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 builtin/push.c | 6 +-----
 transport.c    | 8 ++++++++
 transport.h    | 3 +++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7a67398124f..63d19acfb27 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -519,11 +519,7 @@ static int git_push_config(const char *k, const char *v,
 	} else if (!strcmp(k, "push.pushoption")) {
 		if (!v)
 			return config_error_nonbool(k);
-		else
-			if (!*v)
-				string_list_clear(&push_options_config, 0);
-			else
-				string_list_append(&push_options_config, v);
+		parse_transport_option(v, &push_options_config);
 		return 0;
 	} else if (!strcmp(k, "color.push")) {
 		push_use_color = git_config_colorbool(k, v);
diff --git a/transport.c b/transport.c
index bab28965f96..ca6cd5b3436 100644
--- a/transport.c
+++ b/transport.c
@@ -1091,6 +1091,14 @@ int is_transport_allowed(const char *type, int from_user)
 	BUG("invalid protocol_allow_config type");
 }
 
+void parse_transport_option(const char *option, struct string_list *transport_options)
+{
+	if (!*option)
+		string_list_clear(transport_options, 0);
+	else
+		string_list_append(transport_options, option);
+}
+
 void transport_check_allowed(const char *type)
 {
 	if (!is_transport_allowed(type, -1))
diff --git a/transport.h b/transport.h
index 6393cd9823c..1b8735e2ca4 100644
--- a/transport.h
+++ b/transport.h
@@ -342,4 +342,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 /* common method used by transport-helper.c and send-pack.c */
 void reject_atomic_push(struct ref *refs, int mirror_mode);
 
+/* common method to parse push-option for pushes or server-option for fetches */
+void parse_transport_option(const char *option, struct string_list *transport_options);
+
 #endif
-- 
gitgitgadget

