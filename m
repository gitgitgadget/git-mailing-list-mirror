Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1C26FA56
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226248; cv=none; b=V+ScVOYdy6BfafOqjJCxwL30ryGIVZnt9+VICrXKgRn6gHeSC3AwzGGlbYOOCIeBdk/+yYFDx3eoiTRyDQU5LW5CWBG2NY4j6kOfUKFocc7k6cl87RHB/6VG7FYDVt+yMUSTmy/IEQbYTwOUPv0SUsVbOiML6SKjk5yn3hqq6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226248; c=relaxed/simple;
	bh=b3S7FW5hqOjCs1DSGSjHqMzq+gKBXVieijbUifVPuc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL61NNZew1op8vjPpfkmMNxq0+1ECxEYUmR2f8re2JiNdY0HMG/bLO2RGcq0pO9yriKUEk1xlKQJwa+qPwN4AmfxRfgfqz/qL8LywuQZ0WhF8saESdCOtD8BDsst9DQfvORgxmeywzMw64U0TIjGrhxFPU9sNFZ5hDzOGZ/FoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APkgQ9T4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APkgQ9T4"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70ddadde2e9so3505436d6.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226246; x=1756831046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESFh4niFqRGzr53yDwFw8RvD9ObfVEYw0NGY1QrMteA=;
        b=APkgQ9T4yeu+xFZYQGu1SQkxGzC35W5olszZcfiYzztnZrpZKVEeBP6WDGUVjtAlhf
         ynzZ1OKWa8eorY8eoe0+obeYqF/oNIVgVbh+POIW/B2Zv0eJM4kMdjCu3N44LKR5ZwS4
         xZ4ESLzl7LNKWjXbBWvneMoa+FD6ufkWUE+Kmyw2m7AnV1cQF7lETZDhMmwd99yP1nIR
         cSXajzKlDiw5FPLc+07j1ez6oitkKOm05bPvfB+nwx6W3B4BS/q6nLL5lG/SPMv1omP6
         hYaRPGkn5mDUGYrIDGu02603Qec2s2Rx7lCPWcTKIgLa55/015S0JbB5KIxcK1EETa4p
         u9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226246; x=1756831046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESFh4niFqRGzr53yDwFw8RvD9ObfVEYw0NGY1QrMteA=;
        b=TSHOSXGwfuiGW06q6/ZKIWpdl7qtJehtgkRlK+IzFdVC061J8Q64SPOFl46Zt6ue9g
         PbQjOo/aK/e8pflp7jF+46eY95LauP1+21XfdSEFKqu2IYtHO99KvfWyQsiDG/OfZw0K
         6TtBhTKQ8hdsYz7N/oMKnTzxOS3jGZR0e0JTs1CKgzbb+gOdySn6DAeq/CRv1rxK5iJH
         lzXisls1jnh5TFs28nyNxP3pBFk+yIDya/gqgTHKq6rqem8uxAI4uHFyHdbnCTG1MlF3
         OCYLCSOVh0LN0uEMRWS3MO+7g5wrPGbW64eLPC8HOYHWcIrHO+hUnfEt7kGGxQYeyD3L
         Pe6g==
X-Gm-Message-State: AOJu0YxkLACckoe+eXXezCNoRBCoLKd8fnVTs+UCp55CC7xcEVRzKuso
	7+2A1PEfk7Qt3+PpvYFd+YX2rzme09gtwoqtENRmdKMzTiQ+r0AqlZF/cCwZ3Q==
X-Gm-Gg: ASbGncu5SMfiMBAzpT5lM00qMqI7yuk4/RybcCTdPLBoTyx55/t1nYDL1RbZM8lwkd+
	0p+mpO+29B1UpHc1AdNDqhdT4vU3BBgzb4DtwkKW5aF6AkkFWbmvrL9w5XVgOZTlFNbJi4fDwlS
	caROJr2TdwUyZMhQ835TK43FZbA0J/e8QyCzkpTPQszRt7KnCZguUqie8oyXmCO8tzvGgabCvqs
	vy8V/vCxcxeEQUVS65inV+KXCmW5kb/Wjcao/mASmHzkvTB73hrmKVgOmxoahV0QA5MiLRwVeHm
	dDykyafbWQHEsv8NwdCO+jeWi3PwpdHESLs75x2PcSYbjBm0Elhjem//JXKpV/dxHdxDVBge5SO
	e0KT8Rk0Vuvk9nsAxXtPA+KMeexu5FLj4jH0=
X-Google-Smtp-Source: AGHT+IFVTLG6YF7Kl7MveU3np353EDXE3J3oTP3cybi3XOZ+4k0V/bx+TnIwVFFDbVcdZLbupvWXTw==
X-Received: by 2002:a05:6214:5013:b0:70b:a663:b9c8 with SMTP id 6a1803df08f44-70d971f6590mr202913096d6.7.1756226245988;
        Tue, 26 Aug 2025 09:37:25 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72cc195sm67138986d6.63.2025.08.26.09.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:37:25 -0700 (PDT)
Message-ID: <c3c0fbef-f395-4972-8352-dd89af6799d5@gmail.com>
Date: Tue, 26 Aug 2025 12:37:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Aug 2025, #10; Fri, 22)
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>
References: <xmqqsehivqxi.fsf@gitster.g>
 <CABPp-BFuKUH0NKR_9Qb7Q8Cb++o2EVzqYK8WyvQ_PG5_JFyZ0w@mail.gmail.com>
 <xmqqbjo2kqz8.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbjo2kqz8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/2025 12:06 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>>>  Needs to wait for the base topic to solidify.
>>>  source: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
>>
>> Maybe also mark as expecting a reroll?  (cf.
>> CABPp-BFzMLGJwz4QqYtvw3zRYgmC=Mb8T8GCOsrLZqT2z+8H7A@mail.gmail.com and
>> CABPp-BHLcy-A4yLR8gP1Sjt_EKQ4K08kPyb7G6yifdZj+0MJNg@mail.gmail.com)
> 
> Good idea.
> 
> As these are primarily to remind me, I'd prefer to point at articles
> from the topic author that said "in the next reroll I'll do this"
> rather than articles from reviewers when leaving a note to explain
> why I do *not* want to merge it yet.  But this second round does
> look like it needs responses to reviews.

Yes, it does need responses to reviews. And I'm looking forward
to the base topic getting a reroll before spending too much time
on a new version.

I'd consider this one blocked at the moment. I reached out to
Ayush earlier to see about progress there.

Thanks,
-Stolee

