Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0E3C7DE1
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752816; cv=none; b=KZZG6OmTs+ORDaHAeyLfvZ02Awe8DdvDUycrrr+1B0zLrGRSS5Esu/Sd1DFpty/R79GYNjeQqVrwO6lYzaJus2jfobrt4LxbL3+SSDdwpXwlSiskrMMOY2T0FI+MLp8cc4ZNgr8Y+8gLzdf9AUQBVgj6SOYMxJcfxMXEsSQa9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752816; c=relaxed/simple;
	bh=AyHTUEFPYMUxRqY7+rXHjlBHL8cHIoboKzA4Yk1ldbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtTDw92fLuT/zwD8ePD1T8Sbn+wN7PNAOSKO4PM/Elzs4KbQSETNtDZfMJuwZPsRCQfIiGVt0GhEPAwPypE9U0rbgW7+kPnvYeiYlyawrDl5Y1FFZfJHq7bwKyb3/7ykJyn4aqRVr6DUYT6UOmWq1S5GCBH91hM8LMXnDG99HMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwnIywmF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwnIywmF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so4572795b3a.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752814; x=1774357614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq0EamnLCSAPd6hPYc7H63DEtt142ASeeUnh2gvcLN0=;
        b=GwnIywmFC4cY8xZ0G6cVOm+yseY8Vq27jeL6wplxfuK5NeFgbTSykvH5ISjUmxWTE8
         MP46WFcV9pWNTKJsIXMqv6md2/8GbJWyjrIMUptsy2PFbA4TdEakgxoaHNHk1r9Pi+dF
         IGCfG3MEi5QBy+JoihJr/mXvKODE+a9Vl8Bmns/9dREgCW0rD86nHGiCP2bBAFFsKORQ
         DkXjcMcqpyMl1J66AKFURCnC4IM4Kw1P2vYSW5FlUY8bbXwsBIrpF24/6ohE/xFr+FxJ
         ygkWn90afTKK8QAIneAsTn5cMeazuloTsjPCAg2zb0vN3oHGQ0KuD5n4aIR7rjaEli31
         kYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752814; x=1774357614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yq0EamnLCSAPd6hPYc7H63DEtt142ASeeUnh2gvcLN0=;
        b=PZMBEndg1r/zwnvz1aFKiRu/1QdFRMm4uy9sshhKfvnw2F0ZOuzOl40SKL+haB5f0u
         cov80+6Fy9U974G2F6az6j2k8X7EPlRsDcNkJW5jrW0Ga3jQvja5S+90VcANZ5nQotFb
         NelER4sEqPxzXTVW8fxOyGlD0WMNMclnp0n+ftvvWVgxUoErfdAtEGrwo7yQhN6cOWtj
         NZVLXm1HQ/07UsluIOgUUZUrYnBgJj88TzD7TlgVCOTE8lY4bGtAVUqx+f5Sfpavmtom
         LQUB21vUazEQfGh1F3UDpv8EFCz6DEjc8vKbf/orStcW/PIFzP0Gya5D3C4JpFHMscXa
         qrog==
X-Forwarded-Encrypted: i=1; AJvYcCXPzi08TcJaWjClGTJh+YnPdZ7JjiTLeVG2vTpQSzqgJffXPjM8N5QOUh+bMct6OwY6fbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRFcdLXNAHZHuSt4gTs5tJF0BNUTroBDUEmAfkdATD6wx1nST
	nB7ItynjfJR2Ckij46pMIzBNKF8e84FX6c5nbm+3+vYLubrSUKPjdT6e
X-Gm-Gg: ATEYQzxGS5sbw5vQQv2xZiATAx9Yxbncl1qNupqSPrn8Fd2XCmDxsiEBViUbaZkX4QB
	fbC3LnP3iUAB2gfdKxq6uXtHUkExDWYmYjuUaxTwYQvuVFqFg7BQjC4/vUBj4KaUvjZFtKpeBTZ
	ZTilbTYgLN5TJqAsrz2TXiQiZfTM7FW937Z1uNee8kUd4WFrZ8g5tVITjwjeLr/MN3qiRTyxmfQ
	1ZQQ6IQhcjmuq55cUL+ZFYGAMYRPCVg6/zD/8wuS4XcDwu7ETnyQm1kEq7SZIwi1Um2sQtf9fbl
	GtSxs+l9vSli5NF8M724vlGAWhjWSBXypWdCt9KRb7l7Dhs65kyLkqdixjNewMHYrEg1UZhDc36
	cYoMGZC2VniUdzNbMbj9AmXit21IPR/jRN0kFTe8QadYNGNg2XAHK4tMAXBZYkG+s9gO1YTWQmb
	bYcpC5OnTYv6OMnKhB0+RV/+xNQhoPWkwwXJ007ZMWgaizwaoMKiL6rLFLvLgMCQ6tfmkjlHfZq
	NfrKbRuAzXMF2a0oPbBkWngxND0peCcg27gOXxkDIWBkFibqR06HQn+8Aa4b4L8WxNGL90Za4Uq
	XHcjrDI=
X-Received: by 2002:a05:6a21:6186:b0:398:6645:6ee7 with SMTP id adf61e73a8af0-398ecd5f1c2mr15562999637.52.1773752814041;
        Tue, 17 Mar 2026 06:06:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e2:2a:942a:7c1d:65f1:ed49:7b1f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c740e14dfbesm2871131a12.5.2026.03.17.06.06.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 06:06:53 -0700 (PDT)
From: SoutrikDas <valusoutrik@gmail.com>
To: christian.couder@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [GSOC Proposal] Complete and extend the remote-object-info command for git cat-file
Date: Tue, 17 Mar 2026 18:36:03 +0530
Message-ID: <20260317130603.84482-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAP8UFD3LJEU1YNBOi5VtpZANTY9PA3_v=eU9JF163F2efp-hGg@mail.gmail.com>
References: <CAP8UFD3LJEU1YNBOi5VtpZANTY9PA3_v=eU9JF163F2efp-hGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi there,

> s/has/have/
> s/its/it's/
> s/sreies/series/
> s/type/types/

I will correct all the spelling mistakes.

> > multiple network trips to get a single object's data.
> 
> The `git cat-file` command has a `--batch-command[=<format>]` option
> to enter a command mode. In this command mode some special commands
> and arguments can be passed via stdin to `git cat-file` to request
> information.

Will correct that.

> But anyway I think "information type" is not a good wording for these
> things, because we already talk about "type" for Git object types.
> Please try to find a better wording.

How about object property or object attribute or object field?
I feel like object fields may be a bit more technically correct.

> You can try a rebase to see which issues would need to be resolved to
> complete a rebase, and talk a bit about these issues in your proposal,
> but otherwise applicants shouldn't start working on a project before
> they have been accepted.

I tried a rebase on the current master , and there were indeed conflicts
I will include this part in my v2.


> Would you implement both the client and the server side in the same
> patch series or do it separately?

I am not sure actually... since Eric Ju did everything in one patch series.
But personally I feel like doing one series for server side first and another
for client side would be a bit more focused. But I am not sure if it would
cost more time for everyone involved, like giving feedback and all that?

> > My current semester is ending in the first week of April, so I will be
> > able to contribute 7-8 hours per day, totalling around 35-40 hrs a week
> > on the project.
> 
> Do you have another semester starting after the current one?

Actually I made a mistake, its ending in the first week of May. But no, 
after this semester we have a summer break so ... I will update this part.

> Not sure if that would be very useful first. Also that might be better
> in a different command than `cat-file`.

Alright. I will ask that as a question before my final gsoc proposal
submission so that if its approved, I will add it to my tasks in gsoc.

> There are other ways to do this, like using:
> 
> git rev-list --objects --all --missing=print

Did not know that ... but thats great! I will remove this from the proposal.

Thanks for the feedback.
