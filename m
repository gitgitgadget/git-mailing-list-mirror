Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220F284880
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367966; cv=none; b=q5mgpZAfHybxwtG7yz6vv24nAoU99nrg1eUnS6Vq5C34OQSj4uHMf1PVSyJIzE3HP2N9gJjLC3Xilwe70Y9rLEcQ5AESOEia815HqP7ACeM5142DPPgOebU5WmgYaMJbfwCSxbzFRfW1wjPMSRpWBupZjgUNZlQuVxAPzioUiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367966; c=relaxed/simple;
	bh=0rYGikj/5ZPc+HgMvcZbO1NI8L5TotIO4yfhWfkzR8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4heth9PLmAANb5Ned4edOYtOBmR0OxNHP84rOJpZXlwsU8vV1YdLVnb2z0CmEo6mIDfYZOf+ZdFMtn2bf2rIVoEH4hSwLdtcn7FYec0PyEVnhXTVEF8uy4byVcT6S/5bLIuy4xmrJ5HiFfy01C4NGXrHXP5YBrgoqAz5c8SOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAJTHvxf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAJTHvxf"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b9ab6cdf64bso558302a12.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 10:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762367964; x=1762972764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+3+4IXAUVHV3/wA+n9mZa3Lt40XbMbvgb7gyAb7Ny0=;
        b=VAJTHvxf0YFD+atx9uXWxTJD1RRvbScsX3d+AquF8p4VfRDVM7DjxuNq51UPhS9+bp
         B+E+d6cvU8zoh16Rb8QfGVXRBYLWjSGMGb4rTlaH/E9WszdqK3AflT1Ty4xCtsZ80IFd
         qt/apu8h3VVXRTawKIQlUyf5+gmVKOF2P7wNsQXf+B3R7TZn6rdz7YICNKS3eXvIOiE2
         qRlpW/RGwT6Err4oV/Oz0RIzwUna490NWOCRUuFPyVBoZbjnWxhn8I6YTrLxo2xUy7Ns
         cZ66FQGRz22qEvAMcqDsYm+bsYVPg6NdqhdiBCIxGPU2T0zjmfRkxrOvA9mli5jXmVbv
         zxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367964; x=1762972764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+3+4IXAUVHV3/wA+n9mZa3Lt40XbMbvgb7gyAb7Ny0=;
        b=GLPorjA8C512rH7xhKUZM3P5jC6NwuMoFqCJ8kk6QH9gqCsfwp1LenTUq5bJBmuOPn
         Ty4S2TmnK2vyOIzVfqbz9dCByajZsbZ89y4vVfsecLQa+enzDPyGppLDN64xEenQCMK9
         ASkYG8eX7KgdVNwExsRH8yw2ymaIt0LROgfrzMpFeq5y7qT4kF0DXU8GbAlTdmUuni2y
         mPYrS9R4E0keDUcDZflOfj444Oaq4xIA8uYy+ZZJAtsPSHkVBzSX25n4cEGWFKawYBu9
         /SZc+//X/z4PNogqlyYxVmRH1zNJu9L3+5Asn8p5YGcg7/DdeBNqS2e/5htE4/w/up+K
         fmtg==
X-Gm-Message-State: AOJu0YxBnfMneAiYTj2A6seAo5iMKU/lHRccwq+IY/rLXFy87NHnRA+G
	R0l25YTBd+aqb8fPSDQ+Ht/5awlcIQd9RrS0TfhvnNdoX+GKf3dVgzvl
X-Gm-Gg: ASbGncsEKHkPgwYDoS0VMwq3JXwMx0SSVXN3d5o0gyaoLUwsu6VQkzz9oMOj1eq9GTk
	ZyLUPBY0egLNySGnWAoR6hT5PSY6pC6Cj7Wm0pc6PlNysMnlxr3MSTC2RJ/qflM3vycw0sdaxQT
	zFAzfdHQhocOe6ODwr6XXKh6koPQXrzCTXTpCUEjuW0mxJ9PupuUSxJDr9RqaWOrvktKCU9Xxz9
	OyMdt/3ZW9FKTYvCdoLzW2ExKOq+hGq396sccIu0FLm7c2FkdIcQw+IpTj0pZR0kavYelUqvkj8
	MVoh24y5e6nFXaKaS6/xROXaEPd6uDI3MEK+x3Sf55w0J1KOTPe8KZzUfkXXjIb7P4bDAhhhg1F
	No+hOIY/eQi0xp0InQI8LXmdKxB3zHVLdwwgIIghKLTe4IXrk0nNj/K+Yryvd5jpu3P4xf052q8
	xN4ylmiPSbck4/2SJjUqGxPhr/W1GI3fAY3K8JZ5iYb27mIMgSRAliv2lE5NJKBugm+oEbbRD86
	9a92ErXPcoXZyBQq/OVZHrTx8kKho+0I0BoGjUn/6j9XLWWnyooYhUlzifQ5zBUwg==
X-Google-Smtp-Source: AGHT+IFI5fd5YkJB0Sv+KSYGHdaJ2WRBBFxlqF0JfKlk3n9XjX54IACBQCCKTMht+MBnV21ve+OV3g==
X-Received: by 2002:a05:6a20:7f86:b0:263:57a:bb46 with SMTP id adf61e73a8af0-350ddf1545amr571000637.13.1762367963820;
        Wed, 05 Nov 2025 10:39:23 -0800 (PST)
Received: from ?IPV6:2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5? ([2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm25798a12.26.2025.11.05.10.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 10:39:23 -0800 (PST)
Message-ID: <a030b02e-7ef2-44ef-9793-7b8db3abb7c3@gmail.com>
Date: Thu, 6 Nov 2025 00:09:17 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] replay: use die_for_incompatible_opt2() for option
 validation
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, gitster@pobox.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-2-siddharthasthana31@gmail.com>
 <CABPp-BHyUFpFEK1YXSYQWEXSAa2fnUTsH9nsf=LgPs=GNQG2RQ@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BHyUFpFEK1YXSYQWEXSAa2fnUTsH9nsf=LgPs=GNQG2RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01/11/25 00:17, Elijah Newren wrote:
> On Thu, Oct 30, 2025 at 12:19 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> In preparation for adding the --ref-action option, convert option
>> validation to use die_for_incompatible_opt2(). This helper provides
>> standardized error messages for mutually exclusive options.
>>
>> The following commit introduces --ref-action which will be incompatible
>> with certain other options. Using die_for_incompatible_opt2() now means
>> that commit can cleanly add its validation using the same pattern,
>> keeping the validation logic consistent and maintainable.
>>
>> This also aligns git-replay's option handling with how other Git commands
>> manage option conflicts, using the established die_for_incompatible_opt*()
>> helper family.
>>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>   builtin/replay.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 6172c8aacc..b64fc72063 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -330,9 +330,9 @@ int cmd_replay(int argc,
>>                  usage_with_options(replay_usage, replay_options);
>>          }
>>
>> -       if (advance_name_opt && contained)
>> -               die(_("options '%s' and '%s' cannot be used together"),
>> -                   "--advance", "--contained");
>> +       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>> +                                 contained, "--contained");
>> +
>>          advance_name = xstrdup_or_null(advance_name_opt);
>>
>>          repo_init_revisions(repo, &revs, prefix);
>> --
>> 2.51.0


Hi Elijah,


> Thanks for splitting this one out; looks good.


Thanks for confirming! I'm glad the preparatory refactoring in its own 
commit makes the series easier to review.

Siddharth

