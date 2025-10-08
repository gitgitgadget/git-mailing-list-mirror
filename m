Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1E2773E3
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953928; cv=none; b=VmeFIo6yzce616/A5FqLeOqTKP62DE1xcLzGJ3jtbSXMm/I/QOe1/ZWVBpwfk0Sytv9si2uXufJheQ/fo4WzORoZnh5qDylHX4iSfRm2QKUYv3067h+sNAmc0LPr6E8PE1+idS1czCnl8jufT76pMEf/gChSKESYN7xTgtySvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953928; c=relaxed/simple;
	bh=29mlV8HdeyHUxfWAF1KMBoR6RZ6lpgjIfdUVpCyolMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyO85DRti/E53H5BhDH3A/sXMZXoqQ3HBONAAqAuflg3cko7LsMDEH/xqNQ2j649/65dtpYlbGPudJ6rtJGilX2pwUc+LfQIxenZxX0n+HgbVIQuAPAye/ndiotvlgj9MvYo33HW6UfEXamL0+QSTk0saUGJbIyevVkt+d9F0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INcUGiAx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INcUGiAx"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2681660d604so2714575ad.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759953925; x=1760558725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtWLbcydlP2d0N3TSmEBpk83YmYj0eHtvjbXTqxGy/E=;
        b=INcUGiAxnxv9MYN+WyCU0/aw5Lne5sbl7JjEXWRYPOHdLHT/cTRb4Ttwr/QZ9mZjvj
         cc3XIRnV5FW2kONMuA8msHUYRtT/X4Kdpl4RmDAfJEaEtI2lrizjRDAoZzhjGcTLbjKO
         j/Qh8San4neB6k1JYIQpRi5MclJ07ApK0Cuj78kol+gvTzSQ/5ybJAXD2jQHhPrNeLCu
         jaJoUsJOzIehJTrdcmjEF5WpqMk76+dVA/uQy63hFIpeCToVFeXMcb/a/mJAkHUyGLxZ
         478m9jQqYJIC/cM+SP86uhy+eGfpG0DD+lcggI9Tp6IU+hPa79qSakOuTbTgu8DgGhGf
         g2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953925; x=1760558725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtWLbcydlP2d0N3TSmEBpk83YmYj0eHtvjbXTqxGy/E=;
        b=M/XjFOFD5/A44sRlPXJKHVNzfy/2IWFK6msQFyx50FQ/MaNsHA+zzmWScuuWLRv+OA
         JJ9UdDwV5sNxjgmHJPzffOskiDllYeD0VGy8VcbIo35ev0NV42Bmd+YqpALctYQO+Gd1
         CPkI87ShseMhxqd6R+YMk+9TA4K8MNx4gN5NcyUCPowQcpUI4CDfbLVm6hH36pF9Q0YR
         xxZYB2ZvKR4ZfLI+0hgRIYX7RmHm38V3VgXTWbYffX5Jcw6FFRtLzaMuLLdb3PmXpi3O
         awOrvEbPwc7uFVdBroU6Kd1xSUfZ2wF7Z/QNji+M6NwpQtALvyKAdJlJelMCqzMHgski
         UCPQ==
X-Gm-Message-State: AOJu0YxM/JnBeqsRUaAJWRivBnPim22B32hMOd750QQZ2HozDG8TAHjc
	OiwtZuReZbxOi1Jy4UlojZnbVy1gkYCqsZY8sSRoaEDx0zEWPd79eeM/
X-Gm-Gg: ASbGncuobjWL3+NkN9nS8nf6BCPmuNQgt117vzQl4nrS3ISUVpATjYUAZS8+hbFkRsP
	EhbcnyK7lcGL/wOffho2x0oS2P4A8f6ihGr0d2XnJN+od7+pC1YflUMQ6ZgJenR2HOAbZvEhhyu
	8l2bk0IYrKDj+ySJeNMWr8fwWXguWbpLFn6GdXiTcyfrV4Pif4YfiyL2Eha44MczzirIcqYlzJX
	V9WaDWhK55AqNpzL2CMuZ7ZpCRgaIHaiEzeGkECashORjzazv/p6qkKDJUIuOlSsscvqWPdr95X
	fg9ouXDjKRz+jVzX05p6S6WVMzIUpogxrzdz6G2riKHCE3J40LiLHcUl1Pg9mdXTNJtxrkDefUZ
	xtYN4uKi5/rhKuMEkSEKaTMUaDH40ljoDvtIUQnMqW/j2t6K1+nyQsmrjgEUJzryUvAQRIKhtHx
	9c+Pw+k5xbWqj+3tELadHdGML8ENNa8nfl3jizvJHpq43VEJHQyWLIlLlnUxtP7576Q0FU3pBf1
	ITkk5JvlCDdXFecA9zIhzWQJDxlOGBYKw==
X-Google-Smtp-Source: AGHT+IHWUe22SdBWO5KWNS3ZaLILEvKa2i54UnqeHvgmL9HHCeITiaZJqkhLNkmHiAgCREg8PU8HHQ==
X-Received: by 2002:a17:902:d545:b0:28e:cc3a:371b with SMTP id d9443c01a7336-290272f8534mr60409545ad.57.1759953925014;
        Wed, 08 Oct 2025 13:05:25 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:dc83:454e:4cd8:e34b:b52a? ([2406:7400:56:dc83:454e:4cd8:e34b:b52a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f51b5sm1360424a91.7.2025.10.08.13.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 13:05:24 -0700 (PDT)
Message-ID: <d4ef2c70-d03f-4c89-87fb-0ef4dba1bdd0@gmail.com>
Date: Thu, 9 Oct 2025 01:35:18 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 ps@pks.im, code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
 <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
 <CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/10/25 01:18, Elijah Newren wrote:
> On Thu, Oct 2, 2025 at 4:27 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
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
>>
>> For naming, I am thinking either:
>>     - replay.updateRefs (boolean: true = update, false = output-commands)
>>     - replay.defaultOutput (string: "update" | "commands")
>>
>> The boolean feels simpler, but the string might be more extensible if we
>> add other output modes later. Which pattern feels more consistent with
>> existing Git config conventions? Looking at rebase.* they're mostly
>> boolean toggles, but am I missing a better example to follow?
> replay.updateRefs sounds better to me.  defaultOutput with "update"
> doesn't make sense to me.
>
>> You are right - I don't have a concrete use case. I was trying to
>> anticipate potential needs but ended up adding unjustified complexity.
>>
>> I will remove --allow-partial entirely from v3. This simplifies to exactly
>> two modes with clear purposes:
>>     1. Default: atomic ref updates (all-or-nothing)
>>     2. --output-commands: traditional pipeline for special cases
>>
>> Much cleaner design.
> Note that once you add a config option, you'll also need an additional
> command line flag (or make it possible to invert an existing one), so
> that users can override the config and get the default behavior.
> Maybe --[no-]update-refs would make sense after all, where
> --update-refs is the default and --no-update-refs is your current
> --output-commands?


That's a good point. With a config option, users need a way to override it.

The --[no-]update-refs pattern makes sense:
- --update-refs (default): atomic ref updates
- --no-update-refs: output commands (equivalent to --output-commands)

This is cleaner than having both --output-commands and needing a separate
--no-output-commands. And you're right about the rebase naming - it's not
really a collision since the concepts are similar enough.

Should I go with --[no-]update-refs and drop --output-commands entirely,
or keep --output-commands as an alias for --no-update-refs for clarity?


>
> (I know you all talked elsewhere in this thread about "avoiding a name
> collision" with rebase, but I don't quite see it as a collision.  When
> Stolee suggested the flag for rebase, I pointed out it's roughly what
> I'm doing in replay, so it doesn't feel like a conflict to me.  I'm
> also open to an alternative flag name if it makes sense, but we
> probably want whatever the command line flag is to be similar to the
> config name and "defaultOutput"/--default-output don't make sense as a
> name to me.)
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
> Given that it was directly adjacent to the other
> die_for_incompatible_opt2() call, if that were still the case, I could
> see making it part of the same commit.  However, dropping the
> --allow-partial flag means you don't need to add that other call
> anymore, so it makes this remaining die_for_incompataible_opt2() call
> an entirely orthogonal change to the rest of your patch.  As such, I
> think it belongs in a separate patch; it could either be a preparatory
> patch or a follow-up.


Good point. With --allow-partial gone, the die_for_incompatible_opt2()
change stands alone. I will make it a preparatory cleanup patch before the
main change.


>
>>>> @@ -407,6 +452,8 @@ int cmd_replay(int argc,
>>>>                   khint_t pos;
>>>>                   int hr;
>>>>
>>>> +               commits_processed = 1;
>>>> +
>>>>                   if (!commit->parents)
>>>>                           die(_("replaying down to root commit is not supported yet!"));
>>>>                   if (commit->parents->next)
>>>> @@ -457,9 +535,17 @@ int cmd_replay(int argc,
>>>>                   strset_clear(update_refs);
>>>>                   free(update_refs);
>>>>           }
>>>> -       ret = result.clean;
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
> Yep, dropping it makes sense to me.  Alternatively, documenting what
> happens in the case of empty ranges, as Christian suggests, also makes
> sense to me though I might suggest that it be done in an entirely
> separate series rather than just a separate patch of this series.


I will drop it from this series. Documenting the current empty range
behavior can be a separate follow-up if there's interest, but I don't
think it needs to block this change.


