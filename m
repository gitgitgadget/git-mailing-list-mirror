Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE623D3D1D
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658985; cv=none; b=VXLVdsewxK08G64XFYvqCQ31FbU9UOus717Pgbxq9YKzSl6RYbMYPIFr3x3gHyhBB/nKFxxbAqPAfoM0rjQN7Y2xDldJZm8MPjRzA5/s7dS5BElu4TSDZS9U6WuxesHtzT4XUj9TJy7eHXU0BW/ySBjx3EM6EvkLu7FSdcqYS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658985; c=relaxed/simple;
	bh=xUrZTD3SJaBAl+zREMExsiTltc2TDvUVg2EV7pIICLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GHn4a44gY4zO9XqFpGfgxn21dXPARPI8FuWA07Rl15pQ0tcsytwZywnLlRVdXJ/Ptlwwgi+JRJYnR1+IVYozy8bsk+O9RxBOyiUZff+o8889Uamq+nJ/8v/THR8Ni0q9CSoY4W1p2glH5d81q1rEy4Vatl1K0bB/13G2BZnVT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVvCnTe1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVvCnTe1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a00566c11bso86572546d6.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658983; x=1776263783; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0RY2CTVUab56zkOQP58cUVUWiyJrFis2cJVocsedLY=;
        b=UVvCnTe1QP6k9oo7GrqCjwNw2xrTux8q1pIR/N15crpjZL7mNOY8tDGzHegehKLhzv
         2Jy1e+VBmVQB2rzYUtHCIIozA5NwYVV8JlD9L7m/bhtcViSHMvrkx1DAqKTUwqQRXxT4
         Hgzq3MtJOtZLs/8368PV0obvhhsQmUP7SmZpwNNwh4qkIU0hST5XmBxUBfwX0v2huCj7
         qml/8FPHZdbiQv2IrLIgNQaTCpnYu1EBnGvNKSES6QBuVz16oSHzTGNQUr9AaYOZAtOu
         DcjdnKrpsqvZOWFT8Zf3AYC45QWTAgjwb+nwVPfbrE2/TwMAarXsrIqbTVIAPyPjc/vN
         dVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658983; x=1776263783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0RY2CTVUab56zkOQP58cUVUWiyJrFis2cJVocsedLY=;
        b=lOfLBaZpXXcaaLNDwi18Y5+0/72zu6M5voPJpkjB3wR010Lfultv/aQCFfKriIPLGV
         LzNwcfec3g4CFGzwU2f4iNTXIfwBdzFcj640tN0tLKbU1iPxSSgIyovh8jWnbBzQlgoS
         bIiBgWejVXPOYvXhEJlgGqJoaw+LctHTbeltXqyP91u9qUu1aG0ZTUSz46UT+1dgxJfS
         +kUmUnQOFGLgC3bKMBwJF7judchVDko8BAdJcbnfviXwJo54QtATPR9eY++kvIA4+0Ku
         rLlDAj52sJP9mmGgmHhZRkqlG/coXI6yvcLVE8CERuqNyMpSMuKl/amPflKYNiAGRtWi
         J+nQ==
X-Gm-Message-State: AOJu0YyItKQCQRs3dfY1EPSLtZSlu2WHoDhfG+Hs2T/sRmrvWMr1rWjr
	isSv9QwNmUo+UKGlhXfoG7SmEXtyS4zUJmB45ciD30tIp0cMU5VoP832fdI5Lg==
X-Gm-Gg: AeBDievkLpsqxBLOwNzBR0H4bNE05rtrECUHQN+jFJ1JpMTvDXxG/M4vTDQ3dhcRWl/
	z5thk5h7/NqxsQLSNWow8HNG7rBVlfjOcHWGvFdR+D4ChxG27s9MEju4ovUBCyQVfH/RwuyT390
	tFNwUbl50sRtv648RVt3LmHLnbgDy5WqhPMDGmXgX0ljWxxlK+jgPPdtQ4EIvuKKx30T/VkpuH3
	SkOXPYJolWw8RhMc3bh2SyNLzpuWjh4fxPiz452jSDjm9gnRcwMm/NKaUTseikcrxCBD3sHvSNX
	KebTg6mov6FLkgEVsr4Xx2SDum/KfQCDN15XlUOR8ZCeAPc8McpjSKr+AUbVAq2EuTcI1S/5iWF
	th7T1+8cS+2GdoUzdEKBHhI/EyddgJRslV4k4RBTWjpMvru4STPoJ6I1a6WWzzfKeOdUxplvx3O
	J+Ms3oqbOYzHGE+nDUAtiC+/mn7+M=
X-Received: by 2002:a05:6214:450c:b0:89c:518b:9db7 with SMTP id 6a1803df08f44-8a704f9cf39mr361637666d6.53.1775658982668;
        Wed, 08 Apr 2026 07:36:22 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596a0a3cbsm186678346d6.25.2026.04.08.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:36:20 -0700 (PDT)
Message-Id: <6c227f18aba3d36423d4b44dd693144daf25b6b6.1775658970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 14:36:10 +0000
Subject: [PATCH 4/4] send-pack: pass --must-have for push negotiation
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
    jonathantanmy@google.com,
    chooglen@google.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When push.negotiate is enabled, send-pack spawns a 'git fetch
--negotiate-only' subprocess to discover common commits. Previously
this subprocess had no way to include must-have refs in the
negotiation.

Add a must_have field to send_pack_args, set it from the transport
layer where the remote struct is available, and pass explicit
--must-have arguments to the negotiation subprocess. This approach
directly passes the resolved config values rather than relying on the
subprocess to read remote config, which is more robust when the URL
alone is used as the remote identifier.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 send-pack.c           | 12 +++++++++++-
 send-pack.h           |  1 +
 t/t5516-fetch-push.sh | 15 +++++++++++++++
 transport.c           |  1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 67d6987b1c..baa52680bb 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -433,6 +433,7 @@ static void reject_invalid_nonce(const char *nonce, int len)
 
 static void get_commons_through_negotiation(struct repository *r,
 					    const char *url,
+					    const struct string_list *must_have,
 					    const struct ref *remote_refs,
 					    struct oid_array *commons)
 {
@@ -452,6 +453,14 @@ static void get_commons_through_negotiation(struct repository *r,
 			nr_negotiation_tip++;
 		}
 	}
+
+	if (must_have) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, must_have)
+			strvec_pushf(&child.args, "--must-have=%s",
+				     item->string);
+	}
+
 	strvec_push(&child.args, url);
 
 	if (!nr_negotiation_tip) {
@@ -528,7 +537,8 @@ int send_pack(struct repository *r,
 	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
 	if (push_negotiate) {
 		trace2_region_enter("send_pack", "push_negotiate", r);
-		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
+		get_commons_through_negotiation(r, args->url, args->must_have,
+					       remote_refs, &commons);
 		trace2_region_leave("send_pack", "push_negotiate", r);
 	}
 
diff --git a/send-pack.h b/send-pack.h
index c5ded2d200..194a1898e5 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -18,6 +18,7 @@ struct repository;
 
 struct send_pack_args {
 	const char *url;
+	const struct string_list *must_have;
 	unsigned verbose:1,
 		quiet:1,
 		porcelain:1,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ac8447f21e..9272609eac 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -254,6 +254,21 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
 	! grep "Fetching submodule" err
 '
 
+test_expect_success 'push with negotiation and remote.<name>.mustHave' '
+	test_when_finished rm -rf musthave &&
+	mk_empty musthave &&
+	git push musthave $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C musthave unrelated_commit &&
+	git -C musthave config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
+	GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c protocol.version=2 -c push.negotiate=1 \
+		-c remote.musthave.mustHave=refs/heads/main \
+		push musthave refs/heads/main:refs/remotes/origin/main &&
+	test_grep \"key\":\"total_rounds\" event &&
+	grep_wrote 2 event # 1 commit, 1 tree
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
diff --git a/transport.c b/transport.c
index 90923a640a..e65f896ff3 100644
--- a/transport.c
+++ b/transport.c
@@ -921,6 +921,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.push_options = transport->push_options;
 	args.url = transport->url;
+	args.must_have = &transport->remote->must_have;
 
 	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
 		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
-- 
gitgitgadget
