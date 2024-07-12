Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8ED1741F0
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801478; cv=none; b=j/et4q7JQ5Y29PmckM22qU2NU0xdBZLfdiWcvxLrDijWEgWIqrlFdb2mna/NTfDYhdwpyo5IQ1fTWD0l7FV/djnQbFpcgjKv3z8RmV/fAljlv7BGASQ2WXtvvCgYLhFHjHL7OrpQey0rKqySOtUIJg7ujvqeHNUCFJLmBp2G0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801478; c=relaxed/simple;
	bh=7XFuIdmQ/rx6UnCeu3TVFLbH2ai1D/oWME5WMfKY1YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTxB38gxkKZjdaJGKQ9AfXYgWW2hbG0vzLOK0xsgpKzeYwXS9yPA0DO+e0n7IHZxXYw1KtAKwoFEc7dPU21itn2C9ifPas7m3KOA6I2VOlMkwxu9iYSHLMfxdPaeLIk58ZE//+PQQdvARB4Y8np+12llz8i3ELY+0oHYOhKfjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0QP6g5w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0QP6g5w"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fbfb7cdb54so5536675ad.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720801476; x=1721406276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZJ/rAzPzXcFceaBd4qSKf4wkcod8fuL5e27YMouGZc=;
        b=R0QP6g5wbR5WPhObtxQPQtm/PpKeRVuLWQgKy1Cb/8eDs0Venr6dxoezBKhRFT5x0O
         M4Wqb7GHjfQgb3JCVA+tO3eX/VeBJz2pGO1/A50M/i3s1QCenit3Xu0DlH0K+cBZws7G
         n71xpwaJ3YwoAMvIt3MetV/sgkZS375EgSszcPsCQRwjDeH3e60HM4ntHxWONPnibMp6
         EptWEbqv1itbhwHHmhcB84NJT4GU4etDaSdupU5vKh15F8pjKEP/MbkKk/q5hLkyvhzh
         FklehNtxriOvBE5VqbjISVCDBQsp2Rf2MulyURdLNerV4JSgi+sbCw5oYHqzm4l8MY8J
         YR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720801476; x=1721406276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZJ/rAzPzXcFceaBd4qSKf4wkcod8fuL5e27YMouGZc=;
        b=e6TU1LdfUTpQsoJevVmjoUbN8OBVAWm5Iylppv0yvVlV8ow8PSHdRuzeLu8JNbMr5g
         /ymZRg0qUzagEd8LVS42LPqs/BzlBD6JIaXx8Y/+dHqorlug9kkW4QOWrz3lAgS53LOA
         80PGi6SBMvyU4aWdyWpU2dYVZoFzc2HGEVxZn0bfdJCM8URs+wHBTh+XCYI9oQqQqAKb
         1DRI6QjlpquPmbrW0vRO+Kc0xoZLT+q+pxmMT0HufzO9ZwJ7mhXXJy2+2V8V9+dzzb43
         CFqw+l+gE75Sr3mYDGkze3A5BLHxbFgvqn7+wlMLhDy+6v1lbnIhuFFpGaEH3l47uRAQ
         Oj7w==
X-Forwarded-Encrypted: i=1; AJvYcCUFRPF/COUPzV7JQ+/0Zaq9D8ZyzbsDHq6yZ4nZ56boftiu6Pg/z2j0f/jX0PQCZvvE71YQMNxfys2QHULK6R0IiL9E
X-Gm-Message-State: AOJu0YzSETfXGdxLiQDvNzm1CmzIWACJdQWhieX6XJQFXCwivZdI4zRM
	B5BQTAnHmmIYdeZO9NnhM9WlTJH7JhoGtsze7wFUKyUuFsB4MOzc
X-Google-Smtp-Source: AGHT+IGNxvZ22BvPJHM5q3SxqSGVVhw79mHlBUHW2PAvR/vlXv0F9kcc4Hk4Z4D/TK5FTxMVVbH1KA==
X-Received: by 2002:a17:902:e80d:b0:1fb:93e6:94a3 with SMTP id d9443c01a7336-1fbb6d03da9mr104691715ad.18.1720801476440;
        Fri, 12 Jul 2024 09:24:36 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a24eeesm69133615ad.65.2024.07.12.09.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 09:24:35 -0700 (PDT)
Message-ID: <ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
Date: Sat, 13 Jul 2024 01:24:32 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] add-patch: render hunks through the pager
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
 <803b10ed-1cb3-4314-82c9-cf48d5d0bb90@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <803b10ed-1cb3-4314-82c9-cf48d5d0bb90@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jul 12, 2024 at 02:26:22PM +0100, Phillip Wood wrote:

> > +test_expect_success TTY 'P does not break if pager ends unexpectly' '
> > +	test_when_finished "rm -f huge_file; git reset" &&
> > +	printf "%2500000s" Y >huge_file &&
> > +	git add -N huge_file &&
> > +	cat >expect <<-EOF &&
> > +	<GREEN>+<RESET><GREEN>22<RESET>
> > +	<GREEN>+<RESET><GREEN>23<RESET>
> > +	<GREEN>+<RESET><GREEN>24<RESET>
> > +	 30<RESET>
> > +	 40<RESET>
> > +	 50<RESET>
> > +	<BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET>
> > +	EOF
> > +	test_write_lines P |
> > +	(
> > +		GIT_PAGER="head -1" &&
> > +		export GIT_PAGER &&
> > +		test_terminal git add -p >actual
> > +	) &&
> > +	tail -n 7 <actual | test_decode_color >actual.trimmed &&
> > +	test_cmp expect actual.trimmed
> > +'
> 
> What is huge_file doing and what happens to the single line of pager output?

The huge file is to make sure we are receiving a SIGPIPE.  We don't
really care about the line "head -1" produces, only that we don't
break due to the SIGPIPE that occurs.

Maybe a test like this would be clearer?

test_expect_success TTY 'P does not break if pager ends unexpectedly' '
	test_when_finished "rm -f huge_file; git reset" &&
	printf "%2500000s\nfrotz\n" Y >huge_file &&
	git add -N huge_file &&
	cat >expect <<-EOF &&
	<GREEN>+<RESET><GREEN>frotz<RESET>
	<BOLD;BLUE>(1/1) Stage addition [y,n,q,a,d,e,p,?]? <RESET><CYAN>@@ -0,0 +1,2 @@<RESET>
	<BOLD;BLUE>(1/1) Stage addition [y,n,q,a,d,e,p,?]? <RESET>
	EOF
	test_write_lines P q |
	(
		GIT_PAGER="head -1" &&
		export GIT_PAGER &&
		test_terminal git add -p >actual
	) &&
	tail -n 3 <actual | test_decode_color >actual.trimmed &&
	test_cmp expect actual.trimmed
'

> 
> Thanks

Thank you.
