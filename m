Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C13FD152
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535396; cv=none; b=RWNhF3gZF+ivD+7Jw4jnvQ+9zvdkzU0VBcydvGdBbq7HppK+VsRl3D2XW/HCJ06rqX23UbnRBmG8Jsda3vJ4U/9xNYjnzPB9QL8RM8OGElciebSOG2exTfwehF22rwkLqfIoNZkVGuZf+WWORGzTPhudv0cqndz+cVNq4sGBrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535396; c=relaxed/simple;
	bh=VAHKrctqpOcJgP0ZbvCAnF2bwqVotzfa5UAvdNrf2dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtzOHGmNJjex6/IncrnNWbG5mM2BnGl/gvi2sg/eOorJCwL/wJ5x4HG7QFROhblR986tY2wb1AvmKQZCBFtGLF+jNp5pq06JqAU44+fzgpvApJI48OwSKdXDEe8MVU5Pdnskot3QWUqCqEnHkll8BGHUFg7pJg9LpGslgPWyA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEiddiTl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEiddiTl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1621289f8f.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774535392; x=1775140192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SbcPRe/Zzzasy2w5IkrMNK4zl22HtVrLL6Yh50FuzIw=;
        b=kEiddiTl9MWhCV26RVBRrBBN9VAycCHy6SIiZcjIGEJnBZSv3cmbytw00fQ0Naqmv2
         fDtGIQtkMVzdAGAxWsJFgx5mqJjO0U5KSX8auRpqkjDgHeVp/XUymWTY3wS19mU2AI7v
         daajOn86HuWkV3ZlPbe/6tIc9RjxIvI1FZOj4FCNSROjB/giukTZE4F/eIkr5UkhynUB
         NQk65ylSDHYP1Dnf4jg1ptsduY3y5n2WWyIufhNwXfcKDhoiJWhE1hq7OgpfdpDm5g23
         Z4g8M6Dg2i7avtNNYay4Ybp8jhmfFx1bjEuoRQj9kurxA1qXzn1C+BM5pAA8gL01AVu1
         fGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535392; x=1775140192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbcPRe/Zzzasy2w5IkrMNK4zl22HtVrLL6Yh50FuzIw=;
        b=dGr4dUhBZVnT9zfZjL/eJuqHmLQlWzx8rNV1wtGOWFx47pyJ3Llhw68a1g68yJzpH+
         v9fBMyM6mhDa/O4Wk7yL/syyXHG3v1c5nPr1jswk7+/GjcwUg0S2kyPYROCH6iY0+NEQ
         hHoBKofKyc1CQVygNIrotJ4iCqEo2mH4HwPJ5uxtAPwXKkxcVY7YFI5+h6dHALXYWJEu
         fM1QLcrDzLzL1scRvJ96GQVn0pnJ+aCT1WawtE8DwAPEYp+nOtGnKd0e0Nb5XzJp7X8L
         zzuEcIzhOd6Rnv0yU1S2ZSZikF0OK3udAlwAHLCTuOz/cBxYKWN/Q8eSruyXbhwpoYiY
         tzpg==
X-Gm-Message-State: AOJu0YxAXC9FtNw6zWGiKWaSwGurLR36NTLgRqhAEzq8jNfq24oIF8K6
	/zGFgqL15QW+v3TvRTK5KT/C/GNiWdcjYeK9n99oQCsX8Ru7829lNGIF
X-Gm-Gg: ATEYQzwnXL6IuazLgvOZiukgjHaI6ifd01bAcFcDiCzCzyb5r1rWIS1dbZJUhdbaEa+
	qp/SWXBNiUxop4CjwTmGWpCyCu4mWzHSk2wIy0Fw75/t3dEIAHE6uwQeppcQLd1/rTm+zyf/Gti
	vtk1VNpaxySQ/ur9S/BSZegt23SWxFDPa4gUevhnzjOHOvkQYuYUDiG1D1tKBX56vxKutaNxwzt
	ba2dPEm6SFaSvKitaepO9ZjwJ6WmDICrJwL6IcfXX7+fOtdBXNiqOt8r4nxPHSk9f80v5UDRJLU
	v7En+fwYI03TaZeR7jxfcJ7Mumt7mrkda0Du5DeMm2HP2CKwbF96fUJ4fTDUwt/0eurfDOrh+ai
	Xo0U7laiE2Wqq+9vVxiecHL0lhjIsWPD64vOIUrtI7vU/wcrDFbv8L2UrQPM2V1X4YGoiqDp3HJ
	XVeLs1kJLrmEZ4Or967OvKO/7g0grqwTc+mf/7ipsi+buTlNiHtF771zRf2yNOU6V8DTvLW1iq8
	ZIXqQ==
X-Received: by 2002:a05:600c:3ba1:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-48722bdfeebmr31554225e9.11.1774535391426;
        Thu, 26 Mar 2026 07:29:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d23679sm75818205e9.9.2026.03.26.07.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:29:50 -0700 (PDT)
Message-ID: <ad6a32f9-1b48-4bb5-97c5-96d1dfea3074@gmail.com>
Date: Thu, 26 Mar 2026 14:29:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
To: Junio C Hamano <gitster@pobox.com>, Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1773959395.git.mroik@delayed.space>
 <cover.1774284699.git.mroik@delayed.space> <xmqqqzpa489h.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqqzpa489h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/03/2026 20:10, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
>> Not much has changed, just applied the suggestions Kristoffer made.
>> Thank you again for the review
>>
>> [1/8] pretty.c: better die message %(count) and %(total) (Mirko Faina)
>> [2/8] format-patch: refactor generate_commit_list_cover (Mirko Faina)
>> [3/8] format-patch: rename --cover-letter-format option (Mirko Faina)
>> [4/8] docs/pretty-formats: add %(count) and %(total) (Mirko Faina)
>> [5/8] format.commitListFormat: strip meaning from empty (Mirko Faina)
>> [6/8] format-patch: wrap generate_commit_list_cover() (Mirko Faina)
>> [7/8] format-patch: add preset for --commit-list-format (Mirko Faina)
>> [8/8] format-patch: --commit-list-format without prefix (Mirko Faina)
>>
>>   Documentation/config/format.adoc    |  2 +-
>>   Documentation/git-format-patch.adoc | 19 ++++----
>>   Documentation/pretty-formats.adoc   |  4 ++
>>   builtin/log.c                       | 35 +++++++-------
>>   pretty.c                            |  4 +-
>>   t/t4014-format-patch.sh             | 72 +++++++++++++++++++----------
>>   t/t9902-completion.sh               |  1 -
>>   7 files changed, 84 insertions(+), 53 deletions(-)
> 
> All incremental changes look reasonable to me, and it seems we have
> already reached the point of diminishing returns?
> 
> It is possible that people are only commenting on low-hanging
> obvious typoes and mistakes without seeing a bigger picture,
> but I think I've read through an earlier iteration of the series,
> and found it more-or-less solid, and I do not think there was a
> drastic change of course since then, so I am happy to mark the topic
> for 'next' now.
> 
> Unless other people find bigger issues remaining in the series, that
> is, of course ;-)

I've just had a look at what you merged to next and it looks sound to 
me. The tweaks to the new feature in this series are very welcome 
improvements.

Thanks

Phillip

> Thanks.
> 

