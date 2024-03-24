Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3247182D4
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711295149; cv=none; b=rU1qhOE79WjzR07mOwq6hWx+UCwiPmLhEYl+7mvQPMal0b/sosH1KypIe9haNlRHITAKI9FvEMtOtUEwrQX9s/bDPvUKJFQ52mfraKcNj9t1DKtjADaQ+QHztBj23g8eRhUHKIVaRDVXWPyA3sbO7QUuoRDUERVLG1fikDY6qNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711295149; c=relaxed/simple;
	bh=VAutYhKnmcHbCGcDFX7v82ijTSLWwhOYhJeiW/5ovQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHT4cPw4YkxAXZiAuk3vFlKGVHcj6Ke9ROdwDMzgMn5+Me8jzHoJofxDU4NHD/ak1yWtUY136js1ZwNrtNBNE1ySf9qQPmJL/lMb1upO3a8D0c2b5xzxSxDI0zfgBxYrwUHcdx9JEiwF5BKJmHyXkErhyBTOZXB2NiGp2yDvY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyVRTxM9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyVRTxM9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341c7c8adf3so557579f8f.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711295146; x=1711899946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s6/WF8Zb55aRG/tWcuaRNFqMV8ythzvGsPTu2FOHV0A=;
        b=fyVRTxM9evmXWgvfrxNTvMs0JT7nYnrXOO0wN4w6yhFQdIwgwEKN/4HqTlhdbn4AJK
         DHOMFFbIPBoHpmFyBadtaptmW4SB5mP6bhR3Nizi7fqmcyNrnfDDyVHqL1DnUxOxZp0u
         oLpp1UIl1li5C/UmJKDDGb7PI+mcfO2w7332touLfCoHkvHHcJnzGRWHC3gXGzkM1bgn
         JWFBT1ab60MNjdJFvJXsIJGU+mWZpwCjKuwKGhoKuDDYdL1Cu4aadcpAytuJlIKrPPgM
         99mSUL8B5Tfse5h/9QnhKMaVH3ZJii6WuCPXI+NdET79fdwvKdZwcWjwO9N7O0HC6v61
         l0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711295146; x=1711899946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6/WF8Zb55aRG/tWcuaRNFqMV8ythzvGsPTu2FOHV0A=;
        b=bD3hUtbSq6ZJ+AKuBaRVZS3PjesP4e/3+5l2vXKuJLwnK83O/2jeqS3XPMNllwdRDo
         B+/SSXPZdnw3sU30EvqwFeSCmd0a9dOxXixtg0T+Q51RoUdaetspfNNzk2WxnRfwtWuC
         w4XNBGfsyJWdRm8pkFrxr0itOrV/lJf7w8e/OTwtvhiUAg41fehDcbnOkgTSJaKQ7mEF
         +Gm4DCVgQ0qiN5wWTBvJmxeOuMJCXYbyD0J7R9vEitbfacVSIKPNOL53KZ1x5EIGKuJE
         UwOjvJUFGVZeqhIdLY8JBI6myyf+vF3WcgwFWJsQlXUpqRVx1SIoFLEoC4/tmW7sB1tR
         WLBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSxBMQYHa9jFXJQJBb5joddwueMlYXgjuNwvta0fVVUVO9rIucG8d78Jbo+MBnLmkAIU0rX4gY42373o1m4ipemmFG
X-Gm-Message-State: AOJu0YyVihaAqWo2eNYC5/R0LM3KOwWG3PowbMYagrBlqI0dwds2abVt
	3CB7oHNSJJ1n8D8/yjYr2uRGq2D+do+oA6GoUjMkUBJsgX48EOkbmZa981t8
X-Google-Smtp-Source: AGHT+IGoQyYrj5yHxI5SNH2U6f5s8IqNteOxxPWQ5Kzbly4U6hzFOq47Tq0DulNNNl93Z+BDwYYgYw==
X-Received: by 2002:a5d:5245:0:b0:33e:c593:bb08 with SMTP id k5-20020a5d5245000000b0033ec593bb08mr3054839wrc.13.1711295146158;
        Sun, 24 Mar 2024 08:45:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id w17-20020adfcd11000000b0033e786abf84sm7043382wrm.54.2024.03.24.08.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 08:45:45 -0700 (PDT)
Message-ID: <1cce271f-c3df-432b-94ff-bf7b11c6924d@gmail.com>
Date: Sun, 24 Mar 2024 15:45:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
Content-Language: en-US
To: Max Gautier <mg@max.gautier.name>, git@vger.kernel.org
Cc: =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-5-mg@max.gautier.name> <Zf636bsHs9woXRAS@framework>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Zf636bsHs9woXRAS@framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max

On 23/03/2024 11:07, Max Gautier wrote:
> On Fri, Mar 22, 2024 at 11:11:09PM +0100, Max Gautier wrote:
>>   
>> +/*
>> + * TODO: in the future (~2026 ?) remove this cleanup code
>> + */

That is rather optimistic - users only run "git maintenance start" once 
so any unit files that have been written in the past will exist well 
beyond 2026.

>> +static void systemd_delete_user_unit(char const *unit)
>> +{
>> +	char const	file_start_stale[] =	"# This file was created and is"
>> +						" maintained by Git.";
>> +	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
>> +
>> +	char *filename = xdg_config_home_for("systemd/user", unit);
>> +	int handle = open(filename, O_RDONLY);
>> +
>> +	/*
>> +	 * Check this is actually our file and we're not removing a legitimate
>> +	 * user override.
>> +	 */
>> +	if (handle == -1 && !is_missing_file_error(errno))
>> +		warning(_("failed to delete '%s'"), filename);
>> +	else {
>> +		read(handle, file_start_user, sizeof(file_start_stale) - 1);
> 
> Actually that fails -Werror because I don't check read return.
> Alternative below (on top of this one), with one question:
> Are VLA using size_t const OK ? It's folded to a constant array by gcc
> but I don't know if that causes portability problem with other platforms
> ? I can always repeat the sizeof expr if it's a problematic construct.

I think it would be easier to use strbuf_read_file() instead - it is 
only a small file so there is not really any advantage in just reading 
the first line. Something like

static int systemd_delete_user_unit(const char* unit)
{
	int ret = 0;
	struct strbuf buf = STRBUF_INIT;
	char *filename = xdg_config_home_for("systemd/user", unit);

	if (strbuf_read_file(&buf, filename, 0) < 0) {
		if (errno != ENOENT)
			ret = error_errno(_("could not read '%s'", filename));
		goto out;
	}
	if (starts_with(buf.buf,
			"# This file was created and is maintained by git.\n") &&
	    unlink(filename))
		ret = error_errno(_("could not remove '%s', filename));

out:
	free(filename);
	strbuf_release(&buf);
	return ret;
}

Best Wishes

Phillip

> -- >8 --
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 99b158e481..7fb25ea2b1 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2332,11 +2332,14 @@ static int systemd_set_units_state(int enable)
>   /*
>    * TODO: in the future (~2026 ?) remove this cleanup code
>    */
> +
>   static void systemd_delete_user_unit(char const *unit)
>   {
>   	char const	file_start_stale[] =	"# This file was created and is"
>   						" maintained by Git.";
> -	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
> +	size_t const	length = sizeof(file_start_stale);
> +	char		file_start_user[length] = {'\0'};
> +
>   
>   	char *filename = xdg_config_home_for("systemd/user", unit);
>   	int handle = open(filename, O_RDONLY);
> @@ -2348,14 +2351,14 @@ static void systemd_delete_user_unit(char const *unit)
>   	if (handle == -1 && !is_missing_file_error(errno))
>   		warning(_("failed to delete '%s'"), filename);
>   	else {
> -		read(handle, file_start_user, sizeof(file_start_stale) - 1);
> -		close(handle);
> -		if (strcmp(file_start_stale, file_start_user) == 0) {
> +		if (length - 1 == read(handle, file_start_user, length - 1) &&
> +				strcmp(file_start_stale, file_start_user) == 0) {
>   			if (unlink(filename) == 0)
>   				warning(_("deleted stale unit file '%s'"), filename);
>   			else if (!is_missing_file_error(errno))
>   				warning(_("failed to delete '%s'"), filename);
>   		}
> +		close(handle);
>   	}
>   
>   	free(filename);
> 
