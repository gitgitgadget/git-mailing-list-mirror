Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F41BB686
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431248; cv=none; b=OTFGjQyTG0T6WNiOTTrD/p5CiWWzz1wE48hcwS8hWGQPz66Hx/pny2VpQkc/ss0vsOBtqpcuP/1bzkgpOh+U+qtIxj/Y1HxugfSLwepLNwuRFY74wdWJbJbuMRtFhL3gd4L7qdsSm1FaBXp0ghhaS3sDGUhSS7MLpzhsfP2KG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431248; c=relaxed/simple;
	bh=87pHJ3uiqPEKvG0ntS3B+VWJtt1f9oflmLBD+NDBiHc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KzYL2whErvDN7DcfFaWzuRMfZR4pzuvG7TYYBX2S/HwKhH6aLQo0b+25iVAA8AjtuEX0RCMjJ6Gu6GAbsfcZsDECzHzkg8zCNAC8jNhvEBk9DYwPqdplmEGT6k/LNrEV2BcFKWch80xTisGNg5pCEYiWTjpVKarypshfMq8EN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCVcVVsC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCVcVVsC"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso2132610a12.3
        for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727431244; x=1728036044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUNZ1ZX8av4dkMoCwLaCGLmtsPKVlZaDEKtpfld3pjE=;
        b=CCVcVVsCwS6yeY7gB0ey/svhL4Q11nWO5l/TCnh/I2Up2FnzBZlAanRLbontuZdvme
         zz3Us3xdLKS+M5jCHPPjX7A+AVyq+BM8Jh7AQMZkwY6sUpT75Fo4MjGULF7wZUzh8IWl
         gwRX4WIWCiwwrjVXSjRilxy/jQL0jVeNzU1y2fq7lWX08ccn0Knd5tdOByjwwOp/ZgMW
         kjfYdd09lIFIWJoqwjvQjE3ugvrubmGbmXFmCj6yXsky1uJ3mRCLh1jPbJmjRvusRqBO
         T4wSsregj4kEHDibU0GT27t5Bb/vnjm3jftEpUUsRBhgNn+RBXchuiBjv6Cd1k5jxvlt
         LkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431244; x=1728036044;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUNZ1ZX8av4dkMoCwLaCGLmtsPKVlZaDEKtpfld3pjE=;
        b=ZU+kmXA3heo4o6bS/dtGakGHyudeIEyax3M9iDqbh0a7/N30QiJJoNpl61XagSvR4A
         1DKIufO2RRF2mlQ7vwBZeBnOri5+57uBp9PPDLcgsl/Hf5sILCPt5dYPBoOHr3oX9Rfb
         xmqnjPM4okQBnkOVD/io2oeXEDHQqHxxiAzATZnJUxw+hl3VmfYnw7zh5PYsxOcTh9br
         lqJgvGycgdKBLmbFQ/yicr0k2ixkhQq/bUzFY6UxcAGsLnQxawJ35c/zLW/FVJr4ufcQ
         UkEhbn3ftaEUl9LU7KBf/OTiAACBQqP4Svzucp/nua+3UJX2WJDtkZAwRPo3mCRV+9Wr
         jzoA==
X-Forwarded-Encrypted: i=1; AJvYcCVlg9AXH/v7kPWmdOrqW71vmyzvKcOub8Yw/0wYjrydSCnlEflYcGpguZdPi+YitGBQorQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpcJ4BAW9z+2CRR6UmevPhGnjqVcUAGBYsZwYO5KEaNEh+STd4
	1qjguN0+41PUb9tb4Y2yvImQEkDJXwDb9C56KdmZtwC90wB/hEeP
X-Google-Smtp-Source: AGHT+IHzYQUqOMpDcaHp5l9r/hB5osVG72xNLivNR9LZ7hD27C/PjWr9Bjl0rHs3DQFvlYmwzMWumw==
X-Received: by 2002:a05:6402:2318:b0:5c5:c060:420d with SMTP id 4fb4d7f45d1cf-5c882603693mr1771532a12.25.1727431243733;
        Fri, 27 Sep 2024 03:00:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245e9efsm955819a12.58.2024.09.27.03.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 03:00:43 -0700 (PDT)
Message-ID: <b33076f2-ca01-4286-807c-f4b45a00d944@gmail.com>
Date: Fri, 27 Sep 2024 11:00:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Eli Schwartz <eschwartz@gentoo.org>, phillip.wood@dunelm.org.uk,
 Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
 <71ed5967-0302-42bc-97c7-81886408d688@gentoo.org>
Content-Language: en-US
In-Reply-To: <71ed5967-0302-42bc-97c7-81886408d688@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eli

Thanks for this, it's useful to know how meson works with Visual Studio

On 26/09/2024 17:04, Eli Schwartz wrote:
> On 9/26/24 9:55 AM, Phillip Wood wrote:
>> One thing to bear in mind is why our CMakeLists.txt was introduced in
>> the first place [1]. Visual Studio's CMake integration means that so
>> long as git-for-windows is installed building git is simply a case of
>> clicking on a button, there is no need to install extra software or
>> plugins. I'm not sure the same is true for meson and I don't think we
>> want to end up supporting both.
> 
> 
> I can't really offer suggestions on what may or may not come
> preinstalled in Visual Studio. That thread does suggest the major
> problem cmake was trying to solve is:
> 
> - having to install the git-for-windows sdk at all (is it still
>    necessary? I guess so, because POSIX shell and perl and mingw
>    runtimes. Unsure how either meson or cmake could solve this.)

If you've got git-for-windows installed then it has the POSIX and perl 
bits that are required to run git and the CMake build uses those and 
downloads any libraries it needs with vcpkg so you don't need the sdk.

> - people who are *unfamiliar with the command line and want a GUI*
> 
> 
> Meson has a trivially installable VS Code plugin that is supposed to
> handle setting up the project for you. You can generate either ninja
> projects or Visual Studio solutions. "One may need to install a plugin"
> is hopefully not as big a barrier to entry as "install a bunch of stuff
> then go to a shell and run make vcxproj". Is the criteria truly "must be
> one button click"?

Personally I think so long as there is a simple way to build git without 
resorting to the command line that should be fine. It sounds like that's 
the case with meson.

> [...]
> Stuff like "how painful is it for a Windows contributor to set up an SDK
> and then also go mess around with Makefile targets and then load the
> result into their IDE" is an interesting discussion to have but not
> quite the same as saying "go to the marketplace and install such and
> such plugin" is an obstacle.

Agreed

Best Wishes

Phillip
