Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE972BE058
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682116; cv=none; b=ked8Ml9y40BU7rzY6e4Q1EGqa1l0ke7FBFAPzb3GSzFafh6Qu1wpM8HFtBj+nSdZKphIZ4PccLwN0tEP3XnWIhW27U5RHmt4q1yyEF5TX5O6R+9oj8wt1OspNvyDs1YEknHZZUMKj/p3NWcJ1s5GEvmF7j15u63JlhXIE3dcDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682116; c=relaxed/simple;
	bh=nZ5DzkgovFQ/fCzDJqjXEYmfR+2umdaLbJk7m+ryiC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDeo+AHJDuLxub6Jvjmy18Bai9HA2QTZboviB1obcr65Bt4KssBzya9y0h2O1EdiFBi+GbierUJovmERrHaIHlTKYnss1Bn3NvHvSj1uDen3lFm5B1Slvt+mEMWNe7WUbzJ7vHZEADKg5wK9B+3D/3OjyuhZMmnIbBvG091Y45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMNQOdOZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMNQOdOZ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-780fc3b181aso4072930b3a.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682114; x=1762286914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ASPVfwl/tGIujN3f8dtoxUk2rXVMhA3bNHCV+BvAHk=;
        b=gMNQOdOZ6R2xcgPqvH1PXEzGh7hJVIwxqjN61sCfifhAgQK1WP86g3iU4L2xKJqYe7
         Om0OWn2Vh45wbxozxtW3b0XLxxO1cmj3QKLfDqSAs4nUMDcbcNXVSiVkVK6Nf1PqMpUt
         lrich+7x25+WzgTa5zKavEuPz//aWB1IFg3rsp1FpEJmLNjMyYBbI01bMo69KoDmfZrf
         //AmJW5mOPIBx/4JcIVsTTtLsn38/5WB+lqiyFBe14kloZTlg3DfWyippUO8FO6GJVm7
         50p9V6zWAqHBNjaxZWpAjBgQthOASLqEP/ePTXbTj1mFIPzF8Nzyy+HjNjSN1nHEqqX2
         nMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682114; x=1762286914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ASPVfwl/tGIujN3f8dtoxUk2rXVMhA3bNHCV+BvAHk=;
        b=beE73iPkog3kovx3z/QAFIxGqrsB50B5Pe6jdOm+L9nGkrD/xADSTnawyGI54DhBdl
         aZ6fL4X6QOwA8SwceasSXADyvjc/632NIAaLLwEgaJBEz3kbx227Kp7ELX8t7XVYxXxF
         2AAg28sXcrK/jgCqSBRpKZSvNqIBMvAJR6gK/0z1D33GncfcrlXhVymLd4wRtUWGxefJ
         D5/8ytNCdhmgUQWaJXpXAmvuXpNt82EsECRwMCuMbbH6wp5Dcv9rONvNuEbz/DiGO2GU
         DHqoWm8mRcoSlnLAYgBH/w0+SBxTSzhoGp8n6EVq14Up0M3Dw4vSisH3I+X2xdm3Ip+r
         Gnog==
X-Gm-Message-State: AOJu0Yy4g1u8wJlUrllSGZEdBb9y1LV5QGBxE/JmHNlzpVCjr4cvOmgm
	gLASfIeBq6J9yI5HO+A6iCRjKjp4nu94402eH4oc5m0ZvH9B5wOMaH+Q
X-Gm-Gg: ASbGncu0OYdKHXR9txNiUNwBeLxBQEiuNtOQCC5uoXQwq1cyItwGM9mHfTYAB197KU+
	q5mRShzlPlvsyob5RFJQfB0RGGj8sEIcF+BoXiTSH1iFqkhxAS3SsnO+Rl2ZbFJ4LqHmF/XaUEy
	pZzkNbm0HfN7nG5dbnQLARAsJ7iioVS9+kpJ6bQl+61s8QgB45Gqszc+oB0em/Tpu5wei2/B5wY
	+o/AtGV2Tu03NOXp8TxASbnOTdGZ4zSkc4FiAQB/HJr2q7qa7jowPRt3HPxCKOPMj9vvFKamla0
	Ony1JAo/kYI1YqB6KymQ2YkipHEj6Z4DgSTtmtt0Sv0H4j5zAMcUFfj4GJUoMgqPYRNUzt6ashH
	/RtGOVQ7CcXOgzmfO/t7LxfC0VH8BDW3Wx0MNBuK+CfXdcPYGTKhJCnRgDiiMnEhdySZorRKwMQ
	NdaL7/hWnhoKZTB8tty0wqj8pVzQAmNZmtziNRvblrfwOn7sR1fNKR485J5kN6acHUOkGQHJ+UH
	kNqetqJ1Fkk+BZXKTKLpekXYLFdB3eAXy0G45bLu1s7FS/ui8UWZp+PGsNRQx0=
X-Google-Smtp-Source: AGHT+IEdA+hBD0OAc4ldwIjXVcb+8hFMsO5oUyeZ/3g4oX2MCCTfVlzYFs2FoDldw65OBxhKfWhDWQ==
X-Received: by 2002:a05:6a20:2447:b0:342:1f5b:fb1e with SMTP id adf61e73a8af0-3465381dc5emr287172637.48.1761682113751;
        Tue, 28 Oct 2025 13:08:33 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414072487sm12480193b3a.52.2025.10.28.13.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:08:33 -0700 (PDT)
Message-ID: <5ba34d92-1032-43d0-806a-91e190b24524@gmail.com>
Date: Wed, 29 Oct 2025 01:38:27 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, newren@gmail.com, ps@pks.im,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-4-siddharthasthana31@gmail.com>
 <CAP8UFD3Bz+Yn4qtCrFoKcE=u-dAtK0cXON1nFMRL8n9wBSS8pg@mail.gmail.com>
 <xmqq7bwkqpua.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq7bwkqpua.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/10/25 21:00, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> It seems to me that a dedicated function could handle this a bit
>> better. Maybe something like:
>>
>> static enum ref_action_mode get_ref_action_mode(const char *ref_action_str)
>> {
>>       const char *config_value = NULL;
>>
>>       if (!strcmp(ref_action_str, "update"))
>>               return REF_ACTION_UPDATE;
>>        if (!strcmp(ref_action_str, "print"))
>>              return REF_ACTION_PRINT;
>>        if (ref_action_str)
>>              die(_("unknown --ref-action mode '%s'"), ref_action_str);
>>
>>        if (repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
>>               return REF_ACTION_UPDATE; /* default */
>>
>>        if (!strcmp(config_value, "update"))
>>               return REF_ACTION_UPDATE;
>>        if (!strcmp(config_value, "print"))
>>              return REF_ACTION_PRINT;
>>        die(_("invalid value for replay.refAction: '%s'"), config_value);
>> }
> You'd want to do "string to enum" helper function just once and call
> that helper from the above function, once for the command line option
> and again for the configuration variable.


That makes perfect sense - a single `parse_ref_action_mode()` helper 
that both
can use will eliminate the duplication, as Christian suggested.


>
> Or do so where you would add a call to the above function directly
> without your helper.  I am not convinced that "here is the command
> line option (or perhaps we got nothing); what is the desired
> setting, taking configuration also into consideration?" is
> particularly a good abstraction.  It is more common to have
> git_config() to grab replay.refAction string, and if there is a
> string value, pass the last one to "string to enum" helper and
> remember the result, then call parse_options() to further overwrite
> the result from the command line option string (which again will use
> the "string to enum" helper).  The structure that requires your helper
> function smells rather unusual.


Thanks for the guidance on the standard Git pattern. I had initially 
planned
to follow Christian's combined approach, but you are right that the 
traditional
Git pattern is more conventional. Looking at builtin/am.c and 
builtin/column.c,
I can see they follow:

1. `repo_config()` with callback before `parse_options()`
2. Command-line options naturally override config values
3. Clean separation between config reading and option parsing

I will implement it this way in v5 - using Christian's suggestion for 
the helper
functions but following the established Git config-then-parse-options 
pattern
for the overall structure.


>
>> [...]
>>
>>> +test_expect_success 'replay.refAction config option' '
>>> +       # Store original state
>>> +       START=$(git rev-parse topic2) &&
>>> +       test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
>>> +
>>> +       # Set config to print
>>> +       git config replay.refAction print &&
>>> +       git replay --onto main topic1..topic2 >output &&
>>> +       test_line_count = 1 output &&
>>> +       grep "^update refs/heads/topic2 " output &&
>> Nit: here and below, it's a bit better to use test_grep instead of
>> grep for better error reporting.
> Yes, "a bit" -> "much".


Will switch to `test_grep` throughout.

Thanks for the architectural guidance!

Thanks,
Siddharth


>
> Thanks.
