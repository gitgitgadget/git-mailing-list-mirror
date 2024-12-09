Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A81E515
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784158; cv=none; b=oonX2aTwbieuKg9N/TfrzoFmHEZvObTSa1UoG5wfxdlp3ktNy9GhnZn/n2wkSqMosgf8qThsRa5EbSZuzCzkaoRvOvK8ZZ+W7zknrgFazLxNSXsBsXQCqk5DfT2bnyOjpMpwns9QT+dCWM6uwgiJCDqt3cNcO7B0OzPPC2C1UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784158; c=relaxed/simple;
	bh=Z78Bkhwyh6Zlhlb9wJWYuhfaohwkvuRN9V3LDe+Lj/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6y7PWHM4EAk+riBybyNtT2RJr5Th9IHcUyQZJcXxs08AiqtTlCRg/7HuPg613fLfG+PE1lLeOWq1UnWQBMdsQn+K6U58d1ebKmoaeJHfkD6DU4El8v90j0TWPgucTCeNdvqxI/qXRcbJMhwCcfXxFTzkVDtpMT/0LnMlRv0LUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPQJidk+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPQJidk+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434e406a547so18303185e9.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733784155; x=1734388955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MORSf1ihGEub0Q/SVEeTp4aZs+tlAz9QlFuPx13PzM=;
        b=OPQJidk+i3tvAWEiZWknh/RPC7slQX3OCzIKOTSAz74i93R8Yp96W3+oHHsn7Yoaeo
         KYoiIi4iSwDT4MRI2SSgZjAIMTOnF6tutnrLbrkI3fXcO2YgN6hvBxBersVtwIZnsHqk
         3grCkiKaP7ll+KcuXw4wF+3mdTUbZ3GUA5kZWVNkO+jvI7s0/Jy4eQCLthC6BmipWx4q
         c5XDfg0yl9ZUrgEQ8Jr6kdeUFDFF3z0v0h3Hh46Sw3zJwGKdHx1t77aRqRDUZYr79FOw
         rHu5CkgTqGeoIWeKqj3DLl0ulnjjtU9iHLi+nu+CdlUyZtwDshoM4zC5WsMm0UCgLrS1
         PFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784155; x=1734388955;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MORSf1ihGEub0Q/SVEeTp4aZs+tlAz9QlFuPx13PzM=;
        b=aT9cOXWRyDLucswMmeqlk6khI2ChUWjYQvFRK4jSk6qV6I/gfAef9tPLMTWgEtTYey
         k4/iRdDXr6gn3M7Q1JjK2w9yvwRbTQ3t4g7NKNJ7qLSDMId5Manxnnm0RO8GYO8FPh+M
         eraiFGpkr2PNiRgUgY0XBkNs4wfLo04QQ8sg7m0Xi+toaNcSQjXDMrBCWbSbCBuLYSr/
         K6kIAtrRMa4hJv72UK0yDszFQVbyL0wnnfLWYAzBMxoA3+bhaWbeC3gvQ/yFCLHZzMN3
         GHiBb3KDu0yn8xR2D8Wq2RaPIrRzJu9DONfUhk3tS5jr9rWGkXoHPoz7oCbspKck+tvo
         f54Q==
X-Gm-Message-State: AOJu0YxJ7LMLBOZPwnTpSWjK4opstQQ4K324SfCqnQgHErZYw7x1bmdo
	7W91qAbqbR1H4GVuPTomk4yhhxfrLnHjuCjm9vjX4UcUxGLpY76W
X-Gm-Gg: ASbGncsKocqaqZE7TUr6jCWysxfGnpOV1nN7n4GMLtjRXpTzH2qaspmdi60W80AFC1J
	YFLgafU3HB1O6kFhFjz88NOo4a+OJBrjdQJKVunOuJ5MIzRbpQqvBeeL0GC7NalaiRaheBCvX49
	y7tYhpnmzGq6I2sKkWD/++1qKllMhRAoNMJT1nDPuJloFiTECS2nb+V89uMAv6F+gcPkqceUycU
	JLu1nTYYpM1zhbJUvEBtY6jSuuFz3tbd0owuJlF7vLbyrqWRGdkJQK828KxXoJaSMtgpdKqeJoJ
	3lfInYQTWRuMLdU=
X-Google-Smtp-Source: AGHT+IHuqkCIrKLA2Cs3qKyzCpSS5U37B02G8qE9Erkg/QHfwRKYVIOrLu8Jvna9u78rUXeUwbQAEA==
X-Received: by 2002:a05:600c:1c0f:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-434fff33a38mr22808665e9.3.1733784154966;
        Mon, 09 Dec 2024 14:42:34 -0800 (PST)
Received: from gmail.com (219.red-88-14-197.dynamicip.rima-tde.net. [88.14.197.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbdd8sm14277130f8f.95.2024.12.09.14.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 14:42:34 -0800 (PST)
Message-ID: <9b46736b-3303-4837-b2ae-72757a0bd60b@gmail.com>
Date: Mon, 9 Dec 2024 23:42:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically initialized
 vector
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com> <xmqqwmgf3nf3.fsf@gitster.g>
 <c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
 <4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com> <xmqqser33ga6.fsf@gitster.g>
 <xmqqy10pprnp.fsf@gitster.g> <xmqqttbdprj0.fsf@gitster.g>
 <xmqqikrtpqkb.fsf@gitster.g>
 <20241209021556.GA1293399@coredump.intra.peff.net>
 <xmqq5xntpaya.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5xntpaya.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Dec 09, 2024 at 04:33:33PM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I think it is this off-by-one:
> >
> > diff --git a/strvec.c b/strvec.c
> > index 62283fcef2..d67596e571 100644
> > --- a/strvec.c
> > +++ b/strvec.c
> > @@ -66,7 +66,7 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
> >  			array->v = NULL;
> >  		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
> >  			   array->alloc);
> > -		array->v[array->nr + (replacement_len - len) + 1] = NULL;
> > +		array->v[array->nr + (replacement_len - len)] = NULL;
> >  	}
> >  	for (size_t i = 0; i < len; i++)
> >  		free((char *)array->v[idx + i]);

Yes, of course that's the right fix.  I have just seen what has been
queued.  Thank you Peff for the quick response.

Just in case it get lost in a junk folder, I just sent you a message
without cc'ing the list.
