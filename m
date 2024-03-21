Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BD13442E
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049970; cv=none; b=hk7c5HQkOKsy4ZiGZv8rCYt+PwkkYmy7sUs5N1uVvRH49p+4/mkDZbiSs1nHuoF4o8DkQsufo50SpQITbY3mY4TA4e7FXv/CTYqlkO8BmuS5IaKP2vQcDIPy5WFGjwxr7Pkq2qoBhoYrZkCsbU4173OW14zuHvP4yX2+1Flvtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049970; c=relaxed/simple;
	bh=RzfKZ7dj+XGzXuLDyZJWzPNFkO3D+yrUQT9gi2HjGIY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uVwKXj2Cdwx82J0hs00I6+TEVoM9Ec3m9IbWvFlZiXykVSzMe0pcHV5wvoXn5maIy4TluCod0HohuA6Cwmhw3zXDRDSRt4GcA/qcsAKV8kgsCVT1aMUMDvJQ988cbrc6V1T7kPhPHkBWoJz8R55uhG2tzrpLxn5B2FdPKzcmT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGY98J71; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGY98J71"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341950a6c9aso948499f8f.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049966; x=1711654766; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DoPvBfbWGi4gY/0R0DUsvsjAWBI/r3F3KkPTF4IVdE=;
        b=bGY98J71uGvAvzRvlHpIXIUxlrrJS25hcZeoKLTMnyeKIHUfOgc+h3qAfksVzM5wQr
         r1ZWHnO8a2yg1C61P1ZXS2mu2eWdo4UJNn33TGMESYKaGW3TFefCZ7MkqEZXvgxL9l3m
         2l8XXB9yJ9WhB7vnn909J3SCxSQw0VAxJ2DKM7EHwcO9urrTnyonQFJajeeLtfx1VZtH
         ynAXTRrU7OMmfefQ4czdTn+37CL2AwWOMJRlA9avrfJyiaJDGRw6iTva5Vt3PpLt9/X2
         ddHYq5Ke2tQ6v1NPTxgEdbKnMc9ujyiGMmtXDudr4UiQhsTticefERCYwC2tkzxrtMuU
         jfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049966; x=1711654766;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DoPvBfbWGi4gY/0R0DUsvsjAWBI/r3F3KkPTF4IVdE=;
        b=S9RPjOxq6gbM3VCX3FOfFscz3mPWShNtHXqeuMwj/XTR8osE7/O7xQ9aI1ymHPYxXp
         4RT8JQ5e5ylMfexAjtPsVcNpTUnZcuFNHn4G6h8Ntrf32Bdu0FMprL/UG7bBUjs0SLSB
         j8nqG6v6QCySAGfIUDZobJ+tcLlKJLiR4aiv+OL0hv112sRrSsXDeLMR/v52rIOwq0gT
         sxGjwAGh+3MuDDolMdYjgj16XManNWtzEzlVj6xUilfZukh4qmDN7MEDy9wrvvYb0Xgp
         YaGx9uq8xd1WVBUmXDGyrflR+VZGM6L5yGy2hsxJgwg3v1a7KwB8sdplvHC7/UDFK80u
         o23w==
X-Gm-Message-State: AOJu0YzSCSWcTF5To+z4TaQHMK3+NQVK8vEn+EOdSc/I1qBi7FRVpJOR
	Dw2YT7IQjot07cUOaTrrfnGjfTQ2rpKIiOLjls6Yjot2Ka60NYafPPIZNDj3
X-Google-Smtp-Source: AGHT+IHWa3QGYrv7Wm5w9Fz5ih8ft5hxmWSvV8CR93kqGsgrb6R12HVGo8/8Eop9AwJEPTMhHGsNCA==
X-Received: by 2002:a05:6000:8e:b0:33e:c4c1:b45a with SMTP id m14-20020a056000008e00b0033ec4c1b45amr125578wrx.8.1711049966547;
        Thu, 21 Mar 2024 12:39:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d42cd000000b0033ec312cd8asm329450wrr.33.2024.03.21.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:39:25 -0700 (PDT)
Message-ID: <b8d0620d4104106210ecf6a34ada591adf01cff8.1711049963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
References: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
From: "Sanchit Jindal via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 19:39:23 +0000
Subject: [PATCH 2/2] t9803: update commit messages and description
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
Cc: Sanchit Jindal <sanchit1053@gmail.com>,
    Sanchit Jindal <sanchit1053@gmail.com>

From: Sanchit Jindal <sanchit1053@gmail.com>

replacing `test -e` with test_path_exists,
	  `test ! -e` with test_path_is_missing
	  `test -f` with test_path_is_file
These helper functions will run the `test` command with the
corresponding flags and will echo a message if the assert fails.
This will provide better debugging logs for test, instead of the
previous method which provided no message

Signed-off-by: Sanchit Jindal <sanchit1053@gmail.com>
-- 
gitgitgadget
