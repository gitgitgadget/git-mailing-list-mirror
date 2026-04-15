Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA03A7828
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259665; cv=none; b=qrxL2rP3E4SIbJjyjP/nfBDibVpjB+nwMV9j+TL8afuSvHMHIOtfYFDQICUhxYo52FKSq2n8aOrZHeppxXMhrMkcWWCC5g+mWXR58nPD/Rh6A05UOBvAid4gPA/pFUuEMPKLzymEsp1L9rG0r7OBNZ4tPdpcnZwX1yXK8CB0T00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259665; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BLgY2spVbLyVBwN+TAd0I8U16POBm82tEuMvXr7kFInP6mO0sESREYIVd3Ci99KVPDk+TVFyllCTHWiAfJMTglyd4uLMfUBQ08j2dLLxf4cO00BfKw7Ec2MRRpVGEY6EPgmi7h+8xj0UGxurnq721uRS6v0aR+4c9U5Ll4nux88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICOCzEs9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICOCzEs9"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6f21c2d81so509576785a.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259662; x=1776864462; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=ICOCzEs9sScuw778sVSVirLpC+x8Cf71+QurBDSDKkkJdMYNo+TH5oskM7RGJfHpU1
         t8TGrcDYRPGsbmTGYIIs5HFu642i4cRx4tXqOsZriidq+WCp8eaRM/G/W1PbGBHDyrNM
         /zE7iV7DezleIdawo/pZzdD7atzpwKydRQsHtHZmib8EFZ7WYBtxR+Yb5hxfMswwfTWs
         WHsUXvPi+MRwtEGM8wIMHPATJSzNkXUT+eLutzC+wL4ekO8C4WRnimpKZkMWKEEzzpUv
         g5wdYVqAaOgJ7fNhKKw7byhgaO8rADbrt32Ub63j9Yt4rGLmewtiTj0yCSKY3Tv5WK5S
         0i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259662; x=1776864462;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=WWHkrKc1m+bVxBTpSGZMvSZkKMdQwz53/zSCBnt4Q8t0RbqzLlK+r7qpZf+toAxhSU
         QRAvjye6VKLtmsGvKokciycHHe3skQniCpyEcQwOUqlTpP9G0AIMi/5MVWiKLJde1ZZV
         wCz/gMTXkkr/7pmrZC11UsY9MaBk7X1S8Zig6deRhvnKr6EL274HpAEN49NWJpOAaNeE
         FsfH539RMV0L2FEiXilaiiTtrFEX4r2zvCqMNy3tvVdJPD8+2wara/azI9oOezLi2QBK
         oOxFyeEZ4sFXj3SSft7/4bfkb9st0Kjl2MkzOYrk2rhYxedTevWU4nXqFZZZj4QbbguO
         /H+w==
X-Gm-Message-State: AOJu0YxoUqo3hmxP+KnKsesLVlq5r+tHVEN6K1R1m+pm7+Fe7SgCMP5E
	JdE/mgdOjDC5kTsq7oaZoFBKrJXEu5Ssg08yS8XL76scSc3XahIqHfiHs+PoaA==
X-Gm-Gg: AeBDievkh1rJqKGj0tkuk+QskVfDOQNAY3vdnJMExGl+HU2NeQPvgdnaJpP2pH3DsGU
	3BoJKAZ76h7q2RR7EM43PAGGzH5SpcYJyrFMrCs7yN5Nu7iXUTIfhjFbgNWKLSN5RAF571pDmi5
	XFc4Jmssa4jzmpe9nFF8OXFXBOYOSQ9XuK4yBqf3Yi4BPlhr+rQj0m2OWhpLTj/c/eVK8gUs60N
	VC/L67+xbLYsDdI+FKgJlPxOHKjPXVQdwK4OnJA9sAZ/qDMf2fZW69l9ALZJ8ul8rv2SYHh2Ehu
	HFPOCT726jP0P8hUutHN4xaoOHa0g/HfMBMKJjgDfqjT3hNVFv9o1OgVtLC/lNaefyzI0Esu1Vn
	UD0i65QV04zZvPl5GDclS8by36Fd/Yc9KHV9eFGcKAPJAZq6FUck7DhEdyezHgPN/nABqAD1rMG
	7VjDgNnxf8ui+yPm1/FRYMsBG2Lw==
X-Received: by 2002:a05:622a:1985:b0:50b:2eee:4b38 with SMTP id d75a77b69052e-50dd5ad15e5mr301709011cf.8.1776259661916;
        Wed, 15 Apr 2026 06:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1adc9e60sm13008921cf.11.2026.04.15.06.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:41 -0700 (PDT)
Message-Id: <1283d259684c0ce1484d533d78076d059106d84d.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:26 +0000
Subject: [PATCH v15 02/13] fsmonitor: fix khash memory leak in
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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

