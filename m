Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C737B41F
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325560; cv=none; b=c04aYVcCFeqtnlQYmdzOGxMUkSPa0jDyN3CHqTlWK71Qdj7r8g4tjxpVCIiScNGqDL34dCp9LAUsJGLEnULUPMM7hanxXueaclJEG9K/hv3T/HwKCdQ4jZQ9RrVGhdT4j/6QrcutcYfnMkB1ABolpHY1miMDC1E25MsXkJ+rSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325560; c=relaxed/simple;
	bh=v1yhMhHV/cRRTE6U809l0XHHnKI796P2GSIHGW7oqgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOwV4DCbzhyAZgAztSU5i3a2v8D+9mJwRWsoTtdWG3Xl7oOcK+PcAk1WGaz5HRGBo869WPJd+GfxK7lhVW8IqjEm+uGlaVu35vRty0ZNY785jHXjWOo5C2gRTkGQmAC+P48YxpU5G+ICiLwjQVORCIILuzDevHQjrdtpBrONmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyc/hcbk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyc/hcbk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35b982990aeso640894a91.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774325558; x=1774930358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1yhMhHV/cRRTE6U809l0XHHnKI796P2GSIHGW7oqgM=;
        b=Qyc/hcbkd2G88fkxpqNxUJ1Yq2nw4FDP42RS/TXlfqpk3rnUSy4NIdPCu29B0DZCJl
         uYSlJsqiN37hVilqhhlQMm1xnFHnNOOODRXD+K/K24yZb3Zg7WTXaiAqQdKhoutKwCIt
         1ralefNGsRxpwwOu/93Xu7A4GyGtVaXwNN/laygJGc2PZ7820KNfWtgqmOyLxMhr5IRn
         LlpZD6c+0kOBgKoDpNr7n9Eaf3uJ/1YmBoNIbxcUJM0CPUs6fJweNE2C1kFIrlMP/ahO
         cT2yqoqB8NQzCkfTUc9fyeZi4wqd8WhY4HWIVdvGwsHikeAxPzuwRlNcyBVt+4Fj4zBS
         +cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774325558; x=1774930358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1yhMhHV/cRRTE6U809l0XHHnKI796P2GSIHGW7oqgM=;
        b=MpDLG8jYGlUcSr2tMTea+cY/90BzIXPgnhvxVOFvWSYSClDc0VPomoXP3nRHyoa367
         RyxtBLfyxQGTl0TWINCjaH05E1/CG+yNl/LjZO1ii0Qta4VVtwteCxWKUM5LrpuWumyX
         jeqxnlMIm0hrpmR7EOB4vfsd4AV/tS01WGMn79zItUGEs65UYarq9EFVr2ljErb+MAg8
         Nu1LQ3O/7Jsarrg2A4jCNe999eN0uTkP8vz0cvOn26dJrn2YOrd7ryqKQWEnPDC6u1pN
         Evhqz4Y3HnzV8B7BJQYDcI3N0UC/hj4b+lz6Jq5ys2KC6znpvsJM5KShO9QSIFu5hblM
         v4NQ==
X-Gm-Message-State: AOJu0Yz9R93O/GcSO3jNyBKHTUEZPI/+wA2599Da1UPKquiqpIjMXRyz
	YXbuCqgJUR0snu1qSae5AzZkZ4VyUJ7MK2gH08JOnYWfRTS6keIiY2kn
X-Gm-Gg: ATEYQzxLhXs52LEEI5Vy9FdSaXtsfkIVAjasfAoQxlKsdeQCmaU5eh9J4juWVeGASRJ
	DGYfrxk5Hypk/plj9XmCE0tnBxDMviBl6xiBJ1sbXJrKdgS+Zjb+WnszssTseRaXjaLw+SDioVS
	+sv7xf3ViKxTvh4IJBfIzuUbfaVjhUF/1FeZ9iF986D57sHOAFA5vnZPzDExPp44dwlpj1GIlZC
	Xi1mzNDrxOHfLHbj5/YCRdOgP3B5yjL9hKQlKmN73LHvAzBqGe4cibztFyfnmCTegHBCRSNs0yz
	XQOqbhOc1wA9Lmeh4WN0vtcrWgGX3HcANkVmDalsWkihauTuCiuFi+x1ec5yXAqmUK/FhH13lTa
	nFI/XeglB97juFXcYcltpK/9uoAiFZynq/6bJAsDufGUoCF7gUxJSxK3xQVXhg8ZVni20k8CcrF
	/iWAdPfCepHriw3cd4cszLueG+Exlh+QU8Ix6OTBcsEwCYs7xXnIfG9b8Lkqq97GkSwQkGvdA=
X-Received: by 2002:a17:90a:e70f:b0:359:8988:38c2 with SMTP id 98e67ed59e1d1-35bd2bd5c90mr8251631a91.2.1774325558297;
        Mon, 23 Mar 2026 21:12:38 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c031354f3sm765240a91.6.2026.03.23.21.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 21:12:37 -0700 (PDT)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: a3205153416@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	jayeshdaga99@gmail.com
Subject: Re: [PATCH] t/pack-refs-tests: drop '-f' from test_path_is_missing
Date: Tue, 24 Mar 2026 04:11:33 +0000
Message-ID: <20260324041133.42909-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tian Yuchen,

Thanks for the review!

You're absolutely right, the earlier version accidentally removed the
shebang and test framework lines along with changing the file mode.
That was unintended, and I corrected it in the updated patch.

I'll make sure to properly version future updates as v2.

I appreciate the guidance.

Thanks,
Jayesh
