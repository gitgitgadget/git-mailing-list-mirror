Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A015687D
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974444; cv=none; b=OaTvOftfbhKY3xCx/0URaTBFxu3cVg2CRpUDiX8sQrtdLSZmLk8TaScjXcK6RfBcokEXIi1UxlI7D+YViu/t+pY5R8hnBDGYg/NcYm0+kvRKEhu1AcUwntSWia8ecHvM5ryLlUcgmfB1tW6DCvQ5uacuhjznK12dZB1fVtq0Ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974444; c=relaxed/simple;
	bh=vDbLflxJw1kQYTs0NTjcdRyfS/+HxK7xMRzQIy19Zwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h02RQ9drh/KsenV8z3G+KSytQ+K6xmmyiC9U+HpFbRL10r4Z1hdbEAEhabj/5xmyjYuYZno6G3JZ+ttekGS5PaSCBTY0+K2Kp3IPB9KhWRsWnHeuiBqUhMrGV+rI2l1s0joi/EKpE5qpL2LrjfeZ5sEdIADKXSrt9JNKBVOgjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhSQQaJg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhSQQaJg"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so1334666e87.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767974441; x=1768579241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+kD4GS6tj6ItOwB7VUiCyUloWswRxoC+k1ymYaKOXs=;
        b=mhSQQaJgsoPclGCvHCgSLrm15U8VWHgATlh0LAHdKHSNiHwws2TuZ9wsDVxn4ffVze
         wqbPHgbon+e6xGolxq5KsO04TSjCVP2I+F7ZrbS9LG1XABSMqwOel23oalrWgkk91zB8
         Z9on9e6ErYrOA2aOQvOKUAcbPmWBiRjBEKQ9wVh8FdE6hBceLoScn704P67IMaPwfb33
         XKGiEmL1AroqHvtCJtK0FvUtQxv70oAtMJRoGf4U4HhmIAT2Z44AJZkWuMPSXjmubXnd
         Ly2tMtdRmSHXegqheuZAFOHs47dGBN+rfiIg8L/1tLg+Fq62+Fvg/8RWkgN0y/nrAu5f
         xRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767974441; x=1768579241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+kD4GS6tj6ItOwB7VUiCyUloWswRxoC+k1ymYaKOXs=;
        b=ZkF3s8H41y/dqqROZ8AyBt2U8ZtZQH40DjkRQ9GbVAmWBlEkpUAxme650Drzs7z0Jj
         DFuAmwjS0L2KfPDuzz5m18mJp7qebBOinFOmtdtDalChRjxamHN1zwShF5XQK4TXaTtv
         mvKs+3hTurbHXgLRkDjqm8IzyKkXUtxDzMiCKKWWVqY8+H/4v3tse/Amv8fpoRec6uyD
         vBFpK0wMtdbcyn8qKXu1fJX+oCDv7Kj1sTfaPJPnoc+nR/dGh78Jsn0rRxJFS22XNQHO
         L24UlfkmyKfDC7k2PVyA1kpARiyW/icIbFZ6+W+dNCbQtIzsdv42rgaRRXimGaisuhR5
         8udA==
X-Gm-Message-State: AOJu0YyXRqC+vbQsNZbuZM2h3OsaLnuLTlcobTOVduRv4s6T9OmNNlq8
	gZ15dnJDnKyFAJ5+QMtgXgm1ACT6FmbiOXgscT9YrmsoBrMDxJ883Ekf
X-Gm-Gg: AY/fxX55FyWERUTgLmgsQtR9TNyjsDKD1YSb+ro8ENE5Kt+N3+VgIEX7HgYEDnGJhP2
	vagnz6VeT9G9261l7Yz5tfxNwb5oQ/mm9eHFxsZKlgA83iMYQ6olc/yXm97UYJMqo+jzSZoUxjD
	PDGqSZZ1b9s/g1YpsF7DTPn7JBqSFBx1IqbLzhY5p+4Ofb5kv+v3MKNp3ymXBBYuMwfWrwyefrk
	0SOc8rndoEjFwbS8OOkv7Z6xJNb5A/uqjwyvC8V1slTcBQdt5lkpjXeQH5HjmN9RD+ql+Hzkr1J
	YGR15O4PRR1sDz//TM3jVGVVN4zMiKqvUNlv+qd2JPZgfdKKI/RyVo2xttt7CO/mvVLIeT5XH7L
	rayoBnbpfJe78g5240jOMKVRiyzlG2nRfts1y9LvPYCwgF8y8LXWqBdcBX+K1LxaWzSxuCR7Gbi
	M8LGZtNhdjkNO0U3DF7UpiQt6G2mCNBAZiSTVrCnnxNFv9+nj8c2UR83MEwl0uNuk9a2BBrNk=
X-Google-Smtp-Source: AGHT+IG7tFtqhlTHcuIMb9O/EdwiowP80uXz5PYq6ijvHZrukUmVgz0LTV0o+8Irlgm+26/GNUiKDQ==
X-Received: by 2002:a05:6512:1106:b0:594:314d:ac53 with SMTP id 2adb3069b0e04-59b6ef15f6fmr3668810e87.23.1767974439189;
        Fri, 09 Jan 2026 08:00:39 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b7c2dd9e2sm847601e87.5.2026.01.09.08.00.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 08:00:38 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Fri,  9 Jan 2026 17:00:37 +0100
Message-Id: <20260109160037.2067-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <ba2b65a5-0e2c-41a5-a480-ec3f5ec2178a@gmail.com>
References: <ba2b65a5-0e2c-41a5-a480-ec3f5ec2178a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Using an enum for a set of flags is a bit confusing.

The point of the flag and the bitmasking is to selectively turn off the push
and pull advice advice from the relevant branch when the push branch
comparison is active.

In an earlier implementation the advice logic was moved to the caller
instead 'format_branch_comparison', but it's more faithful to the original
to have the advice logic inside 'format_branch_comparison'. Maybe I
misunderstood your comments around this?

Would happily take a suggestion on a nicer way to handle it.

> On reflection I wonder if we should be calling branch_get_push() instead 
> of remote_ref_for_branch() and tracking_for_push_dest() as it respects 
> 'push.default' and so the branch it returns is the one that "git push" 
> without any arguments would push to.

I'm not getting that to work without tests breaking.

> I think it would be simpler to just return the full refname and let the 
> caller shorten it.

We could to that but what's the benefit? Shouldn't a helper function reduce
the work for the caller, not the other way around? 🤗

> Why are we checking for BRANCH_MODE_PUSH here? Don't we want to show 
> this advice regardless of the mode?

Yeah, that's a good point. However, this will often lead to the advice
being shown twice, see this test:

```
status --no-ahead-behind shows diverged from origin/main and ahead of feature branch
```

> Having to test the flags each time is a bit cumbersome. We could define
> a couple of local variables to simplify this
> 
> 	bool want_push_advice = (advice_flags & BRANCH_MODE_PUSH) &&
> 				advice_enabled(ADVICE_STATUS_HINTS);
> 	bool want_pull_advice = advice_flags & BRANCH_MODE_PULL &&
> 				advice_enabled(ADVICE_STATUS_HINTS);
> 
> Then we can simplify the above to
> 
> 	if (want_push_advice)

Done, will be in the next batch!

> If we don't want to show this can't we set show_divergance_adivce to 
> false when we call this function - why is it guarded by BRANCH_MODE_PULL 
> as well?

This will already have been shown the the pull branch (the upstream
branch).

And in the cases when it's NOT shown for the pull branch but only the push
branch has diverged, then pulling won't solve the problem anyway. (Unless
you would try to pull from your push branch.)

> Here we set an enum to a value that is not a member of the enum.

I use bitmasking to enable both modes by default. But see my comments above
maybe there is a nicer way to handle all of this.

> This combined with checking "push_branch_modes & BRANCH_MODE_PUSH" below 
> ensures we skip the push branch if push_sti < 0. That's good but it is a 
> bit hard to follow.

Possibly this can be done in a nicer way too. But at least I try to
encapsulate the complexity to only here, to allow the rest of the code to
be more straightforward. A good trade-off I think.


Harald
