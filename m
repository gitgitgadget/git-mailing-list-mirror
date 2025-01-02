Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E401AE876
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832628; cv=none; b=Ed4qFXJw4Ld3mkBUfFN2XnmZVja78ARNzFr0pJMt3LfyyTP62/MEpWLk4C36ZQQQWv5oSU0tnck9UBDgHODgiDKU2OK/5w7R7hTR8pgx6nHKLoM7Olrmt91Rn+MO6NlCnirELzoEfzEzCOV1mKqbnuendiwHjJZ381JhBe31TZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832628; c=relaxed/simple;
	bh=nrj+r4sRW2gt9fbdKC+QSgHJGknKfTl8NRmITRHxQIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7ngwNg+feohQZesAP326Uf6MTLI3pCpwdylQHn9mqvg5Rq3xGOiNf0KogbzFdwOhlWGqwjqQk8AG6pLR/tXu/SaSmjxpYoGKD2+kVuvc8nFccI7v99LIOovSykzDu4787fM3fo6RcQ/BJoSPu6qqhIx8k5PQ8tgv8XfeyrvwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGs5rATh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGs5rATh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21670dce0a7so73557095ad.1
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 07:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735832626; x=1736437426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOSqflLY0T7H+9JDKHDJV3UG+yy7W4EYzo7bOp9WsJE=;
        b=WGs5rATh8ONINsBsoBY0sj20RFCYCq7y5aWhU4PDJtwpUZN6lKKCTCqO0Q+B/++hly
         L0UJaZCFuVqGJnULD621nwmhTJAxhvOmv/XwBb7/dpIq0hxT+Yfh2oYtUBSCTd8cWsCu
         JmjHWZzG4TL98BwlVJK0qUzxqQIo/yC31Tq51q4jQ88LaPuHedHxEx/ulM5clnIfOHBP
         2y8W4cf3zqm6q4DjjqzMiMRsW7bfTNpwPDrRo9395t8rTzqYpXr91amzcfGWa5lJ7Xiy
         zvIJChDj0FpZ5PSvQOfPBPp7H5QcueCTCgOVupn5ckz9ydk/2NSQSKx+YIMCXN/D0imr
         3x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735832626; x=1736437426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOSqflLY0T7H+9JDKHDJV3UG+yy7W4EYzo7bOp9WsJE=;
        b=RqkxMMreWXeZamsaHyH4Jdmf+Rz0foKcD354Nch2YKWP8SYmMHUopZG6KuqffUX4ed
         OoAKyohEqt10zAzTfmkz/Xb1agb4RMKl7I8o7RrSWBoy3ESKcbD2C88eJcr44XfVIXLw
         6OrftxOb/51Ul/4pRcnSvDzeqWNBxPRROsgX4Rd++naxyC3Gk1T1/xe3mOGEpxyPrJfr
         F5MKWAmZW+9fvGOUtiPzMaGBjaiVx6W1F/sKxM5S9XnpxmFIveBO2ayi3Iv+3xSDtPvC
         S1lhSOyKmqX4aMDX29Cfw84wCdjKKdYNxJ9/RZX7M5lIS2X5fqs/rgLsGj4WVhsn7HK/
         oxWQ==
X-Gm-Message-State: AOJu0YzgXuBiRpXC8W0FjWUTbeBSa+AC7bSrY4RuIp2x71QAzNyL8jv0
	MbJ9lC13EbwGikKW8ryjDtHlS8pD5pM/27PvUHclwLuQZpt9u+lco5HDOUwz
X-Gm-Gg: ASbGncvCsgYAT2WRL2HffAfdVZmdiJgVcoVz16HF2KVXn+SAnAi1/YS9+KIn46QA3kR
	+1WdKkbHgtDZ4+kto3ssQ7rwbWvTmJfeogNKkGg2zBZOKR+a0Scv8a8V/+6utBH68hEwZsJZXPJ
	rmhnjQKH7fqzA3OdTEt/lrM0z28JuVMTxYfR9BgcZV6GXvclk7Vfo41rHPeKDOLpRIFDXnGXYvq
	rub4UlnUCTw2lFcXJBB4WEIumiFy+OVqeLMj7QrZG+daappbVDDFq+LE69bM/4pId8vBYjcZiUH
	Zcupcbp17FduDDlx4Q==
X-Google-Smtp-Source: AGHT+IFMWl8Vv5GLCzz7f+z0HFwwBTGoKAiuLu3lyQb30Yw4mqWn8dLD1UlGXI/NJF9k9XhvB2QU9Q==
X-Received: by 2002:a05:6a20:841a:b0:1db:eead:c588 with SMTP id adf61e73a8af0-1e5e080dc85mr74368788637.29.1735832626190;
        Thu, 02 Jan 2025 07:43:46 -0800 (PST)
Received: from google.com (56.166.125.34.bc.googleusercontent.com. [34.125.166.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72e61sm22573961a12.3.2025.01.02.07.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:43:45 -0800 (PST)
Date: Thu, 2 Jan 2025 16:43:43 +0100
From: Jonathan Nieder <jrnieder@gmail.com>
To: AreaZR via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, AreaZR <gfunni234@gmail.com>,
	Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: use U to denote unsigned to prevent UB
Message-ID: <Z3a0LzChuIzmr7jw@google.com>
References: <pull.1849.git.git.1734488549111.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1849.git.git.1734488549111.gitgitgadget@gmail.com>

Hi,

Seija Kijin wrote:

> 1 << can be UB if 1 ends up overflowing and
> being assigned to an unsigned int or long.
>
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>  builtin/checkout.c     |  2 +-
>  builtin/merge-tree.c   |  4 ++--
>  builtin/receive-pack.c |  2 +-
>  color.c                |  4 ++--
>  delta-islands.c        |  2 +-
>  diff-delta.c           |  2 +-
>  diff.c                 |  2 +-
>  help.c                 |  2 +-
>  imap-send.c            |  2 +-
>  merge-ort.c            | 18 +++++++++---------
>  xdiff/xhistogram.c     |  2 +-
>  xdiff/xprepare.c       |  4 ++--
>  12 files changed, 23 insertions(+), 23 deletions(-)

That said, most of these don't overflow, so it's not obvious this
results in higher quality or more readable code than before the patch.

By "not obvious" I don't mean that it _doesn't_, by the way, but just
that we don't have enough information to evaluate it here.  What
motivated writing this patch?  Is there a style guideline about it
that will remind us not to backslide in the future, for example?  Or
is there a tool that notices?  Was there an example you ran into that
led you to look for more examples?

This kind of information about context will make it easier for other
in the project to ensure the patch does what it intends, and even more
importantly, to see if there are additional checks to add or other
instances that also need updating.

Thanks and hope that helps,
Jonathan
