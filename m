Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12192395DAC
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842446; cv=none; b=sJLyqJCrPLXUVeprDVnneAEkcmFf0LXn7nxijkOvpVXiDLaRWVUhFu/s1x4DrmKvQ2uk7bgi9Op8uzpl63IRfQpBxPQlvpKgj4v5cnKGivNte2Gray7Wj4uSgL4nZI763OAZTGB6eiTozGJsunbuwgvD/532jfa5Lpc5MpNQKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842446; c=relaxed/simple;
	bh=AJg7fkUYlqq0Pk69ep8FNt1EuJLMQmYo/+HTO37FbfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxTREuakgC6R4M3Z0B4lKDiCyEbkVJk+bfu2btndVEQYTvgQuiD0jYCncbfXAWPKMdZRcafs+7YCLIvCI+Iu1Xji4B9tE4en+pC0NnLTyH42iPugZg5FCq22rgylFfzK9KRk3BNuPhlpgedn/S5W7vfN2Q4lhNgK6MQdVr04/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDj8/GZU; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDj8/GZU"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16079d54c17so2760842c88.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791842444; x=1792447244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMZyEsJBVSO44H7wx22ld2uQvwVYyXZgALFpPgKjIb0=;
        b=mDj8/GZU1XPX09Zocfa6XdM+IsYpKCdk5Ysx6vjt9nApXzrSP0SyEXuxpf8jonSr2V
         ieMz4Oubra24xecd3X8CVRfEuToKleMhSoQNEfERy6iY/fFhpp6LyDRkvOt/u/Og0ya2
         ClLfdhfCNzAGA9f7S1nfepMq5eKS3qsZXL3QubTStQcaSwu8TAnw2gb/EkBwCAOXpdfX
         9pRn/a4jJpjdJsN9iv9med7AyL5wq+IUzw6vGF1db74yg1b+CoOfLyPe346LS9BAjo5J
         p4BKbJXHN4Aazi4yr2H/B6HMgpDKVr0/lwgF8Utgj+eButQxK5nGS5XuPhumJbvKwgVP
         XPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842444; x=1792447244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pMZyEsJBVSO44H7wx22ld2uQvwVYyXZgALFpPgKjIb0=;
        b=SYuRH6+aBfmZE0tdvrRtbrYQAwE5Mz0qs+OQn5aceMqwrN30nLB5RUVgFNZOckhrfA
         +55SSqZobBeqSV/b1YmgnI476VvYTrr54ATGaaLq441KCvo/204Dap1XRgpfYO6wBhL4
         +qItySQ7Xf+hhfKLyNI68uQnJMRQHRiAWHQJOcwWjlkSS6I7VoyAqdOdNE32vWJ/ip+y
         d0yRkTWHx/IslNyM8v31JWEz1oN49nU5xHgMRPG/1oehN3780QbMUhUl6rtqC0t6ATQ2
         QywWXmly6U8FLx/n+Jtk7e0lyP41zynQsoZwMcZJw3om12qBedgM6BVPX6m53vs0tdcN
         xT7A==
X-Gm-Message-State: AFq9FYIm/R/3FIsunlwTKkXC+p0zVHuLglPxTMWR2UTNqKwiIVPQzrzW
	7J/g8E/B/ON11oGtboqyz/JZNkyfHjjcx/wWyAuON/oubcjKoXBUGG4x+qqbCaOksGA=
X-Gm-Gg: AYBFou3kDup8vkXC9wDD2MhIdKmRzHZcWu9OwPVYB8ZrUPNpHzXi08pwnUJ3GnSjKhH
	Ps+1PGP8dZgae2RrMkHD6/EOKrNszEcZg9S2gXr5ypldQsY8a7Lhqoc1BDIBkErrdVA8gGSjFEw
	UwrWL9Hsnl/7gyde5DvCy132sSwiHfkcZPB0aQx+XXtIRN29ip7tM2vFYAQ4V2Vu4J6/lT4e0gc
	sa4/zAUasBeNfh69zpE7or0op42u9eU8F9U6EjT/thZOkS+4s+T8wRnLu763rl3yCbiY9EUxc5W
	2DPzIcMqJ+4vA3/3jUmLaexkGX0W9wLV906nW3rE5So+JhVc3Fkxsc+zYxdlwbsNd/XNVtG9+lY
	aZINtDbhAYmUUzUFQgnSLIP0rHtFwQjTWdidymdbWjuqfYZjnVg/64Wo/lFC69ryU0XpiGoYI44
	7DwI6OpFhlEJAj2QVQ4mjLQdskjVE78dtqbE81RnVHA651ZHPJJYpBY5mtoOMB494W07iALPxE1
	GavnVu2rgf3jqb5GvXogMuqoy52a/3VMPPXPdmooyMmBYGcGlTW+8P6/7+PFggA9W/wE6o=
X-Received: by 2002:a05:701b:2605:b0:13e:5a50:1e17 with SMTP id a92af1059eb24-16a55487e53mr16411677c88.3.1791842443966;
        Mon, 12 Oct 2026 15:00:43 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm40825874c88.16.2026.10.12.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:00:43 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org,
	sandals@crustytoothpaste.net,
	Xiangfei Ding <xfding@google.com>
Subject: Re: [PATCH v2 2/2] imap-send: let OpenSSL do the hostname verification
Date: Mon, 12 Oct 2026 22:00:39 +0000
Message-ID: <20261012220039.136932-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
In-Reply-To: <20261012203057.969878-2-dev+git@drbeat.li>
References: <20261012203057.969878-2-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Beat,

> +		long res = SSL_get_verify_result(sock->ssl);
> +		if (res != X509_V_OK)
> +			return error("unable to verify peer certificate: %s",

I don't think this can be reached. With SSL_VERIFY_PEER, SSL_connect()
already fails, so a hostname mismatch would only print "certificate
verify failed". It does not name the host like the old code did. Could
we print the verify result when SSL_connect() fails?

Thanks,
Aniket
