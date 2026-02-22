Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCDA3C2F
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793185; cv=none; b=uUp9RjAkvJzez3SAnEHASrp8hvof6nGECOJ6nnB8uVoxcJ4QV9JBrZqrTEuRuD7ur2rAXsWVWJnuTdSAtISwJKRfVzZWwwIJU6X7kdQ4bZ+2PxFcj9wtvz6ekmcVntM0MP/IF3OoEYmxqCEG54XWOhDfbE4DpCMU4oYvnfFPpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793185; c=relaxed/simple;
	bh=oADYKX7mZzKUwOWAKfHU5hi+Rzsc0qghw7hmt5vfN5k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mi2nYVfmqyHUm3I3i+i7TVc80pBTiA9+IilsA0US52SWg+sZVO5e/z1AjRuHyr1xICmEvBX2kWmQ4HKcwKJskynJexKNfobmaOSVEi1X9Nwo/0SAyR7YA07DGIozJKJu6zAfEOj6+dODzstPTMlfNgLzbfYQGjMhD8PXRa6GrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5M6SmV; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5M6SmV"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271257ae53so3358633c88.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771793183; x=1772397983; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvLu5ZbXxFt4L5ooZXLQHKo+lfkeJM5Mwjd1LsvI3Kw=;
        b=dG5M6SmVRBNuwr4VBmTxR1iG5LeD7NmhO+IgiYwh/lfP/ja9vLz0LUvdKSeDNAT9OZ
         T8OHUzWd28XmsxRImY6TezMDVmfZ8+GrAT9syeQyL6y/S33luyQgoe6aYnpo/kkZZX44
         4DM8EUeCcJt95UTT7+MIx96g31SNXONtRGtSIyjkoWF8X9LW5b5eySdBQsgSMx4LjqHr
         Dlgul4Xh/MR+nCLNcmFbGv3mz8INuh5o4vazDTl3v+Q87AR1DoZMQ8ui2rnw9Crkfgd0
         WUsWYGr0thK1sdOoII3Mk7CkMU9naz+dlVQ6WIdDmG/GwnJ5yHz2MSdttDk5I5wYbhCb
         oYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771793183; x=1772397983;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvLu5ZbXxFt4L5ooZXLQHKo+lfkeJM5Mwjd1LsvI3Kw=;
        b=LEFOMDafYuULnGn7xzyw9UgaM0eazKL16rEj9gkQLr9jw9hkyxyK33p0JxWoQSPCgN
         oOtnBjCyaz7mdROSFqU7MnYwvOrg7ruhSqEU0HTiFj+N8bECKiRlhSi00h+fA2HQ9Mt2
         7XDIRidSy1DCVQ7q1u0NYCI/ERbqq6h00CKzLNG+7XFY7y4UvJry/X6nXFO9oTXorlzN
         pKka+JJtd4dhwN8F4fLEid800/eEemoNYImPtYA/11pJxQ3q48DUWmDu4pnw0eKrZfRE
         vbH+yB1tygZAHs24VV7u78wENj5ysjYJxo9Arx5KtBHZCsba/QuRV+NKq1JL2WEfVpO4
         UcZw==
X-Gm-Message-State: AOJu0YzIX2wPiEIyrrdKx13FsPtP2Usf2Sb34FyskDmdqFuCAhhp91LM
	txD6JBULgYNBnA6wEzl9qyCDssLdGYRlmIHFEZ8QKy8sSrsVbbIHThYk
X-Gm-Gg: AZuq6aLP7pfr6b8BR+xZN/awXKRLOargqZs0CohSZ/iwsdK4qufmfHh0J01x+3tPUiS
	gVJa/I2GhwYvUqINsg9DSdRZr8Y0QPFpX7GukpAF7SxdHxeKraOaGVcva3XyaAr9rmf6E3kGRx6
	3aXeBoNg7/NTeNGM4meElu/1GfS78c9fzqALk1pEVsHrjJVrtHZNv69SQ1M8ONgzmqz/2yHOcnX
	42neXVjj6fpRmhlnXxyjtnz45IrqnShSWvaYL/MD98zmC1+7AjvzTKoJ2IM0LcNlD1hH/zORBDf
	pUMB6vhgRj7F6IxqiRHFGxGX/c0jJhDzJUjrx21kbfdXf/YEZDzwFNXKnqF84Palc1BFyfK8VW+
	UOcZht3uizvpjv4sEJjKK/vdbFfRyt5Vod90JGkDJT7QPTjxNloV/9QVl9/xHhLqD/D6zp+Nrun
	ok9YUUYH+grhcTG+wID5/KSzGRT+ieiV38bZwLi21BvXG9NqWRikhDENAqH/TrZbCa
X-Received: by 2002:a05:7022:618a:b0:11b:9386:a389 with SMTP id a92af1059eb24-1276ad5c9b8mr3008386c88.44.1771793183197;
        Sun, 22 Feb 2026 12:46:23 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7b4c7sm6284576c88.9.2026.02.22.12.46.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2026 12:46:22 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/3] t1900,t1901: make repo tests hash-agnostic and
 wc-portable
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <cb85ee3b48371048397a22564c3b5c112d7df57a.1771784936.git.gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 17:46:09 -0300
Cc: git@vger.kernel.org,
 Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 eslam reda <eslam.reda.div@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D1CDCFD8-F4F1-46F2-80F5-C2F55ADCF8DC@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
 <cb85ee3b48371048397a22564c3b5c112d7df57a.1771784936.git.gitgitgadget@gmail.com>
To: Eslam reda ragheb via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> From: Eslam reda ragheb <eslam.reda.div@gmail.com>
> 
> Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>

Missing patch message.

> test_expect_success 'mixed key/category requests preserve request order' '
> - cat >expect <<-\EOF &&
> - object.format=sha1
> + cat >expect <<-EOF &&
> + object.format=$(test_oid algo)

Don't send patches fixing the code you have just added. Instead, rewrite
the history applying the fix to the original patch.

