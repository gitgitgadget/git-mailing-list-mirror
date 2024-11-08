Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6C23AD
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031866; cv=none; b=LhroskvzF0/KNWpZYfPjCnZ3qDm1G/uZ1OHgbEmwFJ5d25lZ5us1+2uY6xGimQqeT7ItAESZocdBACr3ACwscIpEmYMrDtKvPkzDAjURVAEW7ekhlQYLIVAdPhvtyv/1ZRoDr2hHkVTxwDem6DTAO+ssLXX6Oyh+Y6/mt9AQbQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031866; c=relaxed/simple;
	bh=SXmp1Cb25AUtk+udH2QQA6YDl6o1aUhrPLnkDbxrMro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McXrS5mmlclkT8YW2C9rRQX9UXerUPtyV6rWVeZvGK/0l7nYf+DSSSpPsZs7HNEjmMD9GcRNmSVEm1VALdFQkutdCSVHKYOTVTC/T6yIq6aWGuytxQT3cUblAWjqEw+RKak4DsbGZUWdwHgR4vs2M0UJzylBCqWhnewfsxZ64Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmLw4l29; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmLw4l29"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5f86e59f1so1032227b6e.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 18:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731031864; x=1731636664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob3FAyVMlfEJg5TFasMy6rCOA5rwyla7NWnWldInQgk=;
        b=bmLw4l29hHWliHzyDdBllQNYoqcCHmi+bysKdvGFLCzFLOtDA7OyGf7EtDdbTD4X09
         Rk/a3LmlSd8ammIDHq23zlaOQ0y/ygYZ5J9fliyVQxhisvoPw9gFBiCCvA3MqliFyDJy
         zHfw5Zdhx02pFknYBA1iWRVxSpJPwr/M5uXMyi9+PwKJeHtSip+aIm7q8hNezcgZVfHD
         XkSge4QoiW8wFOS1GhrX8ozFR2RHFNDrwi+5QV5zLM5ThcaDYGvkPD6tqyAIcyquNIdv
         zGbX/nmpw8o9f43HI3tYXU5l/JGCG+pyQH4yX8khzV/hoMHmywWwzz4RbegY4GNvlMjN
         dr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731031864; x=1731636664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob3FAyVMlfEJg5TFasMy6rCOA5rwyla7NWnWldInQgk=;
        b=dD0+juOXmUPKr8/oEJXmufZNKjVaGzvhP6/xWvSvyPYnyp9OlrOZKb5gSytZpEF+TW
         PRh06KTGG6hm1IMPF5e5Yc8wTTbjudxX+VpQzKv3TOA8RXPrVTlkzq2guNKQgUs0EPC1
         7S3qjjYtc2YtKIFpGTfq2eeguzqCCbg7EOcf8L/9f6vDfjj+JohQtS5Jtoq6FRQkE7rk
         BjnQ7dmTvLGsJeiYpnLe+LL0gVw4dpA4itc0I1bGUc1Fh0RgXNk8YSchnBr2MKzOUR8B
         FMCUqbtwnOWXRsORm2LKEkOXhyVyeNeeDTk6F/vsZUXGOstxaYuDMOEhm0QSrhazx9Jb
         S7Ng==
X-Gm-Message-State: AOJu0YxZneEcMP3588ZIeGGGUVjY40YBSSldPrky+Shq3YV6oa0sFkql
	hLOC217OSsniXCBvEfIRVKEm8Fy6Amb07mXxsQrgcT2HDvaDn5ao
X-Google-Smtp-Source: AGHT+IFUD6pwe+GIcnojbk3qd7eLF5YhG8jPZDlEZUruJ/91W356Q+OqYWCvzVFJNDd/32jrXMiTAA==
X-Received: by 2002:a05:6808:1825:b0:3e6:63bb:ed4e with SMTP id 5614622812f47-3e7946c80b4mr1578050b6e.27.1731031864294;
        Thu, 07 Nov 2024 18:11:04 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cc67256sm566846b6e.5.2024.11.07.18.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:11:03 -0800 (PST)
Date: Thu, 7 Nov 2024 20:09:21 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 4/7] reftable/stack: stop using `fsync_component()`
 directly
Message-ID: <6ghxx5fmuzujegducuva77vpybihz6b5cnk75wdgv4pv2knac5@m3trfmg2dk5s>
References: <cover.1729677003.git.ps@pks.im>
 <86269fc4fcad9a97709aa0d080c4c077a85ca667.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86269fc4fcad9a97709aa0d080c4c077a85ca667.1729677003.git.ps@pks.im>

On 24/10/23 11:56AM, Patrick Steinhardt wrote:
[snip]
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 9ae716ff375..df4f3237007 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -8,7 +8,6 @@ license that can be found in the LICENSE file or at
>  
>  #include "stack.h"
>  
> -#include "../write-or-die.h"
>  #include "system.h"
>  #include "constants.h"
>  #include "merged.h"
> @@ -43,17 +42,28 @@ static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
>  	return 0;
>  }
>  
> -static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
> +static int stack_fsync(struct reftable_stack *st, int fd)
>  {
> -	int *fdp = (int *)arg;
> -	return write_in_full(*fdp, data, sz);
> +	if (st->opts.fsync)
> +		return st->opts.fsync(fd);
> +	return fsync(fd);
>  }
>  
> -static int reftable_fd_flush(void *arg)
> +struct fd_writer {
> +	struct reftable_stack *stack;

Out of curiousity, from the stack I think we only need the callback in
the options. Any reason we provide the whole stack here?

> +	int fd;
> +};
> +
> +static ssize_t fd_writer_write(void *arg, const void *data, size_t sz)
>  {
> -	int *fdp = (int *)arg;
> +	struct fd_writer *writer = arg;
> +	return write_in_full(writer->fd, data, sz);
> +}
>  
> -	return fsync_component(FSYNC_COMPONENT_REFERENCE, *fdp);

Previously when the writer was flushed it would invoke
`fsync_component()`. Now that a callback can be configured in the stack
options, the callback needs to also be propagated to
`fd_writer_write()` in addition to the file descriptor being synced.
This explains why `fd_writer` is now used.

The rest of the patch updates writer configuration and fsync call sites.
Looks good.

-Justin
