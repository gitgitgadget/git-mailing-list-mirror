Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E42193
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430444; cv=none; b=LpsYwewi1IqVZmakAe/m7sQIHEgHBSi8GnPs0dDTJtu7wmtin6NW8N4nRXBeuzyT0K8WmH82QoYCPlrx10JiY+8TMBAdBX/Nm/x+UEuG33IUsNP9dzz9MTkGLuiySUfYTlapI33e8f53ql45WkzfcWELj3t0lDGFuK5IUeElYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430444; c=relaxed/simple;
	bh=nj3z5yCLCiMyI2WRyTqO46fM737SuGEWj7mAhulWxRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=deJUR6tQv22sj9TqvmNR3jAaGItJk7ew4HvNIQyqOUwzLDCbfshGmC9mhwYdiJemByDJbdFG55CjWT8ctaRf2ErLY909qviHWNtcalz9KLGmg6Ixiw1Aj7lECJ7Wl03BJouiGo6UOWeWpDUmAeG9xbKgdCkImVfrQ1zPJQ2E+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ki8dUKRs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ki8dUKRs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2156fcd6eddso15105275ad.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 12:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733430442; x=1734035242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9p6lPvnG9KV1XykPypsUe5QRCLznVc74THCN0p6AeqM=;
        b=ki8dUKRstq7z+4TD0XI5q0ILAQD/rPLzq0Z+aA3H3FlXLIvc39Ok+gKI2BLETBHeoW
         hdvMmQabiN03pFifQ9xJ0oEaGLKK7kdtJaTEkwJjxVi1ZFqBa/6sOURCBh/9icLI+R93
         kMROTGRQqJglw3pyfnF9e5+kQT9Wfuzi4gj8V3K+IauQWowWJ+Hn40wHSyteFpCeRigT
         s24ZmvUqbiyjIevv90RXsNI0g2wPUWJi5h6kMUkjIFaw/kqFh+AFXNlOl5Gl9tP4Hn9O
         B5ycIDgqYF0+1bwkXKJx8sN3jLY57PvIrp8khMqikVK04ejdj6ZHlHf4HLZ3AF9hxt55
         E1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733430442; x=1734035242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9p6lPvnG9KV1XykPypsUe5QRCLznVc74THCN0p6AeqM=;
        b=n5omRm6oL1Jq3mJ/EeoVGZmp28h38JUj6Oy/RJMrnBO2YWc1i/TPRd0lrA+nEjGft9
         34mb4VIRqLGHPszuSY230FgKH6jxfvETIVgLVlIWLlwU4nFkgA843fGJfox/Di6yoyas
         DB/aFXpMTKBl4xmecluVu3jykAJD2WnIHC3vc4uZ+1ZhssvbkP+dsZ2d+q9clMzbTc4D
         7NhiifNvaM/s1zuODvOqUN+/diZfuFApJZKsVtF5WJcNd7I5ai9GESwcFpYIeIMONs7M
         Ydeu95Se1/CrLKqy9U9IrdHpyg5RbSio0sYvRCc7WIcNT2HR7mrNBMchueWAU8JIoe2d
         q9UA==
X-Gm-Message-State: AOJu0YxZXIdoWQ9eOJI85Eh6zVzEKI6RMPclmwaayp57Ehi3t8jse5Ml
	pIFyOSKuYTOaj7yFnoqwaCe39pYlk0EuWru37LDGQhFu+EZnVb6dTRjPg+ExFLYT1Vlen8jQSLU
	wmQcfrloIRyorvsgfMvu5uGa757QXck5Wp7eX8gwv256zPMOBOkW+6pYsJjWNl58rs3UlfRS3EK
	rmnlg+es36ow3i5HC2AbZ/UuMHu0gwG/s2pphdpxw=
X-Google-Smtp-Source: AGHT+IF/CXSQ3onJ7VKZWW0LNGdxDdKOxC42JjLGd+6O3xCmeqYPFkO28hE+mCb2yXeJiNWlfFONmxIZlWoODA==
X-Received: from pjbli6.prod.google.com ([2002:a17:90b:48c6:b0:2ea:9f2f:2ad9])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e94c:b0:20c:9936:f0ab with SMTP id d9443c01a7336-21614de6491mr2160265ad.47.1733430442117;
 Thu, 05 Dec 2024 12:27:22 -0800 (PST)
Date: Thu,  5 Dec 2024 12:27:20 -0800
In-Reply-To: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
Subject: [PATCH] Fix `git fetch --tags` in repo with no configured remote
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: bence@ferdinandy.com, phillip.wood@dunelm.org.uk, l.s.r@web.de, 
	Johannes.Schindelin@gmx.de, gitster@pobox.com, karthik.188@gmail.com, 
	me@ttaylorr.com, ps@pks.im, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"

In 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22),
git-fetch learned to opportunistically set $REMOTE/HEAD when fetching.
However, this broke the logic for the `--tags` flag. Specifically, we
now unconditionally add HEAD to the ref_prefixes list, but we did this
*after* deciding whether we also need to explicitly request tags.

Fix this by adding HEAD to the ref_prefixes list prior to handling the
`--tags` flag, and removing the now obsolete check whether ref_prefixes
is empty or not.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/fetch.c  |  9 ++++-----
 t/t5510-fetch.sh | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2a36a5d95..e7b0c79678 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1699,15 +1699,14 @@ static int do_fetch(struct transport *transport,
 		}
 	}
 
+	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
-		if (transport_ls_refs_options.ref_prefixes.nr)
-			strvec_push(&transport_ls_refs_options.ref_prefixes,
-				    "refs/tags/");
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "refs/tags/");
 	}
 
-	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
-
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport,
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 87698341f5..d7602333ff 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -189,6 +189,23 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	git rev-parse sometag
 '
 
+test_expect_success 'fetch --tags gets tags even without a configured remote' '
+	REMOTE="$(pwd)/test_tag_1" &&
+	git init test_tag_1 &&
+	(
+		cd test_tag_1 &&
+		test_commit foo
+	) &&
+	git init test_tag_2 &&
+	(
+		cd test_tag_2 &&
+		git fetch --tags "file://$REMOTE" &&
+		echo "foo" >expect &&
+		git tag >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	cd "$D" &&
 	git clone . prune-fail &&

base-commit: 3f763ddf28d28fe63963991513c8db4045eabadc
-- 
2.47.0.338.g60cca15819-goog

