Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636B287515
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666674; cv=none; b=kpOg1Tru1pCkae3kZ18nYcZh24Mpdjic1tNoi2/GLniBHM+BHCS16Ml1lMKx8l3iD7P2Bc30ywfjduFBoXbJKr4rLZF81sdxj4SM6YDYKRCuaHlno5saIDDHFtgUXhsj0h8U1En692FrJGmANh1jfW9zOL2l0z3yujnO5sw8oLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666674; c=relaxed/simple;
	bh=MgnqAVjrJWmNjYbSYDE32sohd+DyxTiVMTXuohMwgP0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qX04BVtO+eLzI/gRhaJVgOqgyguVKKihstXO34dfBNpIN3zmWnMNLZqhdBWuwLD7oAyplD9m7BEXSwa4wTIGtvh8o/pZBk1dJuVe7xP3au03TFKUPXv6GhMY3SumOx7ktI2p2ncXK7hs0qfvxAjQHDjGTbnXoGhVZbcD8J+kxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZcauyXM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZcauyXM"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af949891d3aso316800266b.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666670; x=1755271470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqTB8kZd4pnlbwQWGuDIghXQrdDW26Q5y8G0y/ld43Y=;
        b=lZcauyXM/Z/m0nJW2yIjB4WiCSR2dbsuIbVD9g3o69BLK0N4XoLAJKUDBJtSiSkVRH
         sigfpdkJY48uKVwhfAiNyzpBhKRy7nj6/cFYHC4CxN9p+Txu32Gn8Ajnbs8AVwlP1OJR
         c34C723McBtFX4Rs9sS/LiTq/Yz9y6LIa6GTiP0Q+x/EEQlhjTeG4Rekab75AD0gOBWu
         AeX6Bx9yKcoDxlgQrAb9Muy5NR0rBtj2TB4cADRm8HLro/MKXb6JiNS2OLr5U3ho6ONo
         RZxuHBLFi/LljD5fZOiBP539zaRuoxNZdFjEe35Y8T4K+t8hk+MrOD6KoXp2BYV7t+/w
         FUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666670; x=1755271470;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqTB8kZd4pnlbwQWGuDIghXQrdDW26Q5y8G0y/ld43Y=;
        b=wBKbVbyCTGExfxaFn1C/pS85J7qHACVSoidD11+1DgJp24O+tuzk1FpHv3Nhjf6OZl
         If/8xl9Ea19uqYNv503L1SXU+jQifo5erKmFrdpQGccU75u1CncsmgNDiGEhKnMcEIK2
         BUVFjPjBK+kbUSYRyJeC1YPxNFt0FAwsbS6PgOkqVNIvHC7aphngvLhp8rF/6T/zse5R
         6P6zKoQsyFWKxTLm6FfHGtDyxv89Xq7Cw3RPi24qea2u1cD7thdiWbFj+9iej7zmnpN2
         kqdi+3d5o92osVUCbBlBnVaM5Qy1IMB+2H3J02184XFegqH9QptD2NBtx6ydkx098XxZ
         aIvw==
X-Gm-Message-State: AOJu0Yx4LMoQdP2U6OPYABLoQaRtPmvjUltKLn86psIVtvlywGFHPE3K
	4pS2vQO1HxUqr+yR3483nB/EkhIFZZ53WTByH2wQBtmVW1OvaVfQmgKmSSUZMw==
X-Gm-Gg: ASbGncuutXCNbO/raKGly2w9tTGr7uRB1oDVblxZYfQXAzw1JSbUZ6ZbJuQPhbYCuTp
	3R7FcubWOR1msr/rcr96xQuB0EGN8ivtWUerkOXL9tGYARHPXPZhlG57Du9kIRMrXb2wFdeA9Mj
	V6+HFjRMnHNJKta4YQJ6RKT3aW/EaYZyeIJxxS/ivfKpTkj4jJOnUuKe7o+ZH4yZHGzime3UmYs
	S3Rx2+lQV0Hwp1+kK7+ex1djLzBLQPkxoTuSSTdWoo0C1y3Jga86GuOZ6IMCh7OjGVHmAVc7Lbg
	gX7tZS9O/V0QuzqHfOVN/Wgpm0WMj+RrOM5zFUR3uvnj4C6rEFxVSgfQlyQFbgwBDO6oNW9SZ07
	CZcZswyd0BnQVWvKXlyd1gBk=
X-Google-Smtp-Source: AGHT+IEaOVsxFoyRztjMlvTbPUn7AYCLx0RhYH+fjEs/4b4odn+UVH4QEkzGuTTXzttiiyY3HfIxEQ==
X-Received: by 2002:a17:907:3e8d:b0:af9:116c:61cf with SMTP id a640c23a62f3a-af9c64d27f8mr343996466b.43.1754666670009;
        Fri, 08 Aug 2025 08:24:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21e44csm1499208266b.113.2025.08.08.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:24:29 -0700 (PDT)
Message-Id: <7d4dc6d2c046aa33497f1c485a2022c9896e051e.1754666665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 15:24:25 +0000
Subject: [PATCH 5/5] doc: git-rebase: update discussion of internals
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- make it clearer that we're talking about three steps of a process
- delete a duplicate explanation of how git rebase skips commits with
  the same textual changes (it's explained in more detail a few lines
  further down)
- move the `ORIG_HEAD` note down so that it doesn't interrupt the
  discussion of the mechanics.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index c63d67f340a0..6b79cd0daca9 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -67,18 +67,23 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
-All changes made by commits in the current branch but that are not
+Here is a more detailed description of what `git rebase <upstream>` does:
+
+First, all changes made by commits in the current branch but that are not
 in `<upstream>` are saved to a temporary area.  This is the same set
 of commits that would be shown by `git log <upstream>..HEAD`; or by
 `git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
 description on `--fork-point` below); or by `git log HEAD`, if the
 `--root` option is specified.
 
-The current branch is reset to `<upstream>` or `<newbase>` if the
+Then the current branch is reset to `<upstream>` or `<newbase>` if the
 `--onto` option was supplied.  This has the exact same effect as
 `git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
 to point at the tip of the branch before the reset.
 
+Then the commits that were previously saved into the temporary area are
+reapplied to the current branch, one by one, in order.
+
 [NOTE]
 `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
 at the end of the rebase if other commands that write that pseudo-ref
@@ -86,12 +91,6 @@ at the end of the rebase if other commands that write that pseudo-ref
 however, is accessible using the reflog of the current branch
 (i.e. `@{1}`, see linkgit:gitrevisions[7]).
 
-The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order. Note that
-any commits in `HEAD` which introduce the same textual changes as a commit
-in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
-with a different commit message or timestamp will be skipped).
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget
