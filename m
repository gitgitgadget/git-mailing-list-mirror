Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653525D537
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198244; cv=none; b=lbTO/qBZJC6GH2RE9zYmUe8XxFC43xm2LvNMBgATlrAN4BLOlcUVxT6epZW/9l2DTL+HL2Aoua/HKbaTLoaq2LdRk9I9/eh4d9svebk8slDKLHgujXp1k1YOwOQVnV1O6n5+Iv4QUofhes+0S1OCI0uuaAlytjjWmTIPEgX5mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198244; c=relaxed/simple;
	bh=FahfxEq9C4f9nGOlt1sBOxLgvK9RqXUvAaHszH2NzWs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dZ9zSfWasgyYe0aA9HEA+5JMaz1o5DSSbWHzwWrSKQwwUd5G0+TKyw72lrx3ZB8L04Yq//egTKIw+6rH5RRdcDILV5gAIsC0NFUUV1c09JC06wTQthcesEH47b/EKJKEH63hycuf+uS3qANNptpwGdpReobDSr7j5QO58ExauBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gztE5rot; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gztE5rot"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so56358896d6.3
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 04:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744198241; x=1744803041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj3p+BFp+iBb255XMNp3hXgUqqovPBVWLGYVGN5XDGI=;
        b=gztE5rotE9G/R7GFiq2WhxKgzAqbxLr0SN8sgDulWeY4+mTpuS9WpXYIfswy9NKIh4
         M43Yk70OQNpZ+7v92xokoj6XJ0PW0KFIp+sy7dtDfKc6slTolWEe0Nrk2d4mGmoneMWr
         tLqehlQavpIxVwYKV0OozlIsCdl0MP+ypmI5vBKwSBEqc/i93p/YWRT0+AQLd4X+cvXY
         qvNoyXrBCBAFpFrhT7mzXhjEqotj5xHrNWgrPNcL8MP6X7Y1VDSzx9+ZvAl1XRiTz7vH
         H9Cq6g6rBHhsynl5ZJdARctxwRIIEKgvWRF4UuDeejj1fhpkkHSZ2oVrC2Zj/GDNZOZI
         glyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744198241; x=1744803041;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bj3p+BFp+iBb255XMNp3hXgUqqovPBVWLGYVGN5XDGI=;
        b=WMztudDN1zJwxfTbpyFB+3/VTff2Vy/S7si0sORwZ0j6rEnBNGvVI/Ugl4JM1mV1lF
         tHmRvcBNs+jSrSOOuwXuTwxqZeoCmwc0ZV4nBOSrTylvrScRN3DCKgkMu+p6851Rq4ju
         QCxhvv2o5ULgYb0239F1EwrfOFiFlIMn7gJUrcfkwTetepQVwV6prJkICcB9PCBo1/OG
         l1nx9bKuG+lYKCn/M8VH93sram/EtU0tP005vsITjblU8TVFU08GiUIn1aVH/SQukDK3
         YdpUFjSiJ8yidr6EtHnkoAXDhQWf17XOcSpadR+TR42RZc1xTzVrJGCDl/snD+kvUA68
         7MNg==
X-Gm-Message-State: AOJu0YxNm9NCBkp6cc0AwwVoMlOt8QQn/fU20LFO+8V9SAv4mIaHgCiB
	pBpoL9DU6sGS/9aGX2+VF+Cf2HmKPPzac8Srgw+zhS70y07w35UsEYy1Qw==
X-Gm-Gg: ASbGncv8X91oFmHYSHs1KWVRkjna7h0GnnesC7v2zliIr3KX5tNfC4brkCqAXsj/REx
	nayrvkLYeMwN64lHVfhF137hKOajr/NqTH5jCNO8srTmeAkiJsyXvlqSJRu+GF8HMhVhllt1eDs
	gziO3WosxjIBMUBjB0VQV212TnINS7WeQPjeUBhq6xsJ1KG65aetn1ulJn5KsBREznlgaBZoI6o
	SZvm9qXED2Er+A6pxekRk+Kcg7ExhViR6HQaz+0AgyQ2RyKea99FXhOqXMhV0cA4zlmDpWxJtDJ
	nLC/IWgdpgr6a0aF4MznwZxuwY0VEke+WCR5zHyoDoGNRkO2+oN9pVM+CAH3klAgrQtGSysf3hC
	X9YOC+F7kkZ18rlo2wDJQuzg8l7TIeuwDwspwt5FF
X-Google-Smtp-Source: AGHT+IFza49XhGqCiUFWaBFCcOPte7sEhLl9aUywCC9I7vE8LKkY4/brvQjvPECKKBAxq/NNW4RdPQ==
X-Received: by 2002:a05:6214:628:b0:6e6:5bd5:f3a8 with SMTP id 6a1803df08f44-6f0dbc5d990mr33266496d6.29.1744198241508;
        Wed, 09 Apr 2025 04:30:41 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:958c:6d13:6245:a622:b272? ([2606:6d00:11:958c:6d13:6245:a622:b272])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de97349dsm6158536d6.45.2025.04.09.04.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 04:30:41 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <xmqqtt6znch3.fsf@gitster.g> <Z_TAtJ9LEeHo2AQN@pks.im>
 <xmqqmscqyag7.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d5588a3d-db07-5c4e-3c22-ad4b751dd3fc@gmail.com>
Date: Wed, 9 Apr 2025 07:31:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqmscqyag7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio and Patrick,

Le 2025-04-08 à 10:50, Junio C Hamano a écrit :
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> On Mon, Apr 07, 2025 at 04:49:28PM +0000, Junio C Hamano wrote:
>>> * pb/perf-test-fixes (2025-03-28) 2 commits
>>>  - p9210: fix 'scalar clone' when running from a detached HEAD
>>>  - p7821: fix test_perf invocation for prereqs
>>>
>>>  "make perf" fixes.
>>>
>>>  Will merge to 'next'?
>>>  cf. <Z-pD1puYT87YKAd4@pks.im>
>>>  source: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
>>
>> I had one question around empty prereqs introduced by the patch that
>> wasn't yet answered. Based on my testing empty prereqs do work just fine
>> though and evaluate to true, so the patch series looks fine to me.

Patrick, thank you for your review on this series, and for testing it.
I do intend to answer you in that thread, and I also wanted to actually test
what you mentioned about empty prereqs, I just have very limited time to
contribute these days, so I don't know when I'll be able to.

Junio, I see this was merged to 'next' already yesterday (the 8th), and
you sent this "What's cooking" on the 7th. Would it be possible to wait 
more than one day before announcing an upcoming merge to 'next' of a series
and the actual merge ? This would allow contributors with very little time
to contribute a little more time to say so if they wish to wait 
before merging to next because they want to send a new iteration. 

P.S. I can't answer these mails on my phone because of the plain-text only
requirement on the list (at least, I do not know of an iOS mobile client that
can send plain-text only).

Thank you,

Philippe.
