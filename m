Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD271B48
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286384; cv=none; b=cuZ3TTAYJhd3mcmyo5ELiB8mpRcHqXGbu8vtOhrRjo9U2blRLKKvuLXGlEhkefNxz5MqulxdFwX0+uPlcVEJCSxfH50blmsfjdgEF9qsiRotPxDZBc96MRk7geQLtYfx4lizfglPJ/zekblupUlAP2kGLiJQnfpuTVC1Wy4nGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286384; c=relaxed/simple;
	bh=Hhr7H8Bd48wQ6dQCXW4zPuaI3vLBzF52Nu9/OLVRej4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1yXhTjLjkn8ajiP1m2TLOse5201drm2G87rwF+TP+gqoZZrAgxAcJFOvZuzzfaGzJmyKoTh2Xcx91PvgEt/cfVf7CJ7Y5DucHXAfwCafPcttSldoK8SHH9p/YalM/PLa5B74rxej4L9z4ZSUkbXgm+4f8sJbNNLfKZ2oatIQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfC1mMWJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfC1mMWJ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so498253866b.2
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286381; x=1708891181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaU3EAwEomF6Aj6BbZNDZDsZcoaXMFfYG6mbHdqh29M=;
        b=UfC1mMWJ5EVhm/+JfD+Fha5cWOhjLuchhfVbgzIb42U2CioJ+xXVVWPJptxRXmFiZo
         d3+J/HCtV6fEz9nEJatv9jWLT07Fp4M/2fnO5O4WBbzXQZEvmyHEYh5YLZv+iB0uH3BE
         LNKPn5xzKc2A8JY2y9eiTUIqJDSYSHeO1Wi0B762EpFJfK+NajJVvYYU1Qcd1ZVfGYZ3
         Hf68bujrJlH5iZsD+pive3TnPCqpWWWXdQyA5jN44oOeEFnU+VhLymm741sdz1gqOdU3
         XhgP4KRtmiDNAWB26H6o/CCAXTe+eR5sebiyaH/pDfeyLfNFzPsrGgklVZOtmMTpjMe5
         jZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286381; x=1708891181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaU3EAwEomF6Aj6BbZNDZDsZcoaXMFfYG6mbHdqh29M=;
        b=E3sUcy8/wKspJuTFzkMUyqL2Z8gSeEi+3VCaVyEk831e/doBiax3AQXSK9nAaDdVfu
         jCRF2F2hFfYwIfizkj9EBOdyjEs5Bj5kBn9iG/389h2gk+P2DKbnmdjUw8+BOnUB0+xg
         E4razJ9lZxHVToPEARJrbSp27PZv/2VzEiTKgfjjrDEnQWRvFgoqcOFG0gSjDp3UbWyA
         IpyHbzMugh23PZ5JburXmZr5jhoBucIz7wHhW8vg7cQ2M2FsXj4jddGP8OPlLYPJlgSz
         yfmlGunbEnEwPKb7Ulm2IIMCB8ZsOpISQrCjeNVGBgYXUQ/T1spX/FGOD0GzmQES6o+/
         zDeA==
X-Gm-Message-State: AOJu0YyRzQfjVueYzyaJPkk/UQZxpmIcxb7zNwt8b/0yHgJokf0mg6Dl
	7+gm+upSyK2kk4Flis4bDdoGc+HTS2ocNVj75OD9VBaltkQqYm0B53Hw9siU
X-Google-Smtp-Source: AGHT+IE7UImvPB3MkwumY99bE0BNnxp9JGjbF2cMno0Sjr93IsezfEF3BrauTgXLXrvob9/w6f+V7Q==
X-Received: by 2002:a17:906:780f:b0:a3d:cf66:51ff with SMTP id u15-20020a170906780f00b00a3dcf6651ffmr4735063ejm.13.1708286380652;
        Sun, 18 Feb 2024 11:59:40 -0800 (PST)
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm2206999ejc.51.2024.02.18.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:59:40 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH v2 4/5] notes: do not clean up right before calling die()
Date: Sun, 18 Feb 2024 20:59:37 +0100
Message-Id: <20240218195938.6253-5-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240218195938.6253-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maarten Bosmans <mkbosmans@gmail.com>

From: Maarten Bosmans <maarten.bosmans@vortech.nl>

For consistency with the other uses of die() in the same function.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 184a92d0c1..6863935d03 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -311,12 +311,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 		die(_("failed to resolve '%s' as a valid ref."), arg);
 	if (!(value = repo_read_object_file(the_repository, &object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
-	if (type != OBJ_BLOB) {
-		strbuf_release(&msg->buf);
-		free(value);
-		free(msg);
+	if (type != OBJ_BLOB)
 		die(_("cannot read note data from non-blob object '%s'."), arg);
-	}
 
 	strbuf_add(&msg->buf, value, len);
 	free(value);
-- 
2.35.3

