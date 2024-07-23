Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483514BF9B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726815; cv=none; b=HDYfRIFt6WNT0dRTgelz8XfUiAFUsdFOw0u3IWHD/DsKiL5C64/AjnP9Ht/av30+kEaBWW7CAkRErwyklK6bWEYn8D4S4D7LnHLFF4WBvY14kqV9L9EjvmB4yDx+YpqLre1lvuMw8KMdF8c/wHF8igiPBmXldkNvWxfrTgAQ7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726815; c=relaxed/simple;
	bh=SR4DRIBcnDCNtUP13q+i+fcLuF8fsI/yLgiI/vL0CCI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KMDdLIY6QalhN++16deYbE5GOlmqcuBLzevTCK3XN8CwIiFbNY+r7x4kNoD6uOGJ/meMLbybE1Up4gmWTHvosN0dluHxaLZkQTtqsNl1L965Iny56bJ8J32YrrGACPutPyoZohmO91N5AL6ixYaAp0Wqg5c4n0o9iOiCk5hwonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmDHKERY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmDHKERY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so45781465e9.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721726811; x=1722331611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFTH+ycwLOxnjNRwbVLHqBV5fKN7EeuHye2vPOHAL0I=;
        b=kmDHKERY6gqAij8qEQW3YI8tgbqFzTHRfP1X4WrmHVd66KhOVTOEW3CeZftqPQNmse
         n2mL3if3ZP/ZTdfxSCk7u5LBXOcNGkCJtZgrEZYENADZM02bhYWU60o/9GWCd7tqD36w
         nYr8BBLmoFQ0yoEMHppA3gfg5yPH6QxQ/+bHSgifXrZ8vj6gQr/JY5xqtDmSDTnjy67F
         BPXvfqkt+iSbfz1dpsFtQG8e4iuwHhNKE/sGD2+5vOgkM2aXohoaOXoOh4S4Ss+CFjBu
         ruLxiraHgeo2/gllF80g0uuP5pdMcZBnUZG4VZXL1Vw9dEMfKaAf3KCarqXYXUQtLInN
         JM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726811; x=1722331611;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFTH+ycwLOxnjNRwbVLHqBV5fKN7EeuHye2vPOHAL0I=;
        b=n6K5bYW9IF7qORgRprqAy2iuWY0sIFSJ5RO/znyvYQwZ2aENxWbPt/H5WuYxoZghBf
         iKokEo0yRggHsmjbZrTUl3l3wNtdOd3YwxyA9dnHwXAyrjkR+ai3A6SDAXddc+Myhbo7
         AEtiprP/p1+CNoeQkzPxLXPA6ENjkiTxdT44touig+kQh1lAq4xJafWEqOTN5Ks5r4NO
         BfefNunJnPbdQMcDk+kk6n5MTyjpPsHBfQG2+q1rX9NZY9P0GDq8sOVWfGAMhXe/KVIZ
         HDLfd9JF7JqD0fZ269BKfHrEi19OT+jE2yH/07Diy6w/1u68oLwUJuHr63dimjEfiAEP
         h8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDu/eg+o133xpJbS4I7CcoVf2nmAKIoX5AeYymqZ94m6NyX3G8txvrOVH9xxHVTlNFehrDov7O2eOo61IR/lRP8qnG
X-Gm-Message-State: AOJu0Yx5vLXpCnXOPfJ0k2lHSZy/5Y4BmiJC4MH23X/dZth7fDlOKSuC
	D8in5Zxw/gTUJiujkDm2w1rWEM+nDwVd1DfpZH0ElxBovJmNWo8F
X-Google-Smtp-Source: AGHT+IHE6wPNQ0ZSYdihfEn/UiAk6I0d0pdBaOPbE523Ytnk9JJRqB7TgM3EAELscoAhdE1/GINQvQ==
X-Received: by 2002:a05:600c:468b:b0:426:6714:5415 with SMTP id 5b1f17b1804b1-427dc55bc31mr71556085e9.30.1721726811208;
        Tue, 23 Jul 2024 02:26:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-427d2a5bf8esm188241455e9.12.2024.07.23.02.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:26:50 -0700 (PDT)
Message-ID: <1b672247-c05d-44f5-967a-9861d715040b@gmail.com>
Date: Tue, 23 Jul 2024 10:26:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func"
 invocation
From: Phillip Wood <phillip.wood123@gmail.com>
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-2-ericsunshine@charter.net>
 <c586f7dc-636b-45a3-acb2-faedfe1068e6@gmail.com>
Content-Language: en-US
In-Reply-To: <c586f7dc-636b-45a3-acb2-faedfe1068e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/07/2024 16:09, Phillip Wood wrote:
> Hi Eric
> 
> On 22/07/2024 07:59, Eric Sunshine wrote:
>> From: Eric Sunshine <sunshine@sunshineco.com>
>>
>> Unlike "VAR=val cmd" one-shot environment variable assignments which
>> exist only for the invocation of 'cmd', those assigned by "VAR=val
>> shell-func" exist within the running shell and continue to do so until
>> the process exits (or are explicitly unset).

Having seen the parallel discussion about the behavior of hash this 
construct is non-portable because the behavior differs between shells so 
perhaps the commit message could say something like

Unlike "VAR=val cmd" one-shot environment variable assignments which 
only exist for the invocation of external command "cmd", the behavior of 
"VAR=val func" where "func" is a shell function or builtin command 
varies between shells and so we should not use it in our test suite.

Best Wishes

Phillip

> I'm not sure I follow. If I run
> 
> sh -c 'f() {
>      echo "f: HELLO=$HELLO"
>      env | grep HELLO
> }
> HELLO=x f; echo "HELLO=$HELLO"'
> 
> Then I see
> 
> f: HELLO=x
> HELLO=x
> HELLO=
> 
> which seems to contradict the commit message as $HELLO is unset when the 
> function returns. I see the same result if I replace "sh" (which is bash 
> on my system) with an explicit "bash", "dash" or "zsh".
> 
> I'm also confused as to why this caused a problem for Rubén's test as 
> $HELLO is set in the environment so I'm don't understand why git wasn't 
> picking up the right pager.
> 
>> check-non-portable-shell.pl
>> warns when it detects such usage since, more often than not, the author
>> who writes such an invocation is unaware of the undesirable behavior.
>>
>> A common way to work around the problem is to wrap a subshell around the
>> variable assignments and function call, thus ensuring that the
>> assignments are short-lived. However, these days, a more ergonomic
>> approach is to employ test_env() which is tailor-made for this specific
>> use-case.
> 
> Oh, that sounds useful, I didn't know it existed.
> 
> Best Wishes
> 
> Phillip
> 
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>   t/t3430-rebase-merges.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
>> index 36ca126bcd..e851ede4f9 100755
>> --- a/t/t3430-rebase-merges.sh
>> +++ b/t/t3430-rebase-merges.sh
>> @@ -392,8 +392,8 @@ test_expect_success 'refuse to merge ancestors of 
>> HEAD' '
>>   test_expect_success 'root commits' '
>>       git checkout --orphan unrelated &&
>> -    (GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
>> -     test_commit second-root) &&
>> +    test_env GIT_AUTHOR_NAME="Parsnip" 
>> GIT_AUTHOR_EMAIL="root@example.com" \
>> +        test_commit second-root &&
>>       test_commit third-root &&
>>       cat >script-from-scratch <<-\EOF &&
>>       pick third-root

