Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997884DE4
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296584; cv=none; b=JNIgvUpYCC7y37P/cw7lV7rP+hkIJoL8jkyIhPYAWanpZFflIt8i0rK/bJtNfEsWtp92w4SrwqJcfq0zsAcpBq3aKpyk5EzxbVMptVuh+RPjL+Eb83f5BxOMXTa9OStI4QetTaFS3p9xRiEHhQxSlRJOJUVGbHMFBbn6nSU9N0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296584; c=relaxed/simple;
	bh=spetCyetv3QoXAKC0//431+3s5gsH1qGYsi1QkpnV5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bymkn71DbBP2h8zrwD1j5v8OEFydBDHHW1A3CRHK3OirxwAeKDWF6fs1FoObCCKvfR0ohVcJV0+h+cMin+3+Kx3aM4Fd0njv3DI8Mf29UFBvn/UTPWa2carhfJWbQ5XHgQKf5n59wDYk/jIXf0Xx7UtSZRT5z3NtHnFGky+O5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcPN7wCu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcPN7wCu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684407b2deso404852f8f.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721296581; x=1721901381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/40fYs1Fw0fqQhxJAnSEgUJuFxlV/9XaCcO58NNzJC4=;
        b=CcPN7wCu6aSG1rqqeR3aeEyAFcwt8vE/eEBr4yJgqJvCQheThztidi1zxL/wKoLd84
         RHOCsVWnWi3YkFYo0IfXztf+KQEbq454zk7I+LrZtLJFtQsvb5MoUW8oicwocrj50bYT
         8R+RJd59G4qII3Omy6tUTRJnxH9fr9Ku5cWbx1zr3G0CwnwQOK7mTKY/IpnZaTjKt1QW
         q/vrTijWScVmiwLOXYI+wJ9PnYmUS6P262ZYKOfgsmXRHSXfDLRDTkPGRrSZj9G2Dvxf
         QCSBnwR1dCG1NYfXEQ1YaMVPtJyPtGN+Z36rHLjiN9O0+MXbjxHb+o+D31K0JRAI27iO
         sWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296581; x=1721901381;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/40fYs1Fw0fqQhxJAnSEgUJuFxlV/9XaCcO58NNzJC4=;
        b=SeG0TAn7wioitM8a/jFXGk5xw/vEXHRaOxkSMFOr2grrL+1SKbVPGMAlTZfrQrXIqr
         033xlWhLDzBZONxeRW5PSipAjEICOiIHJTiLaz+Czoccr3SrVW1OzeVH6Cy4tW7lR8ab
         ao9SCEERyr41HsLnDi57eFbPrKChwTvlOLm9vafelU5EnfkzKYc//dEofcLhP9R7EG/H
         6JXwOOKjSiWMBASMzHuogrIwjBSeO1HAOlh3AUtq6nhCPJmyACugdqfn7IPxKI8SxyI3
         alSbLmoN68nlt5Yi0Irnt/4ecInpFR55HHpxITKOsstkhzZCBFapT0BRySyU2X5FNacK
         5ZIA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/xpuAO2/vaRD6CIIznEPHCrwsVHAiWwFZjN1D4ltjr3WLH3VBQVQCGxXmBrSqcE3qzwizVClqV6VvNW3FvvKmCYm
X-Gm-Message-State: AOJu0YxsdCHJs4io3eA5ugIGmSi9UH1z9PM764G2xubPqqCTKYraF66W
	0pQAHNKECxQWDF7ZjNpt3RygjEQvYLeGfS4dBFI8LE/u+caM/rtZEONpfprl
X-Google-Smtp-Source: AGHT+IHoFQb/qENJxQhju9t5Q+LYlRj6j0MGznwuovHb4vpfpwFxSFHQbMP12U3ZgRbxghqLVOTpgQ==
X-Received: by 2002:a5d:540d:0:b0:367:9cef:f41e with SMTP id ffacd0b85a97d-36831746561mr3391515f8f.57.1721296580723;
        Thu, 18 Jul 2024 02:56:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3684d3c6940sm1536937f8f.70.2024.07.18.02.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:56:20 -0700 (PDT)
Message-ID: <6317c4a0-06b9-4e2c-9b23-10cb96950617@gmail.com>
Date: Thu, 18 Jul 2024 10:56:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com> <xmqqy15zzror.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqy15zzror.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/07/2024 21:31, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>>> -	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
>>> +	test_write_lines P q |
>>> +	(
>>> +		GIT_PAGER="head -n 1" &&
>>> +		export GIT_PAGER &&
>>> +		test_terminal git add -p >actual
>>> +	)
>>
>> That's surprising, why does running git in a sub-shell stop it from
>> segfaulting?
> 
> Another difference besides the sub-shell is where the output from
> test_terminal goes.  If the above change fixes the issue for Rubén,
> I wonder if it still works if ">actual" gets removed.

Yes that would be interesting to know. I do think we should be checking 
the output here to make sure the test is doing what we think it is - all 
we know at the moment is whether git exits successfully or not. If we 
receive SIGPIPE then fputs() will see EPIPE which will set ferror() 
which we should be clearing and checking that the prompt prints 
correctly afterwards. I think it would be helpful to add

tail -n3 actual >actual.trimmed &&
cat >expect <<\EOF &&
	\ No newline at end of file
	(1/1) Stage addition [y,n,q,a,d,e,p,?]? @@ -0,0 +1,2 @@
	(1/1) Stage addition [y,n,q,a,d,e,p,?]?
	EOF
test_cmp expect actual.trimmed

to the test. That all still leaves me wondering about the segfault though

Best Wishes

Phillip
