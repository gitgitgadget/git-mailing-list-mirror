Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A56262FC7
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866320; cv=none; b=VDSRInzT0Vg3HNCjeShq7HEOMHeQnPrduExGOLPWfSjkZEXGXToY9AzehoQiPnZkVSycPRdqnvXUh9wb2JvTNtax9cndtH9VZoJfcVuiZ1YcJrlNYuSC46XOeU/LZNGusLxNVuMs9CBwmryPQjtBkA4w6TC2QLOsAW6YNlJzr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866320; c=relaxed/simple;
	bh=ZkDVthlgQ9JTU9s9jtyFGkL+T/VpgWpfRU229MbTcEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H0P4NFo7F5qpj5ujub/kVQutqlTvGWLGkdoY5sAPm33350qIE0ocZAHdZxJT77X6h076hNbMXnBRr6osvV25/0vJx4wGXAHmBto9A3CZPyGA8Pt7MTZ3ZjkCU65MOBi3F0kL7BOd/wqh/3ouKhTvohsGoPkApDguvyN7R2LvgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3bz5L2+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3bz5L2+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2350b1b9129so16888765ad.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751866318; x=1752471118; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkDVthlgQ9JTU9s9jtyFGkL+T/VpgWpfRU229MbTcEI=;
        b=L3bz5L2+fjD6WHiPyk+ysptimBgNTBtRDxwA3IJnW6v9lmiMkUS578E7H7rfl4tCPu
         DkCSaBhh+4SqQZ4Je8gQjxcLfCMi6eIfwkK/GkFY5ny7599vrBwG5Ux6RnEz5PXL0b+4
         69mzFHMzsNNGrNBRvLOJunOHnF8itzUAAiVPqtul7zJZ7yUYHIIrZGxe9nbHOzSwlGvO
         5VbKBKYXwEWiLVySf9m9wcrlhY4Vhj7w7Hz/kxifp8OazY5wpUuP4uFNiIml/fUQzTod
         lhf0/lxDHicQJD+LGuWm1SuDOvNscZCn4PAhfMGvJj+mFEOQL7wi7s3stNsO3QEIreJD
         Emrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751866318; x=1752471118;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkDVthlgQ9JTU9s9jtyFGkL+T/VpgWpfRU229MbTcEI=;
        b=U/3CMql87m41IL2eOEgg08Tk3DtkLdtqOz7SwQJR+pPBTJZw1vC5yEF0pWoDTBcesT
         fGqFUQ3bKdmFLokiJGmMtmI75SCyNW2iwIJJ9oJTkl1/3JnHRkKfuA0u7HCMxbyfnVkY
         JDNidcus/EvIQ/+4RoLrHAE1X2deiS0LXpknGIbFdKNpx31Ccro1MEYVaYrhdBWWhfYD
         NIL/YNsyBnVfDw+egn+t1Co7RcXkyolT9Q8xfSyEU7QZBUWsh9L/4TITxFEteQ0se+AG
         1kOsQMOtWAkDfBfvdENqm6cCwP46MLMz2iQFafTbSdD9oGjfL24j52gfe+luMC15kd71
         vPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVdZrOmkvIvCTMWYCOJ00dpVgDQE/rrqB+HNr8ZVSsh0nyjJgmV/yHE3ocier/owUhmk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6+wXI1R0//QLl43ke5f3N+zsuMH1FF3SVCvnKQE7G9UIs5IL
	pTtEAvpP1BiGJqAx4fCbb83otzs0Gh3YhVKGm0mz5JYXszJvrzZ5XPyTPL5/rA==
X-Gm-Gg: ASbGncu0zNvyFm83mJ29rXwptQQVK8HW8U8WQJktBpNd6fkAbQbfkOrItH2J3FClMQE
	aynxy8m7ovSaqjnWzHEdLbv6K3uQj0v6Wl/vlpOjCKgpkUL4w9d0fRiA4VMcHh5LqY2MdptwUAV
	YtqNuLjayrZ/7UNnOFKRJnVFZEgzwPS7lXqHY2hLX1FqRh7k5zdrlCysqy18YNkA542G4YicD4U
	dCujm5EF0P587TgCmE3n3GddXw70UoFTQ54rRz6ggRW6LxwCJ3mrcEPR4OEw+07ETF+4ojsDcuN
	R3P5AQhJV9OG7Z71n6oDXRPHuiYHk+t3c0q1q+u75sSMl2d3+7QscSPDIELOQz1/gcnJwzUR3rw
	BUQf16ewIp9hp6HcX35u9vDSXpyc=
X-Google-Smtp-Source: AGHT+IEcCigXJu8OoGc2QGRiQoxCv2Wwu2CtyTRveqc+kDQDWhEF1/iGnt7WCBtzjrvjfNoGsxv3gw==
X-Received: by 2002:a17:903:90d:b0:234:c549:da0e with SMTP id d9443c01a7336-23c85ec731dmr125716455ad.47.1751866318409;
        Sun, 06 Jul 2025 22:31:58 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431a1aasm75720505ad.15.2025.07.06.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 22:31:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Eric Salem <ericsalem@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH] setup_revisions(): turn on diffs for all-negative diff
 filter
In-Reply-To: <20250703224428.GB1909836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 3 Jul 2025 18:44:28 -0400")
References: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
	<20250703153438.GA1309870@coredump.intra.peff.net>
	<20250703224428.GB1909836@coredump.intra.peff.net>
Date: Sun, 06 Jul 2025 22:31:57 -0700
Message-ID: <xmqq7c0ka7n6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Argh, I forgot to add Johannes to the cc. Fortunately since then I had a
> moment to look at this, and the solution is pretty simple. So here it is
> as a patch with a test.
>
> -- >8 --
> Subject: setup_revisions(): turn on diffs for all-negative diff filter
>
> When the user gives us a diff filter like --diff-filter=D, we need to do
> a tree diff even if we're not planning to show the diff result itself,
> in order to decide whether to show the commit at all. So there's an
> explicit check of revs->diffopt.filter in setup_revisions(), and we set
> revs->diff if any bits are set.
>
> Originally that "filter" field covered both positive capital-letter
> filters (like "D") and also negative lowercase filters (like "d"), so it
> was sufficient for both cases. But later, 75408ca949 (diff-filter: be
> more careful when looking for negative bits, 2022-01-28) split the
> negative bits out into a "filter_not" field.

Ah, ouch, so the patch somehow ended up to be less careful about
negative bits after all ;-)

Thanks for noticing the breakage and fixing it.
