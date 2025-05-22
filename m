Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D290186295
	for <git@vger.kernel.org>; Thu, 22 May 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957706; cv=none; b=N0pkP3BJlTIWdKFi9WBozftMCUjhZkMb7r8ttNBsKHcJWkb+F0HQmIsoZX6BT6hWJOOy83a+46TfvAgavEFGtetzQgv6RR3gbnl1aNlh15fSLO9JSGcbpaVuyR0XRZktRn/Xh4VCAg+gTopOZm5z6VDuRTGR5qNT2ZvvTQrfbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957706; c=relaxed/simple;
	bh=RDEDvVjbUGdl/tx/oY4XD4+pC2cJP0a2LmErUI2fwT8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ieg+myPqMnYPflH2BBWJumMu8yxjCqX2/OrEhUUC62XnZW2XSqcoG3PCdDfL5MAQRh7NRLiLfeK8cjCzEqw9rZFnX+Krr0gbEGqQkSw186n2lBvI5tmROQr9tUyf4kcGXfkMQTFkxXhpkSCNBujFtwVKvo0ig7P/04jtK7bB8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RzZvjd3Q; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RzZvjd3Q"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4775ccf3e56so4501441cf.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747957703; x=1748562503; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzjZNQwOcyxqch6oePIWBCEBwKi82hMlovO/B6rtJ4o=;
        b=RzZvjd3QbiSSlRa3K8i9NmHlSL9ESAvvGuAZViTXvBZ1LuptGCXcxJnG8o9vunFb50
         hqgybYrFLPRxHUiNVNC2Q4arkIdL2IAPXrerEucRIEu/+jSZiCoHm6CFHl+zQcR+Awro
         VRHni3ZQq0lGzK4DxjeQalUbc7OV9faqsFPHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957703; x=1748562503;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzjZNQwOcyxqch6oePIWBCEBwKi82hMlovO/B6rtJ4o=;
        b=TjpgaaPoOeglwx0VXSA/M2b4Wt4DYoK4xAkaK1Pfif6zWC2ACMy423o6z3a3qI2EL+
         tzNnj9t5yMluy5vRP5M9C3LvZIfmSAxPDpZOVsd0ITPV6BS1fHIpSG/9ANrcFKt+N5JE
         asEvyAlFQLeBCNr8UcPpiaiK0TAKOQtZdJjB83+S3xMQiI9zBSUQNnCnTALRpVOdFBfC
         3eNadw2BznRvmnycQG4YhutdaBcRSZTsRr4F3DuknT32QuRZfpt57+CD5br38fiX38XJ
         WlIaVgEJdTuoF0AJIP3zrRFWt9dFqxLUX4z67m3aIXv5qCbwBC38IreA72u/iCMFtZm8
         +X4w==
X-Gm-Message-State: AOJu0YwlImAsqrhGTPVQBDJUb2LVs8xKNr0Sm+QdRqkCQrzvYhqKJbNd
	+CQKdIceibzgtx3UoLeEQwjo3a+zRgfTmEgk1LHDZm+U+BiIVNpRNiMekvWcrs6RpQ==
X-Gm-Gg: ASbGnctV5wO0dxC+WE3vnoflD60b0Q7cBCzFX7xsevyFEJknfb1jo777i5Vf3w9962a
	qjb8zfCXY/Ippqa7/ceHXcYCxw76PvF8A/M2IwuoR6s2I1sb29q8pxiqMAGEvtqVW9XHuXbtxVT
	U0xfrC78s1WVir+JAxzNed99m90GG0iytpClZ+DyEYRsDAuw1yvhzrtiQQNzWIo+EKOzVzUKEjT
	0XDex6RicjlkhOKVV2DxWYpDl2B6lwTwu1iUS+JSj1jNKSd1yagJd5IbtsFBArgInsTEFyz+k1h
	1xleBMa9yDeT/RvRkqFcW0y06JjUrLpknR1jcc5lZf2thgXToBRDsKzdLW51VVr79g4JGMQLOPq
	QK5L9s+3b28nPyy510Fv/DU11eEPGNxRORYvGapgrzHjuNVeS+Q==
X-Google-Smtp-Source: AGHT+IHlkij9cASgUZZyWwNBizy2ByHCrf2OzZLsb1wigGZ3AQAiRVuxINZjEL4CELFw5BsXs9BTng==
X-Received: by 2002:a05:622a:2b4b:b0:476:fd4a:e885 with SMTP id d75a77b69052e-49dfc77e5bamr21836201cf.20.1747957703141;
        Thu, 22 May 2025 16:48:23 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:55e7:9db3:2295:29f0] ([2600:4040:9ce0:6400:55e7:9db3:2295:29f0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae3f9450sm106173141cf.28.2025.05.22.16.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:48:22 -0700 (PDT)
Date: Thu, 22 May 2025 19:48:05 -0400 (EDT)
From: Mark Mentovai <mark@chromium.org>
To: Junio C Hamano <gitster@pobox.com>
cc: Git Development <git@vger.kernel.org>, 
    Chandra Pratap <chandrapratap3519@gmail.com>, 
    Johannes Schindelin <johannes.schindelin@gmx.de>, 
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH] apply: set file mode when --reverse creates a deleted
 file
In-Reply-To: <xmqqtt5c1ccs.fsf@gitster.g>
Message-ID: <76ce493d-d5bd-fc63-8942-76d0b3cebbf9@chromium.org>
References: <20250522220235.8650-1-mark@chromium.org> <xmqqtt5c1ccs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Junio C Hamano wrote:
> Mark Mentovai <mark@chromium.org> writes:

>> +     git checkout -- data.txt &&
>
> This should be a no-op, right?  What are we testing here?

This syncs the executable bit to the working tree.

I found it useful when developing the test, but it's probably not strictly 
necessary as the test is intentionally independent of the executable bit 
in the local filesystem. I can drop this if you think it's unnecessary.

>> +'
>> +
>> +test_expect_success 'git apply --reverse restores file modes' '
>> +	test_config core.fileMode false &&
>> +	echo true >tool.sh &&
>
> I we took the above approach to prepare patches in separate files,
> we do not have to set up a different scenario completely anew.
> Instead, we can start from a state where data.txt is missing, and
> then reverse-apply the remove patch we used in the previous test
> first (and make sure the mode is without executable bit), then
> reverse-apply the chmod-x patch (and make sure the file is now
> executable), and then reverse-apply the creatoin patch (to ensure it
> is gone).

The file that I deleted at the end of the previous (apply "forward") test 
was not executable. It's important that this (apply --reverse) test begin 
by reversing a delete of an executable file. That was the reason I built 
up a second, separate set of patches to apply: I wanted to give better 
coverage to git-apply setting the executable bit when it creates a file, 
whether it's in the forward direction or reversing a deletion, because 
that's the harder case (and the one which wasn't working correctly, and 
which prompted this patch).

If you like that better, I could achieve this with yet another mode 
transition, but that would produce a stack of 4 patches that would need to 
be applied in each direction, or 12 operations in total (4 to create, 4 to 
apply forward, and 4 to apply in reverse). Or I can keep the existing 
structure, which is still 12 operations in total (3 to create, 3 to apply 
forward, 3 more to create, and finally 3 to apply in reverse). On the 
balance, I chose to keep the tests more isolated, but I'm happy to revise 
if that's what you prefer.

I'll also integrate the rest of your feedback, and Kristoffer's. Thanks!
