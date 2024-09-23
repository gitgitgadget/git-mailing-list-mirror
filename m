Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21E194A59
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093885; cv=none; b=NHeSXVtFhwam30t7WSDVsyyCEcuMB+tIlfmph9HTDXv4KSxiLj/HTt96R4GnbTgkmaYfGDLCzFlYvuu8ZZZCsPBVrmShhjvBkTqJuoYrfS4EjHyU4EQPhpnllTmbCvtO0MuYKByECoNxIzh7VtDpDUfAhdEtGx7TrFF4T/7c9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093885; c=relaxed/simple;
	bh=H2y9xCpm6kXs/DLU2SGSgBcwJRugzTOtV78BxJpbzoo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X8IrtX0PQhCkWjao+jrzNnunWZZt9mimNtQQ/0Y/dx5mjIPlzPPaYrj9GPTnBkqimeUZ36Kcb+srUIOMfuk/stmBwfUuYaB0hvPIp03pk9LTOh2GfhiNtMwwQTUCS3aJ9fWEcE7/OIeY1NLUsvkmPXlQaUReRq8/jjeax3w/nCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZCm3kQa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZCm3kQa"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c42384c517so5297085a12.3
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093882; x=1727698682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qn8nYbZ2QacqlbVhzGAFGu+rxPEefZzXGmMy+OvteQ=;
        b=lZCm3kQa+ttCs0KwbxnLDpkZkqp8yFaDHklEnvIcIwc3QzeRg3m22VWGHHi5hyN1xK
         wOz787nFjeC7ySg/JUBUP6mUW+YH2Yppxzbg0SSQt5BOHZQ+RN4wg4jowTqcTmpMZXSL
         2WMWje/RN5ZpNw7oXd3/jQg5fvrrt0BESidkUvh9suHSUgvV5XUPbViU9e80/hrSnDwh
         tLfMBvcoR8z0/TcH5GOzNOS7dq9jBX1+lm1c3i6yoYRNlqZrnOBXqFVNS6FPt5TuIspn
         YqWFlfszDZNUXQM9NfJ9bU66Ubfibe//Gnea92ITdb8H1QKDMBt29uO25nh8mSvgmfWL
         Cc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093882; x=1727698682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Qn8nYbZ2QacqlbVhzGAFGu+rxPEefZzXGmMy+OvteQ=;
        b=OwoWAW0+GOEtji4EJU3smVM9GKqVpGGw9hLEuk0NeBQkkNly7iT1l4SB01CNsxNX9d
         Sbg1PML6NvI84CUnZNRk09QPk35WBMvo4okFrqh2wZ8xYcx9qms/otX+iAqhAJVjtMxl
         JhkOHVMDd40IoBHQFaJ11cb1kWwakE3s9gQTAO4U2jP85N7zf1SlUg9xPsriQDB/AjaR
         +3Ajqc4lKKgp2zfz/QXrXDkHmMlRAZSzbnqUEUbfwq7NkInM17Suctur2qhI3Cwd92sU
         3wAK2iSsZBYyipcXcRdsaN4BqNSr9DQpdLThUiX5zukln/a2bsNXqk80wQBB5DUVC2Um
         4ahw==
X-Gm-Message-State: AOJu0YwuN9BL/oxJOzU8egiyDqySKxKz4kyRsZHmdJWybBP8hfJ1xPPG
	w3GW/8/OfOMEFaoqUSE3dRw+ZdAzdOJ6AcgZ5o+hpWiuGF3TXuFx/Klx9g==
X-Google-Smtp-Source: AGHT+IFaVgIdnxyN6tsGQCO5QrfxTdQQkQ3/deIgW4UfBDMlXQI7W+FeVpou1xbZIYR6kz9+Xh+iFw==
X-Received: by 2002:a05:6402:2695:b0:5c5:b9bb:c3d2 with SMTP id 4fb4d7f45d1cf-5c5b9bbc4c5mr5135102a12.26.1727093881792;
        Mon, 23 Sep 2024 05:18:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5312dsm10186865a12.23.2024.09.23.05.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:18:00 -0700 (PDT)
Message-Id: <c95ed5e0dd58f01db6a390b23c5dcbaaa7a4e43e.1727093878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
	<pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:17:54 +0000
Subject: [PATCH v2 1/5] transport: introduce parse_transport_option() method
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
index 7a67398124f..290a08f6ef2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -517,14 +517,7 @@ static int git_push_config(const char *k, const char *v,
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
index bab28965f96..c8947415eec 100644
--- a/transport.c
+++ b/transport.c
@@ -1091,6 +1091,18 @@ int is_transport_allowed(const char *type, int from_user)
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

