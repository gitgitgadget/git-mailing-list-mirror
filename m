Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06C25F981
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740189; cv=none; b=kRYzsOT1rHmieo+vJceYFDCnRWlMZvch36hWZ3wLTNNabGNBw3oKDGaTx2dH+jLeMwXouF1SKCxEG3maX+Ceud6j76qRcOglcTcweuwOgVLaWGBMEsxols6QTai7gRzs0H86dYBxiTaIl43dc24t56eApzlwBRLSjKWRdPH7KKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740189; c=relaxed/simple;
	bh=+AGnk0XFn1ZtlO5JRc4EH5bfZ/kH5ePtxKWF+EmcFWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+d8Puyy+TuACqd8H4VinsPWPRD5u/6PG7Sa6QlFCDT2AmpHqaF81CSRHDbXx+iUNlES9R2LZIY1/hwmw+RsKJcyuZf+n/UcUpgL7VGFW/H6dFohC801a7JPQHusyg+5fx/rnNL3NOG2Rp+WQoFlSPdcfCQ9sR54CGvi/iLYxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi0/UmNY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi0/UmNY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43998deed24so18838405e9.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740740186; x=1741344986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dcyGz1xHGHkyo/9RjinoiYov4Azwu9jN/sJtJBe+Sf4=;
        b=fi0/UmNYn2aIuoVmeYn8gE2HNUobv/joTon3aIfgAxw+W+6F+BSxB+NeSv8I19AS0U
         ujgx6eKZYc6nbU2sjFg2F4YPZgBqJirr0HuX58LnX/1I1RzMt6DtCP3ShhFpu3xKmD8A
         hA3/BzzgLBYw9jHu9SrJRRlRJ0BLIab5FY9CXpZ9eLSuwecB5gRrMSBTodO1a9WAaXsd
         YhhUXRRbjrRTKkd09VeMNKuxWRkZGjE0a2IRVqAoTFmyrwwozsmGyEqruyp7FLgKMQ38
         qXf3eAZ4X+vC/W9BR4SCyL15r/VAywbtxKRlxpuHsoGzxgStHs/zmKulP8iIe5IM1mz3
         A4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740740186; x=1741344986;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcyGz1xHGHkyo/9RjinoiYov4Azwu9jN/sJtJBe+Sf4=;
        b=EM/Oe+beOlRTCzPEFwTNrcnQyi1G2LHO13H4ZoLbbCOwYkURA1nRoDzUuLskpqic0w
         0LTiSM58DYRvTGIVahWSafZipTPrK5u5DkrH6APGwtKBsP/ceyIx54pXsdomvWI/rXsE
         VQQYP7Qm8qtvwn0OjduC7h0o6JE7hmXQtp03MS9dXVwVzAnLhLApdtPUgakZDK7tGpfv
         QOn6qBSLvZueFHgZwMbKmYgeBdXtRufE6CNzpcmn7im/pNrWAAM1hRdwB4rm11JM+KOx
         k9MttBnIaEra9FO0JqGR5lfhN/wsuMP0c4zUuk268xFOaG8l4vzVdHZT5uMEjoduGJuu
         K+8g==
X-Forwarded-Encrypted: i=1; AJvYcCXj7euVMj8lEyj9bUa5PAzKAlLUzPrdU8G9AuIFgvX7MCa0NaesQoS0ytETSwgdWRaX1b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHargZhJhqOWqstgP4dAH4dirRR92LceLSCzRhU5SIOA6Bm4wo
	zv79nede7Ki29GdMjYqxfRzeVHJI59m8MWm8s9qRjN8eRh+6JTzU
X-Gm-Gg: ASbGncsx8W1JA7J7F+IAkOsb336TMNE0b885sCnhz/sk6avA5M+wJy14KZJ06CGL73b
	a9Xun6LOCSGyIin/WEvjwSiva8yEWBjFSYHLKctcjG55oGspzcXSiaHZ13lwY0gs+H+kpcT9/Bw
	8D/nByUf2v78lYCB/6U15XcxbB9U8e1ODlzlXWx1I1KBRg9QepmQMB/eZZ7vLlyZyTt2OhrEK0l
	C0wr8h34X96lumFNgVyxAN9wjl1WfSShJ1sgD2Flp7Xp/Ntfuw3u1RTpdSbtSAW7NjG1uXuBNjj
	bZjcUvfvzqP4k/1+lZ5yEU3r0CQzZ7uwnE8bTKvAQM9YeB7F5W3JVM2h7gaxNOVla3R4/5Yh8+B
	QsaXp
X-Google-Smtp-Source: AGHT+IHwP8NncKKB/rWsA1Fk52Nc+Y39g+DMR4m3t/mSou7YIDTunRKxziq2FOtebY9jLK8i033inA==
X-Received: by 2002:a05:600c:5489:b0:439:9543:9491 with SMTP id 5b1f17b1804b1-43ba676062dmr19007915e9.25.1740740185558;
        Fri, 28 Feb 2025 02:56:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e48445c5sm4821113f8f.78.2025.02.28.02.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:56:25 -0800 (PST)
Message-ID: <4e21312d-0d9a-404a-a2e0-0e2fcc681ad6@gmail.com>
Date: Fri, 28 Feb 2025 10:56:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be
 NULL
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org,
 christian.couder@gmail.com
Cc: ps@pks.im, shejialuo@gmail.com, johncai86@gmail.com,
 Junio C Hamano <gitster@pobox.com>,
 Christian Couder <chriscool@tuxfamily.org>
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Usman

On 27/02/2025 17:54, Usman Akinyemi wrote:
> The `repo` value can be NULL if a builtin command is run outside
> any repository. The current implementation of `repo_config()` will
> fail if `repo` is NULL.
> 
> If the `repo` is NULL the `repo_config()` can ignore the repository
> configuration but it should read the other configuration sources like
> the system-side configuration instead of failing.
> 
> Teach the `repo_config()` to allow `repo` to be NULL by calling the
> `read_very_early_config()` which read config but only enumerate system
> and global settings.
"
Thanks for working on this, I like the idea but looking at 
read_very_early_config() it sets "opts.ignore_cmdline = 1" which means 
that this will ignore any config options passed with "git -c key=value". 
I think it would be better to call config_with_options() with the 
appropriate options directly.

For this to work all the commands that run outside a repository would 
have to read the config via repo_config(), and take care not to call any 
of the repo_config_get_*() functions. They mostly seem to do that but 
"git for-each-repo" calls repo_config_get_string_multi() - it should be 
easy enough to convert that to a callback when that command is updated 
to stop using "the_repository"

Best Wishes

Phillip

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>   config.c | 4 ++++
>   config.h | 3 +++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/config.c b/config.c
> index 36f76fafe5..c5181fd23b 100644
> --- a/config.c
> +++ b/config.c
> @@ -2526,6 +2526,10 @@ void repo_config_clear(struct repository *repo)
>   
>   void repo_config(struct repository *repo, config_fn_t fn, void *data)
>   {
> +	if (!repo) {
> +		read_very_early_config(fn, data);
> +		return;
> +	}
>   	git_config_check_init(repo);
>   	configset_iter(repo->config, fn, data);
>   }
> diff --git a/config.h b/config.h
> index 5c730c4f89..1e5b22dfc4 100644
> --- a/config.h
> +++ b/config.h
> @@ -219,6 +219,9 @@ void read_very_early_config(config_fn_t cb, void *data);
>    * repo-specific one; by overwriting, the higher-priority repo-specific
>    * value is left at the end).
>    *
> + * In cases where the repository variable is NULL, repo_config() will
> + * call read_early_config().
> + *
>    * Unlike git_config_from_file(), this function respects includes.
>    */
>   void repo_config(struct repository *r, config_fn_t fn, void *);

