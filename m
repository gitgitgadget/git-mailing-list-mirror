Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F24B1E7B
	for <git@vger.kernel.org>; Sat, 17 May 2025 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747452996; cv=none; b=Q/XL+QE7/G6/4AId8FnJEN9iTXP2uRGWkCMMP93Uo0JR6jEQexaY5vkBm8VzENlvF9WCpV/6cT6catYnKKz9EyLRwSPm7KLAe+LTdYVJ9EuN1Sgw9DKwCr+f7f3emOAm8IlTz0E+M2RPYcj0yS3ofyzNo1TJ97vQFOXPDF7CCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747452996; c=relaxed/simple;
	bh=IkQgJO4qirzAbPVDdnCPnsW8RYnFrVCj/tlYkAWHszg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5c3QUf86Xr3hIsVtkK76G0GSNsmKPYDhF2Oev5iRb4hJ2+muCEJZ+juHh5xob52JTAcVg+F9nM6ZfsGNc8pueRT4xuqG6fcmmWqTLv8vvbH8lnR8PD3kmbU22PUOMNNnG2fK/BK91buOQ/5grJpMAZxJH1gMD8hZO+qtg6Vk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZUh5enE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZUh5enE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426159273fso2891431b3a.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747452995; x=1748057795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neq+RhIJsSEXE/ABMFgpw6cHqL9PaAgAuOeCrYZuBYk=;
        b=PZUh5enEhu14zMRJWwHcECBAw6E83TSVXZn9nh8RHVDJUBBHenMWHX/cff17f+PDoe
         RCOsEOZhZVQ8Hxy4qEgR6GxOWHTf3Uk05amXJBdEnMXLuTH+30WQWHjiWswdot6QsVJs
         OhwzLwzrGzGLiCpC0hDVOA8GZAHpk4PP7vL+lBmjB0RzhqHYoejFi2/pXDjT4gfFL6kI
         mtB9rKY+R//F9se7lClIyH21IcJkUBaUbeug3c89vz02joFAaBg2RJs2Lj1W9bw+et3k
         qX4tKVw45wVTpNiVcEd6cUVsDy7ViyokUeWiDOJWPWxLK1OwdfiRnR880UW1yxfXzn7L
         Y5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747452995; x=1748057795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neq+RhIJsSEXE/ABMFgpw6cHqL9PaAgAuOeCrYZuBYk=;
        b=XckWxyjrr24xmbO8pZZawDZVrchHYHkSfx+avRsL9qDmgWclpkgcTo0W1We0wMRbFj
         IUgBpfj4G6Fv3mR4ZykuYO2MTJr/J2DGsii7P7dfNDJNKJvneebKWMWlk3l6UhBnAE09
         Xrxed8csgYwMDFjoKaDSvOTKqTYSIJCilgUFUg1KyrINcGQ2ovl7lwJfzhmU8ou0ckDM
         rrTvIELNf1blcRLZo4NQLAM1L2uH4wl95W8UYwknviUQ6T9axyaNg7vSvtewVmtSmq8w
         /j3iKHc4HcU2YhC8K69SyIU6vojt3P8MT6Hgx772l+cRYYDg0ssLbtYuHVQmg++owdSv
         bnEg==
X-Gm-Message-State: AOJu0Yy4pC/OOtxECBwYUjIQg9tmDl1VooL2PcEf45HtgTFTfvQciEGB
	B8Ib0mJKrEZeqUaf3Hk9Ruw3wB6aMXgfeqaF4MtOjt597q9d3d0CeEsw
X-Gm-Gg: ASbGncvI1k3VBcTAkUXT2BHVihZ3lZxIE07RewuwQ7b892D9yswVkZ/E9SJO2gkE/3U
	NmTdLtLll4L9OHHWArPk44J4QTqPIPbmMWdCksDcmBUkjpBPC81CN0VW0fpMRhDHe22HhgfqdEQ
	Ex3joDf7KC7H91ZGpuFTZ+7iobkkI8niI3KMxIFSMMPsGiC9JfdlTDpALDjW3KnDls4nasCwKQ3
	aNF9IjWWk6OhOJ6wNPqSwrRsfXgd1zruGXr+RYBL4jGjPe2f4Ky0KCvQLX/b83KkPQh4zQx0p/x
	4E0SRSn7rjNwzOAKiyAbwxU6ZhQhL+8+0RCabRW7NEwFPlQ57x38UIxRn/CWhq3n2mY=
X-Google-Smtp-Source: AGHT+IGwiB0ZIOfDh0dTdvWQWB6twaK7b/vZWkr8xpRF48jzMyx76QfmYzjL2R1Y08mA0C73Thddzg==
X-Received: by 2002:a05:6300:8b0f:b0:215:eb6b:8714 with SMTP id adf61e73a8af0-2170cdf1503mr8019802637.30.1747452994724;
        Fri, 16 May 2025 20:36:34 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ba8sm2285500b3a.110.2025.05.16.20.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 20:36:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 0/3] Update MyFirstContribution.adoc to follow modern practices
Date: Sat, 17 May 2025 09:06:23 +0530
Message-ID: <20250517033626.8052-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqqecworq39.fsf@gitster.g>
References: <xmqqecworq39.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes are made to MyFirstContribution.adoc 
to make the tutorial follow modern git practices.

The tutorial codes actually help newbies like myself to actually know what is going on 
in the source code as the Git source code is vast.

Therefore these patches.


K Jayatheerth (3):
  docs: remove unused mentoring mailing list reference
  docs: clarify cmd_psuh signature and explain UNUSED macro
  docs: replace git_config to repo_config

 Documentation/MyFirstContribution.adoc | 47 ++++++++++++++------------
 1 file changed, 25 insertions(+), 22 deletions(-)

-- 
2.49.GIT

