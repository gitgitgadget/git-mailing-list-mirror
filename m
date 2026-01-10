Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11296336EE3
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768043208; cv=none; b=SFpsvL1gDIxdtkOSD/nyi/KMZBdU9qMk0dO3dTW/S0fU0fjqUGoohq0kvA0sny02b8opWGLtZoxJW+MbVC7wa2AILOWRyOHlmKTF0PFmLx1OViIUUOAG3IE39w5X+NMpeZVKle6AUjgvgi0MXSl3AiTkeQ1YD7bn+t9rCEoebAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768043208; c=relaxed/simple;
	bh=xPC0gCJyzoSgchOURjYHB44s9BIjeFUcWOeXrN/6ihY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=a7FYFmFCdrBM+1srO2wQHCeWFZ1JMKPHchC7clibvoCjOEQF0X5vyaAYN4pRTUgx2cHkHNSUXR+ytutwwztrMCMumf/sLr0kRaECJrySrZIdBl+c7sz/D8IjXNZskGOeCTYCTYvKmBd7RzHQ8SAc6sxvCxMIuQCmNzZ7Sshhc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpXoAgMJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpXoAgMJ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f34c5f2f98so54366101cf.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 03:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768043205; x=1768648005; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JDsirYcp1+8b/H4KuNHbB4H3VQW5W1JUww40u5ztMeU=;
        b=DpXoAgMJBdVhIeQpalw0W8Q37XGA0Mi8wV18nH4IxBBPSHfpzxnvsH6ZhunFSl1JQ1
         5b8rxe/ONBN61xbXLRDsQx0CaWrB7fhn0AmGNJ+0/5TplOFKWI1EHULHMBtlOowQLU/0
         ZU18mGPCJPD9G/SqI9hqTn7X9HE9IR+p4mCx1kj+mcqLb17ewXBH2h5preHu3BKMhqJN
         9/3T6jQBwMkJnwEIm0c0+i0NO7rttnyoWsTTGxFBn3/afQZw1SQobCUz+vwiFLOluBdj
         UHjhIWaIRMEcAk/JBMudSxruikBZGh8sXKtaRrWdKTThUNgMBjIn6nrbNnMpL/2LQMBY
         hphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768043205; x=1768648005;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDsirYcp1+8b/H4KuNHbB4H3VQW5W1JUww40u5ztMeU=;
        b=Kv14uCPKn6qMKbwcnkHGkeoWZz1n0AkabZdYVNqEVfgjX9kvfANyJim1aC/1w8jP7C
         kVI5tzli7x9X3AM9GWHHhyur5FbU+y2BffyS+uo+0kTA7E1ZwTGJqxPu79uWws78ziJV
         vJjBXpJv7TEo08DMkCI5PMAvgUXg5GJlWxhtGkPkpzfnsP+jVapMgu0S5NjFoKkBGh/x
         fCh5VRmCS8wjGyXVw0Z2u2LXxbCtWnTOapVI57GsG25/Cd9rmX6rAyy+LvzoAPCFe4cQ
         en0Q0mVUcVRodODDA7wuPcsqXR3GvlqZQQkSXLexaNT/YyzvETvi/x4KGKIuFRcXTU3J
         4l4g==
X-Gm-Message-State: AOJu0YwhV+OsXo5z+l6DSAhpYDvYsmCY9cv0olRjSP/TLORoiVQeZBKu
	jv29/+GkitfzLRVJYJXyZh/MnzrqZGAE762SZgKHstFFbBgRCsgyzs6gZ6yQ1Q==
X-Gm-Gg: AY/fxX7/Y9Rvz2noJmLwFRdfMjq3W8CxU5FrpYdKAwDUKA9MMF3/tW2saxczpUGMZpf
	3cB5pyvNnw3wbHso7mKifJB4WZ8zPzb8q9YbPj9pjveEATBm2zvugDWdYzicr/U1rKyDG+9XVj7
	S4GT75tsSPXp2kPJjF0V+8FX+MNrr/zH59wQKa3U1nxONf0sM7sL2y+1G4EMDEeKCK7Z78+2z5/
	WUlAgpb0iR2rXyhwp+/0QElpGow9pNboX1/mCwnvyGHxRC1G2AQGEz2W+5How0lEHjPp06ZkGzn
	b90UTHJXwLsshKc/VPFDiHMT8mrBBxQvVi1EziPczYle8KJMbjb6DGfc7xDPFhU8INOLkD3p/yI
	VgSgvXAxMKdGKvuPzwJNlv7yg17CQUj/m61ebXDYb4szoCPm8mmRebHSh6S+v/QD9zy8D7CV7Ev
	j8+Cgq7hEQyb1kPu5i3VsKNV6zUg==
X-Google-Smtp-Source: AGHT+IF9awdgRxrVXxU0jIzndNvR1yKGCxTMGguAuZNz3COXKJ5OfoD/p/WN/7MIhJW/AkmBEyTMZg==
X-Received: by 2002:a05:622a:283:b0:4ff:b2cb:a44c with SMTP id d75a77b69052e-4ffb4a7006cmr174120011cf.83.1768043205456;
        Sat, 10 Jan 2026 03:06:45 -0800 (PST)
Received: from [127.0.0.1] ([135.232.177.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770ce985sm92378236d6.11.2026.01.10.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 03:06:45 -0800 (PST)
Message-Id: <pull.2029.git.1768043204134.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 11:06:44 +0000
Subject: [PATCH] .mailmap: replace Karsten Blees' default address
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
Cc: Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As per a recent email by Karsten, the @dcon.de address no longer works:
https://lore.kernel.org/git/77e768b2-6693-454f-9e11-fb0acdec703c@gmail.com

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    .mailmap: replace Karsten Blees' default address

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2029%2Fdscho%2Fadjust-mailmap-for-karsten-blees-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2029/dscho/adjust-mailmap-for-karsten-blees-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2029

 .mailmap | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7b3198171f..3cf26b1add 100644
--- a/.mailmap
+++ b/.mailmap
@@ -140,8 +140,8 @@ Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com> <kaarticsivaraam91196@gmail.com>
 Karl Wiberg <kha@treskal.com> Karl  Hasselström
 Karl Wiberg <kha@treskal.com> <kha@yoghurt.hemma.treskal.com>
-Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
-Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
+Karsten Blees <karsten.blees@gmail.com> <karsten.blees@dcon.de>
+Karsten Blees <karsten.blees@gmail.com> <blees@dcon.de>
 Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
 Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
 Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail.com>

base-commit: d529f3a197364881746f558e5652f0236131eb86
-- 
gitgitgadget
