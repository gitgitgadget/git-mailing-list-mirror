Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E013FEA
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677864; cv=none; b=R9jHVUOw7I672Hpc0d734TuhAS4gJM0+a95M2IwHpzY1NL+RV5vqD1IiVML2g3DZDqjXiJLmoEWoLR8fW+km4p4etGXyyhCK1OoC1sRyaq/T0ap5riB8DkFue+JwQpsDqLy89kYebSrTaKCGrfRoeEapo4iUpv/fUxnr7yIWHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677864; c=relaxed/simple;
	bh=JNLyLXKDUY24654wf65HmSuxEIgljGasgFGuwBWnBYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNqwgN8m05IE6v+9E/jhCsPmOVV8S96zesZzlHWyegHfgEBIBY0FMwu3rsHmIuEf+oVdv5mJss6nrFQHTCOTRZIZwiTkG5eCYV3KR5J1M8cZgNm+d8EhGL7I8ac6L0xuKRvGU63/cTunSmGKBvAE15yy+hJatdJwB3mr5dEEOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxJNxkcJ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxJNxkcJ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e125818649so3300136a34.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 14:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709677862; x=1710282662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSSXbIYWLQ+r0NLYFzAMYPjPpbGhl7dgJGRrGiBllos=;
        b=lxJNxkcJsG7JFS1uwz0awB9AM+/GH92XlSSjZeagnkEiKQhru4RYW27PYSyEqphe03
         fxar0vsqlMiiZjxyoXTgap8dKlEuRJxBC4JWZZdoWeMCZbn7UQ4WjGOVZLJ71EHIpaeC
         yESb6QHEZaCeGAmt2K6gRDRXJ+D1L8/QTco5m0OYIor6MnrqyFcZxkMiWOicRxNUjBv+
         761B8Ihv1FYLi0Q86vvC3eUBMHgARD84vlgDeeQJqJsjC7lKr+B2A9SFw1dcOFtSO4QV
         ABTM1mrbc+1Ypse0UN4r/RxUkR1RRrQhLjJcY+bldIQQgSTVYw3zhD8c/Vy6Ck8XHGeI
         jY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709677862; x=1710282662;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSSXbIYWLQ+r0NLYFzAMYPjPpbGhl7dgJGRrGiBllos=;
        b=Msu4bLmq+BS1bbC0Fspz4emame0ivNIxcTFmnJZJlFvfW7xCrd0YeYyWoMgEznIWgr
         cAx9K2R2rhPgzO6REsfq2HwGGmM//OqNR5cIQf0jvfsawU2saO1NUJTkOZnHdzcgdVsk
         wsEl1dVXLYFyoO3TO6x6lkCui2rVrzFtuvw9jd/x6bjgL/Y3gr1QGCEBxMGlXQQAb+ci
         Ww26lt6sY8ICLLcpkmgKCv3T5aKiNQltUBS7u19lhWDGwU3zvL/XMIAb/X59wGAMzW97
         yxxWsal+HGGzcat7pngFq8Pbv0J6K6YjoVxe5bHo9LCGI4iMvfImOUCXqSpz5jBchyw0
         RHwA==
X-Gm-Message-State: AOJu0Yy0dfPh6n21g3lQ3pn+6jFsGKqv4qGGMY/wAKpAwSxJA6FaeJ3y
	BjzoXDMRK1P87Bs12V8dop60yUL5mLdx9dru0L7kxy46UKRSUNQOT2GMqsO8
X-Google-Smtp-Source: AGHT+IF5bwdbTt4ZoanSBWXyJtcS1PW9Wn1KwxHnA9pLYIq455No1z2IeGa0hNMKKREeYWdP9Zo9ig==
X-Received: by 2002:a05:6830:205a:b0:6e4:dd99:86b5 with SMTP id f26-20020a056830205a00b006e4dd9986b5mr3358305otp.27.1709677862030;
        Tue, 05 Mar 2024 14:31:02 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id z22-20020a056830129600b006e4e4360035sm818435otp.32.2024.03.05.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 14:31:01 -0800 (PST)
Date: Tue, 5 Mar 2024 16:30:18 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
Message-ID: <6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709549619.git.ps@pks.im>
 <02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>

On 24/03/04 12:10PM, Patrick Steinhardt wrote:
> We do not register new tables which we're about to add to the stack with
> the tempfile API. Those tables will thus not be deleted in case Git gets
> killed.
> 
> Refactor the code to register tables as tempfiles.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index b64e55648a..81544fbfa0 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -737,8 +737,9 @@ int reftable_addition_add(struct reftable_addition *add,
>  	struct strbuf tab_file_name = STRBUF_INIT;
>  	struct strbuf next_name = STRBUF_INIT;
>  	struct reftable_writer *wr = NULL;
> +	struct tempfile *tab_file = NULL;
>  	int err = 0;
> -	int tab_fd = 0;
> +	int tab_fd;
>  
>  	strbuf_reset(&next_name);
>  	format_name(&next_name, add->next_update_index, add->next_update_index);
> @@ -746,17 +747,20 @@ int reftable_addition_add(struct reftable_addition *add,
>  	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
>  	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
>  
> -	tab_fd = mkstemp(temp_tab_file_name.buf);
> -	if (tab_fd < 0) {
> +	tab_file = mks_tempfile(temp_tab_file_name.buf);
> +	if (!tab_file) {
>  		err = REFTABLE_IO_ERROR;
>  		goto done;
>  	}
>  	if (add->stack->config.default_permissions) {
> -		if (chmod(temp_tab_file_name.buf, add->stack->config.default_permissions)) {
> +		if (chmod(get_tempfile_path(tab_file),
> +			  add->stack->config.default_permissions)) {
>  			err = REFTABLE_IO_ERROR;
>  			goto done;
>  		}
>  	}

Since the tempfile is now being created through the tempfile API, I
think the file mode can be set directly through `mks_tempfile_m()`
instead of creating the tempfile and then using chmod. Just something I
thought to mention.

> +	tab_fd = get_tempfile_fd(tab_file);

-Justin
