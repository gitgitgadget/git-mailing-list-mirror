Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156743939D9
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498105; cv=none; b=VGz1GBhquLK+aKS3j5EK+QfIbL81PvBCGA6ogm0U7s3ImEOK4vZB7QTEl/HgXaVUFRezCSyF8Ta0xCWY1J1KgzaPlRGSJ5I1vq+t9nMpJV9IGls0KDcl6UmMe3QjyaUS2OmjYPRf37lV4NrNyta2QrUny1wOc9IHxrUnS3VhLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498105; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CmvlQ1Ua8HiBltbWMWceFndjik3QwsvqBBKf5MkKcFZIR1dxHa4k8bPufz7LaCSc9QdrRP9gMb/V2Yztja1XkXwLErqyQXHcPe829iDQavO6txy2HhLyCgdkz+Ebthm8wMGPSuvDOzTn28tI8sO9EGZj5rPo3aK73VQPuShIm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAN65oOR; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAN65oOR"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2cbdd9852aaso3483354eec.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498103; x=1776102903; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=mAN65oORdi7TS+4PXIWptrXVexeREJ3u95NRsKVtb0HdnVaAXWpBJiUMhXM6g5B15U
         iWXk1MCFEuld4dfsR7F8dVP8FPz2thPJzVsRwOq6+fgkkzz5+Foo+mgSCsaju7fCMOUc
         ZU4zJJLflbxBCVs8jdl7zVKi9OTPwLGoSojuHR0IA6udKFxMiH4cw9Sfvb05keyTSoZ6
         7Y+VEWTTbHKtael3KcSRVSWIzz3ZzMcvI+WrZNv9byoetyx7bb+fMGGLF6+xOCr1hEny
         uXqx1ClOSRusAxGiNfMfbwHDjbn8V5irG+s6zHqZfc6TB+DuVdaqfzvixJM1upFTOg4M
         UbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498103; x=1776102903;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=UBhvM47IgTd2upwdqzCJpulM+QbaHU9nRaiINtTu/+PYiVnsJWrynBD4tiSl7aRaOl
         XC9lgtgaybORyqAGI1Mrx2u11mab6ScOG4E7CExllJYG1H9R8pjc1VGQPEN0pwXmP2aj
         hkDG5p/zNE2WIYbCBvr8qNCl1KlGZ8smFPvilteDQ3z+laLlZ1gnBNfJucAcUdRPFwMn
         e7g5rJerAM/v5io41+eVu4x0GfMPOHhb4M2USVdxiCzpyaxti/xq+rRMjIu2S2Ua7cVO
         zWKwztYjbwMHtYZScCniP7/+jY8GGdgQFlmVSjcL553+YXHdUso64v/nlgBMgIvlvDYY
         DgOg==
X-Gm-Message-State: AOJu0YyHE7gqQbRUi4exrRPdaR0b5gUeZsZbklhFjcMsyqx8wqlIVSY6
	8JnSuFNAH21otv4zwuvMC5+DQ8QUHnOVUKUf0QGnEoPdaepMPSf35brGruMEYA==
X-Gm-Gg: AeBDietU4eFUZuVwNHRVnmNk4CWMj2nCUqatlkfpTzqsfzuYKFGUcmACjBy2Q513zvZ
	2DnhxYivKbOSoaevfrm3ndEF5VQvmcJ6iddPSFkSFOP6zApVkO3fsEDJ3kuRnCdjO9Dn5ASSs8N
	abVMwTDAEWrPXfeghaeiiAQDOc7SxTceZCw07kn/mmW6nDRbw3L+iFZgtbmO+lPrr8VaBA8urDC
	dxaeMnmc7cxSwR640+qidPYSuS6s5790KzSRQiJ/Wxf+bFPN+deOEWXT7ks2rbYIt65u6/LbA5I
	1dnM8BHLTDwnZ0LXOABqF8mDGSe5xbaN3clrSSW6QeVLXbLZVXEJXCSVQ5aLeby7M39c48rY8k9
	RHJOlPlFpw8E4ZDRRqOn40oXrQvux30eCU48MneciLdtV03l2Dj/gvMw10iVQgdMax7BGBAsJXW
	3wmluwsbD1vlvaXoNELf7zzWz+70M=
X-Received: by 2002:a05:7301:1006:b0:2c6:55cf:de42 with SMTP id 5a478bee46e88-2cbf9af8b8fmr6098363eec.7.1775498102665;
        Mon, 06 Apr 2026 10:55:02 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm13973093eec.0.2026.04.06.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:02 -0700 (PDT)
Message-Id: <9f666beea7aa9a5f38e91ccdf4c2806506acadf4.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:47 +0000
Subject: [PATCH v13 02/13] fsmonitor: fix khash memory leak in
 do_handle_client
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
    Paul Tarjan <paul@paultarjan.com>,
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

