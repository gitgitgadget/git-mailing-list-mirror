Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3B1865FA
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353508; cv=none; b=dlfri7TtdX0Sw7xKtS2I6uBlka93lZxbIUYHnE6cITHgdIhye9uxfffOny1BcS+qDc4HVsNRNEwiuY6CtuMDOU8YpJcgRBEfkerqzKjxzrovs9pO5FNgy7iy8+kLDZ3ushP2+zlXRkm1NL98qk1Ii2Cs14Lk4vOu2s7Hyc7DqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353508; c=relaxed/simple;
	bh=p67uYdpeNMPKCUYerCuz8tUcz3q8UQFnieUN68fh2Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSLuAygOqdmXy9KU5hI8/OZoKrXU9P5FpUl0/0aDQhXAxszgVNKq6zWWCP/xEB7CUyGz9iQz/G+b6z5Vxs/94cGg77hBAJiXCgcJBF4bRtcjZP7mMb2LwKNfGIWbYp+GExPkqFhUO4TJTRY/43CfUmzSGNlY03Lvnw6vCU/134c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Umq0sKoT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Umq0sKoT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21561f7d135so15005ad.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 15:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733353506; x=1733958306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7416LtRKQCsLU3Kzu9T1PVL3HtsK9pq3pjBSYJN3PM=;
        b=Umq0sKoTRvXQZiUAQa25sGIi4b0CMjOzywgMI4ixHgcTMzZKAelxSNtfnqubV981In
         wVfzzjI/OY6AYq+Cd7xM2NfBxPgPt++n8pgTB5PbIZrO9Z0UpRNiN1L2TZPNLm9sdGWe
         2gtjjdBZwop4bj4CDe8xpsVRoGpN1hSZFA5aK3qWgS4l+XfxlH80M9nhb8V8oNW/KwvH
         1ZB8NJnTcvNkA2SKO5HJuZxACqAfZHBhTqWC5/pQhGZDJVJGcA+chijXiwxvoWdVhmJJ
         jjS2QxFyf3r6nLPpLpV/mXFDF6iNxDoD932b2IOU1nnys7BIwB/S6J9BDtqv24uxxBan
         dmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353506; x=1733958306;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7416LtRKQCsLU3Kzu9T1PVL3HtsK9pq3pjBSYJN3PM=;
        b=u1sN/Ufwx8vKrs9xyU37KkjVm9iKx5evEY0jQXDBKUC2O75Tk1ddF64S0g3FnMRUXU
         vGIi4kGOUqIV8aBB358P+flUuxWeGS+ZoZOhcOETmSB9fvXf/4T9er3GyX01QfEB33op
         QTKYk9+vQvRpVOw43xZtBzZ0L2UjGSxMYJ7Bgi9eqZj6XpjSA5H0mVuxB2KR29TPezQl
         MB09jKPRVvFSEH8OeKPZNKyN1nFW1cjtpUTrQBOsm0lj+/gCoFCkskMiXePVHqOGawen
         B8mS4vH2tWk4lBc8twQ/11trPBVFznZeyY6B1+AFE8plQoF/WACvhpe95QOcCXRhWaGd
         DZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGFM/bJBe67Nw/N8adHiPOK/5d+Dazzv/jiwOpaUydpU6H5/WKxJwJnqdqgO+5azwTsqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycxVl0C/WcYgZ+/rxao5lVgsPLZbULcU0eY+gwq5EX73veyuoj
	D8AuH/M9R/YchQ9jsrFCIOir15wh9XkxpmVpPpoNDEFrLis1jepxjrUXSl314w==
X-Gm-Gg: ASbGnctvjwJlMELEgtEzbrlTxgS1w6rebW92+y7Hbdxntn5SZXXw24uEQvHppbU6CiW
	gacomZltYXuvBJB0Pb7+AC3073uKOlSmvGxSuSCJ/ga6yKCrRory/60tEp8GZdBuzERIG6JrQt7
	LN0ixvhCS+pI/4t90fiqI0h+Rnwpbn3f+3Ro/Hw/FUMVCE+zO4tq+NkwEXeulYVS6seCy0WmUb/
	PgLGviQhiuew3QlBKkMSxe1RaUTZwIm+fglELK+ku1eAhzK
X-Google-Smtp-Source: AGHT+IGfvilQxErZ9kBemyUFIgoBQu92y3jkc3VKG0pa24qNIEQl3AbilrqlL1wpDYeJepDPuTzHDQ==
X-Received: by 2002:a17:902:ccd2:b0:215:61b4:4084 with SMTP id d9443c01a7336-215f8d3173amr318695ad.29.1733353505673;
        Wed, 04 Dec 2024 15:05:05 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:9c3a:bb2a:d0bf:3ce9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f7d3d6sm84391a91.4.2024.12.04.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 15:05:04 -0800 (PST)
Date: Wed, 4 Dec 2024 15:04:59 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, 
	Benno Evers <benno.martin.evers@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
	Benno Evers <benno@bmevers.de>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 0/4] perf improvements for git-describe with few tags
Message-ID: <fxbv4ihz4sgdfwtq4vkadntank2lzwkt6abgipuojhumjmuxjs@fegutv3kcamo>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, git@vger.kernel.org, 
	Benno Evers <benno.martin.evers@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
	Benno Evers <benno@bmevers.de>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
 <20241031114210.GA593548@coredump.intra.peff.net>
 <20241031122456.GB593548@coredump.intra.peff.net>
 <20241031144351.GA1720940@coredump.intra.peff.net>
 <CAEQVFRFWT02QTL7PTf84p6AAferijHx8L_Tu6ON1H7U=iEdb3A@mail.gmail.com>
 <20241106192236.GC880133@coredump.intra.peff.net>
 <xmqqldx61t65.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldx61t65.fsf@gitster.g>

On 2024.11.26 14:05, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > So here's the series I came up with, which starts by adjusting the tests
> > to be resilient to the later changes, but also to show the existing
> > failure mode.
> >
> > And then the rest of the patches add the performance improvements we've
> > been discussing in the thread.
> 
> So, this did not get any comments, but I had a time to read it over,
> and did not find anything suspicious in there.
> 
> Let me mark it for 'next', this time for real, in the What's cooking
> draft I have.
> 
> Thanks.
> 

This breaks the case of `git describe --always $SOME_HASH` (we hit the
die at builtin/describe.c:340) when there are no tags in the repo. I can
send a test case and a small fix shortly.
