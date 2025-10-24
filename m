Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12B2DAFAF
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314150; cv=none; b=BfDyeBqGHEBgcVdtTRrUiCwQPeAkfvKIiVEjwbDhy9h+54uB72XS3TDEl/ec8U68PnTuLMXmEb3TTqvFOVsr54yzJyjXRJ9UgRsYuAfLwdpkt4ZgEXczWvcT9y6MtHZM7Xwj5vWRivbI3Y2Qknv1oIcbP8cqjTBBD9DhUyJ0Cs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314150; c=relaxed/simple;
	bh=C+kAzwl+/V+2jE8q4xwMuZXHOPpyXC8Y2cTrc4yGZDU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F1AxhqMxlB3/l2seyFVxMMO48lAwZZRMTZPd37goZzu7gEbclehjy688AFaf3Jsxz0/gti5yp1n11SXH5C3VZrAH/6mWSdOtG9d/s3MNyDhhuRRJJrfUGBYF7SPZg3sGs4TW8d1pkFKQrPSsogC/1t8P9HQSeZsGUpAEolZnQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFTGFexB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFTGFexB"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-421851bcb25so1297035f8f.2
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761314147; x=1761918947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfVYkmXY8SfDVmNYBuM5lPa23x1qUKuM9adhccf31YA=;
        b=fFTGFexBvEmynWxNJDno9nJ+iloMY0yJGBUYWMcAJC4atNBrMqFq05ysI1qWXUaJF0
         1xk2iy7DGIglVzrBuLJ2LUXd8r6pYFNhdbXt7sYPOuBjOxW7bw3IYIalZ0lqAAQPizmB
         lINxSh82XLvXpz3/AUqWxUqBND6tjYHLoKzsBONfJ8P2qJwiL4L2vjPK/OZRbhHFvHgz
         vzPS9ZAXtqL83tiR3GA4aHgLCc2NTc0ad5VGNpf+xW5jIZiQ//VrgIM2mXNC4BzGWWHo
         1qAtP3dQweQRt2oFlo24PgUdAzPXsneCtdpsJpsZdW9XoF03Rrk3R1AIEsFLEG8AlnGt
         zz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314148; x=1761918948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfVYkmXY8SfDVmNYBuM5lPa23x1qUKuM9adhccf31YA=;
        b=r3OT466lNfahISp/wWSk+55gLlZdKySRlSvqUrmijTCJ4Bt9YPVhdTaFa3Enc0ksfI
         /m/FCRQ2mRuJpOdIShSiPFemAym+0oZTGw81dDT5EhQaebc6r/Uf+I87ZG40g51x+oa3
         B14uvexif3WyGU8ZLs2xRy8nnA6x6U0urOREvvm2klRLk80EGNz37R/TzUQ2RzBT6vII
         3VYTrCuOFVOcqz3BY4oW00UDvo5St81X+QxFZc2/Aww6srA/anUT5u8FlXnyJT2mUWiy
         TQAA5Rxm3gXN2ImUdNVPlxRisLY/4BbIKMkK4JviV7N1wUZfcgPsQkC3aOzkoq42q5ZQ
         M+hw==
X-Forwarded-Encrypted: i=1; AJvYcCW4g6jdHTJh7aVqVYLFdZ4aFPQrNiiK5iyj/fLISjakO9hsxT2iJnKjN6QUk9IkTWDqtKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FQ7KdPPvcHoqWBu/2x7KjXQa25Opnkc9d/Hoa0SsuytS8tYP
	4LH1Fpx5bSUB699xjTe/uykv9UrGNRYTFQbzmEXGgSLkA0X/u8v3ubrT
X-Gm-Gg: ASbGncs9t/SYtSbuIY8V+aYBu84ITXAAo6uOuXUSkItV5sgxdALfsj/PoXCkp291Mwh
	EnqIZevUPPDw9lYWuT8yCj65oY3mmDs1hCVFL0f37Td2Ls8VWxj0hm5vdfnqmApJIoLcMhxk8I2
	0TmPEE05zsDBSCGf9gMZuW1JsDCBF+RamW1tYrgESrJoRRPkqAIqRlnEAyeLe3PEvkz/6/5t753
	L3QXQncfnZA3k9v9axaxS/QzazcRQDT5J4MgCxGgge5oWunp+ou8P/htR+BEHmTQxfYo+kyZC5A
	1kGuDMAQUb0dRajlrB6btoa0Q6VWYTZEKtRH2W5XlIArlhlRCIHHepHodmwhVYoPpGB1MepE9QV
	RA6Rm+TXvS+L/mJRpYHS/1dHMBTGE05P0Cltz/Vq3h7ov84qB+IU6xE95eKyfBi7F8gnRWQpPS0
	NqoSQbMuaU5kzCZxDpiRRJR++sMEQPwDg8QhIDuA7s2Au+iMGgrqvf
X-Google-Smtp-Source: AGHT+IExPeDn33Em2rHMRzT+xNNPx6YOK5UNhnZeBx/8ZXfzLzgqtQII8uuHV+bLST6kePIZj5E9Ag==
X-Received: by 2002:a05:6000:2287:b0:426:ff4f:39d7 with SMTP id ffacd0b85a97d-42704d9447dmr18934616f8f.34.1761314147501;
        Fri, 24 Oct 2025 06:55:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm97178685e9.4.2025.10.24.06.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:55:46 -0700 (PDT)
Message-ID: <63d07c3c-ac4b-4ef9-ad90-d79f00cc7ca9@gmail.com>
Date: Fri, 24 Oct 2025 14:55:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] git-add : Respect submodule ignore=all and only add
 changes with --force
To: Claus Schneider <claus.schneider@eficode.com>, phillip.wood@dunelm.org.uk
Cc: Claus Schneider via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Emily Shaffer <emilyshaffer@google.com>, Calvin Wan <calvinwan@google.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
 <2688a523-e324-41bb-858f-b32040e1e909@gmail.com>
 <CA+GP4bqb775U5oBbLZg1dou+THJOjTbFN+2Pq1cBPqq1SgbxHw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+GP4bqb775U5oBbLZg1dou+THJOjTbFN+2Pq1cBPqq1SgbxHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Claus

On 19/10/2025 22:39, Claus Schneider wrote:
> On Sun, Oct 19, 2025, 17:34 Phillip Wood <phillip.wood123@gmail.com 
> <mailto:phillip.wood123@gmail.com>> wrote:
> 
>> I was curious why, when "git add" uses the same machinery as "git diff"
>> to figure out which paths need updating, it behaves differently. It
>> turns out that add_files_to_cache() contains
>> 
>>           rev.diffopt.flags.override_submodule_config = 1;
>> 
>> which makes "git add" ignore "submodule.<name>.ignore". Tracing the
>> history of this line, it originates from 5556808690e (add, reset: ensure
>> submodules can be added or reset, 2017-07-25) which made a deliberate
>> choice for both "git add" and "git reset" not to behave like "git diff".

> Thank you for your feedback and for investigating this. I was not aware > of the setting that causes `add` and `reset` to override submodule 
> configuration, and I will need to look into `reset` further.

You should mention the commit that added the current behavior and the
reason it was added in the commit message where you change the behavior.

> I understand the problematic aspect of not being able to add an update 
> of a submodule reference, which likely led to the overwrite setting. 
> From a Git developer's perspective, always adding it might have seemed 
> like the simplest approach.
> 
> However, from an end-user perspective, it's not logical for `status` to 
> show nothing while `add` has an effect. 

I'm quite sympathetic to this view, I think you should explain this in the
commit message where you change the behavior and see what others think.

> A more intuitive workflow would 
> align with how ignored files are handled even though it is already tracked.

As I said before do not think conflating ignoring changes to tracked files
with ignoring files is a good idea. The two are fundamentally different
because ignored files are not tracked. I would suggest adding a new option
such as "--include-ignored-submodules" instead of piggybacking on "--force".
Using a different option also means that user's will not accidentally stage
ignored files when they're trying to stage a submodule whose changes are
normally ignored.

> My patch implements what I believe should have been in the first place. 
> My implementation still needs the `overwrite=1` set in order to get the 
> diff files list so I can 'operate' on it and make the `--force` logic 
> like the ignore files.

Oh, you're right, if we want to print a warning we will need to keep
overriding the submodule config.

Hopefully someone with more experience of submodules will be able to review
the code soon.

Thanks

Phillip

