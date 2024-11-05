Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D61CAA4
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832883; cv=none; b=liZHurFhTyNjwqP2rM+ZKNmwnyn1pPKo3R3DMxdFqsqT/Ed5G+1dVVOy1pS9uIzgvVuplXvLZ4BP1/mC/RVzciX28M2sGrXDfHF6sCtLa4hEprUdr5Bv4hiYcQAtW8J/VUwOQqFSupQqOLLjHoAWR2muazdaMg1CW8xo8May9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832883; c=relaxed/simple;
	bh=mgjoKUkBfKBt8fzofDMFZyakKggVMjOwOppwWoik3p0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=LSF5FoQiUkcFgNGcposcgjxNxvh40IPZLQKWmd2ew7OFcjc0PCy5rnG2TZT4/04tvnpZo0mj51BWR/5dHKcwnFAHse1RyzyGG27lsKCOvo7EU1Nz3wHjypGZX8bI4loWqZoMlSBjAuLyIGU3nQGm/fIhA+gO37EkAUPbsvCGzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Stkg1gDy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Stkg1gDy"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7fb84f999so90191517b3.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 10:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730832881; x=1731437681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T1hUBeqmQ922MHKupqdZrqMdwQb37UgL0l1SLmMNbN0=;
        b=Stkg1gDyMkrubMtfT+kZZ9h2dF8xMEk+Nlsp4Vj0OvHbfKvJoaKoDvHjPrtdhAqF2Z
         XwbRkYrVBl+MI33NOqqM/giR4TK/8ptcWoVP5MSnqiB3MPVNuodEzjSKwac998RBo7CR
         WU8ktLB8D4194jVvAb3DlWJyWEIEEd/cMK1qBbWziN6+xz993kl41ifWafrgwU8Tz1oa
         VbesWtPZK2vkTZeWUedeYC00tPZGofaFS/jmdmc8TheAxPbkQQewMb3SvIViAzEhjSbd
         OUqY9pNO0pKa1uEyHbsSgy0oV74JhotQnPvTb4f1ym2+jeH/+4qS0waSSiy/HsEqSkln
         1NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832881; x=1731437681;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1hUBeqmQ922MHKupqdZrqMdwQb37UgL0l1SLmMNbN0=;
        b=U9g8CR5em9/DNaPRAm5YU40TgZwnVnwGgR/U9jsf7XTBJhmuOXWIuBwurFVJ97vED9
         SmWF6JTLA+dovHTCvVPw1WRKtzapiEbIZR/TlzuH6gs7L4U+bdiBkRYmXUQ7CzMTzpNW
         Rk2K+9Abf72yOkG3YolUG9E7XBo+DhHBVqpimaBtOg9P+tiXi5Jv95Fu8c3jK5aXIFib
         kC3k6+FSmZHMBd8b+gvdRfD/WkijZXu/M2WzHd4pZV1KsP30dBIcB5+3FvYLMf0q0pMM
         7XJ76VLR/4jKbvJ+MXwG7bQ2YASqvf4DbqP4BIH2D4QGxZKaygYZNgdxlyj5cyDKlxPR
         jgMg==
X-Forwarded-Encrypted: i=1; AJvYcCX4mv01CwN+jX50tcG7yWEPQiJ2Fw3M3Z5Keif/lMxnynWZE823Fr+LKQNCPi9QLYvHcWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yVAIZgr99B3C3NGfRk/5jmFVHwNmT5osxBUdhalkRh+Ee6MU
	vQS9vdxJ41L5EWqjjxwwxAjgTukwF2ZKr5f9iJlO/sh5u/kvjyP3hgMsB+IZWV8C4ReeFs6dz7I
	tq1F+Hi2XhRwHfgtPPciYO0joe2jo4Q==
X-Google-Smtp-Source: AGHT+IFQuDicZ4cLnsT2EYN9s9t9gnmco/RyHAE4iNavJWHIMMs2Vzk5BLjxMPx/0TukkHjw4fY9sLTyJtOZaifIebZb
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:af5d:b903:295d:2c17])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:408a:b0:6e3:19d7:382a with
 SMTP id 00721157ae682-6ea64a7e14cmr554077b3.1.1730832881161; Tue, 05 Nov 2024
 10:54:41 -0800 (PST)
Date: Tue,  5 Nov 2024 10:54:39 -0800
In-Reply-To: <xmqqbjyuted3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241105185439.3230561-1-jonathantanmy@google.com>
Subject: Re: What's so special about almalinux-8?
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> Everybody else seems to pass tests, but not this one
> 
>   https://github.com/git/git/actions/runs/11677884048/job/32516504151#step:6:1995
> 
> I am not (yet) so familiar with the topics in flight at this point,
> but there are a few topics that deal with packing, lazy fetching,
> and commit-graph and object database being out of sync, which were
> handled by a few topics by Jonathan, so I am CC'ing this if it rings
> bell for him.

That run refers to 95dcd58, so I fetched it and tried rerunning it on
CI. It seems to pass:

  https://github.com/jonathantanmy/git/actions/runs/11690124087

Having said that, I'm not sure what caused it to fail.

>   ++ git -C dst rev-list --missing=error --objects main
>   fatal: You are attempting to fetch 957c60b67968d2ab4144e7e2fbba99d6ad864e4e, which is in the commit graph file but not in the object database.
>   This is probably due to repo corruption.
>   If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object.
>   fatal: could not fetch 3246c304205324149983025431c5211438f41931 from promisor remote
>   error: last command exited with $?=128
>   not ok 22 - use fsck before and after manually fetching a missing subtree

This is supposed to happen when we have a commit in the commit graph
file but not in the object DB, but the test is not testing that case -
"dst" was cloned normally and we did not manipulate its object DB in any
way (outside regular Git commands). So I'm not sure what happened.
 
