Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562537C91B
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222055; cv=none; b=ts4iQurra/V4zxvcExCWBE3EPfRhQJnxvkX8AvHpd3USfn74ATjIfVVsNQh8BmX42Y2ygz/wVxIk9vuv7gxReABAfemRQUR3y3aR7fn6QtRBnjqO82Bt2sifW6DTzJogb94ajWuaBoDJZXkUKNq6V9QKPoh4B9V7BeL+vUA1QMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222055; c=relaxed/simple;
	bh=b+4I4bMpdmcurKCGK3TQHHQe4C4iRAOACyFNdJWPPAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmChpORdgFbLcddLdUOj7mXoGCUGoeiORq6I9tqrhjQ0Cq4Rq+S32UZPFJDvpduU6vYh821TFKu7Uim/7gUf/ohmtrPKERl96mvyn0GUWepIQq2liSwYCGr4VbY7IjYSISm2GwzC7QuRYS0G1PTnQZ+q5ifm17F0b6ehS23shWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkMbnCmq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkMbnCmq"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-396779b9a7fso50193991fa.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782222052; x=1782826852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h79/tGQTP9RzCpnccy3FxUTBD5Zbwo3OY9Ahrp4men0=;
        b=EkMbnCmq9EyGKA/8ezMwR4LO6h08z5JFK/QWajQvGLxiM5loL5Uy5gyYJ8v8THnA/F
         AXBtTewVT7api5MY6bipJELExCH6C/ZWUmIR3L7VhnZFnmlXSKQwjUoFDHGYl4KHpNVV
         2CK08XDMHws8HXIoojGA0zx+BmSZVMTff45d9jTZp6R/3z2tcmbYdXraB+IDv2wAMIR4
         eJxxNdUic3DR5UsdyHjJlZ1+03bvNeZ6E3CKxG53cFvcYeyMpuw146aHT2mRSaOC6q1j
         p0VrOx9SkG81FAYbbw6lDc5zBkjRXPXIl07vXpX8z/VoyQu+7bUOCu2hnl9yyd80ln1N
         53Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222052; x=1782826852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h79/tGQTP9RzCpnccy3FxUTBD5Zbwo3OY9Ahrp4men0=;
        b=b4okDDjMF8ae9L31B3gbUA84NxCugnQAEj7pSnqPuVYGwLUlKuUE01eNmXeVxpURX4
         V4anqhK2Jvyjg+/yEVe/vOBCB9z4n/O4DdmPcB/UCEgdAgYZkvj/JWqAfMdUj7+9JFle
         T6EDtmXZhRxpY1tHTPiMuM6eqnAFoRJ+bZVfAly3S3kI1TM9WWiFupAMUlm+5uP7Gw1k
         OUMfM/Jiuolom8e2ynsl6ruL+Z9hriEJiYX1IbCOVqkIvhsS+e2e/e4glv4TqgH6Ehxp
         +EitrJ0jVdumYTANTTA1OPZ+qmHfOYDX5wM0+9QSkzVbajhtWWAmnhiQDnvegxQ9HIWe
         iBuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GjR0+DlTtCXs0bG4+vG21HmBYTUCFxjx0i8TkYcxYYm3/3hEvAKLALRkml3SQRRpUvzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWajDHc3FKkSExcMeyQQ0lSkkSguVPBmSfd0zBkaepNVK4ForT
	Nv0OAhUNFDbLFynDbB9vSXcKme0ti+J6UA3LLNPLQfYi9esWnpYhJogt
X-Gm-Gg: AfdE7clviNQzZj7KaZkCBTxlEeerw30uh1qWzroFhozu5E+qBK6H8z+5Gyh+Zto6zCc
	Er8LIunDlDTAacsrCj+/2AuHkhyYjFMtVG2/VNY/XfETojHl++l/Rjnk+rDk4vmImwHFo9y9N9a
	IED6WuCxoeAl+Qtfp6UyXFMlX2L822YnKQ84JAmUxK92R3VANQ071OzM+7boPBCSfEOiIJHJTc0
	hLHrNK2XuUYRnbi3sxaU5jKadr9x1QINFHKV8CVl3NH1i0RjShSPyY0B6XdHs6wsrU031j7CKYE
	0cRqdtH9VAohoWF88fU/3tbazTByRxnx33F6tbv9QZ0VzJSD1sCi2Y7axM4DwMvFaE99cykF2N4
	9Oq4rFIPCvvh105X3kQpBkeay1enJnNHXHBhykjQw6C7DwqBf3pp40VX2tXlbVYI3ONxohhaudx
	sAkktls5BrYKMp4cEBr8G81Z6LIBm3Ms0qJO7P6N4O6kzfN/hAPtyoWYZ2qA==
X-Received: by 2002:a05:651c:2123:b0:399:6ba6:eda7 with SMTP id 38308e7fff4ca-39a2518a0eemr8093401fa.3.1782222052218;
        Tue, 23 Jun 2026 06:40:52 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b156a63sm25383581fa.25.2026.06.23.06.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 06:40:51 -0700 (PDT)
Message-ID: <82c160f7-94c6-4f38-ad16-1f57abc29da6@gmail.com>
Date: Tue, 23 Jun 2026 09:40:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 3/6] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <ed12a5cb5b76925cff08d2ab61efeda382b4477a.1781951820.git.gitgitgadget@gmail.com>
 <5c43f6ce-4dfe-47dd-b96a-80de57ecf108@gmail.com>
 <CAL71e4NJZ9c_=0W4djRFCYPw4z_dkh_ZHEDWBk8cuwXhxT9jgw@mail.gmail.com>
 <4f9cae3c-5cef-420b-954b-d1981d9d5a67@gmail.com>
 <CAL71e4O7hKM=_M4K9hJE0MH9PdHUHxo7hyAbUSLbyk2wpiGxmw@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4O7hKM=_M4K9hJE0MH9PdHUHxo7hyAbUSLbyk2wpiGxmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/2026 5:03 PM, Kristofer Karlsson wrote:
> On Mon, 22 Jun 2026 at 22:26, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> I've used hyperfine [1] when doing specific performance tests
>> in the past. You can build Git before and after and have hyperfine
>> run the two modes and compare them:
>>
>>         hyperfine --warmup=3 \
>>                 -n 'old' "~/git-old/bin-wrappers/git -C $repo merge-base $A $B" \
>>                 -n 'new' "~/git-new/bin-wrappers/git -C $repo merge-base $A $B"
>>
>> [1] https://github.com/sharkdp/hyperfine
> 
> I can definitely use that, but I was thinking that the overhead
> of operations such as repo_parse_commit would be high relative
> to the overhead of the new paint_queue struct such that it would
> be hard to properly measure and that it would be easier if I could
> spread out that cost across multiple internal runs (which requires
> a custom binary of some sort), but perhaps it's enough to just
> show that there's no measurable regression here and then
> hyperfine is indeed the right fit. I'll start with that and see if I need
> to do anything more complex.
Unit-level performance is nice, but doesn't tell the whole story.

We typically focus on end-to-end performance numbers when possible.

Another way to do it would be to use trace2_region_enter() and
trace2_region_leave() markers and then pull the timing data out of
the trace2 event logs. It's more complicated and usually only
needed if we are struggling to reproduce the performance impact due
to external factors.

Thanks,
-Stolee

