Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE61BDA9B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939520; cv=none; b=Jb4SMmAStmvNyfAD6hk3pc6HkdCY1HND3i9O7TzdANLLClB5ndr3Hgtm6zyVcecr20BJNX0EgkcwzGaBHdB+1g9WDl4yDSJsDLMGrKh0T1RF+NHKEcosijgtvT1d9BDx5x/wpUfrKxfPje4CrFhscyzl6eBkR+Nydl2SQLu/wIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939520; c=relaxed/simple;
	bh=uHL9AWqwxqy7eOJgiC4Xf+HSscjNQMuXrOp+k7BFBe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enf5Irq8n0w8Qk1MVorHfQfcPJhdCw3VCy8/I9XFU5OqwyJmfbZlvnAhfKcLrW+rSUc65ymqzqdDHYakVy6bamyDgdDzW0LdU0j2LzlQSbQV1y9BKqLzFV3zSaq4Hl5C8LZ3aqM06tLPzqmS8hJatMCPkGBbDiGCcD6Bqve6KbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhJzuTtE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhJzuTtE"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f0277daa5so555901e87.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722939517; x=1723544317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oGQ9FYCnbm3cnXefH9ON8ZZr5mbg29c0mQScccba8g=;
        b=NhJzuTtEkrDLtrCsKxjOKvDlO+Z3fvni5xWkR19VRr3S4ig/J/pR0ak04DtwbOUUN/
         c4D3uEaKNDDpDQvVm4k3eBDWXo9+wcXQzxDMeAjOWDVfM9DnsJQxDLEwymLa/Nk5Q1/n
         0gTuJ0WR0dELu89G03oR4GL7wfPqBpoG4sVySMmRGglNFxPz4Q/CKVmMAFY/Hk2UDUoP
         ACZZu0apgZTgBzVB7j40dMVOhNZm51t5LKx0B74zYX71XPrR1lubobhwPxFMtWNg6ZoO
         ro9cDbGgUbFyMM2z3+X9sB8BQpB7v41QaZZXPwZMaR0Q7wObVPQ0GtCBZGyJETP1HmGf
         AqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722939517; x=1723544317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oGQ9FYCnbm3cnXefH9ON8ZZr5mbg29c0mQScccba8g=;
        b=QFmq/8F2Qu7RJBbk6PLE/i4dARzZhlVWLUWA/uIh/Er1Y2ujF8CYH5E2cTxiGdmiDJ
         cFHfnbNktpk8LZf6KGrtErm2jnU43oQhwwZzO2cw9qluJjUXGRTC09o4PaEhkTogKARl
         F86GDLA0jihIhnWcBpIXejGSM90vzQm71X5LTaUlfTJ4xL3taW9gZgAkDjpJXJy4UEti
         bHCCyrwmGiGsdPdacsr57I9tH6Uv1Ks9/aXDrSd1WJeWgTN+pwybVqYsTpzuYAGTFCIu
         nJr8FtC92zQMVEEMQPAa1IBF8i2bWWwg7DduYDNiv75ZQ6jWb5LdIkuH3P3gRtwdX81c
         2Jww==
X-Gm-Message-State: AOJu0YwJAl+8noSA6CQ3Z9QXTZIp2O69oKrIakg27yJ3aH814EjcUOYT
	m6jbLeezLS72B3764Y6u8497N0DwkgvPOdompIXKNQMsfRxh9U6oJPm/P1L/
X-Google-Smtp-Source: AGHT+IFNbGdz6ll5kGRof6ySrt5Qsz3kqYxtNu5K67jtstwva2vPwRDNNE4Q9pb4KHhgMi6MCkhT0w==
X-Received: by 2002:a05:600c:1987:b0:426:6773:17 with SMTP id 5b1f17b1804b1-428e6b7cb47mr97698395e9.30.1722939033216;
        Tue, 06 Aug 2024 03:10:33 -0700 (PDT)
Received: from [192.168.1.6] ([197.40.163.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9e924sm170913005e9.48.2024.08.06.03.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 03:10:33 -0700 (PDT)
Message-ID: <207c4f3c-c444-4405-bed7-34186efa1144@gmail.com>
Date: Tue, 6 Aug 2024 13:10:32 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] [Newcomer] t7004: Use single quotes instead of
 double quotes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
References: <20240805235917.190699-1-abdobngad@gmail.com>
 <20240805235917.190699-9-abdobngad@gmail.com>
 <CAPig+cSzq+6bua=T7w0M-+7+2zbzfD6ihXLkWfondZ8NbqUG4A@mail.gmail.com>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <CAPig+cSzq+6bua=T7w0M-+7+2zbzfD6ihXLkWfondZ8NbqUG4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/6/24 06:02, Eric Sunshine wrote:
> On Mon, Aug 5, 2024 at 8:00 PM AbdAlRahman Gad <abdobngad@gmail.com> wrote:
>> Some test bodies and test description are surrounded with double
>> quotes instead of single quotes, violating our coding style.
>>
>> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
>> ---
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> @@ -1585,7 +1585,7 @@ test_expect_success 'creating third commit without tag' '
>> -test_expect_success 'checking that first commit is in all tags (hash)' "
>> +test_expect_success 'checking that first commit is in all tags (hash)' '
>>          hash3=$(git rev-parse HEAD) &&
>>          ...
>>          git tag -l --contains $hash1 v* >actual &&
>>          test_cmp expected actual
>> -"
>> +'
> 
> We need to exercise a bit of caution when making this sort of change
> because a "..." string differs from a '...' string in shell. For
> instance, in a "..." string, interpolation occurs as the string is
> scanned by the shell, whereas a '...' string is taken as a literal.
> Thus, in the above, when it was using a double-quoted string,
> expressions such as `$(git rev-parse HEAD)` and `$hash1` were being
> evaluated and interpolated into the string _before_ the
> test_expect_success() function is even called. On the other hand, with
> a single-quoted string, those expression do not get evaluated when the
> string is scanned, thus remain as-is when passed to
> test_expect_success() as an argument, and they are evaluated only
> later when test_expect_success() invokes `eval` on that argument.
> Depending upon the situation, this difference in evaluation context
> may have a significant impact.
> 
> As a practical example, consider a test with a body like this:
> 
>      echo nothing >nothing &&
>      git add nothing &&
>      git commit -m nothing &&
>      hash=$(git rev-parse HEAD) &&
>      ...
> 
> If this body is inside a double-quoted string, then `$(git rev-parse
> HEAD)` will be evaluated and its value assigned to `hash` _before_
> test_expect_success() is called, thus also before the `git commit`
> command inside the test body (which is almost certainly not what the
> author intended). On the other hand, inside a single-quoted string,
> `$(git rev-parse HEAD)` will be evaluated only once
> test_expect_success() runs the test body, meaning `$(git rev-parse
> HEAD)` will correctly be evaluated _after_ `git commit`. Hence, `hash`
> will have a different value depending upon whether single- or
> double-quotes are used.
> 
> Having said all that, in this case, you seem to have lucked out and
> nothing broke by changing the double-quotes to single-quotes around
> the test bodies.
> 
> However...
> 
>> @@ -1800,16 +1800,16 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
>>   for option in --contains --with --no-contains --without --merged --no-merged --points-at
>>   do
>> -       test_expect_success "mixing incompatible modes with $option is forbidden" "
>> +       test_expect_success 'mixing incompatible modes with $option is forbidden' '
>>                  test_must_fail git tag -d $option HEAD &&
>>                  test_must_fail git tag -d $option HEAD some-tag &&
>>                  test_must_fail git tag -v $option HEAD
>> -       "
>> -       test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
>> +       '
>> +       test_expect_success 'Doing "git tag --list-like $option <commit> <pattern> is permitted' '
>>                  git tag -n $option HEAD HEAD &&
>>                  git tag $option HEAD HEAD &&
>>                  git tag $option
>> -       "
>> +       '
>>   done
> 
> ... changing the double-quotes to single-quotes for the test _titles_
> in these instances is actively wrong. In this case, we _want_
> interpolation of `$option` to happen in the title string so that the
> output looks like this:
> 
>      ok 167 - mixing incompatible modes with --contains is forbidden
>      ok 169 - mixing incompatible modes with --with is forbidden
>      ok 171 - mixing incompatible modes with --no-contains is forbidden
> 
> By changing the title to use single-quotes, you suppress interpolation
> of `$option`, with the result that the displayed titles become rather
> useless:
> 
>      ok 167 - mixing incompatible modes with $option is forbidden
>      ok 169 - mixing incompatible modes with $option is forbidden
>      ok 171 - mixing incompatible modes with $option is forbidden

Thanks for the through explanation! Should I not include this patch in 
v5 as the test body is error-prune or should I revert changing the 
double-quotes to single-quotes for test description and keep the changes 
to the test body and send the patch with v5?



