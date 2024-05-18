Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16621BC3C
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028375; cv=none; b=HGEGlQhhOPkm9VaPoK6FVpr9YciHmkqKJ6yPEyaTiYd8GWG6+gK1axlgoQ172rZMLUSYD61PISAEnEKK92U+/mfqnX0crVLgdRRrWIbu7TsUitIgtTX7goajLr02KSflQSQQch+WIVBNypTcHtWkx5GxoG7C1PKgw8U8dBbWuoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028375; c=relaxed/simple;
	bh=g3mcr9oNJA2YWVKdqdh6JD9CfQ682VkR8dwEEitGi70=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UGReGgCFppUPLCjoiBtc0U1gdA49ePAT5GKKuIzvKjq+uCwAUeGHvvt8Dt+QIULDSLY1IwkodjfhG2sTP4+8IgX+vk5DhIzfU6o+I/i7jV/3jqZ8aeQ2dchYsXhYJ7Nw5uai4FjDwNPYIRvqBEKjHuYKZLmZqq/Lp8LpfeS6D9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmzsjJ0C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmzsjJ0C"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4202ca70270so11596735e9.3
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028372; x=1716633172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3TcY6SNGMN9D4Tqo4JhzJB1VLG5CDwDx+Tm37TVHyE=;
        b=MmzsjJ0CTI7n0/bECOWE86dT1wRyyW++KQdAlfc236W+67+zEYHcETqeHeJ7Vf9yeL
         fe/XDFOR8osnCxytoo5i2mr5EMe4mrdOGvUi80PGbS025BJC8oOxFYlRG69ygdlJCvYD
         MJau6tvDI3Ds6mZA2+DbuZgBzlO8OHUA9p2CxQsw5dLqKjyxwVVkPJdcv7uEk95ApHU8
         Vhj2ZoX1UIG4EhfX4ZyUdGhg6BMqthv2k9ckuE6odVFgT3RDre3pduaPJoaZ1ySRTVYg
         +ZMJwZ1gZL3F+4smghE7V3J5Km9c+WdNZ5r/6inQLca4dsbHQYde/5E+qL/k7h3hxCwb
         6B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028372; x=1716633172;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3TcY6SNGMN9D4Tqo4JhzJB1VLG5CDwDx+Tm37TVHyE=;
        b=MPPWxU0nE9Kadzj4DWsZxiSp/naYcvt0q+bSKUyKC9d4HOJnITDu4T0pXhgHUq04Om
         JXQOhTU0FakpUPQBgkvUcA/abGoD2PhdlG2h2Q54yuSkUA/JfXy8LTEN/IcSttXLJ3aB
         gwnXlcj71z68lZz7iHoOO+l0ER1+WU9d9Y39COtjBc0camT/XdsYelJLpz4pYLJ+PnPN
         Nu8FDLu2Ad5z950NCy64W5LiizvBX4BiivEWcb5QYqLxK1Pq5zs3PtujHdgzS/2eeN2Q
         0adOjhLDGAIzr0CYcvolg4Mf4KMZFr8I+TX73IFdvc3BwqoTdNX+Muro5/Jt2GIbKsil
         a8jw==
X-Gm-Message-State: AOJu0YzyLNEyg39iA8zhiRauLGw+a/2qNjReL3hb1Rb+F79PDgZ2MAe+
	KaEdlP3Sd1TquKLQzrXfKNctmqE+acfjl1volPZXS7ZXz/2r5AiRxZPB6w==
X-Google-Smtp-Source: AGHT+IHoFpQ2s4SdysuB5mUUCTz7cf+oWeqk4u5bSDORpCJ1OzDklUT8Qt9Rt312IVz0J90dQaCiGQ==
X-Received: by 2002:a05:600c:5116:b0:41b:fa34:9e48 with SMTP id 5b1f17b1804b1-41feac55e26mr233102165e9.30.1716028372056;
        Sat, 18 May 2024 03:32:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200f86ab7csm262924365e9.19.2024.05.18.03.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:50 -0700 (PDT)
Message-Id: <961dfc35f426388d660cca4e92f43e169819886a.1716028366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:40 +0000
Subject: [PATCH v2 2/8] init: use the correct path of the templates directory
 again
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In df93e407f06 (init: refactor the template directory discovery into its
own function, 2024-03-29), I refactored the way the templates directory
is discovered.

The refactoring was faithful, but missed a reference in the `Makefile`
where the `DEFAULT_GIT_TEMPLATE_DIR` constant is defined. As a
consequence, Git v2.45.1 and friends will always use the hard-coded path
`/usr/share/git-core/templates`.

Let's fix that by defining the `DEFAULT_GIT_TEMPLATE_DIR` when building
`setup.o`, where that constant is actually used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 093829ae283..4b1502ba2c6 100644
--- a/Makefile
+++ b/Makefile
@@ -2751,7 +2751,7 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
-builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
+setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
 config.sp config.s config.o: GIT-PREFIX
-- 
gitgitgadget

