Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A9F9E9
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440797; cv=none; b=CtK+PAMZUmmfj8KCXa7rLsTk+UiVUf2yUeJ4lq+EMO9YaucGr03sy8cdQjg8q41UFlu5BnJ8FuHYO6t2AHwCS2J5SVwNiSoQ5gw0F/swtKAIDmd3aOuEZUt3c67wCkYfQ7KMQG3StJGzIoiXQcBq2bkiuBslM11lOHbEHjx60V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440797; c=relaxed/simple;
	bh=L3Q4qG+p3wbTB9DfTACQFmzHTJmCvJ1HjZCUKmYdtfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ4mQk8Ysc6lXOtz6pKix7VL8OxC+rbYPA/dXEf9tx9w8n2wvQicpQxBSLVv1ESBVzTCQHOiai8+hCZ9Jcf7UvzrSN5MIit1jLQN1l4GyS/utwbcrBhtLlzYJkYDodw8J3CopWGwG2Up5DJUJw4G4a8Uav+ts9MiwfskmU71au0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uWIR1KiM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWIR1KiM"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b42d1caso35787425ad.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717440795; x=1718045595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lqt9AviRXi3GuPRwxXlWIALwIV2ncUH2FBgmIeh90Ak=;
        b=uWIR1KiM0uyFaGrFGt2/LdtT9GnzWG8C+z/0feBbSTuCSXsk48XRKNH3yOeihRKe6F
         3l1bKLiuUTzWWtGCBogOUsjSmjORK/ev+/tzcY4pyZCr66mYHctkVmT8CtljJ4fNdlwt
         RGvUmU99jHshwezjzI9xRVX6F6oSuFAxcZ1PhaLowu0hZ1qTQayhLUW8vqUkuim/CM6+
         OVc2bLRFbMhjWN6btRZvUEIoYSO9Lz2mq5X+u0L1m1vJZsVs0VLNvQmx1MHcJ7sq2ppV
         L6RO93PqBO3X8KT7kaROlhlwumBsS8ywLxdcNh35vCh9Doj4WTw4G30qD6vSmzw5m71/
         Xkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440795; x=1718045595;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqt9AviRXi3GuPRwxXlWIALwIV2ncUH2FBgmIeh90Ak=;
        b=bP4fe8gPnuaLcLH3vEY8vRGh+VfUfy2M9d2n8IU7iFvKq9eweoNcIfIMNjqYZLAOoj
         ABltH3Oj8PygaIG9Z/QLqJo/BYDpFUvTXYTpeZHp1JyulDMNQ4Y/hsh03DXJGl51593B
         rSmzsLxQ94Fk3ZvfThhNiosIFMDu3yLoafK0EfOBwXA0MXTNV8P/ddk9OCIx5rtUKsjo
         Tt7HCxg1dJBOJmNh8qVJUy24eEbhVDdlG5y6zwBlHtI+xzPkyds5Is3HwjT7z14x9+eC
         zc3Sw9CryR7ao+LUniGHecj6fSAkADsSasfaCFPbyyKvjudxcs+pqJwT8DvtxECUi8p1
         J0vg==
X-Forwarded-Encrypted: i=1; AJvYcCXx037CNctlGhyyFo6j/BC8fVAu0OvuGoi3Wpllt4T9yy9vhcPld7PBp7ojErz2xafVWRqNEiY/cCGZWuSv+idrS1DG
X-Gm-Message-State: AOJu0YzisueGCvv6onbdsROvovUn5rZEodd8dMrqxinJjRSqfRmuOO49
	EG+R4ed/AToihW9D0a63ows+MD2hhIN9J4fC8Abuzoz0NG9mZ5Fcwt9hP3/O8Q==
X-Google-Smtp-Source: AGHT+IFtD2oLFXPPevtwL1nDe32uICa0YNbekGYsyR2K3tYrPzX/GTd3EdwFvoBUSZ/IavTCNyDFKQ==
X-Received: by 2002:a17:902:e80c:b0:1f6:9181:47c4 with SMTP id d9443c01a7336-1f691814a45mr12591045ad.45.1717440794687;
        Mon, 03 Jun 2024 11:53:14 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8ff4:c097:4830:8ced])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd982sm68806875ad.145.2024.06.03.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:53:14 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:53:08 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the
 unit testing framework
Message-ID: <zeenwui37wk5ascgqw7kl6si7oyebn6kojidpevxuy2q4e45r4@sdxjxwn4657s>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240528125837.31090-1-shyamthakkar001@gmail.com>
 <xmqq8qzsuwh1.fsf@gitster.g>
 <CAP8UFD1YVyZj-uGfGXp6UxMfj3kZC5XXNed-5s-jj=ROx4URnA@mail.gmail.com>
 <tubjmjeczh6iigem32ulffvt2ucpygbm4frsr3jsps5tv2i7v5@ly3wge23zn6f>
 <xmqqjzjbqoqc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzjbqoqc.fsf@gitster.g>

On 2024.05.30 08:54, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > The latter provides much more context (we almost don't have to open
> > t-example-decorate.c file itself in some cases to know what failed)
> > than the former. Now, of course we can add more test_msg()s to the
> > former to improve, but I feel that this approach of splitting them
> > provides and improves the information provided on stdout _without_
> > adding any of my own test_msg()s. And I think that this is a good
> > middleground between cluttering the stdout vs providing very little
> > context while also remaining a faithful copy of the original.
> 
> If so, why stop at having four, each of which has more than one step
> that could further be split?  What's the downside?
> 
>     Note: Here in this review, I am not necessarily suggesting the
>     tests in this patch to be further split into greater number of
>     smaller helper functions.  I am primarily interested in finding
>     out what the unit test framework can further do to help unit
>     tests written using it (i.e., like this patch).  If using
>     finer-grained tests gives you better diagnosis, but if it is too
>     cumbersome to separate the tests out further, is it because the
>     framework is inadequate in some way?  How can we improve it?

I'll try not to speak for anyone else here, but I think the test
framework isn't causing much friction here in the decision of how to
split the tests. [However, neither is it providing much guidance. At
some point we should review the unit tests and see if we can extract a
helpful style guide or best practices doc.] The setup for the cases is
minimal and done through the main function.

I think the current split is reasonable as a first patch, as it mirrors
the organization of the original test and makes it easier for reviewers
to verify that it tests the same behaviors. If further simplification or
reorganization is needed, I would like to see that as a separate patch
on top of the more straightforward conversion.

The only part that bothers me a bit (and this is really more of a
complaint about the framework than the patch itself) is the carryover of
state between the different TEST() cases. We can't skip t_add and expect
the other test cases to still pass, unfortunately. However, I don't
think this patch needs to worry about that, since the framework doesn't
restrict persistent state. [And we certainly don't restrict persistent
state in the shell tests either.]

> Thanks.
> 
