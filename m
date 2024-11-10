Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC6224FD
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275195; cv=none; b=A/pAUS90G45rLjmLUXsPGt1uiaa1lRSQZG5CW15AVS++dmWITG1gisTc3pJMNdpuflHMu8ywyTg4zNeK4FPoj3P/bu9joVnUbEjv6dY569wt7LVbwFySagvNrXWL0W9U6OQxeKcs4Ick0wJEqsN/dIj/1glWmttV9BXBWeME+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275195; c=relaxed/simple;
	bh=Rxd2JMigCojptqNlARpzK+ET04LmdrF1l+NATlAXTlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hw7oaiwlc6oJ5exJlW5I85BTR+FX79ZmP7U1qI8vUUZ9sXloV5lTRB/8s+9zq7YcVz3nCaaMGYI3+jxPufaVNELqNt6K0aUMglZSzdxpAoCzTCeRMkHEmPQp2Jd63QPssiQngxfHw9AdX+R0IuXCZ2XJsYAkX/BspXVmTJjPGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDvmzQ67; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDvmzQ67"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso49987085e9.0
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731275192; x=1731879992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYXhnnBbAWBRNE4uBBnIjhgGT4npE8mg7ZSUV0DwX6U=;
        b=cDvmzQ67ql7jj2xD9z3TCUJBRr7ER8DjwAoohrEmNAR3nasHNmJxhPETbljpdyw6af
         YL+C/PKew00oaPc4lZwAohe1CeDpH51Qz/bT6gJPq/6amwZmirZLzHy/Pte44oaFA0lO
         dtaSwvhcv5dsKTnvJ9uo0sKj+BopMuIIbZWRNOh7WlYoysUKibnmFCJv5jOpCoDcelHe
         LtuNk7dLLN4Btc0HMccEPYihgi2iIdkV5HqwnFIyhXPjJ4SwKeup79bCi9GWtBeWeyiq
         x4cK6vedEkjylEqe9U7pScwCBXmS835x4wg7NhuiBkxgS5VHdPdx4N9SnDRcXEIfz3uR
         +jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731275192; x=1731879992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYXhnnBbAWBRNE4uBBnIjhgGT4npE8mg7ZSUV0DwX6U=;
        b=LFzLQJ2+GmafQ6IYeNvVDRvOJGk4i57HlmfhKLoNd7aFAsOhjHMmmLo5eGaT/zLmzT
         gjY1vqKaxE64adP/ASUYLq1sbC9FtudJy47sAScC8ulEt6zaHgESvM1HLGIc8rCsDMK1
         2mFdtVZRGC35aMsG9QxXd4xunKHW68m5yKVjn/Fpu64VKDmxuKG4OxUBcrzZUdEWsnyX
         IEHobO05BewaYEIa6h9uHmhczYigtNB3Lh4UAgniIjPVL6Ln9S7UJrubpHoT7iWSMKR2
         6f8s6FV9N8EUaXbIekMhjnh9xdSRxetJRYpdhCy07ewnR/cYS6XUw0CIUkhVzA2fGYD4
         +Zdg==
X-Forwarded-Encrypted: i=1; AJvYcCVLI1G58kXDwqB4v2YUJ6OdDp5glnX31P2TMN3qKV6ySazagaiPbxsClScpKWIU29YmCLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tQYMWHJFwfozWpVJItJAcDVUf/KqDLGvq5NY+ZzZ6eBeeDei
	b8OM+sXuuQdr2RLhJG2sQRq3URRS0KzwQ3JO75v9Tpz/vOs9W7MdYDBMsQ==
X-Google-Smtp-Source: AGHT+IFP8U0afMrGqKu/Ajkvb0u8wZQPGu+zs12slh5NqdcvZQ/m5SM1pjiJWOHg2lBqk+Nt7tlymA==
X-Received: by 2002:a05:600c:458e:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-432b74fed94mr105305775e9.6.1731275191599;
        Sun, 10 Nov 2024 13:46:31 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e4d2sm11332354f8f.32.2024.11.10.13.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:46:31 -0800 (PST)
Message-ID: <c376f2ef-fc43-4815-8e26-f13da3729ed1@gmail.com>
Date: Sun, 10 Nov 2024 22:46:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/26] help: fix leaking `struct cmdnames`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
 <2fb012662d6c5720be1fe86973640c7a2d6f5681.1730901926.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <2fb012662d6c5720be1fe86973640c7a2d6f5681.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:11:03PM +0100, Patrick Steinhardt wrote:
> We're populating multiple `struct cmdnames`, but don't ever free them.
> Create a common exit path where we do so.
> 
> Note that this also requires us to use `FREE_AND_NULL()` when freeing
> `cmdnames::names`, as we may otherwise try to free it multiple times.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  help.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/help.c b/help.c
> index 8794f81db9b..51adc530d7a 100644
> --- a/help.c
> +++ b/help.c
> @@ -169,7 +169,7 @@ void cmdnames_release(struct cmdnames *cmds)
>  	int i;
>  	for (i = 0; i < cmds->cnt; ++i)
>  		free(cmds->names[i]);
> -	free(cmds->names);
> +	FREE_AND_NULL(cmds->names);
>  	cmds->cnt = 0;
>  	cmds->alloc = 0;
>  }
> @@ -619,6 +619,7 @@ const char *help_unknown_cmd(const char *cmd)
>  	struct cmdnames main_cmds = { 0 };
>  	struct cmdnames other_cmds = { 0 };
>  	struct cmdname_help *common_cmds;
> +	const char *assumed = NULL;
>  
>  	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
>  
> @@ -630,7 +631,7 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
>  		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
> -		exit(1);
> +		goto out;

We haven't set a value for `assumed` at this point, so it's NULL, and in the
new exit path we `exit(1)` when `assumed` is NULL.  OK.

However, I think we don't need this change.  And keeping the `exit(1)` close to
the error message seems like a good idea.  Perhaps, in another series, we could
change it to `die()`.

>  	}
>  
>  	load_command_list("git-", &main_cmds, &other_cmds);
> @@ -695,7 +696,7 @@ const char *help_unknown_cmd(const char *cmd)
>  			; /* still counting */
>  	}
>  	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
> -		const char *assumed = main_cmds.names[0]->name;
> +		assumed = main_cmds.names[0]->name;
>  		main_cmds.names[0] = NULL;
>  		cmdnames_release(&main_cmds);
>  		fprintf_ln(stderr,
> @@ -714,8 +715,10 @@ const char *help_unknown_cmd(const char *cmd)
>  			answer = git_prompt(msg.buf, PROMPT_ECHO);
>  			strbuf_release(&msg);
>  			if (!(starts_with(answer, "y") ||
> -			      starts_with(answer, "Y")))
> -				exit(1);
> +			      starts_with(answer, "Y"))) {
> +				assumed = NULL;
> +				goto out;
> +			}

OK.  But, as above, I don't think we need to change this either.

>  		} else {
>  			fprintf_ln(stderr,
>  				   _("Continuing in %0.1f seconds, "
> @@ -723,7 +726,8 @@ const char *help_unknown_cmd(const char *cmd)
>  				   (float)cfg.autocorrect/10.0, assumed);
>  			sleep_millisec(cfg.autocorrect * 100);
>  		}
> -		return assumed;
> +
> +		goto out;

OK.

>  	}
>  
>  	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
> @@ -738,7 +742,13 @@ const char *help_unknown_cmd(const char *cmd)
>  			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
>  	}
>  
> -	exit(1);
> +out:
> +	cmdnames_release(&cfg.aliases);
> +	cmdnames_release(&main_cmds);
> +	cmdnames_release(&other_cmds);
> +	if (!assumed)
> +		exit(1);
> +	return assumed;

OK.

>  }
>  
>  void get_version_info(struct strbuf *buf, int show_build_options)
> -- 
> 2.47.0.229.g8f8d6eee53.dirty
> 
