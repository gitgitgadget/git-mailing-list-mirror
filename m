Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCB12C53B
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275805; cv=none; b=JmgCgMKJwk8zmvIsv7/afJxVypnk8JX6hntTEXP/UNJjry92dC6jSaRMzuOcbAgvN5+TBdyWC3xp8mjJVEC8L6WRe6kTMXFG5fitFMo9aTe1mjF9KZa3tD736BTsZQb4kJRz9VIgCMmoLfox9jCsZSz6rqFp0yQghy/422Pzx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275805; c=relaxed/simple;
	bh=uMRXEoXnfB8E6Oq877iC6Qw7g7GLuzwXfsQl/r2XUHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXGKSCS6TkBHJzB3g1Cuk2fERxhUowywJn2jn2tlrK+Y/13+KEulDlxV66lMjkc7v5xUk2vtRn1Y7XD+AJBIHt1x88INkInUq1kOVAOEcZ7Tn8bdnHPMzy5SgCA25u2VJHC0Lh4l2HZo4tfmWnYTRN8O9v7F435P34WnUFscxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuJuYwer; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuJuYwer"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4187d5f0812so10527705e9.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713275802; x=1713880602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b3jOfBwKEbyxIHvqSwh41TeCXcCwkALOpo1flmGMivw=;
        b=TuJuYweryhIeGE7m2ZYRvKZWDPWcDGcEtBl21R01ETuePlx8rgvn/SCLHp00yhCHSf
         bRdqQgxXf1a+3kSxwstq+DbJnozx4rfAo55XQXnkpOceA7csKfImq/iK0lGcScMJwHqY
         Pc0x7JKiA/MkuANCZoYSXaoc+tklfx2QgzUK6JqzqqEannWEjeTmCFY2wkn5TbaoNigc
         MXevMij/iOqEBrY5pHiQwdUODv1ZngHd2V8uSSARxpiwOfQVEQoDlzCPWETomeggDekj
         KHWNXYqCxXJ1vbZg+eSal6mYEa1HWhCsAbojIXmPsJw07fhSRw3RN+e/VRkfgm7oVpkQ
         OrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713275802; x=1713880602;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3jOfBwKEbyxIHvqSwh41TeCXcCwkALOpo1flmGMivw=;
        b=cW28DKZaFEO6kOgcbryFWU6YhxC99OVODDDnAfBgFlbSqlCLfnangsaP+YwRkuk5Nz
         +ufBxBi4MAgn8ScJ9rNlZbuA18aXCSPwfBSMGk7wJudKk5rdF88lCdz+c2rjkV4oTlFf
         CW5vrUz26grMBLPqn4ZIATpZt2tpnpB6PH0Ydjm6y3aZRCVmAobfmZfsbI3qaTHvhlYG
         X95gA+TdanopELgaoR8L6tUFYULvFZ6qKk+eikwrf8GB9pQmdfJez88pmoVYHmesk8bt
         zTdryuw4Q41BiPMdYY49CkX94rnIkUhF+2N3J8AakDKb024xI47Mz2MKC8CkuUNg/q8R
         ZPVg==
X-Gm-Message-State: AOJu0YzHEPNUavyUqsmponuIer4uxkrQQYmds//kCDagGDNIWQd0Mohn
	okmyPTw6eYa6m8+K51EevdXG1CdMBHOW0AUvU/bk1Z5MD1yLIAgG
X-Google-Smtp-Source: AGHT+IFZ2ucnCfHF3WAAPY39An/rO567AWIIlCgZU1SzVV8rrSIi1wdDPfXuHCLY4MU+XNlf5VRpnw==
X-Received: by 2002:a05:600c:a49:b0:416:7470:45ad with SMTP id c9-20020a05600c0a4900b00416747045admr9672824wmq.17.1713275801557;
        Tue, 16 Apr 2024 06:56:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id f12-20020a0560001a8c00b0034744966ff0sm10292155wry.59.2024.04.16.06.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 06:56:41 -0700 (PDT)
Message-ID: <64d4ba8e-0dfe-407c-9b32-d02f1ce40393@gmail.com>
Date: Tue, 16 Apr 2024 14:56:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: response to invalid option
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <xmqq5xwhhacm.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5xwhhacm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio

On 16/04/2024 11:26, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>> When the user introduces an invalid option, we respond with the whole
>> help text.
> 
> The verb "introduces" in the first sentence looked weird to me.
> 
>      add -p: require two steps to get help after mistyping an option
> 
>      During a "git add -p" session, if the user chooses an option
>      that is not offered, the help text for the entire available
>      choices is given.

I find this suggestion clearer as well.

> [...] 
> On the other hand, if you are truly lost and do not know what each
> of the listed choices mean, you'd type '?' anyway because that is
> one of the offered choices.  So the only change needed here is to
> make sure that '?' is the only thing that gives the help message,
> and all other unrecognised option 'x' are made to say "we do not
> know 'x'".
> 
> That flow of thought makes sort-of sense, if the choices that are
> offered are too numerous (say, around a dozen or more), but with the
> current command set, I am not sure if this change is an improvement
> (note: I did not say "I do not think that"---I simply am not sure).

The complete list of help is 15 lines long (we don't always print 
everything but if you're in the middle of staging several hunks from the 
same file we do)

   y - stage this hunk
   n - do not stage this hunk
   q - quit; do not stage this hunk or any of the remaining ones
   a - stage this hunk and all later hunks in the file
   d - do not stage this hunk or any of the later hunks in the file
   j - leave this hunk undecided, see next undecided hunk
   J - leave this hunk undecided, see next hunk
   k - leave this hunk undecided, see previous undecided hunk
   K - leave this hunk undecided, see previous hunk
   g - select a hunk to go to
   / - search for a hunk matching the given regex
   s - split the current hunk into smaller hunks
   e - manually edit the current hunk
   p - print the current hunk
   ? - print help

I find it long enough to be annoying as it means there is a significant 
distance between the prompt and the hunk text.

> If we implemented the UI this way 20 years ago in the first version,
> perhaps we would have had happily been using it since, but given
> that the way we implemented the UI 20 years ago has been used
> happily by our users without much complaint, either way must be just
> fine.
> 
> Is it worth changing it at this point?  Does it improve the end-user
> experience in any noticeable way?  I do not think I can answer these
> two questions with confident "yes".

Personally I think it would be an improvement but I suspect it is a 
matter of opinion.

Best Wishes

Phillip

>> Signed-off-by: Rubén Justo <rjusto@gmail.com>
>> ---
>>   add-patch.c                |  5 ++++-
>>   t/t3701-add-interactive.sh | 10 ++++++++++
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/add-patch.c b/add-patch.c
>> index a06dd18985..c77902fec5 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -1667,7 +1667,7 @@ static int patch_update_file(struct add_p_state *s,
>>   			}
>>   		} else if (s->answer.buf[0] == 'p') {
>>   			rendered_hunk_index = -1;
>> -		} else {
>> +		} else if (s->answer.buf[0] == '?') {
>>   			const char *p = _(help_patch_remainder), *eol = p;
>>   
>>   			color_fprintf(stdout, s->s.help_color, "%s",
>> @@ -1691,6 +1691,9 @@ static int patch_update_file(struct add_p_state *s,
>>   				color_fprintf_ln(stdout, s->s.help_color,
>>   						 "%.*s", (int)(eol - p), p);
>>   			}
>> +		} else {
>> +			err(s, _("Unknown option '%s' (use '?' for help)"),
>> +			    s->answer.buf);
>>   		}
>>   	}
>>   
>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> index bc55255b0a..b38fd5388a 100755
>> --- a/t/t3701-add-interactive.sh
>> +++ b/t/t3701-add-interactive.sh
>> @@ -61,6 +61,16 @@ test_expect_success 'setup (initial)' '
>>   	echo more >>file &&
>>   	echo lines >>file
>>   '
>> +
>> +test_expect_success 'invalid option' '
>> +	cat >expect <<-EOF &&
>> +	Unknown option ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
>> +	EOF
>> +	test_write_lines W |
>> +	git -c core.filemode=true add -p 2>actual &&
>> +	test_cmp expect actual
>> +'
>> +
>>   test_expect_success 'status works (initial)' '
>>   	git add -i </dev/null >output &&
>>   	grep "+1/-0 *+2/-0 file" output
> 
