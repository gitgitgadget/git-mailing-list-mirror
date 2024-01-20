Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE8125D5
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705782499; cv=none; b=Jhl2Ky1mz2sHStIIxVc8f7QC4YVxjdl2zul62tXLcIq5hcyED+nS9xiL75T5gbK36sn4gqS/eyp36C52dYTp5tjHxMt+FiM+h+kwhryKUxuFfV89JZvIqZGvJeN1L0juOACqduicAK5XvsQTZptxfvlHTyIsOrpRvwtR9bahg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705782499; c=relaxed/simple;
	bh=RMJqKnahaRC3tNgs1k8OoVgM2nNUFKgeohZuUl4Wh9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ugytEH5gXy0xizt/1zBR+d+etPbop6SJXvg6e3fyPlGKfm4UFOjD4kXpQDhWsAjX8QSAV2Zm6gMmIz8UlHg1HSsEdYbZmQhTqZYyhGmJhS53+sI0qh22nEEiQ2l36Hjxt0iroDRh6ync7tc2SrLww7fOAvq5cWb5ygZbbFs+WR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/oy1nby; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/oy1nby"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc2629d180fso2835962276.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705782497; x=1706387297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eTnGpkhPq1qNieeYZAm10bkMRSwo6gggIX6mDfQQUs=;
        b=w/oy1nbyHLDt3qC0jegmxh5DnJvwWqq0Jx0FU14oWU28LqCJY5ntMjKVCeei+Fh29G
         uU1OnMsRN2Cec0sZE93qUbRoRWJxav+06kz38/L1XBcrJZLGFMngg96ys6bpuVOTp+Hm
         UTMbTGCCFxJ2ybwvoYlpYR2cfbBi49LVO9HE681urpKCbJ11+iGPpj7M+yefZSelQwbt
         BBMuAKUtmMWl6/zNzQnzrmSKayhl1d2jL3SkDL75rukD+3gIEs2ZSDh0vl3cA0+CkfvB
         p84GSHy8Ytv1evKXNpZyKQK82Icp+Mxbh9IDg/A89PFqY0kMW70m8iQhItafH7kOCOm9
         XgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705782497; x=1706387297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eTnGpkhPq1qNieeYZAm10bkMRSwo6gggIX6mDfQQUs=;
        b=xDdNM9hYawYlwLGZrh2q7FgHNxo851Mhz+XFya+Px4TmhBWeBvHg4T56qJ+mSJiZKg
         pmD9QyDXEIFiinLT7N2ZqKkws5dEOJxVLfomV7+eYj5m+JGikUbuR64Lx2ff3WfSPIvR
         Srbpi92TclgEwE/GI4225CUw+gSCsewagVVik3jZe0RvZTmniJxCLBNT3ioX2HgjArxQ
         1FGYA4LAuTQno8FTdDJ11T3HwSCpHOd1JxXe1JND70Q+VcjpDBsDCqbOGd6L/9KiAH+e
         Hdhk36tRDQzQsP19AZfzv+nIM3EHql0Z07XwLc3s0o4D2Y8on7L49GSd44qD/pjJJlys
         kxQA==
X-Gm-Message-State: AOJu0YwNWm0PjtCiLRk0T8fBY0hqA1oKmz/uJUAp54dh+H1QcICJ3/r2
	rstpm/XF2uSZGIEPm138ba04Z4O50z7dvwq3THQO2LojnMoOhj2c0xNGGD7p4oykxy14z4wSdOi
	Jpw==
X-Google-Smtp-Source: AGHT+IGosybMWF/2paCiElmIgGLWIBBzZC9hMqE5Ip67oxfNL1xOpRkj0tBhsARfdGRsTkS5EN1e7T4RPQY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:df15:0:b0:dc2:2767:f1b7 with SMTP id
 w21-20020a25df15000000b00dc22767f1b7mr965214ybg.7.1705782497226; Sat, 20 Jan
 2024 12:28:17 -0800 (PST)
Date: Sat, 20 Jan 2024 12:28:15 -0800
In-Reply-To: <f3fef46c058968f6d0ad5a48776bd2f59ab45868.1705411391.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <f3fef46c058968f6d0ad5a48776bd2f59ab45868.1705411391.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owlya5ozhhr4.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 1/6] transport-helper: no connection restriction in connect_helper
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

> Remove the restriction in the "connect_helper()" function and give the
> function "process_connect_service()" the opportunity to establish a
> connection using ".connect" or ".stateless_connect" for protocol v2. So
> we can connect with a stateless-rpc and do something useful. E.g., in a
> later commit, implements remote archive for a repository over HTTP
> protocol.

Nit: Perhaps add something like the following for the commit message?

    Removing the restriction does not change behavior, because
    process_connect_service() will return 0 if both data->connect and
    data->stateless_connect are false, and we'll still die() early.

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Linus Arver <linusa@google.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  transport-helper.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 49811ef176..2e127d24a5 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -662,8 +662,6 @@ static int connect_helper(struct transport *transport, const char *name,
>  
>  	/* Get_helper so connect is inited. */
>  	get_helper(transport);
> -	if (!data->connect)
> -		die(_("operation not supported by protocol"));
>  
>  	if (!process_connect_service(transport, name, exec))
>  		die(_("can't connect to subservice %s"), name);
> -- 
> 2.43.0
