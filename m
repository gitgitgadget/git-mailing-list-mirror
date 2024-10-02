Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041511D0E34
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886974; cv=none; b=hcZ5YRPLkKdtIyXg6SOLWgeLifq43erfQHv38XWrIFhCaDNM/Ccspqaxf29wvDNj/pfP49j2gEuf2aYSaxRmSn6g3fqPE8Jx4ToAZrABwKZKtiPxzg2soZedhrtrdUJ88GLB+2eoBipksI1ELTda+tVp6cuhFT69zDe8q2vUu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886974; c=relaxed/simple;
	bh=5Im2FgmF0xy3a8+r0dN70ZOl5Cri3l4WYeP23GB8SRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfZ3s3RExHXiC8hI2eIeTRdINbmzxV1xbhqYAty+//sBaAJUINqWRrjBikH0f9zcpdCKvjYJ+1z//EhlFsdv81RwntJnSXhOgAdIvW5zvq3eowaqWQAdAhH9Pv/iLUurohxQGI2r+bTiKVuAKdt7diCHy/ZVdsKaIno9x73iwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpKwukzc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpKwukzc"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cca239886so6427f8f.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727886971; x=1728491771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HljcWphIVOF45JFm+yo3SqSjfYQSd46jx5vm/OhquO8=;
        b=FpKwukzcW8DTnwKoAmgHZxr53PGCscyUqto3ciSIKYGTBwkfTlpx9hFnn2QaeDZ2Qv
         woP5DGOUIard/NrmmVFhvKxFtpmJ+vHPDxJKJLB56VygfJs24zAlsug1QYMKQ2LdiVSK
         2jpWHNEbAhaToyrgFNJQJTuUmcfrW1lXx9kT15wpW4CbCRoJkf1XPxHbVlZBQV/hCMgu
         l60PgJTkBHK4P7mvJEXrO8Oci5DAhYeK1lQwwL92QMjCR9bALhvdws2s8hLm1M7Fe8tl
         H59T3WDhn1e2zaDuS8sMAzN2GqUO6151mS/F330x+7nw9vJNvVXOXtfJ7zTXUtAhJyJV
         +OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727886971; x=1728491771;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HljcWphIVOF45JFm+yo3SqSjfYQSd46jx5vm/OhquO8=;
        b=WOksQN1QvNGsSzJE+jTiWjIw2fiqNynTd/Z6AH1PNTv8E9DdvHOVqEJ9pBVc7rlzxD
         lEZ6cS1D2nCDu6RpKvh8eHDzNmb3otpIAuVQkP8g4SVJMKriDt3WBOp7vBulcSn2JVAO
         0nHOYnUeeweHXqt7kCU77dV/kwc7ZuePvc3Q67Qopg4U1HZ2mH+dikES88p4lBZb9jvq
         T41USeSL8pqroM87wmooEZwUuwtawr/rpps2cUsI4OGar2QlcS7V5hespBy/Q1aszdsB
         mPBnTtPvQw8JxeuNsXlH9R9TbGPl8E+V1kMaafQKU/SdI4x+ReWGwk1rcA/ISwSbTELB
         S1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQldPmbVGev4vHObmcSNKNfsFifiIobZC6S7sC9IGbVKoRmduWVKWklm1MSHyrQmrenmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/n5vD81PhijW4yvKDriEC9YdSqKVcuLohR2iDS/+3hFq6XWwr
	28pUDTzKyqGKHeNmFAFiio1YFoJeVXxaF91mTB9zj6T8uvhds1N+
X-Google-Smtp-Source: AGHT+IGyLlym+PZwsu2zG1GvWxsiIIQdSaZMNEtbnzpTlISvUydSNKYxAZX0ZVlGbXa4wJcinL83eQ==
X-Received: by 2002:adf:b609:0:b0:37c:d198:3167 with SMTP id ffacd0b85a97d-37cfba1849fmr2908270f8f.53.1727886970876;
        Wed, 02 Oct 2024 09:36:10 -0700 (PDT)
Received: from gmail.com (132.red-88-14-49.dynamicip.rima-tde.net. [88.14.49.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730e55sm14343427f8f.82.2024.10.02.09.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 09:36:10 -0700 (PDT)
Message-ID: <b1408033-5366-4e2f-823f-7957a9f30fe9@gmail.com>
Date: Wed, 2 Oct 2024 18:36:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add-patch: edit the hunk again
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
 <2ad1f7b1-714c-4d6e-89a6-fd65271222b9@gmail.com>
 <6f392446-10b4-4074-a993-97ac444275f8@gmail.com>
 <556ba87e-1eee-438d-848f-bbc5558289fe@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <556ba87e-1eee-438d-848f-bbc5558289fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Oct 01, 2024 at 11:02:53AM +0100, Phillip Wood wrote:

> I'd argue that users who are not familiar with (e)dit are more likely to
> make mistakes when editing hunks and are less likely to be able to fix them.

This series is not about making errors more descriptive or making
(e)dit more (or less) accessible.

Editing the original hunk is already quite challenging and prone to
errors.

This series is about regaining the possibility for the user to see
and correct their mistakes.

> > > This is still missing "n q". Apart from that the test is looking good.
> > 
> > I've been resisting the idea of "completeness", because I think "e y"
> > should also be fine.  But I'm not going to resist anymore here :-),
> > since I don't think the test has much more value without "n q".  So
> > I'll add it.
> 
> The reason I think we should have it is that the tests ought to be testing
> realistic user input and not rely on getting EOF which is unlikely to happen
> in real life.

Sometimes, I use ctrl+d instead of 'q'.  So, some of my interactive
"add -p" sessions can be described better with "y" than with "y q" or
"y n... q".  And I'm real ;-)

Of course, non-interactively: "e y" or "y" work as expected as the
test in this series and others in t3701 demonstrate.

Since we already have other tests, I didn't mind adding "n q" in an
attempt to move the series forward.
