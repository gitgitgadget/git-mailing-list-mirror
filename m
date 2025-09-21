Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC18F54
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758446380; cv=none; b=pwZ9Lc9pYWFuUjBuWxHQIFzJVe+5Iu9PfFL6j0M50cholSxLh/g2Vv4628fIEdJs1rLY0bLBeMn6IpvJK0FtkZ7D5pSVflaFIp5X4DdTWejWD4IKeGLmapnro7+FwXsi9L7z3VMbYbN41AER5WupRmJcbguWV3vd2NzbP+1q16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758446380; c=relaxed/simple;
	bh=sZFCeCC2zJIJ4Jyv1lUlDZMngl4cAFnFJA0kRxhRHvk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=udICGUA1qz14UE5z+ElPfioRNClGhR9FI/cakpkIdgtMfXfbrucbu5vvKNhGJZYMhxw6AD0ii1Yf/diiHjNWPRx3krqxauNaCMAysSkOki0sxFE7R1AifvJH5C+MZTolQSw1b/zPDlDCdrn4cgRAGOX39wN2XVla1u9MQg4IZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1mMNsdJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1mMNsdJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1420599f8f.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758446377; x=1759051177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWrRO9YOz7L3HYYiXwvqQSqascLtY0gLqwY9mxEZGGY=;
        b=B1mMNsdJoLXp1HU806xz0N20J+9KEBiJnlxY+YyyYAoLc2MuKIYwHsIVzCA1hhkRiW
         VjXCTQCBqkg3GKGreC2T9Csr9HC42YeXE1LvDNvDjjJIHHyTzXKFJIo3Q0Jl1wGRFy9z
         ehQN1mKN0UXh+qN7l89jZDHnYmkyTUt+txXYjLiY4UOgl5jbwhwZ1R0v71znKwWKBRJW
         3xBeLjQ4SlP4IFGfZURYoyP7yYN9v+PrutOgijOXLvqmQFZdqAZfym60jrAKHGpiWwyu
         5XfkyIxAsh3Nxsm4PA78UtJGkOkzXHPR9nNvd3L/1esp43qS2bKLt83OlJ5FH8fWiSu9
         urPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758446377; x=1759051177;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWrRO9YOz7L3HYYiXwvqQSqascLtY0gLqwY9mxEZGGY=;
        b=iODJmZzkKuQq89mP10IVZ34zWvY3WJU+bf1QNSDGC4BsF6CWVjZncD21/fqRVderoU
         XyiyaIOx1aEj3S+MBxmFXfiHkXRL8xtqDSZjaJJKHZxxkjOfx/BmfHz2Im1Eer/+s8z+
         WRDM1kXg3qFcN4o3+UhNORhJveGzBZxNkmnZwVUYYdmtnpW6wGUL8V/AKl1BhgTwpo4G
         vVkEaGAKB6x0rZotjqUqxVbhp4CgajELpL9b74qYCSbkUCzJgfP55ox/qZmzmwuu6kms
         y52qD+RVoEURo6VeF2f9WleAmNGJALXbh6bNLspagTZbnvvQE7mqa91+/7LjI6Yu3Zue
         t73g==
X-Forwarded-Encrypted: i=1; AJvYcCUs89ydSma23G1nROXpGUTavQsThlIPBP2Mis0ZypOXfnNPcUYPVDOHw4xWnPyJEsVwNe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxam9PgCPiWaWnba2itDirUdpmtLGEAH12I9T/oF78we24UZ345
	TfrYxmo0uyORqVSYfv5XfkGx+Y0z4G/v0UhzONAwsyFQ3P8+o0WYTG0O
X-Gm-Gg: ASbGnctYcTZ61xreptjpFTcGyO/K/Hh/5EX8XEhI/nsPCiZIhJ8wKn7Q0Scdc0UlTiy
	d3m5Adro/RXu9Nmo/H++Rm/UcB3C9FA3SrjE6bqcLChFaHRooYE1xN9kwtR1ZoacTAZEu32x56U
	ctxB7uqu2RZB5MTo4SjqfPEaH9i/GnJtHb/LqI1CtN+YFYaDfw438tWBycEPx4KqLCFHcxujMj0
	ZC07+ukIsheuf9Jndqv+hiOcD8bjZqXTUTqw3Lu931vPgO6jVlyIZLw8+E9Fec4GhW76Tm1MIwR
	r8OgkWitiMZZJ2ktJa5CjmvIwB0rD0PaQfp3vUodZEkBUHJdKs22/YOu5W5c5AxyLFkDgMn6z2S
	/A6ppYJa9WblWny/6AS4Q4L5y2tU+zuiM9QH1Iv+l+QFMGS14U7s/GWHAHk/pgl8uMpSIbtKKxO
	I=
X-Google-Smtp-Source: AGHT+IGHgU0hm5HCmiU5myRVE44hi6pLs6MTck5flJJF7i66hqPAA+9nLuRq2BLt6mfM4g1x33JsNA==
X-Received: by 2002:a05:6000:2209:b0:3ec:e285:546b with SMTP id ffacd0b85a97d-3ee8558132dmr7511322f8f.50.1758446376638;
        Sun, 21 Sep 2025 02:19:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbefd5csm16083978f8f.51.2025.09.21.02.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 02:19:36 -0700 (PDT)
Message-ID: <c8a35919-e1d1-4d85-b7d7-81923667af60@gmail.com>
Date: Sun, 21 Sep 2025 10:19:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/10] xdiff: treat xdfile_t.rchg like an enum
To: Ezekiel Newren <ezekielnewren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ben Knoble <ben.knoble@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <1e404c3290bd4ba8b4973a597b976c301138cf73.1758294992.git.gitgitgadget@gmail.com>
 <xmqqms6owu7o.fsf@gitster.g>
 <CAH=ZcbD4oi1hdWDK8s2g6mQGrk+kwWffnSYE5gQZ_d3Z2Z3euA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbD4oi1hdWDK8s2g6mQGrk+kwWffnSYE5gQZ_d3Z2Z3euA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/09/2025 01:38, Ezekiel Newren wrote:
> On Sat, Sep 20, 2025 at 6:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I am not comfortable with the idea of exposing a set of overly
>> genericly named macros like these, especially when they are *meant*
>> only to be used with xdfile_t.rchg, to those *.c files.  So far,
>> when they include <xdiff-interface.h> (or <ll-merge.h>), they have
>> been rest assured that their namespaces won't be contaminated and
>> they would not risk stepping on others' toes as long as they stay
>> away from inventing their own xdsomething or s_xsomething (neither
>> of which is quite similar to how we name our symbols and types).
> 
> What if I move NO, YES, MAYBE into xprepare.c and refactor `char rchg`
> to `bool changed`? 

That would be good as it avoids the possibility of using MAYBE outside 
of xprepare.c

> The problem with bool is that C needs to include
> stdbool.h to match how Rust defines bool. git-compat-util.h didn't
> include it, then it did, then it didn't because compat/posix.h
> included it instead.

75a044f748f (git-compat-util.h: split out POSIX-emulating bits, 
2025-02-18) moved '#include <stdbool.h>' from "git-compat-util.h" into 
"compat/posix.h" but also added '#include "compat/posix.h"' to 
"git-compat-util.h" so there should be no problem.

Thanks

Phillip

> 
> How do you feel about xdiff.h including compat/posix.h too? If we
> don't use bool on the C side then Rust is going to be littered with
> some_condition != 0 or other_condition == 0 and won't be as clear that
> it's a boolean instead of a numeric type.

