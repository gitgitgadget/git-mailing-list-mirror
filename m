Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F335AAB0
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849921; cv=none; b=rFddTRF5O2Cq8WS9Dv/9bS/q5EGQQ+EqfY8zONbEsJnjORLnKv9aUl00AujjFSQR9M4TsMueRJLUYKlTqVmdliDMMwS5OKaTYDAhoeU1us8RCOxAGKZhg7CTj+RfIGbtZEnFljZnlvaB5LyKteV+RixTYOhW8gmJtXSw/IqiOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849921; c=relaxed/simple;
	bh=l2KXVPOH2EsBV4rBxslGaUwkQL09gkt61680Ww/H31Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lJ1HVQx3iYKkWcaj+vNRpEJR/fqEuphGr7PoFB7NOJjzCbas2k/5bVhSW5onqFmwydhwnNfzdkVwO3CZvMadeRVrhNjqIptjHG/V2tx+c9KoXBYRKKoGmNZ3WOtZyfF4L/LDYMKfE9iVHV1e4CH8MJAxwS8pKmuAnPT15Na/27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKUuzGy+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKUuzGy+"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso2000272b3a.2
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756849919; x=1757454719; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9kUXW6SRsQXD7oD+a7xDkSMvn1zBUMXuOTPPZYlhso=;
        b=bKUuzGy+rxGXfzzVn6rXi3iQJldjFW/BJ0SZfF67pR8erkPHH78EHvlF1w8NNLPJLL
         ixFPuruRHUGCMA9H7athNbZx3Z0NjzuZxmdDvcSVKcLfAA63kfjD47fe1zNC2s1ruK4t
         HhR7mL3Xd1Ox2lxipB6fyrzU4aDaWYWzaqv6rhyW3wzaVm3qDEF6naCkQPuddyEZyb9v
         w1uzBvD50eYRQ6NxyWPJFqgAnTUqfRdQzt539N6sKyVpA6mZqoMEzeWvbatDqiUPRvey
         TmeQiPnUupJ3RzrqgcXcHbxhLHtehjMMa50qjqlfI78RbmcnnrJyzO8jyZB+CaSaW6PQ
         VfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756849919; x=1757454719;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9kUXW6SRsQXD7oD+a7xDkSMvn1zBUMXuOTPPZYlhso=;
        b=kSIBqUD5KYw65264HzCKaj+Toez9MMaWZ2jn9Ibx/M9aEbnoQKbIHK4UHIPjMqlyNW
         NTzdZ0zx7b/IWoL26J+fCig2LInONbUk+aE8i6BuzY1ZhdVw/vWr/Fu3aTuMF+38jHIL
         wtFTQux8os4yZu3aaayohyjMhfrlVIpWPDBXywadNc1MvoijVnS8Aec3JptGqM7SN7vU
         rE0coHTBksIQe0UTg5b8sQpPKc9ln1E1qNAx6ZGod0l8qApYN6mzhZbsgomYOSpSvk5w
         UHOBJsK5D3sYXl3JiqpXD5nGnl8e2x+l3NRkCuYtupPAaGapMrbnQmrS/cwyN6EaSwCm
         UqgA==
X-Gm-Message-State: AOJu0Yz4r3R84AuxfvUflcs2eq2WfZkkZkdb9PVkR8VJiLPgryPSM0uh
	7wTGHlvsnBBusVOFz9hIJ6qyg48yM0rxKbmvLYm21lDNef4VFag3Fek6
X-Gm-Gg: ASbGncuVaoyOLqCaLZi9pmvj0ZhDQeOXLcr1vHfBlge1SSE0PpnFTfUVeP42Ymt86uG
	NFINVR8DToayn9nQon9L/dwylMIKFrMBgjGHKWy21AvJPHsADIEeaUaS5wNQ9w+g7Ta/tFeHrj1
	XDGdGK1apqHVplZCUOr4rFzIL4TWignf6uKXzg4eng4IYviZ7ECtLm2u5Qhy1QT1RNdks0zeBA/
	Mrz48szWvY9bTBgh1nn7eU8LYATAHfHapgvp3rCGYUqgAlmB2m975POUBfw0o4eGXT4RfKFOO7c
	oCgdVvTpbilnvKBG+U6vMAQsaKCX/44SNROeNSotAMVOTof393hVwzTHHmL36Zvo8w1eiwbOdUJ
	DXbjBDhnEZH1P+c2Cd2OZxvElE6vIAicjGk3OjyJzm+FJekqAzbDXB8xghUkOmouKaNM=
X-Google-Smtp-Source: AGHT+IGetwkZB4GaItyeLMPII9QkjYwtuUYE3qSeManOls5OzWlHGTulS88p18vWcQd8QYTU4PUoog==
X-Received: by 2002:a05:6a00:4b48:b0:772:282d:5a68 with SMTP id d2e1a72fcca58-7723e392a0fmr16324773b3a.29.1756849919328;
        Tue, 02 Sep 2025 14:51:59 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f0:b77d:8aa:fda6:1fc7:374b:6356])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4b99fasm14745844b3a.57.2025.09.02.14.51.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Sep 2025 14:51:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v3 1/2] repo: add the flag -z as an alias for
 --format=nul
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqms7cltak.fsf@gitster.g>
Date: Tue, 2 Sep 2025 18:51:43 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <E6D61B04-E10A-4533-BB5F-E8E066AB4ADD@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250901172732.98845-1-lucasseikioshiro@gmail.com>
 <20250901172732.98845-2-lucasseikioshiro@gmail.com>
 <xmqqms7cltak.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> This is OK and I do not want you to reroll only to revert this, but
> FWIW what you had in the previous iteration
> 
>    git repo info [--format=(keyvalue|nul) | -z] [<key>...]
> 
> would also work perfectly well here.  It is not like you are
> forbidding the command line to mention "--format=nul" twice, or
> "--format=keyvalue --format=nul" to allow the later one to override
> the former ones.

Hmmm, ok!

> The updated option parsing looks much nicer.  Thanks.

Thanks, Junio!


