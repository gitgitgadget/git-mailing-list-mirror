Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA034F250
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299994; cv=none; b=bDFrd6VbMjBER+/VyZ8PSwWaGKXkCgxnTrQ2wOwgKFrEOyneLqo1JDx8HOX6S+9qmwmDGTMh28F0IIqoyBKGl4s/4XI68vU4ld1848EAu2Xdiaqn3W72sjR7sKqUQU2YOmywKaDTrKVcKm+UQhn8bW2SUDyhIKEdAYEHxdn2bRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299994; c=relaxed/simple;
	bh=tSzPEBU2+U/mhmVlZ/e1fxhLsGDCai8lIa+3srTfjrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgHWqziUbbA9a28C1p698RH97YnQ9NxFzPgDDDuYrdhhoLJL3s0JJY3o0vRyPmE4Htw0AFn/eJfZN9y64zS+p2RnDB9ZloHFtDXy87S4SvQaDhhuiM5RovDQNnB/r9IEIIHbPVjbBHCAAPUFHU442AWrGZVfLkMg2mg2yKNx/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMRoefmB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMRoefmB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adbd435864so11936895ad.2
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772299993; x=1772904793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtSYpFjGmBiPE4X+q1qc1+yeASuZZLK0U9nKnN27i7I=;
        b=VMRoefmBRIMgeQmJaUhmMS4IPhsLHqFMHUQvjhAEEgdkbDXf3UYH7zUNh4XYTb8oMS
         C9L+iCqVKBrPfXmpfJtqGpKzAcgOB+V3Ld7Om2ZC7MdbNW1pl0NrIctvc4KD8mFrwEDv
         joEDHvglyzRhGgnWYhWgcPYEYyDJbq45h5cvpW3gSE6LpR7bnST4MnYctxyijnuebG7b
         ObNITGF1zrTGb5T88ZX+S2FRbXt1UwCApUeI7ngFQUQ8oUYGxsWWXZ4GMIDO7C7VGJHI
         iWjEtC3AGHcKGF6FtmNmHNeqBe8W/bGCURsga6NwCJ3GJvtiGXF8xXYKZ0d4V7WVYkfS
         ey/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299993; x=1772904793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtSYpFjGmBiPE4X+q1qc1+yeASuZZLK0U9nKnN27i7I=;
        b=IJSwe48Od7wUH3IXigb4mrdrk9jbvStyXYwEx/WKvC1WB/7IrxyDmMkTdjH3M0JPtX
         aq/cThwf29snyXCpwLzf6sEK01IT5SGHsVxSLCIJ8ainnxOtUS0fBU1pL6K+FctFUfHd
         o3KGlp59pCWk1Un2Je2KHIrv2UmADbE5nO1UR+Ba7o3I3N0SiZYdMgwPi/G2VCQYiApR
         Oy8c7XexK0nO8EGrjC8NxKKKiFtlOtkOEKHoLYsTwCSM4QmoXtNFYRdFXuiVmB07Q+Lo
         UUxX47y3jQpHK5EvZY3lqK4AqY3XFYCDgeFpiTtufo9poloXT0ldDqDGG0XhB9BTbFHa
         mQYQ==
X-Gm-Message-State: AOJu0YyEkYzTClPeLmI/gLQyPw1t9hewwl+CNg1qEdCyNR6l0ypaTazs
	UlxJiK6bBQmTMG1Ir7bMOI7hN014DI05LsrTctb94WM4bOL4Akz3q/a5OwKDBA==
X-Gm-Gg: ATEYQzxu0G66j50Yv/V9sb8eIA8WdW4L2XFE8QA+waxHebGwefdx4hdB9NE7oFISSZ4
	KOUImQylzQXs9YipYDkSO8PiKSXHU3LvQXlQu6ZXWnicn6nOsLPd0Rs8nVU146u3Pu88NAOzTs8
	g0eASenxNNN1U8s6iiqCtcz/91y8Fw09c6L2l3TSxrlzjt9ir8P2i2p5cbhnzJv/hUs0eOKnGR8
	UVU9zuKaJD3TeZgq7UnwA+yNXJxbv5M7ooYrBnITHC931rJOFRYw3pwLEEA0l7hXIptAi3sDoFp
	D7LH45TNqcx656gMEj0pBmjvkjGHuMBhRBZqes//Nv4eTtB1/2pw+xrrKjrKR93pC9OrjRPjewz
	0SjXs7NUC+Voq2bc3dltjaU2iQ8e6j10NDi7/rwDBSPE+B2qZDVkklDgPu0ZQuVeIL/kJtCDyze
	45f8XPnBw4/SyLuxwilVOYFx6D6UB9VHLfd1OhzJAlS0RxY7a+eUD4ppC0QRqebaPrFuvnF0iSO
	uCpqNMbWw==
X-Received: by 2002:a17:903:1212:b0:2ad:ad0f:bbc3 with SMTP id d9443c01a7336-2ae2e4965afmr72668495ad.33.1772299992621;
        Sat, 28 Feb 2026 09:33:12 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f0ff9sm98643325ad.84.2026.02.28.09.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:33:12 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH] fsmonitor-watchman: fix variable reference and remove redundant code
Date: Sat, 28 Feb 2026 10:33:10 -0700
Message-ID: <20260228173310.97905-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aaMiu9mDVAb6Qvyr@fruit.crustytoothpaste.net>
References: <aaMiu9mDVAb6Qvyr@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This looks like it was written by an LLM.  Is that the case, and if so,
> how does it line up with https://git-scm.com/docs/SubmittingPatches#ai?

I found these bugs during code review at my company where we use
the watchman hook. The $output vs $o mixup and the double
output_result() from the recursive call were both causing real
issues. I used Claude to help with the mechanics of formatting
and submitting the patch, and it ended up as the commit author,
which was a mistake on my part. I'll fix that in v2 with myself
as the author.

Thanks for flagging it,
Paul
