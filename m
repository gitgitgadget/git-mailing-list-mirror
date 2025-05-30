Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAC2AE6F
	for <git@vger.kernel.org>; Fri, 30 May 2025 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748589761; cv=none; b=hCf+SFcFRzaaVOX5LeCiFmG/4bYbJoVo9n0CAeZDJB8lG5PeHvSu4bbpXSvOemFa34qiwU3i+umogs2Lpkr+n6LTGP9hLkp0Evr9DN3hLsywWWtNeeFLrMBBYKOu8rOFTSS4zGP/oWyYRzA0mQfKXIiczhjPUE9lP/JpGutavr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748589761; c=relaxed/simple;
	bh=3W2+6gZy+CkUmrBj9OgdKOzrKAjzPe4f3/rDtnzFuz8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=McrC0etuQTirGipopi9I92avfs1LL4zUnF9cv8lfNXEPjrbpExtTjaDL22b1RsKdIwAojvs5vlyZkzdxGZaWJkS3KeGpjw09/cjw8un3nJsEQb3amx52h2sWh2D2BsvMjfDGWQOgcdt4PKwegSiYsiVPqdXt2qhQf8f3R43azLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBQWxrAJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBQWxrAJ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so10762605e9.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748589757; x=1749194557; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSAO9KgxLSBOAqO1/q3koLjb3b7FahGTO0ryCcKvdgI=;
        b=iBQWxrAJjo5bWqjFEqQoEhWUdCSdQMvek3wSV2EFZXECLmuhpIDycNhGHvo1BNmj2a
         Y8OCQgGdhowbpoF2m3ZBxoNvjGILrM4qYP3NnOEJmKIfo81dGN4kGzUvYnNvNdL0mFZ6
         8S080shZ9Mr0ntPV4L2oxTmfJwf8flDvRHw6HWM2HPGTUUZrMszses/lk2LJrBSlHO/6
         VMBvunycpwL03VYhXQpfs4TU010014KpkdZLYnzxbvbW9YzqBrp17XR/enLYQZNrKssL
         P1FNFZZC4SnSZOTwwTlCI5kFMrsRV/8vQjL9FuBxNESRSZy3vNq+u/ggmE4s908tfBWl
         grWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748589757; x=1749194557;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSAO9KgxLSBOAqO1/q3koLjb3b7FahGTO0ryCcKvdgI=;
        b=gQTksphiG5eWyXDkOzf89xwJ8mrjoSEk+1yIPBstGlMjfL6bGSpG1w7JvX2Ws880ak
         raWlowqNS5XaG+Oy3Uij3o4MaCCSRvqif29sG7Jx51mAvD4R4P7PteapgCQ3FnlpgveF
         bVNT2Dlut8QWkVc/z+qm5lNjZPTlTq6+a4eTGr8i4dAhUqTfOwXmw5GV6foD58tPHRKm
         zxhk4Mml5obgizF7TBAb0OW9Rbe3PA7NaoA86UsSYMTSoQaiKhpgtOb1B8VvtF9y2C7V
         YbKIlFSBV8XhSnjMbzGnacl6T/NvECfBQ2/xbQsWvfRUvBlfvxyspczYY4m4+UN3bP31
         gWtw==
X-Gm-Message-State: AOJu0YzWIBVTaXCYy9kmjJkx+ABSU3V5jNVJJ8hsMqVkTEf89IbkhUC7
	/AnMkjsVen/ptYy9e4BijGeAAG/kSAo91hv/1xj0O35/uKZMC+YyMpncxsQ9bA==
X-Gm-Gg: ASbGncthXCox9Z18EcjUo0wXaOSh/iyrWm6EYET2JuTUynf1UMopwVnJw4kyoXoHdxL
	7+b0vTE72sJBrIfaacWdJgY6tPz1y/PkPFlK40699cC4J1EcZjpFA8wqNLXhrzsxLHgvLddpYFS
	fLNBQhFFjYkHBS4WDQx6o1/hn+Xo1pZJLHqSP+/pHjwuu2kY+EFd3fqhN50/ahKgy1CRf8DqZfa
	M7DbDs0P6iMNjROecIjjpv4HbTWKyh1b//IDOlaWg5VnQrg6Licc/5jhar8ZbH43bmttuMO9Vo2
	F6YtgL9E/laKc+hked8tkEY0gXBjk7ClUJmsBDO/0mA5ZcP/IRDfi/EDt+upl5Y=
X-Google-Smtp-Source: AGHT+IGGwpw6Uv8MpPaCoqlySAxWYgUGvH9yOXthlxlJfaU9r/iQWFnKYHANs7NXFbvJgOGdogEADw==
X-Received: by 2002:a05:600c:3657:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-450ce8189b3mr39967345e9.3.1748589757356;
        Fri, 30 May 2025 00:22:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009fdbasm3944183f8f.85.2025.05.30.00.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 00:22:37 -0700 (PDT)
Message-Id: <pull.1948.v2.git.git.1748589756289.gitgitgadget@gmail.com>
In-Reply-To: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
From: "oneee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 07:22:36 +0000
Subject: [PATCH v2] doc: sparse-checkout: use consistent inline list style
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
Cc: oneee <kimww0306@gmail.com>,
    Wonuk Kim <kimww0306@gmail.com>

From: Wonuk Kim <kimww0306@gmail.com>

Fix this inline list to use a single style, namely numeric, instead of
`(1)` followed by `(b)`.

Signed-off-by: Wonuk Kim <kimww0306@gmail.com>
---
    doc: sparse-checkout: Fix list markers
    
    cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com cc: Patrick
    Steinhardt ps@pks.im cc: Eric Sunshine sunshine@sunshineco.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1948%2Fonee-only%2Ffix-sparse-checkout-doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1948/onee-only/fix-sparse-checkout-doc-v2
Pull-Request: https://github.com/git/git/pull/1948

Range-diff vs v1:

 1:  c702bbc8782 ! 1:  6154158b98c doc: sparse-checkout: Fix list markers
     @@
       ## Metadata ##
     -Author: onee-only <kimww0306@gmail.com>
     +Author: Wonuk Kim <kimww0306@gmail.com>
      
       ## Commit message ##
     -    doc: sparse-checkout: Fix list markers
     +    doc: sparse-checkout: use consistent inline list style
      
     -    Changed the list markers from a mix of "(1)" and "(b)" to a
     -    consistent numeric format "(1)", "(2)" for clarity and consistency.
     +    Fix this inline list to use a single style, namely numeric, instead of
     +    `(1)` followed by `(b)`.
      
     -    Signed-off-by: onee-only <kimww0306@gmail.com>
     +    Signed-off-by: Wonuk Kim <kimww0306@gmail.com>
      
       ## Documentation/technical/sparse-checkout.adoc ##
      @@ Documentation/technical/sparse-checkout.adoc: sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to


 Documentation/technical/sparse-checkout.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/sparse-checkout.adoc b/Documentation/technical/sparse-checkout.adoc
index dc2e763bbec..8202172b70b 100644
--- a/Documentation/technical/sparse-checkout.adoc
+++ b/Documentation/technical/sparse-checkout.adoc
@@ -66,7 +66,7 @@ sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
 	reasons: (1) users in cone mode specify directories rather than
 	patterns (their directories are transformed into patterns, but
 	users may think you are talking about non-cone mode if you use the
-	word "patterns"), and (b) the sparse specification might
+	word "patterns"), and (2) the sparse specification might
 	transiently differ in the working tree or index from the sparsity
 	patterns (see "Sparse specification vs. sparsity patterns").
 

base-commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
-- 
gitgitgadget
