Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF82D837E
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405268; cv=none; b=bahIhEt971knKC2FejHWvoI12nFX0XLO1z/CNfNE4AS9AwxX2S0z004cZMVC8SlrEKHves6LMVvbDFKwwvkWbGtXhkNO+O+g1YNOP/tSn1gGY1idyrIxU/R9vLf93e2dK8FwdiHfFkIiQvAClCWaUYYNRJGBbLGj2DPngVzZgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405268; c=relaxed/simple;
	bh=bWYayIdhrL3Rd9AyUDHHyctlfsCBet/syl/FcLqzcTw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m3v5hLunQ7dfpEHXlxS+aJWpXMWnmonEBnht5i56ar9K7D2BcGgPDY1qXUiUdrhKB2JgcJq493NwtXcj+ShSqsuxEHVnSCsdPkj1uDCZ9X5qPduyI9ZwWIERjnJkUYoO+5TVMqT9As95X1Ft6jBVprUez11HHE/GZXn0WUtnZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI+uhM51; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI+uhM51"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8718187eb6so503149266b.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405266; x=1769010066; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbL8Zw0MO0kmyQH/z5LSB+ZLee09mFf36t+GP7u2tg8=;
        b=AI+uhM51GKaoq6wkML16JF/WesvB5wvD1b6gHsTnb0Jh3/eCe2iLwp4EvU2VrsY4qu
         51+NyZ77ER+7OfOkZWBfaW2YXzUa3U8p0lE7jFRlTu9+E+2F8QhN9gE4dwRRPGUQLBrw
         9TBPctPVPQ534yjlV55mlW6fo3pUaSNKaCEEyr7kYI8Dx0XioE+47UGf2BNq2+VK9n9L
         OiOZ+Ad4gGkFIe/v1VuNgzjoFeesPJzN8zhINBc+IwMe/pnybh3PzsTjjbHA3QeN92iV
         Fk56/E5evLAR2Pirbr9OmXN/qyZBkJ8DwOXuKMeN0N9Zr14/o/aJo+1VaWuu6L+uX9C2
         O1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405266; x=1769010066;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbL8Zw0MO0kmyQH/z5LSB+ZLee09mFf36t+GP7u2tg8=;
        b=HsbLgwjACOu9+wK2zVPFcRq70gQxt5v9cBppFGO0IFPpkhsZKkMz3lqID8G/VZB7RS
         clmW3ff7jIs5XUTDnkqOv6C0sg2UoQQV8uGh5z4bn2YqztpHZIpcC2AQRMmsexKt9LhQ
         d4yEgVG3YB3qUFfoPQEns7r2PizVEAOl78s+22gPCkzlHa2M+PFHjr9efwW79SvXM9m8
         /rz3Mtu0ihoJPAwfUb/nKz6DywdL+7MsTYJpb6WS1mDLG46ENSX8NzO/ZvmIvvt4XLhp
         RjH54f8I0yXUPZFnG/TNssk6T21k2EaCv/LjP8GAOVH59RRKTf0W+2v/RHAUiAlNfaTR
         blEA==
X-Gm-Message-State: AOJu0YxPSGWbIcdT7rYJVnqzdcpWiZn2z/z6pfVQfjZHX466pWmROSoz
	bNRqB1HuYAhbhKCzLsyEk6A4rFKjH2MKKiLLC0C210Shf1Zv7XLVhzC6Bnz6Ig==
X-Gm-Gg: AY/fxX4THk/BapPCYi8+r0bBHFBoRN7RQgCMva944fwnnb3pmflxocZw/m6x8N29F9A
	bKRlbfY6AgOlSBmsvzELeTCNeQ+HJEsPfhhpRehQYhJXpgZ9UC8Mk/foMCVitHCCoIQsi5yRmco
	7lyaCekm8LHKznIAOzQZzF910hywYzO5CXjkuK/F8QnqJipXRYko4iDdMXnz4ibBkh/JGDhJnfC
	Vp68hhw1QSbgTinePd+Ld68MZCDvvAnGR0MGGz9Oeu7FBTc8GinDu+gGse71RNQSmIRpkm77Bsa
	hTJjAL5XH/3AYirM7vHn1f8Mrk6iNYBQ9ZHRfVefjPTy8ZPW1zLZpKe9KTF0WWZnDhSRg9xPouY
	a7/KhZjfsBZsUhQN6FofDIBgJCpai2lBALn6nM9ZL7qkjDORkOMgQCYY2VyxRAY+Ng5x0Ai0Wpg
	1hQw07LexpVyKPwheR+Xg=
X-Received: by 2002:a17:907:9629:b0:b72:70ad:b8f0 with SMTP id a640c23a62f3a-b876127fe74mr247397666b.36.1768405265482;
        Wed, 14 Jan 2026 07:41:05 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1b84:297e:182e:6730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872642beb3sm804851166b.46.2026.01.14.07.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:41:04 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/6] refs: provide detailed error messages when using
 batched update
Date: Wed, 14 Jan 2026 16:40:41 +0100
Message-Id: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPm4Z2kC/yWO0Q6CMAxFf4Xs2SaMGUB/xfgwRt1qZCPrUBPCv
 1vwrae9t/euijETsrpWq8r4JqYUBfSpUi7Y6BFoFFZN3bS11gZaYyCjz8i7FF6JC4xkfZSBHEy
 yt+L6BIwwLxwoeogidGmaqEAanugKQ0ny5cEQ0I4Muuv6dmjq/nK2SqJnudH3qHW7/5mXw7l3U
 dv2A2fvP0O4AAAA
X-Change-ID: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=bWYayIdhrL3Rd9AyUDHHyctlfsCBet/syl/FcLqzcTw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlnuQ/q0sgIDWWKOq8bSBZp+ZVHsRH3om2bt
 dADcurJmJf6wokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpZ7kPAAoJED7VnySO
 Rox/ry4L/0IYq8AOFpM2JJ4TakSNwQZ52sQZxqbiDPaOgtKj5GvTgwhD944nfeK25B5kdLQHPqv
 FC6w7yqWEAOaCnInMYnHH830n8GoiZazNcDRKTBcdKuJSqnSmLopwg+HG/J3lAg3azTmGoE/Ca8
 IahT5AXV35Zopr4iQD4kOOlTEWKDWsVnxUZkMsYsBG4s+BTs/3q+kVayByuHWvusecRT5gCrPYq
 TyQcxJ7vNinncUu1953RQ8Tl8tU60DdXtCen/oqARord2aedQzAZTDGyM9zhsi5LbiOHZD5fBoy
 kMnqWqjM+LV+yju/eO6meQ2zDWmMltr5LirgqaJa1LTGRjJiIcmA3B3RR9NlnoV2fQphgzvoK2x
 N79yHXP3IML0gkRNYcgdUWMZhcG6IMPsG9TFL/nXMQSYzslHzqWyRmkgi6m+cXVKeAAreEEV03X
 4x0Lst4wRAW0vEEcq/y6qXIGGOcoJqJb7pi/fa8oIZcJmnQ9c73r6XUdTO2fXiT/qRVWY2W+F26
 7E=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs namespace uses an error buffer to capture details about failed
reference updates. However when we added batched update support to
reference transactions, these messages were never propagated, instead
only an error code pertaining to the type of failure was propagated.

Currently, there are three regions which utilize batched updates:

  - git update-ref --batch-updates
  - git fetch
  - git receive-pack

While 'git update-ref --batch-updates' was a newly introduced flag, both
'git fetch' and 'git receive-pack' were pre-existing. Before using
batched updates, they provided more detailed error messages to the user,
but this changed with the introduction of batched updates. This is a
regression in their workings.

This patch series fixes this, by passing the detailed error message and
utilizing it whenever available. The regression was reported by Elijah
Newren [1] and based on the patch submitted by Jeff King [2].

[1]: https://lore.kernel.org/all/CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com/
[2]: https://lore.kernel.org/all/20251224081214.GA1879908@coredump.intra.peff.net/

---
 builtin/fetch.c         |  9 +++++---
 builtin/receive-pack.c  |  9 ++++++--
 builtin/update-ref.c    | 13 +++++++-----
 refs.c                  | 56 ++++++++++++++++++++++++++++++-------------------
 refs.h                  |  1 +
 refs/files-backend.c    |  3 ++-
 refs/packed-backend.c   |  9 +++++---
 refs/refs-internal.h    |  4 +++-
 refs/reftable-backend.c |  3 ++-
 t/t1400-update-ref.sh   | 26 +++++++++++------------
 t/t5510-fetch.sh        |  8 +++----
 t/t5516-fetch-push.sh   | 15 +++++++++++++
 12 files changed, 102 insertions(+), 54 deletions(-)

Karthik Nayak (6):
      refs: remove unused header
      refs: attach rejection details to updates
      refs: add rejection detail to the callback function
      update-ref: utilize rejected error details if available
      fetch: utilize rejected ref error details
      receive-pack: utilize rejected ref error details



base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
change-id: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a

Thanks
- Karthik

