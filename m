Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70322E62D0
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757232; cv=none; b=Bm8h7056Gb7r/YfoqZgPxPqQxxvoBK76Ig4OVMS5gg4a9a3Dq6u+hHtJjew6+P6qwvd19m7mt5yKizCXG2wg5OcHSe+bVfhnpf2w8F3iiVX2q+qyGBTV3EG2L4sGDpGHiVBWzpNlx6E0Ngh+pYlaNgYq0EcyUtj/Mg6ul/tm7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757232; c=relaxed/simple;
	bh=Nc8fpfsRY3o0hTWrL2frSbgioGf955Js+bu6EdsMmY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ncxb2Hx4qUsVdKoszAIY9yd8ZlQjWIrbHZBagCE7aJ3tBtWGziLN/Ni4o7scwuz9LuOH+Jb4KDQzSVNA5nAWVhMMvJwVtvlAhcDBsyYUxDm2oEBkd+1l/oS/zjo+xgg9KREiVVTQyf9mSkyQxPRax2iRp3LGnDwoL8pbaNmGbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtSIJ/in; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtSIJ/in"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so125386b3a.2
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761757230; x=1762362030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xBD0Qf+W8PWPKX0pHlkbn18BD+lIvCK3WD+gTcFKo8=;
        b=MtSIJ/inUbdeMfk8I68e7iCcvWLNcqXoBSH23ocInNDIYjRJBjrXjpuI6Iz2ir/ZAO
         2FA1cQ4ZxcU0kDpl9YsPDyHm6Z0FWx5+BU9LYzxpJLpHvY6ii3hOBKch1V7EM/lZf5xh
         zXkmDJeciNLRfGOKx8g6Z80sF1QNOHQDtMXVuGSXawm7SyrVA4nY18f8tK+GsNyXtcf2
         M4hss8ZXi84O8zmJHZNBu9clhHDnVwenpGctyVV7Y9hnzndyuKSlKXMGH9Z4VRJ7ZWgM
         8V9A32fwFZ+7cjoa85ZnEZlTnVFmia5dgRMzjOTkEtUtZ6dBSNe2RUs6hOOywTCaXTli
         QH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757230; x=1762362030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xBD0Qf+W8PWPKX0pHlkbn18BD+lIvCK3WD+gTcFKo8=;
        b=sL6HmA+pWL0wnDxj72a2sDwDHjmEoXYUOXpHRNgn4qJpPivghpP+P2Pcr+xqJ0mJmH
         Wg1XYbD7cCVVN2ZpARfyhMKMjcmQqNdecSw7EntViUl1w6AJfBPzg6K6liN/v2dw3coK
         3X9zXypdFwTQP6qXy7gIW+a3AKt/FU6dqKj7/DY1JvITeIkGaaRmFHqvm+KrerP7DdAL
         I4ibTzODRHHMhbK+O8hOrmvc9tcyyt40bgvdM/EoTuDz8CP8oX3MwqqBp734aBEfs9TG
         o5fs7ZA7coTNRJiBTeBGYmK+gL7Cpvt1fKxasb3EZjF8q2zOP4gA1nxhFw4+yV+rWYbS
         tUtg==
X-Gm-Message-State: AOJu0YxJ2T67tZOETZ+r+oj4t7l2FB9UHUDTATrWyJn01+d+7vGNru3i
	4AbbB7pOxY/T55uUpwGUG5YGnFCcyTmhZP91VEJjTUXMshZgmmGPOimL
X-Gm-Gg: ASbGnctZq768gvyOaxOC2AESCwIw/jbWWFvLgQPApA3Bw4c98tjzlarHwlIjm3h1RIj
	YI5TbUDL3sooYCEqPzSMKglNskhC7RxjLvEQ+7KRj/QQCH6rXg1Te+Hyy/VmVd/xvbq55b40ViF
	ovDV1ExjFifyP8Dxw/xMUC3YlR0PWvAkhyysrKe/ogRXUlNJ96vEuyVKvKmyaL3tVf1I9LzQFix
	QnQy3LjoqMq23SnkhJ3f5XwKIWimGAOqPwyLTRdrZ+fQMuMheSM4e9GRb7npep0YE1fGDV3ZfKE
	tSRxERc00IDq0qbAxpy2ZwjLJG913sgpjYDi2KDwgyIS8tUUEUxSsf4w/rUUoxerf2DPkbHtfjz
	AUo3muHC7b1110i+ZOEmEOI8p8oOhYbXVgZ31T5O42MrYv/Xe1ZfcSIeYwX7HW/oS7+o3sra3jM
	QTqHURl4eTtOQG+tJGKxXbMzzFU4S+V54ILmFDR8zBY0Nb/ozHLHQYzXtAUERDjITpuJFJGB2UL
	6RYBEAvMOgkB13OTw3CGAvL82+OGRNQZurEgfk8PIk9usG6lR/ktY64t4+gbcw5VA==
X-Google-Smtp-Source: AGHT+IGoRFraWglsF4UPatICzoz53WerouRCewXG8yT050Dp2PIkVPvBLZx0qXxuurrS6n2PpZ4Prw==
X-Received: by 2002:a17:90b:3907:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-3404c41c74bmr63312a91.13.1761757228277;
        Wed, 29 Oct 2025 10:00:28 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:e197:ba89:d0f7:5538? ([2409:40e3:177:42ef:e197:ba89:d0f7:5538])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed74028fsm16270960a91.8.2025.10.29.10.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 10:00:27 -0700 (PDT)
Message-ID: <dd147777-b7d2-4271-b0ab-6d580b8f2768@gmail.com>
Date: Wed, 29 Oct 2025 22:30:21 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] replay: add replay.refAction config option
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, newren@gmail.com, gitster@pobox.com, ps@pks.im,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251028214609.10041-4-siddharthasthana31@gmail.com>
 <CAP8UFD03fx+wKwJzDG8UZz=+S8=07hG6npNnebTmBxrcXNYqGQ@mail.gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD03fx+wKwJzDG8UZz=+S8=07hG6npNnebTmBxrcXNYqGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 29/10/25 21:49, Christian Couder wrote:
> On Tue, Oct 28, 2025 at 10:46 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>
>> +static enum ref_action_mode parse_ref_action_mode(const char *mode_str, const char *source)


Hi Christian,


> Nit: it's a bit strange that it's called "ref_action_str" everywhere
> except here where it's called "mode_str". I'd prefer "ref_action"
> everywhere.


You are right - that's inconsistent naming. Looking at similar patterns 
in the
codebase like `parse_sign_mode()` in gpg-interface.c, the parameter is just
called `arg`, but for clarity I should stick with `ref_action` throughout.

The inconsistency came from trying to distinguish the string parameter from
the function name, but it just makes the code harder to follow. I will 
rename
both `mode_str` parameters to `ref_action` in the helper functions.


>
> (I understand that "mode" is related to parse_ref_action_mode() having
> "mode" in its name but it's the case for get_ref_action_mode() too.)
>
>> +test_expect_success 'replay.refAction config option' '
>> +       # Store original state
>> +       START=$(git rev-parse topic2) &&
>> +       test_when_finished "git branch -f topic2 $START" &&
>> +       test_when_finished "git config --unset replay.refAction || true" &&
> Is there something preventing test_config to be used in this test
> while it's used in other tests below?


Nothing preventing it - I was being overly cautious because this test sets
config twice in sequence, but `test_config` handles that fine. Looking at
the test-lib-functions.sh implementation, `test_config` uses 
`test_when_finished`
with `test_unconfig` which properly handles multiple config operations.

The manual approach is actually more fragile since it relies on the `|| 
true`
pattern and doesn't guarantee cleanup if the test fails early. I will 
switch
to `test_config` for consistency with the other config tests.

Both fixes are straightforward - I will send them in v6.

Thanks for the careful review and keeping the code quality high!

- Siddharth


>
>> +       # Set config to print
>> +       git config replay.refAction print &&
>> +       git replay --onto main topic1..topic2 >output &&
>> +       test_line_count = 1 output &&
>> +       test_grep "^update refs/heads/topic2 " output &&
>> +
>> +       # Reset and test update mode
>> +       git branch -f topic2 $START &&
>> +       git config replay.refAction update &&
>> +       git replay --onto main topic1..topic2 >output &&
>> +       test_must_be_empty output &&
>> +
>> +       # Verify ref was updated
>> +       git log --format=%s topic2 >actual &&
>> +       test_write_lines E D M L B A >expect &&
>> +       test_cmp expect actual
>> +'
