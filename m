Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F892750E6
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953587; cv=none; b=aCwXRfvLifN60pOUPOA/Qe2ToV+YphZF8JCQdxlkzwP48cAB1z2tlhfBfvaF4yET3vlJm1PA5esRNgXUwzKd393ax3KXxwmbQUEYosNvllhvw5+eNh3i+vM+ZrUv6ETitHfS4IPXmEkFpnvVrhiba3p9ijw7A/sfx/0/XHEK14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953587; c=relaxed/simple;
	bh=A/tUJmO2QDJCuHYglpJ24G88UUqDWuEZ1eY+Y1mxNpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nToonyx7ZczxUvHqobXxadWBoBsuesZvQIcbQZmK608sQfEYpxPA0ejvrtIu4cqFqoQZhZddJ8drqm+5pVl05F13S4BLj7VGrDUjaIL3ESU5k9l8fbTtrb4l839Bla5sEk6BKxic7rdiNSPJ8b+6+DXxA4iLzOjYZRg6dSj+54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUhKsxgd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUhKsxgd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so240794a91.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759953585; x=1760558385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+Slx5AQKjtdgdxM/hAxKkqI5HbzR3UvpBtp5gMVHkU=;
        b=GUhKsxgdixhEzu1IIg18iuFX5C1L2gPexQbqX0aHSv4j2U/1vpbet1Q+NGqm41txMx
         1II+dtk/9HJGsOKyxlBRWxxO20qk643ONZVL6qa5G0W7i8BwMHwh2la1afpWv6dXUclI
         3M55xc/SyET6/aZa/ab2ybNUaRepHSVhT04hrnBIr/yGHoSkFFBEM8ovXDxLCLilLz6f
         sb5fPYYXJxpCQjarfkZiCuYPaNiLkQqsI+NU6wSVQ1E5uz6RYtOmkR16FLpN04nr650x
         VFKRFUujNuE6Ek4AdmsB90y2VQdo6YEPYbod9x21T6Wt4r0NxY47QvZx3xc6exoADJQL
         qoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953585; x=1760558385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+Slx5AQKjtdgdxM/hAxKkqI5HbzR3UvpBtp5gMVHkU=;
        b=VWAQ1P/mV+ojuo79QbCTw9oJp9WodVnUiZ6lqLm9a/Y9GfFQT4p8q2A6TaQcp6bsk3
         DNzps9KoOQeE/q3o19f3PdM/WLjS5Xhym5UYkJJkiqWM2LAy5NfsShOYtXHNTIJ314my
         PkU755Dhci4GI/lNe8+HOYvwtFZCRBQ2y4Suw2T1DAHmjWoKdhGL2t7M6NL74Np8UUlX
         JQyIJvy1SEQFrYiT327ByHTyQ1ENZQw8qveYD3O02VXItUTjkIrRSHgJWEkoblrFgLz8
         jrWVbirB8MyP/CzzHnRUUczkXQZbK9Gxuk7liUQGgX3+xc/1O7yECmT82YQHcl5/papT
         6NzA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8xUKYhutiOG3o0K3/AoknkPiu+PgKh1Mx7HjK3ZA5HWryyrx7Wb5wp8jC1RBmCRAXdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmBSFlJqZRlxRxVsAG6HEOb0EtRM1Q7PqZNKG6myqjwo5VQcc
	1G4oZ/hxlirG6Y/ifp0eC+eIf06RBYVJT5AANmc7Ov/y/xU6hOXKskgT
X-Gm-Gg: ASbGnctqpM0wLf1mc7zolbOpDgHakzfEeZE8PLeB/TTuvR+ALRQlYfUhx+/nsGLC2c6
	jEd8LsQIX12K3VFngDgh84wVVLkoh2/Lp5/6+8wAM3mHqq/Kh3KNc+gW4kC9RsxMfPUZqtqGpwo
	Cj+qqwo8T0M/5mOKrCdFENcffSZq8ZcD9rGV8MOMwsfGpAdEPG3dG3PJ3J92BDNC5m4Jbk95cBx
	DEWvc4W3Swj+/TgeaVnhnhNM6FbO5E1MvYA3CZCRggoR5AjoH2gCgFcuA4Xda2I56VqG/b7p4sv
	PFVNM1KoE11IWsLwUTQuNR9lXXUvfTHNqlzgs6po6JtYVq81vpc+VQcUvD5OmRGmXsq2wzULn49
	UU3/YC3nTDufGTQnYKbd1J26o7cnyiQlh6mVQwO/uoFx/hEytdwWVpAnFqaPQETJqTTe569P0PP
	AJqt2AvFnzQSVmJn2PAEu6TBYmMnySeiWpY+8MFKgekCmlid19I6SSJLhJLSjsyWfC916WeiSB/
	8tKOUdFKfuuXHeUtTkhUI05ZybYP5LYGw==
X-Google-Smtp-Source: AGHT+IGSHNOele2Nq8aU9qI4yUwbyPphgCkhnHK74YodmS2OqdCk82WjyYAxQQkAYQt0gICOKEjPYA==
X-Received: by 2002:a17:90b:1809:b0:335:2934:e217 with SMTP id 98e67ed59e1d1-33b511150f4mr6069468a91.10.1759953584960;
        Wed, 08 Oct 2025 12:59:44 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:dc83:454e:4cd8:e34b:b52a? ([2406:7400:56:dc83:454e:4cd8:e34b:b52a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51113776sm4389621a91.14.2025.10.08.12.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 12:59:44 -0700 (PDT)
Message-ID: <b3369f52-5391-4b00-8051-57617f998734@gmail.com>
Date: Thu, 9 Oct 2025 01:29:38 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
To: Christian Couder <christian.couder@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im, code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
 <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
 <CAP8UFD1JBeGxV65DFCs9dSkYwMpSBhWCZoj6dXCwmKgZnR_=KA@mail.gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD1JBeGxV65DFCs9dSkYwMpSBhWCZoj6dXCwmKgZnR_=KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/10/25 13:29, Christian Couder wrote:
> On Fri, Oct 3, 2025 at 1:27 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>
>>>> For users needing the traditional pipeline workflow, --output-commands
>>>> preserves the original behavior:
>>>>
>>>>       git replay --output-commands --onto main topic1..topic2 | git update-ref --stdin
>>> This is good.  Did you also add a config option so that someone can
>>> just set that option once and use the old behavior?  (as per the
>>> suggestion at https://lore.kernel.org/git/xmqq5xdrvand.fsf@gitster.g/
>>> ?)
>>
>> I didn't, but I should have. I will add a config option for v3.
> You don't need to add that configuration option in the main patch. I
> would suggest adding it in a separate patch after the main one (which
> changes the default behavior of the command).
>
> Note that in the commit message of the main patch, it's nice to say
> that a following commit will add a configuration option for users who
> prefer the previous default behavior.
>
>> For naming, I am thinking either:
>>     - replay.updateRefs (boolean: true = update, false = output-commands)
>>     - replay.defaultOutput (string: "update" | "commands")
> If the command line option is called `--output-commands` then I would
> suggest naming it "replay.outputCommands" and making it a boolean.


That makes sense - replay.outputCommands matches the command line option
name directly. Much clearer than my replay.defaultOutput idea.

So the pattern would be:
- replay.outputCommands = false (default): atomic ref updates
- replay.outputCommands = true: traditional pipeline output

I will implement this in a separate patch after the main one, as you 
suggested.


>
>>>> @@ -330,9 +361,12 @@ int cmd_replay(int argc,
>>>>                   usage_with_options(replay_usage, replay_options);
>>>>           }
>>>>
>>>> -       if (advance_name_opt && contained)
>>>> -               die(_("options '%s' and '%s' cannot be used together"),
>>>> -                   "--advance", "--contained");
>>>> +       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>>>> +                                 contained, "--contained");
>>> Broken indentation.  Also, should this have been done as a preparatory
>>> cleanup patch?
>>
>> Good catches. I will fix the indentation.
>>
>> On making it a preparatory patch: should I split it out as a separate
>> cleanup commit, or is it minor enough to fold into the main change? I am
>> leaning toward folding it in since it's directly related to the option
>> handling changes
> If there is only this additional small cleanup change in the main
> commit, and this small cleanup change is clearly mentioned in the
> commit message as a "while at it small cleanup change", I think it's
> OK.


Got it. Since it's just the one die_for_incompatible_opt2() change and
it's directly related to option handling, I will fold it into the main 
patch
with a "while at it" note in the commit message.


>
> If you find out that other additional small cleanup changes would be
> nice too, then they should definitely all go into a preparatory patch
> before the main patch.
>
>
>>>> +
>>>> +       /* Handle empty ranges: if no commits were processed, treat as success */
>>>> +       if (!commits_processed)
>>>> +               ret = 1; /* Success - no commits to replay is not an error */
>>>> +       else
>>>> +               ret = result.clean;
>>> The change to treat empty ranges as success is an orthogonal change
>>> that I think at a minimum belongs in a separate patch.  Out of
>>> curiosity, how did you discover the exit status with an empty commit
>>> range?  Why does someone specify such a range, and what form or forms
>>> might it come in?  And is merely returning a successful result enough,
>>> or is there more that needs to be done for correctness?
>>
>> I was thinking about automated scripts that compute ranges dynamically -
>> they might generate A..B where it turns out A==B, and treating that as
>> "no work needed, success" seemed reasonable for scripting.
>>
>> But you raise a good point: A..A seems like obvious user error (why would
>> anyone do that intentionally?), and B..A where B contains A is likely a
>> mistake that maybe should error rather than silently succeed.
>>
>> I am inclined to drop it entirely from this series. If there's real demand
>> for specific empty-range handling, we can add it later with proper
>> discussion of the actual use cases. Does that sound reasonable?
> Yeah, I think dropping it from this series is fine.


Thanks Christian. I will drop the empty range handling from this series.

On documenting the current behavior for empty ranges: should that go in
this series or separately? If the current behavior is just "returns
failure for empty ranges", maybe a simple doc note is enough. But if we
want to discuss what the behavior *should* be, that probably deserves its
own focused series.

What do you think?


>
> What happens in those cases should be documented if it isn't already
> though. Those documentation changes should probably be in a separate
> patch.
>
> Thanks.
