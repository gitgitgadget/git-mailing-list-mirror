Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91776134CF
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767053940; cv=none; b=SzUhWxbMHkd288Sjg2Tr6hoWAxFl0+aFQG2trQjUqoz7DpewFq6ppDSf8t1gQIfLWM3iByT1t2EP6wzI7sKVgAb3N6GI3RRxn7ERMG30OBz6b74wAlFhiXCQjU7efCTkXyy7hyb7FNbpm9X60pR6DTOYG7ZPqMmH66IOFBD/iBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767053940; c=relaxed/simple;
	bh=qpJxPvW9nwmM+cJh6zft9HLU2a1m7clo7dSOxvUGqnY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fcr/eFM4UxHPyr0to1WWvb09PxW8Mzok4dY7Ah10K56gmpOuZiMDdggwN5dWDRllUmnf5FY1klgvK9LtJFgjokVdJtS5jkgGGI7EgF64V9UpeCKz71mn/4brXwxYG+IfLVWpUkDGKdlA1H3Z0aSvO2rig6aM7dcA+BeD4UL3GG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji9WXqbu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji9WXqbu"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ba3ffd54dbso1351800085a.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767053937; x=1767658737; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpJxPvW9nwmM+cJh6zft9HLU2a1m7clo7dSOxvUGqnY=;
        b=Ji9WXqbu4pUJUaHLHwKMS5tredAuKUfpB/oUx3FnCUnXq9IMlC6OpgfpuqW5wiD3m7
         btXarlHH0sTosJv2zOtfWJ/w1/4bj1D00qbeCaWmwo6CvAjfvBlFEdHcFk6NFB6DK3IM
         GU2HTU2VqW6n8tOJQJNTR0K701p/MFzXmgUMZJUNjBzczr7+pfxuIqm+hqLYriRRdhW4
         gdMzFrtWbWns9DJCV+6QYy65SlyJsfwrh3JA1IpPsHzTdnmrzF2t1jcg65/CcG2trOJh
         aNnp3GWzQtwJ1in1qfaOOcbKq2rnlSxQMkQdG8JlkMk6SPxeYHMdJwuBhLWbH9BXt6QE
         3IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767053937; x=1767658737;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpJxPvW9nwmM+cJh6zft9HLU2a1m7clo7dSOxvUGqnY=;
        b=kmPZF7SMWULAKH3lCnVstqUNTnS4o72PTXo+HSh4F9/M4Z35e1XWe5e0dTyzkR769p
         xP5zj1EOlyXTcqFLCAHFJ3ldt/UczWF4ksaDCTT+MCBn1yj9yDCRB+rQ531PRrgabMEF
         wkatxW34tYMeidKbZsn683YIUqdiVKcqhbwnvsVE/dQ2dUp5r86H1TlkafNBaHrIn9Ds
         yWoe6Omi8+xXh+wR9TBh9CX0oL87YWIJh4jFDG/+F6aPRBsgKdU/4CQz0Yn2D9iPbdIQ
         8Vpjn0o9+2an6aQ/bRI08YLTfnOlQBzvvzAzzxyK7BwUuwjj9HAq9hYFR2PJo/q1swYS
         pyvQ==
X-Gm-Message-State: AOJu0YyVXzIPgggWs6dcN8wOMyVj3BbhASSDwAtv7WTk5e/WgPFW6em/
	YmOnBGhgTKw9vEohheVOg8QYrUjGm7ER8w4Qlk8jmSYhHodW5GEYUYFlZEGMMA==
X-Gm-Gg: AY/fxX7AHevV2GfZhRwMVU+4O3p4zGyG9sCMzfTwBCWLXnc2d1FKiuGLOoGveBBQaN0
	eUtHZfZnSHZMtzOglcD7p88EbRtCQVh7lteNStU5FFs/WyI5u4un+zRS5DlxZkXraL0kNBpVKS/
	CqvR7RyoLnTQmBlibQyRuFLRsKzn+HGFuCX4x10g5JlC4ZnFV/0W2CCHiTjF4+KhR5PQWkB0TFf
	WJ78ygFy4e5XyrDJWwe4RhfuyVqd2phVyXxlIBSuRqczHlM+/Sqo3tb/2017GlOVxnsl2q+UcxL
	c1w/Ub0i7HeLuLD9dNHbKdBxRQRhuKGKqFkSXGBZtqIi7ADt1NrW3XNZ/of7cwB1X9bNm93twJI
	wiPGDx/K7TiLCPr8F3X3/EnHIxLqrlhO4C6TzLzMFbybTsAbJR8FZnkvGlVDY1O8o/K0/4FZT0d
	fwvvrtCE6Ze+I+S+VnJJ1nI/3hxNEnozjm1D/ECJv7RuqgUQ==
X-Google-Smtp-Source: AGHT+IFkGVhsDW/62egnfb2u/KjPpddB9NvOgXzI3ZMwgaIr/TQb+JLU/bDK91wMJGvExfsnDJIxMA==
X-Received: by 2002:a05:620a:318a:b0:8a1:21a6:e045 with SMTP id af79cd13be357-8c08f66874amr4639217385a.19.1767053937102;
        Mon, 29 Dec 2025 16:18:57 -0800 (PST)
Received: from [192.168.1.99] (23-93-72-44.fiber.dynamic.sonic.net. [23.93.72.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783662sm2577299385a.5.2025.12.29.16.18.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 16:18:56 -0800 (PST)
Message-ID: <16fc8ecb-01f7-4056-be58-e3aa20345f77@gmail.com>
Date: Mon, 29 Dec 2025 16:18:55 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
Subject: How Does "git log --reverse" Work?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to understand how 'git log --reverse' displays
commits in reverse order (i.e. oldest commit first).

The fact that each commit object has pointer(s) to parent
object(s) makes it trivial to go newest to oldest.
But, I haven't found a way to go oldest to newest.

I've looked at the code but it's not well commented.
Does the answer have something to do with commit lists?

Any advice would be appreciated.

Cordially,
Jon Forrest

