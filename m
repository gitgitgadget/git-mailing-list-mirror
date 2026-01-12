Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB231ED81
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200819; cv=none; b=pxRyzrUhGPZs8PalG3yuQnYGyQd2QOoZHyb5GG2QgWMNBo3JuM6BdQxs3rdUn9CR+qD/VuVRkZB7H0QVhE2TVnBBQAFjRbIprx8aLUp2xbsxnPdg+I+CRq6QqvqxHjZ7xHd62At30lsRSnO/xKyzJMSLKcyc3J4K2xcGqpJ6T7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200819; c=relaxed/simple;
	bh=Fow60OgN6cPuXPB02FraC/roj2D8bU2sT0ILLeOD6As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyZ9/kRQPBs5zL2PqQ0Gi118maoL4WkYLebtzI1tEE10y2xoS3gbEy6Blv0YZDF7TTsuFtSDwNoc51/+HzCri8dGuLZWZ//XNPy43oBT/B6Z2ZkJeGsYo1llPImqUTvmFi4qvpTY6AQ6d7YVcDwPC0QIiD7jFp+SrfdfTKAXvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEtP+NX2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEtP+NX2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81db1530173so1184333b3a.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 22:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768200815; x=1768805615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRKgLoo06nAt+U/bhDkGCqYB0Y3GyVs2AJPQOW/CCTo=;
        b=IEtP+NX2WfhswslNNtIyleESuOboQsFycl/Z9vnsLrvxNgCEKvaGo618iMXd6wB9rF
         h8/j0iAaaFE6whUfjjVBEGqg8O9/BSaESPoHbtRoLy2pSD819RAz9V8lh58SJPyF3NoH
         tQOOdAghV2G/aq32b8l0DyOfOzDBgEJCV6Dd2Z45/cYE+7ADAclxfqtJgiYjdv+A5B8Q
         SpFKKoE1P/gEmC8OPT41psW9JiXVBKN5jZSB5KXUXbnk5Nc0YJy7uHBGrn6vh5B7uZgY
         bjCWzvGdOJNjHMBqtZ13G2tQwDEb8/oKAo6hy4Y819Z7rovY4jY39QFe3vd5ro9Xys4I
         x+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200815; x=1768805615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRKgLoo06nAt+U/bhDkGCqYB0Y3GyVs2AJPQOW/CCTo=;
        b=bSog3p1NwKGYQw480QLVe95KjGARZ+z6DwNHaG1YxB4hYasKQOQbAPqwESHAeSMQTn
         3tqKgYx68MftdbKb74ilMN1iXaJ7/MbCIxnBhu5q0vAIDr3djajoTTIiDe4CovkqW4Bq
         HoozdMYiHGa2KwvEIsp9wm9OgAEw6UXdpT5GW+V21TFVt4AhVH5Qc9r7ZC1YFx+Hpet5
         dj1Z2lPHl/l/3avHthZqKRQyAhbft4FiNDs9yLtMF3SIYBbeeMaBVkx0ijvcbH5btpVp
         q71EjsvXJ2ldqMhB3yNNYohs26wlyKQgq9GlMSYOKg3phQZFNZ/0Ph/0wxBpIWzr10Qb
         ohtQ==
X-Gm-Message-State: AOJu0YzqfTcYNuJoEiFqJo/oeN9wqff3R7JKE+EK94ih8kAgi3dN9ddG
	x8Dt0u5YELFJfmj02kw8thBVjmRYQZA+x0H5GEhZQYfxsT842VO9S45DoGKBwpkm
X-Gm-Gg: AY/fxX4fXAsoVaCPwIxR2eue2yv5K/YH2IxYbyQTyX9Se9hvILOIUFU+FTRUsoYzx4j
	0ZBY+8Llc/oE1xfz06iwHI7B88mlRcNYoK1xL53IH41wMCWWMP08+9Set2hCSjCX2qoaeEN1L0r
	fUFMeREqSRaiGAIAJvzIKAFvSH71rImvmcSMr/UALesP57D7nir952lWMvGlouCE3dUGN7NzAR3
	v4G14azXyw+ldrNieU9U25lI6BCKcAVw7pUvnHhk0zQQ6NZyL9CTxQXYfolllQ3t22SqqSOmRFj
	yIMHlEIUeXwqtF4R6EVJGLfyEFTU7EcVbO0EfEJGot0JaMOOeQfbLJvq2SFPbq1rBqbyjEmzHcM
	131V0wHkujQoqTgD/wBrLnM1MUcplR67xe6vrz3K+Pg4ndKgjS5GI/i8ZHmr8f9ARJiV7kb6X3m
	fZi9oPTCHDvm8NEpV6O7A60FTh0QdZr31g5g==
X-Google-Smtp-Source: AGHT+IG21ZO73M863OyoL8v8qKYj+5Xc9+r0lfVCCCRnhZXBlJ5IRwWsy7nH4PX7FqLo5JzXUshxlw==
X-Received: by 2002:a05:6a00:1d1a:b0:7e8:43f5:bd3b with SMTP id d2e1a72fcca58-81b7f6e6ed3mr12769647b3a.39.1768200814718;
        Sun, 11 Jan 2026 22:53:34 -0800 (PST)
Received: from d ([27.59.119.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f476sm2634005a12.8.2026.01.11.22.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:53:34 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: deveshigurgaon@gmail.com,
	sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com
Subject: [PATCH v2 0/2] t5403: improve post-checkout hook testing
Date: Mon, 12 Jan 2026 06:52:59 +0000
Message-ID: <20260112065301.1290-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260111072950.9463-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up on the recently merged patch that replaced 'test -f' with
test_path_is_file, this series continues the cleanup of the
post-checkout hook tests.

Patch 1/2 introduces a check_post_checkout helper function to replace
the repeated pattern of reading and validating hook arguments. This
refactoring does not change test behavior, but makes the code easier
to maintain and prepares it for further improvement.

Patch 2/2 updates the helper and hook output format to use test_cmp
instead of individual test commands. This provides clearer error
messages on failure, making it easier to see which argument (old ref,
new ref, or flag) did not match the expectation

Changes since v1:
- Updated the check_post_checkout helper comment to be more descriptive.

Deveshi Dwivedi (2):
  t5403:introduce check_post_checkout helper function
  t5403: use test_cmp for post-checkout argument checks

 t/t5403-post-checkout-hook.sh | 53 ++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 23 deletions(-)

-- 
2.52.0.230.gd8af7cadaa

