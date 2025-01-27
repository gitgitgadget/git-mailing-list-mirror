Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A01946C3
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004569; cv=none; b=CMU3ntjW53xLd8YtHyfMRKhT86KZ3ZEsiCZmmtROQCsgRiXXuLf8GxmCQPg0G3xP4tNI64LJJipqgXMqigVk/7u+AMINxQWQDP8zbUDSyGmF1uDIfL4uag5d1gO2XfYKs/Ih7eJAXOKZ586m1F2jK0Lp5ZO+L8++3YhZlOxi6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004569; c=relaxed/simple;
	bh=JdVj+U1cDsTbkZNQGLCyZAe42c2CLN7EcRMLh/xrW/4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I/xZeCND43BxBzO0V+/3qnyZmOAW7vHQbTC/D6diz69We9AGsBfi5RcGj2t1kFqAyJSN/uVlrq9RDm3Ny+H9kfxZ5XkG/p5e1HpyiuGQmCRDY/bXF9RvMQM+IJbU2oiue8TEc6SiRgaxCBWGsGK4EQ4OuMGNxwPrY3MaXjIe32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVUm5GzJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVUm5GzJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436249df846so32311505e9.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004565; x=1738609365; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g4Zd4bV2pt5qgOFmu3sjdIGZLy0JnYlFRmYIVQ70RY=;
        b=XVUm5GzJk+QgxYeZnUqtrUZAnBKYFeMFY9VHvMpvg7nNnwdjSrWj29g2IH1KoSeBd6
         rrEDGCu/ReW6T/798Dsjjm+b6vRYFy3d+wb5cumCEjIoEhJUuZtfS7YBZjPJWTQGtfPP
         URUqY27DziqOQ09vfBgDvrpNBq65EC1tgUhBfW55Bw5qO6+eiaIbScwWKdEK7YUhN62x
         WHVF3dIDHSJr00/aIu72NmjaGH2jsiggHhgZVVhh8hSvf5SWPUV0gVXwoZ8h2pffIlJA
         2u+F0v7Y1HMStiWURSxuLpeztMVRwwnwsY7Yzj8x3O19dkwOH7xloQp21gxoEbq96ftW
         qvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004565; x=1738609365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g4Zd4bV2pt5qgOFmu3sjdIGZLy0JnYlFRmYIVQ70RY=;
        b=ILGIA7lxs8WDM5645PfCOn7Mcr98bzOcZvw/NsPKE8RABXjLYx7f2lv/cksvxbjjR2
         hV6meRHjs79KfpSpBIW/3e5kTtcMLHAwDt530OYYaHgaTtkLe5emWxw3tDhvmO1pDtJB
         XpWq48VhM2Apeqbyk8CsJ+41oMTVZ6E52G68TDm+7QsMuSWL1F8WsiddHJkmgABg8J0p
         moPJImnqHhb8FikndlICiHyVCODpaBz3IkpQdAO7cFAKx3gUpBDEJAqCBP0BSe3bRyF7
         tuDjooiDMBVL5GyhNue9XEfjiTjdat7iiSi4ik35LDiTToc/VIwOA1PrTVaZn2m0f9rc
         UbTQ==
X-Gm-Message-State: AOJu0YwbOl6UH+UFxenXZ1X2/1ClCT8+a2MNwoN/OU36FZXs7VSB6okt
	hbtEsZwAXLHyXxHWOtPNIeZ2lS5Rcd5cNi1hI468coJ4Yli03urdKG9SVg==
X-Gm-Gg: ASbGnctl5BBq+TUdFgo+YJPhn8c/TKdgnyHJJ84qdIHuk5E7OB9fON97x7Su9MgjYVw
	EEkjb6+epWWBgpLvG2aVnsLAWYu8ojAQhIGpQWNJHUnyFR9BenD4Y7b/blYmDJ/6WiVI2Jmhsn4
	qb4KWV7Fw2ig6IXzXSEPu6fYlpc8Xy1E5kDj4VDOTsj7fXl7ttqhfkS7XrHBEDBqwn+FV6Gld1i
	eoQRIqEkhBwvWCeP/bsZ4J5GhBaRwviDJYx0Cxj0XvGlNIafPygMW/svd3h7yuKDvPJaD9HGJoA
	A240oA==
X-Google-Smtp-Source: AGHT+IGivEFsjZ5MFQOfTf0+tlFGQh3CeT0anQmZhrcjlGz467oKXM9lku7y3WsD+T/GF1yfojXp8Q==
X-Received: by 2002:a5d:64ec:0:b0:38a:82a3:395f with SMTP id ffacd0b85a97d-38bf56552efmr35237832f8f.9.1738004564161;
        Mon, 27 Jan 2025 11:02:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a176434sm12002125f8f.13.2025.01.27.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:02:43 -0800 (PST)
Message-Id: <bab2ac318802ed9993a5fffccd73966b6309cef6.1738004555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
	<pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Jan 2025 19:02:34 +0000
Subject: [PATCH v4 7/7] pack-objects: prevent name hash version change
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When the --name-hash-version option is used in 'git pack-objects', it
can change from the initial assignment to when it is used based on
interactions with other arguments. Specifically, when writing or reading
bitmaps, we must force version 1 for now. This could change in the
future when the bitmap format can store a name hash version value,
indicating which was used during the writing of the packfile.

Protect the 'git pack-objects' process from getting confused by failing
with a BUG() statement if the value of the name hash version changes
between calls to pack_name_hash_fn().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 57277429900..7c488d2d3b0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -284,6 +284,14 @@ static void validate_name_hash_version(void)
 
 static inline uint32_t pack_name_hash_fn(const char *name)
 {
+	static int seen_version = -1;
+
+	if (seen_version < 0)
+		seen_version = name_hash_version;
+	else if (seen_version != name_hash_version)
+		BUG("name hash version changed from %d to %d mid-process",
+		    seen_version, name_hash_version);
+
 	switch (name_hash_version) {
 	case 1:
 		return pack_name_hash(name);
-- 
gitgitgadget
