Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A418EFD1
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897933; cv=none; b=WUILSa28peRGRTRTOmku44SuU3z5ulDuPTNU+y1QD0rYMqyLafArarUqS+mxibSc0MljNzt0QeRuu+9lammDw7LFggzPosx4aqXpKIx4TY5UwfRTJ8EycaJP7N1uHPcGUSlkrxxwfbnPpuJ2eum3sQGLhh0P2vmMLjDcZpO4dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897933; c=relaxed/simple;
	bh=ptgyRvG6ra8v7zRYP5Kpwe3ESIuzoYU0LDg/Hjqo2XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ey8gH2T3HhBk6vZJoIlm2TFe0DxPsZcznaTamqniV4nRWBRKRq/Bb3McJ333P+HapTS2CvM/q6bb3WZRs8c9KQLoV4fdOCXVdbVcAr6WxjSTuwbP3qSzol6ibLjCf/NMdd5777cLcyQWAEvzflulnphXJpFYlov/hbO/6ABPfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYanRkZb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYanRkZb"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3fd71badso475750185a.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771897931; x=1772502731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7hPFi5/RokDC7BihW2uwmrqqeVUt4XcWuJIEmkHQMA=;
        b=dYanRkZb7EI7Cc1mQ6ZHGyZI+4L5M2/HgiO/8cgSIwSlMYzZa1bTa14QS2RHAypNcE
         LiCw7qGVcSWrPq7fhsLTcDSf8rDkPQJYn++s7wp2gj5z5UtR/dv7sJsypfcpd5WvrjG1
         BAghh/yCha4lFdmin/3rFtQuQD/Vo0lv+aqGn3OGN0NKl1X7h5YheyJ+9w8RthAsrXAF
         j/G72ly+kjmZ/Gf+hkXKkQB5+CSQEnBYPe3f0PIp9eF54kybGqCSn3S45Z7Xh6PJGHoB
         phusJ6pOzTTQLqFIl5A4u3ljvoRymGPXuTHeswjVX+3VFkTB7f2IUtvGB1epKg2IH3Gn
         5oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771897931; x=1772502731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7hPFi5/RokDC7BihW2uwmrqqeVUt4XcWuJIEmkHQMA=;
        b=JXl4UFHuSToSw5u37eL8eFytn4AvP/G+tSVqPXlUr62gBXTaUJbB26lY9O04jQRUpD
         He74N8CF8frDYVxmxng1YwybNx0aHvRV5+Y5pJ9MgRezvgdEXWPxuoEZR1B3tjyezsgU
         hS7oI5/zg3HUCDgcuk685UrsCi9RrJhPklN9mce2Do4oACTf78YN2kcYTxOhdAWozwbR
         RbR+eFYPBj421axxQNZcIZqAxnG+pQDUFwgOTnoswDcoe90oZoqdnXUY+vslo9rGSpTc
         8eK3sNetgEZYsJ0CNCL5093MfcQnI5wdZP/2jVZUK6PrBm+goFBxxophHSyPHO0uyvhe
         jegQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZEoGo0nTcRpPSYDlblfBpsCW3O2YsGLMfLWtgayZtXNyRtrW1iN6vgoSeu0g+VIIuwH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4t1l2hdMtLZ1VkEKFzk+HSdIxwjsg1ahlLgctJr8uz4dMP7c
	tGZk9OeFQ2b7U4LEL4QE0TwC+4uBqAR46z6KcjVqMwt8WKS1KyBhSLVa
X-Gm-Gg: AZuq6aLu4kLCk4g9micgmW3BaUj5QJCxa47tn2ZJzSzdTJuiXjeIRWZ+HPmKa1EWtXf
	3QlgwUz3cyWHKruhcqr23o/r6TKwkfEGLQhar5M8VgDxb3Mt0iXRr9t25dIbhgtqF9hDaehhrYQ
	2nw3Df4O+b8Kr1CvpdCbBUSWF8MpRJOz8Be1ZAT9Ki3fZfGoqClLcgO9qR2DpUmuFc+yk6QRtrG
	cC2tnjKPtT6CPqigfSfqpVHwGu2qIXPbX4WhnMCXyRR9KUY42dFJrk6XY1ZEYi4AXbVs2wTybmp
	THgi+aDugulbQbDzhuJMgSCH0XyP3qnUlrCfvHbY9cGBTU1G4q+VjzcYhz2mQKQ7+3l3oyHr6MK
	zFgAIk5eRsHlnqyx5QP3ducYwjs0JySZFsIF9f23wDKsB1O2wh4u8eoeHQetExW5yxHaZmB4b8C
	iop5/+Jj/kygIovdhCDG0eN5SuFQJgAN0KGAHqfmrFPpgraN3oHzdAmRwNcJW/7bFOMAU2Abits
	pttpcSjuYP4/9SLqR3PiltJsStRoe7vMIpCDPt235lPT/9J
X-Received: by 2002:a05:620a:414c:b0:8c9:f9c2:118e with SMTP id af79cd13be357-8cb8ca156e3mr1192394685a.32.1771897931462;
        Mon, 23 Feb 2026 17:52:11 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d100591sm864061985a.35.2026.02.23.17.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 17:52:10 -0800 (PST)
Message-ID: <1d4d795d-3a0b-47c5-864f-56f3c7601d39@gmail.com>
Date: Mon, 23 Feb 2026 20:52:10 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug: for-each-repo malfunctions in worktree due to GIT_DIR
To: Matthew Gabeler-Lee <fastcat@gmail.com>, git@vger.kernel.org
References: <CABpCjbY=wpStuhxqRJ5TSNV3A-CmN-g-xZGJOQGSSv3GYhs2fQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABpCjbY=wpStuhxqRJ5TSNV3A-CmN-g-xZGJOQGSSv3GYhs2fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 5:58 PM, Matthew Gabeler-Lee wrote:
> I noticed some scripts I have that utilize `git for-each-repo` don't
> work if I run them from within a git worktree, but they do work fine
> from within other directories, including the parent git clone of those
> worktrees. The symptom is that the command I pass to `for-each-repo`
> is run as if from within the worktree each time, instead of the repos
> fetched from the corresponding config entry.
> 
> After a bit of sleuthing with strace, I think I identified the cause:
> $GIT_DIR is set in the `git for-each-repo` process, and gets passed to
> the child git invocations it launches.
> 
> And thus, from within that worktree, `git for-each-repo
> --config=foo.bar -- branch` becomes the equivalent of:
> 
> GIT_DIR=/worktree-parent/.git git -C /unrelated-repo branch
> 
> Which of course is not what the `for-each-repo` invocation would be
> expected to do.
You're absolutely right on this. It's a subtle oversight, as it's not
one of the worktree-specific variables, but GIT_DIR is being set by
the worktree logic.

I have a test and a fix on the way in [1]. You'll be CC'd when I send
the patches after a CI run.

[1] https://github.com/gitgitgadget/git/pull/2056

Thanks,
-Stolee

