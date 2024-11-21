Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD61DC06D
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221848; cv=none; b=UkJ7nanQbGWb5SOnNr7ISQbxZdVzglRYrLUAZPeQwNT70otjZuy70er19s3i1Litc0Ea+Cuf/QwYCTpYoUPyz1/i2Y7h5HFAZwaXcZI2MP757xv0eh2sCBsJec/w1d6srWTq7oIywUsPcns60Fq7/oTT8jwAVOIwcB3CiY9C/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221848; c=relaxed/simple;
	bh=Nb9jLAdqJbo4TzBNL70GiKCWiYwQoCy3ipdVR/b3cPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZUabnXuDRZhNdTes7IL34txjhZus2V3qN5RbQ0gOFlUm4P6+7mnK8tVRioK8s/7P9Ci2jMaad2Zh1qBbrRZcv7A5uMw8Uwv7ytTwiAyYuSNgYhoUxTnpv0QrJEScWreN9VjZkVsrTObZm8MF+SaUge63wZeX6MDz00qzu9RjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqjPjyBC; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqjPjyBC"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-296994dd3bfso942659fac.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221845; x=1732826645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yIJxLwLqAjqYTr3aLhST3hNJTRZlCGGYbjlGW4a2eo=;
        b=LqjPjyBCQn0rLjMQFORNLSEtE0e/KOUFeY4WKpkO4uhp2e/LLY0Fr5Ci75VwOk3OFL
         tPkGxPKwGl882XFBVExYGEgxUmNOQo6CQtC5INiS6oG81na3UwHa7rnrkbXI3p7qVjtS
         WfJGauxHIHbQckEPwgE6oXSIeZ4ODYcZ+AFhbZpAmYKK90AJEsqmVH/czGOajXu5apuy
         wbOdxwL507SS6Dse+vhNH2THxhegQ4SDI4fkMzHfzq19f3RTGx/oXh+KP6B1KVgmxSah
         q45PIvkIWVxalYf0Qfljybn0D0bzwoc6/sfg50qjr+We70asOHFjatrDtAwp/g+4Ob72
         coQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221845; x=1732826645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yIJxLwLqAjqYTr3aLhST3hNJTRZlCGGYbjlGW4a2eo=;
        b=LmsN2GWHXStenkBd5Pb2t1t8wO215AIMhmNUfhTL8N/6f6UoY2jPpcWSWVQ5fWAmI5
         StUjLOvpl6pfzMqnC238EJgcVvImx+gljXsl1xTwvChSUUoLZ5bUF6O73JRRSgLY3vgE
         gOqOHvW0zTID+1E1wSMOS7nDUStN9YuC3rzPifqyWsUI4h6zkOcdiseLT01SOKR5oeWq
         Vwxs3PAmUDeAI3Ch5CXgYuBJtrXIhRs8TjXyAouz6lIpzT8naB+7eO0629SXErG3Xx86
         3Z2V+WfigbuwTZmSpv/B/bj5TTIU5U4tjibvs45uZbPFo2QJgl3cXiVJACCldhAGbVvy
         /SZQ==
X-Gm-Message-State: AOJu0YyUk1LkbWPBHkIzn0dNhlZk8Lr8Y8Dxx0DzvedNxAdH2BMooIXF
	zO0s3G+uf3pdoX+hCTsi3Iv/dT+OJc8cMsgUZlYRpI6D/rYjE59f8Q/NTA==
X-Gm-Gg: ASbGnct2w4CfOZGs9TMoBwdrgGEqpKmLNUBj4pduIGHA8wSxUI9PGVC+ulCNkOCV1jS
	76JM2Va9Otc3ZJWej3wysignNygf1rycpk++kCVK/JArkEMW03gthFxeKiKEt73TS9VlxYsQ6VH
	9YOfh3I6mwFzeeOFyRUdg+qg31e3VrcbEWu/+MNlb2QlTQBPnI/zdc/dc7MycFuw/Z1zhJVv3Cw
	zyXR93n8zSTjdJx6WSvkF2g3xK3jzpWdxzH90KlSKR8L4HleEioKA0ajw==
X-Google-Smtp-Source: AGHT+IF1B4kbocK6RBQxgTha7l/wA5TC13IbNE+qFoVSEwiQ44bszzXi4oNhHnRSVEdM2umYc5N5Uw==
X-Received: by 2002:a05:6870:ac99:b0:296:ff2c:7736 with SMTP id 586e51a60fabf-29720b8e654mr382211fac.10.1732221845099;
        Thu, 21 Nov 2024 12:44:05 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d669843sm126481fac.28.2024.11.21.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:44:04 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/5] bundle: support fsck message configuration
Date: Thu, 21 Nov 2024 14:41:16 -0600
Message-ID: <20241121204119.1440773-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121204119.1440773-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-index-pack(1) spawned during `unbundle()` can be optionally
configured with `--fsck-objects` to perform fsck checks on the bundle.
This does not propagate fsck message severity configuration though.

Extend `verify_bundle_opts` to store this information and update
`unbundle()` to configure the `--fsck-objects` option appropriately.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bundle.c | 3 ++-
 bundle.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index db17f50ee0..97b70e2e51 100644
--- a/bundle.c
+++ b/bundle.c
@@ -646,7 +646,8 @@ int unbundle(struct repository *r, struct bundle_header *header, int bundle_fd,
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
 	if (opts.flags & VERIFY_BUNDLE_FSCK)
-		strvec_push(&ip.args, "--fsck-objects");
+		strvec_pushf(&ip.args, "--fsck-objects%s",
+			     opts.fsck_msg_types ? opts.fsck_msg_types : "");
 
 	if (extra_index_pack_args)
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
diff --git a/bundle.h b/bundle.h
index bddf44c267..2a7b556f83 100644
--- a/bundle.h
+++ b/bundle.h
@@ -41,6 +41,7 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
 
 struct verify_bundle_opts {
 	enum verify_bundle_flags flags;
+	const char *fsck_msg_types;
 };
 
 /**
-- 
2.47.0

