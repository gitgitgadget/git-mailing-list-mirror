Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4653716C
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842947; cv=none; b=XV3xGXivFr7npcHaQXnsB+l515CBEeEDkTyhlRGyeepyiHCBY3F2C9G9K1jwMGS+D+r8096zgoLR+MSiPaVEL6QMZdVJ1Nu3HOD+jv26WyFnP3pTIkxrxtTjibOIxtALeHeGMCozV7PucF2iAV1WbAZh6SwgWlB+ZTkbwXF1Pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842947; c=relaxed/simple;
	bh=KB7hJ7veuo+sIVGtCOFeU07Ih6ir3co//yLmTrnLgHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNu8hxOSK7cSW2CxrrQPwddBTuPlMqWkLtpgnq/lMBSQ/MLszVrRPA6hpEYAXn3vQNlNxbtlh+qEsI0vlHVdWXKV2nWZZSHfU5GmLaiikAr9SEG2cvkALbjjpGZBm65Pj1mTy1dmsDLdv5aYv891iXk15T/fVwEaLZ2XzXS+JdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXkX3lts; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXkX3lts"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bda6c92ce7so1425491b6e.2
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 05:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705842944; x=1706447744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9FMJy0BfYncbOyA8v2BwB5v3NRrdoNxTP85p4a7NtI=;
        b=OXkX3ltshFJJtFmo1JN2qDMarxYeLrhoL0vKqG9KepxkfCjrL4ofOdYOm7Ck7vzU+s
         YEYSYuSN8ERFPJxuUoiPx7fBWsbmgjXpRCLaxsfJTWydHfC6yhGteh0W8ks+XSxA7WIh
         qKNc8shnG8D/z843n9JiXO5dVKuC2jdhRmkRm8SkSAPAk8kpeIl9O7i77N7+lDD0r7IB
         tqK4AkNMimDfNXEkATD9pnxnnCPJEOdCRomEV3d7N9EqX+A+k/g3w+lz7irdnJNOcbf3
         RqV/CHj9eNmAy/MzLByn+v7PIIx3Glgem3h9hBYDpZmWRcOjCRlPEhT+In0PUiVizxNI
         MRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705842944; x=1706447744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9FMJy0BfYncbOyA8v2BwB5v3NRrdoNxTP85p4a7NtI=;
        b=DL9ZXAr6lVcTuEXRVbMjIDOZmeWtJJHd5j+YVpYlX3HXt8ndIgcMAsfzWLSIl3aehU
         JuapngSvWgogirXWt5qGJnpYc0M290Wm4/sRTdGmvNtnMZbLxJiQaTcEfeQ4twzCd/pO
         AOqi05LfiCXW6kQdjV2y0D2tf1d82hD6xuzDEqaVOTr1za0SmDnxUovyYThwcOOUEGk3
         34DS5r3KlB/2a2fadZmieGccN6/KWCyLXJi0zm0nfLSs5W6d7vNeWhaDCZOquprkpgBy
         FurgW1zPsS0vH554carKbgN9RLZdfGb/Dedh1aONchaV7nhlvLYSieWBwM/vpRQggC+h
         wtvg==
X-Gm-Message-State: AOJu0YwXrm5bQKhT0gCZXfuZ9z8dJzBO8c6c61gSGn9pihGy/kurwV/k
	sj8GdV5SlKVLlKLdkYLM3oD24ltsoJhsfBUSAEidXQfjYRyP10jr12HjT6Er
X-Google-Smtp-Source: AGHT+IET1nq4lsy3EKPZw9tmn0gRopCTHAxqaWqtF+auVeoWI+B+gCyG/p/zVXfbhPK02KLoLXWjmA==
X-Received: by 2002:a05:6358:3a14:b0:176:411b:888b with SMTP id g20-20020a0563583a1400b00176411b888bmr1934956rwe.17.1705842944234;
        Sun, 21 Jan 2024 05:15:44 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm6619005pgc.29.2024.01.21.05.15.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 05:15:43 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 2/6] remote-curl: supports git-upload-archive service
Date: Sun, 21 Jan 2024 21:15:34 +0800
Message-Id: <b63b014a22a69ffdd680543ecb4c49ac2c83bb4c.1705841443.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new service (git-upload-archive) support in remote-curl, so we can
support remote archive over HTTP/HTTPS protocols. Differences between
git-upload-archive and other services:

 1. The git-archive program does not expect to see protocol version and
    capabilities when connecting to remote-helper, so do not send them
    in remote-curl for the git-upload-archive service.

 2. We need to detect protocol version by calling discover_refs().
    Fallback to use the git-upload-pack service (which, like
    git-upload-archive, is a read-only operation) to discover protocol
    version.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 remote-curl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca5..ce6cb8ac05 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1447,8 +1447,14 @@ static int stateless_connect(const char *service_name)
 	 * establish a stateless connection, otherwise we need to tell the
 	 * client to fallback to using other transport helper functions to
 	 * complete their request.
+	 *
+	 * The "git-upload-archive" service is a read-only operation. Fallback
+	 * to use "git-upload-pack" service to discover protocol version.
 	 */
-	discover = discover_refs(service_name, 0);
+	if (!strcmp(service_name, "git-upload-archive"))
+		discover = discover_refs("git-upload-pack", 0);
+	else
+		discover = discover_refs(service_name, 0);
 	if (discover->version != protocol_v2) {
 		printf("fallback\n");
 		fflush(stdout);
@@ -1486,9 +1492,11 @@ static int stateless_connect(const char *service_name)
 
 	/*
 	 * Dump the capability listing that we got from the server earlier
-	 * during the info/refs request.
+	 * during the info/refs request. This does not work with the
+	 * "git-upload-archive" service.
 	 */
-	write_or_die(rpc.in, discover->buf, discover->len);
+	if (strcmp(service_name, "git-upload-archive"))
+		write_or_die(rpc.in, discover->buf, discover->len);
 
 	/* Until we see EOF keep sending POSTs */
 	while (1) {
-- 
2.43.0

