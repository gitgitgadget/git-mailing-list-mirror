Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE1350D5D
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115400; cv=none; b=gQsePhNGnsyUlCEaQvtNusXMlLC4RklIg9X8EZwXxJOHUDRXu8rY/pGEX9Nhq7mG2c5TouSxDaNxitA/1Q/Fjva2uT+n5TO8M6jXiBJJeKANzCJzqX0l6QlXLGZE+ofzvzZOxfwTGbtum5lfq1+ES8v8rGpmbW6yV9EClzYxtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115400; c=relaxed/simple;
	bh=RBItSAQFAmdFDeXYkHAr6zSRnobdS63RqP2giWmq/fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHYMlSUxvzzDH3HJEry6FTE0SVFMPmlmaQsJ5RWUgxYaETcEOaRQI/cKfst1o0MVjAEzfB+25nxk4Cu8aLWAaRnfKVBSTFzlXYmalT17OFTrZs2LCP5+vIjpPet2sJbSqv5zwn0VxxHPNyOHvxA55kz9ULNpytyV2gtQRs+fsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+VlmU6q; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+VlmU6q"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-385c23b88e8so15486471fa.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769115393; x=1769720193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjYoSxWASHNt43aMMnlFiQyew069/ZVBPgEY9HFHaAA=;
        b=M+VlmU6qk6pKOsYvo6NJqjp8h8tDDJk6BSo5raBZcUiTi82XF6ttZSNM0uigOSa9YZ
         cNi3JeolbMJHurxxif7rAAyuO82SAutJLYMzpFMBklPQDUfpA207Cqtkix4DCyQweAhX
         u+Q91/mxiQvQvWzd0i4ahEPFR+9fnEVCDmS83gI8rWA4FQVXmpd0T/KwbEuVFt3F57M2
         C5xfvLhg12nWhquZS6daCFiELh++32Zs6cFVysU0HZbk9bnX2D0ZvIugmIZJZlLU/UnJ
         pd3AoIku9B2fs057knwWDP8J8Pzf0LDIaD1kIQjjvsfS4t/H0Ou8BRt+mA63ZZEPqqua
         B1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769115393; x=1769720193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjYoSxWASHNt43aMMnlFiQyew069/ZVBPgEY9HFHaAA=;
        b=FswtYqh8UqYotl66xYCa9JdidtG3OrnFyV+06wwZM+3yij2NHHaA7qqqadLFHukHAD
         92ZsDCT63+z6IEHXxv6B7abS61UUpEOlJOkol0dNyWeNZRzk4bHTda2V37fZz8mKQ3k0
         y9xs83RzAMQFKFTGSv2K5G/IFdXFtzsg7mCuNWhBwH5T5Lq+OE/TAt0UlSYQ/C15aZP9
         SBDrjvtukMuMhSATfbB5OOAImKIMbl/1AML4LreEBiwmh2tz8edsr59Vg/AQuuk2QWOt
         B8Cs3c2UxYlz/OevPh+KVsaGJpTprDTfA+vb8COsLp7jtZsJarw52vvsEqos72FzsSjl
         WnnA==
X-Gm-Message-State: AOJu0Yyw9He5e4I7uecReFxzXJutmzKcQqQ8Ef55GSPlMgvgEzS8dorU
	UteSr4+pm0IDk/bAFopk1KqEKgag8ONv/oemjcwxaC4pUr8KQ3T1wY7uvonDAQ==
X-Gm-Gg: AZuq6aLQqVyTM2eQVCVYSnz0BJjfpCKz/9Ew1I2jyiBDeoKsCFDLOJ62MC/aLDVE7Dd
	0Q3JE5XNBqLJK7lmjVJnbKFFDDQp4yyPz/+JrJf5oM9wodNX9u1doR4EfVxpvGNs6lnf0iuI8Ou
	Q+MmG1RWqefcaKV9a441buCFb3CngHI+SD+A3C3HYuTuTHLYWf1f1lW5jd7bBMPfINtUVV+YHl+
	x6nHoTZCHk7GyjeMGL0385JJt1SAVoS93pFQlUc5f/MegQDBWc/GF7dtn9bKZWfZHjiM2oDKNAO
	BoqN1m1nGjxx5Gh9Y3BVheYXgbT+J5GkqonFypwMJ6BUymUR/JqcHxHiKTEKVkRvS4vqKZlCiX6
	QbYsaosQAI/OlVpQJUoLjfJp0vmHVJTJHhQEkqOwK4s7wK6rlmlps9N6dRwdSE5QK33YQz1t9ay
	C3FnAwACgonxpzFmasj2YgJWWyLtdJ5E0UUVLL4Pne3qyym3z0tRnitRVJqks+3a5WIykkdMs=
X-Received: by 2002:a05:651c:996:b0:37f:c5ca:b734 with SMTP id 38308e7fff4ca-385d9f662famr1663571fa.9.1769115393277;
        Thu, 22 Jan 2026 12:56:33 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385d9fae8c9sm1315721fa.9.2026.01.22.12.56.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 12:56:32 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Thu, 22 Jan 2026 21:56:32 +0100
Message-ID: <20260122205632.80273-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq5x8tmlj7.fsf@gitster.g>
References: <xmqq5x8tmlj7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> For example, writing "v2.52.0" there to see how far we came since
> the last release would become impossible if we always force prepend
> "refs/remotes/".  I wonder if we can reuse already existing DWIMmery
> that uses refs.c::ref_rev_parse_rules[], which should allow such use
> case, while still allowing you to write "origin/master"?

Sounds like a follow-up rather of doing now, right? 🤗

Since the inteface won't change, just adding more functionality a new
feature, we should be able to fix this behind the scenes later.


Harald
