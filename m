Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06961D45E8
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554580; cv=none; b=ZD06HNeRlNPuIsWvkPXOssi7zPWEmXprDj/95Hb+W3CYdQwqUAUwSCzGme/OdYREPg1AShEzMOdqlnEVqaPZF0F83sKyupJp92Bbnd5WbPeS9nSsZlrEbL1uAWhG3zlhtpDqKe0n8Lw19/8oJAYNrZZtOFUD/H5FEkexKglDgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554580; c=relaxed/simple;
	bh=MQpMmfaD9IRRJYVE3FPODdQtnnsGX5VJhJ0yIjrpPE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgSneB5aN9ljn7h3gcTUUUGNmrvjSgWn49qRRlYSZTbhaq4DqsEtddxQR0rUvOWbMFGwQpHQGCxD5NviQxBU7oA5XALswE3mBIzyUBNRoFiczWzVvApTDcI4l4MAZvTbUK35k4fcUan5IJjOyCbZy5VII4G6rHrl+V4DY0Nuv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgL8xlE9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgL8xlE9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0046078so18442245e9.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775554577; x=1776159377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=umgpYZiHXUuLB6mX5lfM9S1vRbztFg0vld/Yl7pVqqQ=;
        b=TgL8xlE9wlisn2zopSrFqNT9nrXI2vBFVP60/2ov2s+bGEdpqvbmul1KRAmipVShUR
         A44HSZ63A0uOKIcdM25DVANPrc4pTEYoYLLYiyUHXbYb7WPiEag9pThCnYd/G8TEXY7T
         3JF/Lq1Rf5zPqZy0GLSPPbIy5Mz1Revv8Vny+rZ6HQvRPpqoHOKxY5HXt9YU+nznQWJs
         265z787MfgHVM7D4SN30ecSvpqg+2x8Fc5a0BinbaLQGYThK8csP0Jfhs1x/pi3tn6gJ
         A8ZmRz5478rhOiQ6S8oV/3Rg3a7sZvuD+KQh8PUoGhk2ovQ1d7VAL535onB8O6qdlIOl
         0GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775554577; x=1776159377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umgpYZiHXUuLB6mX5lfM9S1vRbztFg0vld/Yl7pVqqQ=;
        b=lmuWqTbR3d6gPWoiNUBCnZOBysDrN7nK8aQ52U2sc8ptz0VPNGbj+ZR1Yp6kllnUGT
         WNpcgrKypjABIIDYUPOTuIBPe1KpvfU9rb4cBULl204OjVdEZ8v6xYWqxH/g12f0EQWV
         hzWcBZmrnHRxNOcI1iD/V7KMQrmbAw7g9BMPnRCyCyVuxYT/ipx5YtB+ybagzDjECsr7
         Vuzn/prv2/Bf4AAJtGDW3IteatfSeT4Weed2iKb46S+6zcwGykEu6uEVvozpjji11O3Y
         ZkrdFcryIl1JlzHHg0hV4cOs3N3zqBRwJCKexLyt5b3DJ0sImSR4ciQIL7Ei9BMZcj8u
         IO5Q==
X-Gm-Message-State: AOJu0YxCL/2QEGkOWVbKDC1S+PcSt7RvPYa0WSXqdsK/mnQlo30snMg1
	Wo1kD2pM3OGK4Zk8lBKwW/tQPcei8pfOo5SVID5D+ADSnj01VrOD7ys9
X-Gm-Gg: AeBDiesRMyrDWxuD9oxwR1MW3vCl9Y/MkcCrVUXDbprKbfkIPkVQJRnUWRpI67lAVSq
	2G7MCsOZhBLB4Y/nxUVb+4Z/jaBL2pQ1aPYoks42pUK5DklcLW7UgFBIaoyHtBbla73foWhbAyb
	k7uPrCndP2I3PpIoAc7iSpXqEciATvlbNvkwUXr3ufv4YN8k/I7uiMqswpSrWh91NX0XrtIjq27
	mwCNq21Xkn3mTzfasgrcILhNar7oF0wtuJy7qX3q6qtkdENqz2PGJ6ZFQeLCXqTDNyvod8m46PO
	pDzDW0V3CWva/dNx1mf5PCt1umQdtehsh/136D1TQYs3fPJAHTJ8ejn5GyRe4n+7Z/Ub387yWyo
	dS75V/F07qvEAahuV10pkPqo95Gcu0veIPStfCZ5/HtjlWZf9gXRX1Tj/OYJ7co/dlDRPgIYuHz
	gPhOaAZZ5tfGGkwyeTAQqToZf3VQPs7tG6Om8uhd1Otidc8ZPmHepwh13SO9Nc0UQKeIBteu5ZP
	YrkIYVh2wsGoA==
X-Received: by 2002:a05:600c:c493:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488996da0e3mr214820875e9.4.1775554576805;
        Tue, 07 Apr 2026 02:36:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d289asm47749472f8f.19.2026.04.07.02.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:36:16 -0700 (PDT)
Message-ID: <a280c7de-1357-44a9-afdd-bd473fd4e2a4@gmail.com>
Date: Tue, 7 Apr 2026 10:36:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] stash: infer "push" when push-specific options are
 given
To: Mirko Faina <mroik@delayed.space>,
 Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com, quentin.bernet@bluewin.ch,
 gitster@pobox.com
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260405110953.3316-1-deveshigurgaon@gmail.com> <adP3JZhS7IHDuUxm@exploit>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <adP3JZhS7IHDuUxm@exploit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2026 19:15, Mirko Faina wrote:
> On Sun, Apr 05, 2026 at 11:09:53AM +0000, Deveshi Dwivedi wrote:
>> When "git stash" is run without the "push" subcommand, the command
>> tries to assume "push" but rejects any non-option arguments (i.e.,
>> pathspecs without "--") to avoid treating a misspelled subcommand
>> name as a pathspec.  The only exception is "-p", which sets
>> force_assume and allows pathspecs to follow.
>>
>> This means "git stash -m foo file" is rejected even though "-m" is
>> unambiguously a "push" option, and the user's intent is clear.  The
>> same applies to other push-specific options like "--staged",
>> "--keep-index", "--include-untracked", and "--pathspec-from-file".
>>
>> Expand the set of options that force the "push" assumption to
>> include all push-specific options, so that pathspec arguments are
>> accepted without requiring "--" or the explicit "push" subcommand
>> when the command line already contains a push-only option.
>>
>> This was marked as #leftoverbits in [1].
>>
>> [1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/
>>
>> Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> 
> Just realized, "--include-untracked" is not specific only to 'push' as
> 'show' accepts it too as an argument.

"create" accepts "-m" as well so that's not unique either. I agree with 
Junio's suggestion in the link above that we should assume "push" when 
there is no subcommand given and error out if we see an unsupported 
option. That does not require the arguments to be unique to "push". A 
complete implementation would also support negated options like "git 
stash --no-stage [<pathspec>]". What is implemented in this patch maybe 
sufficient in practice but it would be good to mention the limitations 
in the commit message.

Thanks

Phillip

> "--keep-index" as well, but since
> 'save' is deprecated I don't think anyone would mind and should be fine
> to leave it as is (though this is my opinion, should wait for others to
> see what they think).
> 

