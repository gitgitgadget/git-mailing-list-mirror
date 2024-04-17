Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B92F516
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346664; cv=none; b=B7CpMOlJrTk2xNTylykkgNEsqS4pTGUqy9m0LFe3isRoZN6Qu66NkdekkxYm+A5OFibU0VXcWyujTp0OLn72AnUWqnftZm57ENT0OZn0DDsf2GS2Ly3clvvceZ3IrqyopD2KqlLaSCucW9bQ7Cv6OYQK5RjlpYuGtTO1CHWu8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346664; c=relaxed/simple;
	bh=xirvga9utMX6afVIvNZdhyjpdhQFvOm/le5PQShuhPQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MG84Z7Smlv9ZVmjwFHtG9/P9hfQD9lhSJL9a79wK/2HgIMVSx5DKRgYlHSbdboeb6HW0TFOlOB3ap91IWkUQL2SugyRUame7sp4eBpgCKgc1W+OcozoJnm2pc3/uzSAONqd7XR3ifCceRozEwttnazozVpow1zhJdV+Txm+JCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1IK0LdG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1IK0LdG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-418c0d83e61so2811955e9.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713346661; x=1713951461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9k33gm13kFaY8fDPXul4d8HJ2OtOKhDgxPjk9fL0QE=;
        b=O1IK0LdGUqLjWumgV/Dd65k/crEvLFjN1MZYE4tKnZXis84Luo1UOJI6Svax9Jvhka
         1ZcCp1rNIi3nz6xb5IpTtH+ubgNdSIoweYk+zp81SqeI2swdQ3xt1sHiL/lVyMzymx3l
         xkNu7FqZYOTp246isyo72BaMy3BztlHF+Vez9/J7QVfjfxHV3I8/WbDW2mbAyE5uFVOz
         VppfqNH+ugsKGIbCh3p/Z1waHSe9zmQA1pW8o5FgUClHCSVZYrXBzKlRcR201EWtwCID
         jYxGlmr3TLQjC2zTP1P5rgGfXXrM1dGdupCAhd/aAAe11TBOT6jb3ExIK7CpKPIwJuiZ
         j5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713346661; x=1713951461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9k33gm13kFaY8fDPXul4d8HJ2OtOKhDgxPjk9fL0QE=;
        b=L7fWrTSVfXDAgElTyu167sLLsX0Mjgf/hkfsZD2X6GgGcwGH496aizQh6P7OZf17yV
         Sd6pikOsi2cHVlfwYnFfy/gW6XSwuoJqAX06hLt9inZI+oFfWP4b7VLyHEM32lNachKZ
         VpkDLlvjBm7CCuGify/OuNvTQxn17ODqmkEnX0rxrgqmU5I6TMu/4IGXwsFeBGD0PQPA
         aQ4dIk8wSmzNyBwVf/xIaWxCl8YaNJGq6EtpPeSL67ztcIA1p+uM7ItzMgs+N+j/8Jdu
         WCwVIGD975uCVZlMgF+Tf5aQGwTP1n6OYGqpBs8oGpeO5EQgntnF4kg+SDOrmcjhxj5e
         M4lw==
X-Forwarded-Encrypted: i=1; AJvYcCUWHOISx0m3AdM3rGInj7/4gj3bzdNn+uILH3qX00BrQ9Ya4lUMxB7IaG4EC/lUV8/A+cJMdAGk50+5yKVkMbTPQXCs
X-Gm-Message-State: AOJu0Yw4izYMyPO7rL6btTHG36Pp0kKWKNzgAZCm2O+CUI2XlV77TZaA
	SDtkHUkuSdvJUz34QIwdkQSKMbF61/2f6GySjKtsAOZZAoVEGkkq
X-Google-Smtp-Source: AGHT+IFUZAuCsftw+fl7jCpT7NLRcQuX0NUOWry11LJGmuKvmwDlf1F/NmjOXKCpKqgjg2xtwCfbsw==
X-Received: by 2002:a05:600c:3592:b0:416:2d39:bcc2 with SMTP id p18-20020a05600c359200b004162d39bcc2mr16161830wmq.29.1713346660497;
        Wed, 17 Apr 2024 02:37:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c0a0900b0041668162b45sm2046299wmp.26.2024.04.17.02.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 02:37:40 -0700 (PDT)
Message-ID: <1d0e98cb-78a4-40d0-9bfe-390a3a30aad8@gmail.com>
Date: Wed, 17 Apr 2024 10:37:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: response to invalid option
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <15f9252c-212f-43eb-84f3-6046fb2fab38@gmail.com>
 <20685fa0-815f-4cdf-95e0-7206588552b5@gmail.com>
Content-Language: en-US
In-Reply-To: <20685fa0-815f-4cdf-95e0-7206588552b5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 16/04/2024 20:24, Rubén Justo wrote:
> On Tue, Apr 16, 2024 at 10:41:32AM +0100, phillip.wood123@gmail.com wrote:
>> On 15/04/2024 20:00, Rubén Justo wrote:
>>>
>>> +		} else {
>>> +			err(s, _("Unknown option '%s' (use '?' for help)"),
>>
>> As this is an interactive program I think "Unknown key" would be clearer.
> 
> Maybe you have "interactive.singleKey" set to "true"?
> 
> Perhaps "key" refers more to the key pressed by the user.  My impression
> is that "option" have a clearer and wider audience.

I tend to associate "option" with a command-line argument, not 
interactive input to a program.

>> Something like this (which also adds coverage for '?' and 'p')
> 
> I know we don't have a test for the help.  I noticed this in my other
> series.  And I decided not to include a test for it then.  Maybe in this
> series it makes sense.
> 
> However, I would prefer to keep a test only on the new error message.

Why? This commit makes three changes
  - it stops printing the help when the user presses an unknown key
  - it starts treating '?' differently to an unknown key
  - it starts printing an error message when the user presses an unknown
    key

The test you are proposing only tests the last of these changes. We 
should be aiming to write tests that (a) verify all of the changes 
introduced by a commit (b) are likely to detect regressions to those 
changes (c) are reasonably efficient, for example if it is possible to 
test more than one key with a single "add -p" process we should do so. 
As this is an interactive program I have a strong preference for testing 
what the user sees printed to their screen, not just what happens to 
come out on stderr.

Thanks

Phillip
