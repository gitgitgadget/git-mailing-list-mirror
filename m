Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2672800
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710621187; cv=none; b=P8y60mXxJKTWWpgNJQQSoNsGufUweKGXUgDHOUmaIUjHkjKgut0LS/TMF0PqtpYRixcTXSCz0NfH2M53QBVKvHGVZ5/HC6pttPhqjbw2vclo03/GDOypqQblVqLeacPgMiWJsuboMYZ60lclDdczdvuoz0+G71ohmaH91BkMDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710621187; c=relaxed/simple;
	bh=h7LbQQ2utmM904CkFihU0W9U3uZ/fRWYWuULN5ZUSt0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dIB21taL2XZKAUdsM+6Km1RPqMTRuXBc73r/GfB+dTEHA9watPOxMJWfoDSLeqEXgtz81jn0QFmQa2toQMZi8KEJkNHcfnvXXKTk59kY/1RlIcAGJIeNWHP4Vlo0uH+gIc35Qk5JZir66jM3XBz8yOKeZUqrDZFkFxB+/2FgkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwUHgxFS; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwUHgxFS"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c37d50adecso697585b6e.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710621185; x=1711225985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsNgNozDtgDFAgHoOm+5PlhUMWJbnVjDHnEA1MY019w=;
        b=QwUHgxFSgH4zidjJVNCfeN5+g3qBwE7T36KlrYR3YzZA1t9oOImdueqQ5w9aCwv0MN
         SImur7blBqL22P9HyfbAOJvWswEY0lf+UF+5lvnlxU3NkinFYxFCYuhf2VDqpgTmQryb
         hGYhsl/vlBnNw8jpIXUNp7nI7NOoXwsLdi7TeiQ86ayoQhwP618Frrxf1MKqOPtthR9J
         rSGQK9UIZ/cL/ryT/vZb1O+D17vvq64y3fiem8t2ySPmHM1X6x3eR4XIMrB+Ygva4FVH
         bXR7U/VCrCAaxFQsDAP42EQgbUUDLWOLzE5TfJsUqNd1pXchhFfUqHPa0jcMDOD/1r97
         jMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710621185; x=1711225985;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsNgNozDtgDFAgHoOm+5PlhUMWJbnVjDHnEA1MY019w=;
        b=wxtQCERu2Nvsa+EtvHj1OmPn1Wzk6fhSizNraepq52tDnt/Nzw9+qKFkO3IyTGaaeN
         Uyizn1PnZ/daoXGc8XMKShimraFlqI/1MBI+UqpmHrNPgYKB3AZRlS885K5ZJLksGnp5
         f5egYok7l9ONWPiM7eutSr8O2iBsCcsNlT1Iq+3uZ4OvfJo9/NNN6e6rulKQjS+979+T
         N1PGHj6eXJ0BnlZu09sJ4htN6q/qn7//lO7I7/csYPQZgYqzqRXj2JyrrOnjm3BLslbN
         OAi9oBCUjV9Cny2LZEGAJYvaKYyKg/Vs2V1GaB+5nGGxAkjQN3rSza86nuE9grgru8ZZ
         4i7w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4QEzkqFMKQ/PqA//HtNaM/PjM4O2KC2O0ADi0FUFhvQc/Ql4r7pOH4kfbDV5vNLnEo0tnx08Me0jvaeeVQVQoBoR
X-Gm-Message-State: AOJu0Yx1yjuDShtzNZiEvPLvb3hCS5De/YaDkixYg//L7jH9pliCchQr
	mXuLtvyqS2xVOYCzNs3nvMvtpZ71K/XW96jYbCyGxmF7BgQTz2wO
X-Google-Smtp-Source: AGHT+IE8Ymzz/aTK3/w/Ryy+5p2HvpWzgGBZZmyfu5h2jOl1kumRIhCuulHc0boZMg8skSQvjMRNxA==
X-Received: by 2002:a05:6808:13d0:b0:3c3:75e1:5cc7 with SMTP id d16-20020a05680813d000b003c375e15cc7mr7007791oiw.39.1710621184957;
        Sat, 16 Mar 2024 13:33:04 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:103b:f04a:b551:cd51:32ac? ([2606:6d00:15:103b:f04a:b551:cd51:32ac])
        by smtp.gmail.com with ESMTPSA id gy10-20020a056214242a00b0068f6e1c3582sm3385854qvb.146.2024.03.16.13.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 13:33:04 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Allow disabling advice shown after merge conflicts
To: =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 ZheNing Hu <adlternative@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
 <4e1abd12-d73f-41b2-a334-036be9093485@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f773d6d8-ad1b-dec7-1ba1-741af497bccc@gmail.com>
Date: Sat, 16 Mar 2024 16:33:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4e1abd12-d73f-41b2-a334-036be9093485@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Rubén,

Le 2024-03-11 à 16:58, Rubén Justo a écrit :
> On Sun, Mar 10, 2024 at 07:50:59PM +0000, Philippe Blain via GitGitGadget wrote:
> 
> 
>>        ## advice.h ##
>>       @@ advice.h: enum advice_type {
>>      - 	ADVICE_RESOLVE_CONFLICT,
>>      - 	ADVICE_RM_HINTS,
>>      - 	ADVICE_SEQUENCER_IN_USE,
>>      -+	ADVICE_SEQUENCER_CONFLICT,
>>      - 	ADVICE_SET_UPSTREAM_FAILURE,
>>      - 	ADVICE_SKIPPED_CHERRY_PICKS,
>>      - 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
>>      + 	ADVICE_IGNORED_HOOK,
>>      + 	ADVICE_IMPLICIT_IDENTITY,
>>      + 	ADVICE_NESTED_TAG,
>>      ++	ADVICE_MERGE_CONFLICT,
>>      + 	ADVICE_OBJECT_NAME_WARNING,
>>      + 	ADVICE_PUSH_ALREADY_EXISTS,
>>      + 	ADVICE_PUSH_FETCH_FIRST,
> 
> Here, I assume you're trying to place the new name correctly too.
> However, I see that it's in the wrong place.  It initially caught my
> attention, but then I realize that the list is not sorted.  So it's
> understandable.
> 
> Maybe you want to sort the list as a preparatory patch in this series
> and so we'll avoid this kind of mistakes.
> 
> Of course, this does not deserve a reroll.  We can do it in a future
> series when the dust settles.

I fixed this to put it in the correct order.

Thanks,

Philippe.
