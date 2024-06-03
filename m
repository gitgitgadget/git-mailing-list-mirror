Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6B84E16
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415098; cv=none; b=Okc5j8pyc73F8YPyUJSgJMk86M7Eu8bvUy8qB3aMTzglLENQ16ZAgUAkwHszju8sfDLfcm3VAeimP8NSZVWYSdWps2gXAJ60+1p71eRyPB4HJibYIPOuhAaYTBfea5jdjs4YHBGC9pE/+XwnayDkVAKI+5dHl0Fgrbtae06sY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415098; c=relaxed/simple;
	bh=3TrEuSIWRBd1dftsMQq6NIlM4Y6IxQTyIvfTTX9mCjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hltn74t4BXBEXaTOdphz3h1sw+ixogfepDERi2Sv4hPVfSqKD04ugK0mIxB+3rDMYpfL+86zm7YoVUnGc9FEJGBos7dfEkTQl//E8pnVGaVpvKOy7aVna5jg6tGk6whJgRLoyWOuni1C7+asWoJFFQxxL+ObmJV/BgcDD0oN4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFVboby2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFVboby2"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6cb6b9ada16so822653a12.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717415096; x=1718019896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hlHQbEA7B9U/DotdIRWNSOrq3HckKzVtKd0jFKPvFQ=;
        b=PFVboby2P1ctAY5DCvBE1ldfZoqI1iMuwo0Rtd2K8B3U/rnz+i2rvEF47pNhuXkgKP
         KoVwA2agT0Edm/1MMLxQaBh0cQdDHeyxj6HIbPYkqcYTgOIKDT8l69WI8LTx5maEDXwQ
         EW3U0vHn8EqAv9ogcTPBVWtY72K4qZD2AIrk0QgJ1RItDo4oswc3EG/71kIhu60ci4S5
         m94coxkhLOlEs55tRDGzPv3BPj5KTDz8SrVt/ZN23jJJkmybNpxXfrN6QYYjRjK7iQgY
         27s1kKSGWMziar19J6woZYEozJV8m4xuFCZqjTUOUf5Y5+gNVceAigLNNrm2/ZH+S+yd
         jB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717415096; x=1718019896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hlHQbEA7B9U/DotdIRWNSOrq3HckKzVtKd0jFKPvFQ=;
        b=oiOqBzyoDMNNIVCnpSTzxdiWkrUsmYTM/7lcteRNSsEFgaHCJh+2Bq38AexrqNyj9Y
         2+re/BzQnhUw1UKZfLAfaMXsa5hPL0GLwlRmUtq7sJ+YDelKA/w8TbzBP2Be+2NXURe1
         5tqCjI/xIqSaFi3vHmFeQWSNj6rKjr7tGfmJ2Pymfp2IN1KG3DgrZU3PJ5vpjDAODKNP
         HZh1yJdNbRGVGkvZoC65603miVvJLzO5JfPKvNhRYdLKKGMDdehx3JcGmc+PYsWYJyx0
         aqGXmOLrFRHmMT4tDjRI7/1ZoqZnHw+LPkf/hxdxb3L5GrkHZYxZZ67xJo6pES2vI6ME
         tKiQ==
X-Gm-Message-State: AOJu0YzRHcP4t+VXBK4l/3Qmh34hU6ApW2t+L9DPwoqttX0P0h3MFIdQ
	ueoTlnOlH9E57wQhABtjDU7h8aca/rmsB8/7q6GlWua61/LWgYarjwoxugjj
X-Google-Smtp-Source: AGHT+IEm6W7avlS2r6ZfzjKVKy1jHMRYINeIaYJl0iDvNolnV1CzPDSTJf12BfWd5UBFAE7gqmZq1A==
X-Received: by 2002:a05:6a20:7f96:b0:1af:f5d3:b91b with SMTP id adf61e73a8af0-1b26f0f0444mr9345063637.4.1717415096328;
        Mon, 03 Jun 2024 04:44:56 -0700 (PDT)
Received: from [192.168.140.164] ([1.145.243.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7027e4a7d5dsm27156b3a.49.2024.06.03.04.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 04:44:56 -0700 (PDT)
Message-ID: <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
Date: Mon, 3 Jun 2024 21:44:53 +1000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
To: Junio C Hamano <gitster@pobox.com>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <xmqqwmn66zzc.fsf@gitster.g>
Content-Language: en-US
From: darcy <acednes@gmail.com>
In-Reply-To: <xmqqwmn66zzc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Without having a deep understanding of the code I don't quite see the
> connection between this change and the problem description. Is it
> necessary? If so, it might help to explain why it's needed in the commit
> message or in the code.

> ...I guess that
> checking for tm_hour is assuming that TZ offset should always come
> before the values necessary to compute the timestamp comes, but it
> smells like an unwarranted assumption and not explaining the change
> in the proposed log message is a bad sign.

This line has been reverted. The point was it would only parse the
timezone offset if it occurs after the time part of the date, but I
have realized that this is unrelated to the purpose of this change.

> You should also add at least one test.

Yep, thanks, added now to `t0006-date.sh`.

> Do we also want to check for overflows in the other direction (a large timestamp with a negative timezone offset)?

Is this something people want added? I am happy to implement this if
so, though it wasn't my original intention.

Issues with the commit message should also be resolved. Thank you
everyone for your patience :)

On 3/6/24 21:13, Junio C Hamano wrote:

> "darcy via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>      fix: prevent date underflow when using positive timezone offset
>>      
>>      cc: Patrick Steinhardt ps@pks.im cc: Phillip Wood
>>      phillip.wood123@gmail.com
> You're expected to respond to review comments before you send in
> updated patches.  I didn't see the review comments responded to in
> the thread:
>
>    https://lore.kernel.org/git/pull.1726.git.git.1716801427015.gitgitgadget@gmail.com/
>
> Please see "A typical life cycle of a patch series" section of the
> SubmittingPatches document.
>
>    https://git.github.io/htmldocs/SubmittingPatches.html#patch-flow
>
> Step #3 and Step #4 are distinct.
