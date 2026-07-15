Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA32931C2
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109161; cv=none; b=t/M6lNpdzIDC+QfyBXOSbJ/rGAPNW69UGr66nnzdqdYfnH3QMbb6K7EPMWevah+Uqt1rLaH4epky7VRylbtrtoc9e/qOBs4YNKfp9LBGh6uUX8MyUStGp+zV7lvkO5sBJtso5suqe2EhQB3HXcyXLPEswGdbohtbLQkrfCVca6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109161; c=relaxed/simple;
	bh=zIPQgXuM+kSMB+p/l8zBj3xeUQuJCD35A8pJAP0Lv1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwYhgM6i3qSSpmWivVOjwa1MAA2c6ak5TFHzxO+Gmojo1ztG9CivWtIHrZCB68I5BX2J9mhSoXPOqoGUnd9P+9+IGWMbGDTdi6OJcIBHJxRgkK+DksiyoGByREOJI5TgYM09duqpfLM+/yXQkl/nWPLEa2kcArNkknhXhIyvguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbT/GFrK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbT/GFrK"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1198710f8f.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109158; x=1784713958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7EGIlaMlC6bUm5CEAU3RPpqireG7fRDCnfzf9/p4On4=;
        b=hbT/GFrK6jwhVRy7V6ga8Qn3DgMrmzdt4/sv1+xN+NViNWUefc9q9Qzv+uLnBmzcm0
         6/CHsLhVhGaTDTRsGZpv8DUvCQ/CUUzpcB/6MBLtuVmH1K2OS8BIy6R1kqjAaG6LyOZs
         FSkuSIc9Kli2iIF4ZtyWvu9av7BrhSq7fN0++Lr6papb8Ja00Z8FdPSQ8DJSXA927gFk
         oeL3jXdzacc9GG/l8MEn83Kub4HNbsBERy7XdxJJalNvRhUrOnuRj7F9pBP4Nw8AWb97
         cfy+LWBhJu1a7jDuFd0fA0Ylcwa9JFv+qygMvLbio5KgD7kyQQw7cGG9VskLgHiP4HH0
         AxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109158; x=1784713958;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EGIlaMlC6bUm5CEAU3RPpqireG7fRDCnfzf9/p4On4=;
        b=Upx1MmVm+0kt9KyZHWDOZWv8KAqU+dKZEMcU5vGA4E/3gdj5G8Gze2TYv9cx5x5r6z
         qvWjLqnE78Xn4nn1YlLcCkgJBhgmF9eh0UXjpYUaQsVeLDmDlHu+tt9quD72BIYQJdDc
         JL+Ph6B/lmMgzFtUyESbjbdTLthCkDSqXkuLyWuyQh08tfRhi5QhUFtdqgoOiRy7jfVz
         vVTu5jQ6XSlzkOwjnKC2fYKBKD/dDquoFS0HoDECipUzlX4ItaZkTi1g+5ZNHknVCO+5
         2xicj+qTsj94uzHN/fmdxwi1gVzyr9AM/cOwKtoM/E5aE9RMIngjPOj6d+Xc+Lxa7flh
         Zd8A==
X-Gm-Message-State: AOJu0YxFesjVGD07pKxR3z3h31IhzsU3nJJu7wNuPUuHUXBlcH2Yrt26
	40nuNuXyOYhXzGrlDr2bSI4DErNRKSEmzTe5VrILTTB+Evn/SBtPMro868/3eAzD
X-Gm-Gg: AfdE7ck7H94lvBQBCrRnCnjJJ8P3u1R4HfxthD/3wJx0kQmV7bjDyTMqcn6LQCtgMGm
	jo5weStl8Z7nlCsCvWSstzqW5V9dSvfQEAzcIrlM+jwuDK1vYwuuvY6U2MLe3DzqHN7/5BKBuXF
	gfOqukTECep2GvUg94y9Qn0qQvoooNwk79EYFoMPvnBxVwhtRUzEmKiuVoeaAJF/wk6AHjmb3cm
	jujK2hlqcynHI+VM3aw59PGuOh8AT1cY8OWiIcb2M+VU+2DG9Zrj/1v3qPeOm/rIiH7vdyzTQEO
	itiN39sxW1e/4YG7/ojOHgGQJW+jJqELsNO2wk88KkRZInHkOGEmqb+P3sFbMxP29d2bg9ShlIc
	QKACb+5lslfJhvCPFSpEZmR3YdqmhjhK8ozrUdmuRW8FnVXkL2Zjsg/xSzVHZu3m1lIdFLGI2F0
	vPaq8pddTEUT95fa7YQJgRJk0q5qY3un/zE0/Jn7GVS1PQoUUsS5/n0FDQ7jgXDhsTqVyLFlpQv
	jAoQG1z3e21O8dOwtGOlq8ADn0bSjMLhG8oHiNiY2LepSDyi6BUSU2KAEliqP3vm1ZdM4DDQClp
	oO1EUBR01Og0vCoXbQHn+xThNFWE3XCEhuwxQq1pChL7bbAmANQ9aLkMcG3Su1sz0UfqsWpa1zw
	NW9T6NZ09Lw==
X-Received: by 2002:a05:6000:615:b0:47f:28e2:d4c4 with SMTP id ffacd0b85a97d-47f2dc8d7b5mr18747442f8f.2.1784109158074;
        Wed, 15 Jul 2026 02:52:38 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:37 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v18 09/13] serve: advertise object-info feature
Date: Wed, 15 Jul 2026 11:52:17 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-9-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This allows a client
to decide whether to query the server for object-info or fetch as a
fallback.

While at it, update the object-info section in 'gitprotocol-v2.adoc':
- Require full obj-oid explicitly.
- Fix parentheses.
- Define obj-size explicitly.
- Make obj-size optional in obj-info and document the behavior
  for unrecognized object IDs.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/gitprotocol-v2.adoc | 11 ++++++++---
 serve.c                           |  5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 2beb70595f..d3530c52ea 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -568,21 +568,26 @@ An `object-info` request takes the following arguments:
 
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
-	information for.
+	information for. They must be full object IDs.
 
 The response of `object-info` is a list of the requested object ids
 and associated requested information, each separated by a single space.
 
 	output = info flush-pkt
 
-	info = PKT-LINE(attrs) LF)
+	info = PKT-LINE(attrs LF)
 		*PKT-LINE(obj-info LF)
 
 	attrs = attr | attrs SP attrs
 
+	obj-size = 1*DIGIT
+
 	attr = "size"
 
-	obj-info = obj-id SP obj-size
+	obj-info = obj-id SP [obj-size]
+
+	If the server does not recognize the object id, the response will be
+	`obj-id SP` regardless of the number of attributes requested.
 
 bundle-uri
 ~~~~~~~~~~
diff --git a/serve.c b/serve.c
index 49a6e39b1d..2b07d922b3 100644
--- a/serve.c
+++ b/serve.c
@@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	/* Currently only size is supported */
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 

-- 
2.54.0
