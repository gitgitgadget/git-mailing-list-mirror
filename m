Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7A1E48A
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305667; cv=none; b=uTpz2J0/MfaygLbZB5SmJy6f7JlB/InejkU8ODjxQBIMf8PE68xvNtG87ivpRM4Hc3gXDg6ak0cBQMX5pxrZe5nHG9Fq8Gx9hAzTbbx6q0KAZBO97YwbFLM0RDKemaLTk3geScsrfio2GMnluTLoi8dBY6K+llyvYJUr5S4lVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305667; c=relaxed/simple;
	bh=77GwgdlLzB69Os3shd0MVsk9/Tuy0w65DArt1s0KeqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5GNPxtBNEiZhMLbMDUCSaZRAFLepDOz0H/E/oqXTf7Heti4Vb4D5EP09YmgkmgBEBiKjb6wygk7hiZ/FKi8aMbrEpHu8PQxl6Au+p08z1C16bxbpynb7sVqAAV2nFdVq3YW6bnrnCP7UQF/71QAB8bBHzVI0N19RFNlg0pNFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQpD+lUS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQpD+lUS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21683192bf9so91206445ad.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 05:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735305665; x=1735910465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FONppq+5K9L+Ev1389RFi/aTFJraYWgXpWny9DbSJD4=;
        b=eQpD+lUS/ZefGVLKk4BsYYJEev4KbiSCewhwTuquSVStgg4p7sZO6PqUbFOWF1Ife1
         lsDBFJ4/gPmbJaRLF/PCoH5B22oxzSVfS+0VNN5m7MQK/KnJpqaPuWOwyWme82gs2965
         OsZA4Y93UV1PswQ2KgJ3rGkRy9l5aix2zJ47OHP/r+JN/W8kPip+4PS/pkHeH3ufMcTi
         yfEEWgqZlS/EsGqMBOxtbBgX7tKXLQ9nWnv4oyLW5qJ+tMcH+xBRG23eLWxjgVJAA28s
         DI0HKSN5kJbtk7CizUS/o547PTRGaNSncfNQQys0o8xzr8/lFSBj7yQcx6Jra1HoPA8Z
         KuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735305665; x=1735910465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FONppq+5K9L+Ev1389RFi/aTFJraYWgXpWny9DbSJD4=;
        b=b8dyxZKcWd3JPSKdN7E+1bA9duRNG+lqOGRCWAO1TKlNPD7aTFtqv9zQEspav9gkzJ
         HoaQLJ/PiPZOX8ggKlKbSGTgoNPqI4i9sPfKedotUhly6LkzxTf7b6UTYu8Tp0Qrtb+s
         wH60+HMdKsnq7STeONhhh4NEWGwlhCGGT8T7CuVHOpwZ40acU4Lrreynqlawp6F08hzk
         FTfGKYFrA167HWrSILrRjUVyuONaziJRUwFpwTGdqowaTcn24Z2lg4MQdzQ1BzhoqYAE
         977Z6xC9RY7xjKI61QllYvnr4Tpq1QY1XF2mYCoTu5zOkCRZjnYbZ8T1+RM1xAdukKFY
         yCRQ==
X-Gm-Message-State: AOJu0YwOLaMg5PTfUhbc8mDkeiuQN/SSNhv36F/XAn//4iICjJzaaIYj
	s+dKfaEtt1F15TuBkqzQ3pNuIds9AKN3jnbrYLegKFpdXeD3AEE5G/dgwQ==
X-Gm-Gg: ASbGnct2uPrUPpwLLtrtEsudeovOzHzPKOI33NHRS0CsGeYR9JdG9q9w4GrOAIpvq+I
	dRDZe5oY+5CF5VBFRtA0cCMVk5GzSNspnOmVI/2vHL4ES4RKWRtlv6d4Sz+NCaDxqe63UswXOPh
	X/+EJzxFrHGCPyCxhzHg55guzrr84322FSAxsuywCJi5fQixWxIyit0KECLmZuaeWuPOSnUV6+x
	tHtSCFMtFuBt8Pq3ytPA+o8utlTxKGKzclVRwc2jNhdiLd0n8/v
X-Google-Smtp-Source: AGHT+IE6B62cAJh3Ui9KJwN+R/InVmIAlaxZh6W4wDZ67hA/YVTkAfJTcZdquHsqAacc0yOTEUhf1Q==
X-Received: by 2002:a05:6a20:cd92:b0:1e4:745c:49d6 with SMTP id adf61e73a8af0-1e5e082e7ccmr41161072637.45.1735305665448;
        Fri, 27 Dec 2024 05:21:05 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad837395sm15147883b3a.69.2024.12.27.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 05:21:04 -0800 (PST)
Date: Fri, 27 Dec 2024 21:21:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] builtin/log: fix remaining -Wsign-compare warnings
Message-ID: <Z26p9GJbmyUd6bG-@ArchLinux>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-7-07c59c2aa632@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-7-07c59c2aa632@pks.im>

On Fri, Dec 27, 2024 at 11:46:27AM +0100, Patrick Steinhardt wrote:

[snip]

> @@ -717,14 +715,14 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
>  	unsigned long size;
>  	enum object_type type;
>  	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
> -	int offset = 0;
> +	unsigned long offset = 0;

Why here we use `unsigned long`, is this a special situation where we
cannot use `size_t`?

>  
>  	if (!buf)
>  		return error(_("could not read object %s"), oid_to_hex(oid));
>  
>  	assert(type == OBJ_TAG);
>  	while (offset < size && buf[offset] != '\n') {
> -		int new_offset = offset + 1;
> +		unsigned long new_offset = offset + 1;
>  		const char *ident;
>  		while (new_offset < size && buf[new_offset++] != '\n')
>  			; /* do nothing */

> @@ -2183,7 +2182,7 @@ int cmd_format_patch(int argc,
>  		fmt_patch_suffix = cfg.fmt_patch_suffix;
>  
>  	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
> -	if (cfg.log.fmt_patch_name_max <= strlen("0000-") + strlen(fmt_patch_suffix))
> +	if (cfg.log.fmt_patch_name_max <= cast_size_t_to_int(strlen("0000-") + strlen(fmt_patch_suffix)))

A design question, why we don't change the type of
`cfg.log.fmt_patch_name_max` to be `size_t`?

>  		cfg.log.fmt_patch_name_max = strlen("0000-") + strlen(fmt_patch_suffix);
>  
>  	if (cover_from_description_arg)
> 
> -- 
> 2.48.0.rc0.184.g0fc57dec57.dirty
> 

Thanks,
Jialuo
