Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D63822B6
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570459; cv=none; b=WKyJUyJHvEH7fiVTHS2YHdfwScqw7tU+v4FuWAXQWQ8bUmZ6w7StDq00ZtvPZTzG/ot6whpR2zy9t7MsEcfsABPMJL+GQKz2lzosGkFKAiyFkZxuazeLZaUStaBHzjzQdP4yTYVNCbsSTmFWUM4Llb81bcIURTzWW9DQpHI4UIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570459; c=relaxed/simple;
	bh=CgaD7XqRSIEpInDmXKl76YzOX8E2bf8u03+QhSKLOW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5XLAUbgd5mcrieRVs39/1S26TvbAZSWcE2CeU6HZP2/zd6lcIbrGR9h9ea0KoB4jNxJgLftkSoVQHLGgbErkptTb/Lgx+frnacXgfW03A5iFYcZ1zC2oVgxD1gGNFBkoImkZI4zJ9NSg/X5gQ2AWXCa5uo6lqxlA7M3LwCwuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJAwUHok; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJAwUHok"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82418b0178cso3549312b3a.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772570457; x=1773175257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfYByuGDPkY+4H1ykHJB+mPNRgJj1CKJd8ECfgUELrc=;
        b=VJAwUHokFi8w4mxxmyD2VvDWpn6rJRaRf+9KQPhDwRZ+XgWcrLTuHuTC3cdCRincuY
         4xQByFKXDMWiOiGIx7nOCdfzoG5N1XspsmvvfBFA+o/Mcc/1Bw2dnGUCZrO3GZI/+mzi
         MgDRYf7BJKneaV5bJWGQ0XzWZkuULM80a0H6VzK0wmxuqMnGBEf85Jel70WZfT2KgVJe
         kaab3jHQuVcl5tZlD2x80iCRntkg5BsAr+foT8aoDDbVPN4C9VsKWMV9EkxwQt7XP74M
         tU37ZsMQ2zaASlNF3R5AyeceHPcx/mMuq7rlMrfVE3i/w+FX3+OKpAtiOj+kDf2NPVBL
         AM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570457; x=1773175257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfYByuGDPkY+4H1ykHJB+mPNRgJj1CKJd8ECfgUELrc=;
        b=LsjXAyI3DkS+Wf9yqWdbI1od6OVN6jK2xQbjcF0yIS0LlnhqcjcT5H+RxkTvT/PeoY
         HkKfaVs7X+4ws+2QG9hv+hQtXkbZojHh/ZFMWxgkoljbtSOGvGCaxdogXFHK5jYPzo3A
         IyhZdwO8xPoHopq/yOaC40Ld2AGoHNUIpSZLqLUF9cfKeFE9bNT8eUfvgRULf9rz1Dve
         yw2gC9GP2zBGEiOGzamgMrn+BhtRCA0tG1r6R3ADhXagklHvU02z/LBIE0O1406m77If
         ywAb3gmugDp/zkM1oDeKlnMy/+4L0ESG9IBd1QCDh/91RCYhVCV94k4ldxoLaRNdJqfb
         tgCw==
X-Gm-Message-State: AOJu0YwgAq4P10cr5VdpZ42gXl2ZbbWddt+jkpYycG4vh9Ge3oBnw24y
	QfJ3GKkK69LuqvCan+lG2IPmLu3SwqNAluK4IpG6DOIWjTu9h5ozkMPMS/KGcLcD410=
X-Gm-Gg: ATEYQzx8b0cvUriLjWHXu5FZ+4gfP5n0+Q8sUBDyJPA3YZ+ZB/imrSpLxjpWcs3xKs0
	oXX5pczrRgkQtHHlc9uKrztc2NDASZD900ZPsQpgCFeNvKrxHD7yBHx29aWJuki9X9yCXorjl+O
	Dp482509vLcNONANLpa6+q8OHz9FgCg0xTvWsV5nYuQn3Q6r63i8DCWiVPQNllh5UiH/ZdwMe+7
	gyGGww4U0pesGMoEqjqG4GbrMxXUH8g3FYG96K37jvF56frK2Bqb3V7ibhkXz7d6DWqWpMq+Pix
	5j1h/MIiXrOxu6iL7XgWnXEa6IoXC9SawhPdJbPYJmj5oq7ZZcSAV3TvxMLiyV0pqTN6HTwgCRE
	pd+NOaMb/V2pR7IRDATWmVHZEYjVIwGKtrtgx5m5dMCjKnqzCucdwZYAPHLZt+TJ4wPRyVx2b+K
	/F54iQsSQt80HpzoCbc9kVXiHhBTYXUKmlyzGqckoqe09qI5JCVRLuSMpVsII+flVU3vkivA==
X-Received: by 2002:a05:6a21:9cca:b0:38e:90ca:5a1d with SMTP id adf61e73a8af0-395c39f7babmr16173275637.11.1772570457358;
        Tue, 03 Mar 2026 12:40:57 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:562e:3a88:890e:9f53:fad:871d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c531sm15348524a12.24.2026.03.03.12.40.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 12:40:56 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v3 0/2] t3700: modernize and fix exit code suppression
Date: Wed,  4 Mar 2026 02:10:27 +0530
Message-ID: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the third version to modernize t3700 and ensure git's 
exit codes are not suppressed in pipelines.

Changes in v3:
- Split the series into two distinct patches as suggested by Junio.
- Patch 1/2: Focuses strictly on breaking pipelines to expose git's
  exit status and simplifying 'wc -l' logic.
- Patch 2/2: Converts all remaining 'grep' and '! grep' calls to the
  modern 'test_grep' and 'test_grep !' helpers.
- Fixed trailer formatting in commit messages.

Siddharth Shrimali (2):
  t3700: avoid suppressing git's exit code
  t3700: use test_grep helper for better diagnostics

 t/t3700-add.sh | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

-- 
2.51.2

