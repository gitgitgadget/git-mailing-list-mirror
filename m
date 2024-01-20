Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194712B75
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705782630; cv=none; b=vAMKeMvnNiqeu9GqsTwoz1VXos7uSj+7IOelsYwBDlrCTn1i2sVKd6NmrdqQRUyFlm1d+kC7zDO0ljFNI/vMW1WxmSs0RXIezrq7DIIzdWrVkArvBYeeliUpss+uOq26wONinOXe41TU6jk9KaYrZYrXOxj+5GEHS1FakqYvDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705782630; c=relaxed/simple;
	bh=3N9wZkmLode00M0QDDSmb+6xroX5/QjfP0hXOFSC4jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OCgNvNu/PXX6F9FXj005XQBG94YXrxuw+mJnY3iu3xCWIc4Qf+zlNFbXwlcZicEBb0HbL1pyXKEDtXy11yXagZtV1yVxcqJ0G5YPFoqI5THXzCEQiA5I65NP5trH6CScNsViLp/4xwsugpne5VUkzfpIDJxBHmEcEPNFO72LEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+NK3FJr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+NK3FJr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6dbd56b52d7so131753b3a.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705782628; x=1706387428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sX6jsp5O4j3bGUz2u2fkdFensICVylg5ORuskXZtPeU=;
        b=U+NK3FJro1Q01pDK7AC9c8+Jgcxp8VF3Up0wf0C1Lz5kJm2AuW6PldaGFmasuxHEqd
         nsfc3lnCFpBI6Mr7XQ6nVCTc1YA64bJ2UpyFJQ9yq3MOD6ZrI9TQxPMxG/+SpEF6C860
         2JZhszf28suqJnevAulGwmCm2L3saUIl//U2kDqHT9FCHBLjcewdUkGMV706NLYml8CO
         1JN9oF2nNumLbwBr7OCJZ7210gstSzJQBhT8glUEohYnNtZ+Z/1Q18IaC5T5I2DTM1Hl
         Bh6Acg81mOHQv80pDL0Dfwph2sZCF7BbPOkt7Rix+fStVafFcAe9/P9S3zXIsjUoTv9c
         qtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705782628; x=1706387428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX6jsp5O4j3bGUz2u2fkdFensICVylg5ORuskXZtPeU=;
        b=OGV/9bJcpHkPKDA9ZlP4EkXRdtNR7wDNkUCj4+puz1ox200potrr7o62oz8O3RcT8m
         HSAPxIRh4+DnMlV4g0gnkz5kMquGnU11bwjjQNVk51GhisxdodpI6uYdX2XRi6M+Uo1I
         QsdYDXJgGVthO+jgEb5pvg/kS1UDM1yGGfmGYAwOszkrh1dNZiit/6w1xUD83fvzh+8f
         i7sY9hGwUZXSWSFsPWQSFg6KVO5QrO8A2kAWJ/L4MgnbEazJJnwY+G2tQzPlP0T+NVbL
         oxN2cpfEbcA5mcoFoTP7vn+HbZLh6A+n6GLDNFpE1VtV6bM2mCAxWWtJHScY0jO+4fXb
         IFtQ==
X-Gm-Message-State: AOJu0YxEB6e1ry0JbFVIcL68dVpQcsGAiKafD7t3fIyK9bu3Hij4MEQG
	5oOKdrOE6FsIaWthoxRWtcM2wiD5DqfyzGvGCeDgjMOq3zbc/4HKbLy1h7lML2pSEjvg5qgGLFh
	E8w==
X-Google-Smtp-Source: AGHT+IH6rsYD62KU2ROB/E4I0SSg7J83n+seJDjeSGJfH7qZUo93ABMrZ5ccTbAjWGHZVkz2MCIWkLilNpg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:ec8c:b0:1d7:2286:e09 with SMTP id
 x12-20020a170902ec8c00b001d722860e09mr10970plg.3.1705782628197; Sat, 20 Jan
 2024 12:30:28 -0800 (PST)
Date: Sat, 20 Jan 2024 12:30:26 -0800
In-Reply-To: <6be331b22d51e1f6f96cb0035d99db5b8cede676.1705411391.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <6be331b22d51e1f6f96cb0035d99db5b8cede676.1705411391.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owly7ck3hhnh.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 2/6] remote-curl: supports git-upload-archive service
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Add new service (git-upload-archive) support in remote-curl, so we can
> support remote archive over HTTP/HTTPS protocols. Differences between
> git-upload-archive and other serices:

s/serices/services

>  1. The git-archive command does not expect to see protocol version and
>     capabilities when connecting to remote-helper, so do not send them
>     in remote-curl for the git-upload-archive service.
>
>  2. We need to detect protocol version by calling discover_refs(),

s/,/.

>     Fallback to use the git-upload-pack service (which, like
>     git-upload-archive, is a read-only operation) to discover protocol
>     version.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  remote-curl.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index ef05752ca5..ce6cb8ac05 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1447,8 +1447,14 @@ static int stateless_connect(const char *service_name)
>  	 * establish a stateless connection, otherwise we need to tell the
>  	 * client to fallback to using other transport helper functions to
>  	 * complete their request.
> +	 *
> +	 * The "git-upload-archive" service is a read-only operation. Fallback
> +	 * to use "git-upload-pack" service to discover protocol version.
>  	 */
> -	discover = discover_refs(service_name, 0);
> +	if (!strcmp(service_name, "git-upload-archive"))
> +		discover = discover_refs("git-upload-pack", 0);
> +	else
> +		discover = discover_refs(service_name, 0);
>  	if (discover->version != protocol_v2) {
>  		printf("fallback\n");
>  		fflush(stdout);
> @@ -1486,9 +1492,11 @@ static int stateless_connect(const char *service_name)
>  
>  	/*
>  	 * Dump the capability listing that we got from the server earlier
> -	 * during the info/refs request.
> +	 * during the info/refs request. This does not work with the
> +	 * "git-upload-archive" service.
>  	 */
> -	write_or_die(rpc.in, discover->buf, discover->len);
> +	if (strcmp(service_name, "git-upload-archive"))
> +		write_or_die(rpc.in, discover->buf, discover->len);
>  
>  	/* Until we see EOF keep sending POSTs */
>  	while (1) {
> -- 
> 2.43.0
