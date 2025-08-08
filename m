Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EC27A900
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680533; cv=none; b=J6l4QIZuxaSHuAJCMjv1Bkarc6my+rHSiOF6cCn/PUc7ke1oWkCwgNKbMCYuSD3qck2QYuEIpyxDfrSiOSw0/PacDjSothIprNuNFXXczfZlJJ7pOtnkbU7ygWFLro/qIlnMAwsamSNQdoUN8+OUOLCfTGXK8eJ1/HOe3BAvO0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680533; c=relaxed/simple;
	bh=qBfD6NP+wFmAjizQuzBXqDgeGPptOtu6XsrDOLTtAK8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IzGaWWwEbj26KLdcC46GdPrUZrZlc0hQNmG/U0FGUyXISxCYcwIBa4FdDxW0+ADNJ/uYasB9hD8awcXvltL16mSZ8b1NFpHsyCCinCxEZxSff8KSgO7QqwUFwVmdf2LEd+alFSAwqgjkA64234GrIQVTTZ4ni3Wb0zY+3e9OhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm4ApofI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm4ApofI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so12977085e9.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680530; x=1755285330; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny/yFKVov6e/Qv52lxTmLxsJYzy8BYrlAOHv5FbfKbQ=;
        b=cm4ApofI0aXC9Yp2xaL7DTLsiZXRXEssIfuzgu/Nk+VfzlV7Iuk5ZFsu08iEmDVQVQ
         thRBlgVbeTMPQ4Cm9OvhKL586YaxMBRppgFmb721F1J2esp1YHlrIB27su3Yor+ytZcw
         lANqZ4wOxtBcUdRTp091ixmj1/tPAcNkGa79GRVWrDtL9Z02ZxO+PQsHbOweR5l5SR1j
         S5qJfodQoQpqJ2d7J/DczH4dDO9E/NQr5iG+29RZNBNjJ9uY16hPmZGTTwtJiF0BFsDJ
         +uitMmy8gPJBJkKzgQTA65ewEKLBsJUXq1DEJ9m0w1LPBKuYL1c0QFA7wzt4DbiQUMzs
         pLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680530; x=1755285330;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny/yFKVov6e/Qv52lxTmLxsJYzy8BYrlAOHv5FbfKbQ=;
        b=kCoacAwSSB1oktfhVB7wbQCW2OzcFNhq6Wa2OmDXPwZ4KbS5uKx1+8EwbrieeHM9ar
         rjVmEXMxqmXTdnYxlwBPatex3fsdS6h3bocRiDqsMS8pAsDsd/Ce3niKmti+xUolwoJh
         FpvvPonuo4c3W1Yk6cw+HXTIG7f6e9sV4jyX6QlC86aMCB0V9PRmW5FCpMtspLGxnTPg
         /2nule5zZ3mwDNFngLKkafg3cfk5GVLc9HiyJMj6t66xlXZDzuY8dBrtJmMJ4I5jZ6UP
         C9UseUTcSsEaVCyoEIYIyQKrQOmhBV926aa5nbafSDK8G1rwTGqjE4Qikyko8UXxpkjI
         X2BQ==
X-Gm-Message-State: AOJu0YxjN/BMYS+yPB/Cx1pUf9yLuGbEWttzPier49PsfBHUaYy4MnCo
	4Ob4Pims1z7voux9i5+3X0tl8gUYBGtO00YHU0sMkjDFdxcx9THvXRntDGdVqg==
X-Gm-Gg: ASbGnctEeZVIJILjhX1EcsvtVmp2yne2cOfmQN1DjZBq8bLW+0G0fniDzBjylnVG6Pi
	4JwPuuv9M1p24yEQb/v8xIWn2p+IgRzToBKrZgjC2T+QdSc93QPlzf4Mqalt53kz0RmCx6ottBw
	WdelHheQd15Z6bC3iY4Z8UBM5PuUnB7L/i2vGyRXossmWyZI5k+1lSljp8JUEHedMhVA5DAat9R
	QAmgqBkYRgc75Hm7x2Iil8cwUft7LxIvNMC86uUl5NZMfyzJV/DomQV5Y/494O7pHuTab7cUu/J
	oL2+hStOhLNR430IrDd+LR0a4cTK7gLLzrThpd3BGQIMuuO1ABeTj3BXoOWNPxs4JvyrPKzzKPG
	yKI+RH+Y5yX2qk6B2IPRByxflr404DE9IQg==
X-Google-Smtp-Source: AGHT+IF2kkT5++ewnz2Rxt0KpxTANtqlJNS+UxvEjFbjdzfduUwywATACuI1sPpbP7W2UglMkOyAwQ==
X-Received: by 2002:a05:6000:26c8:b0:3a4:eef5:dece with SMTP id ffacd0b85a97d-3b900b4db4emr3582885f8f.35.1754680529709;
        Fri, 08 Aug 2025 12:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0683045sm22102295f8f.41.2025.08.08.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:15:29 -0700 (PDT)
Message-Id: <ce7ab74ea0fc0719d66a53c3a1666be2371adea5.1754680525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 19:15:23 +0000
Subject: [PATCH v2 3/5] doc: git rebase: clarify arguments syntax
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

This removes the explanation of `git rebase <upstream> <branch>`, since
it was already explained above that it's shorthand for `git switch
<branch> && git rebase <upstream>`

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index a93c616f38b1..e700b92e35ac 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -59,12 +59,7 @@ one of these things:
 
    git rebase --skip
 
-
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

