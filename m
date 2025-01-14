Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B642A83
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820935; cv=none; b=Aa3cP/FdlTHyTGUDYRy/edVtKP+cp54KZyQYf3/hc8CyD0em2pc+FBEtfNlO7r/OIRLchrub7HQ3tYJXv9qX863MF+9GqaUJiK2lsV6GEC+712uXiJcLogExftU5DEzlU9TJi7908udtzi7lxB4i7wuZuhRYIKXMz9DdQOBWRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820935; c=relaxed/simple;
	bh=jrSA3HlbmH5BEYN9N1c5+RtLrVe5ydZhdTV3x90T1/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWLWXfEVAazXO4q2T8mevOa4ZlIynNytzlkj6yKqHX+B2PBSU0YuUbcavaON8aCCcaXdytOWADQinW1G6M8FF/J3LYg6yFDiYPVS1Y0UomPSjYJdq9BKsVXaixaMm9oVBV/kKAiZE9gEwTzl+DDZl4CF4rpXVo4D1UEwj21qUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENbMVpkP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENbMVpkP"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c8474d8f6so32383191cf.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820932; x=1737425732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0Apue2WtnALJeyxwq7+yCN6CrIFpP2E0UXVBjhqnaY=;
        b=ENbMVpkP33k3xzhOXsqnFhERbAR+GwQ7itMztyQqBEJFQkkSnn/OvlbRf7rO96xiap
         FUojg019llkz7U4W3EHkFXYOTbfA1OS/JCgVCNW4f2jlAO3l5YGPPaPsqkHYk1IitjPF
         w8jvQzD9r/I9n5tyGLcmwGc6PqJ9qDyciq84hAEwLzcthPF14i3wZX9Js01EXyYhcT6c
         KirA/red7Yeyfgpg4Tddd2V6hc0beWGWmNsp/z5AruNBWe24eosYjEdAPAsUHgusss6+
         Pm+VOUwRjUOQsg5N7S0YoSshGFKXDjfzav/Ivk49VQenI/7IosGtQaXlv/Ysm0Z3/zQn
         rj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820932; x=1737425732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0Apue2WtnALJeyxwq7+yCN6CrIFpP2E0UXVBjhqnaY=;
        b=vsegMEmcE8lPqDUW0noWcsP1j/JPjr+rYDokYO61pPXFEFER3FZwuL4VEd3QzLxJEm
         qgWPXjdmb8W7GLGxZ1eGvJtWUSrPWG5pE7Z/TsJs8RjwFpUaBk/wcL/P8tI0jd/20Ypl
         1qSg1cxwu0MV5yPdzy1UKLR0/QnnUOLbZ6K53MXN5xuF2KVMGPWJRCVBJg0OvuBx9ryi
         TXAJd4u0TkvopljCk4DU5+O0lWoPzI+uZ7sLwoEFl+gkWGrS97//c3WccZ20lRmGekZi
         dRezc5grHHpf1easLA4Iexc5nkKfzWRuR+s+tvgSNVSChFwNa8slxbnKQYF9hxHk1Hnr
         Pwbg==
X-Gm-Message-State: AOJu0YyJ6GuhK5jYrnSl/uqtU980s7ASpTAXJRuxbLCzE/h7JcRKj7Ue
	3d0W5YqjefkoqMlKiPrb6KlWMlEU+CHOZmbqrgREtSqmlyN3iYARbMCc2edgngc=
X-Gm-Gg: ASbGncsQDEHCcH/F7u2G/MEU/dcFFwYILveRrgVo+wCAyTV6SXhvjbURMJSgKA9fPLN
	YOUyLiuQplSZXODWhZ2oV5PKvMQvbY/ugy5XPUl57Lyz2tCc6/go/QI7G++gbxkrjJN5heoDN0B
	gfPgP3K91o84wT4U/OTeue50rcaNOssDn/+No4LBGJy8VlbE1GrEOmhIWZTQmM9ru9mCFE+sBb6
	BnHtSUqSV6CvozStAxgvAW/PcFrYKUVKTKhZ9wiEwyYk3l2Wq2TgQ6ZRGyhQ5jm2ZNVks7Hoe48
	k3EK/Ec=
X-Google-Smtp-Source: AGHT+IEVs1hJ1OfdwmR3wYS2+fcfIqV0lblQEVBtEqCeQUceuFLjh1YArrhecaXBp8NT1oNeqAAr9Q==
X-Received: by 2002:a05:622a:1194:b0:467:4bd4:866b with SMTP id d75a77b69052e-46c710e5840mr354567421cf.35.1736820932241;
        Mon, 13 Jan 2025 18:15:32 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8734072bsm47572221cf.33.2025.01.13.18.15.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:15:31 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v10 6/8] serve: advertise object-info feature
Date: Mon, 13 Jan 2025 21:14:58 -0500
Message-ID: <20250114021502.41499-7-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114021502.41499-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index c8694e3751..7a388d26d9 100644
--- a/serve.c
+++ b/serve.c
@@ -70,7 +70,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -78,6 +78,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.47.1

