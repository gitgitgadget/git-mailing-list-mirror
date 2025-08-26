Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE717C91
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219902; cv=none; b=ID2z6/uKTyeYqTUpy8exkzg+LEyl5KiRqbVcyxyg3ZLnYH3w/rzPM+UCdp8WyxTXtLSYpXRA2N4igk0bonczeEmkY4xwWVBZqFqDRxq14mxTu/kKIBZCyeRd1NZT5bs0V0hZG8YjDga9CTDzprS3VABLR2QuO/ti7I6SR8VA+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219902; c=relaxed/simple;
	bh=ibkF6zbpYx18JJCz1XcQKcy9f8NeVkDruUr+n5w2++c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kaz4UWr6SONwKap52Ko6lb1HQnnl6q5ypozk0+GIYBmORkngoLhScofWr9poD84aavkGofh7GR3m/csfSwY9ybW5HavzTs+RzSQee+2JTf0jerXREg8cv0USTTZ9XYYXR06wYfYGepOjOvCfCD1oQBX7ht1bLRG7r2qSZfh+dmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQQB18oo; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQQB18oo"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b476c67c5easo3798120a12.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756219900; x=1756824700; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y4+o8z9wJUraSjcqca5lkYTuHIbs4a9h8CCBW7n0OM=;
        b=GQQB18oooteLa4TwMz4PsvqGBWRpuDkaz4TKQcIbeMrgCFShHML5ZGjpLsa1gN9gBP
         dYznX8Zt/Ub6/dOFkiNCb4YrQgnxL2v8zloX+TkLrpMqL0ld2jjfiOZZMJNEsmeP9Wv0
         KQkJS9sL3tYsOzui6/4DedOBVaRVNwsFxSQkv4HtXkmI1joYjwwHQign55NmwhFPyI8L
         vhZuaf2El35uVdfwi+cnXSaKbiiEGahJvo4ibQW3fdErnfeo1YpMEV+lC1iO20soLd15
         uPVi/r34VqWcPg/XPqO+PyGJB0E/xLoC0MYhqpKH9iuBMNKM3/9aIJZE07W45XEE+UWp
         Dwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219900; x=1756824700;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y4+o8z9wJUraSjcqca5lkYTuHIbs4a9h8CCBW7n0OM=;
        b=LYqnsUTw3OT6NDo6oVu0MSKR9VJA5Pd4oYQOie27QvH+R7hhDT4Ko89iJ8HRqt03If
         LXo9sZw3XulqkeIg0/gRxpOcHtOpU0ffmLB97qOdNllz7Ma+LP0rargkTTZ5OZYFU2cg
         w7gywm4+EWSzLtpoPMAArPd8R8V20cpZMMmJKpuwik1SgF46F9DcemTv/0ml4WJZu+pJ
         MkrWFvjUMRL8834uKA1hJh/ee1QbLHQM8RDowEWrC40jrQmno+w9rwRoAXPMs0EyZPA4
         bP/hH7NU5qNpYoQUtF4DQMv9VKXMkz2UFET1s70IuijB1iGR8f0l9wO08TqoWizsJ+vh
         4jKA==
X-Gm-Message-State: AOJu0YwEMactCg8RnR9hA6jXk6c3q7RC/kNCZ2gQPiiYxRykIY7U5u8R
	YdeDb5AVhVlL+IhxL1sOuAuQ8GjC3Hod0Rn0ptpfwKXXD84s7CDrnxItXmqToQ==
X-Gm-Gg: ASbGnctSZwVsyHdcn/Ceey5noQv6Z8yDlqRJk6HZJTvmXRi1iT5aQ4CJvrH427Q08iP
	OiJMFbrqutoPWjy+buMaCTqxgibHEJVC2G5K6O1vkblbySRrMTIJqubQcpa5Ak0nllHGcc7rUXT
	5wcHt9BLybNU1Vzc/UgWN0mno8Rdui2TLFWwjpAqgN1aMXXvTuI6WKWBmo+Oyp5F/ZQX0xnw72G
	bA/yYofmWXdHeglX6h5a53QfxDBM1S9i43+hjQix4BlNsw3EPkzjUxxd5N50SZmYwTuTlR6pPbk
	4Yjv+xvnUxs632sAEIffbDzbe4c0MhAVbawefuKiCEociI/jl0QA7ikFrHURdsZYLb8Wjwr0efk
	8q+NCPkDH6S0h2F2A57dxUeWOi5qBoYOLehAG9MOK5alJkqTFzhkU+5e2
X-Google-Smtp-Source: AGHT+IEqGekWxXvB1z77LCHOKRI0N/2QzHJJAHTRq5YdrnbbELZ+h5+oz2nDjYxEpOyTmLdMIt1tsg==
X-Received: by 2002:a17:903:120d:b0:246:2da9:73a2 with SMTP id d9443c01a7336-248753a297fmr23237325ad.27.1756219899554;
        Tue, 26 Aug 2025 07:51:39 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687ceda5sm98577095ad.63.2025.08.26.07.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 07:51:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH 2/2] repo: add the field objects.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqh5y01mv3.fsf@gitster.g>
Date: Tue, 26 Aug 2025 11:51:25 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 Justin Tobler <jltobler@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <261E9FC0-EE4A-4B4B-BA21-69B93EBA6933@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250820144247.79197-3-lucasseikioshiro@gmail.com>
 <xmqqh5y01mv3.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> Yes, and extensions.objectFormat specifies the hash algorithm used
> in the repository, extensions.compatObjectFormat specifies a
> compatibility algorithm to use.  So objectFormat is a good name to
> call this new "repository metadata".

I was discussing with Patrick some weeks ago about the compatibility
formats. By now, the "storage", "input", and "output" formats are
the same. For example, rev-parse already has those options, even=20
though they return the same value (2eabd38313 (rev-parse: add a
--show-object-format option, 2019-10-28)).

Repo info is easy to handle this situation in the future by just
adding a new field. By now, objects.format returns the storage
format. If/when we have those formats implemented, I think a good
approach would be add two more values to `objects`:

objects.input-format=3D...
objects.output-format=3D...


> Perhaps drop "s" from "objects.format" before it becomes too late?

Ok!

> We may also want to reconsider references.format as that is not in
> line with either extensions.refStorage or --ref-format (taken by
> 'git init' and 'git clone').

What would be a better name? reference.format or ref.format?=20

> Do these keys always have to be two words separated by dots?

The idea is to group everything into categories, than it will be
easier. I have a future feature planned for that one could call,
for example, `git repo layout` and then it will return both
layout.bare and layout.shallow.=20

> I am asking if there are other keys that would plausibly fit next to =
this
> object.format thing.  object.count to report how many objects there
> are in the repository, or things like that, perhaps?


Given that it would survey how many objects exist in the repository,
this would be better placed in the planned `git repo survey` that
Justin is working on (we discussed a little more about that in=20
=
https://lore.kernel.org/git/vygdkwopfzrbdpxpxebnq3xdlg3ow4i3w5y5evduae2zue=
lqcn@la2dikht2qrf/
). I'm cc'ing Justin here for more info about it.

In the `info` side, by now I don't remember any other key to be placed
under `object` aside from the aforementioned input and output format.
Perhaps an idea is whether we're using packfiles or only loose objects,
but I don't know if it would be useful.

Thanks!=
