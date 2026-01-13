Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1DC389DEC
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298092; cv=none; b=X7yaQHMspWiCkaEx+LuFNQ2v29TtPLRz9mtBk6GpOYWtbtKtnPYc8n93sOJ4TKiqXys61BLVORkl/qHvCTtUhhq/fAz/wq107So2jCyEJfi1QxOZ0nF9EFdIr19Eqr2+dN7uKRP/RQ7uGRzGBuz0SBO4+R2J389lovi+rUbyx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298092; c=relaxed/simple;
	bh=caIxGQFV6dQHhbfL4V+vGnobusjld0yMGM1Qf6qgzQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7m8vgvg0gqwt4zlE0OdJw9ufuc9X1lVmk+BiEYG0jvqXF+RYlQ7BFHawhfcY5fkkS+ND86zZV642kQH8ESRVD5pcgrj+TB+Gi8v+QM3XKJ5d5IwOoE3S6cghyBEz+KpVdar7/HGje1CZCzl6sK/2UHxjxcZxMMzDZxS3NEfV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBOwo18j; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBOwo18j"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso50589361fa.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768298089; x=1768902889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLaTg05mKojFO2vtCcDjbgIW7cTtAr5HXn7CDq5Hibg=;
        b=nBOwo18joca7uOx7Tx7W2hjYLmOb2+iJh5p9lD+GWBcA6r/6KO3OMeltSXfRf4grgs
         vbKRgxNNtgj0zg9N6yrKgXpDlGzN0GGRHVT/2ByKpG6m0XS+aZU+79cnm1S4dWHTc4zJ
         Mo4pCNTEIPcqnYlSJ2EaiQEByGXdcASkZK9KH1A09w4aPt4I7OXO08PZOpQX5VfgV1po
         CUBuKC9etw//PY55Sj3Ll1MPJOdIuaIiwSPDdGO6EzkujyxiBUK8QdW7YMC8X+8QGmni
         eKk3wJFSupxnu92bTrEygahAs7FDOhV/odROdPSWjCV2UTFRhojq5zMpL3tesTAA3eZK
         +pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298089; x=1768902889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLaTg05mKojFO2vtCcDjbgIW7cTtAr5HXn7CDq5Hibg=;
        b=JFqfbONuuBbL3yttvzJ9d2I0nkCOEAnjxot0RBntR7eMu/UH21N4lWFDIWpGkZwdU9
         98Rssc5srSA6sFPrv5sCjta86QqCaYwzBrul3QU4Z2F1dVObjLG8PVcP35fx7WVwRw+9
         guxMNHtMdew7LxU2pHtQc2FrZ/DjwQHxOyk1jJ0huwGZehnQAO6dVkw4aQ2me0DVlwoK
         bmJKbDNgxBcEoZBuAFg/GmA6NXhLEP7gVJ4DpRa4HLIMDz/DjynSpT6iFXxfFkRwLddt
         zcDUR5cr51STQtt9SM7ssDdOdpUZOGAB4b8EmBL5agclhUqFtKYDSWBbpHuR9uDzRF5A
         02fA==
X-Gm-Message-State: AOJu0YzvaETD9Z2oCNu2VnwKv3JW8ysxn2FXxOxqxx+Vdt4lVwhgozY2
	7B/ct2RNSvxJ2ug8r1tUUjre90+wtYeXjOJemdRJseuSAqtG4+CCQ9OB
X-Gm-Gg: AY/fxX633uvODFcjHrdFdbV3I2NFOegZ5VrzR1Ra690pOTZZOIVao1kD5XNWF/NzzER
	U0GAkwxzWLV2dEb21wP7EFi4BTNYa6IHwtAwnjjXFpkUO4c7+GsfCz2QAcn1hg5DsELxgDFyki9
	OE9oBVmkzWyvgwjCE/vgSr3fuq5SgJx5nCdXfFJ65QArF/U22lsLOdpcROYI7EeS1sa2CXDoUI9
	XyY3KExDD/pAapkzF2T04h1ElOutViT1eG+EVyyeoC+WCEhyhu0SxT26UKRYEGYoz1+ABc88/pH
	nD4ZppZsS1re2c57E2ChQGvkurjzGtKHTKDR8INgjQdKaN4lZQRbubsZE4IIwayZIxsYR6h1PIZ
	+d4S/dHm7BUi282Vz3u4b3/uvGSU4/gzWubdF/d0qCV3ySpnSDATO7qd5zL77eG+pK3eh8Zyl5m
	XOeklaWMqNkPZzSsIKdmQaWLhFzU8Yh4xH8GdPvNIbI12WlwRJmhabJvtCu7QEA9dP2VIfxaQ=
X-Google-Smtp-Source: AGHT+IGfZ/VV1EgIpQfm6XbEYEULUZrE47bR1JFdMDsAC7mrhCu9j7Uk9iKF0W4PaNZRuJvhez81CQ==
X-Received: by 2002:a05:651c:420a:b0:37f:d7eb:15bc with SMTP id 38308e7fff4ca-382ff860204mr57222451fa.40.1768298089113;
        Tue, 13 Jan 2026 01:54:49 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb3a0046sm44993431fa.8.2026.01.13.01.54.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 01:54:48 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Tue, 13 Jan 2026 10:54:47 +0100
Message-ID: <20260113095447.52482-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqv7h6lfua.fsf@gitster.g>
References: <xmqqv7h6lfua.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Just an observation, and not an objection, but it looks curious why
> the last one is so different from the other two.  IOW, the above
> makes me wonder if it makes sense to roll the show_divergence_advice
> bit into the base_branch_modes flag word.

Good point. I changed it, it makes it nicer with one fewer parameter.

> Other than that, this round is a pleasant read.  Thanks.

Thanks for all the help so far!

Harald
