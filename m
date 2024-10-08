Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC193BBDE
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358706; cv=none; b=RnOcX1Wo8GPT/qRuwDIMnfQy2Vdbt264kE1LShzkpD7J2ZX71WotL2VajEw3vxplyMI8nV/r0LAbJRFHXGrFUqYU1B/eoYm1au4pvF42R+K3pIycwnVoE/SEs/nZmhUFR0pslkBZe6c5yP0Ihft/8J484dyV/tqr0iGDogzWj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358706; c=relaxed/simple;
	bh=/jvQD2FNHc+92kqEH6/bXe4BXMA8iDnvSDBxStXvHXw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pRXRNw1FcwDB9CzdLoE68TiQbNGNnUd02/AoaCnrO8U7/OTPOojYHvjJg+UP6QiykAnqo9HyWAWSbmcdeHJuCqJTdT+SO4nVp+Bv6sJNnLPS/BtSXo4GTitYw9VlPfAxKb8mc3MMDPTWm71mG1TZzAgzwXvRHIus+9BvHImmmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O64Xkk4S; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O64Xkk4S"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53997328633so6558902e87.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 20:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358702; x=1728963502; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsI6+m0lUHKGW2MyCFhSAENQsiTQQegTweIYYmCavzI=;
        b=O64Xkk4StsCOnnDFY3kKggaweGOZD8ONU7OVRgvMKbEmN8198Iy5akjZzzo6VlDkT4
         sS0DUFS3LeStWtSykJjFrq7/d7JJLylxCPCk6Hnl2KFg51EDRgIF2jMw6Vlo/SoZ0d0R
         SSRGqy5pEXU2nY9f2FYNY/5h6pm5Y2phrx0gJ2XYy7UaU3WPV+yMK9YKT6dxpuXFSWwO
         Ycc3gjoD146eKEUG06d4uuMeziJ3g8f5BT6OTgcvs9zo039g8VA0sH002J8qKNzgUYfc
         yFu67E6A7MJ2acrw8ySkuOhod6HnKcdR79zqpz8wox7h5aZ8kZjS0X6V7Qo1ucPi2B3k
         zpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358702; x=1728963502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsI6+m0lUHKGW2MyCFhSAENQsiTQQegTweIYYmCavzI=;
        b=f9AYbCRryL86rLpT3M1fNP1kk89k+BY/IzpviPyTHhrk29plzOa/OCbGZnn2RPT/0F
         WTs9hxkYCWBIzYJma/COYvSbR5MqynAWHd7k2TYGe73KraN1KhlOmwGIkDu+7mxvxog9
         X4IXWrzzuWrOdky0O8NmHR5y8T32Ey9gI/DwvHsr4fLs7uiumLCIcdvJgtbfC0ft5mxY
         DcSkRGkTOWeRjRdzV+ZZhhltwyE1LpEmrjGQ3B18A4U7sDPTACQkLssy1ZnczftLxm6Y
         wWdL8rB9+xYtr0ankqxcHFKIZLU8w6rSZ1I2u20kPGp6lZvsyVQ3SeMs9dD6ibjAn6mv
         +S6w==
X-Gm-Message-State: AOJu0Yya/KC5nkqeBQuM0iEPY44Nkhy9LsjxPgw7sOTfjO7NllPu/EZo
	oBRC2O2qt36c9UNKAqUPN/KDYoqOvY2T2K86U2t5ZNb6IITSbeaUXBgaqw==
X-Google-Smtp-Source: AGHT+IHZYnDzKU1iHEHqphL7xI0rzZxuP7CPo7St7tU0ICVA58DZ/BoX9H6Mr/t2DhnJmL/zMf8MPQ==
X-Received: by 2002:a05:6512:3192:b0:533:483f:9562 with SMTP id 2adb3069b0e04-539ab9cf3c3mr8685637e87.42.1728358702007;
        Mon, 07 Oct 2024 20:38:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9953f118d8sm216327766b.81.2024.10.07.20.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:38:21 -0700 (PDT)
Message-Id: <b44face42e16f2044b36ed4ff64316a23c0caba8.1728358699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
	<pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 03:38:15 +0000
Subject: [PATCH v3 1/5] transport: introduce parse_transport_option() method
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
    Patrick Steinhardt <ps@pks.im>,
    Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Add the `parse_transport_option()` method to parse the `push.pushOption`
configuration. This method will also be used in the next commit to
handle the new `remote.<name>.serverOption` configuration for setting
server options in Git protocol v2.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 builtin/push.c |  9 +--------
 transport.c    | 12 ++++++++++++
 transport.h    |  4 ++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e6f48969b81..e0ff60d48e5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -519,14 +519,7 @@ static int git_push_config(const char *k, const char *v,
 			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
 		recurse_submodules = val;
 	} else if (!strcmp(k, "push.pushoption")) {
-		if (!v)
-			return config_error_nonbool(k);
-		else
-			if (!*v)
-				string_list_clear(&push_options_config, 0);
-			else
-				string_list_append(&push_options_config, v);
-		return 0;
+		return parse_transport_option(k, v, &push_options_config);
 	} else if (!strcmp(k, "color.push")) {
 		push_use_color = git_config_colorbool(k, v);
 		return 0;
diff --git a/transport.c b/transport.c
index 3c4714581f5..4d9e605b273 100644
--- a/transport.c
+++ b/transport.c
@@ -1099,6 +1099,18 @@ int is_transport_allowed(const char *type, int from_user)
 	BUG("invalid protocol_allow_config type");
 }
 
+int parse_transport_option(const char *var, const char *value,
+			   struct string_list *transport_options)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (!*value)
+		string_list_clear(transport_options, 0);
+	else
+		string_list_append(transport_options, value);
+	return 0;
+}
+
 void transport_check_allowed(const char *type)
 {
 	if (!is_transport_allowed(type, -1))
diff --git a/transport.h b/transport.h
index 6393cd9823c..44100fa9b7f 100644
--- a/transport.h
+++ b/transport.h
@@ -342,4 +342,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 /* common method used by transport-helper.c and send-pack.c */
 void reject_atomic_push(struct ref *refs, int mirror_mode);
 
+/* common method to parse push-option or server-option from config */
+int parse_transport_option(const char *var, const char *value,
+			   struct string_list *transport_options);
+
 #endif
-- 
gitgitgadget

