Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE51D5CC2
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763557; cv=none; b=L95jvVM0bUPN0DBnsKhSW7M77WxCx7PmBzX9uvN2QeLK+v+B5S+rlfu2y5XKtkn7apveGj9+y6LfaxxzPWaa7V7fd4qsj+wlCVh3PkfLsC3e7Bz0SdiDFFCjIHVlswUG6J3TxR+ws5nW2NgfNdC/BCZOYpznMZffMc2zkQ+rhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763557; c=relaxed/simple;
	bh=oVv62QpyV70fdJrjyOp8nusGjSJx3Dew9eiCx+GaF30=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=W2NxjmB/f+ZEOmvXlgIx3eo6/2o3d+aKSb82KWZydJ4ysrjHEGYeteJhLto/1KKB593s6zREnD9iI4t6CTGu7725dx7JTwJKgd6UcH/c79i0AdituQLgdsxLuVwS4GcG9kpse0tU/+mqAXDYvUlFEmlWpszUkYOiV3cGrM2ZCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YL/yloQH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YL/yloQH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e86e9so36851867b3.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730763554; x=1731368354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hiV2jVWWeVrru067YNQo0c3q0GSFiyemWooBwZpGhfw=;
        b=YL/yloQHvDmhu1kO08ns0lB1al81q/KO+9mvjFKxRzjFRGolTxvhKrWsz8iB42X8IX
         9tMUGnDvfugU5eFIr0lfYQTGxq+kXjzP6InOAMH2xtnJmukCHjLYRhTiftaZN2zer2K6
         W0tn/fC6Z3c+JXbXDi2UXAJOopS1VVTvyiwGhLedd4ZixYCgkMc4tFH6jZiFwfOXLb5A
         hV04doE/gWq7CBfw2WOfxey3+z04fee5nk2z1FNkfxI+WTURGl07NiAK1v6hqd1RP/IM
         K/xm7MXogcA5McD0KHDQxwZLGrJya+6jZH8NWkFI+A81NoYP/8YBinHmQWlM46CHMg/l
         +7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763554; x=1731368354;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiV2jVWWeVrru067YNQo0c3q0GSFiyemWooBwZpGhfw=;
        b=wSpar43U/QwQePvM5IfIVr1ykqNW9MCRC8K8RkQf/6i+CjpeoAc589zyFXTC4kW8ur
         pVpgriqQq3I4MGIfyKxyXAdhg10s5LEkfQ9EOqDsNIVJM1QEyQcs8k4W/Lmth14DvxXK
         4AeN/BQCeaGBkHbE10Szyrg5KAEt4smMMqSGEx8CRNJ4gHUhvf9KdtD1rid0mm2BOx0C
         1Stucbrt9Ps/vp9otU+pNlTqoxYmJN4fCMB6pqIE1/Q1883F0U6X/9pvPSG7rWaWzuBP
         vyBxDQzzPDDskjpby3rwmWNnGMMly2sbWcbCreaNSmFzGeuydAmHSaBcc5wLr6cx98ha
         cteQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgiiHeI+8gRqIr9oFVAL2CvBEav0dAsAZZp6ULZ4dnVr0PgwGYARiJ0lUtSIkvINDRWqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u8tqvF2nB3bYVSB061TSCusAQWlqZOxX+QN3fH2QJ9+YFwZ/
	GjMwShCBfr1Hrz0yuUpTju3fcW9KOOoPbku7/dAMy4Uyi3DOyB/xwKc3JqXnP0ZECWABT0rvoKo
	2csOa4sml38KCTzTZxyXWZqNKdIpfGg==
X-Google-Smtp-Source: AGHT+IHvkil2yAJWhNvYeYVMI91SluTXFaDzIrsnjW4Ip8W9vd8rzDIb8LNGrxEW53B3F8zJdKt7JEsGvsNwafoiProj
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2aa0:4fe8:8e66:1c8b])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:998d:b0:6ea:34c5:1634 with
 SMTP id 00721157ae682-6ea525566admr954387b3.8.1730763554582; Mon, 04 Nov 2024
 15:39:14 -0800 (PST)
Date: Mon,  4 Nov 2024 15:39:12 -0800
In-Reply-To: <58e2e41e-ff67-4d4b-98f0-48be5eb3df27@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104233912.2493936-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/6] t6601: add helper for testing path-walk API
From: Jonathan Tan <jonathantanmy@google.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, 
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Derrick Stolee <stolee@gmail.com> writes:
> You are correct that if the path-walk API emitted multiple batches
> with the same path name, then we would not detect that via the current
> testing strategy.
> 
> The main reason to use the sort is to avoid adding a restriction on
> the order in which objects appear within the batch.
> 
> Your recommendation to group a batch into a single line does not
> strike me as a suitable approach, because long lines become hard to
> read and difficult to parse diffs. (Also, the order within the batch
> becomes baked in as a requirement.)

The hashes in a line can be abbreviated if line length is a concern.
Also, note that I am suggesting sorting the OIDs within a line (that is,
a batch), and also sorting the lines (batches) as a whole.

> The biggest question I'd like to ask is this: do you see a risk of
> a path being repeated? There are cases where it will happen, such as
> indexed objects that are not reachable anywhere else.

I was thinking that the whole point of this feature is that we group
objects by path, so it seems desirable to test that paths are not
repeated. (Or repeated as little as possible, if it is not possible
to avoid repetition e.g. in the case you describe.)

> The way I would consider modifying these tests to reflect the batching
> would be to associate each batch with a number, causing the order of
> the paths to become hard-coded in the test. Something like
> 
>    0:COMMIT::$(git rev-parse ...)
>    0:COMMIT::$(git rev-parse ...)
>    1:TREE::$(git rev-parse ...)
>    1:TREE::$(git rev-parse ...)
>    2:TREE:right/:$(git rev-parse ...)
>    3:BLOB:right/a:$(...)
>    4:TREE:left/:$(git rev-parse ...)
>    5:BLOB:left/b:$(...)
> 
> This would imply some amount of order that maybe should become a
> requirement of the API.
> 
> Thanks,
> -Stolee

If we're willing to declare an order in which we will return paths to
the user, that would work too. (I'm not sure that we need to declare an
order, though.)
