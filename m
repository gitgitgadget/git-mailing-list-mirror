Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5F15A85B
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367206; cv=none; b=TiN9vM77mjWbwjSK+O6ZKbGjtOfLIgwKAmH2FR8+N1gFLczV7nqPkJ4iKQcrJ8+GbFLuwewVSieXdOgkDZLF2EqKTon6zTCdVvo9+NnHAsCwdfiVKVfzdAckzVV9r0WaGgbeJ5gi/YsP7Ir4Hj4kvr7RARs/CysPF+IarpsifU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367206; c=relaxed/simple;
	bh=6RmF8PgKERtm4KWK1CoMj/7cQ2uqWymXSBR+I52Uc38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoppxwgRP3WNf+DbRuxPSyjwKhLggft4Q1VunYB16Q8bbVOf794DLlnl77EHUPT87a66qmi8Ga+Any9K6d+k+sDv6EA+GFgHdskMEBBwKOXcTfWkAYoIAuYDLaprVvAjlrrwMwSilcWvUdQH5o5dbSHs5vhyfvKOTlXMzeBex08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPcAKwap; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPcAKwap"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71b0d1c74bbso897920b3a.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367205; x=1727972005; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnLwGCL1fWS30boHLiioFYC144zslebvIPY0b6mqyV8=;
        b=YPcAKwapFx9UkB0FG8uRUQpJWaVqW52c7SeuZyERfa0xT61KicKQWrTSIlYrGgwX27
         UdYfD3DBm50BQS08q0shnuBvxuvYu6TzHaZpVWIcVKMhaa9RRX7PPXUsK7KlWaqCDuPx
         ffLqXIb+xN65yOrsprdZqDWCpFTXodtnQVfdlgNmEhvfLSYMOt1tom1/bCgRsMLmNZHP
         KnbZBjqn9ZQBin384OT1qH8E84dQi4Ve4PA6jtPzd5Ry3R6wkt3eNOlXXa0yN3HlMKsL
         OmI7MtxOBj2hmArk6Xoafo+aqKdIk7joTbmuTktNkN1/h3or7VMKi0RJxHcjsjuBkKG0
         kXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367205; x=1727972005;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EnLwGCL1fWS30boHLiioFYC144zslebvIPY0b6mqyV8=;
        b=Z60DB6e+WUYYxLmAsP4F8AvpGJ1SwhHf2D33uQJioW2xRJW/hFf3acwjTA9l0Z6qrg
         n1CjZ0wATMRs6KJAPzUSooKr26Ezm/Eljei0hUDF+xosCjMINaxRUDTXwrMuqNjv8cV4
         7hLG/+LBNmN+GIJsGiEjWsOp5vIiLbQJF53hxd7aT/B7iaxSaGgkcJRaqT20xrbcgiBs
         FjmQk9/+zxulfAwOLKxNg/TbPJDqvIDHOFkni6JQ/PoWlXGMog4vfcmkeZISFCeEk+Cr
         pp1RW5HvZHoWn0sERoFIt/9w3hjxcAzGJtdH8kmOknieR/xh2PDkznAqw7OyJRmaqc8h
         OY0A==
X-Gm-Message-State: AOJu0Yxhyh+t5RslnwV9kY7BXltnRrmN7GmNL48TlTvN1WOdl0jJyWbq
	5I4CNL/kz5SphfKa2jGN3qITKSdZwrw8QHLovl5vTlPvrOHP8Nta
X-Google-Smtp-Source: AGHT+IHa0e1rCgly9Pp+biBfKHt1q7tPHkbCCGD3XsReluuqco7cAMfj9Prbvw0rYKkbHlx04+klPw==
X-Received: by 2002:a05:6a21:501:b0:1d3:2929:447d with SMTP id adf61e73a8af0-1d4fa6cfcbfmr348321637.29.1727367204506;
        Thu, 26 Sep 2024 09:13:24 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2651604asm70514b3a.115.2024.09.26.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:13:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
    Josh Steadmon <steadmon@google.com>,
    Calvin Wan <calvinwan@google.com>,
    Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
In-Reply-To: <ZvVPiIzzLTTb75b8@pks.im> (Patrick Steinhardt's message of "Thu,
	26 Sep 2024 14:11:52 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727158127.git.ps@pks.im>
	<f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
	<xmqqikulugwj.fsf@gitster.g> <ZvVPiIzzLTTb75b8@pks.im>
Date: Thu, 26 Sep 2024 09:13:23 -0700
Message-ID: <xmqqzfnul7fg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> But it illustrates why open coding is not necessarily an excellent
>> idea in the longer term, doesn't it?  When unsigned_mult_overflows()
>> is updated to avoid such a false positive, how would we remember
>> that we need to update this copy we?
>
> I agree in general, but with the reftable library I'm stuck between a
> rock and a hard place. My goal is to make it fully reusable by other
> projects without first having to do surgery on their side. While having
> something like `st_mult()` is simple enough to port over, the biggest
> problem I have is that over time we sneak in more and more code from the
> Git codebase. The result is death by a thousand cuts.

> Now if we had a single header that exposes a small set of functions
> without _anything_ else it could work alright. But I rather doubt that
> we really want to have a standalone header for `st_mult()` that we can
> include. But without such a standalone header it is simply too easy to
> start building on top of Git features by accident.
>
> So I'm instead aiming to go a different way and fully cut the reftable
> code loose from Git. So even if we e.g. eventually want `struct strbuf`
> return errors on failure, it would only address one part of my problem.

The dependency to "strbuf" (just as an example) was added initially
fairly early.  Soon after 27f7ed2a (reftable: add LICENSE,
2021-10-07) added the reftable/ hierarchy, e303bf22 (reftable:
(de)serialization for the polymorphic record type., 2021-10-07).  I
somehow had an impression that reftable "library" started without
any Git dependency and then use of our helper functions seemed
through from the shim layer, but it was pretty much part of the
library from day one, it seems.

> A couple months ago I said that I'll try to write something like shims
> that wrap our types in reftable types such that other projects can
> provide implementations for such shims themselves. I tried to make that
> work, but the result was an unholy mess that really didn't make any
> sense whatsoever. Most of the features that I need from the Git codebase
> can be provided in a couple of lines of code (`struct strbuf` is roughly
> 50 lines for example), plus maybe a callback function that can be
> provided to wire things up on the user side (`register_tempfiles()` for
> example). So once I saw that those wrappers are harder to use and result
> in roughly the same lines of code I decided to scrap that approach and
> instead try to convert it fully.
>
> So yeah, overall we shouldn't open-code things like this. But I don't
> really see another way to do this for the reftable library.

But isn't all of the above what Libification ought to be about?  I
was hoping that the reftable polishing would not have to be done by
you alone, and you would recruit those who are into libification of
other parts of Git codebase to help cleaning up these fringe (from
the point of view of reftable) interfaces.

What do the libification folks feel about this (folks involved in
libgit-sys CC'ed; of course all others who are interested in the
libification topic are welcome to comment)?

Thanks.
