Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F42942D
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871735; cv=none; b=oBb/UIUEAHDH5xsIRGTyX2tm9ZIeIAZuDozKLDmCuKfItHU3hiXxNXi6Vtk7ljq1L/WjyQDCVqidXd+fwsr+XazYNMTqyWX5h0KcVMvb0diL6sbOUZfN98QA90VbeGOwo7tlcmEi2RlxQk1Z+C9YL1tZulWEd/iY0wvyFesHk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871735; c=relaxed/simple;
	bh=hb6c5wzWWzAPWugwT6VUb+A8CERBVKXKb7mxctgTbiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFK1T4hrMxcfeiajF6BYGCJ71frq+E25YfyieAmndoWi3N4BuppB5bznDIrnNzd5HFPWHrn90a3OYeWZa17gUSoyljgz1rDfUXxi4whsBwxpYjb+dsSN5CBVVVTRFBlwM4Gg2wkqKTfriA9tct9ITJliSRAcoJdr3GsnV7nKerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oINmOcvK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oINmOcvK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso244127b3a.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 14:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712871734; x=1713476534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PuEhS4q0Xq4O2W2Pdir6HXv9OUjF5NKSK/PzclJUig=;
        b=oINmOcvK9oMj0r5xf6boA+SWBlkkFTa3pzYP7JizZXErlc/7D5awuCYby0bffj9gyJ
         SnQCxjQkrIPHRE0XxRFLIyyppGKlMnv7iCLpLlQtaxGWMaLDde2NPVSDpcoqank4n57o
         KFSR+LVrKiLyGBuvnVxp1+v7Lw+3L+GxkzSguJsb0XsVGe/hQ+86XEcgtSYn9zXiPL7H
         fc9NrZGCidHPU65e0uUJZN59pm/QHC1QBHnUQ25AbfTpCTL6stzJMW26HskSBRo+4LAS
         xKU/aKSQX0HVFy+OoEwmvLlp5GavvCWaLQXK8xh325Zl4z/rzFWRtnk8P6pecWACX9su
         uGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712871734; x=1713476534;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PuEhS4q0Xq4O2W2Pdir6HXv9OUjF5NKSK/PzclJUig=;
        b=phiiY1If/IPB+XwTxVV6MDAqt+zKO/osIUzb7WR3W/fZwtdVYP0nWIh11YlzjS7HJk
         8WERJWfmrY1+QI6RgJ2Sjb30rrCOBdiJhOnC3l9ALQDLqq3LcInVOLqjvKMaodzggpFo
         zynnp4wh5oOgSq+egGwgKXC2YdIscwUbBSqn7INby8YEGwhHk3P+CqIW8IaLPsPmNnSn
         TnNPCyi1A6DQ6Bhhyec2Y7pSctZiHN9+lI54LDfdTT8ZYfJ8X940zctfYNrdxvKm4OfX
         tIi9uoa6TSVXJzncBaV1FBgM6YQjCIZGf9+fdOWUw9QkCbw/wGRPvM4ulBUyXlVjgDsB
         hYTg==
X-Gm-Message-State: AOJu0YyYuXlM3rpYqeOjvJFSEXPm9TmHBHC1J/WQcnkAPBenqBAxkYQX
	zG2aikjfSVHPbIa4p1l7f/8XHEj5o/rijdxjto8GZRBKC46OFNdZL5l7pOkjeA==
X-Google-Smtp-Source: AGHT+IGpZ81XV28+7+yjxy7KnBbthRzrFjk/7dCESQd2XEUfWdd6h8lV5chM+G07YM2uZtelrqQtPg==
X-Received: by 2002:a05:6a00:1302:b0:6ed:63e:3525 with SMTP id j2-20020a056a00130200b006ed063e3525mr912866pfu.31.1712871733592;
        Thu, 11 Apr 2024 14:42:13 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:5d8a:5a85:8673:4f76])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b006edd9339917sm1619340pfe.58.2024.04.11.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:42:13 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:42:08 -0700
From: Josh Steadmon <steadmon@google.com>
To: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Mohit Marathe <mohitmarathe@proton.me>
Subject: Re: [PATCH 2/2] test-lib: replace repeated code logic with an
 existing helper
Message-ID: <ZhhZMOWnrni94WTD@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Mohit Marathe <mohitmarathe@proton.me>
References: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
 <8a730b6ebba4111aaad4e8fc938c52f6e7e54480.1710766062.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a730b6ebba4111aaad4e8fc938c52f6e7e54480.1710766062.git.gitgitgadget@gmail.com>

On 2024.03.18 12:47, Mohit Marathe via GitGitGadget wrote:
> From: Mohit Marathe <mohitmarathe@proton.me>
> 
> This patch replaces the code, that changes the path separators,
> with the already existing function `change_path_separators()`
> 
> Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
> ---
>  t/unit-tests/test-lib.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 66d6980ffbe..b0e26263046 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -52,9 +52,7 @@ static const char *make_relative(const char *location)
>  		prefix_len = len - needle_len;
>  		if (prefix[prefix_len + 1] == '/') {
>  			/* Oh, we're not Windows */
> -			for (size_t i = 0; i < needle_len; i++)
> -				if (needle[i] == '\\')
> -					needle[i] = '/';
> +			change_path_separators(&needle[0]);

Why not just:
change_path_separators(needle);
?

>  			need_bs_to_fs = 0;
>  		} else {
>  			need_bs_to_fs = 1;
> @@ -88,9 +86,8 @@ static const char *make_relative(const char *location)
>  
>  	/* convert backslashes to forward slashes */
>  	strlcpy(buf, location + prefix_len, sizeof(buf));
> -	for (p = buf; *p; p++)
> -		if (*p == '\\')
> -			*p = '/';
> +	p = buf;
> +	change_path_separators(p);

And here, why not:
change_path_separators(buf)
?

>  	return buf;
>  }
>  
> -- 
> gitgitgadget
> 
