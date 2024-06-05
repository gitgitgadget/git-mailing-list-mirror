Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC715F41E
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622698; cv=none; b=K1YqIXb8yT2zteIFW0kUrRECTsaG9BIMLrPg2mRs454iTBkc3fPQhDtHb1MIn/rGmLykrCIgatOi5/H95oM2RHXyyePI3O3d4U/OWfHZU0hgzLq/Wbx4kr4fY/+3MhrMS30XCK6ZfR0zaBx7r6ZIChzIb6C3Mw7aAkir1I0HIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622698; c=relaxed/simple;
	bh=1AKADlXuUDbOw2Vlev0N3ypeK1LHiRQ8s+EPDqKUAtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trfYZpos7F4bYgQQhMZQvTI1JsFRpNMnlsZ7UJdayMkqUnUufqyX8ZfRVdaD04224NaYXJuZPMuGntZ0/+1flT5ecV3azn6/lt2VN07UAoC1zLc48iqNFN99fEoTRteD2A+NwiPiw074TnGh9Yzb13rtTH+FoCk4vZ366MogQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/+8ymQp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/+8ymQp"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc9cef36dso218298f8f.3
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717622695; x=1718227495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fzFo9h7jSV8/nFZOjFs7hA/0cFxagW7XvltdafhofA=;
        b=j/+8ymQpBx+Nu/zJVQNNoxlm3rdi1jIhabe7rX5ktqFtjmR/42q/pIifNYHNAVytvw
         rxQJMVDGzRoNuGT21DvIp97Mx2vsUx2J7wvQ18Z2wbaH3/ZHq6XFTYMZljQN62aCvAln
         GsJLceoXBTLlRjUUXaTEkjqOlNY0UMd6fj3nh4nqxyv6jQPRkI0iE0B5Jfx8OAqX+fvZ
         bANpFalre2z4aVX2t13t1qFpFYo1JHFeqW46Koah6pkWzFEQO5j4OXEJhJqh06oJbtcR
         rjgXhVzUynHdkIz7iws0bilnDNqObGKoBhfPGXEsvjUTdwFb88NoyfOE92iduDf22+3f
         IzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717622695; x=1718227495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fzFo9h7jSV8/nFZOjFs7hA/0cFxagW7XvltdafhofA=;
        b=QByHAICrCljCIWrwa/xKdI6cqYmthv/EXxZ5yYnQN+y78vEX1uiCctNsxzNV3OfADF
         sfinrIzDcKYpxQ7WhtYiIlrHR75pM2TGqoCRPsGXSpMSi83RjjmwZxXKukpJ8m+fNYB1
         wtQ/woUojQCzPQa/VH20Vv46A65lw288X3p4vRDH7Mb+34KMIDqcSlRujfve/MlwmDHZ
         bP+forCK9OY1nqUWHMMNgR2jVJu7e/GP5DnJbM4ALRw5HnjVyeqDUZeTdrgTx3OhoVN4
         Sojm2Ux7UwIULyxMJ7EYR5gMUPJ7HfCaDlK4J0VvpOruLyGNfQu3JDIFokWnU06ZRxuS
         hkQQ==
X-Gm-Message-State: AOJu0YzCqrgwO/TCfqxOX50ihwrYvO9g72r8ixHB42l0QAL4SYt8Lzcg
	H3YyXIQT5dHqhAkq+Xq664CGsS30EslgT0AswAqL3zcQjsVsInDTyY80iA==
X-Google-Smtp-Source: AGHT+IHgcLRoHqmO5nhvXPDJol4dKcDWEIPwVuwDo+vS2KttpLw1ArR4IJT9t+/FS6CxnUnRH8CY2A==
X-Received: by 2002:a05:600c:364a:b0:41a:f76f:3362 with SMTP id 5b1f17b1804b1-421562e9219mr31679205e9.21.1717622694240;
        Wed, 05 Jun 2024 14:24:54 -0700 (PDT)
Received: from gmail.com (52.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa3e4sm711675e9.15.2024.06.05.14.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 14:24:53 -0700 (PDT)
Message-ID: <5aebe520-e540-46b4-a887-af488fe2663a@gmail.com>
Date: Wed, 5 Jun 2024 23:24:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] format-patch: assume --cover-letter for diff in
 multi-patch series
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com> <xmqqr0dbqfv8.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqr0dbqfv8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jun 05, 2024 at 01:44:27PM -0700, Junio C Hamano wrote:

> > +test_expect_success "format-patch --range-diff, implicit --cover-letter" '
> > +	test_must_fail git format-patch --no-cover-letter \
> > +		-v2 --range-diff=topic main..unmodified &&
> > +	test_must_fail git -c format.coverLetter=no format-patch \
> > +		-v2 --range-diff=topic main..unmodified &&
> > +	git format-patch -v2 --range-diff=topic main..unmodified &&
> > +	test_when_finished "rm v2-000?-*" &&
> > +	test_grep "^Range-diff against v1:$" v2-0000-cover-letter.patch
> > +'
> 
> Isn't this doing three separate things in a single test?  Unless it
> is the local convention in this script, let's split them to three.

Honestly, I don't have a strong opinion on this.  I know, though, there
are others who like to pack as much as possible into one test.

I see your point.  However, I can also accept that testing in the same
test the simple exceptions for the implicit --cover-letter with
--range-diff, or --interdiff in the other one below, makes sense.

> If "--no-cover-letter" fails to prevent v2-* files from getting
> created, it would fail without hitting test_when_finished.  v2 was
> already bad enough in that regard, but piling two more things that
> could fail on top is making it even worse, no?

I'm curious, a test like: 

test_expect_success "format-patch --range-diff, implicit --cover-letter" '
	test_when_finished "rm v2-000?-*" &&
	test_must_fail git format-patch --no-cover-letter
		-v2 --range-diff=topic main..unmodified

isn't it confusing?

Thanks.

> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index ba85b582c5..b96348eebd 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -2492,6 +2492,16 @@ test_expect_success 'interdiff: solo-patch' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'interdiff: multi-patch, implicit --cover-letter' '
> > +	test_must_fail git format-patch --no-cover-letter \
> > +		--interdiff=boop~2 -2 -v23 &&
> > +	test_must_fail git -c format.coverLetter=no format-patch \
> > +		--interdiff=boop~2 -2 -v23 &&
> > +	git format-patch --interdiff=boop~2 -2 -v23 &&
> > +	test_grep "^Interdiff against v22:$" v23-0000-cover-letter.patch &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_expect_success 'format-patch does not respect diff.noprefix' '
> >  	git -c diff.noprefix format-patch -1 --stdout >actual &&
> >  	grep "^--- a/blorp" actual
