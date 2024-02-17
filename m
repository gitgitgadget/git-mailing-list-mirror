Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8741E861
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212901; cv=none; b=BMuYqs5YyOup0hJZZ5Ad15dWpTgI0EQhrFhoPIVj54Udk5CWf6Be0tu+3njMYqZcnSNmBQs5/NahKZsf+e03uIxNrAUMziLE+mmXDJJWSFgiMfRCcg9UimiQXXNMqfaY+CvTAevx1vfLy8N32T2k8O8XNbgoqaGHC+XTiUfg+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212901; c=relaxed/simple;
	bh=+qBuyqFMegYUtuKNcFkrikKzN75aDXZZT3e6wmRlBl0=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=iqaSxKb8oOUyR/5C57DQa9il/L+dnFYTPdPz05HHLmZjFBykj9QdN1p1L1xtj6sooa3JXetTbKn+RzjNflzI7JCk6YaMHbcVAlFEiU/bcdUfN1P09XfbTQx4fqkzi41e1BE2n2I+4TcLxEHmO+4q3crJvc6cwmDpbtE3VcY5f1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgr2tfla; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgr2tfla"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41260adfea7so1652725e9.2
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 15:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708212898; x=1708817698; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pq5e30m3oqX2UdC+k9aPVrVnQkr/XEs8F6NfAVTstcA=;
        b=Hgr2tflai4SKulLRwpW17XT7y9MdNEn93OxzHBEzFCYodAy9teI7gj5jV+rIhcHqGC
         C0g2mgz9mmvM9h0gib3MucepITKZTThzgABVcEaYfDZOWgVqyd5iS0LysnvB6sbbHTUn
         WoSitRX3RpuH0ANg7zNj9ZCTUlrbQ9R5ikwcJ8RmO2mORfbIabZSPg9ERv4hl+9Wyvrr
         F3hPbIVi9GNFBFyWDtU0W/SrG/9PDl7e3Y9LY+fHtIWgtgIhcRm1EAjaO8mS7ED4wYB9
         T7l3G274Nex1NtOD2c7RafZZ3UTKrX7T6ln3woKBSemg6I1IyV4TtEGJuynoAacVL9AW
         O1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212898; x=1708817698;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pq5e30m3oqX2UdC+k9aPVrVnQkr/XEs8F6NfAVTstcA=;
        b=mO2kY/2XF00mAfpkklKYFBFvq7lb75ExLoxrAtKOci7IeO9Na/hCfgEIgXfyvwj3wN
         R2X+7Z2tphyR2DBPx0a8C40RA4dagRkHXCL/5g4kYsKN44Kg/L8OI9GztVe4fQ+7gchk
         jLUUXkMKoF2vzIAUKw/gsrS6Qu2s0aZz2uDD3pNLccvW/kiY9ZVKF4qJru8BHotXocnk
         peZl/tW97LA7YL9CJPSCpbkhQoKTsAiIW1GCjUchDZJx49ccVZQhWksHFsBurbRTu1Xq
         isBHwtziztMGokZ5P7S8xcqAsMo+0vZZnSYaCgdi+i5+9HMm2N7EKAKlgrEWi+i6wB4M
         FaVg==
X-Gm-Message-State: AOJu0Yzoq9YArlFAZGYsCOVF23Q78ei3lpj9qKADfB/a3Tz3cLGpgFk1
	q/4mjewjnRcjbxobCGWZcvVW+Vx745kxDtXpYRBkQ0pfbQVAaTYANb2dsnuz
X-Google-Smtp-Source: AGHT+IFICyaD1anJDQJUBo0lUxvqY429cp89uwu5Mw2U9uFhZrx+/eyB0JP17wxlqsHcHQqnRH+Zqw==
X-Received: by 2002:a05:600c:3788:b0:410:c148:2a4b with SMTP id o8-20020a05600c378800b00410c1482a4bmr7329215wmr.37.1708212897523;
        Sat, 17 Feb 2024 15:34:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm6423702wmi.34.2024.02.17.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:34:57 -0800 (PST)
Message-ID: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Feb 2024 23:34:52 +0000
Subject: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
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
Cc: Bo Anderson <mail@boanderson.me>

git-credential-osxkeychain has largely fallen behind other external
credential helpers in the features it supports, and hasn't received any
functional changes since 2013. As it stood, osxkeychain failed seven tests
in the external credential helper test suite:

not ok 8 - helper (osxkeychain) overwrites on store
not ok 9 - helper (osxkeychain) can forget host
not ok 11 - helper (osxkeychain) does not erase a password distinct from input
not ok 15 - helper (osxkeychain) erases all matching credentials
not ok 18 - helper (osxkeychain) gets password_expiry_utc
not ok 19 - helper (osxkeychain) overwrites when password_expiry_utc changes
not ok 21 - helper (osxkeychain) gets oauth_refresh_token


osxkeychain also made use of macOS APIs that had been deprecated since 2014.
Replacement API was able to be used without regressing the minimum supported
macOS established in 5747c8072b (contrib/credential: avoid fixed-size buffer
in osxkeychain, 2023-05-01).

After this set of patches, osxkeychain passes all tests in the external
credential helper test suite.

Bo Anderson (4):
  osxkeychain: replace deprecated SecKeychain API
  osxkeychain: erase all matching credentials
  osxkeychain: erase matching passwords only
  osxkeychain: store new attributes

 contrib/credential/osxkeychain/Makefile       |   3 +-
 .../osxkeychain/git-credential-osxkeychain.c  | 376 ++++++++++++++----
 2 files changed, 310 insertions(+), 69 deletions(-)


base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1667%2FBo98%2Fosxkeychain-update-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1667/Bo98/osxkeychain-update-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1667
-- 
gitgitgadget
