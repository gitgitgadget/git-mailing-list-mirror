Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF9423799
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925480; cv=none; b=jRJ1lCLi6k0sVWx1sUyoXJQnhkvDF+L5jWQxGxmnbzIUMtxsggQZLsDYTL45szROtm6wZpume17wWKMzQqcgobdSXffZz6J7SODGh5/8lkIlSR0fqcyA9173EDCZSSoclzDefLsps5h/MYK/CFU5dl8FKmgoXG35/bzXHvHuJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925480; c=relaxed/simple;
	bh=LoJOeKiZnjQFhVr1+LZOvSHT/9GmKPF3JMNxJbtNpEU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VNWywGVlerGumWVOVUemrQQRC/n0g2c+8noUi+v4GMD/AIB8PlOkYJhHnTBG0iM+1MjpNyhY96g8FabAOlLRl6sxHSGd833nN1/d9+jixflay4XwrsvM6SwQaFDwU+qL++ymG9062vEINu/vDqQQYApCiOL8CZaTKZRbATWj/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elIprX2Y; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elIprX2Y"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so6832086eec.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925476; x=1791530276; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oZqjsJX7EhXfUMjA7tJMODhGWI9NKY/NsNooEV/DVDQ=;
        b=elIprX2YU8jonMqEpOhhSiOaOTkeVywunLuPku403dTLvJZbHg+b9jVMMcq/XuD7Jo
         /4BpjXXlLHY5oaw2aULOeZT3Nv7L7kKGQ77N0VfXeM1eg8PKZ7MbmWrAIpFxG4OCk4Kr
         zCnLVx4p8KX8s4e71jmtO4WLaiwyID9Frdr573A+MNI1E3n2mAAlnzKgCe33web8mTbZ
         1IXAjceOP2updMkA2i/3veyKkuMOIBSjunur9PbJhbeDVpYKp1vZiufV6DGIunH+tYwx
         xd1G03LHUKnYMEMUkRYi72HiF+qZ2LQy9vJz09PBC6sHeLtgWBQax2XSFLSNZpf07Gnj
         uUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925476; x=1791530276;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oZqjsJX7EhXfUMjA7tJMODhGWI9NKY/NsNooEV/DVDQ=;
        b=ZhwYKExxyS41h224IQ+ra8++ixPjLg1BRBLhETIAoyVV0ualrnAiHUBHaC3eOKRuVn
         yrL/zGcZ4Zt07NK+xTM35mP9o15gcSqYIT49EIunmuK30U6J04wns87hDetRWE3GXCbs
         nWJCOv6Oe0+eSkcRv4KLTn95Sk74vMgrQLkhZyZp4tOKmXI9TQreNDGmBHSykhxKdjZt
         UVLStEi9KrGi4L+iK0GvsJLUP1/D2BDcZBxRmdjuWxLBM3Z0zEVIalvi+04N3DoLKt2J
         61zVtT3t8tz+PsA2uldnuKbMBLqlzaMvHDJtMCMOGvIm2FES/Ld4pL1sM2iQWb2U2RrT
         9hyg==
X-Gm-Message-State: AFq9FYIFLA7ipTGlUiOnCMHi6cV0gogZlB2ADoEOhuopylO6BET+j1N9
	77hjpeMaVY0dSjCCL65HC0Ca+TDCKH3KlRYu+S5dzmL0QXIpVJPiybrJMFl3ng==
X-Gm-Gg: AYBFou3G73Tjxb3sCjLRiicbwnLneBhljxsEfvdUhDP4qs3WqO4+IdJat8b8OdL3yd2
	Xg4YcO9hz8hw8yqT22Nv6ZBZcbq9XhcDjCSwYe8zvV+o0go9aGAB48gK6kS1ktjKagbZdcNBxnL
	jZNHojlQVlGeSSVaWI+GmZb6TzeHlP7TfF4/AEIQJ9XwLBaFjiQyyCKZaFYwPEEddw+XFwADgZp
	wcK4zHk5zKbbP+c4boLjxSrlxZbHEG6QxysNIJRhGzTvbj77bYoSQbf6aqjX9Y23VF1bxGvk87U
	X6OGKXue7j02MKigQQiz1lvV6b41L26puAMBgHoYUDMpjw9VvhHGj5ZTTHoMqkLTRD8DE68aAkT
	auXIwEi6vushc/BboEWqTbsAiidNVA5vYb0pyGn5Z6mCmrEK16SqWPIY10HPNRLDBYgM/7qiOgX
	+ms+Ontxp67okuVjsfSFlr82qH9WCNswl4Oj1U44Qjn/1kD9swDpo0MrQ4hzqHHNJYD/Z82zmHh
	XOfOcAbA0QuHZhJJcnhf/Q=
X-Received: by 2002:a05:7301:1885:b0:339:7572:7b2b with SMTP id 5a478bee46e88-34f150eeca0mr1635285eec.24.1790925475470;
        Fri, 02 Oct 2026 00:17:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35105dd1dfasm1717817eec.8.2026.10.02.00.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:17:54 -0700 (PDT)
Message-Id: <db46b1b51009ec2f9a61cc76f9a2835cd207aeda.1790925472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2423.git.git.1790925472.gitgitgadget@gmail.com>
References: <pull.2423.git.git.1790925472.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:17:51 +0000
Subject: [PATCH 1/2] remote: factor out lookup of a remote by name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

make_remote() looks up an existing remote in the hashmap before
creating a new one. Move that lookup into find_remote() so that code
which only wants to know whether a remote is configured can use it
without creating an entry.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index fe62068463..6567ec91cc 100644
--- a/remote.c
+++ b/remote.c
@@ -128,23 +128,28 @@ static int remotes_hash_cmp(const void *cmp_data UNUSED,
 		return strcmp(a->name, b->name);
 }
 
+static struct remote *find_remote(struct remote_state *remote_state,
+				  const char *name, int len)
+{
+	struct remotes_hash_key lookup = { .str = name, .len = len };
+	struct hashmap_entry lookup_entry, *e;
+
+	hashmap_entry_init(&lookup_entry, memhash(name, len));
+	e = hashmap_get(&remote_state->remotes_hash, &lookup_entry, &lookup);
+	return e ? container_of(e, struct remote, ent) : NULL;
+}
+
 static struct remote *make_remote(struct remote_state *remote_state,
 				  const char *name, int len)
 {
 	struct remote *ret;
-	struct remotes_hash_key lookup;
-	struct hashmap_entry lookup_entry, *e;
 
 	if (!len)
 		len = strlen(name);
 
-	lookup.str = name;
-	lookup.len = len;
-	hashmap_entry_init(&lookup_entry, memhash(name, len));
-
-	e = hashmap_get(&remote_state->remotes_hash, &lookup_entry, &lookup);
-	if (e)
-		return container_of(e, struct remote, ent);
+	ret = find_remote(remote_state, name, len);
+	if (ret)
+		return ret;
 
 	CALLOC_ARRAY(ret, 1);
 	ret->prune = -1;  /* unspecified */
@@ -160,7 +165,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 		   remote_state->remotes_alloc);
 	remote_state->remotes[remote_state->remotes_nr++] = ret;
 
-	hashmap_entry_init(&ret->ent, lookup_entry.hash);
+	hashmap_entry_init(&ret->ent, memhash(name, len));
 	if (hashmap_put_entry(&remote_state->remotes_hash, ret, ent))
 		BUG("hashmap_put overwrote entry after hashmap_get returned NULL");
 	return ret;
-- 
gitgitgadget

