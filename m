Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490B5D73B
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007812; cv=none; b=emYnpZrJs2UHlBBx1rfEkpyzFJ2Ue43w9WAMqNcfQscnO9LHUbquEnhLWXjTAtDc5ApfIIKpzHBRuJ5VQsjQlCGIFxtXwztGNAgpzK+MiLk3tDXaCHsrVK4CQmhe4H06nRtpKZVZ5BWiP0uEp8AHiSyMgK15wabdvc0L0tqyFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007812; c=relaxed/simple;
	bh=5qtcd5bKVysQNL7CiuhuvHdCeesVkctAj/2nC2Qmxtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KARgOWP9yMzgATFVHZgQQzDCtkEUXuWn4gHNHSUUplJ0AsBP2p7cVsUKkV49sL3c2LqEiqrd+dMFa/VtmwJmQYqQFYEaTrDDr4uB3el4cjbohE/WuUzzOpvJb2bi4iBqxuzhpNWO60tTAEYCs3P3qGkPArDPq8yfmeUrIgkrOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHZEBH0p; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHZEBH0p"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337d32cd9c1so3706304f8f.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 03:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706007809; x=1706612609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uroNC+xlS42KynSdFcWedagspFahlHQltoVuZ3Bm9/k=;
        b=VHZEBH0p9jWMbZ4oFBOrtysrFbiWSCSCDBGQpCK1W2i5p5VzpeGomrh14uEvAgwFhc
         6V6YeX/K8Doh8G5rOy4F+WbUIxWMPDVO3zVZcsL10m9FJV/6CAGtNtyJNPA6z4gZOV0A
         X6dl6A005U7xjOdyJduniKv0Do9m9JCXg9kIeUMZDPR1yMQQ7QU1PxTKBGjhopX3FjtK
         RhF7KWPyPwDGFVQSFm+jlrkfw99RSI4ltXGsN1Vct7YbsNM18E25IwSF7XGWkwRwA6BO
         gS8t2ayj5IbwSAXkr1VM/x/cuK4PORf06YnJ/MnStdz8B0bbq7I2I97vfG3IV+osneAm
         4yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007809; x=1706612609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uroNC+xlS42KynSdFcWedagspFahlHQltoVuZ3Bm9/k=;
        b=eQFxNoKliyT1cNnKGiG7DWWX4TW+TA2jAwe5CMsjue+kGuEn8B1H3K+NC/cFKbr6hd
         2CEHeljUoOWKCYJE6AAb/kvVk6zpjTFsKR02uGJr45z0WU9ykrpNImbU3BdRUs4FJ/9x
         nonW/77t+bUMhTKvr5M8eFF+qXjiH8TcqCpNbfvzmFzuiFNAyp5IJGDL7NH1Qsj01xu+
         eO3I61AX+XqEAdKOYkT580q3J24d9SGklScNbIAa2mK63m2C7RQsMqUXXzbaKHsuFrSF
         s9Tmm9sWIRlS+cRaX/8JIF42V0YA9/u3tryMx1WCSbTNxPIlhOyjV90/6U3QL2SHzytN
         sYXg==
X-Gm-Message-State: AOJu0YybTzBRMz2lk4tcblf0GJy3YgOyMpTQ71QYxx6wMFUcdYPOcOTo
	H666NDKq0V2nSPO8+DVhQmYjuEhc+Bz2PWGnUUzZ4CVp7uLmS6Yd
X-Google-Smtp-Source: AGHT+IF4wA/mVsSqUziNYRXWNt9ytsBbhZvbI8l3+b94/JSKnJaKZq9vdHvvOBI3D4t7lBlj1CIPxw==
X-Received: by 2002:adf:a316:0:b0:336:6914:4f7e with SMTP id c22-20020adfa316000000b0033669144f7emr3286666wrb.47.1706007808651;
        Tue, 23 Jan 2024 03:03:28 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id a2-20020a5d5702000000b0033928aadde1sm8580561wrv.48.2024.01.23.03.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:03:28 -0800 (PST)
Message-ID: <ba721840-7b67-4822-8046-c0da4d3b9bde@gmail.com>
Date: Tue, 23 Jan 2024 11:03:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-3-karthik.188@gmail.com>
 <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com> <xmqqplxtrucm.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqplxtrucm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 22/01/2024 20:22, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'm concerned that this change is a regression. is_pseudoref_syntax()
>> is used by is_current_worktree_ref() and so scripts that create
>> pseudorefs that do not conform to your new rules will break as git
>> will no-longer consider the pseudorefs they create to be worktree
>> specific.
> 
> Ideally, when the exception list in the function becomes more
> complete, those "pseudorefs" created by those scripts shouldn't
> probably be created either as common or worktree specific thing
> if they are not "pseudoref".

I not sure I quite understand what you mean here. Are you saying that 
scripts should stop using "git update-ref" and "git rev-parse" for 
anything that does not match the new pseudoref syntax?

>> Another approach would be to
>> read all the files whose name matches the pseudoref syntax and see if
>> its contents looks like a valid ref skipping names like COMMIT_EDITMSG
>> that we know are not pseudorefs.
> 
> In the longer term, I'd prefer to see a simpler rule, like "all-caps
> or underscore string, ending with _HEAD and nothing else are the
> pseudorefs but we have these small number of exceptions that are
> grandfathered".

Hopefully such a rule would stop us adding pseudorefs that are really 
private state like MERGE_AUTOSTASH. I think that is good in the long 
term but isn't it is happening now with this patch without any warning 
to users? This patch changes the behavior of parse_worktree_ref() which 
the files backend uses to figure out the path it should use when reading 
and writing a ref.

Best Wishes

Phillip

