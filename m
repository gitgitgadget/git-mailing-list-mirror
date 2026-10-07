Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13820455617
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396446; cv=none; b=CPiPutncA4ZJtBtJnYNlqztUUkNe5f/7CkyAFNg/43BC7B+XvWfhZkajAXq0d2ZZaxKuZOXkmIdd2KOWLuwjXM/c0YpY8AKzonolWkTF2aGap19KYxnMME2xd/1oRGh9qLhe2mW75EDBMOld1tXKZ5phaSZVzi6UDT+Z+5q0vuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396446; c=relaxed/simple;
	bh=uGqpuzSlWqlHAwhhF8y7KwBvlxAfhru+q2rdBLSFIYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LYy5HgUgTlbTPSVA3LLEvqvnl4En7jolWq4y7/ZXVBoc0tRBnp8eo5jPTrXdEqKpTzdjSLaDsf2uKv7bKldCwBls88lUnFr3mFKIbwxyP/pEpCAh5CSN9W+D+06nnekpsZKhFB9QwV1Z/kLamEfO5nTKK2wk5TzfktLhflI+5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asZbemx3; arc=none smtp.client-ip=209.85.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asZbemx3"
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98c854e7439so396758241.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791396444; x=1792001244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bd9Qk1Z7D91FSg6DsyOfYGm/LEsCPvGa1tfcRgpoC/E=;
        b=asZbemx36uYP66D4OIPS5G8fNkJkrDXL3cHAcZB/fU4z0/nZRF2PKgWtmcSertv4Kx
         WlxLAD90ZC8CN2fS7dL0/Bp6u2PkS1xJwNrOt8eYZEs9Y1cPIcDWUXmJUYNH9zqDJFKm
         Jo3DSwnUArAigbirTeRaaLdxRIkN878xOqbyCiw8LhPsbyGt0IIe0YKmxJsejtXP9KqW
         5zzsHL7XwZifESpe7wwyYnQ6HNlybbYVEwjzQwD11kgcn6+Knkx6cnvHwduglH8LhfWA
         oKsW0eMDpsPc5VljkYEVRbIIJJ18BTXPyp+qNAs6X9+z2EK4IWGlVto42lOYBtCZlGym
         LfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396444; x=1792001244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bd9Qk1Z7D91FSg6DsyOfYGm/LEsCPvGa1tfcRgpoC/E=;
        b=ufaIxgSTbvYoEh+ZXkW1EOAMNtImA7aaOBlqoln7uHvn8UMiXAoCKjG1yK+CxhXxla
         K11dvTpyTyol99BJtSHGLtKXiklilWTIMKoyY6HOkaVnzWdrk5XdLWMzsI6j3Mxq/c+w
         jM1B+VI78O8BTei06u7bUTQbWdYeXXdD9rrBckpZwwLXBsTE8Qe3Jlt7+g8PfiDndwuy
         MRmVQKyD4IyaaR8eX1Kze/9LEMXyEZfgcTC8AMxazNdzfe0Hr64y1+X66qc6W8XC6gQB
         HuC0cvpGqDu3bSoTxLZjvC6aLaSqxUcKnvcDh83EY2ByBLxXH4FqM3Rqsnek5ToveGAN
         oGCw==
X-Gm-Message-State: AFq9FYL7FDjOM3LkYaHGKE3A5rgK5NWmQInoZzP1rnRVijXwLLJsVjBw
	2qH0uqSn7oz1Z/6HIlZh2QMkjr6F5JfwiP9lQ5sxvIgoBvKG1FJuUSjHQCTA2ilZQR9BVI125Tp
	LlQFKE3408A==
X-Received: from vsbfx15.prod.google.com ([2002:a05:6102:580f:b0:7c1:7ba2:c312])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:2b89:b0:7b9:fd44:58c4
 with SMTP id ada2fe7eead31-7ca38b75593mr875809137.16.1791396443342; Wed, 07
 Oct 2026 11:07:23 -0700 (PDT)
Date: Wed,  7 Oct 2026 18:07:22 +0000
In-Reply-To: <xmqqmrsp8kzj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <xmqqse2kma4o.fsf@gitster.g> <20261005211213.1896012-1-rmistry@google.com> <xmqqmrsp8kzj.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.1.g22a100d00d
Message-ID: <20261007180722.3413265-1-rmistry@google.com>
Subject: Re: [PATCH] blame: default to ignoring revisions in .git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, code@khaugsbakk.name, 
	sunshine@sunshineco.com, abhijeet040403@gmail.com, rmistry@google.com
Content-Type: text/plain; charset="UTF-8"

"Junio C Hamano" <gitster@pobox.com> writes:

> Are you presenting a different plan, or just adding details to what
> you quoted from my message above?
>
> I delegated because I did not want to spend time on the auditing
> part, so if you are asking me that these two are the only things we
> need to address, that defeats the point of me delegating it to
> "somebody else" X-<.  Hopefully a v2 with some tightening the OID
> parsing may entice folks (who are hopefully interested in security
> related work) to chime in and they would help us decide if it is
> good enough to cover these two points and nothing else.

Ah, sorry for my confusion, I was adding details to your plan
above (I thought the audit was being delegated to me so wanted to
make sure the approach was correct). Will put up a v2 for the
security reviewers to chime in.

Thanks again!
Ravi
