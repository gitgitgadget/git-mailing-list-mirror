Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DFC1E48A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456431; cv=none; b=iv/mzrwGNiRTC69Qv5RGK4EsZQS0i5F1w0y2a3scr5cmy6WdLSw/e8x2ElBiyBjlGcAw2CetKKXQcgRKebWjoo592exYg+q7gdNeb0mKtdSR+5KaHk/tBbv+YZlAQR+zegKKVrgeQtU30jMohIXdw3EuWNHAvs4vPLD/SCcUVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456431; c=relaxed/simple;
	bh=dLn7W1/p7yOTJxP+uoA0DI11dhyb3d8mY7l/Y4fggqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBSzmqYoetvbP4SMllDTwMbbmlPcXuFe/KbiubE8+eVUTA9E2ruBaINg1xubE9L0/pmwpfC0n+KiQhiyFldpGBPFzI1hLIh5nFhcrIu6N9gJUV0JDIagk08/VC5s7JyAwzNvhDZd909u0CPR3nFMtSISaTgclhoCIoLIxXhI33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ik1VsLjN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ik1VsLjN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so1884007a12.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 23:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728456429; x=1729061229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdUwihOFOhtVHRUz/j16JwQGMEzOVShR/8GeTG9B1dA=;
        b=Ik1VsLjN3alZsXSnLRpwlzIOVWAZqPunQZ6J85A9fwR4z8cwCvaj2gqBKH0Dub1oL7
         ZhNJHOfPjGhUKu/Z+35B0K0Hq/pWHfJY3oKjJiISiFGITjH1BkeX6hC5oqomhvMc6iCS
         E2Kfe+Z5G6fX8wMlVL9sZwzboAEBd7VrM22q9176Qprqe1RO5Xxjo+oJ09yvczJD+Io0
         0rXouwCyXPrPFH54Z7OkAR6JdWPQKhMih5gZxTGKOfzvVIJ7oHT35RlJhYcR+muoi3bD
         s7XaK1eEZ6P/5nSz1EB4+Ypa0N1u6ZSia7KA2E0B6iLGVYkmqZXu5Q52BBBU3xFC210w
         QZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728456429; x=1729061229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdUwihOFOhtVHRUz/j16JwQGMEzOVShR/8GeTG9B1dA=;
        b=LZen2zDbW3y/9n6LEjrAM2psalQL5SJrz6DliTqzGURVh3+45Z1r41bUs+GbZYX8OC
         OZj93cb99QpMlf++cEcBdBw4bqBavTbu/v/IYwWEFSTb4yLMxfVbDnS8vSFlOkYZvb8n
         AL1fHbuwQVBShwbdtRvLL0RipZZeaLUTiAYD3jyTLPjDFjG6OsB12Wqpo4+s4zLR+DPt
         Rk6ucUI8AXfTnhWDv7se85nx5lQC4yg/a2hCI2O+ZzANUkC9JyjIla71njQc8YNL6cQ8
         fuH8myJvZLE/X3ecBC2TPh0/wYatOjQVmkPJBD7XORESPAe65sc4jRvEJ9PrJgMErcMh
         nmAw==
X-Forwarded-Encrypted: i=1; AJvYcCUh+eO2nAaq/KM3icZLPNCTLXsC2EPFONqyXJc1vM/krQ0WX9sLTzq/UH8isEhUFqNRmag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSTchT89omzQbLA0p+ep9m+sN/KYqtLmrIXkkkm8T9BmDF71O
	fY69E17KK2JpZBsYUuq5wWBSr/p2OLScO6MmuCjPJStGc9SzSA1myr4od6jF3+pE7UQqMlUXF6p
	s7MdFPOSowvCOcG7wVjvD31K3HIKZs7k1mHEdcw==
X-Google-Smtp-Source: AGHT+IGUOeaEf7OYnNKbCKDvcOV8Luv5e0+iWtHNaoO1W0B5JgQeq4wPqy76RkLm9JWu0hrq7/06FcLnFgcMg1hR0D8=
X-Received: by 2002:a17:90b:d85:b0:2cb:4c25:f941 with SMTP id
 98e67ed59e1d1-2e2a2471edcmr1751472a91.17.1728456429283; Tue, 08 Oct 2024
 23:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001191811.1934900-1-calvinwan@google.com>
 <xmqqo743qkn9.fsf@gitster.g> <CAFySSZCyoaKCGycYgJjCJGJ2mV1yfg+gVFb7RytGKmkjupkNkQ@mail.gmail.com>
In-Reply-To: <CAFySSZCyoaKCGycYgJjCJGJ2mV1yfg+gVFb7RytGKmkjupkNkQ@mail.gmail.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 9 Oct 2024 14:46:57 +0800
Message-ID: <CAG1j3zGcdfd6YRb=Fb1Aqt5kLajueagV+6upt6vwsGW9RxaR7Q@mail.gmail.com>
Subject: Re: [External] Re: Missing Promisor Objects in Partial Repo Design Doc
To: Calvin Wan <calvinwan@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:36=E2=80=AFAM Calvin Wan <calvinwan@google.com> wr=
ote:

> Objects that are in promisor packs, specifically the ones that have the
> flag, packed_git::pack_promisor, set. However, since this design doc
> was sent out, it turns out the creation of a set of promisor pack objects
> in a large repository (such as Android or Chrome) is very expensive, so
> this design is infeasible in my opinion.

I wonder if a set of local loose/pack objects will be cheaper to construct?
Normally loose objects are always non-promisor objects, unless the user
running something like `unpack-objects`.

> > After a lazy clone that omits a lot of objects acquires many objects
> > over time by fetching missing objects on demand, wouldn't we want to
> > have an option to "slim" the local repository by discarding some of
> > these objects (the ones that are least frequently used), relying on
> > the promise by the promisor remote that even if we did so, they can
> > be fetched again?  Can we treat loss of C2a/C2b/C2 as if such a
> > feature prematurely kicked in?  Or are we failing to refetch them
> > for some reason?
>
> Yes if such a feature existed, then it would be feasible and a possible
> solution for this issue (I'm leaning quite towards this now after testing
> out some of the other designs).

Since no partial clone filter omits commit objects, we always assume
commits are available in the codebase. `merge` reports "cannot merge
unrelated history" if one of the commits is missing, instead of trying to
fetch it.
Another problem is current lazy fetching code does not report "haves"
to remote, so a lazy fetching of commit ended up pulling all the trees,
blobs associated with that commit.
I also prefer the "fetching the missing objects" approach, making sure
the repo has all the "correct" objects is difficult to get right.
