Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA241ACDE3
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767546; cv=none; b=fGDzREvKoJjS/+vz7/Zb011jAkwEJehXXbXoE/PuOWPi9ZJ5/zEuOA4y8/denv1w/emwDHPdx/M9W3Krsqbcp/FrDDRF+jUfaKf4AP8srL0UZaITL+m4vJiEIMojiSEzAI9LslFnVhDh+vPs2SY5EoXt8MzCXOkW1PVv3iTWvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767546; c=relaxed/simple;
	bh=1goBDk2AaJ4+cFHCKJH70kZtQ4dXC+ZSVASAmggzZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2oveYvQ6Ek2qTsY1lpcPer807g4JKotxpWoFESN2qUEUCXAilkvd4Dzvuas44wEncAODCXYKjzB1e/HDemp2ytCxxK0qWD+WSgl8Aao809vDn1Xi7Eg8xroF7wxf7EhGXvBtQlshqpV8rkyBpqSjz96Ux2mxYvtatf5TJz96Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org; spf=pass smtp.mailfrom=mariadb.org; dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b=JS8WHqpW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariadb.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b="JS8WHqpW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718816be6cbso4445519b3a.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google; t=1727767542; x=1728372342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87T5ntvLH5/C4fgpTri/fuzVD+UjQSoiutnEfho3aJQ=;
        b=JS8WHqpWjOKtB2/qc4fjxDj6bqKPf534EdYUfwCfinS25C7c7QD0egDsBgm9ASwXc9
         p6HmY6fTCtcmqngsNLqjIlcryiQTQNrfbGXe0EoRO6jOTyx/oF1i6tWfoGM8YLptH7B0
         hWtEkwnoOlABbkKaVQ3AiOmljNevdtf8AFuVbPUwTCkjr9tCrshgdULxPOkRg4hIW4PX
         6CQwCYUDp0Z9wQFzsJaKHhTg797ebi9dOEYkrIfewLKWxnRIYgGhOngxNPE7lgHwQZ6z
         F/J/0Uzu+U/RjuGREJgCUXbljyeL2pYNYIM3vjviyHmAKPEcQQgk6ilPdn8NWCwIbpzD
         rFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727767542; x=1728372342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87T5ntvLH5/C4fgpTri/fuzVD+UjQSoiutnEfho3aJQ=;
        b=ivpekeEoaJu6grrEpLz2B22uA3xwwQfif7I/nWwTRNYk7K9ZK2aX8JYR+p4SXt9tiM
         MUkQ8nTy/cj8YDpvFn+MQLj6rTShiw/mRSD1SdWSE7Lkrvu5gQvfXidm8XK9cwZF9IlP
         vpdP2QVN7fjEzMap4/mSrDX8DM7UrqC/kKhyItaY/Ko8s38HciqQFdccx5vu7Y5LoqeN
         uwEFrhG7Gex8AGkYYbgVswbgGza8LRBuIlAXZnCjRBmUFIRW27Nrp6v3SSpA+zJcun09
         B2tek87wVi/UK+8C//T47OOQ2dahhcyyiUv0GmsCYJIFtiUdzRkaVrf7NGrt+P+QHiki
         sQcQ==
X-Gm-Message-State: AOJu0YzAePaq77ON808F2TnQqiK/Z2Agzb+gI7PgR3GyT4jAHB172epG
	27zXpumdYzjycx1JoKyk4jcU+93L27Igdjy3X2r4FC5NHA8Ze9gLCzHCWhgIbbHCWIawt2I4ZVt
	rhC8=
X-Google-Smtp-Source: AGHT+IE/wLufRhJUTJIgo8S2xbMlBBdW/rCSo9EIaVZVEbD69zcCdlPp+VNI9SOqzVNm+Fr9m6+VVA==
X-Received: by 2002:a05:6a21:a4c4:b0:1cf:4596:d486 with SMTP id adf61e73a8af0-1d4fa7d120dmr21562302637.47.1727767542499;
        Tue, 01 Oct 2024 00:25:42 -0700 (PDT)
Received: from bark.fritz.box ([206.148.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bce8sm9342445a91.8.2024.10.01.00.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:25:42 -0700 (PDT)
From: Daniel Black <daniel@mariadb.org>
To: git@vger.kernel.org
Cc: Daniel Black <daniel@mariadb.org>
Subject: [PATCH] submodule: correct remote name with fetch
Date: Tue,  1 Oct 2024 17:24:23 +1000
Message-ID: <20241001072423.1165932-1-daniel@mariadb.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <ZJQr0_aC-NlLXDgj@pweza>
References: <ZJQr0_aC-NlLXDgj@pweza>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fetching of submodules erroniously used
the main repository remote name instead of the
submodule remote name[1].

Correct this by using the correct function
to reteive the remote name.

1. https://www.spinics.net/lists/git/msg462320.html

Signed-off-by: Daniel Black <daniel@mariadb.org>
---
 builtin/submodule--helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a1ada86952..210ae2570a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2322,7 +2322,12 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 		strvec_pushf(&cp.args, "--depth=%d", depth);
 	if (oid) {
 		char *hex = oid_to_hex(oid);
-		char *remote = get_default_remote();
+		char *remote;
+		int code;
+
+		code = get_default_remote_submodule(module_path, &remote);
+		if (code)
+			return code;
 
 		strvec_pushl(&cp.args, remote, hex, NULL);
 		free(remote);
-- 
2.46.2

