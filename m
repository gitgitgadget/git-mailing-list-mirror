Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD516C687
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735831376; cv=none; b=BzrVjTwiLt37/UdzDLuhaoRpXUJrH1nuhkW/6Nh2mSTQEWBL2Qe/mmPK9oO9Sxdsb9ZhqDvMxX5f3cPICjK//H5MBN8i5TrIaziuncPJ4KUzt5MgHG4icKJFHLEw07F2jCXGMEdAqqtgfi+lg9dEFZ7Z9lB34ciBD7Y0u+f5JLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735831376; c=relaxed/simple;
	bh=MyO+f841HQJ9YMz49KSmdUM2/s/ImuwDV/96Iig1+Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd3EVlwDLEaDwkC7VBPte2D3ii2/J27XZNp1E0ohBrJi7b6Cq8erBFUloASH7X01DDNGUTsS0vJggC5swEPd+pupTd6nJejfxuqPZpM4/TYv12Sz8qM9SYjZPrHtsRi7+7QWjKcGAps46yn+Dd0DLeASIQawc+I1DsAR2UUrAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iabcirpB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iabcirpB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so163759825ad.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 07:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735831374; x=1736436174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODqmK+c9P95028+BgwzWs1VOYRQ9WLoqQDOMB28JNdY=;
        b=iabcirpBSKOYhQqUE0uaDLExbURn/oykisvNNQp3wlAJqm/egKrLsBSfvpQ7lmPtmO
         6tlBG6KmkYdo5oz++XIIDsvYY/sKpZNK7lwteMWlmTNEt1qDNlxl2XTFNPGhObH//6G6
         G7TXIMKBCQq2SYqEblasi0UB2sYk29opAoMBYVOYdtw4MIGwKYwdE5WTyayMyFnsuGOw
         86nlCOP/3J3Omniyase375xQrSHcb+155ZvVE0mtuUTR8sM2Ws8cuX0Lv3oiMFBHhs5C
         TGyCdkqTlli1CosJMLzSvUMFSIhTfh+q1JY0+sGAvTg8gyf4aSriPt4hqByPyZ8bHuVv
         t2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735831374; x=1736436174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODqmK+c9P95028+BgwzWs1VOYRQ9WLoqQDOMB28JNdY=;
        b=w4cKzvEqG+iOI8RBn6a+XYu87Hi9vrPTUsclbVi9RD8EHatA90RV7wXHtjR7nrDIr4
         8Q1ehUH/DcxWwZAvZ8eUaXmgJgBzZdOG8lfgGW86Bf2Fe1IR6Oe5om6+HTdcjiDMVHjB
         XI1v1meIqnTuVjFFZdMV17Ny9nozUii3GOzPVg0TgF3K9s1Koz1kKngzt6xSgGHAMVEe
         520oMEXfkfIZcXwFbHw/UL/uN7Y0aWJ1uzYptUaom2ny3OfcPlmgAYumeirP5GJ0ocpb
         ShWbZycLP0+PPF7EYFyUSnrS1YcdfZdH/Wn6RtdU7gebyj/4Jpm44UI7w3bi/kpxZTU4
         9LBA==
X-Forwarded-Encrypted: i=1; AJvYcCXDPN4J7T/wwAXNCXFgJI9wq4tLaF6nlnKrt0/uu46eEEOwKpnN8JwUfh2Ob3EVymJqA6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrloZNTl4M4ETwX3bUwi0s3vAjdkqcsPOfw+o5X6NY0n0/Fz5
	WkSdZ6nrK81I6BhUTNhXITwU+zO7Wf8Bb6y0hv0BjIxRcIqRzyZW
X-Gm-Gg: ASbGnctCINJdtoOUwtCHQ6lUjW9RREcIyNUEWN23NAmf22ZbIesusndEY8mjAcTsrDH
	l7jUBIO8azHKr7PDVkOALApJp5vQFYUESKNmka1SgyR78e6OANCVXn1X8BoAgt00kQpKvNVWCGM
	FLfOX3ArOIrCeNo9/RPQP8Z3m682bGZOD0SMh5kQEivmcZJfk1zG8CxdeHLRrA5BGtDf61gdOOx
	8ppgGH/ZRneqca9wJKknlxMaoK0Mjqud5OyF1YKDBQzR5yCBeIHd++tHIp/j+NyJ+5InsZE0Xzh
	2R4Ns4gxaelKDsUkYg==
X-Google-Smtp-Source: AGHT+IE5VwtVXPOR8Q5OS1F11BItePE6q6keT3nx38Vs5QhEnv9bZaK+Lqugzf40NWGF65w+qeTcNQ==
X-Received: by 2002:a05:6a21:6d96:b0:1d9:d5e:8297 with SMTP id adf61e73a8af0-1e5e1e269e1mr53474837637.6.1735831373859;
        Thu, 02 Jan 2025 07:22:53 -0800 (PST)
Received: from google.com (56.166.125.34.bc.googleusercontent.com. [34.125.166.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90ba0asm24488593b3a.172.2025.01.02.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:22:53 -0800 (PST)
Date: Thu, 2 Jan 2025 16:22:46 +0100
From: Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: meson-test syntax error
Message-ID: <Z3avRmaMr70FOs8A@google.com>
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
 <Z3ah2YQSx4ZreBpK@google.com>
 <xmqq5xmxwabj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xmxwabj.fsf@gitster.g>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Andy Koppe wrote:

>>>   make[1]: Entering directory '/src/git/t'
>>>   rm -f -r 'test-results'
>>>   /bin/sh: 10: Syntax error: "(" unexpected
>>>   make[1]: *** [Makefile:119: check-meson] Error 2
>>>
>>> Due to this line:
>>>
>>>   diff -u <(echo "$$meson_tests") <(echo "$$actual_tests");
[...]
>> I ran into the same today.  Let's discuss in the review thread
>> (https://lore.kernel.org/git/20241213-pks-meson-ci-v2-5-634affccc694@pks.im/).
>
> Probably this one?
>
> <20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>

Ah, yes, that's the one I mean.  Sorry for the noise.

Jonathan
