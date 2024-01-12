Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA65C8E1
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7rDXHU7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eb6dba1796so117072117b3.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705045364; x=1705650164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv2ABJ0Zh91vB3qdzT7ckoU8qa53NSpYNOKXetvaHIs=;
        b=K7rDXHU7G1OtQnyCuW4z+m67zfHMBkAz3IwO27gIpj4Ls5Ei7zZlitpbyTo6G91H7U
         xOBhjWZ3FWJvwzX9bysT0fEDqOg+/dO+oiDik4ViaZP/VINS5bwWVLrfCunQNzxkCMpE
         4GgY8JdLVDgjxnMiG3eP3bgMVGvBuDOmMdBn7YOjqDk8vqOz/WD85Qd111sa7+8fy4NL
         XRSv24h6YlLaeZom26Pstp7devPQXsGigds0VRTi5nzbEX4gkJL/4BXh3Liz2eDHXLt9
         7k3FGYWX6FzEjAQqqqtAgo9RcDpqc2uV7R/1C1nx9YJSWubJb7m7sdLV6zgO+DiOxbtt
         AZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705045364; x=1705650164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv2ABJ0Zh91vB3qdzT7ckoU8qa53NSpYNOKXetvaHIs=;
        b=GvUWqwma5u7pjNzgD2t/myRzcjub4FYCSL3ooxjhpYMyhxQRM/2iKkT3fN+HQH3xVz
         swnZemjRYBY4HrHY03yMES6bbtOmGzc5Qu1sg++ZcNc6b8TSwI4Pd5A8VMfIftM3OKY5
         lNfViWtU9hJ+ZhESZ3RpPGIeGWaAKVss/aFt4wUfIf+K4xguDuaDblnEOZNjsBPeHrQ8
         Cvtp0QD5CsocJqfdPx+TMb2nRm2KcO82FwR/EnktAh98Ykb8kKFc2voHcDfYEFgFIMx1
         9gOBrp3L5megzwcUQFoCVOsI9/cguAzZ7XRagnspvGKewQt5sEAluwmXMYWllKdNgyPR
         BDMQ==
X-Gm-Message-State: AOJu0YzzV7A+S4IRUA0gd6u4bmH8PQXejzXuCTfXCi3JD+YBFNHM/1bt
	kX0XXpsyFcfkdwF904cTwpeVGFrgKdHjWQeQDg==
X-Google-Smtp-Source: AGHT+IE18r8+KpRpeFjGsAOqf+XRHrbrBUSP4+4MItGXPgzwoDOhHF3th59kHCe7KOsWXEGpST6UJTFwnuI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:8a43:0:b0:5fb:7b86:db36 with SMTP id
 a64-20020a818a43000000b005fb7b86db36mr541738ywg.4.1705045364561; Thu, 11 Jan
 2024 23:42:44 -0800 (PST)
Date: Thu, 11 Jan 2024 23:42:42 -0800
In-Reply-To: <d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owlyy1cvhua5.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 1/4] transport-helper: no connection restriction in connect_helper
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When commit b236752a (Support remote archive from all smart transports,
> 2009-12-09) added "remote archive" support for "smart transports", it
> was for transport that supports the ".connect" method. The
> "connect_helper()" function protected itself from getting called for a
> transport without the method before calling process_connect_service(),

OK.

> which did not work with such a transport.

How about 'which only worked with the ".connect" method.' ?

>
> Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
> 2018-03-15) added a way for a transport without the ".connect" method
> to establish a "stateless" connection in protocol-v2, which

s/which/where

> process_connect_service() was taught to handle the "stateless"
> connection,

I think using 'the ".stateless_connect" method' is more consistent with
the rest of this text.

> making the old safety valve in its caller that insisted
> that ".connect" method must be defined too strict, and forgot to loosen
> it.

I think just "...making the old protection too strict. But edc9caf7
forgot to adjust this protection accordingly." is simpler to read.

> Remove the restriction in the "connect_helper()" function and give the
> function "process_connect_service()" the opportunity to establish a
> connection using ".connect" or ".stateless_connect" for protocol v2. So
> we can connect with a stateless-rpc and do something useful. E.g., in a
> later commit, implements remote archive for a repository over HTTP
> protocol.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
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

Should we still terminate early here if both data->connect and
data->stateless_connect are not truthy? It would save a few CPU cycles,
but even better, remain true to the the original intent of the code.
Maybe there was a really good reason to terminate early here that we're
not aware of?

But also, what about the case where both are enabled? Should we print an
error message? (Maybe this concern is outside the scope of this series?)

>  	if (!process_connect_service(transport, name, exec))
>  		die(_("can't connect to subservice %s"), name);
> -- 
> 2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev
