Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C183BF685
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328631; cv=none; b=D/SxtUJ/cWxHXweRi7MT7OTgm0d/rwzEf7StkBqPThXrCqQARw4gJ4bu8J32sGY3zfNzdqaVrWIVj530Fidtalj+FfQZWxxv9qZzYmcgD13b/AC/ZvLx0547kuLAUoCrB70MX8T4f/O8oquH9LmYv7iAC6IxqgwJrn5Lko2x2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328631; c=relaxed/simple;
	bh=2CS0HHALWZti5q34XPZyTsXltzom67K91jpLjfqBdRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfQdQXvUYOK0lhWQf+lYvuZDyn7Ly0AC/GYRY1k7rh4i7vp8a6oTewwsul8CPW180V610enwVsYOPwWB4dJDIc1P/P2/PH74lVWcgrXWve41buAwri+qP5sy6CSUgmOoJ2nJ+wBX/ZINagdyiCaISBRoe7dNEsKnBNmcyg19L4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igdYSLaM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igdYSLaM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4600ddc4017so1229222f8f.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328627; x=1780933427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEIaPdD88uqd/meSnFTzdgcooujJ9dHTdYsteJPM7Cs=;
        b=igdYSLaMpt6/mA7lLpyigWMiwxpqpPLrJnpQjacrZ/XnJR3+KKFCSgGN/wD2JSifxq
         ENbWedOAHQTspOMDXADIAcGtejf2lSqnfGpockh54Hxj/RM+jsEv3gDo9cQWCHm+mUNf
         6GPxvgHH40ieVdqgPdEAoteINbAtR5APh1tMBAVyBV6kop+iio9Zpag1n0sgK1FllPzZ
         tMcOXvYzaX8b3cEP9A9Q2/nbe9SW5JvyA7vg2J/W3jJFf5OVpt10dQINWacJ5vOanYQr
         22fZAcrXDufq0Vm8GhQiDlwxyBkGlj0KHoRfD1krj3RJLHTTortF5DVSrjTkjpuFsiD9
         ThTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328627; x=1780933427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEIaPdD88uqd/meSnFTzdgcooujJ9dHTdYsteJPM7Cs=;
        b=ky8tc5HTG/IWuOmKiBmXtb5YDs7jMaHNJ8Ai3oNOBlVqI4nMwlZLHAvO4RbJh6oyhr
         XuAFoFuNbJsZ4QOPS6TIWm8yc8RfghX7qnT396xC3vrjG/vZ0YA/qcLJO94QTlNUTs/i
         OHfh1iGSgtUpVdiidQSmPX0CwilLqqNvld2+svkzoi1tOWTD1iEC9i3mPqGf0ydy9etm
         2TOwioCFuWdQLmS61//QDRkWZTD4uPXoz8hlFN7Ol035gEbHPrrBvl7V32OuZ8CBuXjB
         XMF8FjLQmLGfZVcID4hnILNmAh+c+Th1w8f8ZnS8oOFJ/+tNFv6ilto6ISQQonRefDn4
         7pAg==
X-Gm-Message-State: AOJu0YzWMLkucUbrmXyWYTeTWrKLhkBYko9hkjRgbrP/ODTreI8+WYX7
	7qSrGbEj8HslNGA+nSzH8cSc/bzROry4BWrrkdR6V0AeOKR1oFIbK8ljtMJppfcW
X-Gm-Gg: Acq92OHgJIJTnwEs+RXMrFeEN1NKPXJYsuRuoSmAkhTLjM9VxiQX57sxUYgk8QuQkns
	/rlPvhjOn8gF4se+jBI3buR2gZwk1zmbcBwpstFQnP37BO1FXImWEYsvqib6OTZTh/DLYloKryp
	RIhGT0qtR0+yKVuG9uhq/RPzdwfkzdsFJ0msc4KpfP3kQOeObxPTvKtxHWgGW9r2MbPPNJtrpCu
	KKbpYiyROf4d19jUeJ2y8o5IIIuCSFNSJxKM4lUChMZlymuiNK/KFYBv+a86fYaOKuCQP8HTY0K
	p4w8mAojvmUJyNEYTRfADoLyUJlfhh2aUDdpvIvJh3SA6txqRUbp/cIDE0IqZcaHGfpKs6ybgY7
	I/zvFBH2LsbHvaKzfhwYdb3lCyB2/Y7rZMoBwz1eW0xJ9FLmh7SJcHmRTMRy0N9gdch4JqgdsHS
	PtmGjWMmWVnqnlf4I8ypuvtCllkk+fj6JGFvQvtsgGI3Uzk72lMyB8wrpc+holeSsHN/1DT5+SA
	8DL
X-Received: by 2002:a05:600c:4f0f:b0:490:482c:437e with SMTP id 5b1f17b1804b1-490b08872a6mr8014615e9.23.1780328626802;
        Mon, 01 Jun 2026 08:43:46 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:43:46 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 0/8] repo_config_values: migrate more globals
Date: Mon,  1 Jun 2026 16:42:03 +0100
Message-ID: <20260601154211.82370-1-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since version 3:
- Reword commit subjects for consistency (changed `env` to `environment`)
- Updated commit message in (move "trust_ctime" into `struct repo_config_values`)

Olamide Caleb Bello (8):
  environment: move "trust_ctime" into `struct repo_config_values`
  environment: move "check_stat" into `struct repo_config_values`
  environment: move `zlib_compression_level` into `struct
    repo_config_values`
  environment: move "pack_compression_level" into `struct
    repo_config_values`
  environment: move "precomposed_unicode" into `struct
    repo_config_values`
  environment: move "core_sparse_checkout_cone" into `struct
    repo_config_values`
  environment: move "sparse_expect_files_outside_of_patterns" into
    `repo_config_values`
  environment: move "warn_on_object_refname_ambiguity" into `struct
    repo_config_values`

 builtin/cat-file.c        |  7 ++++---
 builtin/fast-import.c     |  8 +++++---
 builtin/index-pack.c      |  3 ++-
 builtin/mv.c              |  2 +-
 builtin/pack-objects.c    | 24 +++++++++++++----------
 builtin/sparse-checkout.c | 37 +++++++++++++++++++++---------------
 compat/precompose_utf8.c  | 20 +++++++++++++-------
 diff.c                    |  3 ++-
 dir.c                     |  3 ++-
 entry.c                   |  3 ++-
 environment.c             | 40 +++++++++++++++++++++------------------
 environment.h             | 19 ++++++++++---------
 http-push.c               |  3 ++-
 object-file.c             |  6 ++++--
 object-name.c             |  3 ++-
 revision.c                |  7 ++++---
 sparse-index.c            |  4 ++--
 statinfo.c                | 12 +++++++-----
 submodule.c               |  7 ++++---
 upload-pack.c             |  3 ++-
 20 files changed, 126 insertions(+), 88 deletions(-)

-- 
2.53.0.155.g9f36b15afa

