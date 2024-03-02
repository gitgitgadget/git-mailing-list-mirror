Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205C3AC0F
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410149; cv=none; b=OrJUXanbi9hgyplHqETEAfC1d1zbvCBAE2po4B0gnC/dX9CrdasYgMWxTZ4+VbmZQScIhpLuB1iXKpEJVqn+8bTw5NOa2shYaTr6K7krpR44p+dXv/EqYddua/LiA5+aN2mtwC8vlht8kIdOxziwwToAeWVVpp02ToYC1hQFNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410149; c=relaxed/simple;
	bh=6zLqDvFPC30LTLgHlHP90A8q/i7CJVZKH1kQ4HBsZJY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pGwClFdAsDinyFyvKQTeiSlvTrbo5tZBY1ZF+MXU2oyCJCZxhQMY0wViapEFu+chLm0p2Kk9q2aArTq262nhdbDay+Le/CE3rZQHJ6xKjJDKqE4iXmDAZ10DYGo72ed/Amr3uP82Wm3izsbT31Ad1twnoENL/lSkXMTKryi1n2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy8N81zg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy8N81zg"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2628e81b8so41117641fa.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 12:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709410145; x=1710014945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L8Ph9mf82XFqqjwDyPofrAoa2zGhKERKs7xAKMkFP1Q=;
        b=Yy8N81zgca/mTW7GrN3/Wa7wCmN32ilq93vCJgjE4P7A9TUVwg3Y+eigGXg+X0wZcZ
         5M99zNxaGHxqRJyYNKNNy9XYsGN8ilEwEaCUr+JKNuW0LbQ7gyOKoXuOGAORAlPxLMj/
         2BSHpADC+O4v7HU08LMyaaTePqOwJwMcRrIduJJGQzyzpxkCH4awKT5McLJLJPJcThVG
         xVqbEKWpvgjduG91H5FYjxKQYmlPZTwl8gVqS0yIBQRUxC0FeyjnpzEDiLGcqig3FwpJ
         hmqp6DaL7VIz/hAUzA9GRqAXcsqkidapr4hvZ0EXdg37yvVKtFod4MZnZuRq70r+jJPI
         6+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410145; x=1710014945;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8Ph9mf82XFqqjwDyPofrAoa2zGhKERKs7xAKMkFP1Q=;
        b=Gy5ZOe8Nh1X0obbUWxalSZYCRNW6blTeLZI6EZb/b0soLBrhFY4hdmon55vQR1OKGf
         eX+J4i6+AD+uSY9bCbhhYUe8IS1nXlq37NID6LXZNLpsIsHFzhW+TG2oLcb5AamziLzx
         KYeoro5KE+jtBcAbXPfqFUCmiHSvZ5+8uvCRYEnGJuMXHmu/UbZ7nUHF/gnP6zoSIk0v
         SxgdeXK0xOH25xwCxHlQOL6Lkv3xCOZRbUL+2wzVEmejI0BzJ1LvPtoagbT3hFDJf9Y+
         3xdZqtAmaFkYvnMonAGEl23w4i8QnNuGTOvC1UvTe4+ezfBCUn7+q2ogF1ZRdrhIBTLT
         z/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWvffnL3CzdUwID6TYkRLd9XelI/nc2e81DUlJjEntI4KjlEaAc8XgCzRV605oNh8fZhR4N0IsgLl1V9lNuWdOTCa2c
X-Gm-Message-State: AOJu0Yxz3VJ18xqe6tnBFFDgPhjWK0Rk/eyRQrEO1qKxJ4dwpqV7XVEH
	OdIm+VOE0u7vZfX4WDTt0DSdCYg/bbkOMGNDOTFc06kfArUF9vWbNMEIfAsjtCk=
X-Google-Smtp-Source: AGHT+IFRLhgctXUDBtML2wQOF2DoJkib31LE1LGZgNunlNOtaaZ8Mx3/MEdzkISCv5u0KftkMWbjfg==
X-Received: by 2002:a2e:a404:0:b0:2d2:7b4d:a11d with SMTP id p4-20020a2ea404000000b002d27b4da11dmr2342109ljn.12.1709410144743;
        Sat, 02 Mar 2024 12:09:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w15-20020a2e958f000000b002d277882eb6sm1054711ljh.83.2024.03.02.12.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 12:09:04 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
	<87frxam35f.fsf@osv.gnss.ru> <6033073.lOV4Wx5bFT@cayenne>
Date: Sat, 02 Mar 2024 23:09:03 +0300
In-Reply-To: <6033073.lOV4Wx5bFT@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Sat, 02 Mar 2024 20:47:55 +0100")
Message-ID: <87r0gs8kgw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <avila.jn@gmail.com> writes:

> On Friday, 1 March 2024 15:34:52 CET Sergey Organov wrote:
>> Jean-Noël Avila <avila.jn@gmail.com> writes:
>> 
>> > Putting my documentation/translator hat:
>> >
>> > Le 29/02/2024 à 20:07, Sergey Organov a écrit :
>> >> What -n actually does in addition to its documented behavior is
>> >> ignoring of configuration variable clean.requireForce, that makes
>> >> sense provided -n prevents files removal anyway.
>> >> 
>> >> So, first, document this in the manual, and then modify implementation
>> >> to make this more explicit in the code.
>> >> 
>> >> Improved implementation also stops to share single internal variable
>> >> 'force' between command-line -f option and configuration variable
>> >> clean.requireForce, resulting in more clear logic.
>> >> 
>> >> The error messages now do not mention -n as well, as it seems
>> >> unnecessary and does not reflect clarified implementation.
>> >> 
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  Documentation/git-clean.txt |  2 ++
>> >>  builtin/clean.c             | 26 +++++++++++++-------------
>> >>  2 files changed, 15 insertions(+), 13 deletions(-)
>> >> 
>> >> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
>> >> index 69331e3f05a1..662eebb85207 100644
>> >> --- a/Documentation/git-clean.txt
>> >> +++ b/Documentation/git-clean.txt
>> >> @@ -49,6 +49,8 @@ OPTIONS
>> >>  -n::
>> >>  --dry-run::
>> >>  	Don't actually remove anything, just show what would be done.
>> >> +	Configuration variable clean.requireForce is ignored, as
>> >> +	nothing will be deleted anyway.
>> >
>> > Please use backticks for options, configuration and environment names:
>> > `clean.requireForce`
>> 
>> I did consider this. However, existing text already has exactly this one
>> unquoted, so I just did the same. Hopefully it will be fixed altogether
>> later, or are you positive I better resend the patch with quotes? 
>> 
>> >>  
>> >>  -q::
>> >>  --quiet::
>> >> diff --git a/builtin/clean.c b/builtin/clean.c
>> >> index d90766cad3a0..fcc50d08ee9b 100644
>> >> --- a/builtin/clean.c
>> >> +++ b/builtin/clean.c
>> >> @@ -25,7 +25,7 @@
>> >>  #include "help.h"
>> >>  #include "prompt.h"
>> >>  
>> >> -static int force = -1; /* unset */
>> >> +static int require_force = -1; /* unset */
>> >>  static int interactive;
>> >>  static struct string_list del_list = STRING_LIST_INIT_DUP;
>> >>  static unsigned int colopts;
>> >> @@ -128,7 +128,7 @@ static int git_clean_config(const char *var, const 
> char *value,
>> >>  	}
>> >>  
>> >>  	if (!strcmp(var, "clean.requireforce")) {
>> >> -		force = !git_config_bool(var, value);
>> >> +		require_force = git_config_bool(var, value);
>> >>  		return 0;
>> >>  	}
>> >>  
>> >> @@ -920,7 +920,7 @@ int cmd_clean(int argc, const char **argv, const char 
> *prefix)
>> >>  {
>> >>  	int i, res;
>> >>  	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
>> >> -	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
>> >> +	int ignored_only = 0, force = 0, errors = 0, gone = 1;
>> >>  	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
>> >>  	struct strbuf abs_path = STRBUF_INIT;
>> >>  	struct dir_struct dir = DIR_INIT;
>> >> @@ -946,21 +946,21 @@ int cmd_clean(int argc, const char **argv, const 
> char *prefix)
>> >>  	};
>> >>  
>> >>  	git_config(git_clean_config, NULL);
>> >> -	if (force < 0)
>> >> -		force = 0;
>> >> -	else
>> >> -		config_set = 1;
>> >>  
>> >>  	argc = parse_options(argc, argv, prefix, options, 
> builtin_clean_usage,
>> >>  			     0);
>> >>  
>> >> -	if (!interactive && !dry_run && !force) {
>> >> -		if (config_set)
>> >> -			die(_("clean.requireForce set to true and 
> neither -i, -n, nor -f given; "
>> >> +	/* Dry run won't remove anything, so requiring force makes no 
> sense */
>> >> +	if(dry_run)
>> >> +		require_force = 0;
>> >> +
>> >> +	if (!force && !interactive) {
>> >> +		if (require_force > 0)
>> >> +			die(_("clean.requireForce set to true and 
> neither -f, nor -i given; "
>> >> +				  "refusing to clean"));
>> >> +		else if (require_force < 0)
>> >> +			die(_("clean.requireForce defaults to true 
> and neither -f, nor -i given; "
>> >>  				  "refusing to clean"));
>> >> -		else
>> >> -			die(_("clean.requireForce defaults to true 
> and neither -i, -n, nor -f given;"
>> >> -				  " refusing to clean"));
>> >>  	}
>> >>  
>> >
>> > The last two cases can be coalesced into a single case (the last one),
>> > because the difference in the messages does not bring more information
>> > to the user.
>> 
>> Did you misread the patch? There are only 2 cases here, the last (third)
>> one is marked with '-' (removed). Too easy to misread this, I'd say. New
>> code is:
>> 
>> 		if (require_force > 0)
>> 			die(_("clean.requireForce set to true and 
> neither -f, nor -i given; "
>> 				  "refusing to clean"));
>> 		else if (require_force < 0)
>> 			die(_("clean.requireForce defaults to true 
> and neither -f, nor -i given; "
>> 
>> and is basically unchanged from the original, except reference to '-n' has 
> been
>> removed. Btw, is now comma needed after -f, and isn't it better to
>> substitute ':' for ';'?
>> 
>> Thank you for review!
>> 
>> -- Sergey Organov
>> 
>> 
>
> Oh, sorry, I misinterpreted the patch. But yet, I'm not sure that
> specifying that this is the default or not is really useful. If the
> configuration was set to true, it is was a no-op. If set to false, no
> message will appear.

I'm not sure either, and as it's not the topic of this particular patch,
I'd like to delegate the decision on the issue.
