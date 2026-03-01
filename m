Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0968305E21
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772392012; cv=none; b=P/AggrkM0gwt2Zq/KVD2k5t/RXZcM5vGOE4RSBeqpW1E6DW/YlRedjjnZTYyj5CJapVKHRiVlSampYAO80MnL+nnnxh2leAB4mneHUMw+MriQ7BrhKIiP1ZF4Z/p1FEFY9GA8DFFcrIrUtALVeykdGIR/wn6fPwWAXX5abQcz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772392012; c=relaxed/simple;
	bh=MvWILDFkVJW8tj/xwip2uSXakmSd5eOVneXo9ji3S20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xw8nFw/9IcRfXpDyyYV+x2+i2lJQ2Fe+YOi5WvJZfYR9SZAnY+MtJ9WwNvO9qcMMOOc4CmTWIFzN4kB2WxxfBnRNTKqaQnNDOKhrWR5psvEaVdoSYD2XpXT1gnYUcImg2tit6bAj8rN2jyTPt+dkhgpdJ4B21kM2hNIr743Cbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awve2L5D; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awve2L5D"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-389f2c46d80so50065941fa.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 11:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772392009; x=1772996809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR3GXNp8ZUlQmdAUZjXcsKnsi9Q8QBt0SDhgjEt4o4I=;
        b=awve2L5D7qEgiHqWB6bClzlhziLUEfNivEuD4M8gKYdvUFeo/ZGk9H57eUUF30D+ae
         oZfvqawFg0oqu2/LCAKVLJ1Ynd2IJDy1dXp//NCcpbeHxA3FWkMfBnXYWj2jwhYNMOwQ
         LmLO63YwqW5bjDAdBYnB/3ZEfxwv1lKaz8hilSVSWpvlMG1X7seItMVtpmbKcQvGt44U
         6nrHbInR1TFQQd1RYIP6s3BL1baKOrWATFhM723b/asZE9lzjRXRO1Nkw2ZkNdGD3/ZN
         csZRMjicgiLiLZv1NT3DNui9XrhQrtrDC0ZHGvFOMPa+E2uNJzI62CNIh5xlSrFToa1P
         9TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772392009; x=1772996809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kR3GXNp8ZUlQmdAUZjXcsKnsi9Q8QBt0SDhgjEt4o4I=;
        b=Jam0lgpzG5lK7cC1ZO3UUHb74gxfY7EKmMsgzi48iQGT9amSJ8Hb7ayNsR+YLYBexl
         OwGbJwky0N1aIfPrKxTwkwu8N1reIP5vlmbpqf4sWcAYnzvrQV4F1woBu2gHphhGgmMy
         14gmj2uWJ07oWkLVbJyrO0MACa+9dwVmkpulWPCgk7LOZWIe1dK9ky29ir7msH4Sd4NQ
         P4FMccyDVJZtpzuSBmUqaPt9hEuqVR50AmS4GewkRo+LS+Zw7Q739HrLiwQSVVBvbccw
         vGTScUyb5Ghkesb9mQjULawdsYuUmMEGNRSniFP1pKFvI1xNOZ4Q/6a5zcQv9LS7Kbm8
         JNLw==
X-Gm-Message-State: AOJu0YxdRxCYSDfhZFYrMccwMRMSgkFyZ7e05hDbKZBXekCxfD+1DchC
	gsgyImb6sGFsgHtD2hqM6Z4j0adCBlRPw/UMWgc+LKuwi0dmvjBUB7KE
X-Gm-Gg: ATEYQzx/X/ctdco9XZ6CA6ZaAsVYLLCj05ZFmhyRgp+8OlE9GZwFwZUAebsNobSO6ci
	4iKOZRTDWLWoNDlurmL/wbcC2iHQl6DETSKTYP8n5bvyWfB4YOe5gKwkNxxIM+MiQjUgVdzMRTI
	hF82VQApi7cj6UYoVIIKjh4qFUW7cvBow4/qicNdcLapBNus2i8nnYA/xg4XsyBDZd4TWUI2MUQ
	9imXXhhOrZCD3+m+iDbhOPVJKr1XBmnmouk/qWkb6uu6lFV+IAsRBdWZuVuKMz8cjMhPcRJwD3s
	OJ40aeh39yLZnOoFDUXsyu28quQKTI4pTWrkUmFOh/wdpGnrFvi1KnogyRg4JY6eu/pewb0/MRm
	AobuHvb5+dl97aHUGK68RKisqounOP3vPQMLDLK3wtom3BcCk/Om/GwZTLs3rvB1KzUxX90XFkK
	T0DKjzBe2LVw4H9BE4YEYRv9dutvmNwSsrUbLArEiZUHl/s1sXqH9YEsQ8S29Uc3tQwJDYOTsqd
	g4zp95knzHFB6mz42sHRKU6Hk4=
X-Received: by 2002:a05:651c:988:b0:389:fd1d:48e9 with SMTP id 38308e7fff4ca-389ff36f884mr60982831fa.40.1772392008897;
        Sun, 01 Mar 2026 11:06:48 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a115bce112sm1194856e87.22.2026.03.01.11.06.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Mar 2026 11:06:48 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v30 0/2] status: add status.compareBranches config for multiple branch comparisons
Date: Sun,  1 Mar 2026 20:06:47 +0100
Message-ID: <20260301190647.41248-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqa4wv5xsb.fsf@gitster.g>
References: <xmqqa4wv5xsb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Will replace.

What does this mean? 🤗

> Let's wait to see if we hear further comments on the
> topic for a day or two and then mark the topic for 'next'.  I didn't
> spot anything unexpected in this round, but haven't had enough time
> to spend on the test part, which I want to read a bit more carefully
> before merging.

Did you have a chance to look at the tests?


Harald
