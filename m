Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C947224D1
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692536; cv=none; b=n5l0r3pui1BiJ7h6BbqFYX0aZvYqVw1qMMfEp0H/97TcKXBCe5Z6HKq9o7Boszz8RAFdCks1oz1DG7/Iyc2AEWh88o8VdKmOp/VqQIMHVndww4k5ypIj2kkDmoQdkBDsekWGb016aXIxkilXINXxIfb5hhRHY2G6zIvi/tG0+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692536; c=relaxed/simple;
	bh=FNn+MNoBqWkVByvniFYUVmzEPWkxHZMRsnpk/YE4fjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j9x7YZhU4GZmVS+HcE7Dx2A+nOR95qVPlRziO9InMXluyChI07WrpxoqbHSQAJ6Ise/8uoLJ/xRcuG9ydgx/CMSJQGz35FNsLlgvXk2HgkpcBB8rSgVywMB3Z9vH27MbckguDDMnGSMcjz2yhqjFwFLzVj3BVmrQekGVcNRZouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8/4HytU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8/4HytU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-703f1e39c07so976528b3a.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717692533; x=1718297333; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4RqfTC1Xw5MFgBka9YsyGFk47MiMoAeo07OpGKZtls=;
        b=N8/4HytURJbh0kpUwSUDUGGmrFnh+0wpLqTg/iOprZiVNVxY8xe8q96PDhO/l5CauY
         5k40caMZLLhlwt2VDmoZpe4tmi5wHx0HFkM0Tlvwx3xpCkcZ1wfBhgLoJCbObNoTDfTA
         MArXDEh/Vg4wo79YPVECJyp4bxm6y4c6KY6bWFm+FkDUfeMMM/MVpxC4uKZFjUyd9XaP
         f/rFgzfuLSzQIOfaCC/tPFUv6ZDEViGYCBna3Vdkt2t1fajz0LoXq5/sqALvJXNoMGnh
         awMgrsLXLh9BMDTYT7toXTy1En9OgAZbSArF+LtumaDBUJ42OAX0rsDqPEo4N94qT+E5
         pDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692533; x=1718297333;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l4RqfTC1Xw5MFgBka9YsyGFk47MiMoAeo07OpGKZtls=;
        b=VZ6/tI8BT0w29DuAvmKfeAc3t9C9KQAQ4TC2j2a9r0e/42rxxSc5hx7GbihwuR4N9k
         LfyMpXi5Top3dDv8+2SnLrx3S2Xk5CSfjeZn24J+a83rrVJoObK6OlzcSc6xaYerYO6V
         d8LTg6Q491bV5346QmZam2vJMV3oBaoG8vkTw6EJlimHoF8+tGrwJ1a5Q/eJNkL4f4Ks
         Ay808K7SpPYYUROFonr17kQT7dyNatgOzAauZF1fCZwxlr2zgnkQV0sOfU9gT4nRy6E7
         PI0xmUlfk7/HXEbLSLNtLYShKoF27BAOk99P/9MvIRr/zDM4qzxGgcjtq8tgO2NTUYdW
         yw/w==
X-Gm-Message-State: AOJu0Ywohdn73GDhaPYYi0PAr9GispppPOpJ4dlrVSHI/c9/+3AHBEBs
	3g5AdWTc+iE1s3zJzlT/JOgQYl4Z0qOC+xVGBwIYU1jGlbNWEK0UMzuQ5Q==
X-Google-Smtp-Source: AGHT+IH2YosplcNnB7CcFngMR12WMVHsG/SvbHqYVmsdMiIupnCF0e7Llyv+z2IQgdKmJWAKB3kidg==
X-Received: by 2002:a05:6a20:6a22:b0:1ad:89e:21b5 with SMTP id adf61e73a8af0-1b2f96e16cbmr131330637.15.1717692533414;
        Thu, 06 Jun 2024 09:48:53 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4980f4sm1293746b3a.116.2024.06.06.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:48:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  =?utf-8?Q?Rub=C3=A9?=
 =?utf-8?Q?n?= Justo
 <rjusto@gmail.com>
Subject: Re: [PATCH 1/2] am: add explicit "--retry" option
In-Reply-To: <xmqqzfrym3fu.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	06 Jun 2024 09:38:45 -0700")
References: <20240606081724.GA1166769@coredump.intra.peff.net>
	<20240606082114.GA1167215@coredump.intra.peff.net>
	<xmqqzfrym3fu.fsf@gitster.g>
Date: Thu, 06 Jun 2024 09:48:52 -0700
Message-ID: <xmqqtti6m2yz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think even without the test-terminal cleanup, this is a good thing.
>> Any time there is a heuristic like isatty(), we should have a way for
>> the user to be more explicit about what they want().
>
> I very often do "git am --no-3" to countermand a failed "git am -3"
> (or vice versa), so I'll be hit very hard with a need to retrain my
> fingers.  But I'll live ;-)

Ah, no, this is not about not paying attention to isatty(0), but
give us an additional way.  I can see how it would help our tests;
it would be nicer if the feature also has real world use.

But I no longer mind the option existing.

> "--retry" is a horrible word, in that it makes it sound like it will
> keep trying to apply the same patch over and over until it applies
> cleanly or something.  Can't we use "--continue" like everybody else
> (like "git rebase --continue", etc.), or would that be even more
> confusing?
