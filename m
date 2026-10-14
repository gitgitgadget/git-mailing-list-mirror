Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86C4A261B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015959; cv=none; b=fqHHOexcrleU8XffRjxxh0p6JFD/RS+a8Ei5D8TMF0S3HtDfgPcOEFs0GPmOJwrd4+JdVUtRitFhp5N/VRFqlpVxJOgZeiSgL2VedooBT2UXK+U7YyFZuPwsqSrxQH3ckW8troeu0OOZ3RVg+YOcO6bSL0TZ+Fy7864fR0SG5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015959; c=relaxed/simple;
	bh=oAuid3bxPS3pdndnqmqVRIoVyNUNSnlyH5H23kgojUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjuvJ0PFisvjXCdMzkNkGTLbaqYIHgC7LomCcYgjrmvIVlCcGNU7pDnRR0/DvRQ0FYuDHn4cLQpExn49+yAoMNl5GIxT7sNaL8YQRty0nZ9R0TObCCFqHlNbsu9e49VCRomCo5nTfDXG/Vai16Uqzaap7cQ4DNHOnn1icz84+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC6uSTY1; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC6uSTY1"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59524so139489c88.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792015957; x=1792620757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bHA+wVsSwys7EOEMGREkKyKTY9jGnAfdGLJArrmqkFQ=;
        b=TC6uSTY1smt3hWtKqPvNF7yMRMfxqalXfNto/ktb51ZHUJz6hVfwsoF3WZ3Xigof5D
         5qTGMMlFIs3RbGZ5WmH5p/ig9McUZkZ6FO8TxGhZ3/N7mcjK/ExrYE/bmwPlHYQHUQPZ
         9JWbm8QlHWKmwLg+uL7IAYttLUsYqsjMg4tLWflSCk+IOPhpWFZaiKasyn10nv4gesWa
         wJED11P1K3bdJdUradN+4LzkpFU754/XuZC803AUolpzzCVl0mZMYnoazbbzoP+aTYkY
         4BMslyselrvufykngmgCR/K0vyzYUrgzeezE4bmOa1Cm7fGQeys+BvdcaxT2R4DKCZPd
         ieWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015957; x=1792620757;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHA+wVsSwys7EOEMGREkKyKTY9jGnAfdGLJArrmqkFQ=;
        b=t4JVYhzFiYqWsDHh4AAqj6ZaQwCPI7UrYVtEzHo5/2GEOZRNHBrsb5fgSBNabadm4C
         9va7JAh+tkdhFe/4HSxHJPt9J66e/ptEqa0eAy1B1vN1FtY/uKlIzPLJoQKABitgMTDx
         66VumC9P76rPNlvezUTlPpqszoMj9snDcpEDw/WnRx+WZnD3/5cg7cbW/2DB77O+wiyq
         oN4jkmK5cO9pPVplO0nCHdDd958+OKj3jXGwb9hXOpKNSHiMw16dG49amstDgkd9QCYX
         iTpBIEguQlU/ILDShyAMCQNgv60Qy+9FOxPTr0WscaSlle/L/SJeT0zxoAY8jX76CQzN
         xd9w==
X-Gm-Message-State: AFq9FYKd0Q9sx7xYWzzYITiN5F4852EAcY55it26svL6CvSwgEIQ8ajE
	1LXk1rwHIDa9QCCBAOoEo6KDLYpz6XKzsZDfKybpSsd2WFNyU9y+XGG783PRzg==
X-Gm-Gg: AYBFou3GNn3VLaQ13zpsKpw8rgp3e2Ea/twrOpz5ZM9m0TPq9CrD1VdAv7SFM+IIhOM
	Pxua5hcNSc8ehgPJxNwums/z+qtE4RuKx+0rIqgq7i+QmJzfeMa0rjLnokNETVRFG/Im1CKA/Zg
	HMslXKH+502UB3fOA1D6SvL6gLCdJQwFaC8gt+EKBHSD1r4RkcIOmbBG/TuLmDsItV/Xj8p1CaU
	b4QNeB05H1zujPdU0ycOTA4cNXTMbgA8xLr3wcs65ru53B86r5zWY3Dxv85oJfQjnZU1TOA/5Gk
	QVZv56syhQGMpmetpWJC2k3g0IVlj+3GvnGOrwDtflP2J5/yMVXjnNBfEQIlvRMFl2rHA9Dkh8U
	EmP6xffZZa9WVFp/sdTk03Bd+cxM2QL4vBvdwdEpiR889Aa6swGDUQEpvfzWFIOHgvxtHphJ7+k
	GRnBMGM5qK0kD/61QKYwsXSJg6FwPn6Q1KamK+4DYZ5Qc9kSzvEyY1Fe8ZB4JikOcFX1gnuIDpM
	YhbtT7koifPL3jayqMqVs0VxXZvi1GttUe2sYWQY6wqiXY0T3EWtNlAiTt8qiPDDA==
X-Received: by 2002:a05:7022:1608:b0:143:3da5:cada with SMTP id a92af1059eb24-16a610ca97amr19152820c88.37.1792015957026;
        Wed, 14 Oct 2026 15:12:37 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567aef5sm48993734c88.19.2026.10.14.15.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:12:36 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: Re: [PATCH 1/2] repository: add core.indexLockTimeout
Date: Wed, 14 Oct 2026 15:12:32 -0700
Message-ID: <20261014221233.1694344-1-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqbj8xuugv.fsf@gitster.g>
References: <20261013172315.2997446-1-quark.zju@gmail.com> <20261013172315.2997446-2-quark.zju@gmail.com> <xmqqbj8xuugv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 15:05:52 -0700, Junio C Hamano wrote:
> > Default timeout is 1s, effective but not too long to avoid breaking potential
> > user expectation (e.g. "an index.lock error means I should check whether a
> > commit message editor is open somewhere"). Tests that are slowed down by the
> > default timeout now set the timeout to 0.
>
> Need to change the existing tests is a sign that end-user workflows
> that are emulated by them will be impacted, and we'd need to be
> careful.

Yes. I'm aware of end-user behavior change. The test changes aren't strictly
necessary - without the changes tests still pass, although run a bit slower.

> I am not sure if the change is making the right trade-off between
> background tasks and end-user action that expects immediate
> response.

It seems the trade-off is between command success rate and command duration.

I suspect that end-users want commands to work (not fail) first, performance
comes next. In my experience, high command failure rate escalates to oncall
incidents, occasional slightly slower commands often get unnoticed unless we
look at the metrics explicitly.

Mercurial has been using 10-minute timeout by default. I picked 1 second as a
middle ground, limit the "slowness". I'm open to setting it to 10 minutes
(matches hg), or 0 (preserves the old behavior), or another value.

> A few comments and/or questions..
>
>  (1) In the unhappy case where the index was read already and then
>      we try to take the lock, what should happen when we notice that
>      the index is locked and better yet if we notice that the index
>      has been updated before we write the in-core index we wanted to
>      write out?  The question is what "should" happen, not "what
>      happens with the current code".

I think the lock infrastructure might want to force dropping outdated in-memory
index once lock gets acquired. The users of the lock APIs need to handle this
new cache invalidation situation. Locks in hg work this way.

How each command treats the "cache gets dropped by locking" can vary by case.
For example,
- status: read -> refresh -> lock(timeout=0) -> invalidated ? skip : write
- add -i: read -> lock(timeout>0) -> invalidated ? re-apply "add" : write

>  (2) Are there cases where we take lock only to make sure nobody
>      will update the index without any intention to write out the
>      contents of our in-core index?  IOW, we are holding the lock
>      only to have a consistent world view while performing a
>      read-only operation?  How would this change affect it?

There are commands (e.g. rm --dry-run) that lock without writing, but these
might be for convenience, not consistency. This change will make them wait.

Since a single read of the index is already consistent (it is replaced
atomically), I assume by "view" you also mean the working tree files.
Then, there is a question about the intended scope of the index lock:
  a. only covers the index
  b. covers both the index and working copy files

The answer probably does not matter that much, since commands that write
working copy files likely also want to update stat, therefore take the index
lock. The only exception seems to be "clean", since index has no stat for
untracked files. Today, "clean" does not lock. So this change doesn't affect
it.

>  (3) When 'repo->index->initialized' is true, does it always mean we
>      have read the on-disk index already, or are there cases where
>      we created the in-core index from scratch and called this
>      function with the intention to write over it?  For such a use
>      case, what, if any, are the implications of this change?

## Does initialized=1 mean reading from disk already?

Not always.

initialized=1 is set by either 'do_read_index' or 'unpack_trees'.
'do_read_index' is the regular path. 'unpack_trees' sets result->initialized=1
so it depends on the input of 'unpack_trees'.  Some callers (e.g. read-tree)
call unpack_trees when repo->index is empty, not initialized. So in this case,
initialized=1 does not mean "read from disk".

## Cases we created index from scratch, then call repo_hold_locked_index

I didn't find any.

There are commands that create index from scratch, intend to write: clone and
read-tree. But they all take the index lock (when initialized=0) before calling
'unpack_trees' (sets initialized=1).
