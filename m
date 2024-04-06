Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30985D29E
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367453; cv=none; b=a1RVKndKf1W5IwerYTeXIUHiPyB+B/AGrz760qgNPqmEj0KNM+aI9FQm/M+2+99CeOHI+k4F7qOqk+yMezuvxPgvBeP39R0m0kOnLviCRydZfZ5Igl5AFPwkr+FpGceA/zlai84zCc8ysKITdG0oDF1AteFk8tEGi+H8r6rJOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367453; c=relaxed/simple;
	bh=RHnWd0008OfWeUaZgPpgjJNlojKVyI2rPSkwZ4eXUB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bCiXVPMETL3NnAOwSGAS4fN2em2QMajt2LymOTTbYBh6iiDaWIqvQNNJWRFWg4JQxvQ4DjyI3+1XQLqfdvCW9FNAkJywJXpTSd/cJj/n9HuruiBUx1cOu0qtd/7kdYrKfoFCO9mnslLvMqOSTXlTPwMBsEKhJ+nHGj6R5eW3q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRVNKxYt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRVNKxYt"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a4ee41269so46778007b3.0
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712367451; x=1712972251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8Aq/0irfxIE3ubeQNN3DIUHEnQn4ajFZN95bAlIJGA=;
        b=oRVNKxYtXkYIwNnStjpk5HmWYk287mwtqtQIXPDQOfoLaJfV6Pg3Zlf/q399T6BqrI
         2eRojWOOIZpcdUlJ/In3ax3yWVZEf2HzN9RKFaseHPCsiEp3godIbOckTTJg5+CB3l3p
         wZx5ZE4BN8ekEseDHhFFLeVqLOSzqyEZ9WGNJdwFqFSlaonmzyFUTzxnyvEZFUXSd3EV
         K+TR53S1yzSqr6ac9jWRGi3560fm/0rNIzy35ifxT507vkOh49ieZTPRf1FCUknMgy2O
         3XSVzoom+eCOLM1rjn88+pqnDTKxR9kCT5Rgprcjuxdym2229Spg2XMb9IjbomF/KUk9
         hcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712367451; x=1712972251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8Aq/0irfxIE3ubeQNN3DIUHEnQn4ajFZN95bAlIJGA=;
        b=jnT/ubc1QOkQa65z01tLFvbahClsgf5MZkXL/UFaLOzbUOTE+s2iru6VqutG2AbUiB
         BFzycOJOHbiioKFvXK5fT9XtxbIYi8k5FRWtssGW+nsSROtKvDHta09FIf2oeGV0ZgEV
         KjPYAGgQWEDxYzFmWzXMEzIg+Ng3uvb4TUMDC16YjeKJofg0vfSDJc+hEVXyEf18sfMX
         oLiO49SUT4xWkou2xc0dMWhMZvodanvUasA3qeMzrV9fsDe27B5+KBZnK8oDnLzgCEOn
         JKDFZEA/Kv+9yV/Sl/SOc7velBbuvDtKSDM+4kXqbOHQxL7tXwAaQLDrk2JIq4vGisO9
         RXsA==
X-Gm-Message-State: AOJu0YzdoIHuBcevbfxQHWBWWkOCkMb/DSC4YFA3wGY8Yl0z7CHpKRo6
	2nt0h5kjapR0yd7TQ03yh9p1ahFKF0DYRhwodLc8m3UZuaPWnfuPIUuAkLIro6oi3Cr+QaBHdnb
	Cqg==
X-Google-Smtp-Source: AGHT+IF9oQ0ogLRms9sFqYrH3F+49+E5B7Q1c0zgYpKcOxTUvl8dkxPif2lsyvg2wHDKb/w+eSCTiuYXnUU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:e805:0:b0:615:32e1:d82c with SMTP id
 r5-20020a0de805000000b0061532e1d82cmr744623ywe.6.1712367451128; Fri, 05 Apr
 2024 18:37:31 -0700 (PDT)
Date: Fri, 05 Apr 2024 18:37:29 -0700
In-Reply-To: <xmqq34t1n91w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307183743.219951-1-flosch@nutanix.com> <xmqq34t1n91w.fsf@gitster.g>
Message-ID: <owlyo7ans23q.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org, Jonathan Davies <jonathan.davies@nutanix.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Florian Schmidt <flosch@nutanix.com> writes:
>
>> It seems sensible to expect that wt_status_locate_end() should honour
>> the length parameter passed in, and doing so fixes this issue.
>
> Thanks.  This is an ancient bug, not a retression from recent
> changes to the trailer library [linusa CC'ed to save him from
> wasting his time wondering if he broke anything].

Ack. Very much appreciated!

Also, sorry for not responding sooner --- my email search queries so far
were using "replied" as a condition so I only saw this just now while
searching for the "trailer" term.

Cheers
