Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDF78696
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577586; cv=none; b=PN1VVjduKI7Ew1NTvFC4ylT08waHZVlT9exTEq81h1cMF+xjHLY3bEhbV3dBvilui9ZQbhVwbYADB/oQl0MGqlDmxApWWjwlvEiY4a79ad13Xhq7NXps0J4sZowCBWdHR5ADCwtEjNsiWvT4kfrcx3c6VwlML4IajDdjuXFILUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577586; c=relaxed/simple;
	bh=b39mMc7smqzZnMG08uQ0dNOEeG0adK1nhXCRWBM2lTk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LZ+mlmgrQOffJDeK85Nle8acliMxy5lSPt8uUQMeIrdyVmlWW2Ax/mwxf8/ewROoL98osHV/XmEKPW8YHz0xkX/fQHfENTH92DgkUSCool80oJp30dh53155+kt45vOUkPAuZFmSqlsDGQWUCwD1tyXNspiTdAkGL/A0Ezqb60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3bHVLTT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3bHVLTT"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso58737871fa.2
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709577582; x=1710182382; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTQr5N4HCuLbB0NaHnG3IeymPlrufWW9XDPgSoTQXLw=;
        b=M3bHVLTTN7RZEX8viGqOjZadzvV8tL2NIg/Yc39PwBH/C6eC3P0BvKA3piFArw0VJB
         9zRDCbFdndgSk85WsVvpVXTpwTdoJlmF4qKuzDedaJxQTVWaw/fU8VKkYjK8/uG95bB/
         cvE72Us/NNXtmu7JhICzZgISeM5F6I7BW1saWEwwSEYb58sg4ozSijTEKMLkEAxsCxjQ
         2h9JVFEMUkNSuTF6BZSDZexyk0IkPc4NQJjmkvle05jgw3ALOzOPMG3pZAC0/I3NDrvN
         Eu8gXSuBfIQwwDFwVilGvX3Yp36gbLIK+yoQ6cGJhVcSeMLJo2eY0wCBrag1D3C1uI0k
         pUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577582; x=1710182382;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTQr5N4HCuLbB0NaHnG3IeymPlrufWW9XDPgSoTQXLw=;
        b=LyP6aBvuI1evAFYB9DMuLgCoqVSQE66/GZYJSMo44ApGGiAu9yeniCt7Q3IkFuFahP
         ictAs5rB9AJrLS1JAFY85HQu1lzqN9nT88wHduvdgzweKQU6oOP+1C3LvcVnY1pSVCdV
         kk5JQcLrCPTjEN9ZAFmbFfTZK5y9lYNcLjl/1MXre+U7dh6wt6cYUGkP0agIynMfSET3
         hwwvGuuN7y+wl9fjrqPgfGibDmCvnJjoQYDQ5I37PNNLsirjSTzRwJUsIaIBzgtOUs85
         SWX68p5a6/Ev5JXkZ0oQwRlmhHX62L2ZlB+Imyz6LT9yYVe9naAd94f+iDTujvJvVRLu
         WkuA==
X-Gm-Message-State: AOJu0Yz9On+EpHDLtCyJgrN+6grM2W4+lRdee4PN6VXDKkQ4wsanpeUW
	7ipoSNDIwyXsuJ54FHKDuKr7CPr2tfmc4RAlAX6ppjSKI1vvraOf6I7LYZ/H
X-Google-Smtp-Source: AGHT+IFfwhgw/qfgbRAwCRP+rOpmIt859dMKup3A5EeSuTlBjJszv+vv20L9HmQv1lE05BBxYYLyJg==
X-Received: by 2002:a05:6512:3d91:b0:513:32b1:9654 with SMTP id k17-20020a0565123d9100b0051332b19654mr8416887lfv.25.1709577581932;
        Mon, 04 Mar 2024 10:39:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id ep2-20020a056512484200b005131434454bsm1817112lfb.228.2024.03.04.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:39:41 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>,  "Kristoffer
 Haugsbakk" <code@khaugsbakk.name>
Subject: Re: [PATCH v2] clean: improve -n and -f implementation and
 documentation
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
	<20240303220600.2491792-1-gitster@pobox.com>
Date: Mon, 04 Mar 2024 21:39:40 +0300
In-Reply-To: <20240303220600.2491792-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Sun, 3 Mar 2024 14:05:59 -0800")
Message-ID: <87h6hl96z7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Changes since v1:
>>
>>  * Fixed style of the if() statement
>>
>>  * Merged two error messages into one
>>
>>  * clean.requireForce description changed accordingly
>
> Excellent.
>
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index d90766cad3a0..41502dcb0dde 100644
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
>> @@ -946,22 +946,17 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>  	};
>>
>>  	git_config(git_clean_config, NULL);
>> -	if (force < 0)
>> -		force = 0;
>> -	else
>> -		config_set = 1;
>
> The above changes are a significant improvement.  Instead of a
> single "force" variable whose meaning is fuzzy, we now have
> "require_force" to track the config setting, and "force" to indicate
> the "--force" option.  THis makes the code's intent much clearer.
>
>>  	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>>  			     0);
>>
>> -	if (!interactive && !dry_run && !force) {
>> -		if (config_set)
>> -			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
>> -				  "refusing to clean"));
>> -		else
>> -			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
>
> And thanks to that, the above trick with an extra variable "config_set",
> which smells highly a round-about way, can be simplified.
>
>> +	/* Dry run won't remove anything, so requiring force makes no sense */
>> +	if (dry_run)
>> +		require_force = 0;
>> +	if (require_force != 0 && !force && !interactive)
>
> However, the above logic could be improved.  The behaviour we have,
> for a user who does *not* explicitly disable config.requireForce,
> is, that when clean.requireForce is not set to 0, we would fail
> unless one of these is in effect: -f, -n, -i.  Even though using
> either -n or -i makes it unnecessary to use -f *exactly* the same
> way, the above treats dry_run and interactive separately with two if
> statements, which is suboptimal as a "code/logic clean-up".

I wonder do you mean:

	/* Dry run won't remove anything, so requiring force makes no
	* sense. Interactive has its own means of protection, so don't
	* require force as well */
	if (dry_run || interactive)
		require_force = 0;

	if (require_force != 0 && !force)
                die_();

that looks fine to me, as it puts 'force' flag and corresponding
configuration into one if(), whereas both exceptions are put into
another. OTOH, having:

     if (require_force != 0 && !force && !interactive && !dry_run)
                die_();

mixture looks less appealing to me, though I won't fight against it
either.

>
> The reason for the behaviour can be explained this way:
>
>  * "git clean" (with neither -i nor -n.  The user wants the default
>    mode that has no built-in protection will be stopped without -f.
>
>  * "git clean -n".  The user wants the dry-run mode that has its own
>    protection, i.e. being always no-op to the files, so there is no
>    need to fail here for the lack of "-f".
>
>  * "git clean --interactive".  The user wants the interactive mode
>    that has its own protection, i.e. giving the end-user a chance to
>    say "oh, I didn't mean to remove these files, 'q'uit from this
>    mistake", so there is no need to fail here for the lack of "-f".

Well, if we remove -i from error message as well, then yes, this makes
sense.

>
>> +		die(_("clean.requireForce is true and neither -f nor -i given:"
>>  				  " refusing to clean"));
>
> The message is certainly cleaner compared to the previous round, but
> this also can be improved.  Stepping back a bit and thinking who are
> the target audience of this message.  The only users who see this
> message are running "git clean" in its default (unprotected) mode,
> and they wanted to "clean" for real.  If they wanted to do dry-run,
> they would have said "-n" themselves, and that is why we can safely
> omit mention of "-n" we had in the original message.
>
> These users did not want to run the interractive clean, either---if
> they wanted to go interractive, they would have said "-i"
> themselves.  So we do not need to mention "-i" either for exactly
> the same logic.

I then suggest to consider to remove mention of -i from
clean.requireForce description as well.

>
> Based on the above observation,
>
> I'll send a follow-up patch to clean up the code around here (both
> implementation and documentation), taking '-i' into account as well.

Fine, thanks!

-- Sergey Organov
