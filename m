Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBA1C2AD
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260225; cv=none; b=HBGxx/2jj9S1mUkgpYDnoTAV+HQAWBzSEWwCbt+wfgg9S8V5ctl7kXbPyg4aPThXDfoOMvjVGrmgTbsBe4SJajFekz7+do0KM5KpDFfRJzTrcd1Zb0abRzmi5gzh/76PEYTkMOq8lw84RqO2H1xLol5nHnhJE8JEY0swvhSg77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260225; c=relaxed/simple;
	bh=fSr+kYZ4fqmjPtHiAwvvZPDxVTaumalwueCv/Va2lmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peEsqRLZAxrUH37733Cv0dG7dzJyeFfj8VLh6H32De1/LX5yIJdQs+dChS1Oln8fMsFeCOVlO0kuV5RZvaeRuGjSN3zTdhVxdNBRG5kALozb2h2Lb+/7Yx9hGnNd0g6HGziOjNn6OotW+GDCbccyB4Q6OuwYSpyr4H0Bs45RPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgFFwEgs; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgFFwEgs"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-296a79e6295so1893747a91.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 14:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707260223; x=1707865023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=susyi+mIsSmZfQpSHvtC8ripzurB9rz7SsjV4pANd74=;
        b=AgFFwEgsBc6tJg4Ov7G1laXdKfBJc+cT6f1pExwVQSgDdViXDkvI3lioVmJ3/4P+rV
         JuXx29vp0aqyZTJJxstyC0bkqCVKz2tcfvex2XNr6jCEQTa4/hqikVaA+36Mgqi11OwG
         e1HFQtP++TXV+W5C9POBhQvRvqBCVBhz34KxzM8XSMr/iu2Bk+uN3syKcYcu7SB/Me6F
         9zt/zzCI0tquOAf6Mu07TmJl+J4BfVyUkyp9Ku/vVnuKMk2MJdIvcQDbuh17QI+f8tCT
         WPOvZ1+/OGslo0Dj0Z1+7U0jbgT4wTGlm/aJTj7aPX668z7X4qpG32dr1IXo7i7BqQQt
         63qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260223; x=1707865023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=susyi+mIsSmZfQpSHvtC8ripzurB9rz7SsjV4pANd74=;
        b=APqucbtpBQBk5OgINIYAlp95uJ+boeBbleuF69oGwR4knuxGw1D8vbCi8kIHDm/0ah
         B8JzB3OYGBe4AeWGUKAn9ks9E7FgPccYRQIFP9Rbc/smhhzB0gd0jQDPKoP78jv+WReW
         eNkGi2v/90wM+nugpZO29zZxtYUPQsMXmqsT+z8ebeReM3pMGaMUunrhOgUnrVimz1We
         f/leedOttvfUHgD5SGVVUnz8Blj9kh/+S/wNZa++o3d0QWn3XmWP/OZp8OhWF5VpTGGu
         kbArAUf78iz1pzUgbhtn3u/GWqd+5Uij5oVD2pJdBO2S5jWnzak2jr0VOdhJSg486CDe
         OsyA==
X-Gm-Message-State: AOJu0YzgCZU2mJ728QjOf7h45SnKWq+P89zMJwJhm0EHyCgo50z8EMwa
	F30mL2ZVmT9gwOtpDsh1ebf1hgcgAWJaTET5T7GgtAL1BO0tcwLcxlN+hHqq
X-Google-Smtp-Source: AGHT+IE06Ugkv3dQ8Oe1okaqO5GTNZjKXoDbrv4Z1zyqoraERpCmU/547RlZWAxm7/KgO7c6I/grPQ==
X-Received: by 2002:a17:90a:7522:b0:296:350b:7865 with SMTP id q31-20020a17090a752200b00296350b7865mr1084029pjk.8.1707260223152;
        Tue, 06 Feb 2024 14:57:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHjAagdFlMd/nogsNq19PmhFrYL7JG8vIc+ZO1Dkbvjvvmtwh7L9Be4WMoQMDGo4LNXM1loXUGYe4f9jYEVam4mK+Z1DUu4L7lPUMuV5gTxANNNRvBbzZghNlInc4olivHuLQv/hLsjqYRZQmKomY=
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090aca1400b00290f9e8b4f9sm46741pjt.46.2024.02.06.14.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:57:02 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 0/3] '@' as a synonym for 'HEAD' in patch mode
Date: Wed,  7 Feb 2024 04:20:35 +0530
Message-ID: <20240206225122.1095766-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203112619.979239-2-shyamthakkar001@gmail.com>
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v3, I have taken Junio's suggestion to replace '@' with 'HEAD'
at the beginning of run_add_p(). Due to this, I no longer think we
need to have/export the_user_meant_head() function just for the single
instance in builtin/checkout.c. Therefore, I have hardcoded the '@'
condition in builtin/checkout.c.

Also, Phillip mentioned that the PERL prerequisites in the test files
that are touched by this series are unnecessary and therefore I have
attached a patch to remove them.

Ghanshyam Thakkar (3):
  add-patch: remove unnecessary NEEDSWORK comment
  add-patch: classify '@' as a synonym for 'HEAD'
  add -p tests: remove Perl prerequisite

 add-patch.c               | 12 ++++------
 builtin/checkout.c        | 11 +++++-----
 t/t2016-checkout-patch.sh | 46 ++++++++++++++++++++++-----------------
 t/t2071-restore-patch.sh  | 46 +++++++++++++++++++++------------------
 t/t7105-reset-patch.sh    | 32 +++++++++++++++++----------
 5 files changed, 82 insertions(+), 65 deletions(-)

-- 
2.43.0

