Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF814F108
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556723; cv=none; b=F4L06noOpq8KK4nbJeNnlPaBCHVSz7Uve3xs5Ty0sdgCqFpa05gfB0j20GHKEf1x3q2eqSSWkAqYYYXqKagsSV53WJkvRYI21NmGfFfT1Gflk5xiuCtRYxs4GRh6wB/voEJcAA4tpjTzdxIlEjL+WV2X42PYrWp3qh/acTUScao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556723; c=relaxed/simple;
	bh=mw0k1QbYFETfe5JkkIH4v8dDChwJJmTjV7Uq5cKEloY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7QzvIK+l/hWhX2BuUm5h5Lhq42IBCsDwPw2VpK+P1+rpPVz7F6TuDWN55CepIciQTXMf59BdzvvIfoCP0NtYxFEG/23rridScTlrP53TYY00f+DI7FyN9Rm9yfp953R8rQp1xlhgimtaP3x9hMDR0bbJoVI2z+pBdZt0zrpS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzrZb8QI; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzrZb8QI"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25e0663de76so2728854fac.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720556721; x=1721161521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/SwGBNK27CMXqPadBVwpLJ3B811W5CuN/wvqtPkZAE=;
        b=kzrZb8QIfccvVPeU4N4AAi3upGXRoBPr38hvtZyI9Ix/DtTfGdYZLuGyJwhANTDY8L
         C7CgXQoGnC7Z+xY8NI9Db8gWjKZLGUiKFvcrEyDfvwUqGAo6tDnH3EtBenZTdP0XHDr+
         /pJtqGZD7aWpczzsPiuTy7FaW/RA+NgIlw/zWYvL7UwCI7j3YuR4PrsK0VCoW7t/cQOS
         zKmy/65HiZIi8qqtro/7GQDOlbyPcgTm7oaRew56ihFTOW9mTMGBMBXbicyNepkAZ85s
         1p1oZi1zzSg4GgATTrvYOn9QiXG43GhX/H+cfgNOA+L9PDxeRa53YYB2z69Nnirdv1/H
         +UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720556721; x=1721161521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/SwGBNK27CMXqPadBVwpLJ3B811W5CuN/wvqtPkZAE=;
        b=GnvUIHpghy6N5ctD3MpqfU3/3ozkWDR7tEF7S1inXW/TJ2RtdezVnvSJbX+DpajWdJ
         5aDdtLEWPUq3dnfOIfkVbK9EO2QGMOnQZIpdRDmZgNN8hjZUEEoP1tKm8L+uaj+Gfeh3
         m8QjMNEiiwghB/bAlj07f/4M+wuQa06FUO47+3JoLm4miUjUaScpxtsTASUx9PvmoBUJ
         IaBY+D6KZeQmlX9p0MY5SfNAgWFiTpCzJ6LskTcYQB8dOCHsq7/n6D0iUKkMfW7nmHXR
         ft5NEnc4NDA1yQ/gPDw/lILn7fkCFdLWgnb/Jen/sfatAzlPzqgWgEA5sSseW5PWVsS2
         nuXA==
X-Gm-Message-State: AOJu0Yyr4QgRzT+TgIPLmM233GByVVHQopKc2kP41jt0OXFZ773lnZX0
	f/18S5KGsk7aTLatnEYhnXMcXq15YB6/qt/dgBmPvxAch4oZOW+J
X-Google-Smtp-Source: AGHT+IGyryN+tZDq41tqgZrmmAApkJyW+cpXNeUtJEMt7tKYacdQhBbPwkNHnvPrLR48CMte+HBCIg==
X-Received: by 2002:a05:6870:71ca:b0:24f:eada:e32 with SMTP id 586e51a60fabf-25eae7baaacmr3291060fac.17.1720556720819;
        Tue, 09 Jul 2024 13:25:20 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa297978sm790840fac.47.2024.07.09.13.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:25:20 -0700 (PDT)
Date: Tue, 9 Jul 2024 15:24:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 2/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <cu3ypjpzpdkazg7w7ho5njcrzvqklzycba3oipwhztlh6lvu6t@wtjew4mj6ku4>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0ufgFhREKlmBFG@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0ufgFhREKlmBFG@ArchLinux>

On 24/07/09 08:35PM, shejialuo wrote:
> The static function "report" provided by "fsck.c" aims at checking fsck
> error type and calling the callback "error_func" to report the message.
> However, "report" function is only related to object database which
> cannot be reused for refs. In order to provide a unified interface which
> can report either objects or refs, create a new function "vfsck_report"
> by adding "checked_ref_name" parameter following the "report" prototype.
> Instead of using "...", provide "va_list" to allow more flexibility.
> 
> Like "report", the "vfsck_report" function will use "error_func"
> registered in "fsck_options" to report customized messages. Change
> "error_func" prototype to align with the new "vfsck_report".
> 
> Then, change "report" function to use "vfsck_report" to report objects
> related messages. Add a new function called "fsck_refs_report" to use
> "vfsck_report" to report refs related messages.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  builtin/fsck.c  | 15 ++++-----
>  builtin/mktag.c |  1 +
>  fsck.c          | 81 ++++++++++++++++++++++++++++++++++++-------------
>  fsck.h          | 40 +++++++++++++++---------
>  object-file.c   | 11 ++++---
>  5 files changed, 101 insertions(+), 47 deletions(-)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d13a226c2e..de34538c4f 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -89,12 +89,13 @@ static int objerror(struct object *obj, const char *err)
>  	return -1;
>  }
>  
> -static int fsck_error_func(struct fsck_options *o UNUSED,
> -			   const struct object_id *oid,
> -			   enum object_type object_type,
> -			   enum fsck_msg_type msg_type,
> -			   enum fsck_msg_id msg_id UNUSED,
> -			   const char *message)
> +static int fsck_objects_error_func(struct fsck_options *o UNUSED,
> +				   const struct object_id *oid,
> +				   enum object_type object_type,
> +				   const char *checked_ref_name UNUSED,
> +				   enum fsck_msg_type msg_type,
> +				   enum fsck_msg_id msg_id UNUSED,
> +				   const char *message)

This is just a suggestion, but I think it would be slightly easier to
review if the `*_error_func()` renames were done in a separate preceding
patch. That way the purpose of the renames can also be clearly
explained.

>  {
>  	switch (msg_type) {
>  	case FSCK_WARN:
> @@ -938,7 +939,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  
>  	fsck_walk_options.walk = mark_object;
>  	fsck_obj_options.walk = mark_used;
> -	fsck_obj_options.error_func = fsck_error_func;
> +	fsck_obj_options.error_func = fsck_objects_error_func;
>  	if (check_strict)
>  		fsck_obj_options.strict = 1;
>  
[snip]
> @@ -166,7 +171,7 @@ struct fsck_options {
>  	.gitmodules_done = OIDSET_INIT, \
>  	.gitattributes_found = OIDSET_INIT, \
>  	.gitattributes_done = OIDSET_INIT, \
> -	.error_func = fsck_error_cb_print_missing_gitmodules, \
> +	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
>  }
>  
>  /* descend in all linked child objects
> @@ -209,6 +214,13 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
>   */
>  int fsck_finish(struct fsck_options *options);
>  
> +__attribute__((format (printf, 5, 6)))
> +int fsck_refs_report(struct fsck_options *options,
> +		     const struct object_id *oid,
> +		     const char *checked_ref_name,
> +		     enum fsck_msg_id msg_id,
> +		     const char *fmt, ...);
> +

I think I mentioned this in a previous reply, but it was missed. Not a
big deal, but it might be nice to document `int fsck_refs_report()`
here.

-Justin
