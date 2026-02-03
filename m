Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AD314B62
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119777; cv=none; b=sszi3EoQqwjrUgO8FipTSOxFLLeY7FZlYTHH0npj6AuNWmXIrZwZJjnl512K6W4Hvy7ZIQ01LSyR5Hcu+bCQxZ4y8GIr24n7KXiU2wdxD6jV1wZP3ow1o0dTgq/EDZFAznfRyoTc1q7phr2D27azb2w1lc6lqeXsj3iHG+RLJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119777; c=relaxed/simple;
	bh=DJ4hrE546VxHzDypzTev70FvedjQCRkD8bQ7sL7tDKM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hSpE01ISi0EbOuKlRD8InGB+4XFHoyvypT/JRjSVKBq1nKQb9hcPeOftUJwmaNgD0SHOtsMXX1ZQyLMoXpJtJWw0199nhvVjEKrX4UdEtcQdxMzVleTMndzCHwCK2b8L6VbGyhwAOtjG4DtK50MkzK3pWMIwxI/bNQBs5pt2FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoDpQHnW; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoDpQHnW"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9741061eec.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 03:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770119775; x=1770724575; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRj4Qj4A+yJmZ4nIh2cXhrCBI2Ti14NsXRZg8Yqp4mc=;
        b=LoDpQHnW3yqsHtDba9K+ETGWDK43gnfb8TwXRkXt8OFRLBJ+9/rpkSod5I8jWthBO/
         erwYt1dy1X/8ZI14l1dOStWNqHvukE8j6Y057j0bDQTh5F2wupzSoGtqECREhZMUqweV
         0iSh9ZsninNzMOxhK27QtUVgU4JCgzspW7A1EbegzWUo4picG2z+Qjx+CWvO+6X69cVy
         h/U3OMbIvdOvV5LDaxofxzOM/yix6ntzU6Z3qRqC8ETBrcv1whdqzNSbSh9ZTmVGEuKU
         cb1PJ6RHO4vKbgy+01Y1xIxfFA8zxT1i5pau1nrbKp9q1J0bkS7MaGDr+Ik7tj1yXWtr
         oo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119775; x=1770724575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRj4Qj4A+yJmZ4nIh2cXhrCBI2Ti14NsXRZg8Yqp4mc=;
        b=puFoBxlFhxiP7LrvJQTc8ceTBZvgnTqNiUfNGZ2rK2Lz3zH+QauIFpxH0llKR3B+rw
         dm7r1u4M1mjQrYUlGrBsq6vW3s0qng+ndtA38RgXQZ9+FtH4V1XkJM8iFaB7v0Ob7i10
         26UX6IFiSFwqEYA0v2o3wRigbJ6Y8FUASxV9RF6ql661sj8MtuKJwNcKpDV6t8JK7UHA
         KPHopENKrjHV2npmEGk/tawL+Iw3nzRaznPord+t91ToD9LpRlOyk/JIJpFp7MeM1U/r
         YPfu0CxJP+NX4lHoYpxi8sRUx2J6VynTu3QV4mwTGAhs5GzOxCSqxxRMnY9gfsnjXudD
         ts4g==
X-Gm-Message-State: AOJu0YysH97rRcwKRdNYWNqigG/sTHHeGvtZq8fn9/4K0OIsJ6ZP4DpB
	CIZh/XeSOcZiFHhKYN0/wtA/yDx1DB5osK6yMVxYLJkynN1OF3nDUgj24TpLrg==
X-Gm-Gg: AZuq6aIpuX1K4tHVwSBA/mCX154Jn+E75EnR3aWeyvcOkzJcOtQHdYfxAwoyEJ9xF0q
	5V5/qw6qkkqJNfKWBdi9DGKShtmILwO6gRIMEq/AzYeslXsmgLnZk+kFip/lUcsSK/NtMW4tC5U
	3cve78QtMpSTp42r9aVSgQnhLAmLIzMjjhDF9f/XhVHcVHl0PTXHZU6hqEnzvn9YDfSCDiG1pyt
	488Yfa7sLsh3ZJFSO2AjqP/ceTP7KHri9V5halIxO+myWyHl7h7Xmltpm0zxH4eM8XMlu35Ax02
	EYt1aoKwxjaHRmM5WU+m5pFU5PvybprISwDVJNFm3INu1TOcm4e96GlSVUBivZW1OebNA3wqbui
	TOAlsfVJqhno9y5w3fBFB7unP5tQFDFp4zjQDlRDYpzuMVGz+B/iqL8iu+9btpgidcPfUQATZ/G
	1CQYHIzjSl0MN/qiWKcgWO8OQGxw==
X-Received: by 2002:a05:693c:6092:b0:2b7:fdb6:ccf6 with SMTP id 5a478bee46e88-2b7fdb6e72cmr2554429eec.14.1770119774728;
        Tue, 03 Feb 2026 03:56:14 -0800 (PST)
Received: from [127.0.0.1] ([172.182.201.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abedcasm22107129eec.21.2026.02.03.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 03:56:14 -0800 (PST)
Message-Id: <pull.2185.v2.git.git.1770119773541.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.git.git.1769937818682.gitgitgadget@gmail.com>
References: <pull.2185.git.git.1769937818682.gitgitgadget@gmail.com>
From: "NitroCao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 11:56:13 +0000
Subject: [PATCH v2] clone: fix segfault when using --revision and v0/v1
 protocol
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
Cc: NitroCao <jaycecao520@gmail.com>,
    Nitro Cao <jaycecao520@gmail.com>

From: Nitro Cao <jaycecao520@gmail.com>

When `git clone` is used with `--revision` and the protocol version is
v0 or v1, the client segfaults if the revision does not specify a peer
reference (e.g. `--revision master` instead of
`--revision refs/heads/master:master`).

This occurs because `update_remote_refs()` assumes that if
`remote_head_points_at` is set, `remote_head_points_at->peer_ref` is
also valid. However, for v0/v1 protocols, all references are fetched
without filtering, and if the revision lacks a peer reference,
`peer_ref` remains NULL.

Add a check for `remote_head_points_at->peer_ref` before dereferencing
it to prevent the segmentation fault.

Signed-off-by: Nitro Cao <jaycecao520@gmail.com>
---
    fix(clone): segment fault when using --revision and protocol v0/v1
    
    git clone command would segment fault when satisfying the following
    conditions at the same time:
    
     * Use HTTP protocol v0 or v1 to interact with remote servers.
     * The value of --revision doesn't specify the peer reference, like
       --revision master instead of --revision refs/heads/master:master
    
    When using protocol v2, git client can use ref-prefix param of ls-refs
    command to fetch wanted references based on --revision. But for protocol
    v0/v1, git client just fetch all references and doesn't filter them. In
    this case, the value of remote_head variable is not NULL, which leads to
    the value of remote_head_points_at not NULL too. But we don't specify
    the peer reference in --revsion, remote_head_points_at->peer_ref would
    be NULL. So git client would boom when update_remote_refs.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2185%2FNitroCao%2Ffix%2Fsegment-fault-with-revision-param-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2185/NitroCao/fix/segment-fault-with-revision-param-v2
Pull-Request: https://github.com/git/git/pull/2185

Range-diff vs v1:

 1:  f75b1f7e2e ! 1:  b3ab27f977 fix(clone): segment fault when using --revision and protocol v0/v1
     @@ Metadata
      Author: Nitro Cao <jaycecao520@gmail.com>
      
       ## Commit message ##
     -    fix(clone): segment fault when using --revision and protocol v0/v1
     +    clone: fix segfault when using --revision and v0/v1 protocol
      
     -    git clone command would segment fault when satisfying the following
     -    conditions at the same time:
     -      - Use HTTP protocol v0 or v1 to interact with remote servers.
     -      - The value of `--revision` doesn't specify the peer reference, like
     -        `--revision master` instead of `--revision refs/heads/master:master`
     +    When `git clone` is used with `--revision` and the protocol version is
     +    v0 or v1, the client segfaults if the revision does not specify a peer
     +    reference (e.g. `--revision master` instead of
     +    `--revision refs/heads/master:master`).
      
     -    When using protocol v2, git client can use `ref-prefix` param of
     -    `ls-refs` command to fetch wanted references based on `--revision`.
     -    But for protocol v0/v1, git client just fetch all references and
     -    doesn't filter them.
     -    In this case, the value of `remote_head` variable is not NULL,
     -    which leads to the value of `remote_head_points_at` not NULL too.
     -    But we don't specify the peer reference in `--revsion`,
     -    `remote_head_points_at->peer_ref` would be NULL. So git client would
     -    boom when `update_remote_refs`.
     +    This occurs because `update_remote_refs()` assumes that if
     +    `remote_head_points_at` is set, `remote_head_points_at->peer_ref` is
     +    also valid. However, for v0/v1 protocols, all references are fetched
     +    without filtering, and if the revision lacks a peer reference,
     +    `peer_ref` remains NULL.
     +
     +    Add a check for `remote_head_points_at->peer_ref` before dereferencing
     +    it to prevent the segmentation fault.
      
          Signed-off-by: Nitro Cao <jaycecao520@gmail.com>
      


 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..ba8de92563 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -558,7 +558,7 @@ static void update_remote_refs(const struct ref *refs,
 			write_followtags(refs, msg);
 	}
 
-	if (remote_head_points_at && !option_bare) {
+	if (remote_head_points_at && remote_head_points_at->peer_ref && !option_bare) {
 		struct strbuf head_ref = STRBUF_INIT;
 		strbuf_addstr(&head_ref, branch_top);
 		strbuf_addstr(&head_ref, "HEAD");

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
gitgitgadget
