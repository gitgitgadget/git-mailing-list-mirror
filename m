Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280831C84D7
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753006523; cv=none; b=GHO+B0bamyWTm77DvFZp8M3fhHOSH9RrvCBn7Int7J1j2zC+f7TzwVesNGocX+z6WI0CNxQRxjMky6+m5PDuwB21Zynyoi5Dx2pcSU3vinzhUBSoLY27hiYPGKR3Z7Fz1iRxxb8QooSU23gY+Z+bXjmg9hskPya8Wys8H3vnfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753006523; c=relaxed/simple;
	bh=4MtRzbgn6NKX+jNXwA9LWgOYDT5QAAxW1IBANACg9SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVT4XwIjjLgMIxZngpSrnfXhjNdz3wSVA94CS0ur0FxELatT6ICpw18cr/J6PnyVsDfUhkSB3VqrMq6w2NWKKGtvPp7XOqKmBN5PF7nVSWi8TfDlsUu9U6BTIFXxt54pc+pvu5Z/1iSgwgeCBLQziFRP3+M1dg0/5Go0Rkei2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUjpiEG7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUjpiEG7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45600581226so36086245e9.1
        for <git@vger.kernel.org>; Sun, 20 Jul 2025 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753006520; x=1753611320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GG/jFO8FCOxGS5eflrcKdf+G6wjLpCOlBEWPkvuXkUE=;
        b=ZUjpiEG79Q4EuL4vXpnBzdDl5+fRZ11ry9wux1Jphcii6nMXhrT2V6zI3YZHVed0eZ
         rzphNhP+XXUTQFzTeeC3ZvjiiNen/iDXGiOMudNvw62JDLXxpUxLnT2HuAEa+lTind2N
         uvXXswRP5/cjvhVbUiHO9HsXDk5jhZ6B0pI3GG/8kbm82qtz574p8/yjXdVE151QYJP6
         mTU/ukHmVhfeYMBO1ZMSVnIcgDchXc7mCEY52FZHTuFtl23MEoxXCZLdDXcGrfFKD1cL
         7ZL2ABDhR0EqoCGmC7X1JhNtjTr297aG/akk97eyOtixxVRkMjAbZQ+no9zm+4XTyW4/
         8ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753006520; x=1753611320;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG/jFO8FCOxGS5eflrcKdf+G6wjLpCOlBEWPkvuXkUE=;
        b=NdrdoYn8m8xzrlx5M26ZRavx5hxOmtwyRbXiAXVeLweIvY7LEboyEJ4VzpTLhN6s3O
         GTmMmLEJZ1p+IqnZensfAFBGbGvowneIRKqaFop/x7CawbPratl77yhU1EjYRLU0v/81
         57mfVOT+uesEPYHrGvT+st0p9In7pO0+K8BIO/hdnhyWt7ERjjcPa4G1o4zyat9h7lva
         LCnJ83374Usk472t1GksJjrbJSa/hoL4jqwl9hbcZRZ3Uo9nfqqoteRo6iRFxYtGbxF5
         HRfOlmYIc683hAt4TkrYiwnsOPH9g+c4EkJXWG9LhNV2lfyxog1cnXaiLX+56U5XS1ZX
         SXUQ==
X-Gm-Message-State: AOJu0Yxrb8ffuqQraWQJ1r4heQQwuveaqfVTSTxbBGrlBZWe6OikeRj2
	hhCnRqmo7Z1lhEWASCgZvx6+ZNeKcfK8TU4eyuRx4ZjbvAfhJTBZb+BwbtBA6g==
X-Gm-Gg: ASbGncsUQRs7WqrGdWIczaD+r0fVJ3AHMrGXZ9AbcPO+/qu+HoGLy7J4LwktyB2sX2x
	N88jeUNLAvY34FHj0Q8ICkvrzx2MgYcAmkNAXA7JPEJXdIHeDty0565IqzpB886AiczDdshbpH1
	EcTfY8Evuh2m4e2+iIdW+99NFf9CjKXEoETjHkwkcDCId5isp0qb8rsUPmLRo+xlSQHH/GPrz5T
	xemtJu3SEePlQYQ/wRXKv8pElQpJ+zHxZJDwpCPdIgcBkyJpS+ATbIDiADWnYT2FbVy/8UzEfSn
	XtjkTPD2RyJn+ptYD7Dow3EQvceNGp2ssrvaNWjTnTMhVmePrHzb5SDxScUFP0XM1y4AgPIOqvt
	YMlAL+9KE2z685FvLvEEALWW/wC6RCkdUyGnxVxspQoHXNoU=
X-Google-Smtp-Source: AGHT+IHEok4vV0DC4H44sC6Y2ZzYazZ0elYJDBpetLIg+OaORmzDUhUuY9fbfxGrQE459g+JwQIGuQ==
X-Received: by 2002:a05:6000:64b:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3b60dd4f79dmr14009739f8f.16.1753006520196;
        Sun, 20 Jul 2025 03:15:20 -0700 (PDT)
Received: from [192.168.1.194] ([90.254.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bbbesm7266025f8f.29.2025.07.20.03.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 03:15:19 -0700 (PDT)
Message-ID: <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
Date: Sun, 20 Jul 2025 11:14:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] xdiff: conditionally use Rust's implementation of
 xxhash
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 19/07/2025 22:53, Johannes Schindelin wrote:
> Hi Ezekiel,
> 
> On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:
> 
>> diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
>> index e69de29bb2d1..96975975a1ba 100644
>> --- a/rust/xdiff/src/lib.rs
>> +++ b/rust/xdiff/src/lib.rs
>> @@ -0,0 +1,7 @@
>> +
>> +
>> +#[no_mangle]
>> +unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
>> +    let slice = std::slice::from_raw_parts(ptr, size);
>> +    xxhash_rust::xxh3::xxh3_64(slice)
>> +}
> 
> I know that this is a pretty small file, but I do notice that it does not
> have a license header.
> 
> This reminds me of the unfortunate oversight to be careful about making
> (and keeping) libgit.a's source files compatible with libgit2's license to
> nurture a fruitful exchange between those two projects.

I'm not sure I follow your reasoning here. libgit2 was started after git 
and chose to use an incompatible license. I wasn't around at the time 
but isn't there a list of git contributors who are happy to re-license 
their contributions with the linking exception used by libgit2?

> With Rust, we still have a really good chance to learn from history and
> avoid that mistake: Gitoxide is a very exciting project with clear overlap
> in its mission to implement Git functionality in Rust. Gitoxide is
> dual-licensed under the Apache License v2 and the MIT license (see
> https://github.com/GitoxideLabs/gitoxide?tab=readme-ov-file#license).
> 
> Would you mind adding a license header to that file that explicitly allows
> the contents of the file to be used in Gitoxide, to get the Rust effort
> started on a good foot?

I wary of that for two reasons. Firstly over time it is de-facto 
re-licensing git as the amount of rust code grows and the amount of C 
code shrinks which deserves a wider discussion. Secondly it makes it 
harder to convert our C code which is licensed under GPL2 (or in the 
case of xdiff LGPL) to rust if the rust code uses a different license.

If someone wants to start a discussion about re-licensing git (and is 
prepared to do all of the associated admin in the event that it happens) 
then by all means do so but I don't think it we want to slip such a 
change into this series.

Thanks

Phillip

