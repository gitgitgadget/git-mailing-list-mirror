Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36E19F13C
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571467; cv=none; b=NbrlwCx1e09bJWAPGPCmNSHiVtHuaS4DE087KuGapv2+5nFgIitO6h/80W56j7JISHLkidcG5DpMdH+j7DZOfjchMQ4zSzw+SPHLGCyjlBCNPXSq2/ISk2FJRTZjvW+9Rl7YZV4TOT5REZ5t43muinqnznMn4GVt8MkLnMr/0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571467; c=relaxed/simple;
	bh=QXSFG2qXO/mvjS+wkdI6Xoo5NJIVuKHMAN2mVrVklz0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VO0RL+Y8mBt1I2tBqf5Gv8wjjt9H2TwB8CoBH32nqP9z+hq+Cr6xrjcyjfMHDfZVSr2GhRjR8awPcgXrnyE8os8Tb2neLIXYpsjZeWjdgLgN4F4UoB1OrZ+JM4PUiW6axxyhaK/YibLw45PI0qZvvrcUrRETWes0FzsHA9+2l38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+Ia35iq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+Ia35iq"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so1239279a12.2
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571464; x=1742176264; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/eGGOZ1MVQ3Aa7LEyzHAhvSe7KJMa3QIegDMdZ8sBM=;
        b=E+Ia35iqvQLD9AJjXgosvccgIGzbKq63YlsIaaHPmE2je509ugeUhwOg0v0tGi5C6p
         ok0ohIhPutq4+Qu2HRZjRqEWa7d56uhcccr/6V8/GzJSmLOk8Jua/kDkoQP6z4ATkyNI
         cOxv+4UcA/Tdk3r+JRmIGmyVsxnzDWCcvvkou45MNSwmucInsgAUe5ueXOD+NEfqF7La
         1oY/HdCU21KI0a6rtHqRvZlCo37IWtgwog0jCSQBXELajDv2VFQbG/kgzmn3YajWx1+n
         CgAOOehg7C46K07l4rDK2z8SPdjGjBQLYBz0sbNA4anD25PYBC+oaZmfH8NwAvRFWJSF
         aZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571464; x=1742176264;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/eGGOZ1MVQ3Aa7LEyzHAhvSe7KJMa3QIegDMdZ8sBM=;
        b=EzZayTsU65I/L7DACCDylZSt2U6Owedz8E1J1aUvTc3mdgvSx8axhPn/7+6hNydZex
         t9rz6yhQPSJyU/dQVcAx36rjChByemTuAvuMMl+G3AE5ujUYUtLsVSdlxGIPkd7Byh1R
         +TXlbgsMIoEoM53jYx5jJ4Hye8exv1CBzj4Nl7QCQekZdIUPSjAVqHvT/18x2rLoiyGx
         sqYNDuvT1SPP7BAiYY4gvVc6fabFGPIxSjm4/rNuvqkvuBinuihgF59FDJ7EviaRjjUR
         WdMKFGt/e72PjZKTMTTgYROEY8kqG/t6Cd+Z3oOpUK8qgvglO48hx3usRkVu+C8ZV5l0
         NBAg==
X-Gm-Message-State: AOJu0YyE8W0GVhDf/4PnAtHKbgWqGzhe+u/gNl/1ihAyXx+NQhKS+iqD
	I6WzW4RkUQe8BvbGAZZVq7uJq3g4igEpSRQPJ3mkFRuY1HFcZpTOBQgaLw==
X-Gm-Gg: ASbGncvwjRjlfBx3Xq2Y/LEKjGW21Mf+0u3/H2XJEv+RCyX826lQli1jxvnJME29pD5
	Gv+ZPXcuX+/GArWqARMesJcdVCmQYluxMAF8TGKxqV5l5/LQwApgrwW1BydH0QqwQYVweabQoo2
	zIlxWzx7OJN/WbVZUtB1Sf3uMM07Y7iZWP3utxjcMo6NuTq2oPo4ztf0GcAqn3XfFsZudCREb3g
	znqIsYrYqC+Nb9NUdN+/vh+4Hty6z6Ptw/fKqgjnoRFbOOFCr+H4oI1HWoNAFPLHMMpET4XjRAS
	kmCAMgLZLVSke/raMOz5XFUflKde3rBy/fAnptX/P3SZVw==
X-Google-Smtp-Source: AGHT+IEGSSNjCEoHUutyCjX76XDbdHsyM/YZ8Dm1v7Afjljln9FyeHOeiZ+KvMuq8Cfw0oovuLJbwg==
X-Received: by 2002:a17:906:f58b:b0:abf:6f87:c720 with SMTP id a640c23a62f3a-ac252ae319dmr1318110266b.29.1741571463686;
        Sun, 09 Mar 2025 18:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399c9a79sm671724066b.162.2025.03.09.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:03 -0700 (PDT)
Message-Id: <fd9a335329e9932131a33104c5a136583fad5d23.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:51 +0000
Subject: [PATCH 09/13] scalar: enable path-walk during push via config
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Repositories registered with Scalar are expected to be client-only
repositories that are rather large. This means that they are more likely to
be good candidates for using the --path-walk option when running 'git
pack-objects', especially under the hood of 'git push'. Enable this config
in Scalar repositories.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scalar.c b/scalar.c
index da42b4be0cc..bf638fa34b8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -170,6 +170,7 @@ static int set_recommended_config(int reconfigure)
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
 		{ "fetch.showForcedUpdates", "false" },
+		{ "pack.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

