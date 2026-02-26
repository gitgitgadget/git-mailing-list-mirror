Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41902494ED
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065651; cv=none; b=HS8vIrl5G+FdB/VzJod4gjqOAsz/aswLcDATGkBRGeVvIX6GqPIRRkBPZ4YDj9JCU+j49QPuqZbn7kLN40Zhl76YZqeRZ+9tASNI6kZTzNSkSDLn7P03viMUw+eUqL/WiRNutjY1hxXurNmvyDVKeodSMGXNELdsMYvVeYC2HG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065651; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tazGLbgovNYnOS0fvSysltHcmNr7WvvKhcNn3de4x7K1rXQXGrlpPeU120N056Jz6HWUC1xBDA6aqTlcYI6f9QA1uTaLVa3z20AQBvTlpjONlCF7sl/TSro9W+U2B28v7rdu6+2DgdmWz62InyUSqHNA75rob8YozlUHjoKDFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdnvhCrx; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdnvhCrx"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdc4f2b680so217114eec.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065649; x=1772670449; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=cdnvhCrxbDT1MNvv9J3ga2UeGmNqEPwUX/9oyuHUCRGJ2sk4Af1U2X0nppNnB8QB9R
         LA6cDLf2Qy/kOAIGG1KfYiSvNKi2VL0flUB68d6y8oAXcDEZt2UChGBf8si/MuWGd9M2
         anD5u7UowQ+TGw3tUZrGZTyqBX0z29GDvq691CLBkblrazzj3tvCmMreIsW8d5MYvhDj
         12KCx3WZMkyPd2crm/YwRjhSwtwO6o7fO00aUHcuq8G7PvoIqDucGeKvOLv9rgsVnMkJ
         FaHzX/IMm/2qjFZ6RXvpYfl8mIDbYq+lIOaX89Jhss3W9XoGNGYAzwgVf7tPeZuI50gp
         FIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065649; x=1772670449;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=PBISWZtrhxzlALIQ5JE4nxNyS8wcph6VQpYtI2ZTeOUOxrpUW2i+8L5FjYQ1wrOpa4
         vjtphCQEsPaCmaSJBgT05NcNu6dokLxnjUI4LV08DP1JSaJd+hYejVZtWB9E+7kUeV+f
         xlAYIzNdSVyVzMwTVuYASfbr/4H1kbj1qGSUeRueyvUcpYmyU43T/nr/Y8DGlpXo5FMO
         E4h5VC1HX33lU0dTNabQVhUMYxfp2QQwTNZqCVUePcv7VwmZdG7Mp0DpE9zbmHpUd5W8
         DSVgqjjo7AmR5qJF+9o9LN9zlTzhA4XWmwsSK37nNLBn4+V+t4wfmpVfHxZMGfEojXME
         5PpQ==
X-Gm-Message-State: AOJu0Yy8aDtNkNRHa7UdtGi/eoQ7u/m7AanaW7T21X/alJG3kruwH39f
	NfhyAQTfpa5/jzeCUAuwJQv5v+HVkKnq7yMTFm0s6GrC1mqQplBNnEF9/vNgegNF
X-Gm-Gg: ATEYQzw2PF5ycck8ZmMLBlnET8kqJiPPPuKAygXkVHi0HRphRsovwglIWDp1ae1X4BN
	BB/8Pfg/GLGLcuttyGbxSOLT1HSNC8atoIt/YhmpmC1eX+fGZmtvQpy7rZ8qq9gEH3bzJrbAhvL
	eD7xkCBWpfehH8aZDGjAbhWWWDj7pcXwZYu9R8+lkiVqw5Q1ZzvFt9CUU7ZCalCffrQfKWW/qFE
	Jkk8/fu5/LccXE6A/nZGCgkQL2ZQKLPNW7vaJeQtMR52hPNU9oU3I0J8hMHnG2jFOvTcwjLYxjv
	xwW4sYkbrP0TSoqv2gNFN8H1ylW/VJw6TEmgIa2Zza7P0Eqo9sv/QGPG1RRQ+LxmQcxZ7dr5+Lh
	nXJRyNO2+Micnh5kpfKo6N/h9R1K2aEvYQi1+Xqg/QO9Lojg40INZ4NCwcaFuNC2NTlMGlLLdma
	BT7JJtXBvYSCQLYZ1fv0D4V5nPxQ==
X-Received: by 2002:a05:7300:fd0e:b0:2ba:a713:d64b with SMTP id 5a478bee46e88-2bdd2f124d3mr183447eec.9.1772065648442;
        Wed, 25 Feb 2026 16:27:28 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bce276sm529280eec.3.2026.02.25.16.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:26 -0800 (PST)
Message-Id: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:14 +0000
Subject: [PATCH v7 01/10] fsmonitor: fix khash memory leak in do_handle_client
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `shown` kh_str_t was freed with kh_release_str() at a point in
the code only reachable in the non-trivial response path.  When the
client receives a trivial response, the code jumps to the `cleanup`
label, skipping the kh_release_str() call entirely and leaking the
hash table.

Fix this by initializing `shown` to NULL and moving the cleanup to the
`cleanup` label using kh_destroy_str(), which is safe to call on NULL.
This ensures the hash table is freed regardless of which code path is
taken.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 242c594646..bc4571938c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown;
+	kh_str_t *shown = NULL;
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
@@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		total_response_len += payload.len;
 	}
 
-	kh_release_str(shown);
-
 	pthread_mutex_lock(&state->main_lock);
 
 	if (token_data->client_ref_count > 0)
@@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
+	kh_destroy_str(shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);
-- 
gitgitgadget

