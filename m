Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BED37DAA9
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547239; cv=none; b=X2AMTPDHtsygeOlpPt9XNgQwfj3+zMtMLAmYUoUKncFtlI7/6sg6WlzkmjpIagNAj4CzWz6tp/FJ2tEZbLVEX+udH4GOT1ymMSQ9vBAnyn8v9kQmrmBu6IOHd8NGptW+oRHoIOFAhn0tehpATkdDd3vJqTaWBfJ2+dMbpVYTY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547239; c=relaxed/simple;
	bh=C6JX9wsLLRNOqiqJP/NAqPm+0X0+uzt4nKcGu+4WlNs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oule/2LOXdP2qL5bw5rYKH6faHyeuKqsqzFxJ/flBDDdwlOZ2fsahUrWcf4z90z9tJA0yIeag66WIEVaReZvFgjFO9CdvYBGp8bQ+FQjNPr/3T3+2Gx7FlwNjXw/7gXiCEPIz6YHd3jrw5rA3hxFE6FApFkgBTbnwy+3XF5O6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1zGiRbK; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1zGiRbK"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-825b40f8a26so1938530a34.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547226; x=1792152026; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=C1zGiRbKil4eVMJEoKiZcDMiQtC4PXkLh80nzQr72t84xdL3CJ/BaV3BFhL2DNM4vS
         IrDVpNb4rtNuprprquYeljS3tO5LiqBkKURo1IJlEQpdAH/XHongy0C6UeE3iTv+XBQC
         53I33EywpGyhaL0s6A7ZXVJOacwtkKvjgtwNPXKwU0aWtmpjFqiMBjBBZoA+aLPRNmvk
         uKVYDIANgSCG6JkXbJR29D+8oj+DxaXWf0fuBPjP5k9W6HIsoX5u7C4yqPOwJECBiO34
         kC9m1M2Xo2iNtnZjTSYIWwLGnkTVnqU6eXUBwD79E/wQ279uQMrw/wCy3pvhB7uKX7br
         0BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547226; x=1792152026;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=WrbtWdVaD1zdeNvLPtHKYj2XCxE6nccjzZ6eyYJh3Np+Vfc+GuXnUJHGtesTjmql7V
         bj9GDaCVVoMLbV/Gqx1Atrvct55io4PWF7lNRe+neLyFkQX9cRkCQ6cFijaQiPlv02u9
         4yM5ZjOsmwNenUwSvE/oC91Mep99pVCrBrgzeE0iBmp2inNI5T1PKXbfhjtR0/J6HoqV
         JXiI0vmXL2JRrMPeIY8PqANDmRwkHC40NFvHf3oLskFEYBrMRuOQ+8MtGx1FmCSenCq+
         CU1v70cszpxMl/Id5OeblDfpXI+BoBl3JnkHpwtQWCK7e1NrXxSSYCVueWXWhw7e3omJ
         0d6A==
X-Gm-Message-State: AFuF++n5yiJ8CgzQu1vu5djVw+8kFj3qYwYDpvDiU4yj926H9Cx4dFIP
	uVYJfG7kTw86dYDGt71Fgpzt08y9kwkc1/oQnbU4cJcPpf2PqxmANnb/QO7//Q==
X-Gm-Gg: AYBFou0tKV+w6VLp0/eLorowfRbP5EXV02apHpN1jySVnetlvDktSd8mVxGLtk6PyVi
	KylRBR9nDdho041nM9Qj2Dyrk/X8f2zAUn2EddmckdU4XTFlde5vmI2jO0wLg6XnvwBUhm9X9qP
	nat+Q2fPh5NJj2QNRU0uzbuEMSgajTYS2ekEE4ZeCxXZMZ5eKn+KoD+ymlpVpN7cSaRg4G6bh1+
	/I4wsQ3av2LvdXSYvp+T40x39rMRYgA5DS7HU8s/I83wEZ49GaxetUSJBC5rKuFf14OgS12dKiX
	//3FPGyvaSbaQTV/CXp/xn4Ub8DO1tVWFUTuptDc1qtrseIqYWC2U9aHmcvo1HnxuM73QrhjDeF
	OvYu6Cu/HIB5HsFxKD/hk9OUO1ADZxiyHotictBd4Qizi9CuKnf8FkT3fOvnVUtHMxnkuiLAeKi
	OlDAbjfllidxp9XCPOI5cBs1QnVG/oG1Nu1f1cCTb6XNPK/T9utCkc+l3ctXoKCCN3nS5GHIYHH
	mc=
X-Received: by 2002:a05:6808:4fe0:b0:4e6:76eb:b997 with SMTP id 5614622812f47-50c59399cb4mr1511863b6e.62.1791547226032;
        Fri, 09 Oct 2026 05:00:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.148])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50bfe56242bsm1731860b6e.0.2026.10.09.05.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:00:24 -0700 (PDT)
Message-Id: <72b12070455aaf659eab049571451d1369a1d804.1791547213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:00:10 +0000
Subject: [PATCH v2 3/6] doc: git-rebase: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove some of the detail about how to handle a merge conflict, since
it's explained in detail in the new guide, and there probably isn't
enough detail anyway.

Leave the steps since rebase is special and has a `--skip` option which
the other commands which cause merge conflicts don't have.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..da70aff498 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -46,10 +46,7 @@ If there is a merge conflict during this process, `git rebase` will stop at the
 first problematic commit and leave conflict markers. If this happens, you can do
 one of these things:
 
-1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
-   and make edits to resolve the conflict. For each file you edit, you need to
-   tell Git that the conflict has been resolved. You can mark the conflict as
-   resolved with  `git add <filename>`. After resolving all of the conflicts,
+1. Resolve the conflict. After resolving all of the conflicts,
    you can continue the rebasing process with
 
    git rebase --continue
@@ -62,6 +59,9 @@ one of these things:
 
    git rebase --skip
 
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a full guide to handling merge conflicts.
+
 If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
@@ -1284,6 +1284,11 @@ include::includes/cmd-config-section-all.adoc[]
 include::config/rebase.adoc[]
 include::config/sequencer.adoc[]
 
+SEE ALSO
+--------
+
+linkgit:gitmergeconflicts[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget

