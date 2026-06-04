Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35914B8DE9
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593316; cv=none; b=VMK+OUMCmRa+QwtNXsUK09kbXUIDpzKPSezkCULZ+MdDLTymRjyG8oktODC6YUWzsBzZdZdxkgzjyRDuLOnXZx6TlTpkVarmLPtJPKKulvbRLQdRylrCRCX3lYnu4OYiQ9kYxS16+86SNZR1OlEaxnPHrH7f10cuRTGKi7rWK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593316; c=relaxed/simple;
	bh=2sHqsJkinbfMXjYoUkpAy1sJ+1CbWZV9DUOV004nkVU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SPM2IGlioT6BcQ4AuBhU1Hbc01UMcH91jVhLveFljhdK/VwSFUzrXMjNf2t0gjrrfmnYygguomAoCL0ujQFYltilS/nH6G72Cz6oVpO/S9i9icUTG6lMFLDy2o5YR565tyJs7yuRhPR0N76suZt7A9jnIlwKh4DaD616OlYpud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqRkjHSG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqRkjHSG"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304ddfcf72cso1017608eec.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593315; x=1781198115; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UhpzL3WT17mFlrK1z9Olna0IafaVycfEXZup1rxxTIM=;
        b=pqRkjHSGaeFUqFLUQs9H+6M942tek6pL4Bk5Bf2AAzMty5MHU+4bo/Mjv7un+/TyVK
         IFZ6FnJcKOD0+ivt+2yuuL42Q+yUyD309Fnz7kAsr2zQsdwoXEy3lGS1vUou2N2KufxY
         qhymqD1RlcDL8knH7F13NwkY36gBOqHiAMkZqqalwLSpHsJvCDxdo37JOVYi1wXw/Vf9
         k+0KykTqmNSelJG4ksmlkJaJiSlvNFoGkS3+W2qtrWlwD2XiX3gbdz+gm+hPv2MlYf4K
         85nDZ9PbaHonEaqzn7dRVDJMduUTx3qGKEkZk7ABbwrpArKJ+PeUtkRjIjf6Cf82ZtNc
         EyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593315; x=1781198115;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhpzL3WT17mFlrK1z9Olna0IafaVycfEXZup1rxxTIM=;
        b=BXAt7UrwvkrSokL/EIchfMnK77lK8J54wkjcZuSyG0pUOBgr4+b0Zp2Zg/2yJ7a5iW
         peFm965Ym/198/iX922i6vFmn90QMXYyqqa3XyQEBabGc69k8X/yG/ZR0NWcIH1cEDzo
         s3Eb/Yalg10e2ucf6TBbIOVX5E/hNgQSSs7OSE6GmnvTOJ0+rootIpPDy4ebkm0o7Gw0
         s9aKLojg5B1pziYRUeAE2HXm/G1iCdrHhUCb7lKxbEk5L97C163S06tnwsuP6Ax1IFJA
         dTlxXLkNAGn4bYariGbbMS+gSH748QVGnqSKKsAVId/dRRHPDSSQRVSl8z1xwoK9MNuE
         anxw==
X-Gm-Message-State: AOJu0Yw6g1kAsG7WmIXEBjDbtO9DJeEcG3a2xCx5Y1A6Zy9HcELDbCMX
	6JgWwyS8KCzG8J9cRoaziATpzgxpDNoJyIke+k1ZwSiPMvFjCReq7hJWhnrKng==
X-Gm-Gg: Acq92OGwLwAeaZ8X3Q+oXQRLyKxE6aOffFrH5F9lgWZblWSLOnkY46CByyYQF5wQogD
	awH4Zl6LhQEmO6N+LxlLYxPQdbWIXfnZPJ1ZovdugrTqZHwqu1AjOgLcQ1mdg72KSYpKAxHQUyR
	CNuU+whfcmKgNNjUiE9Pzl8bt7pRf8sUT1LRn1M9t+jQ0KIdqpQe+951e7zinoUCUYOPpUF56dN
	Hzw8Bp9e9nWGAAa+BRg00AYINokvai+ooa8CRmaCoYu/KUGyC2yYcp9LJOhjQoieW35AR7nzMvK
	Eqe6c7RQfFobfn5i+7npX45qvuXiGosiF8dBAcDJK17/EAtegwWCvTdoSAhJ/o5tawedTFba99o
	GhJIpiyIgQlElXTfHk8Sb1qQxTr8ZNKseTkmhyCvIbOYmxU7P/UHEQn2QuQPpkjCKvwCv6mAqUr
	HYloKz9IMH9Fds9hg/kEbdPt7Kn/D4zm1KRqkXgQ==
X-Received: by 2002:a05:7300:320c:b0:2ea:5057:a331 with SMTP id 5a478bee46e88-3074fb67399mr5112812eec.21.1780593314637;
        Thu, 04 Jun 2026 10:15:14 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcb98aasm5206864eec.12.2026.06.04.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:15:14 -0700 (PDT)
Message-Id: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 17:15:06 +0000
Subject: [PATCH 0/6] Support hashing objects larger than 4GB on Windows
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

Philip Oakley has contributed these patches ~4.5 years ago, and they have
been carried in Git for Windows ever since.

Now that there are already other patch series flying around that try to
address various aspects about >4GB objects (which aren't handled well by Git
until it stops forcing unsigned long to do size_t's job), it seems a good
time to upstream these patches, too, at long last.

Philip Oakley (6):
  hash-object: demonstrate a >4GB/LLP64 problem
  object-file.c: use size_t for header lengths
  hash algorithms: use size_t for section lengths
  hash-object --stdin: verify that it works with >4GB/LLP64
  hash-object: add another >4GB/LLP64 test case
  hash-object: add a >4GB/LLP64 test case using filtered input

 object-file.c          | 18 +++++++++---------
 object-file.h          |  4 ++--
 sha1dc_git.c           |  3 +--
 sha1dc_git.h           |  2 +-
 t/t1007-hash-object.sh | 39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 14 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2138%2Fdscho%2FPhilipOakley%2Fhashliteral_t-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2138/dscho/PhilipOakley/hashliteral_t-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2138
-- 
gitgitgadget
