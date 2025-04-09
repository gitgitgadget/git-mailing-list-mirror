Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A0265613
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207894; cv=none; b=HlRchnhctMpDdAiUmph/AWEubd87vwAnDawuWuDR2WdV9FyEfh0API3uZyH53EfvRve4ypZw3MRNz8FHr+7KkSXN8/WG7jn7P9FDGB5sSbAp4gh4g5PRYDTE6+6XM0WfY0Qh1q6RWdoiWW/8jVs0bOZEdMZLPrY7sWmKQAXxfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207894; c=relaxed/simple;
	bh=OK+sroJ2Dul5LOjlRtTaxw5aR75oJIPsssygsfyQm54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwvQTHhlob5a7cy65p/C0sAGn8HqQQT/6IcTa7dyLmX3d0UDJwasx86+gEoqjvtsCfWASkgbG3FLjp+fEumWe1hmYNxL04RjQP3g7kmOf82yWNoQnftOBD9jhKZIfhgdLigPh/b8dovCp50Vb6UGgmIHMjfV5RpLN2gRmEdnjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT8mjjOu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT8mjjOu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso73616935e9.3
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744207891; x=1744812691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X46pXtXftB3b+eXl3uaoZC39Fv+hPc4SlNQHatcetko=;
        b=KT8mjjOuBwg/gqqCsUbwagaxacfRkKm+RtJjLDjAzj6HTkvSZsbisacukbNExxNnkv
         4lVFbXgmNpADCn+jwVjJOXtOGGNtbYmj/uRLo2KP38ETFusE02e9by6L7Xrbn+g2Frmn
         8SjglXxibGHxOHGv44fuPObi1jBasod+3f3mS1AeyL7rfAZ1ZUqDHyrSFj15maauayV+
         UMCwCRpvuFoAtEzf0/KJlhgwNwfFpmZMXW6iSZE5IGTUfXiu5pMmUQqd8FeeBHoYU+T8
         G3XdRmHLn5lQIni6Qq5zeKqJcH/yrBpc6X2DhzMS/95A8qzLdXrQlCvw9WzM/GMsjoYL
         bvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207891; x=1744812691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X46pXtXftB3b+eXl3uaoZC39Fv+hPc4SlNQHatcetko=;
        b=T15OqDiN4Is2X8b0ADngoYLrAYT8Zg7h14SDBaz8j3VbuORz4k6sgQbz9zp85kcPE0
         OofqSHqzFc4kHdhOaOCvxjYgNSCDQJ/fub3uu6zlslg5Iz8MYNKdQXaFtoDQGNcg5rPl
         otVSTkc2mN5rlyL6b/varbNBquJOgrbcqEifSu4M5YWc2n4TJH312XCSle/qqWEeGX3w
         67MVmYVdXRwxqda0u3XL/i1aNrSZbJ6etypnMH8YnxrEyRyGhl0Hz/xl/RgVyKhp7/2Q
         Q20L1DqNu6Ft8JbfrO+MlgsQFBSIdftwvWhUWHfKS3oWClxmWrwhumerN4GXwk/Rslh/
         VBsw==
X-Forwarded-Encrypted: i=1; AJvYcCXXUS7DsGVywLq3L/rlB2GmDCLb1YDEltB53ydAp0vT4wHNHcWMTwDCWXvAKPBWL+4JpMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzJgCueZpMJUgfYhY5rO2iJzFrGhltZtKD/E6UTBru/RsvHOo
	gYeRjy5jb4kgafjmIJ8BY81qRrKEh3XKGJHO+ykSHyF5g1IrDdVuDS4BYw==
X-Gm-Gg: ASbGnctrq0nztw+Mz4gTLgGCJ1pbZ/PL7WUdo6c23XC1wts4qZS5SShdYDEDWnywhS1
	Gu0eCoeL6gDFNZJma0K04zCeGxxwSjVFnbtlMrGrY0/eiyVWL+oRlC1gY1ifpEiZePyUMhz/F2y
	K5E0na5UrrJDsedc+XQ2o+wMw3CzWrlNoOy3QJfOo2M7obZofIRnrm10mqWJMbn4DSM71j9OsyP
	1ytNMby8hhI+UVInLB9mtx9KilfU9oL9VQHfNOGoi2Imq1bYrHa057T0Un1hdhl2D6Xpx+Tg2Us
	AyxIAGZ+2S8G5W9FBfiEAtzXNV8BKNKiYvyZkjjIhQg2KMx576cyqV8CJ5isENyqoxf+746JLds
	N4YLrHdj+jteyuDCucMEHu0p8BCw=
X-Google-Smtp-Source: AGHT+IFo7IuaG5WubhdiyX+aYeJGNI/XY/n8+Sab+oeWQ6CvVF18Ah8YzkshkLt3wV0d0uqq3DpCeA==
X-Received: by 2002:a05:600c:1f8c:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-43f1ed62ee0mr31550175e9.31.1744207890886;
        Wed, 09 Apr 2025 07:11:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0cb7sm1781513f8f.75.2025.04.09.07.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:11:30 -0700 (PDT)
Message-ID: <7f744f34-050c-4d8b-b5fc-aae622c3c5b6@gmail.com>
Date: Wed, 9 Apr 2025 15:11:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] [RFC] rebase -m: partial support for copying extra commit
 headers
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1902.git.1744041163929.gitgitgadget@gmail.com>
 <Z_R6W_yjJEYuWo0A@tapette.crustytoothpaste.net>
 <240d1cab-b564-45ae-945e-cba621aa7562@gmail.com> <xmqqr022yaq6.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqr022yaq6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/04/2025 15:44, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Thanks for sharing that, it is an interesting list. On the subject of
>> encoding I do think our documentation could be clearer that the
>> encoding applies to all the headers as well as the commit message. As
>> far as I can see it only mentions the commit message, not the author
>> or committer identities but repo_logmsg_reencode() re-encodes the
>> whole commit buffer. Out of interest do you think we could be doing a
>> better job with fsck to pick up some of these problems earlier?
>>
>> I think "git rebase" only cares that the author identity can be parsed
>> by split_ident() which is fairly lenient.
> 
> "rebase" already knows that it has to be picky which header fields
> need to be propagated and which must not be, doesn't it?

I'd say it's picky because of the way it is implemented - it calls "git 
commit" and there is no way to set "extra" header fields when doing that.

>  Can the
> same be said for arbitrary "extra" header fields?
> 
> Information on some of the header fields are inherently destroyed
> when you refine an existing commit.  The value on the 'parent'
> headers may need to be updated (unless "rebase" is fast-forwarding
> an earlier part of the changes on the same base), the 'author'
> information usually wants to be preserved, but when the scale of the
> change since the previous iteration is so large, you may give it a
> new authorship, the 'committer' information should record who
> created the new commit object that records the result of rebasing,
> the 'gpgsig' and 'gigsig-sha256' header fields would lose validity
> if you are creating a new object that is different from the original
> by even a single bit (if we are somehow recording which predecessor
> commit the new one replaces, it certainly is safe to drop these that
> have lost validity, as we can go back to the predecessor to see it
> has a valid signature, and the change in the new commit that lost
> the signature fields is the moral equivalent of the original.
> Otherwise, carrying a stale signature may serve as a reminder that
> the commit was rewritten in the past---I dunno).  And so on.
> 
> Now, one thing that worries me is this.  If "extra" commit headers
> include truly extra fields with unknown semantics, the machinery
> cannot tell which ones are safe and benefitial to propagate.

That's true and we could have a config key to select which "extra" 
headers are propagated. We do however unconditionally propagate all 
"extra" headers when amending a commit with "git commit --amend" and 
when rewriting it with "git replay" which I think GitHub have been using 
to rebase branches for over 18 months. If we're worried about rebase 
unconditionally copying these headers we do something to stop "git 
replay" doing the same. On the other hand if "git replay" is being used 
in the wild without problems maybe we don't need to worry.

Best Wishes

Phillip

