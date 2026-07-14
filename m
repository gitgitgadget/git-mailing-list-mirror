Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B03C4B72
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029528; cv=none; b=jDZLBXDrMGXl37RFRuonYqmkXCGrqncrJqMQAXOrJrvbbVgIsaDI6Mzh5mTK6ORg8ft9wFTK/Odpj69GeO2l4uewlpQO7bTfv/3rgrfwvJEebsMu56Eu84XJ8HLuTYt0LC3gG5N4Mi6HuhX+0Ahwaz6zFXKA4D/5ggqPTFzDulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029528; c=relaxed/simple;
	bh=zIPQgXuM+kSMB+p/l8zBj3xeUQuJCD35A8pJAP0Lv1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odujFo2gZFLY+L3p5szlCT0CG5A6x3MQYYsQK7aIjt3j3OUHJHpxM9rSIFf/64LgIQ0SFjIrXa/tfO4/Vwt9tfTqYTZaVr7U5gfDxR+KcVykOWIOtE7rWJhDnPzWvtDIZResnXabugUepBJDLDlke/TrXDcsaJidf6BVH34oNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjdwY4IJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjdwY4IJ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so838158f8f.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029524; x=1784634324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7EGIlaMlC6bUm5CEAU3RPpqireG7fRDCnfzf9/p4On4=;
        b=jjdwY4IJGgXHtLUdzdm4H6szUl+/xvZsjoqna0iLfLcDIm8wfd8LT/h2mNMMwiryKS
         26hNGg9O0eMQFfItNklX2rw9W1jLcfMjPI3pRV9Iwuz0LKu/uRDN/fTC/88+5BaVldy0
         mZuew302usKkDKl2ed9ggWWz9g3zpRskhLeNj7kK2xPNxSnlPBDoWVdolgAbXEdAFwIj
         A6iaoU/NhnaJfMfObWkGFLdPNnehRaH3dHpawYGX9A93oM5E1dFGHKKkhb8JtF6l+zd6
         3OfpnfkES71pWT0hzn5Sgq7L5feeVvd/1X/jbYZFhrInF32LNPwtXGt8fJCmSs8GG1LJ
         sMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029524; x=1784634324;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EGIlaMlC6bUm5CEAU3RPpqireG7fRDCnfzf9/p4On4=;
        b=MtVqochtSFMkX7LmhTv5XOjR7QB50tFhOHWDJzCtNOkFxd3JT5B+dc3NFd5Q35cT4s
         fK9j7w2yKpKe0lQXkYSg0ksBaTIzB3wz9zscioe4LukeMi5LD91yPVPGWAoVp3AsuR1W
         /9D3aSbnO2v94wjPCXJqD86xbYGjeOgFYr5phqN3tNZ8NGt+6Z4A3wMQp8I7s2Yim8j/
         SOub8jGJ0c5y2kv8+X+4KaZChgnAydLaC4OD8oPTG16vGcf91y1hT6BW9KNb1aP4tn2k
         82tFKHCBBd+VV38oxynrgxyUSX1o7fQsJhOa52WbK82+tnlCoN/2eU8dPstogx/hFX1H
         2AwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4o2CDR8tolm6KX/W40WarwQGqIXlWV2ZlIOTBzA9T680SI0G2rL51+6zO+5AoPZLAocQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxc+J09a5EyOQrg+15siV5cnqCqPRcWiqPwQ+Ep89yTZUKr60e
	nWnGXPvjWkAqubTgGnVTc8PHDAoLGw/mLJC5F55qvuzwQ0IrZ/AeVU9K
X-Gm-Gg: AfdE7cnTtoks3OJsjEn85cKs1Db2oVeCSNWvBU4X2RMLjfGKp8mlthC/9WHZj5dQRR3
	jeQJwcH3LW04wTE5WHc8LwWE2y6Agvepnk17bUinphrEhQTOEl2UMaPaaNaZyT5aY1T/WziNPyq
	lks2ACTcMPEpq5E1eKzfIaufiKp7Zn97DvQ90ypcCV5UqJ6MfiV9h2DacVVSE+xoBSy91ntke2d
	N+7qRCFgPHfhxGSMv8q2kiOnVejKndxucZENKCIgdbxO9Rbf6fqIkt9Gc3XDvT3uZKuGs7AyvLC
	ykEY/tochoY8nUhCMb1ethnzfxMRTukoLSKOBHgUE8OF0t3k8z9/NyrhQtNdjPYBZD0S/j+fI/e
	RUHKLQQwlmkNzHod0eZvF0mh/6JfrfS8G5ORN7oh9SAlmgCLZoMdZ/HTtmXwRZmU+89pVe8N8Y9
	0yy4MQA3J0K59N1lxbC3lKrPpRZW7rJulYZxR9j3JO1xHSYuz4YHreqUhfa1HyJR9O/P7neAW89
	HMtuHLK1A4thvy1k2dJ7ZJ0slGsk1G+PipnLRiMFE3C0OI+Qyl/8aJmwp18uWWo48IQlOKKutxW
	HQqth6XLdM9totZssIFvqrpDkXYi+a/ZelhBsCUR22xpzTlRd7zwj9b3Ckr0lVM9rG8ThE3INQc
	bgUtT32uhFL3gg6LJLBxY
X-Received: by 2002:a05:600c:474f:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-493f87d8aafmr133368395e9.4.1784029524003;
        Tue, 14 Jul 2026 04:45:24 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:23 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v17 09/13] serve: advertise object-info feature
Date: Tue, 14 Jul 2026 13:45:05 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-9-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
