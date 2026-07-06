Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFD37C11E
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783312168; cv=none; b=U7uMhIQzfx1kew5hoAZ4l6Bz0xQoFPklX174ywzHSDPpLCmJnAVS4dSYUySra/Ts5vaI8PogBZeGAWi+H42sJCXx1PYl72AbgRUvks5ntjoPyoq9qCzJ48uClq2N9yeOewwmQFnilp/EIxUhZKPiQhoI4BBdKEVbJRidoZfa8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783312168; c=relaxed/simple;
	bh=cJDiApRzxt0FvzJVbzRCUxZ7oJFh/x6tNI1N8Krcphc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mamf4zo9lXGfSbOpykpGt9goS9FH7eBGdiad8dWeHpJ92viNP/ftEswaQrTZNAbQFDp0LLjLMGoLLdEb+tMNkIEMkrifEqPXrHgn8RlxPJCCDIa2A2WaryFyN4EM4EgiRm3VHIiexMBg4/UYYGJuEfLaSnuKjEYoos4VryK3CDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFRehaoD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFRehaoD"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1290720a12.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 21:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783312166; x=1783916966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAt+M35QX/S98f6CSeZGFUuY/yenIv9/T4uDNt2T3us=;
        b=oFRehaoDm9okEzdTvg9PqK7MvsSgAmp9Do4HLBuUv/O6EgRLiCSNiZ+2w6/MFxj6Z3
         Q/wdTzEyizpAnQJbRUmETBLCqgJzBl1oYqxcT/bNNxpRyysiCDnjlwqF0DNXT8Fs/PtC
         TK7qSB0leM3M5N4kvwgXDRWEmmhDUvQQSVZIcIM8g7pN/gIxb/1U8oaKCjia7iFk+8G3
         epOmfq/iHFH0USnueQHzncWLrq3Mseku/3ykHGFC5dRlgXCKIXOnxsWGV+rnqZ3sYW2J
         AxsyxLyDMkU7HABuinPuzt/Mvj0uydHBEfKbK748mq3dDEBelckhxSCGC7Xq0y3kTXKG
         RAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783312166; x=1783916966;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAt+M35QX/S98f6CSeZGFUuY/yenIv9/T4uDNt2T3us=;
        b=X+8aw7tTAbrf7OlmxG7fLn+bfvHyPSGZdwSuEtD+NE4ZX6RsHbhcgd7P7bPAfb+c32
         sp6OD65RPdOa29bHcshQWMMC/ER45HRcfWm3JX/RKj+46SJgrkfIrZlYhx2xei7oWDUU
         y1+3JP5SJUgREVDmUTbxBw7iR5BrpNnpMLQ0BSE0uvb7/j5TvUgUpXE1LoiX/REzQvPT
         iNSahakxIh5k7MktM1inJBstf8EtvvnmDTRNQu+ekgrFGTWkOqQOP8wC5hemgkQRTxYv
         Ph9yXpAgPhfyKbyw9Ab2YoGl60uecjcnVFEQPdW0hsWIMbI+3MKA2QRWahMsOAruy3+1
         Wz5A==
X-Forwarded-Encrypted: i=1; AHgh+RrYIVQokBpfhOUfq5Rok3Rc9I3+Qf57f+F1DNZxX/jTwvCbTdTCntc4/fnjjAFaQeDorRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6hqhGzMnGMubznmxWosQri+7CXw7Po9DVc6DYhezn/fnu5izG
	9DhGr5U7SRlxuOCDVFZ+gRWRfP4JG6UdF2wetzHzQy9hOKllM6gNQyxw
X-Gm-Gg: AfdE7cl1bf3ylyxKUhRUZM1YUMwIrdi24eKO6eqOSxVoMucSRhN9qjbd9QKsWEV8iL0
	luSQpLyXAPtXQ7qfrU5cKDGU+n7yh1oQOS37GNZWZUyOSwtq0Bf/13KdCGg0CZJTxWLrmICx09S
	0m9gK0rVgT9HOElUJO5+VjnVrjyFptu2tzaUuEctjYSKj6PQxiMOQZwSspesEDK7iJZcCMIXRkU
	YQHf4OFmP0ZMr2ZA2hRY6WzCJ7d6dwL4JS83MWwXyYuEqrOOp5ogXC5OfjZ0t0/mRBqDkrN6mU1
	D94mGUPx32ABSNWgKJa6jccHQyabBceVxJ6TH5H+JR9UGg8wIkluIPUae+kAFufx1NBgTGB2jNZ
	zHPbWt/3f+0zD5f205mQxUOeSM6UZMneRMcemG6pmlSrE+cETC6kbmZE3Hg2gM205Rd4RhAdukn
	+AOlFpZnmoTC4YuN4vAayxMpZlJpBx7WS5oC56yAjKIqnR/JSUUq/VD+J5DIdRnt7zIBiPID/s
X-Received: by 2002:a17:903:2c8:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2cbb201b38fmr78340595ad.2.1783312166389;
        Sun, 05 Jul 2026 21:29:26 -0700 (PDT)
Received: from ?IPV6:2401:4900:884c:e906:2c5a:2cc9:3a3c:60d1? ([2401:4900:884c:e906:2c5a:2cc9:3a3c:60d1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm64584264c88.1.2026.07.05.21.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 21:29:25 -0700 (PDT)
Message-ID: <7d00e3e0-27f7-4d54-8985-ba7b670efcfb@gmail.com>
Date: Mon, 6 Jul 2026 09:59:18 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
 <aj9wcFEb6oCRnfn2@szeder.dev> <akS51xJSP4tkP_pS@pks.im>
 <cbbb08fc-fd4d-45ef-927b-05ac44602ff1@gmail.com> <xmqq1pdmrcp6.fsf@gitster.g>
 <akX1TMoRr87Id8Ss@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <akX1TMoRr87Id8Ss@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/26 10:51, Patrick Steinhardt wrote:
> On Wed, Jul 01, 2026 at 07:45:09AM -0700, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> Another cost is remembering things have moved - the other day I spent
>>> too long wondering why "git show origin/seen:wt-status.c" wasn't working
>>> until I ran "git log origin/seen" and realized it had move to
>>> lib/wt-status.c.
>>
>> Yes, this has bit me multiple dozen times, as the tip of 'seen' is
>> contaminated with this rename, already.  It is a huge pain.
> 
> Yeah, this one I don't have any arguments against besides a very
> hand-wavy "it'll get better over time" :)
>

On a bit of a tangent, this made me wonder if it would be helpful to 
make a potential improvement to 'git show' UX that shows a hint that the 
file asked to be shown was moved as part of a recent rename.

Something like:

   $ git show origin/seen:wt-status.c
   fatal: path 'wt-status.c' does not exist in 'origin/seen'
   hint: 'wt-status.c' appears to have been renamed to 
'builtin/wt-status.c' in 'origin/seen'
   hint: Did you mean 'origin/seen:builtin/wt-status.c'?
   hint: Disable this message with "git config advice.objectNameWarning 
false"

Finding rename just to show a hint sounds a bit too much work for a 
hint. I wonder if it would worth given the better UX, though.

--
Sivaraam

