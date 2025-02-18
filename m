Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684826F473
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895888; cv=none; b=YHckD0qZ0T20jYhrmFNP10Gvg5qaFxiCgAcOARWptZUv4ymawy6BBLWeCKhXb0sCStPXD9O+HQ9O65wRREjB6jbjwPaov9uygVCYG9/9nvhdrqUrcod/nJhOjIMb6tRJebREVOpS1SFpJfvHraQ8NNJLt+Q85RSif0PtSuyEOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895888; c=relaxed/simple;
	bh=+S1zg5XbCyQ7711DWFK4Erle4f9KxWiAuUlp3bpaVVM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YdgHwTXxpTtCRLIBHKjRkyNlifpmklwv+D97rH5Kinzd/1zCww/n6RVpgQ8rzO13jGLDcP+e4HAwUbTXRmG1D+ZIGL4LWkQrhhKFrdZRMR0JEGVpx66xxeENx3sS7r6V6Qjws9YOu1Pe4NivNxkRX319iYi+N/c3ecJS2NX3RXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeuXssF5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeuXssF5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f3913569fso1791532f8f.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739895885; x=1740500685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7FtHLrzUWo+GJfYTEfGjK8nJID5aIuC0/8aOGD2Gy4=;
        b=TeuXssF5WA8JdckM2oRkLaDEHOaUO838Oh+kHpCN5dT32HKpqMSg41MYyD1KElxBKq
         4+5xAplgfQxA3BqaH9tn+ilJ7bYTjM9wGncdpAzK2gFXqF6HkZK3e50mDJ9SQE6MQbc5
         aF5hpMaOcBn4WGr1HR0pK2+Izd00I5DrOaKSIv3eJzHO5rnkVBj0zt5trsvhkcRCY5nN
         XcBscJW89idDI6wBjTfGe4CuCeO5PWogs2fFofIq7EN55bp6+xC+ZMEMaPnsl99dmQ0s
         PHPzHrOS1P5dhKUFU2JyFzMGLcHhFjzIYLl5qR0//y53X89RDstDhp5QgbdxXtFINMYB
         mwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895885; x=1740500685;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7FtHLrzUWo+GJfYTEfGjK8nJID5aIuC0/8aOGD2Gy4=;
        b=MCCIoaa9kZhPRN1StKvkx62wbVVxSHNUE3/23T14tErl8vtOZA/G6gwoqREjXnL82e
         FWCBWpjs94MwpQWE7UINwwPsfYqi8zCN2nj+57+feQdLQGI+IgQM9ThADK1De/WThBi2
         e749dd1GZJ2fX5TjIli1jcNpC7OOuSSsQItU8l3qy0UBnP1H1hxPbrqL4jbpC60KxQcS
         n/kboynHJP3wGIzzD38N90JgCTWsjQLPuUQn/vqo17hDhOM4B00Fv4AQY6Kt3k3XzjEz
         sR6Y8m/kNSFuFLsOcafy5DdWjmORAJD0EREzv3lFan6ugMsjveS/awmLxvJWbVWBYaA3
         6sbQ==
X-Gm-Message-State: AOJu0YzQhBDKuzKeW5yVwe5kqKmW7EwxJU8Dm3aj9om2DeNDgbQHdAvy
	wBNzFMMFO4eIY1z15O/aDp4nNSpnU7V552NE4+FznuOnHR4fYr8anrTDdQ==
X-Gm-Gg: ASbGncs2RoeJyPMwUiGnWwcqMGhkHwwF3g9o4G+CYIcqae3d+eNAPJLjadLt9AkJ/5f
	K5OuW2DQYodnk+mSRFHodGMOwbhd0T8SfCokbQAqRlPcVVUmKyZJs+7Pp3qTna80kVcjKXXy6ug
	nguX2E1pvaUDl+Bb/AzRhEkOuPRe3O+flebQPi1Vn0osIF9Omg3rN60IONBuf9CT/nBq4Of3kk/
	DdkngczofozjipD95GGAcHlR8hYJx0sFW3eAQa7RpyIS5ojTXXti1sM3fGP7o8BXe8cN6xSpDXx
	O/wYiS+PXdFc1Y8o
X-Google-Smtp-Source: AGHT+IFl1yP3/EdXoNtYNKq/tqB+oYzAI4WWis9diGW6wE4ybdpXo9a/BofJk8Am6yD2Tl1v69OJPA==
X-Received: by 2002:a5d:6d83:0:b0:38f:2c10:da1e with SMTP id ffacd0b85a97d-38f57ea22c6mr377178f8f.27.1739895884933;
        Tue, 18 Feb 2025 08:24:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25914171sm15615846f8f.53.2025.02.18.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:24:44 -0800 (PST)
Message-Id: <a017982009267da5157d314a7d3061bac60ea8af.1739895879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
	<pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 16:24:39 +0000
Subject: [PATCH v2 5/5] merge-tree: fix link formatting in html docs
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In the html documentation the link to the "OUTPUT" section is surrounded
by square brackets. Fix this by adding explicit link text to the cross
reference.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-merge-tree.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index efb16b4f27d..cf0578f9b5e 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -49,7 +49,8 @@ OPTIONS
 	Do not quote filenames in the <Conflicted file info> section,
 	and end each filename with a NUL character rather than
 	newline.  Also begin the messages section with a NUL character
-	instead of a newline.  See <<OUTPUT>> below for more information.
+	instead of a newline.  See <<OUTPUT,OUTPUT>> below for more
+	information.
 
 --name-only::
 	In the Conflicted file info section, instead of writing a list
-- 
gitgitgadget
