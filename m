Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0352D7DF0
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881231; cv=none; b=tvCEWHhZI7ELiaUKWJG0QTUBFMcIMoWyUZVPHXy/tXh4CP3j8ntYeBgwlZFOrxfZZikri0aIi/pYVJNVD7n82aTUX3PE7VGGD7EA/SCpd/EMrdK5r9j3Z56d9fSoOLAQihIptxkouQ1QXb9H+/Xb419MJgrKW+GgWSbuxlHklBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881231; c=relaxed/simple;
	bh=Wq4jWGmeVjDmzirNVZ0iO2rjar/sj1KUWKKVND/h30s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0qG5pKPbbj33aJaDO/WAho6J1ES3z/Y1buax/1ddOfXQqNlUHLqD3Bh3B0w28qW849u9FXcW7XTjRgpboKa2YcJqDGqu35QBfPPkqLlTOxx0rjcoZv2sIb4tFSDIS6+PniprnnZaNUVNvRT1y20ndMj4EnHloH6ptZnNJE9VRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS2GzxcO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS2GzxcO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e414f90ceso2176775e9.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758881226; x=1759486026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFPU7G7z2a0rDkSP/9KrEg2DISTdk8gmKTarP8rRej0=;
        b=FS2GzxcO56+QRC6om8vU58XCqC4BzuJGYHi5PcwBY6J7rQf7rw9DrCPfimrMhmySaF
         A/0HeN+z4xU2RNP5zaBKVJvz8tUXAEPFMl8V+/RaChjhszMP9Dsh+XE0mVwBji5QFHZr
         GnxDhpSHEsN5l9oDswXWxGhYrr6SWXbo9ySriSikvjBWhYU0/VrNicgAr4LxvVA03vQF
         vBA5lbD5Q5Dm9xhN6c4fTa4NNIP4kCxnXM7leCslUh8tplXH/tQ84PDa9CS+AxayL2fw
         Ae1d2vSzj1EDE0qv47Ux61FGsJhfMbBmBq3B+8YOQkMUxr8/p9mGHHV8AUwUXAKQ1ce2
         3m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758881226; x=1759486026;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFPU7G7z2a0rDkSP/9KrEg2DISTdk8gmKTarP8rRej0=;
        b=M2ieYc+DFJ5/v01OYW+2B47o6K2QRzmJ5kNke8SkjdoWygkk1W1tLR9zsduIIL5ie/
         6J8A/Hn3CeGDrjQQe+UUGNxSBj4xAf/8j4ou+ciVRjO8UKM2iArA+H47U0TMF+4c+jQp
         K61UemPIUQmRqEk9hWeTvK9ibNbICoY3WXuBL79iH7IF/1T2/tMEq4p6b19KREvp//sh
         7nk0v8UjlyzYi/wBXCRQK2ib7hEBGiQIcWhLBJUCpPRQi8OJfs9j732tAql05xIG6v+d
         lphbXwfL2p8lyN4ivKs/3rXQiEQktmbBd27ecuf8KElwqxnG7+UjNIJwEP3HJdpq8dtl
         5SYA==
X-Forwarded-Encrypted: i=1; AJvYcCVXkHgZE7gqhjkwmrNYhkAAWnZF32Ep1ZxmXnKm+G70XY0+PC0GcG6gwzgzpcX8VeA9r4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOoUvbZCj0atlRyEi4Df6U3tI3WPQzl5KoZEXop6zBDVXaFbj
	MQCHUGgTAUSyKF4gCBs2fpvAklZ5EdIzf+bhv7LcdHkKrEgzBQMmE1zl
X-Gm-Gg: ASbGncvPWBJv8v4AaM8LTBUhndNCvIbNBiEJ2nDhhpQd7yE/+Mu7h/4f7t4SsdRQVsX
	ijZJGqKzcQOhSF1t/tIRZCr34G0RbCPcAmKe97XpK4ljCsgGbGyXDtN4rOFIMVipJvTViqssv4k
	MHGn3R68Cu/X4rM87YcGXDV2MZtpD2HxdJ4IFFNc2l6weitUocsD/hzGTTtU43S7wbFFK5Nd4x0
	4brNakj4e3/OnHddFPs1QHeqq6WZmdEqdo0Xx8yfVAJlDvmWgdPJ9XaHX7J/IJBCLKaVclwdjmt
	H93yvUA/lQLrJQQoLEul3B8b75X+fnXyqJ0vzpht+kakvpMRbyS+kxne+wGhT6Li8LAj/RjgiNH
	60wsrkh5gdTOo5s9zfvhOcUSgT3lpKlMmoPVvwlbHLuBzDElyPMo8TrBCYQ==
X-Google-Smtp-Source: AGHT+IHdFttZvf9z8dYxbOrzsINlv6hMdy0sUwTrQqa6AstC5gMkzoiAsjmtstug2EXAGhrgpgyjfA==
X-Received: by 2002:a05:600c:3b29:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-46e35d31f08mr52101005e9.35.1758881225657;
        Fri, 26 Sep 2025 03:07:05 -0700 (PDT)
Received: from [192.168.1.194] ([84.64.105.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33fede76sm65810835e9.14.2025.09.26.03.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 03:07:05 -0700 (PDT)
Message-ID: <20140030-6bf1-4393-a941-bfdbc69c79fb@gmail.com>
Date: Fri, 26 Sep 2025 11:06:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
 <20250923174825.GB1136654@coredump.intra.peff.net>
 <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>
 <20250925022555.GA3202669@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250925022555.GA3202669@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2025 03:25, Jeff King wrote:
> On Wed, Sep 24, 2025 at 02:48:26PM +0100, Phillip Wood wrote:
> 
>> Thanks for putting this so clearly, I agree with everything that you've
>> written here. Another thing I'm concerned/confused about is how the
>> exception for a single project works in practice. Does it mean that a third
>> party that wants to re-use some code from GitOxide has to check if the code
>> originally came from Git to determine which license it is under? Or does it
>> mean that anyone who wants to use Git's code without the copyleft
>> restrictions can do so if they launder it through GitOxide first? Neither of
>> those seems like a great outcome.
> 
> If I understand the suggestion correctly, it's not to license it
> specifically to GitOxide. It's to use a permissive license (like GPL
> with linking exception) that would make it compatible with other
> projects with similar licenses (like GitOxide).

I was responding to this paragraph in Johannes' message

     Note the exception? For new Rust code (and of course excluding code
     that has been ported verbatim from GPLv2-licensed code), GPL v2
     could be used with an exception along these lines: This file is
     licensed under the GPL v2, with the exception that it can be freely
     used in the Gitoxide project.

That suggestion is pretty close to what libgit2 has in its 
git.git-authors file[1]. I'm not sure how practical it is to special 
case just one project though.

Thanks

Phillip

[1] https://github.com/libgit2/libgit2/blob/main/git.git-authors

