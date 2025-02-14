Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F548264A80
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554585; cv=none; b=eipA4J9GNPdNUVcsTkiz8b2PHX56DJfwPTwWPmVjR/lZ7IHAnBOMACyuK+QqzGSx0/6TBMWGXMKzcZ5waDOLTe0TVFoArVyq/4Bzdw1Y4mwnPPN/dhEehW6tYUcula2t7cQe68fXmL8Llp16X/vRp1szrqPgPzc8P8bdm8x2Cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554585; c=relaxed/simple;
	bh=7DvDnDINIggqyE+HIdh+nHsFJp+GEGdRkWHeslYJiAw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FT19+aOxF2Z9NLh3ZbO6xGlL6unIH5eqLQKcaRfGlMXgNyPkPNxy/qw0N2oauGn1rZFXpDFgAaTZpdjRs4UWAftgr3Vp4moMVo/ucRCkhuklA9JBHKyP/grQQwwcAUsx+jqEnR3gNmYi8OvnabbKPCzbwt/+2bHEahtsAu1B6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8d6g22F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8d6g22F"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43965592e1bso18462225e9.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 09:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554581; x=1740159381; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2srr2pLRq3ncXVy/ViK68Dky+bRnnbX1U3SO2DVHN04=;
        b=C8d6g22Fht3grdjO1Ev4krhBF9ccIRZeQ6jd6TNTJowKlojXTMEEfbLQ831zxr5YX6
         IC2DTc6w+Inko/6PfiuJOHkK6pDSC8f+GgF2jVPCeue8M42T239na30qbWxJjw4YWmwF
         SZK54ApRvqSPlKpe2Hlf3EjxKdH2EyYWNrDq8NG7KLsXiRbQORtV9/FHRrH6MuovRiVi
         fSxZvT2gJFfzkwN8Lu1ll30sc0ftm0bEE9Qcm8NsSFQwch9z8CCl210fy0A61pxt1MDY
         Msz9LYuGUeAK1s/Ri67jJJfFHt8wP5LMFToC+IUWjYrNeRsyOqruq5YyV/zfyrJ9iNb8
         zDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554581; x=1740159381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2srr2pLRq3ncXVy/ViK68Dky+bRnnbX1U3SO2DVHN04=;
        b=OeECrBfTnifgwo3Rcub9cPoT55LY5Ov8wDFY7dYT431hBp6cmcbNm7XG8VQeNeEdDA
         VrmMsPJQeNyAS8jgwoAp0LrrzcByxVIRBrPB0gE7W+dbeXIqoNdxlw4SIfArP5yUqXE0
         ik2VrPXw6JUWO4A0CuRDRsOUYiaTQirvNk1yNFETGdOyA97IAwH5t+cutiyGdzAQE9gl
         SYPFPBJbM8LUjkhIbxAfDvTT9OK/bBXO4srqqqJslBUyW4Wpgwh0pvGL2E1WQCoX5tO4
         OTgPcXpR8cZ1MQeLXmGxDunwHqAmk03E3kHWMJBjhlegjGDY1i7nd44Z1CZhRDeUbGP4
         K/Ow==
X-Gm-Message-State: AOJu0YxPFpKGSCX7omZvAZI52GtdTqOx0T0LJBbkGUoanvPGdGZ/wru9
	EXkVZ0QU08VkYLv53ypKXbfpUNMmVjKVuwD27A3njEOEcrnG3/NhYa9SbA==
X-Gm-Gg: ASbGncvSVHApHvnh5T3ctAAi1tAhQyzzuppoE53aFzhpyn461SKpr7L+8Bff9Gv0OoS
	BT85nzEyKdpHlNYIYjx2VhCnyImeq4erbys83aHHZ1mRAg3zfyBJn/jFitlq+uEqnBc/3a7FFfo
	VWkYgHEXcpGuhsP25Y+TPGegHzizCoUHc2cqO/dOLn4MJoDFuVuw1qCAPF+ZvkVQNRGIKC71iRU
	+6Wkr0wdaphxYWTrEYHWErMez6RdgHajxYQrshuFbURi3ALvXaOk8wCxUqDj/ontQ91nBfGb8m8
	n+MHz/d3/mfFrFHw
X-Google-Smtp-Source: AGHT+IFUawT3+cmGW6u8sVfnBDftLKykl5UmDSkWkQyXN69TXYwanN7h6n+7qDH9x3aJ0pbwzFi5DA==
X-Received: by 2002:a5d:5887:0:b0:38f:2861:8fa9 with SMTP id ffacd0b85a97d-38f286191d8mr8167757f8f.30.1739554581440;
        Fri, 14 Feb 2025 09:36:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd51sm5173065f8f.29.2025.02.14.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:36:20 -0800 (PST)
Message-Id: <cc2e59ca0475ea2d4f2df7784d5a4c81a70c264c.1739554578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
References: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Feb 2025 17:36:17 +0000
Subject: [PATCH 1/2] config/remote.txt: reunite 'severOption' description
 paragraphs
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
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

When 'remote.<name>.followRemoteHEAD' was added in b7f7d16562 (fetch:
add configuration for set_head behaviour, 2024-11-29), its description
was added to remote.txt in between the two paragraphs describing
'remote.<name>.serverOption'. Reunite these two paragraphs.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/config/remote.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 4118c219c13..1b9814e8aa4 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -101,6 +101,11 @@ remote.<name>.serverOption::
 	The default set of server options used when fetching from this remote.
 	These server options can be overridden by the `--server-option=` command
 	line arguments.
++
+This is a multi-valued variable, and an empty value can be used in a higher
+priority configuration file (e.g. `.git/config` in a repository) to clear
+the values inherited from a lower priority configuration files (e.g.
+`$HOME/.gitconfig`).
 
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`.
@@ -114,8 +119,3 @@ remote.<name>.followRemoteHEAD::
 	Setting to "always" will silently update it to the value on the remote.
 	Finally, setting it to "never" will never change or create the local
 	reference.
-+
-This is a multi-valued variable, and an empty value can be used in a higher
-priority configuration file (e.g. `.git/config` in a repository) to clear
-the values inherited from a lower priority configuration files (e.g.
-`$HOME/.gitconfig`).
-- 
gitgitgadget

