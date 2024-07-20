Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10FA27735
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721515033; cv=none; b=Rq8zNSNnVsyc4pvNMOLQhGjVXfKfx31wVOuBCg6vVvtrFmFf0QWN6LN+dvOWh1nD6drtX5g6vCljghWNiMtQIantrLzcPzsuloGeGXX9m9S2fks2dzS+ijfjbU+XqsL92GL+feinld7ArzZWKJhzLRek2GbZ92iNSIFU9OxRtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721515033; c=relaxed/simple;
	bh=basljeJaChSrAMTqNeSNlKrRetJ/Aq7iIK0MZTaTlLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpvCUu3QW6BxVlr0Y+SNLSG2j7G2DytAK4pTlZe+XRUVxueEArTqfVvXmY3CCeu64Sl8bn8WkbhNsR2q9ZZdzkhWAF3unuznfmHuG9K9RCD31I+IOOltsV2Z7vd+2xlablDNy48c+H8mOkIPId4kwbytEJpf2GFNT2GNiu1I/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNCKEvJg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNCKEvJg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427b9dcbb09so22411405e9.3
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721515030; x=1722119830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFaHPL2lpXBmRMHSVFeZpX6beSm5Y4JvY8yzx7y7zo8=;
        b=iNCKEvJgplc+jPAEhsXoUThrt1/IHdLbsFaZcOJ8lFK3cb9ZuzkpbEgx/3K8P6nP3w
         FD50i+sCPU4Ki2ebMMdDhVn0+ZD8GNPGXhBuR0p4P7mMOoTYlLqVZrIeL9/RZrzat0iK
         giVit9grhoJ+o+DWAAkO3x35JnHhchUuvTln13kra31XwxDhT7KhxngYuH9aBBaM3sui
         ksclPVB1AqOkDES6BOexJOEWNGuNvk7hAHNiBumDyRwZfMcoMvLVx1GJ7G3Lzf9ZPH8E
         obLGzPWmDPu/960Jq0KvdPWpXYO8wKqtDk2VEjblYjajBwZygMDzw0S6TZR4KlUg6IzM
         aqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721515030; x=1722119830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFaHPL2lpXBmRMHSVFeZpX6beSm5Y4JvY8yzx7y7zo8=;
        b=coteW/2mF3DjJXf6K/us4MmLyp3+bId3BX6jPpf1vP4etP6VSOmthavR4t2At3AVy9
         PRFa0xho6KKQa8AJYxJfS8ZG3V5pmuzQZCv8VWUzAhCSHj7jC3RyHc+SjBdJ0YSbFpXF
         pzHQUGhk8m0we5MGnK/9IA0kVWya3fu39mXMk/pcI988438Qy3+Hds6rDQlbJQlzFn/i
         vWFfe8/30Zpku7QVeXLlxxADSaJsyDGNfOWHuJNdk0aZa/7l4zMNFF7qszDtIw9A5C2S
         JZ/u8pSRuk9qnGXLkswSW2ZQ4ifylTngCcEbuvKqptOOLoWuzgbwbOh582M95fVx3bO0
         J5dA==
X-Forwarded-Encrypted: i=1; AJvYcCVEqR7AZ2DWkHH0LessvDDZBupQvXP9JKFBMnPOQr4oLOgf7Jk24OghH2RKVAGq448ijRhdIWI6UlE76LWgDBQ2sljt
X-Gm-Message-State: AOJu0YxCnMZFB+CK8zcuf5YsLWWZQlqPxg1t6r5TCIxdE+a1OlZCMN9M
	QnE8zROXM0ALk/8eCAe4KGOZt73UvQW4b/5xl9MW/9bK6BpsgJ3g
X-Google-Smtp-Source: AGHT+IGzt6gWz3A3KLRBL2gUiIQ4DOgFUbI1Wvqtz5jNGiOJP08Qia6kzXh26670lOiPt40yrTnLlw==
X-Received: by 2002:a05:600c:3ca2:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-427dc558a45mr15848975e9.24.1721515029953;
        Sat, 20 Jul 2024 15:37:09 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427e29d11d5sm1444625e9.38.2024.07.20.15.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 15:37:09 -0700 (PDT)
Message-ID: <bc1b9cce-d04d-4a79-8fab-55ec3c8bae30@gmail.com>
Date: Sun, 21 Jul 2024 00:37:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com> <xmqqfrs723bp.fsf@gitster.g>
 <CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jul 17, 2024 at 04:09:17PM -0400, Eric Sunshine wrote:

> > >> -    test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p

> It's also curious that t/check-non-portable-shell.pl didn't catch this
> use of one-shot assignment when calling a shell function[*].

It would have been great if it had caught that error.

As a reference:

    func () {
    }

    VAR=value func           # this error is caught
    echo 1 |
    VAR=value func           # this one is also caught
    echo 1 | VAR=value func  # this one isn't

Maybe, catch this errors expanding the regular expression we have in
`check-non-portable-shell.pl` isn't the best approach.  We might need
something more sophisticated, like what we have in `chainlint.pl`.

Perhaps someone with experience in those scripts could give us this
capability :-)

Thanks for your message.
