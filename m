Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594A308F28
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505278; cv=none; b=YZrYz63DG5U5VlPfzBPJ4yFbq/mWIy0R4qSmLvZuwcFM7htxbpA+BE4AHtgUsTUZLjHmaMHs4Hcpp5WHuRO+iByKgS7j6WwfEA4cx4AoIJODCggtCPNaPJud1Pw4V39d5CP+zkqitfKyapvmii/j+Baqjx4sbDFz7HS8/2cIH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505278; c=relaxed/simple;
	bh=EqSdaapoP4Iua/0005K7fJJQLg93opY0nNsFFjYp2WU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W3UF827MiCqI+N+qxN0oVJs7p5w4iX5deCWIjSeZPMwIyMaxP0MneRshu9/dZlLiq08tP28tgc19s8bhJvCBlL0O+anjHoKf67bNO3rHCPSVqqMdg5vfyu40gbsHhOXreXaTMuJjL15ViqRTjsqxS0IG5Cz1+3uQJpP8W3cO3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7LJm+dH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7LJm+dH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2984dfae043so58271105ad.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505275; x=1764110075; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ1xCZGcTGnq37poV0lY8Av9qjcJb/UhKnYDd3dwctY=;
        b=I7LJm+dHozucDiVEA8yJr/ycBA6Toi+QS67Cwr4hQYzGErTE63BP9aKXgFQiP37YZd
         GCuEozgPweaHPXEw4B1xH768qe7pUI5JQkXfB0pfr1s7ONGbjBBgM1wiLxuNGOutotHo
         GxrFoOc2xnmLL6lJ7HapB49Yb6saZM3dE5AGXuf+rToWcelP1FanWqFsYXok8fHMfb/u
         q5J9yyBv4k6lqHJKsZDzEiKUriGY3kDrCq0vaLfjXNEkj5MGf4uOure89blPwB9E93ql
         8hQqhge/c7ft0wt8FWZI7z/NYZliFmFgqUZMOfE0ESa/bpIbhVW3hpBKhQiKxxayRxXt
         GkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505275; x=1764110075;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQ1xCZGcTGnq37poV0lY8Av9qjcJb/UhKnYDd3dwctY=;
        b=ji7+lM9zzL5zQjmf0BIIRGuS7sHN8oKZ8VEuYjG52PlXb2iRd/iSEvvvyYw9lK4nWt
         4OrjtlMWynvQK7NOg1+5PIpZaiVvEFxQhmwe1bkeCKJnZ1g/WUHEHWP0DLhylnVLNE4U
         NclJXFxthRAjxNXPbNY0ZvlqkAMCM3U+KSVTL9S4aG2Lpb1W36OahGJDAYGc7ThCpS00
         IEz3yuSPXt8UUJELmv8VYvEjyMpm9zkFIarQMTIqfk1KAyaUh2nq1l8guLZxZ8OGSU7A
         LD7gdKbgL4qkquNM08dfdNpW7H1FqNdhtyt5Ydn3uqb6Rr9+hdAzYTDdVDShRjCJaHpr
         3Acw==
X-Gm-Message-State: AOJu0Yws7WDPFaBo64mWPwunLt66UvI6Sc4P0805OdSDfdn5ETZzUab+
	EP8SFa4mNqbLwqXMKtJQzFSjdRai4aFvaElTOc8wrvi90h/9ex32Ahwl26PMdw==
X-Gm-Gg: ASbGncsyUWc6QyLdxCMWwNZd3FFfaUheRNU33JhvfDVI2Lm6a7tSE1VXahmtyWx3qs+
	5YM7r6xfFlD6BPEkuPfSHFHFiAFtg4NGBzVt0XPfOc9FLvn/QGGzDTalvN1VjFWiLhI5Mh/DgAn
	5dhZ2OARzapR+imtVl/u7jrjQVASqr+CGBARN4P6qk9kOyheLLKK4QFESir7rQBlpujsLQ/+yem
	RQoZAaS5izUTFgX8q9RPXQ87GZi0pxw/gv0g9Xu8UrbwaTkneLWAPSbB+scGO6ByT657CCItZEh
	FgzcWXlczj8nOihUFMJqiGPoSgC3XBDOIvQtRpLxpbifFgG5esFtebr7TN1jubDznuAhM38Xfb+
	uwXQuIvb8hOWUnNvH2FUit0BjMQ86vXnMU42ux5DeFXy+6ioYWc08Zd23BvEzeb4YEvfUVwnRQu
	NUyWbNu0jI8UmeER4i3wZmLMA=
X-Google-Smtp-Source: AGHT+IHT2GgApnvS4J6y4QKtrE6ic/HW2u8RWYD9Npn23YwHiCH9nYtLEf0sJgT3zA0HLkN8q1u4rw==
X-Received: by 2002:a17:903:ac7:b0:295:557e:746a with SMTP id d9443c01a7336-2986a6d04femr186293055ad.13.1763505275295;
        Tue, 18 Nov 2025 14:34:35 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm184388705ad.32.2025.11.18.14.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:34 -0800 (PST)
Message-Id: <bc4941c14668984e882d43baaeddd08312efc217.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:21 +0000
Subject: [PATCH v5 09/10] xdiff: change rindex from long to size_t in xdfile_t
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

The field rindex describes an index offset for other arrays. Change it
to size_t.

Changing the type of rindex from long to size_t has no cascading
refactor impact because it is only ever used to directly index other
arrays.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 1f495f987f..9074cdadd1 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -50,7 +50,7 @@ typedef struct s_xdfile {
 	size_t nrec;
 	ptrdiff_t dstart, dend;
 	bool *changed;
-	long *rindex;
+	size_t *rindex;
 	size_t nreff;
 } xdfile_t;
 
-- 
gitgitgadget

