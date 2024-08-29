Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29323146A96
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952578; cv=none; b=VQnuKE7cQ3IxwUlUr5hhN4CCMf4bmh5cJV0ST7lqCK4MyNbqmIFGXlIJKbJzK4x+AAekeQB4SCNmt0xtn3GgPKvrIznaZgXrYXrpIxP9+As7amO+Ea924Q+noD5hnGgFBgBdSNeJiw2/uvX0FA3tMMCjO60CV4EibThNaA3LSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952578; c=relaxed/simple;
	bh=Mqv//pF1lWiETZAX9xz2/p6Sqhs5KnWcGWkdrT//vrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBFsoZIuCq6Jg866mqVpRWIz9hSe4YDtvwr0fQQJB/kNXlCb4VGdSYsXhC4mvrwIuBDPNioVgVOH+gC0U7u6CRc3TZa6lZvCMqsOPwhyfqxzSeK60GhpCeWrzS5UYQpW6DjmAeiJquvmBx8Zd2thaCL1MQ/XHCcwP1DzXH7QHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06c8Iwv7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06c8Iwv7"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c07fb195b6so817a12.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724952574; x=1725557374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mqv//pF1lWiETZAX9xz2/p6Sqhs5KnWcGWkdrT//vrI=;
        b=06c8Iwv7QaNhqjw8lecvpOQ4SrLRafd+QUnrvcA2laVLA4FM9k4ZhsVw8hS1HLI3Se
         glkA4fAtGAZPuLBkoV/YpDKR55ICJWKoacqF291TyTWspXb5P6WF4rVk8esOTjOgOexT
         rC+WHcGp6vL0kCYwo8rt8xopRE5Owld/TxGT/Uwz6TabmN8h4itv7Qxme+Xx1fx6fMDZ
         dvGkrm0kJD0N5u8v9tX27KvIQwT5gOnXDr76TiXRMRBXKOfA8COVa4Dzn1oedniUpcsY
         ClVll2ejQqXLz8k2INOLKJttchl1fAmLIWxVMuq8PTkdYhL3ql8tA2wicfHcZc4UxEoN
         U/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724952574; x=1725557374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqv//pF1lWiETZAX9xz2/p6Sqhs5KnWcGWkdrT//vrI=;
        b=hA0l8tH5qnaGOcryktXD5kYbrlCCE+Jk83a62nrnJ2dDNKM1eRWr2T8h4vBVfSsXcu
         9FDX1xO8uxKPjYdZmvvrvCcmr7C5hJ1gQeNgNd00K0uJ8zjj7cravBRo/q+Xacw4DgMq
         A6pgEHJzpfeP4Jnfzo9QP1Aikh/Koycx9hvupyJP9M33YyvAgtmuOC3Mnzkg+BMf9eWU
         cjQH87cJ5dyczzWIqv6Wt/9j/22VR0SZNiXMOfzqXQPtcuzJpEJPUaAXQVJg1//XwPZN
         Bct3GVesuPQrKxORw0jWoFynjfKgzheE9jv6p6c5d2d7Lf37ehJAqhrOlEnaE2G85xO0
         KSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX93gfS6E/2YKsPYuXMrIFZ0/zqAi1LP9HcQvGeBg3Fpk5Qugd78sXBHlALPTGcwg90ReA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizgU977Zi8k5Mk4bID3s1t/s7MF/p3+gBV12d9C0nB6aOEHx7
	ZW2DfCOhlP41nPjpW6Uz74T1LM+pXNQLR8IVeiCJ4K3AbV6vv+uOknmc8X40UwsiikXtgD+6APP
	FY7+76D22sU2Aoc9zfs5dves2ra2Koyg9yg8FCj59IoXTfQXqMQ==
X-Google-Smtp-Source: AGHT+IEURmKovBGpDBQLmRvBQ8oozRf/7MevYWavTBK3yM/PPdcWs2MuoBBIgLk2+QsACriKMI+wD8kugpfvqtzrTOM=
X-Received: by 2002:a05:6402:26c5:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5c22df47011mr1556a12.2.1724952573727; Thu, 29 Aug 2024 10:29:33
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <920db3a2912c609d4ac1fca2fc6b137513c8eceb.1724656120.git.ps@pks.im>
 <20240828202902.4156688-1-calvinwan@google.com> <fazvh3gejzofti6ii4x2fkoh66hni6lcc6axc7w4tspte4lioy@hgnvhue2pm26>
 <ZtA0Oj0o3UXmSIDP@tanuki>
In-Reply-To: <ZtA0Oj0o3UXmSIDP@tanuki>
From: Calvin Wan <calvinwan@google.com>
Date: Thu, 29 Aug 2024 10:29:22 -0700
Message-ID: <CAFySSZAPJUkZmVrjzoaL6JqdJrmfphecq58X+yZZkwqu5yJGZA@mail.gmail.com>
Subject: Re: [PATCH 15/22] negotiator/skipping: fix leaking commit entries
To: Patrick Steinhardt <ps@pks.im>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:41=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Yeah, that's mostly the reason. We have e.g. `string_list_clear_func()`
> that works around this issue by making the caller provide the cleanup
> function, and we could use the same pattern here. But it seems as if
> most of the callers of `clear_prio_queue()` don't need this because they
> already drain the queue during normal operations anyway.
>
> With patch 14 you probably refer to `clear_shallow_info()`? We're not
> using a priority queue there, so it is not quite related to the prio
> queue we have here. So I'm inclined to leave this as-is, and if we ever
> see that we have more callsites that want to clean up the prio queue and
> its contents we can introduce `prio_queue_clear_func()`. Does that work
> for you?

Yes it does! Thanks for the clarification
