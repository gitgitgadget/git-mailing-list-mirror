Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400E1DC99A
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390971; cv=none; b=YzEUd01YlxIRR89zUQurba4aXTo3WKpPCdga95KPKwTQPmgAwQFBYO3Z7iyuWLhqYWaOOBy1eJTWMHqA7As9MD3oqrPdzMlKkn0J0hEgf5wlPfC7IIMjE4qyBPtHiqHwArkQW2xUlYiEcyqDj7Uq6usfz+0aPBdflSTIIt81USk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390971; c=relaxed/simple;
	bh=QimdTBrg1RRq0gfadcMtwkUh7NUr0vIPEnEyOoiYRMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHOjoSoLcXbVUtvfAj8cuWsHEDkOHzWtkg0/+LBEVilqvR2nfhPKTC17+BqhUNDSaC4ahPw0YdoNANHA0HMfq0QQKdcWIrwS+V23lmAjPyUn7qfI/PiEE4x98CIl19rj6Azh08gvZfxh2kOkf54tXyvnUrZYDhHDXJdFa16QKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=W20exdzk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="W20exdzk"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53c9035003so2333954276.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741390969; x=1741995769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BoO8SCMUHAC7sRQLQ3gwv8K1AC2ae9uVK27ExQ2daDE=;
        b=W20exdzkulDtt2udZ7Q1OpQILVEffiwXVfYfqHaV/eH27W8ieWqs0J+p4CALfANrD8
         JB740RylqB8WnN2PZeU7ukOQat5MoHw8/qWfyhQ7ASOnRis7kgA2Dec5dkXZQNjFa6Rp
         xmXrDtxIiJI+uu4cPV9Lgn9n4Rl6v2UTamWp+FGG3S8XvOgM/6alZT+c3YnI95oM0O8q
         cb4iLanrAGt5RpUzsxxLiZH76RUV5I6iehFy/0JFDL6B5gR7IxlxIB8cBpxnGTf5J3c0
         oEMGKDGIBjKqz5UF8xi2lTWZrKSAmSGAyuG2DNzu0AOnMhp0HduODqyPUB/mVRHrHxav
         HukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390969; x=1741995769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoO8SCMUHAC7sRQLQ3gwv8K1AC2ae9uVK27ExQ2daDE=;
        b=wMhUN4RmvQ5CzOzuOTorRKxrn/gmRXvyRTjN0CmLjizdlBbUPQDy3jiQsPYB6N9AF+
         wSACZPhMKF6997+cHxdBLhT+7qUv27B7kMi7SqWIJ/KEJn5ROHvuStmMxQe9rSCDzylz
         Cg8OJkMYXjA3yEbZrEfhxNTGMQq6dNx8LhchL/iYaV71be+Zms2WSvpg9x1H1h2d+CRo
         vhAp6tXEVjMHbwjRE6PDSDLCBqaRqWvKNPrWgWMQ/J6DuPq7s9JFv6pVrOuoFtfTDoC6
         EYkJHq2VF+J8kw/CkXY/A1HWsNmhDwxGgj5ivfIeuMRPn3kDSdqyGj+GOAD/BUNCgpYZ
         RB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFUKm0WWTeQ9TBfjx5KbV0sbDyfuEySgxsMn6RkI7hr2+eUS0x+Jv2KO9KrnuwavpvvmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRwfPuUIZz4SSUy4nZHgJfL4BxwsvmSusXlod6dsu6Nb5q41Z
	M8Tgc9HGfdRWb7P/A9jtSjff5tGl7rXGPcfdwZdjtqIMtD8X9YNKCwd2jWPS3OiBX+mZv46E08h
	8
X-Gm-Gg: ASbGncv9BxmJiErXhY3ZKTpmWajmRSKSZuaiDF83H1W43NxDOdvIl6mDsSNXGcUsh1Z
	QWXx5MrTEd0Lsygn77nntkL5vB3ktJhPTRd9kQEtcN9c9ul1qtXZurIV9FDpZnpQyuBlAd+CWlN
	hloFXfusGfnxtV4xbWWJGHDK4uTRNQc8h2VJwD9WM4HBnKxvkvPinjRdYEa9g2bha9nOw4PXL15
	ws5nk/4wf0u2GcmtyGKfP7lsiPBYjC5Y24l4HRNYrnGqFTALPgWWAcnupDQpiu6y2Y0gTqxW6fm
	8W9NtX7TfGb6+hEra/F4gRdzruj6jOitwhSvBfXpsp9M8RWMhXaia+sXBrbkUWgLJxOs98p1dSE
	/2nF79is1LajtJhm1
X-Google-Smtp-Source: AGHT+IHHNCArsQD0B2nD+lTl9yo40aYhwbHK7KlzhIiVwR4R9CJR3YPl5ChDJrP1COY1q47j/P8PfA==
X-Received: by 2002:a05:690c:c96:b0:6fd:a226:fb24 with SMTP id 00721157ae682-6febf2d5d54mr78163927b3.10.1741390968873;
        Fri, 07 Mar 2025 15:42:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c43dcdsm9616347b3.94.2025.03.07.15.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:42:48 -0800 (PST)
Date: Fri, 7 Mar 2025 18:42:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	SURA <surak8806@gmail.com>
Subject: Re: [PATCH v2 2/2] refs.c: stop matching non-directory prefixes in
 exclude patterns
Message-ID: <Z8uEd926AFgA7HlC@nand.local>
References: <cover.1741223981.git.me@ttaylorr.com>
 <cover.1741275245.git.me@ttaylorr.com>
 <67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
 <xmqqjz92hxxi.fsf@gitster.g>
 <Z8q99U9u6HQvHXFT@pks.im>
 <xmqq7c50g32y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c50g32y.fsf@gitster.g>

On Fri, Mar 07, 2025 at 09:31:17AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I think you've swapped things around a bit by accident. The problem is
> > that the patterns were being matched too loosely by the underlying
> > backends, which had the consequence that the backends marked too many
> > refs as excluded.
>
> OK, I agree it is confusing.  As a selection mechanism for refs to
> be shown or processed, exclusion should be "we omit it because we
> clearly know this one should not be in the final result, but we may
> pass questionable ones, relying on our caller to have the final
> say".  As a selection mechanism for refs to be excluded, the logic
> should be the other way around, so false positive and false negative
> are going to be swapped.  We want the exclusion at the lower layer
> to only say "this ref clearly matches with given exclusion pattern",
> but we used to claim matches for refs that shouldn't match.
>
> OK.  Thanks for straightening me out.

Yes, Patrick is exactly right here. Thanks, Patrick, for beating me to
the punch ;-).

> > What makes me feel a bit uneasy is that for the "files" backend the
> > optimization depends on the packed state, which is quite awkward overall
> > as our tests may not uncover issues only because we didn't pack refs. I
> > don't really see a way to address this potential test gap generically
> > though.
>
> True.  An obvious optimization for "files" _might_ be to lazily walk
> the directory hierarchy and skip recursive readdir when a directory
> clearly matches the given exclusion pattern, but the result of such
> an optimization (in other words, what would seep through the sieve)
> to be filtered out at the upper layer would be different from what
> the "packed-refs" backend does for its optimization, and they would
> be different for reftable or any other future backends.

I had considered doing this back when I wrote 59c35fac54
(refs/packed-backend.c: implement jump lists to avoid excluded
pattern(s), 2023-07-10).

But I decided against it for a couple of reasons. First, it's a little
more complicated than the packed backend's implementation, since we have
to consider the additional context of what layer of the $GIT_DIR/refs
directory we're in to construct the full prefix in order to even perform
the match.

But the second reason was that we should never have so many loose
references sitting around for this optimization to even matter. If we're
in a case where it does, then the repository in question should "git
pack-refs --all" to take advantage of the optimization.

> But I think that is the nature of lower-level optimization---each
> backend takes advantage of intimately knowing how it organizes the
> underlying data, and how they can omit without looking into a bulk
> of the section of data deeply would be different.

Yep.

Thanks,
Taylor
