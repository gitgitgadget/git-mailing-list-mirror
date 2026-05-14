Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2C3F4127
	for <git@vger.kernel.org>; Thu, 14 May 2026 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796967; cv=none; b=B1jVMZLo0Fy6XMjpF5D2wM+mAC9ts0C3YoD02kdpttZ4UOJfmWMOvW0o9zwT0iRl6tqEQ0WDw0EAgkibQsWBz38Sg7GWRqsIWm+ALgaRUABIpvh3UkMPMF921WledY0cWrC1rpbNsawmlfTyDHVQ5IXBNH7KB9nhLWwTUcj8CjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796967; c=relaxed/simple;
	bh=BUXJJYcuAP1ksN4uTAJs9VO+QeMs6IUkjpHkLZONAHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnpSYCWLd1+zPRQV4bbjcrggrMsxTzaD14eKF+Nn8bb+P0DHAIUUJsobsUBbWYj0V1IMw0wRGJgiWM3Cgtc0rQJZGqENxN8l3ZY6Hn5jdr0nyi4b9bfowMtxtekhV5bj8dUafAG4KyQ0VijiCM8sh94OEKqwE056znFjE8xErlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQrQm/s5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQrQm/s5"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-394413a63d3so27199261fa.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778796964; x=1779401764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4esVVq5vgfXfl7/2ovIs1/irizEhhyad0+MKXMmfNK8=;
        b=eQrQm/s5wFmlr072a/zfqG5DdY1N/6e5ZbsQxKLv2xlGtK4KCQSM6SDCzmU1Rkrmjr
         N9W7+zIfD4y0huAtRpPkOVGsTSPUCXV+DcJXvmifZzobQKsALgR2P/gwiMbuVAGJ68WK
         atIdtI0Lfw2Y5bhiFp9j6cm+aNPp9ISxbxu9x2LunYS1G7heFn/54LVvUM1xd8+Ba1ku
         k14Fwof/YfFDvwSNvM3vTSq8jyrTsrc6A9qSjNPDUMnZ4BfTt50VljSNyrVrM4xhl17t
         GNGTbeg+Jcdmdk7DkOoaSg1OMgp28QUSj1p1UXOaatI+9Bni3z1nAPnNGRLlXPRybeJ2
         RA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778796964; x=1779401764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4esVVq5vgfXfl7/2ovIs1/irizEhhyad0+MKXMmfNK8=;
        b=o9xGYI2sxe8niLDqg8+QWc9NAm5SfSSks+6ipU2va+zx2YZLBXfdJGyKF7Cqh6aZk0
         p7yimFgih1hYBNuX8k6kF2rZJfGwPzILSHFghMHVxbAJQBlC3ZT1rYQLEGFMA1VMEI3L
         FOaKZkGuQXfqyWQMo9UGRauqnHtbFJdyVS3AY9OXrcnEJV1gr9YYvMjz0DOPMKAQbZwG
         NN6FpP9otZboel9ETunnzo+000VY8RqY6tPQIhZQOdqJuX+naZX+1RyOs3TWe1g+AfuN
         rR2/nrhI/n+cprUDDDMgKO8rrOd7c3OI9CWXIMaAg/U8nlJCKuHHbTA1UO6OySjdzLor
         hweQ==
X-Gm-Message-State: AOJu0YxqsUaB+nFYh1tuFrD0mbpohbZd5JB2aE62ju9JFpyKgSdG1eXr
	LkokjQewae7gHddDmHp9FMQ3ir0L/2ZrR2Dz8qI3MMHobLVQ+gHmslWZ
X-Gm-Gg: Acq92OGOE8aTXvC5k/L2M9d9TE4+wxxseLPmC7GHagToisLL25+NLBD/ugpvQFVD2O3
	BwSAFRHO26rQn6J46aVHJgkdSQzI5qjzCXysAT73itIxQvQjt8HGZCGS0qGcLgeyLmANMPe7Rau
	gnSYuqkCdD/92MIJzQDgBHTBaP6ZijK66rsAc8dUJh6SrC5ivhEiN6HJJsqDELPsS1xxBQLPwGk
	jMbpCyDzVljsWHHxyzRJNHeXKo1TGr8QBNCA1GSJ8DAWTU2tvjDzliWkvxm2WwpLodBh4MN5wyE
	3xEzPFXl9SFI02GKItSVvPrpc4WQ6XV82+AHzS9GDu9JjHr/FP/uPgpUqLUpcplgCQP75je2m7S
	mwFpe1UTQ+9qb0pvzbzmx+SlLIiG7FTeXE0Zuv2RdkDJ6FFVCAweFD5Q9d2/OdRMGs37ps/Amth
	1FxGftGWMoylLvdtW/xRsi4u+Y+gpbkqZGAGEmOmFvKp07J0npQWAdv7xdlAGNMxsxkp9tp7hgd
	J6Evmt9zQ0gJ0qX
X-Received: by 2002:a2e:8814:0:b0:38d:fca1:4a6c with SMTP id 38308e7fff4ca-39561d4c2c0mr1883961fa.17.1778796964118;
        Thu, 14 May 2026 15:16:04 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c8d87efsm9789071fa.12.2026.05.14.15.16.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 May 2026 15:16:03 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
Date: Fri, 15 May 2026 00:16:02 +0200
Message-ID: <20260514221602.9918-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.106.gcfa0dd594b
In-Reply-To: <xmqqqzndel8c.fsf@gitster.g>
References: <xmqqqzndel8c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I also wonder if, given that "=" in anywhere other than three-level
> names, is invalid, we should just start accept
> 
> 	git config foo.bar=baz
> 	git config set foo.bar=baz
> 
> and interpret them as
> 
> 	git config set foo.bar baz

That sounds good too! Probably even better.


Harald
