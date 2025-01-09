Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929ED204C2C
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736458025; cv=none; b=AcggoIVyxWzzb/X//UWIwFTEe+hjXH6pDxztSpTX+F+yxMOnsYsW2p4abXjjKm0ZW1s9l88p9D49Mi503kibAorooLN17TK1pq8CJO5J0M9DSkmnqmM+GUh6gbPQUF9DdwQMPLwFuKHXXPEnrzymr+RgCO+fDO3ZLxDpZnICots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736458025; c=relaxed/simple;
	bh=aNbpcn4MiIZaczOY0gPK7cP2CjTknasw+eAUBlQD4hM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lnfyMxqp9wzh3FRuDfAPTIe746FkxRGRiPpCxwJD6w772MVWX3bGgJuZNyx/BvUeNSasMaa+jSclFRlVhtc8rv7CUIsYSKk3wLSRkGBl2lS9ehsMDrknF8ahYTrRo6tDf7XlSk08CAteZc1LZyVs+rs/OlGBhIQYT1ZsqGEaDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYRyoWt8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYRyoWt8"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a88ba968aso1295229f8f.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736458021; x=1737062821; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hcpaYPcXWcOplCsIZCja6oTuWVd9I3iDWcA9nFtejAk=;
        b=eYRyoWt8A0odROh78U0OJ57uj/OqPCGBP0mE+slMwPd4aX5DyCHp2FMIjZB4Sg31P4
         Elw083fCZKlIhUniOR1gk29ouNR8wlYB12dZEt7QE+Bsfe8nkSmYaER47sdrFMTRXEPb
         pd3HHGd6saZ+8ROoUUTJBuDjT1QaCCg7vy/kSq1hVgQwzFBy9maV3vtn1GAHjAOVxXKj
         2bXtgwXhqyp1XYTADYuqths3uecCZaimMlFbYFD3AkuEW6t2/nAiwXGFHGpzT6COLZ/A
         /E98l5gowpgH5hsxITAUSYkAD/kXwb0hGJt0W6jEGb17gTkGbeYs4DkgoSRwnTaeB/6P
         SyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736458021; x=1737062821;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcpaYPcXWcOplCsIZCja6oTuWVd9I3iDWcA9nFtejAk=;
        b=GqcVyL2G0TnNceOn1NUvFpVoxnZUte8GIh3vAWDDQRjwOMNFGUdOyCJUITwcHkJIku
         69NnVVvNwoRgh+WwBrO1QoVrV8ETZmuk8tY6q7+hssFpTlMWk+Be0vN/3P9ozjey0Qda
         AD0DB/koiYLsSYnh5qcU1eav3kUXda0AhzAoL7MlvGiAS5zPPR1Lnm3Ugav8SAcW5Ksd
         lHNsKJbwT6sJKYvBa4Vda1ocL7/KjN05zwdPkL7exf5FeaA+YtgXlwBV4sBQK+q2HY2j
         0J/EXK2iGCTvWJVnlqBcj4N/lq5BMnCH3BQnCjG4kWCagBLvqhly70tc1vk9FP9Fvb0c
         m6+A==
X-Gm-Message-State: AOJu0YwU4H2HIO90wZHOSAuiQ7PXCm4SJtlI8XFCSFp0dH39p8TVeSu7
	Lqbon4t0WzcSil6IOF711Nz3XhRhCiF7yTeeVkhLcSycILPTnXzZR1fnLw==
X-Gm-Gg: ASbGncuhEvtkg2FeKaS3bBiHm0/Py6GEEjRNrgiAAlp6wOVGIU7tk2vSUBnLLkVORec
	U+Nn+IneuJgzrYeTC98M9pfqAl1N1Fl87Hj/lgBfKXgOsoTRD7v/dr/ib3toEySqchn0WaW8eah
	UvqZ1NBbnKqxWX2ayPvIxCK/UDCZAmxaiPYdaxK94Rq/n1jmXkQ5E8/IuocC1Oft+ZdxWzYn72I
	cAU5wYVybPOVJJimqbiPzrbC8jUOvKAmMfoY7UgR1dNBeddvp9RF5dZNw==
X-Google-Smtp-Source: AGHT+IGiRqK7SHFd4Nlv56c3lxzLZDEHXqG9uVPK61hUOuib4XOtvmTCh4543YtKzFcDtOPWcKAwXA==
X-Received: by 2002:a05:6000:4102:b0:38a:8afe:5836 with SMTP id ffacd0b85a97d-38a8afe5883mr4727430f8f.17.1736458021341;
        Thu, 09 Jan 2025 13:27:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c6dbsm2814011f8f.55.2025.01.09.13.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 13:27:00 -0800 (PST)
Message-Id: <pull.1851.git.1736458019921.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jan 2025 21:26:59 +0000
Subject: [PATCH] docs: discuss caching personal access tokens
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
Cc: sandals@crustytoothpaste.net,
    derrickstolee@github.com,
    stolee@gmail.com,
    Johannes.Schindelin@gmx.de,
    peff@peff.net,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Describe problems storing personal access tokens in git-credential-cache
and suggest alternatives.

Research suggests that many users are confused about this:

> the point of passwords is that (ideally) you memorise them [so]
> they're never stored anywhere in plain text. Yet GitHub's personal
> access token system seems to basically force you to store the token in
> plain text?

https://stackoverflow.com/questions/46645843/where-to-store-my-git-personal-access-token#comment89963004_46645843
Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    docs: discuss caching personal access tokens

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1851%2Fhickford%2Fcache-pat-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1851/hickford/cache-pat-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1851

 Documentation/git-credential-cache.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 487cc557a87..18e9933674a 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -78,6 +78,23 @@ variable (this example increases the cache time to 1 hour):
 $ git config credential.helper 'cache --timeout=3600'
 -------------------------------------------------------
 
+PERSONAL ACCESS TOKENS
+----------------------
+
+Some remotes accept personal access tokens, which are randomly
+generated and hard to memorise. They typically have a lifetime of weeks
+or months.
+
+git-credential-cache is inherently unsuitable for persistent storage of
+personal access tokens. The credential will be forgotten after the cache
+timeout. Even if you configure a long timeout, credentials will be
+forgotten if the daemon dies.
+
+To avoid frequently regenerating personal access tokens, configure a
+credential helper with persistent storage. Alternatively, configure an
+OAuth credential helper to generate credentials automatically. See
+linkgit:gitcredentials[7].
+
 GIT
 ---
 Part of the linkgit:git[1] suite

base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
-- 
gitgitgadget
