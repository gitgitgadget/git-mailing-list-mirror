Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706714901F
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612615; cv=none; b=QsN7rofPnu34czfxIysUsed/SBuCEbQNYAuip7PxBlCh9wf5aYNX3TXkMcGWyWbb6VmeD+YQ5Wm1GXyZR84RKSppgQvuIA2hEmBpVltBmzlOxO7BFVbK7lpbeewkNc5rlsGNP2am6xLrZRm1kkplKt7zbJnNbNSOOfiP8pUnIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612615; c=relaxed/simple;
	bh=QSb/Qh/k/jtO5PpkL3y6lTEdSq/J5NWkFsE0nmeVhaY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dHxbK6u1L1i3FqUsHyBZgh0KoWVWflmnqak4n65fmY2UxPRZbl3oe6UkluoEyn4FRjjhSaQ8HCq9LIkq9bWwjD4jFia2Bq0596vSMUZWw1D/4PFT6ad1ZSeJQYLh+H2XsDM3OuYTOpKQG8cB8UoOxZ/24PukYn+T56tGZ9CeAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeEkghhW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeEkghhW"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d220ad10b3so75148751fa.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612611; x=1709217411; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2HklqQzwQdN85hogz+D0Bk5KjHPdNYbw/bviEKo8cw=;
        b=CeEkghhWb2VStuo18LVW64J4q3XjJlVU3OOQ0IBNmtf5ZYJB5z6Uy4RDdEixm4entA
         GQ6hTzKwYzBq4guriQ06Y5YYFc5wV6TFQI2j2oDzvTqwKJJ+sMkevTR2kovbH+vCqfsT
         DiOKfKgMNaJIIL3qrQWrJgxVN6I4CVKsbKKsNn65ADMiCj9LbqHoY9/hGMq8+iVumCSg
         Nnrtj13dY8puLe5/ugeA8jAvQpy3+NLFA+C5aeklHbk9GH1tKuQSpj0xT7JY7ldUppAb
         8LKSEdhL0wgi4vvJ3tykYdaqixSCJHna9SwSBtAkQWAA4cSVu+MgZZsFiYVvAwe0cVei
         4LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612611; x=1709217411;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2HklqQzwQdN85hogz+D0Bk5KjHPdNYbw/bviEKo8cw=;
        b=YdHUusXo4SOwkxA0dFsU4NYThhswSGJFwrS63HOTOE28eV6ec5pU7NXxu0h6a05Rfn
         cUa0gkQK+GnBIzM30kFVGmzUobtcqnKY/gPNu4IyChx5UOslQj0Thfux7N4EYWus58++
         bMhZ5vyI1jxaMd579jREQVKTQVYSd/kFHbQ1yG7IRITTCDIZvoqimZKDzXg8MyvpHFkI
         rXAlBzVkNEmYq10OfUSf5r5o58s6hH2thsdVR/sDunUL0X5GGL6gRR8I4v5huOhznkoW
         3vfGOc8n2jx7dWmWximQ59i63CvpFY4PW2gkDHFqNcm6M/KECVY+0fICujpeXkq/SxqR
         55Wg==
X-Gm-Message-State: AOJu0YwyWeAhO/gUvOSTgfpjoniQ6smAgAPK2qBwZbbppXY8jrQ350aH
	LtjBkNkRPXJuAT/xkLsLFwuF5iVri6M2Nbr5K//YGT7vWpJ5n+j8SrE++VCU
X-Google-Smtp-Source: AGHT+IHmRWqkZ/V88OKcKnlRebD9/DUwFdhx9+IDvfJwiV0+uEtXC2oOz/r56HfyZ1V2FBKI7wliIA==
X-Received: by 2002:a2e:870a:0:b0:2d2:35af:e8a5 with SMTP id m10-20020a2e870a000000b002d235afe8a5mr9006971lji.24.1708612611179;
        Thu, 22 Feb 2024 06:36:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b0033d202abf01sm5906201wrb.28.2024.02.22.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:36:50 -0800 (PST)
Message-ID: <91dc4ccd04e3a6cc50ed389edb6814e1e7a0c4dc.1708612605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 14:36:45 +0000
Subject: [PATCH v3 5/5] cache-tree: avoid an unnecessary check
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The first thing the `parse_tree()` function does is to return early if
the tree has already been parsed. Therefore we do not need to guard the
`parse_tree()` call behind a check of that flag.

As of time of writing, there are no other instances of this in Git's
code bases: whenever the `parsed` flag guards a `parse_tree()` call, it
guards more than just that call.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index c6508b64a5c..78d6ba92853 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -779,7 +779,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
 
-			if (!subtree->object.parsed && parse_tree(subtree) < 0)
+			if (parse_tree(subtree) < 0)
 				exit(128);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
-- 
gitgitgadget
