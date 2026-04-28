Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF4395D8B
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389672; cv=none; b=f/E19yPDVMEU/Jk4zqN+1d95abuzwL1YAfExriyMc4ZL91BMDFeFeJNGkoZElA2rPO4u0iIWaHNAqPTlhGB082eJ9o1sY658zGv2py9Z1hVUkNOQ+MFzloTAuJpkr8DhPhKQvesAExcvKlTYeFOUtWUwv99Vf0QKTRdyIGBoK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389672; c=relaxed/simple;
	bh=lvCxLAXNzeClLauFVnmPjFYcViIKPdyh3polpStiJZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYfRz9eF5YloxcrdDjGesHw8Xd687No5edn1JHYKrwYkwv+cz15oV88AEIML1w9aSeyTBSbzVDSoK8y2gwBWl85xTAoLX0zvGGh9VicMvydO/IePnJRd02L3Yi/JXtaqc4/eui0/4D6PTCrWfD66ByVqbfV0jSR4nVeAPypA0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5yZCIaJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5yZCIaJ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a62a049c1fso8924862e87.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777389669; x=1777994469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvCxLAXNzeClLauFVnmPjFYcViIKPdyh3polpStiJZM=;
        b=f5yZCIaJf5zsze0Uj6ZFq8gO4a1FtJ8/LzGYaHCEGpa78tTTTI6WECR+Jzn/Ni1ewm
         AIjeLrZb2giAHUdZCK0BHgwY+f/IHUF89QvrILfVnUSnjGg5/SOiJSm9otWlmtFb6+CG
         Q+kZtL+4I6wAt8gRx2eAFXfBimy644kPFLr9TnqZ4gxsMNzYLuz5QcMW/THKq/BypEp9
         BPhc4906odEGxaLZFE9+x/6O9NzjZ8nnEi/Vkcgf+2/HkVtMycM3Jxj5x6dM3yp+joYL
         EqwlaNMzAOGdypUiuabOZgJQOG/HNDTOrRmqFViaN80y/ZjDBlsTSrAGzku5PPywo6tD
         FDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777389669; x=1777994469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvCxLAXNzeClLauFVnmPjFYcViIKPdyh3polpStiJZM=;
        b=V8akXClkqiGcspPMQ7nqcwFaXTkgfYgjqvOgURXC7yMiM0RhH2GKVas5yO405Wk7qV
         za9N7uxpx5Olyoc9/5uovfIWl6OTTTxqi3W1QCpetCuemzGJBE9kw6gzFC68/ynI1VA6
         Cfjm7UlcCuVING9EN1+XBAB2dJ8TiguUdoMJaH4ItqtSBICZxPNktgmE8FWC0GE7+D6h
         KggPB060rXIVT8F++xG0XZo5CCbBEGAThR7FqDakBNRkM0bAdibCRCcCaYdNS1cUIlzn
         xaAJsBYGe++/vapj4ykFj0QWzTgeKagFFlCr2ur68HGDFk2rDGFSR4956R2XVfMyGTCF
         N4lA==
X-Forwarded-Encrypted: i=1; AFNElJ+6/9XdEXYuig045rth/Dm7/SGKU4YNfm/cno7vTdGq7g0LWWXOopj7jCJblc4wtHaOd5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukKsNzHGb0ASvgf51Vhq2INliun/4S2HmP1buPQkv/UqveDaW
	6JjOkdUHRtrgNPrW8TqEop7xA0fprgsBiTdHB1HalLgtG3VCuN+Fz4AE
X-Gm-Gg: AeBDiesWofKP1dcUSDNNUV15m52XlPKJL7OjDh9iLl312iQs+wTtNLZDtHb1h/2zAEz
	1VQicBYWReSBdF5rPLxwjCVEvml72pZwMQi/yV7DF1Yjj+9hZ+BPW2OIvAtbByZXcwgpn//6903
	L7n0t2CHpVF2+W4Qmn1v6f7X/EZLdGtfkqRfrtPq62c6iUbwT6WHlfgTTUbPnf1LnQzSrSnRTkm
	MXtg3Pa0bPVW+bjTwIv0PgeVtQUvrLqqMxhFIzb5FT+NeO9Z8n2c/NISDeJYZDkkJ62G+LLHCZA
	uu2xcsq5v+sdzEmugMHVbT4HprPfQbEC+5vTJO3YKqxMrXH06sshJS+3mgGCFx7k8qJuARjts/n
	5xiXiUo+0+ERIn3ZfXOJWcDLdVWqmhUUgN64ymzwKG6EOft9yXZz7o6LsJGW5nVsBD4718pRnsW
	7FVoNdNRSQYhsPN3cDH2mIRi+XrvfE31EEZjqYVVRDj3jPsvzDq919SUOlPlhtkmKHfR0gMrVhQ
	/yEQXchhkrsfSn6+rOSFV9rrRO02Py37jv5pw==
X-Received: by 2002:a05:6512:1392:b0:5a4:10b5:624c with SMTP id 2adb3069b0e04-5a746618210mr1685020e87.23.1777389668921;
        Tue, 28 Apr 2026 08:21:08 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a746408238sm709530e87.71.2026.04.28.08.21.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 08:21:08 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 28 Apr 2026 17:21:07 +0200
Message-ID: <20260428152107.56482-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <66e3b1f0-e00d-4b9b-8ee7-ca71444cf56d@gmail.com>
References: <66e3b1f0-e00d-4b9b-8ee7-ca71444cf56d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It may well be that fixing all that turns out to be a lot of work as it
> would mean modifying do_create_stash() to allow the branch name to be
> overridden and modifying store_stash() to use the commit subject as the
> reflog message in which case we should leave that for a future series.

I suspect that it is a lot of work, so maybe also better to do later.


Harald
