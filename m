Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C733B1B3
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767297720; cv=none; b=dlFJL27guBJXuF4XHG5qjU/dHcnaPGB3Acs0HVhzIL38HX7lPc8q5cf6ep5ME/yjN8XHbXySz4An66CdY15nSueGArloYIK+aGyxSraA7ZBcp3bGQqFO7MRU2gvP1bgT1kfOmMC83J3nurWE6nGRsVt95NQ24109hOS7aVvqkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767297720; c=relaxed/simple;
	bh=+s+1ID5C0dZqTfhFzMoH9iJ1MQVvzBly667kQFei9wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZG+BoZmxhQWJAJfXyNvfjJHkdgCZ7ARmixvtUf6s9LwQfwxDQhWC2uAUpUnm8iusM/Cim9uyMmP+9U5eNMdFG5ASNdLLCbX2q96UKHwEh6unqGcgsYunbsTH1OH0WkcYeGpmx8WuKesIjwOPbTIgq4BAoLKMztLPe/VlCTr/+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngXCdwMv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngXCdwMv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so9144181e87.3
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 12:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767297716; x=1767902516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s+1ID5C0dZqTfhFzMoH9iJ1MQVvzBly667kQFei9wo=;
        b=ngXCdwMvj6soIj2J1O6tpchc8AFXYBTOJupqpkul97Ifx361gS8PEqkvuOeq8Vn8ux
         VjM4eXmRQ1o3UBuC+wTg4MtNKNBH0H9h7GCmEwZKn9H9mzxLjmuNPRGBml+MuJgEfpzO
         St8Tx6cl3pGyhj8FuoOECrByQvO5XMXGuKWw9IGu5bzijQ5PenuJt5ZDg0spDTcK//J8
         7fS/kWH5er/jHI/wrYZ5/kqQ1wK7z+kwf34UQErPSQLRuS1v+dQcQXOF1ausupA21WMT
         2HTF75NKGJQpWyM/rI1P/+qVaXp9ooY0C2eEaROG6jc1ZH0rfAyBSMetxU5fwsy0kbV8
         ifig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767297716; x=1767902516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+s+1ID5C0dZqTfhFzMoH9iJ1MQVvzBly667kQFei9wo=;
        b=Gz0kiTmd4yVZaZCUJVTE2H6rKnR2kueZHiyyDiAPKQzpH0AsKDLcWMuHWKFKvmeEg9
         dnK/UygCyVq9qvc8u/7zXGvv8LKRzy7ic4ZXulTOx/rzQpX826cBHVof4bE0a/ZuGOFY
         jDCt1VnAB9NhdRC0hdjO+3ZBZzXOsschxK2dhwB72Lk1hBB1jkiSxiID+U012JSKql6w
         /KaVyHUHCRr7ExjXLNmQrobAqz4VZWAd5YNH6OBDwr/S5a22z2yvL+LiKtzd4k48IGiB
         eArpWiXuXIAIZFrxY44xq3ndZXQvHRIEPXm/B1+YlAJJsOGXbPe05rMEKMmsVn9tT2Bu
         8aXg==
X-Gm-Message-State: AOJu0YxjPtPz7BWj7jaSGMevoxo6Lp2FvRQ9hbWR65FMsOmrVB7zT6bB
	bej4w+R9Qs8iYVeYpcEqP+7x1HigUJthzfTxZzyt72COmzXovUbiQwIP
X-Gm-Gg: AY/fxX7Hi1Rp+Y7dY1i8UAS0vqwFn8APNNnD7SNS+FLBTtpcocMdrqyYJjjV2RdA4t2
	D3kS4QWf/vxkVQwQc9sqBWrILsVuidw3rP53ThaqEnR+e8Uxu5NklJ0ftEG25KN5KmcR6EL36m2
	7G8ZifEO9PUupWimUWBLNywM2BO5Y6CU26IA1Sqt8O264OEtL3W/nV9a3VaW05U2qlj1sy6hfE5
	rhvKcLns6lRVGg8weLu9QlZZg+KSSbH2KJSAQJYFqT9mCiq9I1OcUc+Co6NWdiMcS8NlZ04jGfE
	KdjCpjbt77vUAQkCUC33DBQMyIxAaFExiVrdvOgj3bBAwFzWkBGcFKEhPyARaG2t4vy5/E1FkR5
	WEQa9g0PdPNOBURCqXwk/3deTL0liH966Gr2Lc9lZoKF2VM9OHf/WNuq6DRS3b1BfDeT1GmZS/a
	NnW2/q+nZljZpo3WufM6meXH/WlgheoJwjinGwEQcI5fntRfETyKBP2qNEfE1ELVEgY4BPhQlGx
	zO4QQDik8Rh
X-Google-Smtp-Source: AGHT+IFOQoWrHZkLB5UW/MuSHCUl5hUQhPiK73spwqMANLd4NjT3pDXH2vd/dKTzORrQVsDMpFSzdQ==
X-Received: by 2002:a05:6512:128c:b0:59a:10d9:72d with SMTP id 2adb3069b0e04-59a17d498fbmr15525692e87.45.1767297716288;
        Thu, 01 Jan 2026 12:01:56 -0800 (PST)
Received: from localhost.localdomain (h-85-24-230-171.A753.priv.bahnhof.se. [85.24.230.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f85dsm11814324e87.73.2026.01.01.12.01.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Jan 2026 12:01:56 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: sandals@crustytoothpaste.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Thu,  1 Jan 2026 21:01:55 +0100
Message-Id: <20260101200155.15210-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aUtCP5YvE_v9hmgM@fruit.crustytoothpaste.net>
References: <aUtCP5YvE_v9hmgM@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Brian!

Can you take a look at PATCH v10 to see if it achieves that you suggested here?


Harald
