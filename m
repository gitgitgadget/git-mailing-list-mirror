Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775F20459A
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768116608; cv=none; b=nqkSxaYvFnsyDtj0yIPvogU2W0axmxThu+RjYXK2e8y6Uwsr4fXQNMrYdT58LT7SAAe6m4fRH3ppQM+lvrZySXaRjDUyYa4qrRKOC597RhfZWNWT0f0ORSABVZA6qN7XFf2+50mWvcmR36D2W3KDY+MyAO//rh5EBIOdXFAt3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768116608; c=relaxed/simple;
	bh=Icr5YTiz1Ba7dPLOyoG8YdqyHW+EMYrN4Yv7Jg9IGUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roFPgZ9tVCF7eH6379jRnR78HwapUk4xS+DLNwBgKiSkv6JlaJ+Klpe3KQd0jv5xzocap582q/ickEESGumnrqY9WT5PecGGuANEZeCdDUr6Dqif3lDBBGPzpkxddCbw5jRxcYcaPtG5IlFjthp8UinjP/Ze766BU8EzEF+OEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV27nOwe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV27nOwe"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c565c3673so2100559a91.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 23:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768116606; x=1768721406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbgdeKW5qa5I5zMzLaXmJJA+Q5s0MBGq7Da/f5666s4=;
        b=HV27nOwekDXIdi7W/47hU9lFI9mchMYyS5y6T/MgRNOO37Z7x7cjMaK10VVIGSGXtI
         PQ47JfXnp1zhWCSlUbks2m9OxuIIo/1C9vVHnKvmy5Hjxe2ghK6azZ/59jr6/pN3aiua
         4hJd/7nb4tVIWRo9G/SxcJhLo/9TgH/iX20kicwOkh84CGkYoUFtS+J45+AuOJ/AsBVR
         afxuOxG8UAx+iY+sGcAVSkKbXUpLxVA0ZO86P7L15MObUzh4G9fSie20maoa9QXRq1gf
         ovbDyckSuDg7L6oHXtLbeqGZbNy+lE+gflGK7tCCbVrtydwQGgkrVp1ty7utM8wtXisi
         n4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768116606; x=1768721406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbgdeKW5qa5I5zMzLaXmJJA+Q5s0MBGq7Da/f5666s4=;
        b=wugE8OnilSKBMpvSLlqRiVHOu4FZzltJ9P7Cqpqv8NdaDpDko691zvjWDxfkwUVNmy
         acfDx8cnjiI/zOKrfiqE5ZohPDfetMNFNZ1DHSVGiAA5EnVDm4/raU2rFk1GG8ouwKlg
         AW7e8EgSsGkKRgJpC3jqG7PCBIRk76abCzAASXsbH1aQq/GJzTvlnB7xHxfN0FNWPs58
         5JrSX0+6P5PNZP2Fwp2fAxJna4elBgbAHIHKrREj5utQ2SVxTiCIAnsY+ki8iCqQOxkq
         ZygBlPIfiuJrRXXIGnGrFTw9gaiRcdxj1LDnXBWBkDuaDTX/jwOvSGAiiaSvdxk7oBQo
         p2Jw==
X-Gm-Message-State: AOJu0Yy2K+t7OMxIH4RMTzGb+nX1FRCJlfZOj6s6K75mGFOpqokl5zmA
	fdVDQDWC2+Dbqo1OZrsUG1iygYFmz+O9DmcQX6I0KiLPnLR5YLkpvdyXLlLiUkzt
X-Gm-Gg: AY/fxX71fsY7I/QRDRcM/0qXJPgJZstCTTebu25+S3vjD8GdxbBxc4mnScdoEMbV+53
	zIeff0yhdZ8ZHW+089jzKqRjRJbOFBVhPNxPT4HpfoRWY7wRR7gWOC1Eg6Fv3w6BaE9gn7fQblq
	hj/pz2YWviNa0gbDsgwGgxjUJgVJxmm8MJj7b/YU+nv8ZSaYPlw6PP5qyw1EguAa+RsHc7s2cYW
	+aDxiW/ro4oLtY8iQGIQn4DoaTlN4aGeCrpdMQWMomFouqT6egQVI4TrXrxnUsZWa0WEsiUC3gn
	PIREs3Hl9/so939+yLO/o5jHZSRagWFdh09ipP8zuC1pGwuM94No96h8y4BHv9WhR49ertE9szl
	2Dr2ab3eZNma6Tra9h04u450fBeii6YUeWS2dpfCkVI5r39Ys2ct2SdjtQ90gjgagLI/i4wh8pw
	CGOYw+svOYO9wXAvaRo1oqwX3s/2Ni2o77JL6bQCuWk4A=
X-Google-Smtp-Source: AGHT+IGmIdrjZZIB8p8F/ZJlBb8bFf82xsC9vPTZLYh0kIYhzWepq1ijA0o25Zk+vhkeYAeZCLX4vg==
X-Received: by 2002:a17:90b:1d45:b0:343:747e:2ca4 with SMTP id 98e67ed59e1d1-34f68c00bcbmr12570303a91.9.1768116606041;
        Sat, 10 Jan 2026 23:30:06 -0800 (PST)
Received: from d ([49.43.40.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d292fcsm14177619a12.20.2026.01.10.23.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 23:30:05 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH 0/2] t5403: improve post-checkout hook testing
Date: Sun, 11 Jan 2026 07:29:48 +0000
Message-ID: <20260111072950.9463-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up on the recently merged patch that replaced 'test -f' with
test_path_is_file, this series continues the cleanup of the
post-checkout hook tests.

Patch 1/2 introduces a check_post_checkout helper function to replace
the repeated pattern of reading and validating hook arguments. This
refactoring does not change test behavior, but makes the code easier
to maintain and prepares it for further improvement.

Patch 2/2 updates the helper and hook output format to use test_cmp
instead of individual test commands. This provides clearer error
messages on failure, making it easier to see which argument (old ref,
new ref, or flag) did not match the expectation.


Deveshi Dwivedi (2):
  t5403:introduce check_post_checkout helper function
  t5403: use test_cmp for post-checkout argument checks

 t/t5403-post-checkout-hook.sh | 49 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

-- 
2.52.0.230.gd8af7cadaa

