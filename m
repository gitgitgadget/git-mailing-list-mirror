Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60321DFE3C
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181695; cv=none; b=hxWXBJG8wX/9po1bdOkMYf0pajJJcXjUqG/aYadHzBhIvqjBOx8pBOMgb9kItX2i7xx3yNyEYh3Bts0jHQ3mUkqRmpDu/pzJyt2Lg2q6Ya2JbEVlTXOMCpvD/3f4u/lh5KX59IUBA60JoyAvMdunOeK2CNXzJm8YeFtR1tnJtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181695; c=relaxed/simple;
	bh=gGT4sClNAEVFi2q6/9l0eb4NoWm0pY3aniYGslfwDUE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Abyjhlh3xEwZFL/Lc0mNw8sRnfx77Zbeu8WLv8+oRt56/NEoIikFqEaCMdPDk4EOWdSmar4SB3tBSfHw2ye0u0jGd8TgZq7GgqMH4Vkr0kVJSth52mIYaQtpzuSeXGSBpeYIF7CyCP69/yXl7RHgYMzYUU+kWW5G//4zygsT9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkTGtb/R; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkTGtb/R"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa503cced42so719469566b.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181692; x=1733786492; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGBQbzuNYxN5FTR54bMtqCam9ba8agaf6AyhAHPSh4Q=;
        b=lkTGtb/RIOiJzrHdWELYOtmWOSZVMRc2rnCQzlXyIFaNO7HV8CUBISq8xjFdpxhe5c
         1Lm4bcGgMDk8bacDPQzgE6ricriTfblxi9VY/TKQSbvU87dp11mLWsq5Gx5CBJP+pcvb
         nHIkGq/I0wHf1mC2+FFSdlWsu4n/ZO18A/9toZ+4wBPY3PCO9MjY9FdQhiUb8q6qKrHL
         QsGGbtv7Ewil/DB3cbhjllqH6UH20kTNzpJrHxgSIf1r6wc0ktjIan4TXe3S//y33/Jr
         zRq/rcHkhPAcuNh3XE/8DA9h1KJ9PeRPQ9GcM8cHNOSfpXhkbxiTWqq05lZ+UFQPjZ3F
         yK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181692; x=1733786492;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGBQbzuNYxN5FTR54bMtqCam9ba8agaf6AyhAHPSh4Q=;
        b=BT52Kv9nr02zqYwNhwcBVWQcpwvG0U15aN7OjXyjntu5MQeui95WetSREXmMoWyQ/2
         N0sJ7/5hPKzAwk2fAIK5XOZGIWidqu5v0EozqiJ1vkgBoCKwT5I/YyfdruCK/5DKmmUq
         1tXX5HgNBcWq83MOjcMo9kD5++pn7R+DAPQuKXtYQEQe7Gc7e5ZOVr1TFwAR+Hva0mNE
         dOa5DNFcqQZpZhHaQ5wVzwMzsFfD9i0PJrMwseTNUpE8w8MNWmrdWViez5NsAliDrtzu
         0ROUxMEUYsVEbsDyqFTXpTLLiC4DRXs3rawdplJX9i1k9En2GHUFptF/MgNZb/kFyxXL
         CPZw==
X-Gm-Message-State: AOJu0YzqvH8AKcI3Og7EhW/sxySYvPvzU0vsB76bWaSEnN+R6GWnPYu2
	ZRIq45rThjLZvNq4/P6yHceSY4DDdoAmoC25SKwHkys4nGb2gRKvpulu0A==
X-Gm-Gg: ASbGncsUWw2FoWH0VQqoxxUUF8YPWzLJoa6WEcf9Y6EjuvUWflAkty9Gv0BMZxH5gJP
	i0IqN9Keogy4SXtkoIqhb0pIjKFeOoV2bdoHayEa/Im8MQMecwuuWL/eQp8SI6qzXTQDFiPTlzm
	glIEYcmXoEi/JlQhVRy/ClOl2wQhQ+mPsbso7ppO+tUJdOLCzc7PDNnEdw3BmNPS005Ttdl0/Ja
	+E2OuHuo1M2rZ4HciOuipRWgIHgpEqZhhgwrmpnvTZL3//Jd+U=
X-Google-Smtp-Source: AGHT+IGjaCs4ZXlpFpgP3VlNPFyolH0xs4Nzdcoa0xsfv+LRhF531gRz0lKCnop4I3vRkSOVpWrnAQ==
X-Received: by 2002:a17:906:9d2:b0:aa5:2e85:3b04 with SMTP id a640c23a62f3a-aa5f7f4ad83mr4895466b.50.1733181691519;
        Mon, 02 Dec 2024 15:21:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599800a6dsm553709466b.90.2024.12.02.15.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:30 -0800 (PST)
Message-Id: <3885ef8a2f76968d67b03503455cb4f0761dd89c.1733181682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:21 +0000
Subject: [PATCH v2 7/8] pack-objects: prevent name hash version change
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
index e2f6431d614..7f1cb8de2fe 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -276,6 +276,14 @@ static void validate_name_hash_version(void)
 
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
 	switch (name_hash_version)
 	{
 	case 1:
-- 
gitgitgadget

