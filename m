Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC451E7C09
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514219; cv=none; b=YTDI5n0Cs7Ek/vKkS6e+Wnq8u1NUg0fT3EinG9JqPZUdgn5rkwhe1orOalK7RiIMk92xzIWfcQLJeoTywqqRF4+Uys53uD9aCKc3B5nXQYCWgtlr1J/MuBReoXGW7eEBorXz9dN8G9N88sTa+Tk7vCrnfDcxT2ZjsOry6VE0LHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514219; c=relaxed/simple;
	bh=KzQzdCC4302w4T4eTVDGkriFVd7vkLV6qgeu0obpUco=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nInvR6BXxLnh6YV8lfwx6p3ztfW6QXakzqPmUc4P3+loipfMLIeQMWCMdjbK7Ih+bFAXZCDNMifbBGpEcpbsrVyhtZ131rv6IonunG3GK+EFaXw2gcnCm0na1ZsrhAbjqeVBZW0rIhUwFCZGFkveNdvyFE8GFLskDj0knZH2zgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb8kRjIz; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb8kRjIz"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a482407e84so1331564137.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514216; x=1730119016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG+8oHGFWHTayEA+NmoFPMVVgFQq1Z2lhKe1xgKd6+c=;
        b=Bb8kRjIzw0t7+3vjuq5BJJrrq0jbue3HafHM6g8h4EJo9yIz60tj2YHJiCNAqd7B6y
         OdL5eUF1U9FRDVhgKqB7Z4fpAlLBWVXOx5MSsmIglhiVNkBoK0v/EdZD+JaoeqepBIx+
         Q18ObXX5IAQF+CJAVSVHYvc06RGefdNKTztuG/Ec5fu6GjNd5ggHgHVXYC0GMRv6gypi
         uoXXQaoWKLI2fTLp6sahntf+TDTzhyAfd6HuktkcxEwBJrvJwZqZVEYiPgV9kySnEmN0
         sfPN9BnzL8RAmBPbCINFa0vn4r+fx65vpXjWX1kgWf6J626lMhw6WQqYNx2ye2jkLYSQ
         tu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514216; x=1730119016;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TG+8oHGFWHTayEA+NmoFPMVVgFQq1Z2lhKe1xgKd6+c=;
        b=D9txX1QZNa+A7qk2g0eRtdTlkMlVQ0cy+p1YleAacLoX6wjd6c2HQ0pnNFkZYtu4m/
         6sZ5UaxU9D6V8vybMSlQgy0xl6buTUF3RRsFo0IlCEEGOfo4bGhHXMk1mFWlyvQe1v0H
         GlCI8VTOTg+vnp5+uwGQjWrQpAYf/L4jHHLsKjEB+BqKHy2PrG0y4m1vSO4WVJ5GSGEu
         Yl/1DpfMqEo/MTFVnYiI4WSStqC4lKfwH9EWSCUloaTtathLiv16iWSzekxQrN+KVRnI
         tMMcWyc+rjMzpT3yozsqoSv+SNoMEPipsTqtnHKaZr5wfDjZooC70N+eVP6F+DdhVGkK
         HwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8F5Ce7P2hJ76/DaXnRh58lUT7iHy1ZXe2x2/Y0Qj23IsYYeRA3EU8TDnVS8cHvMpaSaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqChUf2qXb5QIE6tskFiqxiLB+PzXAmzQLXCoj3ij4I5Cvf+wv
	GIqm5AxZoZH+1g9awltFdHAS1u9i9A2Hsvf81D2xRInBWwx0X2DXsalbdh1FKCDtUcNaDpXLr5Q
	N3U389M89pWzqzXL+BEgYGSrLQxY=
X-Google-Smtp-Source: AGHT+IHYSScrWFe/giNQa/jtbNwFQS5lJSazdoKkIXL57H7MLHUa0PO43T6T38ZuKQtr+0TTW4E4etp0MVS20dnU1ys=
X-Received: by 2002:a05:6102:32d5:b0:4a4:8e06:6e98 with SMTP id
 ada2fe7eead31-4a5d6b16d68mr7971696137.15.1729514216374; Mon, 21 Oct 2024
 05:36:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Oct 2024 07:36:55 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxCShtdTlv7t5fYy@pks.im>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <ZxA6I67FfPe4fV2F@nand.local> <20241017024828.GC1858436@coredump.intra.peff.net>
 <ZxCShtdTlv7t5fYy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 07:36:55 -0500
Message-ID: <CAOLa=ZREg3xuaT6mbM8+Havn3regZDhK45kGy0+Fw8t56c7Mpg@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: format iteratively with lexicographic refname sorting
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, Victoria Dye <vdye@github.com>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008061980624fbe8ca"

--0000000000008061980624fbe8ca
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 16, 2024 at 10:48:28PM -0400, Jeff King wrote:
>> On Wed, Oct 16, 2024 at 06:11:47PM -0400, Taylor Blau wrote:
>>
>> > On Wed, Oct 16, 2024 at 08:00:30AM +0200, Patrick Steinhardt wrote:
>> > > But there is one exception here where we _can_ get away with sorting
>> > > refs while streaming: ref backends sort references returned by their
>> > > iterators in lexicographic order. So if the following conditions are all
>> > > true we can do iterative streaming:
>> > >
>> > >   - The caller uses at most a single name pattern. Otherwise we'd have
>> > >     to sort results from multiple invocations of the iterator.
>> > >
>> > >   - There must be at most a single sorting specification, as otherwise
>> > >     we're not using plain lexicographic ordering.
>> > >
>> > >   - The sorting specification must use the "refname".
>> > >
>> > >   - The sorting specification must not be using any flags, like
>> > >     case-insensitive sorting.
>> >
>> > Perhaps a niche case, but what about ancient packed-refs files that were
>> > written before the 'sorted' capability was introduced?
>>
>> We should be OK there. In that case we actually read in and sort the
>> packed-refs entries ourselves. We have to, since we do an in-order merge
>> with the loose refs while iterating.
>>
>> I do think this optimization is worth doing, and not a problem with our
>> current backends. The biggest worries would be:
>>
>>   1. Some new ref backend that doesn't return sorted results. I find
>>      this unlikely, and anyway it's easily caught by having coverage in
>>      the test suite (which I assume we already have, but I didn't look).
>
> My assumption is that a ref iterator that _isn't_ sorted would lead to
> undesirable behaviour. I'd be surprised if git-show-ref(1) started to
> show refs in a random order. So we have essentially baked the
> requirement that ref iterators return refs in lexicographic order into
> our codebase already.
>
>>   2. Some new flag combination that requires disabling the optimization,
>>      and which must be dealt with in the code. This seems unlikely to me
>>      but not impossible. I think enabling the optimization is worth it,
>>      though.
>
> And this part is an issue with or without my patch. The logic we have
> in the ref-filter API is quite fragile, and everybody who wants to add
> some new flags must remember to update `can_do_iterative_format()`. I'm
> not really a huge fan of that, but on the other hand the subsystem does
> not change all that frequently anyway.
>
>> > >     to sort results from multiple invocations of the iterator.
>>
>> I think this part is erring on the cautious side, as we can often
>> collapse these into a single iteration due to the ref-prefix work. It
>> may be OK to keep using the slower code here if multiple patterns aren't
>> commonly used, but I'd suspect that:
>>
>>   git for-each-ref --sort=refname refs/heads refs/tags
>>
>> could benefit.
>
> Mh. So we do end up using `refs_for_each_fullref_in_prefixes()`, which
> may or may not end up collapsing the prefixes. We do sort and dedup the
> prefixes via `find_longest_prefixes()`, so we don't have to worry about
> e.g. `git for-each-ref refs/tags refs/heads refs/tags`.
>

Tangent: This sent me down a rabbit hole, I wonder if we can do better
with naming, `find_longest_prefixes` calls `find_longest_prefixes_1`,
The `_1` doesn't help at all with explaining what the function does.

[snip]

--0000000000008061980624fbe8ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d539686069b8a79d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jV1N1WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2dqQy85TWljMHRlRlBNTXRqL0lVSTdZTC85dXBLRApHQ0ZRUHFuZExC
WVJNTHh1VmhYUElEQkpOQkp4RzVQbzZpSjl6SGRkZm9HbWdqOUdUeUpta2RqOTBKazdaVkxWCjJR
REV6Tk9nNmx5b1Roa2hFYVNTVWVUL0tmY3kzamxjODY4aFdZQWJNL05iNHR1YXJQK2h0akRXeDBE
Um9HTk4Kdm1pVll3VngzNWFQbW9pNEFmTmRjdUI5bk8yd3YzYzh4VEExOUhKeEtqRFNmQlI5RkU1
UmVieXhRdGRvUTNZQgp0eDJDdGdocy83VlB6N2NZRmRhUHVlenBHZGxuVWZmTVc2N2xJampTdy9t
UnVmYm9kSG90N0JXdUtoMWpFU29HCmwyT0hBZUZCR1FSSXNSaDB4TVc4V3k2UmZxVzNZS3kzU0E5
cWlSRytNMzN6Z0RkWUE5Z0grRWFSTk5xb3ZHQTUKajhQNHREZm5LU3BTMHBqWDYyeWNUUm9rbmNq
amVESjNDaEQzdis4dGxvazNjOXlXUGFJeW52dFJGVlprQ3hjNwpNTllldmF5RVJCNG9EQUhvaS9u
bnhscHZtc1FWVy9VU3NrVEx5UnduemVaakZKSlgyRnNhT1VVSmJDdFdBc2hvCm4zd2RlZDBvKzdq
K1Baa09lRzh6bHVWcUlzM3RMaDlpV0ZiRjZjQT0KPStmVTQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008061980624fbe8ca--
