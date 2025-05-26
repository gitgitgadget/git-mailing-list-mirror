Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F41A5BA9
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255621; cv=none; b=fO14e9PF2yZj6hBr2ugdI/n6uwaWoA5UNErZOmcX0veGT7sL2qaPNdg0pET4tg5ibsChBQry9Ik/iKJW5UuOqUS2unP1DGmcfD7WLNPPq/U646wa/aw6mX55S9z9zE1i+/88SvFkxnAkBqQuRfY7Rb2oUFck2pgXkZkcBILs6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255621; c=relaxed/simple;
	bh=TVq6MoRg+0DRnPoab3J4MeZgjGiIsUpkZv1UUzlfxb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYoCPNVZBKcnmP6hAoocbZr5DPbmuS5Z5V4NmqI3hbPJNji5ARsODMAF9WD6SSVD8tsA31UhLEgOOb9J0pVDuo04J88XitDJOdtyHTWXWS/pqwdeBpfhBsIF5/vxXMHklvdXAsh+JFCYsho+zg8dKQiNhMudXtCblc0OUwCrZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5ZRnxCW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ZRnxCW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4cad7d6bdso1300217f8f.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255617; x=1748860417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bMel5U6Z5yUT3l5DdciANEr3shfKxWw9kGTwhJFyc0=;
        b=S5ZRnxCW4x4TTBtKtrypEx+c/RwEaIGsjAb8RBdeUoYmWVTsl1h43EF+WuYlXDq1wP
         2asgrqV+kWOXi3Z11B8Mnvg89g4x4ayhkWwQOOZBLxs3NsYCh8/U0gaoJUgLRsuwsPQN
         hyrkUOGMCH70kHV6oDR+5cLa3/6AE2bjrb+kUOrKIxb8s+ETsRhV6FXu44ticP4emxk9
         g3yQXig31XTHLwrhjDXGaBQLvbnLSaW2eTjdQ4Wprh6DbgtenkDpeYhdSpc33flSKmfG
         bSeeJZglWiWgOuPlhcJwLkqeZE2l9Gc2y4fMoHrHbuZZr1ai/sLqBzm5bXTdtlucbAaH
         jlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255617; x=1748860417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bMel5U6Z5yUT3l5DdciANEr3shfKxWw9kGTwhJFyc0=;
        b=OkSy6isqKB84lU282nlaCzHHJGUmU5SxaotG7yvqb1fHt+YNqqDVmQ6YBdrzPS8n6u
         GyFJjei0euM2a4ZeOnHK0HPoOQdnlmd7p+lnCUsxB8DfWFM8qARMm0fuoYnVRXU/o8PQ
         TjaxZdJ0EHC0YW2xjaDWkiEMpGvjaQDB/hxs6TYW8m7kPYiI1OaCL7pDRb9wlJgnSyAM
         f0cwNG9PGNubF4QQQbWCyypeAMRUnP52agw3X6i3lDRp7xNHUdBcxgemNvBoIfaAB2pn
         xu7g1k3SeiHETp7qvJ5IWEhsy5Ybhv+bGynUUDXH1lKMT7aQNYrJXx3jYMx/cZjUWDzB
         0ljw==
X-Gm-Message-State: AOJu0YxciDwv9C1YJr0AKR3y7rAdQUNUdXVGiVihhG5s9ZWkdJx4hZI3
	POpnIDuY1b0Qi/fT3yp7T+Lr/WWV/eJ/w4RN5ujM7wQX9iPbrwToK1m/9/RBc8Mf
X-Gm-Gg: ASbGncvYYxnIv70bcf1IJ647pqmyUaYEJmU4aNjfLzrB/BQBj61I583ObOg9aHZH5Lq
	DDq3SzCOjMNFA3h9C+VX/OcODMJleyx910NHqtaPoPCx50uF8KqPgRrpw7ivSXHojOTbzyJoTQA
	FNb+OHKuQvUFJV8L+aDFyo4ZCzxcmH5iD2FWDT3kC5wp2YyI8NOb0Xip7dW2/H1MJJ1vxwTCdl+
	MnWW0JWB6c1w7NJbf8iSKMhHC0uXZxF6PKYHHDvpcuY/jzzWss49O2lXSsviVe79jHOmaIMem4A
	AaBMXuh5Hp8GrHpPbk70dTZrQLYnCr8sc+lPhDrnDSw+d6qxGZsD7PFlFJL4JOv/OyyRgKDqnUJ
	aiXA0uVhnOILvL+B5xMxr33mYdmx5EeFPurw+YzcUH3+lHPg=
X-Google-Smtp-Source: AGHT+IG9El6UKcY8zAdeGeC7wv8mcFdcolSAQWwL43h9PN67Vi4akkC+rQzCLdmlp8+rygspKHEsDw==
X-Received: by 2002:adf:f303:0:b0:3a4:d367:c586 with SMTP id ffacd0b85a97d-3a4d367c6d5mr3146011f8f.13.1748255617218;
        Mon, 26 May 2025 03:33:37 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d26caf92sm5071512f8f.66.2025.05.26.03.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:33:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/6] gpg-interface: simplify ssh fingerprint parsing
Date: Mon, 26 May 2025 12:33:09 +0200
Message-ID: <20250526103314.1542316-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.614.g649fb04ae6
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "gpg-interface.c", the 'parse_ssh_output()' function takes a
'struct signature_check *sigc' argument and populates many members of
this 'sigc' using information parsed from 'sigc->output' which
contains the ouput of an `ssh-keygen -Y ...` command that was used to
verify an SSH signature.

When it populates 'sigc->fingerprint' though, it uses
`xstrdup(strstr(line, "key ") + 4)` while `strstr(line, "key ")` has
already been computed a few lines above and is already available in
the `key` variable.

Let's simplify this.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..e7af82d123 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -431,7 +431,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 
 	key = strstr(line, "key ");
 	if (key) {
-		sigc->fingerprint = xstrdup(strstr(line, "key ") + 4);
+		sigc->fingerprint = xstrdup(key + 4);
 		sigc->key = xstrdup(sigc->fingerprint);
 	} else {
 		/*
-- 
2.49.0.609.g63c55177e5

