Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C8175A6
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302326; cv=none; b=Yx8iZYZiyw9RlFXgqzOs/AKsulXef7I3ybAYOQz+gKwJw7K7pDvsqqKpv3tvC2qpaY79VdyBULwvtIYG1qXhNm/8zQR3IgmlJV9QFMysPFdpaOAWEEinusOuQhAQ0M1Vh8MABhbgm7iTuRDE2kJShM3xpCfBhDvvLwtkkQnNAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302326; c=relaxed/simple;
	bh=KqzKdZrNdxV9LD06YYBYyiW2u49xdbUtUyrjoTRvzys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o++d84tXPPXqgvnWSHMA3MNDjTToZH6BB3vtxfmHnIqlXFZu55EaIzxcdXmS30oImmHLVase4FF+ig8SCCmhwzl1IkqpUE9TgZGBh8qT18V3Ysr3eFm83qRlrbFV8Hm5kTGY8iiVTcl7lnvRZ/L5fvdn+MOHgLOlZ0OR+DEV2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfim0zWN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfim0zWN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b18099411so348279f8f.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 02:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707302323; x=1707907123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1W+gvetXZ42LoORZGQR4BpuXc5hvDwdAv5rERF3GURg=;
        b=jfim0zWNNrRFLOwzX5JNqHYW+ONOkFqXfjplDiNYA4CsAl5a4MqOeqD+t0TbvSbiey
         Upv7Q42MLMI732kps4YsjEngxkDeQUw9Sf3OCMIBaul67Q6zb8v8HDU2cmFIZmFv6ydJ
         k8OYFM4zjia/Wwtc0E389GFJnaacFyqRQnjbl/PaAWevhlxbfGnB0vPxZqSVlTPCChIe
         8YGyrtvYLHP3LOt1X6Zexb16XFrxUR5HEwKU9D87D+54vj0MxSaL1g5/7okaJNIQ7O25
         FSLrlZbcEM+oxJUjOE68y0xtDxIHA3+4ks7FouNBjUwe6ojUqevqjSeUurLaHSnu2AiS
         RrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302323; x=1707907123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W+gvetXZ42LoORZGQR4BpuXc5hvDwdAv5rERF3GURg=;
        b=BUN+lL/CGHoIy6IULImQLQhWWbeJRTQl9QIU8j2LOlx8ROLfjt2ZEWUTGX0tGX5pOt
         XHq2D4HVBVEzpSMKVjf2LCLNDPTbRgRUkkGZndW4B+SUnDr4rInhdwGH246Q4j3p38Cd
         H2gA2sC914oHdasYLwMUzOiSK+d3HTcgQV8sk1mp03ZT9vB+KZ793dLkAYL8nc+Ytljz
         ugA9nVaoW4h3dPKBWdh4mTjpqlg04AabpBTI0afLlBzCZaTY4I+yvac9KBBexGAHOgn2
         RlhfLj0UaDgjEUWhV+/rBYfbqCAialLZlyg5G8f61M+E47JBuA9xLq1BJdN1/EQydlXR
         9hAA==
X-Gm-Message-State: AOJu0YzIyLnZrR7P6Sn12w16ugknj+eR2Sd1oYhMTSJ6LBsWPW1TTNAB
	aBZGgd0CIlErtGBAQ951j9lclHsn0qFYohmESyeC8i529FfvZbHr
X-Google-Smtp-Source: AGHT+IHcswYLBQ16yVhvewk7AHujB27ecehrWXe+D5GFzG9Z1fanzljD/NOlkumFsW/b0O3LRrLgIQ==
X-Received: by 2002:a05:6000:4021:b0:33b:47d0:52ce with SMTP id cp33-20020a056000402100b0033b47d052cemr4596599wrb.25.1707302323012;
        Wed, 07 Feb 2024 02:38:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSFZkjOGHcPImXWZRJBXaZLf0Fgbgizv+1OqLZd4x+EqEq7DXX6y6IDT+BaMrUL6ez3/l0pf7go2Pj/yARC+/zR1t3Qf1osYk0l616zdYir8rjvWA=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id e22-20020adfa456000000b0033b4e5f54c4sm1112558wra.79.2024.02.07.02.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:38:42 -0800 (PST)
Message-ID: <1aabcaec-7266-40f8-b7ce-e82b8df58891@gmail.com>
Date: Wed, 7 Feb 2024 10:38:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/3] add-patch: classify '@' as a synonym for 'HEAD'
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
 <20240206225122.1095766-6-shyamthakkar001@gmail.com>
 <xmqqil31dqx6.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqil31dqx6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 01:05, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
>> Currently, (checkout, reset, restore) commands correctly take '@' as a
>> synonym for 'HEAD'. However, in patch mode (-p/--patch), for both '@'
>> and 'HEAD', different prompts/messages are given by the commands
>> mentioned above (because of applying reverse mode(-R) in case of '@').
>> This is due to the literal and only string comparison with the word
>> 'HEAD' in run_add_p(). Synonymity between '@' and 'HEAD' is obviously
>> desired, especially since '@' already resolves to 'HEAD'.
>>
>> Therefore, replace '@' to 'HEAD' at the beginning of
>> add-patch.c:run_add_p().
> 
> Of course there is only one possible downside for this approach, in
> that if we are using "revision" in an error message, users who asked
> for "@" may complain when an error message says "HEAD" in it.  I think
> the simplicity of the implementation far outweighs this downside.

I agree, if we were replacing the revision the user gave us with a hex 
object id that would be confusing but as "@" is just a shortcut for 
"HEAD" I think replacing it in the error message is fine. It was a good 
idea just to replace "@" with "HEAD", this version is much simpler.

Best Wishes

Phillip

>> There is also logic in builtin/checkout.c to
>> convert all command line input rev to the raw object name for underlying
>> machinery (e.g., diff-index) that does not recognize the <a>...<b>
>> notation, but we'd need to leave 'HEAD' intact. Now we need to teach
>> that '@' is a synonym to 'HEAD' to that code and leave '@' intact, too.
> 
> Makes me wonder why we cannot use the same "normalize @ to HEAD
> upfront" approach here, though?
> 
> It would involve translating "@" given to new_branch_info->name to
> "HEAD" early, possibly in setup_new_branch_info_and_source_tree(),
> and that probably will fix the other strcmp() with "HEAD" that
> appears in builtin/checkout.c:update_refs_for_switch() as well, no?
> 
>> +	/* helpful in deciding the patch mode ahead */
>> +	if(revision && !strcmp(revision, "@"))
>> +		revision = "HEAD";
> 
> Style.  "if (revision ...)"
> 

