Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68D1EA7DE
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437311; cv=none; b=pbZSejpcrftkKFKKKVMlZIHzd3lPAYPaw449BdT0lQKWj7Bzi7C9fEoBTSwFUKTIt9Pw7ZSc8j0IEpILxcR0J325+pnoBmhm4JhovjxMNi2zqCo2jtj9QjNzk8vDQT7GAUUH2l1whOL3cjuWEUAx5mYW64VJMGnBfj3r8BgtdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437311; c=relaxed/simple;
	bh=Sf9HOMjtTSIbjU/eik5d8eoDvbxbsupue6qJdlsKfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOwaEFpFGi+Bd4HAwqtF5pRpRxOCLEKxRb9j3ZHup6REL0u3tFbKRjUCql/o+qRUoZaxOrXnjiqG81rMWMlBCQ+J0UPPiPCAlQTUVbQl3OzZWc6WlaIHrufS+9HYG1q9kvzlapKRfOv3VWTexf5sMqqmLzwDJ3+xPwtDxIeUgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omrv3djS; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omrv3djS"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-601c46a92d1so135616eaf.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742437308; x=1743042108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGMJoFT2YBica+yWn6oVlVeHYQR1zXWMpCm5P+DNc4M=;
        b=Omrv3djSMP7eAizB43+nctMMeh9RNU73Sth62Ep4AekCeelE0KC+mH0z22rn0o3fK6
         fhlkXS2LkPK+q5rcxGyRVQiuANQgSePHMYkH6jgnWVxWwLRVbxeOfkupTpOgzkYIftAG
         ZANaR2l6I0NmhvWbIWvyo1LenF/ZYAHvsTSzenkG8uy0bRiCAAQK0t6wfcgVLxoPXi3L
         sds6dPVjN5pkQyV4JrazPQvx1nLkzzi1/vC3KWzb6Bq62c6nl4RHT4uUGOM+zJb1P9dq
         E0TqqYVhHwWpE3QaSzKW0xQSfKJ7Sml5CxvUiNSkUFW2VvPQcbpsdtOaYjGL+WBQCMrv
         1FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742437308; x=1743042108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGMJoFT2YBica+yWn6oVlVeHYQR1zXWMpCm5P+DNc4M=;
        b=uEanaK27wib7kiMYxvBXLXOGqFJEbEgAmFF0xqxRfFMWDijDOWFDyO1BLUGUyEhd0Z
         ZDYnHSiXMx1DsAP8ICIlmmKwTsROObWNQPGgTOU2YkVZl1JfuB0nMG3rYt6xfQ5ULdCi
         podHdeGZkL1V+FuUk5oOyhgXbkKDS+ls6IoDmMoIc6/Ng26DE3qY87C/sN/OaHUT3wkb
         WYqCN8LlfAfqO36M/O3S9mlgwSojujJzTE6lWwi7iGf0yVNSNmG7AV05pJw+LKDam0iQ
         FsS0gX88VaAyz9/4i2mJM99aaNi3LDVxgnEam0fQSXIprnHlznlTpyrtujEmQGFdS2Eg
         odKw==
X-Gm-Message-State: AOJu0YxO95UbrChzHFDaTVGRMKr0DFGbf0kph4nZN1xiEq3GPxqWWxlq
	605Xl67OkeWaevN7VqwkMp/qmR4IfMdQ3rI7ctwMZfvOZcSNIHR0mjTdVA==
X-Gm-Gg: ASbGncshGrb9IGBDldwcow4KQhxkbwXDRsKM2ajzzf8+XOd/IRShKz3SH/RtGg+Sngf
	UDuzrEGfWdVqIdSpnvoqKuNVjcxh3f84rfb+YPPfilTWWxV9vU7FMNEmR6LAIlwy4Rhlsecj6lL
	u+29ci55rEVx8OmB30DuOs3ffZ0P79jwQHDrJbAOWJmFyRXH6n0+QHfpJrku4+emNT4lL8nlYDO
	jJ3uZbIQrMKWaey4w1Yfs9kIIES8ccFnFyUcZEJrBeYFvaH9Q+fWFDJ9ela524bMzKWVB/1dRpH
	sauGxDWsqAbB9p1l2UGmajiWaPChGuu8+xPrvNnD9GSQsZOLBWi7
X-Google-Smtp-Source: AGHT+IEe73Ag0z0sRqt1u1O+Ft4PcPnL7lNpa5V8Xv5iKdG7esOR8IJL6ua7p9PLdf5BcGejotB+sA==
X-Received: by 2002:a05:6820:7605:b0:600:1030:1114 with SMTP id 006d021491bc7-60229762f98mr818720eaf.7.1742437308421;
        Wed, 19 Mar 2025 19:21:48 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601ff46adcdsm1549579eaf.10.2025.03.19.19.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:21:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] clone: suppress unexpected default branch advice
Date: Wed, 19 Mar 2025 20:46:46 -0500
Message-ID: <20250320014646.2899791-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320014646.2899791-1-jltobler@gmail.com>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 199f44cb2ead (builtin/clone: allow remote helpers to detect repo,
2024-02-27), clones started partially initializing the refdb before
executing the remote helpers by creating a HEAD file and "refs/"
directory. This has resulted in some scenarios where git-clone(1) now
prints the default branch name advice message where it previously did
not.

A side-effect of the HEAD file already existing, is that computation of
the default branch name is handled later in execution. This matters
because prior to 97abaab5f6 (refs: drop `git_default_branch_name()`,
2024-05-17), the default branch value would be computed during its first
execution and cached. Subsequent invocations would simply return the
cached value. Since the next `git_default_branch_name()` call site,
which is invoked through `guess_remote_head()`, is not configured to
suppress the advice message, computing the default branch name results
in the advice message being printed.

Configure `guess_remote_head()` to suppress the advice message,
restoring the previous behavior.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9eb66234bc..3b166b05e3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1523,7 +1523,7 @@ int cmd_clone(int argc,
 	}
 
 	remote_head = find_ref_by_name(refs, "HEAD");
-	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0, 0);
+	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0, 1);
 
 	if (option_branch) {
 		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
-- 
2.49.0

