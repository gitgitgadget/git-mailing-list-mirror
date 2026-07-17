Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066361E51E0
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284504; cv=none; b=ra3d3JS9NKnzccT74c0ttXLo2/33IUM2vHsBw+nbKl9pvE5hUtw4MLNaCFL/D8ZdTfwCuabvdLqkKbwHYY6fGJ5xxW2PiVMHhZDv9HKB/8qa0pZkRAauMAtYiQVsbkAZyP9Rjj3+XFJHkd7fjc+CXP6Q4MhKHWbmBzDUJcF6SW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284504; c=relaxed/simple;
	bh=ERrrURUcJ1jl0eNSgKzinWsz2IVmQJNMI2enuJiJTEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVMyjJtTD9OMnOKk8xCSB2B0NJTj7Gw41uugdhNqeGKtwYupPvs3/bga0j4YidQM3K+qTP+Y8QFqmE3OIeUmJS48J+eT3noG6KAVGP6YmbT434glTKdvEUV5FMTad3QucXV6Xw7pYLnAODMEHNvrQQuaKgZjai39fUcDsOWKOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5VOPNiD; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5VOPNiD"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381072761d4so4490778a91.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784284502; x=1784889302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ERrrURUcJ1jl0eNSgKzinWsz2IVmQJNMI2enuJiJTEA=;
        b=d5VOPNiDVAq+PlSDitC+eGnrUwsUQhLFMVR7BUGPcAvjg3tlecM7ZueHrywRcVTlIS
         DRstIeYUD/LL5pdmzaF8/8dR5AInb0HqDJORWZn2GOSTDQOOTp+GdxjSvkcSpK17lLvO
         2SSKN18xyvFt0WhGoyoKjc1NatcH6y3RVzXbVOfSy+PKTRyuPKwZeWztCSw9X0QZ/CL8
         areyBgVpEBwP18a070IPba8/ZfDtgkv6J31oWfFPK7axpvnVDdPmFqtGAgjXrfxSCExS
         FwLwz0TP60buQ1tNd9EXTN42UI6qKhN1Nm7x2gKNMZMjBPXtx1dYXKycaCozpEVzBuG4
         9U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284502; x=1784889302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ERrrURUcJ1jl0eNSgKzinWsz2IVmQJNMI2enuJiJTEA=;
        b=MHcQVqD11U/0ZxIrmaQ7k4AIK7kgY/LcUmTcH3KBBDc0d4dwdPonHhpfuFv0LMshFk
         2lW2v1NapqSUzKO6xUzbfenFDyzvyPa2KRuTqNxuzQKlpCDGD1f4Qnnb+ICCJZRcSc3l
         Hy8LZpyAs2Dy2z07uwqKE/MkmEjRGr6475+I0tlPGc34uazdfg1cP+cBfG903MXBOYRH
         gmfOb5xyt6EQm1S/a6hL4WD2t0TLaTvYMMBXaiJXhcZGq4dNEMDlKYeumWhkuFpo0h8l
         EVuMZL/Q+ILWu/RaBRdKqDtM/d17Q23y1gXF+y0YpfFUd2WfSS2gSDb40+uibeiu7DjL
         oQPg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0JLaWHpmtWw5vqDEC/gGPG8MXBl2Bfzp5QUgNQ4rJHPIcyqvEo2iy/dPy4nyzndovoLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxb+boD365bWU04WCYmftvSFGCooOGWvmhS6ccvDm4ln5lhl3
	7b7xwxhTJzJQ8Q64dcCufHGV4Qgx4aGMXcC18X58TCnt1LxP7JEB7Q6u
X-Gm-Gg: AfdE7ckVHfx2WBnrmKfWL5Ck+3JlsjT340A2V+5W9R8/s6o4Idn9DvT91g0+MynGZXn
	ilZ7QET9IV+GRKnVSd2BGQZRIQBwQ+ZIYBXvIqC+IHRy384vYZfEswG5svclHKlEMNHYRBUhiLa
	4PQuf+WKvnzc8KIZhrF9P2rLViYcSLPp/6UiYsnffleDKsgNSHJ1Jy26saG4j1GwA27Hvuyn8gm
	hDgoakGDfUhCWtW75i1e+s+sVs8QW+Ttu2o4TtTtiR+kPWDykyla4h25EgLzqwIkOi0JONgqpRs
	gU3J0jop7QtL4xVTaSg4crhuIvtaJvVZ2txXZQadgZGke7y6Lue/ppCWsfugX5AZOjoapneqcmn
	j8ncvid94OrAQwrmccy5o+qOOmtbTJHM44MGGggQUJTSHmJbgNWKWlZBvK8KxpA/ibvjaL04Ih1
	DHTdERBKd0gUbQCvp2/vGT05bbrU2kr/WRrDoJDzWBFvCcHW8=
X-Received: by 2002:a17:90b:1c02:b0:38e:d3b:436f with SMTP id 98e67ed59e1d1-38e4b585ec8mr1973458a91.36.1784284502270;
        Fri, 17 Jul 2026 03:35:02 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429cf22b3sm6169859eec.0.2026.07.17.03.34.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 03:35:01 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: ps@pks.im
Cc: gitster@pobox.com,
	git@vger.kernel.org,
	Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: Re: [PATCH v7] show-branch: convert per-branch flags to commit-slab
Date: Fri, 17 Jul 2026 16:04:54 +0530
Message-ID: <20260717103454.62750-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <alntPJy2VwVK75qj@pks.im>
References: <alntPJy2VwVK75qj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Patrick,

I am a real person. I used AI help for structuring reply in that thread. I understand that is not
appropriate here and will write my own from now on.

Vishweshwar
