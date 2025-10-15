Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A2245005
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537034; cv=none; b=bczRto8tpS03MbWUVlI3mjQDrnbD6b6zm6c2VYNCy704abaMTT/NiFGXJrwhZ2hGjPx52zAdQGUsQW7GbeEhZF8FQmWdm9zzCTFi2RJhsWxCOosyUfXOs5f9jFLHaeU/t4o2D7ejkuMmJc3mNj8AwNcDpBdjHR9af/kvdwQ7ya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537034; c=relaxed/simple;
	bh=SlBgfVjwMecw/TBG5RjZpjRneA3uTWg9syNYpzIE/W4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JuNaOuglLZc86+qLjlTFW9cyJmwcQJSYYXcKOvby6WmFQyHh6mq0l2TSom+S1f35MjNdCq2upJmh9rag+8HTSAY/HWV/1FaIzn0qoFPPnQ9fyG7Ztel/P1doY8G5IT5N/aaRjwPJS7CN4S0W8qbsVIdqIKg8iM4A0BmYpVrkMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbjN32lX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbjN32lX"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so13250096a12.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537031; x=1761141831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H15Ndv0vlQpY4JdGJ2qdY/sFBfa40QUCfx7fpFdGPXs=;
        b=hbjN32lXP87i864+ursE8e9GijAFJf6CZN0eFy0V58jzqDv7TnEZNexC83fh2nl3n9
         dvPSNd7nOF22Z8xFKremO6dLliMJxPmq+dAwFq5aXUl2QDOwl663vSfONFxuxpIcv0dU
         qZXiTE5JkB8EVlJL53FYfC4Wdru1Zf0Su1GzYHainYesVH5Rf1ZKrDvsavmbPmOXjuZ8
         ZwfCpaza90w5hIPH1ejhZ+8lYJZsVf4tT32ekpTTByT/LU0OPRvy3/KpBBFLLwRZffxy
         VCN9W9QA7zH2pAwZdrt3GCuyjDtpi8/KIPhMbfhrIv0dPhXSOJ+bcG5lBhVwiDWKjbtb
         V3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537031; x=1761141831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H15Ndv0vlQpY4JdGJ2qdY/sFBfa40QUCfx7fpFdGPXs=;
        b=qzWcTCIUKUf8+Vq78iD76K5bQegyjZGiK+wcJpNna53ZfWrXXewVdkGrIrGx+202q0
         Z4TdEaC/+3k+pvxmvVXrvfKzEbGfHylO8Ze1RpnTJkmyDNQe0XVLUIZi5Iw8712OKKp8
         boA1udjxYe96FN9mbe37WzcZPo1nEtYbj8d39vM8iy4Zj0YLvHJWGMfq3R4n3DURadsk
         erVa6we3T7t1PKl1fSEuDx4i4DWfQt4dKJVsCBmznqOETp+XO4H/Jx/thcGYgR9BkD34
         e1IMsyfqWmVtvQndIJXZwgFc2I5V7jJFLyQCh1E3HWBl8MX/MCMKgjkcG35/WV9BO9s8
         k9yw==
X-Gm-Message-State: AOJu0YzxlyIcnV3DQFMQOWS6Kd74Y7xYnpRZ3P/tdHYbomq2pg7ggVni
	66/JmWpHGQSy50pkm03vo/XkupMb/JrVhYciCrHUirHxpgIH45vFMu7SIfffESsndJS13S1C
X-Gm-Gg: ASbGncsZqr5QzcSrVQroEiRj5BVzmOf6YL4yDhN6YqGs+PhekoN81ogF1S6meZH6Jxv
	RdbcwHNljoOiJxn2HiuACmhoLfAOBqgvBHMhh3/r+xliubdiXFVDNTzEbbu9Y0iq5ptD92K0oCS
	ccwZMRo0jH3PkNYSQAoXP11nKebtnQdv/7dunE8fSKzHXzXtDSHsTuDIF9wj29sw7Bzkv7Lw1jJ
	stJUBSh2pei+b98rpLlMvosAPK8j9vVRyQDK1uHF0f0AMLauSspHJCU4b8oPTepqBxA1ViaRzwj
	vIaPYJBpdlclmPcQvlq/Hhanz22jGVA6WqeN5NjK/W26hFX5rtToE+RTS5H5fY19zk4Jio9qYGU
	cg9vhJFd86Nl8rDxgGHIO7MNig2V2EluDNs/Qhj+HugteaSantoHqcuveuNWLrWF5H/aK6Hq2Nl
	aoTdxEA/wIpHOzMtJfWs4vuz4L55FQf8pB8bpYmSrhuibujibbuLpbOyDcvzanxP9AxrKPgbRY7
	8UkeOfDWb+RuAAQEfaYpIlvQJQQ3JeLxkKFBHBfCfjQWctPVRJgBg3tQm14XIlryQS+tpWQ8kNp
	K2JM9B1oc34=
X-Google-Smtp-Source: AGHT+IGSZwuSLBzROYfqBZ3a7ZVP4ul0J71H3rAAsDmpm2zO9Tx5oDNu1h6Dnqe23epBfnbDZDz9jg==
X-Received: by 2002:a05:6402:510e:b0:638:d4bb:6c80 with SMTP id 4fb4d7f45d1cf-639d5c79c99mr24293935a12.36.1760537030976;
        Wed, 15 Oct 2025 07:03:50 -0700 (PDT)
Received: from localhost.localdomain (185-100-234-112.hosted-by-worldstream.net. [185.100.234.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c1348b2sm13569524a12.37.2025.10.15.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:03:50 -0700 (PDT)
From: Solly <solobarine@gmail.com>
To: git@vger.kernel.org
Cc: Solly <solobarine@gmail.com>
Subject: [PATCH v2 0/1] *** t2401: update path checks using test_path helpers ***
Date: Wed, 15 Oct 2025 15:03:28 +0100
Message-Id: <20251015140329.13691-1-solobarine@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014161446.6135-1-solobarine@gmail.com>
References: <20251014161446.6135-1-solobarine@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** 
Thank you for the timely review.
I applied the corrections and resolved the issues highlighted
in the initial patch and used the appropriate test_helpers. 
***

Solly (1):
  t2401: update path checks using test_path helpers

 t/t2401-worktree-prune.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)


base-commit: 60f3f52f17cceefa5299709b189ce6fe2d181e7b
-- 
2.34.1

