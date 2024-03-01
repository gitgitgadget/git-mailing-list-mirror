Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651717D5
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303697; cv=none; b=Umxaq9LH2RfPMlObFuTHlXI/8fPBJBwAmzdk70+NuDVIwl6C59saUd9B6ZeFelcuQxceH7qNOlV2cYcRHKSdR3koERTDIjvr1H77YZU3CLKCKbEBDCFt3zZ/73FSaW944zCY8lsZxSBqvFnGYCzJmJUS1Ymg09IHxoMLgEmhGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303697; c=relaxed/simple;
	bh=PekHqWCBFAX9HwiY0rmyGFIggsYeapDeJ+Hy4FeZjnA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EdwgxFkfsDuc3QWzPellvOxOavOzGbDF6TS9AnYf3//e9Dw0SGdRtgJZJrcfB9SuK7RiV9QrgW8iCULEL8NiRdBR9CitKuACIOnj83AHny7AVAmPRQRG5cqPtEwP7UimGL2ZqioC5l0nCkFypFrJHIpvHFDIB4NNKAvlMWKId5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwXXW7z2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwXXW7z2"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d09cf00214so24884391fa.0
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 06:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709303694; x=1709908494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BmMOpTTzqqX2vXbzNzJ4qEDg5Pk4aNNbR043HmV/rd4=;
        b=dwXXW7z2CwW2hQNdtKDELhapFvVWw9s1mbs55QjvNiOmqF6QzA7xKG7a/L83c8FnYM
         e9awtFfDgJ2oqxoG2ONhDLRIIWLlOICWG4Kvg3zen6AwNvN15zGgyB00ToefAxGAzsnF
         ieoYgDqWhOoEa/8c93TVZWhG3wwhO2so0SNN+Y+QJ1/AYQ+pOpCm4AKmp+zFW3O6G+ZG
         wNOQNuo7Ivo2BF7pnNofkxWePwZ2sJOljAO5+UV2+xSUtXeDrM3yvezH6KbvHGI6tgLi
         d30ruI4uKyJ3BP1cm4NzsKK3EDgOQ5ENfZjEwcIgZGwpXv3jajEVJ1p+HalVIWZxDHwm
         mNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303694; x=1709908494;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmMOpTTzqqX2vXbzNzJ4qEDg5Pk4aNNbR043HmV/rd4=;
        b=TCodtSVZHw567IjgHVPO7b3tPXYodVkNFTPefa8Ok8l/ZEpb8Hr4hhyy0rPe/MmL6Z
         YqgNUpFaNyA9bOF/kJKycuKsFP30NyogGB39IrAzLQSxKhd3Mq0wAdGmtW6MXgkikrHy
         o7YEzSLpvf8f6FFIrrCpXMdpZ5aGQ0jo3LgGZ9A3zmwykDm1qu0kLZ60YTielAKSuBDg
         a+Tl58H7mAnSQpmXVwXP9xWifnKD38dznx+UScwiH+sJ/X07oxt2d59pCzExaOreAYDw
         ybVpcDcM2SLkmB3artnSNw+lCoN+TWOaxGgXdoo86dJwcASCgeH13Z02Tm8lODQH5Orx
         J9gA==
X-Forwarded-Encrypted: i=1; AJvYcCWo2Rt2HLHYHM8NteC5n3zbERmY8bvSnbyW7uRFfEJBWYTRnDyIM+GR7somzCwdOFPFuBtK6l+ZwZ7dKtV0HjGYqLJi
X-Gm-Message-State: AOJu0Ywn3bgIQFbbU1pufnzJsqx4FqHwoVTeJl6zQDNNFRELHEjE6wqX
	c9iOkRBDMe9tyO+CnmUrngwbScCb0e7z6MlGrrgiYXodKfrwDV3VjRd1+Szd
X-Google-Smtp-Source: AGHT+IEtU0BD7snLlPjwZTqphd9UMbcwWPWBFDkAGCgrtnQToQczQezJli1FVOY33WZaBZNE7o031w==
X-Received: by 2002:a19:f703:0:b0:513:2be5:1fca with SMTP id z3-20020a19f703000000b005132be51fcamr1536384lfe.29.1709303693518;
        Fri, 01 Mar 2024 06:34:53 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t30-20020a192d5e000000b00512ed6cd31esm657018lft.85.2024.03.01.06.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:34:53 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
Date: Fri, 01 Mar 2024 17:34:52 +0300
In-Reply-To: <51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila"'s message of "Fri, 1 Mar 2024 14:20:47 +0100")
Message-ID: <87frxam35f.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <avila.jn@gmail.com> writes:

> Putting my documentation/translator hat:
>
> Le 29/02/2024 à 20:07, Sergey Organov a écrit :
>> What -n actually does in addition to its documented behavior is
>> ignoring of configuration variable clean.requireForce, that makes
>> sense provided -n prevents files removal anyway.
>> 
>> So, first, document this in the manual, and then modify implementation
>> to make this more explicit in the code.
>> 
>> Improved implementation also stops to share single internal variable
>> 'force' between command-line -f option and configuration variable
>> clean.requireForce, resulting in more clear logic.
>> 
>> The error messages now do not mention -n as well, as it seems
>> unnecessary and does not reflect clarified implementation.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-clean.txt |  2 ++
>>  builtin/clean.c             | 26 +++++++++++++-------------
>>  2 files changed, 15 insertions(+), 13 deletions(-)
>> 
>> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
>> index 69331e3f05a1..662eebb85207 100644
>> --- a/Documentation/git-clean.txt
>> +++ b/Documentation/git-clean.txt
>> @@ -49,6 +49,8 @@ OPTIONS
>>  -n::
>>  --dry-run::
>>  	Don't actually remove anything, just show what would be done.
>> +	Configuration variable clean.requireForce is ignored, as
>> +	nothing will be deleted anyway.
>
> Please use backticks for options, configuration and environment names:
> `clean.requireForce`

I did consider this. However, existing text already has exactly this one
unquoted, so I just did the same. Hopefully it will be fixed altogether
later, or are you positive I better resend the patch with quotes? 

>>  
>>  -q::
>>  --quiet::
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index d90766cad3a0..fcc50d08ee9b 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -25,7 +25,7 @@
>>  #include "help.h"
>>  #include "prompt.h"
>>  
>> -static int force = -1; /* unset */
>> +static int require_force = -1; /* unset */
>>  static int interactive;
>>  static struct string_list del_list = STRING_LIST_INIT_DUP;
>>  static unsigned int colopts;
>> @@ -128,7 +128,7 @@ static int git_clean_config(const char *var, const char *value,
>>  	}
>>  
>>  	if (!strcmp(var, "clean.requireforce")) {
>> -		force = !git_config_bool(var, value);
>> +		require_force = git_config_bool(var, value);
>>  		return 0;
>>  	}
>>  
>> @@ -920,7 +920,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>  {
>>  	int i, res;
>>  	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
>> -	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
>> +	int ignored_only = 0, force = 0, errors = 0, gone = 1;
>>  	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
>>  	struct strbuf abs_path = STRBUF_INIT;
>>  	struct dir_struct dir = DIR_INIT;
>> @@ -946,21 +946,21 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>  	};
>>  
>>  	git_config(git_clean_config, NULL);
>> -	if (force < 0)
>> -		force = 0;
>> -	else
>> -		config_set = 1;
>>  
>>  	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>>  			     0);
>>  
>> -	if (!interactive && !dry_run && !force) {
>> -		if (config_set)
>> -			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
>> +	/* Dry run won't remove anything, so requiring force makes no sense */
>> +	if(dry_run)
>> +		require_force = 0;
>> +
>> +	if (!force && !interactive) {
>> +		if (require_force > 0)
>> +			die(_("clean.requireForce set to true and neither -f, nor -i given; "
>> +				  "refusing to clean"));
>> +		else if (require_force < 0)
>> +			die(_("clean.requireForce defaults to true and neither -f, nor -i given; "
>>  				  "refusing to clean"));
>> -		else
>> -			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
>> -				  " refusing to clean"));
>>  	}
>>  
>
> The last two cases can be coalesced into a single case (the last one),
> because the difference in the messages does not bring more information
> to the user.

Did you misread the patch? There are only 2 cases here, the last (third)
one is marked with '-' (removed). Too easy to misread this, I'd say. New
code is:

		if (require_force > 0)
			die(_("clean.requireForce set to true and neither -f, nor -i given; "
				  "refusing to clean"));
		else if (require_force < 0)
			die(_("clean.requireForce defaults to true and neither -f, nor -i given; "

and is basically unchanged from the original, except reference to '-n' has been
removed. Btw, is now comma needed after -f, and isn't it better to
substitute ':' for ';'?

Thank you for review!

-- Sergey Organov

