Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829E1D554
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384097; cv=none; b=KC8Z9ycGQMl0l2kDZWbIJkbtashZXzJToKImNN93wK/sHuQld83oGu/bwa9GAcYWIkDDRjeGWy5pyJm+1m2I6BPpeNiZ8a5vnc0TMgfw/pLppUGU9EgBMY+9CZ8E4ZWjETNTQ5h8yGepaOWPQr47R9boIaJLoT+4jFT2Nzm76To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384097; c=relaxed/simple;
	bh=jp8UoplSqc2P0iPHS/gTE4E8jyKVBGrNQQ7phpYSkqI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QodfN94aiQ8skjufd4NpHpVHIdkwj6792Z3jNzIMesoQzXhUKRu4CulI/tninfiwxgWLWa7v7xCKT+4YS+NozR3ScKjT7Vpmp93JrEklW9PbKlr94NMJCvzmPG4Hr9KIhefpBc8rjEjlwWVod9SIRar3qJBRrnlyOXDMR7o9nHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVCoqIao; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVCoqIao"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b2119da94so34643765e9.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714384094; x=1714988894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NguTBM8fFk8JdV6OutS5yALYSTu7m2xe1F81pCUq0Lk=;
        b=QVCoqIao0Sst8sbKYGCtizu4IS/ygwcHCXwb1wm3tDy2gj+ZeTK8mQ5eFEZzMXwvPL
         2ZLFhlWGtlDVlE60L8CatUEJ3GH3QgVOmfw8omDCOAcB4yLnpjMuOhzyZhnKDh/CrZTR
         /b+wgoB7r8zfrNgUjDZvpHk/89Rw1h0RA9KKluyuZcBKpft9xOLL9AJ+NQU5icpCL8Wf
         7j7Q4ovdKHljHDMW66qTqn9ROv5pREz+05IfldUBvBDgthillhQN1SBxMYKM1ToMOln2
         PhBeoE4fmrAzqka7Mpb4HmkuFUiPKdsSWEZULRXhZDO1oNrxorozcAgaEgHooFOb7bdl
         QwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714384094; x=1714988894;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NguTBM8fFk8JdV6OutS5yALYSTu7m2xe1F81pCUq0Lk=;
        b=qRZzsi5+XHhUyFPTRPPRWrkEiw5dXcw7Dwa33qtKRgCXDY+SBwR2ygkuhO+OuuBYY/
         qaw+P9syihzeeudDAwoX4I2bvPzx7KuzxARi38I1ZMpRX/QwYRAQKkK4B0R7ZV6yo3Fs
         Q0ehFVNN5HLfXJMJa2meRTX7slnSr0ptq6dhkiYy+6Sxjom7jIxux4+2qFt1tqRhg8/P
         2gIp729arzWq18csTBUJkCGxtgEK+pFlmSDBn7AMekquPgCHvCr3IOZjW+oHHKlzNB18
         ZwZbh44zzvB8zHeeIG86ac0n0XdVmdvoMZk26aiPM7MRkOTTtGwa+VE4l1+GF+yWJYXA
         Rt0w==
X-Forwarded-Encrypted: i=1; AJvYcCVzZ27gcWBoOn5mQQFjXBPkaQI2coertoUxaTH3cYIl1DZM+h95nzgz6CqIjykD2NesukeWXbZoRxNQtwlCkjvhZkve
X-Gm-Message-State: AOJu0YzrZv0lB83hDyFCvZSjlmMUdRELd42Jve1IyGwxhVOLuQEi85K5
	XlTFML+pXXQuIIZtCAZvwpTFh/ggcWkJMzT43I73gT1DFgduWFymFz9yNA==
X-Google-Smtp-Source: AGHT+IF0wE6srQmMK9VNunsyJGKTuotpveF0CuuqJikHLS1yMeEllVF8DQtXMeJxq8qDpPsBzX+vjw==
X-Received: by 2002:a05:600c:470e:b0:41b:f979:e359 with SMTP id v14-20020a05600c470e00b0041bf979e359mr3579625wmo.38.1714384094251;
        Mon, 29 Apr 2024 02:48:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id n2-20020adfe342000000b00343eac2acc4sm29021482wrj.111.2024.04.29.02.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 02:48:14 -0700 (PDT)
Message-ID: <33bb69ad-ec79-4863-97b7-51605b94c9c5@gmail.com>
Date: Mon, 29 Apr 2024 10:48:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Patrick Steinhardt <ps@pks.im>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com> <xmqqv849xups.fsf@gitster.g>
 <41d23496-0bd3-47c7-a470-39334588f520@gmail.com> <xmqqfrva22py.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfrva22py.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio

On 24/04/2024 16:35, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>> On 22/04/2024 16:50, Junio C Hamano wrote:
>>> Rubén Justo <rjusto@gmail.com> writes:
>>>
>>>> 1:  0317594bce ! 1:  b418b03f15 add-patch: response to unknown command
>>>>       @@ t/t3701-add-interactive.sh: test_expect_success 'warn about add.interactive.useB
>>>>        +	test_when_finished "git reset --hard; rm -f command" &&
>>>>        +	echo W >command &&
>>>>        +	git add -N command &&
>>>>       -+	cat >expect <<-EOF &&
>>>>       -+	diff --git a/command b/command
>>>>       -+	new file mode 100644
>>>>       -+	index 0000000..a42d8ff
>>>>       -+	--- /dev/null
>>>>       -+	+++ b/command
>>>>       -+	@@ -0,0 +1 @@
>>>>       -+	+W
>>>>       ++	git diff command >expect &&
>>>>       ++	cat >>expect <<-EOF &&
>>>>        +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
>>>>        +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
>>>>        +	EOF
>>> Interesting.
>>> My first reaction was "how is this different from checking just the
>>> last line of the actual output?  The early part of expect and actual
>>> both come from an internal invocation of 'git diff', and they must
>>> match by definition".
>>> But that may really be the point of this test.
>>
>> Yes - we want to make sure that we are not printing the help and the
>> only way to do that is to check the whole output
> 
> I was not questioning that part of the patch.  "My first reaction"
> was solely about use of "git diff" to replace the golden copy of
> expected result in the test itself, only to allow for use of
> different hash functions.  As you (or somebody else?) mentioned in
> an earlier review, diff_cmp is there for exactly that purpose.

Oh sorry I'd misunderstood

>>> That is, we may later decide to tweak the way "git diff" hunks are
>>> presented, and we expect that the way "git add -p" presents the
>>> hunks would change together with it automatically.
> 
> This argument cuts both ways, by the way.
> 
> Insisting that the output match the explicit expectation (not what
> "git diff" of the day produces) has a few advantages.  It makes the
> test more explicit and easy to see what output we are expecting, and
> more importantly, it forces us to update the test when we decide to
> tweak the output from the command being tested (i.e. hunk selection
> UI) and/or the output from "git diff" command.

There is also a practical argument against using "git diff" to generate 
the expected output as it only works if the diff contains a single hunk. 
If the diff contains more than one hunk "add -p" displays them separately.

Best Wishes

Phillip
