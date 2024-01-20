Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8499EEC6
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705783083; cv=none; b=MfMy7Rr/cKr0mb0sdpPqXCtgRqsUItxYoHDfi0ueQLxhvLayQ62+jnEhtIlQEZXNq+j4OGVYIGtrUGrHDf/Q/CgDum5jT8CcbEEKJsa5qjqEJcbLJozHOhGVvMQ+59Q/SP4FAjiQRbQOIW7YFrKGZDaUTb4JI+XWjkQpn+9ob5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705783083; c=relaxed/simple;
	bh=KWaK1U0/WXfo6jspjBC9QLCVS/qb+rsxwXEmYB47XLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBs0XFIprlHZgLRF/NLHo4qt7AL22nrtQoBET5OY2L4RDwJovEUcWA4ox96PjQieeYzR4ZDb6mPayHiui0XpdxyTfSASw79hIB0VNzHm7rTpTu7mH9ldVgAfe9TpJ/GmuhzYHmLCyxhp5rXv43Iu1U9soLMwdK4cfSEaz6Q0ScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRiBTvya; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRiBTvya"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5ce97b87716so1094036a12.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705783081; x=1706387881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yY1lat8UY0pRhhKMENC7SOEAE0lN8ySstpM/JcQJIo=;
        b=kRiBTvyaPxcfkROBFiLoFqODZEWZsUiK1hLw2WxjMaXdVYONzgD5KYpFrqGXZiB0Hn
         kuJ5Cyyld/+ftMeWqWn2YWzkZGhXTwOkD3ifQbSmw740awQXHAwlbcnSwncDVSLEdNF9
         +4yz+Zumuvm2mLo9EKbB/ghxo8Eyg5u4xsK43WesNuFordD+/B0zR6H6nvBmSCl5UypG
         noP3dmZ0sacqnU6DV+VZ861IGHQNSz/uIYaPMpwr503gjT7mWFbw8xtpbkf7skx10X9p
         yfamABVB24R7lbnrXW3i2AW7eA6KLlFILt9A5LVmCyoz6NchLCxH/6h5OUjxk3nOPjMo
         l4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705783081; x=1706387881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yY1lat8UY0pRhhKMENC7SOEAE0lN8ySstpM/JcQJIo=;
        b=YZ4HDef16Sftc8NDrIkkQDy9OjvzQBFvck0F2BwW1SPwzV/QPAnoIg4/y8aMSSdKlo
         goC+o3H0tx6bm6RI0CZWC8hQkwn8AX7H5HsMpP51wwz1tFwSQ/NMnJS41jtC97sbmGOY
         6OLngpBL+2tfF9FMEtYUSR+0Te/Ny8kAN+oCItz9RqRClIfGzPpoYv5bBULrntCIous4
         iQ52RM41m55n5spwNNXzpg55paUeEkN7N4rYF10dHBoeQEgl4GRY/69iRryqq95MM1TF
         VHxpwQPzFWYVLYLn2z38pRtN35IKJoUoUsV7s776N3EciPMsueoUZ+4QRbFDjiSOvmwz
         eq2A==
X-Gm-Message-State: AOJu0Yz5SNFUbPa+Tvph12M2ZiecZ6MgOa1nDPqt3DsBG+PpMJa6sfyy
	AQKqpj54oyP87z3Qatw+BExx8+vXfSjLVJlRNggqKxQIo2H8MvEwSCgZPZKLgVuudUozXVTsVPG
	5kQ==
X-Google-Smtp-Source: AGHT+IH3HghArGZsoOKPkyCqpUkza6b6sZDC8svmws3UTnEUbcEW1/rZTOjRZkEmKbIe02uACvUtFwpIMGg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:9dc7:0:b0:5cd:8d75:e744 with SMTP id
 i190-20020a639dc7000000b005cd8d75e744mr11303pgd.8.1705783081120; Sat, 20 Jan
 2024 12:38:01 -0800 (PST)
Date: Sat, 20 Jan 2024 12:37:59 -0800
In-Reply-To: <6ac0c8e105febe526dc64182845832297656a8a5.1705411391.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <6ac0c8e105febe526dc64182845832297656a8a5.1705411391.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owly4jf7hhaw.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 5/6] transport-helper: call do_take_over() in connect_helper
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> After successfully connecting to the smart transport by calling
> process_connect_service() in connect_helper(), run do_take_over() to
> replace the old vtable with a new one which has methods ready for the
> smart transport connection. This will fix the exit code of git-archive

s/will fix/fixes

> in test case "archive remote http repository" of t5003.
>
> The connect_helper() function is used as the connect method of the
> vtable in "transport-helper.c", and it is called by transport_connect()
> in "transport.c" to setup a connection. The only place that we call
> transport_connect() so far is in "builtin/archive.c". Without running
> do_take_over(), it may fail to call transport_disconnect() in
> run_remote_archiver() of "builtin/archive.c". This is because for a
> stateless connection and a service like "git-upload-archive", the
> remote helper may receive a SIGPIPE signal and exit early.

OK.

> To have a
> graceful disconnect method by calling do_take_over() will solve this
> issue.

How about rewording to

    Call do_take_over() to have a graceful disconnect method, so that we
    still call transport_disconnect() even if the remote helper exits
    early.

to make "this issue" more explicit?

> Helped-by: Linus Arver <linusa@google.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t5003-archive-zip.sh | 2 +-
>  transport-helper.c     | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 6f85bd3463..961c6aac25 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -268,7 +268,7 @@ test_expect_success 'remote archive does not work with protocol v1' '
>  '
>  
>  test_expect_success 'archive remote http repository' '
> -	test_must_fail git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
> +	git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
>  		--output=remote-http.zip HEAD &&
>  	test_cmp_bin d.zip remote-http.zip
>  '
> diff --git a/transport-helper.c b/transport-helper.c
> index 6fe9f4f208..91381be622 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -669,6 +669,8 @@ static int connect_helper(struct transport *transport, const char *name,
>  
>  	fd[0] = data->helper->out;
>  	fd[1] = data->helper->in;
> +
> +	do_take_over(transport);
>  	return 0;
>  }
>  
> -- 
> 2.43.0
