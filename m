Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926CB19B5B1
	for <git@vger.kernel.org>; Tue,  5 May 2026 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972818; cv=none; b=IF9gkTjYChDcnAvqMoxEnsaMMhEiAJwS57LlxhZLYuSr29yCEbt5KCu9memRspOTNFJFqNsM9z5d5DHgJbvctfJuGgqW2bP1YhM+HtVFjlm01Qh7a0mrMxTXCmMFo0Z17lGwukh8VCT22fYU3y3uhNLGKiLv3chg3tH1kqRKC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972818; c=relaxed/simple;
	bh=JA5TGXdkPEPrJy5NtUtELa2Al9IGYqnsEpueEx6PPMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok9RmgmotbAgfXj+MzA5uNsD+dfxBjzzTz8qoahG3HzXYSyh5EMrIj+0hhLHpMVrKk92lY5DOAKys2I+gMr5AeexJv5IJbj5EvoJYr44I2M7NPcaPyAQrM/TOorQVW5B6klyHktxWlHoBasWRn2ub/JrB4B88XCikCfPs3O7dcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSHIn62P; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSHIn62P"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so40341825e9.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777972815; x=1778577615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65V6nDgIpDKir1C68siIYsRJtQWnd7gj/BdfPM7L/bA=;
        b=hSHIn62PgjnrX5b8+ZMVdHenYSEnm+hNrhXYaxPVxD86ewYgGSKfpJOykbNgOuyktU
         49iuFy3dGOaLuAkiYD5zANVpIedAtVWCApnOv+IynoiahBIOYH1alZ9iueO/94hHlx6I
         vRXf7lq13dcyxuZyaCCahtHD3TlyYW6I4pLV8hxWBpr/dMKyeBW/zB6JawwtqCWcZj1a
         0rySNlKWXpjnUiXi0uXcagzC9GKtF04Yv29XEe7faD3TjLDa0k2WouJPTlXOICIzBRIc
         JA4SuGfJTomnK+yeDQd+wjcelTR5Ad2E+4s145iGMhbhbwp+6OCFAxJSoZ9/n8soxx0+
         r4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972815; x=1778577615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65V6nDgIpDKir1C68siIYsRJtQWnd7gj/BdfPM7L/bA=;
        b=Q3FfQcaG2aNIiVk7TvFhADzfyXwQA2iJ/REOeSno4WeZwVlRyWRp7vXargt0MwtPPX
         qCC0FiDBhrffGdQzEo4SzOuueWP37Q3OM6QbbnvPQF3jqGeGOx2dv6qH4IT3ZMpzn9AO
         3uicjLuLlSFVz+is3rUIfjBLWILT880GO28+M/4bOH13hTyUeK4uai9fnBEXdHRtpfbC
         Qnd1HRY/Krs9+Acm3KQOkSZI0u3IvS9s0Ctz39k4rlivj3ZXs7YY7A5pD/IwILFxwDUi
         ckbVdZj+IEAZdhWzZAkaZuhhSW76z3xiI71VZDe9951ziRmNH79EoO5YYHj5Gk1aFGZ/
         BPYQ==
X-Gm-Message-State: AOJu0Yw4hbnnRK+TZPQPqADA8KTqoYeHISqeFOSRsBSQUqJPK/rVFLel
	H1FPeF0mnZXJ55myca1Fmv6VfVEbgSjIWYQ2TLfclhGBrsWU8HZxnCZRfiCSjvE6gXJuk5WyjgQ
	=
X-Gm-Gg: AeBDiet6hhIzoBli7VLuDzJNYhNB7vCAsKLsNFU5KuHoDhzsOux1u8bi/js5vTBMn4K
	NhW+QZfQL865D8horpbpoN/jhEkDb20uuv3R5w6xM8lx4TVcxT4ZyCulWV4xXez4YCOUu8Br0O7
	sRTWyvd+UO4tgF7KsIqo5sRYfLf/cJTDNuSb6TSFAfQzXaxAJ08w3iJFTI7qWHm+hNOc+E4NJkY
	8Uo5Ho0EtV6LZnL3U6W365SoCZy6L4i/PQLAU44yVbx4/RtGqLd6IycTHof4JiRPheBrGdNFmwR
	p5Cg9nU9sFYvo1Io1PqLa0SBvxif1JLK+rPnE5uFLgJffIxc1alVSjVLCwvMTlosewI6vjVRMql
	rSgmdq5nmPPmeoiwW9LAVZ/bpIImlrIFQrO1Mj+0nMLcowJ0ylxZeJ2TchO+7x49JoYz2YOOYLh
	j550jSo7J0Ru394+O/RWgwUAwXbHbDXHp5eYMwUPZQyOx9Qip0WoP2bnYzug==
X-Received: by 2002:a05:600c:528e:b0:489:ecee:c4ef with SMTP id 5b1f17b1804b1-48d18bde33amr34556625e9.13.1777972814519;
        Tue, 05 May 2026 02:20:14 -0700 (PDT)
Received: from localhost.localdomain ([85.121.183.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2fa5sm291828175e9.12.2026.05.05.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:20:14 -0700 (PDT)
From: aminnimaj@gmail.com
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ryan.hendrickson@alum.mit.edu,
	Aliwoto <aminnimaj@gmail.com>
Subject: [PATCH v2 0/1] http: reject unsupported proxy URL schemes
Date: Tue,  5 May 2026 09:19:39 +0000
Message-ID: <20260505091941.1825-1-aminnimaj@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260501190401.1580-1-aminnimaj@gmail.com>
References: <20260501190401.1580-1-aminnimaj@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aliwoto <aminnimaj@gmail.com>

An explicit proxy URL with an unsupported scheme such as
htpp://127.0.0.1 is currently accepted and treated as an HTTP proxy.

This happens because Git parses the URL, extracts the host part, and
passes only that host to libcurl without rejecting the unsupported
scheme. As a result, the typo is silently accepted.

This patch rejects explicit unsupported proxy schemes while keeping the
existing host:port-without-scheme behavior unchanged, and adds a
regression test for the unsupported-scheme case.

---
Changes in v2:
- make SOCKS proxy type handling table-driven
- use test_must_fail in the regression test
- use test_grep on the essential error text

Aliwoto (1):
  http: reject unsupported proxy URL schemes

 http.c                | 93 +++++++++++++++++++++++++++++++------------
 t/t5564-http-proxy.sh |  6 +++
 2 files changed, 74 insertions(+), 25 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.49.0.windows.1
