Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584FE27C875
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385749; cv=none; b=sFe0uq5BhLMDUqfn5SiK8WlKrqDT5NAMP6f3BUR1NbJon8p7XGg48GZokMQBn6v3tYAV2KrRQfT8aviXEqr1Pb1k/EeYqlscqH7cnTCeAoPbgnMZ/enSZErN9x0NH+vDRPU22plzIAoIjF069Tgwcz5AOAMBRZAQPhxSDa+0jwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385749; c=relaxed/simple;
	bh=VB6MQXHv7TNSgl8mYao9SR8OLaxZtPJnO2L/qSBMohw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uD8tDDBHkrUdCnTYMPq/nx+JajYEo5U18sPg8DNJf8CdJZqhCZjsSOl7iH46qTr0gbPO7TS8Y6uAkAbkGxO4e8hT89Ddp4A4XsIVOT7eAo4kk2wOUsigeABWBosLlVQetGN7FN+KavRDb9CWwj8+HvqI7IXr1T0GHM+rik9HqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnsPf67d; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnsPf67d"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b27c1481bso1585674b3a.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385747; x=1751990547; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huyu3bYuWZ5++ijy+y6Rfc6ZV+mZD9jZYTTdXvZam/Y=;
        b=LnsPf67dJCLo/dBmYb9+TdKdT2nVLsX9A5YBt50YFlpKeXPBz1GxbPGny1r5RMMCh3
         E6QXm5c25urJN+ZlGfhdlq/oBkxQ+URwwFGYXMojf3y7jsULJF/gL2caA0+IRPhktpM+
         wNNtrSLymNN1YquD/jYBfWchauPfZ+Nu8FTdY4iIA1MNEzh7YV/3O7A3r3YiUMzmwB8w
         LAgPH0FzcMjIAOuM28i0wCwZB6o+3m4bZkF1PBx1LKLd1o0mJxcFQyNz3yLFSMuOpxlQ
         Q4g6HRqUJrZIuPeojdv5Q/IrXlyqVML8XUjgnw2cMg73csiDq+UTFYJ1syfwt17rbHbg
         iQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385747; x=1751990547;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=huyu3bYuWZ5++ijy+y6Rfc6ZV+mZD9jZYTTdXvZam/Y=;
        b=N4zYkUN46j54V1r84X5XZY/8eN4Lqexi+eEZG32oIX/DL9ZqU/S8cQ/8MJimUNEnhx
         E3qTm/7cR7iaWprG7IyPfdV8jsczw7Sw64qh5DWKi3nd5Kwm7wfNvVanx7JteT7tJUoa
         rqsNGA00lvMvCTCzpP78y9ctInW6BvMcB2X2QbDhn3mOdp0g8Y+yYVmJx0uMD/c7fSmn
         FSAL042yJbd1wfRgdmZYuG/ghDuQTgTNgBzUd1A/w7kMMF+Y9jFmdqb+581Ylc8EXL06
         frC+8xwx2UWHGnYaz6eo70MbHFtC7Y45h8fkzf4kiLswsN611KZVIBkNbpg67QJ9Kall
         iXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6fTW3nPYDbvoCUU4W5mBDmX+dPgjNEuro1Dlyc4kRTZNfuebTke65b8z+q3qey964Dbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3Jf9KBIFPRzHnxDVE8OtT44I5+aK0M8tqCGD3JXjjvzHcPt7
	dgm1p1hOOZ09N7PzD1HTx9r+vU2O0DO5t+MiF7hRu2T/MrnZBabrcroo
X-Gm-Gg: ASbGncvfccJK+HGOYczqIC1masHQJ7kwcXxFVSFJhZM9HwwJVLXl3wq3c+vcPJNciYH
	L8I7heNu+rB291U+tJusIJVeay9IMVbjZioarhqlhsecm8AXb2UKZrqPQuRY4iDwSeFt2VaD9fg
	X9Cvdc77hCf/1NRsKXJT+uhIysdI/4HavbT4h1NVdVWag+PDEha0/jTWXJkmKVSSN/ydxBsaw3q
	i4QzC+2ZdMWl96A33rbXLEfOm4rY3qBjFLAJr4JiqbUhH8QAXaJNzAV5RgBQz/7+6fTizT/YRPZ
	xlQqtwfvQBU8VY20AhotUDWBVWXhRFRkNgFf0DbWqTuioi0rfTMtRZ0MPHOenuGdHr67sPHrA6Y
	IvBxGRhpksyzunXZTdNT3GPZHYfznOpmoY41zPg==
X-Google-Smtp-Source: AGHT+IGEpEZxOAK4rCZprSc5BLwIEuqZ47Pwpi/W3RNk4iP3EcjnTRirCBTKvtWQLjx8l4LMNpu6Dg==
X-Received: by 2002:a05:6a00:cd0:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-74af6f7e391mr26593043b3a.19.1751385745764;
        Tue, 01 Jul 2025 09:02:25 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af57ef0f3sm12465503b3a.154.2025.07.01.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:02:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  jltobler@gmail.com
Subject: Re: [PATCH v2 3/3] meson: add rule to run 'git clang-format'
In-Reply-To: <aGO00T4c2Q-EYXZx@pks.im> (Patrick Steinhardt's message of "Tue,
	1 Jul 2025 12:13:37 +0200")
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
	<20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com>
	<aGO00T4c2Q-EYXZx@pks.im>
Date: Tue, 01 Jul 2025 09:02:24 -0700
Message-ID: <xmqq5xgblx0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +git_clang_format = find_program('git-clang-format', required: false)
>> +if git_clang_format.found()
>> +  run_target('style',
>> +    command: [
>> +      'git', 'clang-format',
>> +      '--style', 'file',
>> +      '--diff',
>> +      '--extensions', 'c,h'
>> +    ]
>> +  )
>> +endif
>
> Do we want to call this target `clang-format-changed` though, so that it
> is consistent with the implicit `clang-format` target?

It think this is trying to be consistent with the 'make style'
target.
