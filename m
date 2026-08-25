Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6D3B6379
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684198; cv=none; b=O5LNxSEiVPTS53bxn/fs2GoA4KJ3fFUwyc/54Q/qVz9jjb5kVhPNxdkUaCdKsrBXjnkL1ZueZfkvRKZJmgB9A/F1S3jKK+MSNJLVc1qfJR8E8/i26ZZQrI7TisHSdTX3KSaoY0pe6qIx4Sz83nIvbRo/g0klu8/OoLTg+hF/msM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684198; c=relaxed/simple;
	bh=MT9dtwYx8E8rh9BAByRWXay1EQcu/+7yL3FL97SkuG0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y/QlwT1iKL0H2jlNlK6xB/YClYnrqHtKdCEVP++uo0pUq8e1+AISm5C5QN9qJLnY87M4hR5pFoqoJ++XXLQmy4BbjVaRBCMPjuYLFZgGMyb1iFLL9Phc2auBjVZBNyGvLlxLHjpQyVyBfLNiDIiqu3ZLlEq+OXV/mTjJT03+OOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exSoeiXT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exSoeiXT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so226293a91.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684191; x=1788288991; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NbU2GtKeRttj2xyh8lux8ka6I+e3u5TZhvpvzX80RNM=;
        b=exSoeiXT9IqkNK8FzK6aD8BvfLzuNwZZJJUN7/HkiZUi29YRVP+oqUdcTKvIzldgtX
         pc6itqHuk2BnkYuV2YoqdKKmT4J7ISkYhphMDIQyjLSxdtBmEvGbxd1N8yqSICXJCWSe
         mKJ0SHvVjDu054QtDdbEYvpT7lmzN7+nFvOolArMhFbUk2pMilGwhytBjobu0K0EMzvl
         E867B+5wcXqauRj7/MDfxtX6ZwvoL+DzgN42rB58SCAzMJt48ZrfYVWASCQ50Fj0sUgl
         KHo4xelZ+0nEXaHFy/MJrhuPmGI6EnzdLf34sE1bSk5D0OnRguanRLHW+uGR91mTbw1Y
         Ot+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684191; x=1788288991;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbU2GtKeRttj2xyh8lux8ka6I+e3u5TZhvpvzX80RNM=;
        b=Fq3ndsRjDrJwBhCaYbrkHij0YMERng+r39HSzVm8SqG5xw7/Cc6C49w/ayNxxyVrDD
         Rp/K5sknCmi+si3MTpwvhzY4iTyTHHgxUZjUN41Z/Qrt+/jmb5CFC52TtXf0ddV/11nT
         GiPb2EjZ9HoCI6qzu4r5XEVCstVeL0cz28uUz+OQe2/a/vZpVPVVRIkGfKhz6iZ+lTJU
         cPicMou97s9bJZFi9mIZZZJkCzTkSLJhJnhZ1uu0n4Z4NDP5RbJDIHtsk4UXrcJOjb3o
         zsg/ABXellFAxdJdnXv6kGljBBVB6RFgoHrxErfVbFIjWhd34L7mTLwPam4A0k+8FZzA
         ut7Q==
X-Gm-Message-State: AFuF++l7GXdtWYBr8Sbr14wEI4KjBMyVmT9TDiolbUnUowNkHDpNVPqG
	IOChBVrDsjh+tPNX9AkL3J/RRAFKMTejfZbLfPGa4qHc5cznse24pTk9Bi2VUQ==
X-Gm-Gg: AR+sD113Q+jgKpilHSvEMtXOyiNc3E6NnB9sCV3ShwY75D64AYdyoGlNtc0uS/52p34
	MRdkMVhbld1VaDPauGeCcw7ertzKGaE5r2+NVBBMtaOU8tj0qxZnGsHQiDs3OECv5hUqq9N/CyY
	OjIhlCejJN4ugP/bSDpx5OBewfRyC1C9OeU0dz2B36oE+2XZXdGNYKvo5lNfdM0DGEU9GVa1wEK
	VCdLWM5uEY5VqffueDs6SnnJaG6RTRH2T3yv7idmNozSA4FeBOzguSwZkCXPs6jy7yg5Q4GgWNd
	STXxYwySDCH6YG+UM0SI74tu5S/YP5jctN92oDbfa600jFVHNH9rCcDrueg/KvDDPNId5ttlv3G
	6YCKaOqwpfvUkNnx0DEFOxDnWT1yp+ZUlf3Z83myGH7762/P8C7fdU0ZuPCdUBdPBwiypvw5Z8r
	H+3wNOsZQkunFf7knKsKjenFcCBjrvJk57002NI1Ywtp+hVbDBjJZNdpEr9ZLuNUM=
X-Received: by 2002:a17:90b:52c8:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-3966d191092mr2722986a91.5.1787684191002;
        Tue, 25 Aug 2026 11:56:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f47d8csm1167894c88.8.2026.08.25.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:30 -0700 (PDT)
Message-Id: <7f0bb405ad380fd35ae6381961ac667fd7e5dfd9.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:19 +0000
Subject: [PATCH v2 5/7] trace2: remove use of xstrfmt()
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
    Taylor Blau <ttaylorr@openai.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

We continue removing the possibility of a die() in the trace2 API by
banning xstrfmt(), which calls die() during a failure to format. Instead
of allowing a die(), perform a soft failure by failing to output the
trace2 data when such a failure occurs.

This requires carefully concatenating strings using memcpy() to
construct redacted data to avoid copying password information in traced
URLs.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h |  3 +++
 trace2.c     | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index cb2eed75cd..14aecfdc7a 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -17,6 +17,9 @@
 #undef xstrdup
 #define xstrdup(str) BANNED(xstrdup)
 
+#undef xstrfmt
+#define xstrfmt(...) BANNED(xstrfmt)
+
 #undef ALLOC_ARRAY
 #define ALLOC_ARRAY(x, alloc) BANNED(ALLOC_ARRAY)
 
diff --git a/trace2.c b/trace2.c
index 7044276435..c37f783fa0 100644
--- a/trace2.c
+++ b/trace2.c
@@ -260,7 +260,10 @@ int trace2_is_enabled(void)
 static const char *redact_arg(const char *arg)
 {
 	const char *p, *colon;
+	const char *redact = ":<REDACTED>";
+	char *redacted;
 	size_t at;
+	size_t prefix_len, suffix_len, redacted_len, redact_len;
 
 	if (!trace2_redact ||
 	    (!skip_prefix(arg, "https://", &p) &&
@@ -275,7 +278,25 @@ static const char *redact_arg(const char *arg)
 	if (!colon)
 		return arg;
 
-	return xstrfmt("%.*s:<REDACTED>%s", (int)(colon - arg), arg, p + at);
+	redact_len = strlen(redact);
+	prefix_len = colon - arg;
+	suffix_len = strlen(p + at);
+
+	if (unsigned_add_overflows(prefix_len, suffix_len) ||
+	    unsigned_add_overflows(prefix_len + suffix_len, redact_len))
+		return NULL;
+
+	redacted_len = prefix_len + suffix_len + redact_len;
+
+	redacted = malloc(redacted_len);
+	if (!redacted)
+		return NULL;
+
+	memcpy(redacted, arg, prefix_len);
+	memcpy(redacted + prefix_len, redact, redact_len - 1);
+	memcpy(redacted + prefix_len + redact_len - 1, p + at,
+	       suffix_len + 1);
+	return redacted;
 }
 
 /*
@@ -300,6 +321,8 @@ static const char **redact_argv(const char **argv)
 
 	if (!argv[i])
 		return argv;
+	if (!redacted)
+		return NULL;
 
 	for (j = 0; argv[j]; j++)
 		; /* keep counting */
@@ -316,7 +339,14 @@ static const char **redact_argv(const char **argv)
 	ret[i] = redacted;
 	for (++i; argv[i]; i++) {
 		redacted = redact_arg(argv[i]);
-		ret[i] = redacted ? redacted : argv[i];
+		if (!redacted) {
+			for (j = 0; j < i; j++)
+				if (ret[j] != argv[j])
+					free((void *)ret[j]);
+			free(ret);
+			return NULL;
+		}
+		ret[i] = redacted;
 	}
 
 	return ret;
-- 
gitgitgadget

