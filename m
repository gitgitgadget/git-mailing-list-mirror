Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC731DDC37
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679584; cv=none; b=QFa9/6hCcRZrnZzuLjsa+564eXu/qmImb52h6IP9dt34gE136YCI09Qtd5/FePwlV7Ohrb4EuH3TdGJECCMnF2lDjDx8jzb3BEoYkNYInMyvdOINJoEYWW7cy8FVfpM3k/Hm67z7nYul7LS27Cggwt8EfTNO7/dGsnBzsA9n0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679584; c=relaxed/simple;
	bh=XIV8ArTOWORf0kG58IDeYXQyKA42fKcuf4iHd8iY3KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX5xjFoW2VoH14VLgSAfxlVaeo7EbQTjwTjlKZeerECruuCfHRiKb8fJVXuo2EJaJANkhI/i1hfiUCr/G1iyDKCO2n6w8XNnoyDvjmwJY8ZzuRiMcDbsWzNb3cWRWfg1v/tcZfYSTliQ9uSLQmHsirUIEcwrUoRf/vK3DpS6vTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iye1nZCq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iye1nZCq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5579235200so4489509a12.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761679582; x=1762284382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYzJnHAzRQAm4W3sd4d3PELiF+UePW6G26Ebi02UGDU=;
        b=iye1nZCqv/HNjV1hLAcdaFvEkSfG5K3GfaAAcaLajM6veD+Fvo/QvoKz0F1ImWy+Be
         qUTRNp7pwDuh2dQux1VPcygPYFfiUy56CQ8h8/Byh7g6O5PmNnmgxhguAdQHFEWP0bGD
         Y7IlcioEyIeGprfFT4EoFJvHyQo6nJ+zpA/J37swmc5J1K2ajTU/CVLQFh3MJRZZ0byf
         eFTCjAXJJcM5BqhKEpKmuzq0u8WvN9v95KlcdqCg56nS3jpfVAzTacHWe5zf4EMp+T0f
         rds/3Ysd6I0aSRSLYVA4P5trNRhr8cRDYZLjb3bkl/9qmwkokDXYBGCnGMoc0W+PxF91
         uNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679582; x=1762284382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYzJnHAzRQAm4W3sd4d3PELiF+UePW6G26Ebi02UGDU=;
        b=ERNMxK9U9Ko/LZbut4XkEtavVjLWV/qQCScoLAYR5VrZXO16bHNsD0dDL0mS15pvE9
         01uB5AsCu2bflMchU3qagmWpbpKXF2VqYqe20a+oiOvdSnZ2kVEAF7dEx7V9VeMjrD66
         JFJHNRyodl4lsKSk+vHl2BIj3PjoyQ6IMg4MSCLeNyqCw4pFkv3+ocr2bjUkY8TJVnZy
         CsK60QhytIH0hh/Yy94dDpy8tXKUTGYpAsR0XrKM0NM7rIvY/PNMGhnkqOjGw2Za9dia
         OIptodu7v7XtsS7quCGOX4+cpSk5k0Wu2NWxgsl4CmfDSHG/oDV+jpsyp3FlX+xx+ZJW
         HAdg==
X-Gm-Message-State: AOJu0Ywu3tmKGa4CExY+oE8u49Es6LGtyAlxqMKZvCUVFiWyR64ytrJG
	FdKSSJqDZW3JCS1DNNWgl2HDlXkACZx+gi7j/s/4wv/Zeyrc8Veo8reo
X-Gm-Gg: ASbGncsTiT6qVIecMWc4wJCmObchvT/IzlwA32QarLCW4WDuva+bc0CW82xhAAaSfoU
	+Hkog+qwW8SmXpvvji2JoFxt6WGME1dQfzICm/oNR7/t0yJBNdT2/j5F6GwxryXwFt5TlTA7ONr
	rMDTgRYKqdjfR6/vwHpx9rJHmKydvsIX7HvXoUXXXKCUuUH2jxhHHrbeqdcOD9FEioiwsp3CN7j
	1IO7HZWD9HsZa6mWqtUVaT7B8UsnphiVScUgkFwZ9FmCQsDmCGouvHsTfwSHzDeos6s3/Tkk1Ub
	+MnTvxUHmMru3fgbEb3JU7OSjp2oTKwNqEcjotlwd2xiAVo878+bUtsooYz3lVdElZrzSL/o5wI
	64fLrGVdW60ZJ9BGazBbSbKCmcFpfW/50o+WTlaXteBUR3dfJ1lwxQPeGrRkMpBRc1Y33reuMYn
	DJf7ARQhU3mID+TzM24nHNvtIQmEoIAhHzJyZkAItT1nokBYLwGXArgDc/myUZOemdt9HJgOCuH
	3wPNHa7S0oPDltzqwS/sWjhX0JYfR7i3XfOOY6bY9qJmcin0XFuONFlTDGV1u2lx7Tg6VroCg==
X-Google-Smtp-Source: AGHT+IGW40XRQAJ29VJvYgqJ8oVEjviNvM/SpvcQmccD9zLUa9mv+BQ9ivxUMebPhxKmJUvJ8uqQKA==
X-Received: by 2002:a17:902:f682:b0:294:df75:4251 with SMTP id d9443c01a7336-294df7543dbmr1143315ad.31.1761679582424;
        Tue, 28 Oct 2025 12:26:22 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm124578905ad.21.2025.10.28.12.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:26:22 -0700 (PDT)
Message-ID: <3dc2325a-9551-41a4-a747-c9c2c4aeca94@gmail.com>
Date: Wed, 29 Oct 2025 00:56:16 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
Content-Language: en-GB
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, newren@gmail.com, gitster@pobox.com, ps@pks.im,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-4-siddharthasthana31@gmail.com>
 <CAP8UFD3Bz+Yn4qtCrFoKcE=u-dAtK0cXON1nFMRL8n9wBSS8pg@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD3Bz+Yn4qtCrFoKcE=u-dAtK0cXON1nFMRL8n9wBSS8pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/10/25 16:31, Christian Couder wrote:
> On Wed, Oct 22, 2025 at 8:51 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>
>> @@ -367,7 +368,20 @@ int cmd_replay(int argc,
>>          die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>>                                    contained, "--contained");
>>
>> -       /* Default to update mode if not specified */
>> +       /* Set default mode from config if not specified on command line */
>> +       if (!ref_action_str) {
>> +               const char *config_value = NULL;
>> +               if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value)) {
>> +                       if (!strcmp(config_value, "update"))
>> +                               ref_action_str = "update";
>> +                       else if (!strcmp(config_value, "print"))
>> +                               ref_action_str = "print";
>> +                       else
>> +                               die(_("invalid value for replay.refAction: '%s'"), config_value);
>> +               }
>> +       }
>> +
>> +       /* Default to update mode if still not set */
>>          if (!ref_action_str)
>>                  ref_action_str = "update";


Hi Christian,
Thanks for the config parsing improvements!


> It seems to me that a dedicated function could handle this a bit
> better. Maybe something like:


Excellent suggestion! I will extract `parse_ref_action_mode()` and 
`get_ref_action_mode()`
helpers to centralize the string-to-enum conversion and config 
precedence logic, Much
cleaner than the current inline approach.


>
> static enum ref_action_mode get_ref_action_mode(const char *ref_action_str)
> {
>       const char *config_value = NULL;
>
>       if (!strcmp(ref_action_str, "update"))
>               return REF_ACTION_UPDATE;
>        if (!strcmp(ref_action_str, "print"))
>              return REF_ACTION_PRINT;
>        if (ref_action_str)
>              die(_("unknown --ref-action mode '%s'"), ref_action_str);
>
>        if (repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
>               return REF_ACTION_UPDATE; /* default */
>
>        if (!strcmp(config_value, "update"))
>               return REF_ACTION_UPDATE;
>        if (!strcmp(config_value, "print"))
>              return REF_ACTION_PRINT;
>        die(_("invalid value for replay.refAction: '%s'"), config_value);
> }
>
> [...]
>
>> +test_expect_success 'replay.refAction config option' '
>> +       # Store original state
>> +       START=$(git rev-parse topic2) &&
>> +       test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
>> +
>> +       # Set config to print
>> +       git config replay.refAction print &&
>> +       git replay --onto main topic1..topic2 >output &&
>> +       test_line_count = 1 output &&
>> +       grep "^update refs/heads/topic2 " output &&
> Nit: here and below, it's a bit better to use test_grep instead of
> grep for better error reporting.


Will switch to `test_grep` throughout for better error reporting.

Thanks,
Siddharth


>
> Thanks.
