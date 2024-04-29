Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC814A8C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383183; cv=none; b=Yqdv56ac/tAvc1Mcsh6etDotsrx/Zlyym2h4J92VD4OEjZUePc5RFOz5z5g+h4LqUxZ5BnHn0iVotbZaQh65sFFdZs/zYUEPfSnGBXpctZoz3o8jcXOW/2SH871/Mp7uET/keyUuyLzXryhruOPXtXdsosKeXPEi9o0JyzKKqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383183; c=relaxed/simple;
	bh=pW0P1BHWvPGeC1xLS6VWoDS9im8+ohfVBsKIMyTqfFw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LhEHjGX83aes+LeyGzje9JqZ7YlFW8PMC5YMt7yAoSaKi0Wh0uurUfyiikuwCWECGLsbMalPiuAHMVD1CBBKwCVg5+5HkECxbpp10EI7IE72WNRJZmg8qlg5Gm6UdiM0KfS3vwcrvIGtT/6cP8H4xNQLjQpaRYOxTg/FdXIxVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTQa2Ket; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTQa2Ket"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d1adeffbfso487326f8f.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714383180; x=1714987980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kjjji0Nmp7ERQxrJ47AFo4N03CL54/Q6VwLzZNiPtOI=;
        b=DTQa2KetKBObnZryZm0TOZBHXkPBYgk7qnXq03tOHb2Ohov1u/cgnPgoTSE6D17MVZ
         nNEK/F/0LXPZdyc86NNnhAizPYMGE9Bu1J+PAqzEdpEXof88wwYeqSOvU9h7cU3jFvkV
         bqd+MEjcxZkBRxQY/6alqxJi3mVrjckTPSmmzI/iT+9T1lW77lu4ti81C2iSR06l6NFH
         diIa9KRW5XMUET8HzLC94DdAsMZcBGzQMv0vL5mftJ0I3ZLduzWRTdQW5rB2RU7rT0/i
         I/QR3dnef21tl1hk2S4JSkTQBYWc8OX6ltuXQx2Xe6el6NBUWzQOCAl+E8eH/f7Gjn0d
         5TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714383180; x=1714987980;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjjji0Nmp7ERQxrJ47AFo4N03CL54/Q6VwLzZNiPtOI=;
        b=aSKaDC4EMCcw8i+rInX7qGZMhnTAwZxaCMY1pem48vSShHNyPysteKdgVLlR649pjp
         YfbKxDZhZZpcLikbBs1PESdPBl/Jlrq/5la55PrAROFDRqeTk4qfHXo0azwMQwwF2ZN7
         ebdOj7Q9gcQSu0YnFNV7W4iuhiSQvLQuBrjfotlv98/hB/7Cuxr4lK0XQTvmgHPpt58t
         KWa5l63y6Ps7aFR2zaKPXS+FKSMr0UQ5uXJzKFMWI2BbdqLBcFXgKM9aIWSlQ1KVkG0q
         c0SxwR08ViA8Bg4xkW7ym/sq7N/2ewnOnv3EYD+3L8rXxG2GhnuNrqSsCxh8NRV39yCk
         dR9A==
X-Forwarded-Encrypted: i=1; AJvYcCXPddND0aqg5YSkwHpDt6WhXIASp2w8Am3Jc9r55FrlSOZJ/xFX93vMSrxdEJRr+x++j4Ag43lxAwq2bvMKLx2EYOBr
X-Gm-Message-State: AOJu0YwHl0iyVo/Cimk9W3fsmIuB//4uFtcdJNidqEkwKW0aNchwGIyh
	GwN/orGaSUvt7ijo8+sVB9XkLG+l7VBUCLdX3TxZt+b/xgiog/WF
X-Google-Smtp-Source: AGHT+IECBKT+l94TLAEMbY66E0jsfqQ7SYlmUMJuYQhcqmuj7cRJ129/mAR3x4CxslglQpGKK+XIDw==
X-Received: by 2002:adf:fe8d:0:b0:34c:f31f:906f with SMTP id l13-20020adffe8d000000b0034cf31f906fmr2315876wrr.55.1714383179998;
        Mon, 29 Apr 2024 02:32:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id b8-20020adfe308000000b003436a3cae6dsm28975907wrj.98.2024.04.29.02.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 02:32:59 -0700 (PDT)
Message-ID: <b2977495-3b4a-4f2a-85dc-d0568f34f2e9@gmail.com>
Date: Mon, 29 Apr 2024 10:32:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
 git@vger.kernel.org, ps@pks.im
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com> <xmqq1q6rc44n.fsf@gitster.g>
 <20240426211529.GD13703@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240426211529.GD13703@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 26/04/2024 22:15, Jeff King wrote:
> On Fri, Apr 26, 2024 at 12:31:36PM -0700, Junio C Hamano wrote:
> 
> But the more interesting one is a call to refname_is_safe(), added
> recently by Phillip's 1dbe401563 (show-ref --verify: accept pseudorefs,
> 2024-02-07). Looking at that commit, the intent was to allow pseudo-refs
> by loosening the conditional that checked "HEAD" to allow "FOO_BAR" but
> not "foobar" outside of "refs/". We enforce the all-caps pseudoref
> syntax in is_refname_safe().
> 
> The proper API there is I think check_ref_format() with ALLOW_ONELEVEL.

ALLOW_ONELEVEL just disables the check that the refname contains a '/' 
and I think it is aimed at checking branch and tag names without a 
refs/{heads,tags} prefix. If we want to move away from using 
refname_is_safe() perhaps we could add an ALLOW_PSEUDOREF flag that only 
allows the name to contain '[A-Z_]' if there is no '/'.

Best Wishes

Phillip
