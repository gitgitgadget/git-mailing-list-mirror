Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B143CEEE
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132687; cv=none; b=doFP+OcHWh+3Ec+1f4nuYncKF88gLhiw84w7NqHSN2DgUatQhnQ/1ty9+sLtZtfUyZQ86R1R9drTFTN+BmMzoG9D9tKtGsuLscWIl9GjmIErB2jinKn7JsuiEHBeIT6mAhQN0XysYZ/29qItQrB7InR2liKG4d+WS/pzUkVL0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132687; c=relaxed/simple;
	bh=VTfoRK8eaLCvRlhKSpw4RFMig/KjfePqCowunvWLVqE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jpJM8Y5M5N6rXR9CDV9CpEauQxjBz0rePwZ4PFC/BxbDJr1Mhoqsk5astEFqbczcu/1qyOyQTDf43jYfiys5G2+vxCAAvT8H/Bv0POSCjZiLa8hxeQT9ArtVtvtrzsln8fGbsWywTmJQ0b0VbNhUU8ZJa7MZy1tooJ+9Inn6fH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUPgupyU; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUPgupyU"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1271257ae53so15524410c88.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132685; x=1773737485; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqsroTL+rCK0LzEXNwNKc4l+JVaDecIBuKqnui5Xlqk=;
        b=dUPgupyU9ZNCP0g/dRmoP4mG9dPS5BzeNH9GGpAeOZ2NzVKqZegLjyY8yCXZurHTq2
         gHW7JBQIoxT+ipljWD580rkRchwJQG0YUsfnrtWGeAXNhVQVOc6u8liOKeQfy59ttOs8
         p6nwUQkKQA/X5Hcv5ODS4ADIIaeD69jAzZjsc2DLVq6V1aL175lChR6bwHsiEmPRgEQ+
         zP7bCxYiT5jGQPdi0120CBQtzDPyuHVq774CrIicFKF5gMnsSL/WK/yl08NpDeMz0OpG
         rSXYBwZZmqaxSSM7jI9iimizyWdeVPYn9rbYN/fiNJRdrPbPtQrl4RMz60NytL/RwxAq
         BQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132685; x=1773737485;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqsroTL+rCK0LzEXNwNKc4l+JVaDecIBuKqnui5Xlqk=;
        b=Un4LyulVS8TYsVJFd0yQ9w+NqUeNYxPEPOIJNwW33T+AZnotFMxgIDKecpxjlhLxbc
         gKjvoCUkzn6tKhEU5AO76GXHyRKTbTm8Up+eckoFgyw5S9xRF9CZuB8hHE5rfrxPAQsI
         JWbfV/LNODfR77b9T4dAhg6znFgjAjrsfwkZFZ/GiqayBBiGfClNNrtbK5+PMvhZu1QR
         7q7CwFFAI6+OP4hpTosT8FUrh2D0m+ktLOS1uVBsEar66JL/Y9kmHWszwZZ6bVd2FTDr
         EzaflOyOHdVA0ufZ/tzX/CtpxWk+8696cCc3aRP1WvujRJ69hlREwqAJV32oD9JxYz8F
         /arQ==
X-Gm-Message-State: AOJu0Yw0WqXVkWbGhQfpM9DU73vIzAA+7DRXub7qD6+MMzfGnLpYOK98
	q3qMWAqPZLfj0BokW6NLoRc/aNiN08FfkYv6M1Ob5NR4OE2V/kl9Idro1UmMlw==
X-Gm-Gg: ATEYQzy7Rk2I6kbyidvS3r4HfdlphmmCMahnc9cjo/7lVP0pnGOq/nIH1Ry8eHtgLr9
	L/lRZqxV0/cRChEOafcSSO+CYB/Ft2suS7HX0SnLa9cTkUJfHpTTZIQvoTGbQ8YLHCywUA/HxBT
	9+SoCoXJ5Ni2AP6EjNWSHhPuFqZM3/XrHUzXbb8CFr+HImPvrGeVt0nJEy3sOK0Ni/OsjPw0lVz
	seGbxTlK9oL8uUremHGTVy9GgpckmB7e4s7IzhwdC5iKlR/Z1TzBTEEjJUcpCEh3HC4bcjWQBb3
	2NhU5UdlL1atUmiUOQsDTVXoDwq1//nqr2n95JF60xgCN2bCW+xTrOw/mSoCtzO6925/swgIL9O
	ZpGOmH4P3agGlFRgc5TtQz8+hkAMqybFb8aEM4IYuMA6T50yvkxHPDO+cugMO4thn4TOK67KgKj
	Xh54q7v+BnzRGDlW1dsk0WCfj5
X-Received: by 2002:a05:7022:eacd:b0:128:d2a2:1d12 with SMTP id a92af1059eb24-128d2a21eedmr3655678c88.44.1773132685184;
        Tue, 10 Mar 2026 01:51:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128dc108d37sm5875320c88.8.2026.03.10.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:51:24 -0700 (PDT)
Message-Id: <185356a454ce8074ee8be5ebfee9e9086ab88b7b.1773132678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
From: "K Jayatheerth via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 08:51:16 +0000
Subject: [PATCH 3/5] repo: remove unnecessary variable shadow
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
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>,
    K Jayatheerth <jayatheerthkulkarni2005@gmail.com>

From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>

Avoid redeclaring `entry` inside the conditional block, removing
unnecessary variable shadowing and improving code clarity without
changing behavior.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Acked-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index f943be7451..fae1141cff 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -445,7 +445,6 @@ static void stats_table_print_structure(const struct stats_table *table)
 		const char *unit = "";
 
 		if (entry) {
-			struct stats_table_entry *entry = item->util;
 			value = entry->value;
 			if (entry->unit)
 				unit = entry->unit;
-- 
gitgitgadget

