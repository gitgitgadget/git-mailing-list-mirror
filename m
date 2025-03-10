Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAD22D4E4
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619473; cv=none; b=aKcEY6bh5oOyiWgRbfkFYfMn0gXDbMMP2oSVji1mPkPZ8DvxmrbBOgdTTbZ9a/4eDwSKCYucREjTjj5xuAHXTpJU2IQghyxnKfR3hGvz87ZRaIDxL+L+UYFEPat5hP0n4yZ6ZeP9nBlmCX7USJzv5wlDo8r76B3ISrg6VvFjGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619473; c=relaxed/simple;
	bh=dm23efy9ojv5hyrD+B4PKpRaV8tikywnOWdcFB4Rmrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KN+IiLNpBsB4AuHztXhSmPDRPp5Mk6aX5cItnlhaOdBCIsNRQivZijvwY/0cH49D9ric4K6wbqHiV8SfZxmMla6s2dYWq63rqBiN1qXFE++BLZtooxNRo/2F0uEvx4TIvXWgVnqBDxNtNnV2Yqp7trVeLHHsMiRsL1XFJI4lOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu5FZlmZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu5FZlmZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224171d6826so64535785ad.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741619471; x=1742224271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8D4l33wMuon7BDftssa74gSCcwe+e6Zu4RuiLrlpjA=;
        b=bu5FZlmZscTGHqWxB9d1EVyGqZ2ZFuWzbTXgVPN/Cyfg82lPZnmJnCxXrEiiIgZWae
         KUplmG3MUM8TLbZ5I9L+dIVW5RQteYTTn4fqOV7Nq5ZzoFs6RcdOhlOhhaiswx0DamN5
         X9a463wWmvENZC0tAKH+3owYH6LaSLcHntTnaz1z7/wzH5jSzDB6lelzJq7WL5l7J+OV
         NcgfC5e99bnwlnw3dx97oyf2Yd1w2Csdc1JMcZHOAcGvKH7zxZWTiaIv8fRTD9CF4+Qu
         hODWdvBmWBYa/u5CDFCAegL7MGgzOTXA9a3+JJpeYOrme1MdQrpyoOPg2wrWj/iBMsyU
         Al3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619471; x=1742224271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8D4l33wMuon7BDftssa74gSCcwe+e6Zu4RuiLrlpjA=;
        b=UvO8GGgFJm5qhcT6EHWdbGhG3AJoCZRs3rC9VBx4eUaq3BQc5DjOuSt1nRR1F7t2XV
         QY65A/Z0RlbBY7arr5M3HceCkD647FjggrBGxObRV77Yb4WNnbhVu5edYYJxi5KH3M3e
         lZpFgIw3DZZtxIknwyexohSHDcToUKl8GFnOCB4wMbZn8VaN6HnAezks4mP9fZcLmv0e
         6EXsjWqD02LX7DeKCy8AMMgAhMEJrWqnSZnIaNc2XWQYxu/R6ueVi7cGeZKi0aYDYU11
         DRGBZSgSDg9gHK5tv6d1J6f6GGIk/tG3hqWOMX2QkIM/ddkg36CmY9VysD1pxB/MdX5k
         wzVw==
X-Gm-Message-State: AOJu0YyqPbUqBFQnbkhe/f3ld7RHQba4fRj0SzkF5zMPt3K0HAi5/jSF
	sBFKwbxcPirqFDhA9T0Yf0tsAgOVESf+70aFwvB5nq4t/KWFLTcP
X-Gm-Gg: ASbGncu13CaYOJxsRWDYxWvN9lOCPoPKqvWsEiqLii/xSa+h4Dl1zD34Vm5HE28ZrpO
	LmzOeebJl1rUEkIhOPznAgyHuK7mUSycf+gOaYdJbJdF3mwn602X72g+sSz7LGA8ZETL3L7AEFJ
	YFHEw7bxQb3OeeYAZ451IIPljbu+jSt8EOh0NTnDL417rcwb3bLPc51JoZqVCi8yIuxWP/pUwmI
	DPZvHSAPwfXn2Z2Y2uVfv/jxMZkQsocMnTPXg3vwGIMAS0TFwz/rdleWCvTezfjqq7WZroD+D1u
	NS8YekRl70LJmemH2u9mJznrLfJCC8C4nMlrWhZvbmjyC/tY2xxeHS9euBSiXQ==
X-Google-Smtp-Source: AGHT+IFvGD9rm4w2AgENK0IxukrWdP3QLJp5rZgAs0S0lfxIjuHDFyjNdIfTBDjs0urS9BTH0Sg8xA==
X-Received: by 2002:a17:902:da90:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-2242887b558mr238216525ad.4.1741619471376;
        Mon, 10 Mar 2025 08:11:11 -0700 (PDT)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e98adsm79528715ad.90.2025.03.10.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:11:11 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v2 0/2] Stop depending on `the_repository` for core.attributesfile
Date: Mon, 10 Mar 2025 20:40:46 +0530
Message-ID: <20250310151048.69825-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <20250309153321.254844-1-ayu.chandekar@gmail.com>
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves access to the "core.attributesfile" configuration into
`repo_settings`, eliminating the dependency on the global `the_repository`
instance. It also updates the relevant attribute-related code paths to use
a repository-scoped accessor. This is a part of the ongoing effort towards
libification of git.

Ayush Chandekar (2):
  environment: move access to "core.attributesfile" into repo settings
  attr: use `repo_settings_get_attributesfile_path()` and update callers

 attr.c               | 28 ++++++++++------------------
 attr.h               |  7 +++----
 builtin/check-attr.c |  2 +-
 builtin/var.c        |  2 +-
 config.c             |  5 -----
 environment.c        |  1 -
 environment.h        |  1 -
 repo-settings.c      | 11 +++++++++++
 repo-settings.h      |  3 +++
 9 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.48.GIT

