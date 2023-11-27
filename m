Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="E5aAcio3"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595699
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:39:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27fe16e8e02so772185a91.0
        for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1701092348; x=1701697148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rb0SDVMLcFk91BVXMmPnjvTVBQkdhJLrHM3mjTI9vaA=;
        b=E5aAcio3pOBls8jEAvGdnpAdGDeSrfZE4BNoPKO+xymQhenQnnlMEVTs+aLf8OoHE2
         WRCw8fD1Y/MWQyOz3l+hxs4DizmG8z8rfeUqe2FJA62/ubY//frxNyfRJKv3EMEdLJtZ
         dVQh57ro7MkkkhO9XYJBLAJ1Vz3cl7FPjdPne4fzBU8MKeRSOpSx4K3qWJ29JCbbgQpG
         EGmzPllN6otMdQLF6tfVxAwp3b9emBp+32xFf1ft8VXWuc18PuHZuApWMdk88syMbKML
         RgSMZlmFGKBoh8/YVxNgSxZR7lJ8IkqrMZT1l8EHbZslbnLq3k4HSdBYC6umFQAZslZv
         ChHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701092348; x=1701697148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rb0SDVMLcFk91BVXMmPnjvTVBQkdhJLrHM3mjTI9vaA=;
        b=rMXFjlkjPIKQ7M5fQxwJkVUS6vDncH3KGdtFW/4ezqHucd8/4SLIHAFYBVT/Rax1XN
         4DR89iyjPrec3ZAKWEiGoTnBObxzPfVmK3yDaB5tiyZp0MkITTBadFFd1S2eET8NR3gC
         IgAAUIKbmXffjgRylzGjH/TrEuGJvHxrwHxpBAKkpvAIU9GAYg5y6wNRuIyyKhq33Dia
         w+MRLGSUxBFgBsGbu4ZTYE6U0pvqd4+kERAwW5q5aT9RO6Y8i9XMEQXtSNrLiTGyOWou
         657e8OCd5gX73z+PO8HoD+bo7W1KEKaySvYNKx/jNLSsyavZBurup3KcF9ImzUOwrp3T
         TvTw==
X-Gm-Message-State: AOJu0YymL33+8e8G43HET1fgCKkYT3BBTKLkF+whXK4wAPcGmKRWKmtz
	72i3m7f6bpuLG93vHnEp+XWJW4BWpOvuE7TNpHEGpe7a9QwwdAciElAzFA==
X-Google-Smtp-Source: AGHT+IFwoh2KzUNksWUck71PSUgKAi4UDWRg8KtiMFY0z+OkSQEBrjwb8thzLi0O7U5sVuIA09hYLwFoTzRCKXY3iVE=
X-Received: by 2002:a17:90b:2315:b0:283:9d45:a815 with SMTP id
 mt21-20020a17090b231500b002839d45a815mr11733824pjb.3.1701092348705; Mon, 27
 Nov 2023 05:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGE_+C4mUw8U6YK0m6hRvcqriv4pWdsELpyRJBCY-LrdHjWwgw@mail.gmail.com>
 <20231115232824.2507648-1-jonathantanmy@google.com>
In-Reply-To: <20231115232824.2507648-1-jonathantanmy@google.com>
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
Date: Mon, 27 Nov 2023 14:39:00 +0100
Message-ID: <CAGE_+C4B=zjPqNV+fGt9gaA0O8qmqmK3CDh-eLBPmXx+ChzXAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Avoid hang if curl needs eof twice + minor related improvements
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> I've already reviewed 1/5 so I'll summarize what I think of the rest.
Thank you for your time looking at everything, Jonathan.

I'm sorry for the delay in my reply, I was away for a while and also trying
to get clarity from the cURL side, summarized in [1].

[1] https://lore.kernel.org/git/CAGE_+C5u9H8m5faK1vXKk6QTyjcHgKHqxOZy5ptzsYbF_0yrCQ@mail.gmail.com/

Most importantly, the bug has been apparently in libcurl only for ~1 year and
it can no longer manifest for a few months. Therefore, the main point of my
changes is a bit moot and we might reconsider what is useful and what is not.

> I'm a bit reluctant to include 2/5 and 4/5.
> I think 3/5 [...], part of 4/5 [...] and 5/5 have significant benefit and
> should be included, though.
Fair enough. I will update everything based on your and other's comments and
my new learnings, then the final decision can be made about each part.
