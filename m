Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9C1C84AF
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460464; cv=none; b=pTvmlsfnGR+obYfSyV9sekuz9ThacGNKCMH08bykzOHwvtHba2e3rCgC2UHhljMVffW7cIOEZvb+m+NamBIbbiM4cePKoOIvebEIfiakoCZ5hK/MTMaZgJk7yXXUekVgx9tWAOjnomq9LKYVe3oNtDdP3gjZNXJHsY2jy0pgFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460464; c=relaxed/simple;
	bh=WhzscgVp6Aq1FwVtwbwF9T39ZvwFkhlS3ggdHJsi0hk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=pPH/t/j4xuX80XSpPmO2vzntLVKWKFR0TV8ccb1RFJsahp8sm3vUwx74Y+PVloYrDUv5wlw9eBg6FMbsGTdY7PyJnfbhM+05pmVBhAGr2JI0mEugyGNZWvMy39WcFJEHckJONnrcZTABA2inJtjW+rhHEOEOMscaz4mSRrzB8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khS6P7mt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khS6P7mt"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c266c1389so1913572f8f.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460460; x=1745065260; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCQd/kb7cQFcywtceL2RnMrKleGCVH+irnISO1EX1fo=;
        b=khS6P7mt9dzIYAV2SOl0gI0/+fumYHbXpVuzKwDdzdUY9Ey/D6Kh0jLrikelI0WBnu
         pAycYGzMLq0dKVVlxVQWtwFJcqVnH5122HvTu7O750plLj7ud3UtwC7RV4m0fCuzLc6z
         cKhHK0rjQM8U9pRv9dlGf2D+sayzKrJVbHVqePsj1DKeXKqobW0Z5QNweWqmBRbcaKjm
         lbJOrji3snOGLyXVto6iLTQcau5tfbgHkkEEERUx3nafdtmhdhtvyFbRL/8IQE9Pt/WH
         76OEOd4M21vBGDGrh0J/IUht9OYu7GeS0JX63/yiXykJgI6CbrpYMNQcA8v9uAdblL5q
         q4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460460; x=1745065260;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCQd/kb7cQFcywtceL2RnMrKleGCVH+irnISO1EX1fo=;
        b=m3nbsWD34Wp7y3lMCWNEcjbw/SePlyUz6mZKIuayUUSRPs50ed4EMch//r+A99KjPq
         XQqDbTY/9eVc1EDhY6WQLwhbLbPVIawJSqyRWvQ1qGnnma01Yji8q4D0VGfQ5S7dMmlh
         65c3Bl0NFNBW8HAEeUDlWAjUmKVrXqobcVaKnZQIwKSYwc/cw/tRvACFuoTfbs9OFpVG
         RBPJ5VANRwGWKzrkmDmd7jVFPlVdP5pELbBJEF3NWHCfuK4X7od/lbr+0NZ12HdvlOVu
         DhsPApKsFoekVehPJv7b8j3tlTASn260r8mq5yw3tZsyTHE6vwo2KktHHf+YWmhD8KjK
         uuSw==
X-Gm-Message-State: AOJu0YzcwvtzuZYSOvhlA3nZz+CIN5RKydljeMLqF7QjDc9Fn4otelq7
	bYCvm2D3s6vyfFZlHVATTBOta0fboCaDnt7IBlwy1adt8CvzO8WoyYJrgA==
X-Gm-Gg: ASbGncvcukUtUBCrQhRGuiiO4NiMPfIPtf4j6kqeKMwxWaXHMaEHVPfe8Lv4ZcSCU9X
	ORWS5X+XqySMLIeQaizYfkL9Cxt7kdxFP5W0QXEVjhrwB0WeJ5BmzdrNz3ndW6GpbSu2hjAleWN
	+lvdgC4jUyPSw8KKBDSvyHs+yrkpb+srRVdRdXai87IT7Uya0XvL4Q9CSEibb/Qvz6ty/h2B8q7
	z1Zw2DtBJ+dmutqwztOt5R4NCd5hIhbEzSJ896Ia7wUcGFDPK0Go2UqPn6bHtTcHqvIzzgDiTn3
	CCIzXxiNdw6OuS/ns91cBFtXEuoC0FZE0mCdBRKLWA==
X-Google-Smtp-Source: AGHT+IHru61YCWL5zzoObDUoaPrNMC924Gh7M/G8XyuhYWGeImpX6AfxpeGGGk9SSCcz7ZYxFKjCmg==
X-Received: by 2002:a05:6000:4023:b0:397:8ef9:a143 with SMTP id ffacd0b85a97d-39ea5212322mr4845188f8f.23.1744460459728;
        Sat, 12 Apr 2025 05:20:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445270sm4850747f8f.81.2025.04.12.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:59 -0700 (PDT)
Message-Id: <2690f84602b89f1b10652a6381aa96b2e126d6eb.1744460450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:50 +0000
Subject: [PATCH v2 7/7] doc: add markup for characters in Guidelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

This rule was already implicitely applied in the converted man pages,
so let's state it loudly.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a0e7041c54b..c1046abfb7d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -861,6 +861,9 @@ Markup:
    _<git-dir>_
    _<key-id>_
 
+Characters are also surrounded by underscores:
+   _LF_, _CR_, _CR_/_LF_, _NUL_, _EOF_
+
  Git's Asciidoc processor has been tailored to treat backticked text
  as complex synopsis. When literal and placeholders are mixed, you can
  use the backtick notation which will take care of correctly typesetting
-- 
gitgitgadget
