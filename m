Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F541EE7BE
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090519; cv=none; b=d5iRr1XWe3sdw9rtXEnI75ZvsahYu15k9QaK2MWySlu2pCzVZRLyQKnT6gZA2XvsgnpHvo4Whu8gLXxWwFZb6Esq4+7GHY9014Qj1atvlGUFgq9/ADOpPlqzlAd8ndJYY4WeeVa2Be+KowyLnuxAGqhl2565BKkzlIWxMDAsUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090519; c=relaxed/simple;
	bh=KBuALw5Vc0rduuXwFt9cxd82R/V9ZL22ReWRC3Asuss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a76tejL9KDcmGE40wu8AnsxfIifgKAVhc1nqcwZcyHUAac0vsv+uKS3QJpWFXW5RKFPcCVS1HTzvv/381pPoyFubDuNu2vDE5Y/E9aW27PBLydDeCua3UD5QRnurzheQmvAh7e4+asGoiRopl2YofWml8mu8itEg7rDBAKFQcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHW+G+lp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHW+G+lp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so6696a12.0
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 22:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744090515; x=1744695315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60EEWI9EEqnEefdR5+udEHVeE9WvwgVuCfdHrtVcSOM=;
        b=FHW+G+lpsExNhM9oAEUYgyGJbhFXNu2rhIGBfTJSfNoQ6EUQQVIgHsY9WGcbRffpfS
         9hwCZFdfSKGobn0f3JMZhrrQ6L5abFeDrGdhi8MsuStmSNW+noyKK/uki8Zl2T58mugq
         OMo3nSazBu3befkv6DOycmGDlQDMzkJfkCVYzVh47MrGboRI3tdwkVR4iwNb4gmuH0ar
         58fyrW2u5zed/p+KUXtX0TaVpihl00m4Lyus5IbFfM1Qizq4qnns0yM5kwC4Ifdor5ER
         AsucuBV4I/oJ1CGftm9bG6ZMDAtwzE4TbA5Lk/wl0bPpaq7vIF5vYwdZCHvozEyldSk/
         0jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090515; x=1744695315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60EEWI9EEqnEefdR5+udEHVeE9WvwgVuCfdHrtVcSOM=;
        b=YO6vdZKHKPl48UOLKTxGCRswcu+mV6CJFaWRDw268x+2L5L93WtbMpzXVAKkLgMYMv
         dtiSdLqwMS6vtrJ0huy7flDdJE9UQiqmZqrQ1xdR+W+5Bqo+xoEdqA3SXoI6m+VzBEKI
         cT7mErHB0pr2ymrCyqAhtPn7+vTb4AxRYGTSwEfdhB/o2CvxlMnAFfs8I8uXbIjSKgBe
         QNa0wqicEex57DG7uKDUM0Vt4LXZMpffGL2F25B6dIqKXAB05nnKCnIdOYC1nu48vfhH
         cbEUKHKfJ7L34L7R4VtmzUYPUf17A/ysWTkgJezY66M2dMzaksuYnZ9dnBNpSZAUGN6/
         D+HQ==
X-Gm-Message-State: AOJu0YzquyDz2v2rknvH+oSqE+2VET7b/Lb2GTZK7+wxLY40GYp/WCjv
	QCCWHngYSebCZUV7e53BPpGvFLKhANMGvBkmfpkz7cYv6fKw0RqaYSP8U5QEMCE+95/dLK6XlOq
	h4J+grbQfdaEm7jQ8bt81hlq9QWjWsVREEaybnQCG+r5bu+pxgw==
X-Gm-Gg: ASbGncu3fjhmEnRpeiWETwdDbLwBarNjeez+CE4wQ1lHa2Ek7wGs3F8EodI9A87mnpi
	3CEHTqgGoCUQWTCYk/joKTBR/hKpHZmnz/k6VulVqKcthrcLvOFqIRwTnwK4Efte7GMotPkfyur
	vwIz07mh9iKB1o5qDZRiLF6QP3Dw==
X-Google-Smtp-Source: AGHT+IGi4T5z7EGCVeTc+K1sxs0ke7HmZJti6tt0u2vfQtWNLQJ4AMPnazeXKwHDvG+AsmL6i8Q9vOO9UWpei3I+b0M=
X-Received: by 2002:aa7:d045:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5f26a6984e5mr54086a12.4.1744090515072; Mon, 07 Apr 2025
 22:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <xmqqzfgrjyws.fsf@gitster.g>
In-Reply-To: <xmqqzfgrjyws.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Mon, 7 Apr 2025 22:35:03 -0700
X-Gm-Features: ATxdqUEr8AE9aCVEvu4tMecogKVI_DofGjf57fPwa1SC67KP8u0Kt1DHjZNzAbc
Message-ID: <CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 17:10, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> A well-kept reflog on a topic branch can keep track of how the set
> of patches that makes the topic evolved.  E.g. with something like
> this:
>
>     $ git switch topic
>     $ git range-diff @{1}...
>     $ git range-diff @{2}...@{1}
>     $ git range-diff @{3}...@{2}
>
> you can view how the topic as a whole has evolved.  A downside of
> using reflog entries this way is that it is not well-suited for
> distributed workflow.
>
> A set of individual commits that share the same "change ID" is,
> unlike reflog entries which is an ordered set of tip of topics, not
> inherently ordered.  This is inevitable in the distributed world
> where many people can simultaneously work on improving a single
> "change" in many different ways, but making it difficult if not
> impossible to see how things evolved, simply because you first need
> to figure out the order of these commits that share the same "change
> ID".  Some may be independently evolved from the same ancestor
> iteration.  Some may be repeatedly worked on on a single strand of
> pearls (much like how development recorded in reflog entries of a
> single branch in a single user set-up goes).  I guess you would need
> a way to record the predecessor vs successor relationship of various
> commits that share the same "change ID", much like commits form DAG
> to represent ancestor vs descendant relationship.

That is correct. The change ID should be sufficient for handling
simple distributed cases involving a single remote but it's not a full
replacement for something like Mercurial's Changeset Evolution [1].
For example:

1. I push commit C1 with change ID X to remote R
2. You fetch commit C1 from remote R
3. You rewrite commit C1 as commit C2 (still change ID X)
4. You push C2 to the remote
5. I fetch from the remote

My client will now be able to tell that the remote rewrote C1 to C2
(because you told it to do so). Any local commits I had on top of C1
can then be rebased on top of C2.

However, let's say you had instead pushed C2 remote R2. If my client
had never fetched from that remote before, then when I fetch from R2,
it would not know whether the new C2 was a successor of C1 or actually
a predecessor of it (or even a sibling in this "obsolescence graph" as
Mercurial calls it).


[1] https://wiki.mercurial-scm.org/ChangesetEvolution
