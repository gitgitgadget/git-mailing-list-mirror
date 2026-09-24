Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34EA48640A
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261074; cv=none; b=jZPANVpnIM5PzErBpNgtK0SAaH93eQEsaCyYKtRUC6NxinH6MgW3qslDAZX+D5ZTUbwJGsJyz948baxx0ZipuiBjvPuR0KQeQ/c1hsGjdw8cUdxq5+GFwWQB3f44TUJppKfvnE28NZGf6JBGz1wqG9Mp+C2dQgFBcxI++umSJeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261074; c=relaxed/simple;
	bh=AbvkcuA1vOKjb84e/sSf63w43Eez3tLnVnd0vN1OJx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rnq6+pgpoNs8QatgTPlt+2l73IVkSf3yrtJiXHllAuJQdv1CqS1z6dJKemBCvMDmQIb+gJKNj3TTR6i7oKfCAt6TA1kx4Aahtay6TEj6mRo5Odre7IvH/yiiOLAZZkbe2X6hnlBfsa3O2X1jseckSuOH+kcyhGJ0ZXcknP5JBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJuIHMNq; arc=none smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJuIHMNq"
Received: by mail-pz2-f36.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so1294251a12.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261072; x=1790865872; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=DJuIHMNqqU0wQQ6PTh1kqVIGZU6WKMy8HZGYZng2NAp7LymKb0an/DZIU/zrkU6UKf
         kBDxqnnfK/vgS0tuWXbEKV7pTLCX6QXz3Id0doSYhc752ybYi3+H1NuWylNCPpHfSE9d
         w4lUCekh1cF+/sH6jKwv+AJdFOf2teKBSd+vJaXLHYYgGFEX5zCA+/B/Adi6QsPMzjeK
         RO+t+WYCwoOB+V/SlBDsh0AYTLKdza9CdA18k86lT/jxwEK7/Qx6X3oxNrPSrzaUS6HN
         g577ZKv1U6v6Qn+foSQ/etUyLE3lz5YWYeyQs0bWLUZWd09aCXTOIbQWh/vYSEhpAzYL
         iovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261072; x=1790865872;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=dcgpMXHLN9N9MvdtxPpJqO+cFp7jsLz6SJGrrDJFic4ycnnstMcDGW+3NkFtDeVioM
         nSuUoDk/Mn5C6N3FO5fQm+cmZ7eAIUoHJjcdt9SpAktL8YyrdrlG0qbJHa01kjWomuyj
         Aw2MSsIowitWwMSmedH7VmyMa2w1bl/tYfjvMlZa6FaQ+q8gJx7kpcCA9lwzIMf1X72D
         JOprYfoYeJiJwWdjTCd7yFQhtZqj/hubv+j+bZABbUcEDCDnlJV1Tl/jy8cZL3i+yv38
         I9Qb98gRrd691/SXcOIVB2G08cQKqUXfKWINr4vfgxFAXtif5bnHSvwDHR2zodwfHdM1
         iTRA==
X-Gm-Message-State: AFuF++noADnzpXFZOU9IzLdrz5Efkql67Vl8T5xPVKkQQt/XyYJtO4B3
	/vd5q7Onged8XBt6Z89iVk/2KLrKfrqDOYGByWi1McLRbglC0n17vuITVRcIcM2/
X-Gm-Gg: AYBFou0brwAokpU0UQVRroCAt0I4Dr2bh+hGAa3kAqsY6YjRcR9OUzNUsWduR6+pX4L
	05j/+5CK8W9rTP3MAo61CXJ92WJ0DL2pOtGGmb+PSlt1Zd+dDDqZuoK0LAFdgb6tzmalaF3k0+B
	9mBPqi0KffHddmqUtYsh1DmaneunO3M+pvTPCiaiVzMtp6juVeqdFlO9Ca/v5lVXFXXkjYKmpQU
	dXRWxxHpyZqoDSJPsEqVpCLzyQRbCLSH/mDj/FaxeCPNwvVRb1q8OjxC7SaGCTX75I1JX2fI6+M
	Egr4jgEUdOjHprAPYQgiNXPnBTvZx84qgBPQYjXsAg+rAKw3BUOrKkeRM+lRY1NLle1slzt6FIF
	xHqKBnq/aJKfE0OqPs3SF4BHOOWBR8pHq+Y3lapt1+zh6lSpwcvRdhn6DHAl30vT7OpNagru0aR
	6HQ1iY55QyaC5b6RLAG0WAxo/pjvxsT5lL2zi44YRGug5hkzU3GtruIdPg136uMy0zlTzNCwhFE
	QM=
X-Received: by 2002:a05:6a21:7a4a:b0:3dd:a00a:1713 with SMTP id adf61e73a8af0-3de0e8897eemr2672297637.46.1790261071921;
        Thu, 24 Sep 2026 07:44:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3f5e79sm2802900a12.25.2026.09.24.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:31 -0700 (PDT)
Message-Id: <d3904f0ca7ad0c2274d642dfc72b863647df487f.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:21 +0000
Subject: [PATCH 6/7] [doc] git-pull: link to new merge conflicts guide
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
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 88f4fd3926..73f6d460bb 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -38,7 +38,8 @@ or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
 want to handle, you can safely abort it with `git merge --abort` or
-`git rebase --abort`.
+`git rebase --abort`. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
 
 OPTIONS
 -------
-- 
gitgitgadget

