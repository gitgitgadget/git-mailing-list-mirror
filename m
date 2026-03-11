Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF23CEBA5
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225494; cv=none; b=VWXI+qtzXGMyUDtl/PltuLvPZqXxc3/2dEanpc1UQN+Cnlo9uZy+B94EfjfOw6Qr6eRV4aAs0n2Dn6oDPybfr46ZoPUWGkVW46EgyQPeKgqqfvSkrufxRgheDDyhSjy1g+OadzCXDkjep9gKgefFfaSAd1KRLAU6f6KGUlJBGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225494; c=relaxed/simple;
	bh=U5DkTQGE9nk+YMCHLovn0i4FA0qpvSrOB8/TEo1SC20=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GaS1KWSKMvh6rt/E/zxWlgd3RxVZOkGSP28etUD7i2079epwuRwfpfx6/Um49sI91DnTAOFKikvbXBGw5dSBjwBCGMll5xteJu8i7oEetbQZ9f5obdSltpI7bLwX0W4Vq/xzOQe3BT6aHcQnVu9GuMKWdPkdLNZOx5aYxLmJFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SU2pS8ZL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU2pS8ZL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so42953915e9.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773225491; x=1773830291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53JBScB5jktxSa9AhPsNIXvZyRTxvQnXXN45q7u7JUU=;
        b=SU2pS8ZLM2C41I7wABq6x8uSJGmBTr77drNamLNIkx3PFHCNedvbJyEM0IrmIJXGvT
         +tVNcONwp+WPL80Z4FqsyHrsHWTXVYawREgR63THwC3jbd3roSsp6J0UilnxbBjZVYH7
         LaM2KdMW7VaJAjuohpl6d0E4ZMjqIo4sxisNv7D8zyMMwbtRYjrPtFqYz2hilLn4zpYK
         YV4grQy/2M+zPNuH0AoUxQ8dPOeluBUYFGWoW1Wgbstn7anxT6JDk8n1YYg4ZYEzciJ0
         yMfGV1QpOvQi/8hMVybvWm7LqPEeQKGIk6KP+q9OvCvzvu3/QHx6dPKpDxDSdv/NNfrY
         3CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225491; x=1773830291;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53JBScB5jktxSa9AhPsNIXvZyRTxvQnXXN45q7u7JUU=;
        b=WHTWrXkWTACsNbeVtgOF4ZcH95bleZk4BC+z+5VpOdgc/8SbPtvhcym19gyfIv5R7O
         jpcr/+Tdz6MwUXYXSt6n431Faw/UFb/DSWNsYiESgefQ/jenjhQEj9Oerqhy0QamJv+c
         a7qNQLdovso0UxHxYqwwcOvLY5/XKAklhHRFC8oVD6bUNe4c4n3ZW8/7294iivRqlXoX
         9ImX7hKmL1SmIsQofwtbwNBhgJy/TwxPM4ehf9IPzETm71If1altTiEe9rXIQcnzsFhN
         sOiK0LcjtE8uiNbYVaeBVC9riemOykTLjq1R8BPO8zMbeoX8LJlnoVhsJT+lL6I6yAmZ
         dRww==
X-Gm-Message-State: AOJu0Yw9WQ2h/eK4acHnYU4PTapolWIXMYLuiak1lSxsJLh2Gqq1Ca6K
	m2tNcWxpZ4QREvv/fRDUMJb8a0jxzTzORqZcml0CCGgyM21FXe3wJt0k
X-Gm-Gg: ATEYQzznGPKjq/yy7juJsrO1d/YDLkIA5Vse/qfA2q5g1ejVhaW4TMuEp8BWenQ4N1n
	myh3StPUy0Nj9g+rr0Y4DguxN6JalR42Ur/qoePHds+HakpF/3WhrMbmFxvd0LtSF58iWT7AH9C
	yMJoacvV/isWQzpvdNbajZuPRNEwaxMn3rN10r6p10hNXgg5dymM+oO5kzqdeyyDtJIn+6CqqYy
	E3rK232M7GT8rZe4HLa0TRjbUFLzpL70dWhNNp/XAz/wBAH+v4K+oH+DIWPbeknK18FeTpIyfis
	vVA5S+HYKyk8plgVn4phMuKhf0CfyLBXQSl9f7rkG6RYmLtT2RSyfoGJJy3amrC7nbISQuo1xLu
	fsOffBYSzIaYYCq/liHDSlGpD4PC7tWd9qU6+uAfyTGR0iEqtNGK0YJxKYkXmH/VOcI9jXwJWPQ
	HmZAmDjrbCmqe4StNAtjzRUFbgu/sAGV7aDxEOrvcz5S9/0tQjdFRRtyR1yJ+n9FOZpJxeoy9bJ
	EG4BA==
X-Received: by 2002:a05:600c:800f:b0:485:4972:35b with SMTP id 5b1f17b1804b1-4854b0cbf90mr31567095e9.14.1773225491194;
        Wed, 11 Mar 2026 03:38:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm113167035e9.2.2026.03.11.03.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 03:38:10 -0700 (PDT)
Message-ID: <3191559b-d79a-4d50-8364-50581df24ebc@gmail.com>
Date: Wed, 11 Mar 2026 10:38:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
To: Mirko Faina <mroik@delayed.space>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
 <6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com> <xmqqikb3ws3e.fsf@gitster.g>
 <abCLFS3QP7rJHueq@exploit>
Content-Language: en-US
In-Reply-To: <abCLFS3QP7rJHueq@exploit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2026 21:23, Mirko Faina wrote:
> On Tue, Mar 10, 2026 at 09:45:57AM -0700, Junio C Hamano wrote:
>> That syntax is the same as setting config.key=true; disabling the
>> feature triggered by config.key is quite counter-intuitive, isn't
>> it?
>>
>> We are by default using "shortlog", but use of this configuration
>> variable is a sign that the user wants to use a more modern custom
>> format that is not the traditional "shortlog".  It would be quite
>> natural to invoke the modern default by setting it to "true" (i.e.,
>> "I want to enable the new format.commitlistformat feature, but I am
>> not saying which format, and the "log:[%(count)/%(total)] %s" format
>> is used).
>>
>> Perhaps "format.commitlistformat = false" should disable the modern
>> format and fall back to "shortlog", setting it to true (including
>> the use of "valueless true" syntax) should enable it and use the
>> modern default "log:[%c/%t] %s" format, and non-bool text should be
>> used as a custom specification ("shortlog", or "log:<format>")?
>>
>> I.e.
>>
>> 	switch (git_parse_maybe_bool_text(value)) {
>>          case 0: /* false */
>> 		fmt_cover_letter_commit_list = "shortlog";
>> 		break;
>> 	case 1: /* true - use the modern default format */
>> 		fmt_cover_letter_commit_list = "log:[%c/%t] %s";
>> 		break;		
>> 	default:
>> 		fmt_cover_letter_commit_list = value;
>> 		break;
>> 	}
>>
>> Hmm?
> 
> Mmh, what if instead we defined a prefix format just like shortlog?
> Maybe call it something like "numbered" or something similar (not too
> good with coming up with names).
> 
> I dislike the idea of having an option be multiple types. Should bool or
> string, not both.

I don't mind either way if we can come up with some sensible names 
instead of "true" and "false". For the "false" case above we could just 
use "shortlog", "numbered" sounds petty good for the "true" case above 
as well.

Thanks

Phillip

