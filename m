Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C433CE
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655623; cv=none; b=OE7L3tGHXW8UynKs+7vCcTYw5Ldg0VoPduCbddk6MNouk9qCmEZ7zTxmKvKROwECfjf7VxC8+MqDhuU/yZ8bMjfjl4fYDr7eV5Y47JR7J1vqHNmsDREc73KokiXt3ABUZqSbFonXY1MZgL2iz8CetPX+jp2iE/nW7zjNbjOtY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655623; c=relaxed/simple;
	bh=zeYwIw9t7vpCoy3wuq3UJoYtdw/vCRe89uHAzx8WkbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmDWS2d83e8Jl1224yzNRQ6IdvC9JLqVAxo5IrxhVUZxB+6ZNG08iPfKhaPJCZxQwqTABrWkZRip7G7S5ozQLIun87WZya6Kjvdj4XL2QOMe+UhbE29NxkKDWEqNSaaAS2W8vAKQntWo4VbmKUgEzOVcRtznqzcsS/dY/3zyPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu+q+5SG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu+q+5SG"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so2666499e87.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712655619; x=1713260419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8/+g54xnS5MinWK3DA16e5dxRTWvJotzLYdA5Twha80=;
        b=fu+q+5SGz6EXx8GZVt8SKT0RZEAHMgZbAQx+gGpUz2exJQU6aqQtru0kcrhJ4CBagZ
         8JQhEZ9ji+8XSDos3zWNQjzFDXi5OUbRkW7q5MAJpGeUH7RNhu33oaNEQMKIbIsYHCBn
         ITbXDkkkEUKjhgqRdYI+qSRRMiJ8claErzGws2DmxM2qma9yAuV0uKoi0NZVSSLR7s8G
         sn0G/IqJscmWQ9PuyH6iJKQzsYLmbs9Pp/4iQgek39wpPhtpPXn9NlhyqMHnPLqScbNt
         0cfrf27MvmNBnamt1BvPE5CWJGLOHaMv7NOtmYjjiTQpjlS4SY9NLHX4CYelJyt4PKGt
         l4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655619; x=1713260419;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/+g54xnS5MinWK3DA16e5dxRTWvJotzLYdA5Twha80=;
        b=lHKK1F+SlBqy3HgvAnekmdvaZqRM+4FDn3TI/eiaJsZ8/zO+tc/1KWfInEsN+Kx4Y1
         xm7hExNn+KvRUxBNoLneZDfWcQ4WpCtR+ZPcZXb6Vh6NP4iOhDNKjDfeUBVpg8iCAqiI
         SqT+aPJ8eJSwaQq02zRxcWlNj6edezXER5GWsiRzRdozXnHScLJv1oXV2ymTZZ9QYdzP
         wi6oIcySKHq4UL/MNnGhXTsNR8nRGlhFSI29/FHdWLT10HrQCGAUTJQroZV38gQt9JIG
         ROfUEOV7A4p9nHg2VRKDVVuyyVP6D1UASby74WZOjvdf7cPcw7/xPSp7gguWrng/XUWM
         EP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuLJDjrhsqA16hhxjAhrBtOYTUS2eo9dTcXg/5nIbeLKl5uodidGhSaGlfDakKpq9eMSY7ktk2VxcLUHq7F8vhTa9Z
X-Gm-Message-State: AOJu0Yx3oBA85yhtg8UI5cBDtkMQYzgVxp9TGiJ7kuCBdDBWCvKtXCrB
	IltUHXIGWcb6mVEiLBC3Ex0H37jSrgu6nB2KfD86M6F+t+hw6QBE
X-Google-Smtp-Source: AGHT+IFu6BxPPwcTXPRIL3F2Wjtm2RFN3GTujo2ZhI7yQPfZhn+rlefAUy0NZ7MruOcD/1D9Xw2V1g==
X-Received: by 2002:a19:431a:0:b0:513:2b35:2520 with SMTP id q26-20020a19431a000000b005132b352520mr6508744lfa.58.1712655619318;
        Tue, 09 Apr 2024 02:40:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id dr20-20020a5d5f94000000b0033ea499c645sm11204398wrb.4.2024.04.09.02.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:40:19 -0700 (PDT)
Message-ID: <5663500c-ea40-45a6-bb7d-c906aee4350c@gmail.com>
Date: Tue, 9 Apr 2024 10:40:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: rsbecker@nexbridge.com, 'Calvin Wan' <calvinwan@google.com>,
 'Git Mailing List' <git@vger.kernel.org>
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net>
 <037001da8935$4a6e3720$df4aa560$@nexbridge.com>
 <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net> <xmqqr0ff8rwo.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqr0ff8rwo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2024 22:29, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> As mentioned in the original proposal, we don't have to support all
>> platforms in the libified code.  The main Git binaries will continue to
>> function and be supported, but the new libified code will rely on newer
>> features.  You will still be able to have all the Git binaries and
>> functionality, but if you want the new shared library to compile
>> against, you'll have to furnish a newer compiler.
> 
> I thought one of the yardstick to gauge the success of this
> "libification" effort, if not the purpose of this effort, is to
> allow Git to be its first client.

Indeed, the last set of patches allow git to be built with the same 
library that external programs can use which I thought was very welcome. 
This proposal seems to be backing away from that.

We could have a single version of the library with a set of external 
headers that export a limited set of functions in a gitlib_ namespace 
and are wrapped internally with definitions like

static inline int foo(int x)
{
	return libgit_foo(x);
}

but that still leaves the problem of symbol visibility for the symbols 
that are consumed internally but not exposed in the external headers.

Best Wishes

Phillip
