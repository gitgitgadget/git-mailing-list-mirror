Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8D28DF48
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297098; cv=none; b=TYzfJD0JufGo7uboLpTthi5YlA8866y6jcM6l9mnzf4kL1TSeOfLHjV5TXIh9atJzP8aMLXVrFMphiIRESa+3sF8mjGqLhgLwtuSaqcf9vjQU+aW0ia4D+SZT3M/mJl7FrL18e7wbsUtDxrnewBfSj9aTpuw19BoeWqZkabSHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297098; c=relaxed/simple;
	bh=bHD1rdQL30fxDRMJ99hLWDg1AZDL4GmMM0qz5CJQ5Ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwT1JWGG56rMf7W92Ed53R+sAcESzf0DqJhq++nZQvDu3YiVxFJCMkFaZv02xM6l0KPYB427WUKfQQKgAIoQOShNWASr1bZH/Wlbvd/Cn7CynrDOJSPYf/h2PGZUDiP5tgrSuZY6aW2KMkJxHLLJ5FKUJPuNy1BGr023rH0h+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSvMTI1h; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSvMTI1h"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso2032449b3a.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297096; x=1751901896; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e0BQiGdhR4ZnX86zMYqgEN39JARsqVhKDXDrAgF/do=;
        b=bSvMTI1hvPYFr0/BBxRLLvkmI9RXCMD9TfRQ+6Kc0MwO/T5z9qKaiuJrq7/9laneps
         k3RkEvocYrLH/4Dq6VkdEmLcuQCEYuOac+IgW1c8YN0YI6//4htY83N4iwXQ3fkvV3DL
         IRjVKo5rwrko4om77/fP3J2IsL8vK8KggHn6JHNbHu+Wyzh2YHzfGdS8Ht8ic+EmdUYV
         5LJu7i/6RNiRTwbHqNtTWIUMUtaYCByZziHLhq8MVf0G6ieBxXBk9NbBhozKyx6MWoJL
         qlIRhYkwVpdBumn1PbWHK7Z6mp5ofZVeXJP97wFOblwVrzNRTIpmSIsFxBc1M4jpxxtg
         t/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297096; x=1751901896;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1e0BQiGdhR4ZnX86zMYqgEN39JARsqVhKDXDrAgF/do=;
        b=WFLnxon+/YDfcC7zyXq5M80GyqzbW7kSbdKipV8r3CXphQ2n94W/tBxidWEcj/6JoY
         e0qmjn6irSFGV29SbDqAq7XZpa4XBQmzDCuH7+dX2eOV75mhxpBS7bWMgEejY1fNGsfn
         Pm+oVu0nN5GXR9MRzqcKovySOFVrXqLDOW5m5GaNrJ9bCYxzc+cJRGTKy/uKI8EnpDX+
         iRpeiQpE1SB9Z/bmL48x4WY46gPyLWVyQRFf7bvJQwk7xezXjdjIB7vq8hqav+iLEWSo
         mEqfe+Uc+7Up9MhUYSkC4iH145OtDBBiFlGzfY/jxQt+c9piVbKXav68oPx/kkb7910H
         Iyug==
X-Forwarded-Encrypted: i=1; AJvYcCUV7kNnbXtDZWbb18gQDAcV1yjQmrMvZYktXAMkw/HEWM3xrlIRmxaEZ+AucbAryu4XoNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHe3XMao1Pxop8jz8/V53InSQw03O61yxAMKNgXxDEOubrJLNn
	hl34TnVXGXyblxDNoXYL2sFM+NYlRD4E7YqwwF8M4nSlpKgBvivv+oeH
X-Gm-Gg: ASbGncvTnIhnx4NL/gK7WF968lkrNvOm+79Mdc3hAjGP9iDN8TjxBheZMbNIgd+BGEB
	FjyTUDp9sRcuNxMi6XoZpt4n3cyBNF4P29JGnzYrtKDw5KbqURcTWTIPaRGlt/ApBgr8PIw4CNI
	YGhJ5RSOa+qKjTD1x2cwIGwDXAv9g7pp+k7FDbxyy881RjdutI3xCi8km4d39T+TwW7eZRjVL8G
	oX+3kkwU08In5U0qyvDd9a9Yn8yTe+w7Ciu+YacV0Zr0h+WbmwPmWb80X7IAAFQw6YIwXSY/8U0
	+4hxPtzOYe2u13PFJitTKEjm3QS/G8UT2IWqhtjAYa2MzqK8BIOrkCBrq/njy8pGV378QVUKyFw
	NFg+mYqA6USbgIWkgdy7Przntgq4=
X-Google-Smtp-Source: AGHT+IE1hQ6K3W3d2QM4DtaHuzKcAXmdBzNxQA9RzxlGMGZGLLa0HuR47QpGdSoxbOXXBg3c1nSfdg==
X-Received: by 2002:a05:6a00:894:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-74af6cdaa50mr17304014b3a.0.1751297095351;
        Mon, 30 Jun 2025 08:24:55 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af57f25e9sm8872786b3a.166.2025.06.30.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:24:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] meson: add rule to run 'git clang-format'
In-Reply-To: <CAOLa=ZQD71Z4GSRNCuV=YL1zwGOXa-sGzpU9=8yfVcg6vJA6SQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 30 Jun 2025 01:34:48 -0700")
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
	<20250625-525-make-clang-format-more-robust-v1-4-67a49ecc2fd5@gmail.com>
	<iutm4xxkhchcpfygtqo2s4nit42sclzen63465ljtovzgdsebr@okpj5jtw62r6>
	<CAOLa=ZSJH-Wji+-oU+ku5aojYzEuC96tUu+24UTuTxCxt9LYNQ@mail.gmail.com>
	<xmqqtt418dnw.fsf@gitster.g>
	<CAOLa=ZQD71Z4GSRNCuV=YL1zwGOXa-sGzpU9=8yfVcg6vJA6SQ@mail.gmail.com>
Date: Mon, 30 Jun 2025 08:24:54 -0700
Message-ID: <xmqq4ivx5k1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>>>> +clang_format = find_program('clang-format', required: false)
>>>>
>>>> Should we be checking for `git-clang-format` instead?
>>>
>>> Yeah. While `git-clang-format` is packaged with `clang-format`, it does
>>> make more sense to check for the former.
>>
>> Just for my education, what does find_program() look for?  Installed
>> packages, or a program on your $PATH?  I am guessing that the answer
>> is the latter, in which case it is not like "it makes more sense to
>> check for git-clang-format"---rather it is "it would not work at all
>> if we looked for clang-format", no?
>>
>> Thanks.
>
> Good question. To quote from the documentation [1]:
>
>   find_program()
>
>   program_name here is a string that can be an executable or script to
>   be searched for in PATH or other places inside the project.
>
> So, 'git-clang-format' would work. I've also verified the same on my
> end.

I think that much everybody would know by what other uses of
find_program() are looking for by checking "git grep find_program"
output.

I was confused by your "it does make *MORE* sense to check for the
former" (emphasis mine), as if you were saying that both would work
but using 'git-clang-format' would be a more kosher way to express
what we want.  Given that it would not work at all if you used
'clang-format' instead, that statement was misleading.

So the response I was expecting in the message I am responding to
was more like "'clang-format' would *not* work at all, and we must
check 'git-clang-format' instead".

Thanks.
