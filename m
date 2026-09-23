Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A55424D41
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186394; cv=none; b=q5Y4QyIFKSfrSnyXJJj88Nx8sueePdWqhDsKKuedM3gLCIpr0PKElgqLw8h4RubxiFhAQ1QV8BKD8nQoujwe2SvjdxIlN//iA3IlOVdthtLLPtbYqkKqk92NYdIVWlqI9voCosalPaKjrGrcLQzHZqWKkXJk8GCgi120X7FtZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186394; c=relaxed/simple;
	bh=zr0X5TMub+KiLtJ7uexXiI1xfULh8435accrESYYHxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kt+AzuwmVWwWQZWcDZ1dXTFLciknAuquXZkeWqOYTs90pxR8GzeATzuz5k/HKQD3GK/cLH802vK8P68hVyE+nWylkByyuYRMuMgnYs3MJP7l3lYHKLFDGrli9aSlvMqkGiYJB38BHPnZdnvcWrYDPksfF+GeNDQOhj0b34R3/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=klSA2Te5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9gSzUWE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="klSA2Te5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9gSzUWE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id ED4FF1D0008A;
	Wed, 23 Sep 2026 13:59:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 23 Sep 2026 13:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790186391; x=1790272791; bh=xHf01C9oHF
	Ot32ZOCkdmi1SxzcvpUhTR6guuXsBwP/I=; b=klSA2Te5jo6yY8PGfgXwsv1rAV
	CtD9zPSKPWk4E5QKtCABMk7PGpP8TYvK+6V9Jyn0+vYu4hPC+YKvlm+Oootzeg7R
	isYmVQNQSN3dCGOOmybFebXwjimy0HE2+H4o357/yfZXP230JIy+Zqq0yQGCZsd4
	KA55rhxsW4H01m2TvqRxE1XFq57U0mBgjlQ4lFNew/DBCzU7FfphnzHRuMgS88iA
	gNIfiEDmOZmvSknl5mf8Hb831NiQdG4STbs9eN0Py2qfvhC4go5jA7lvQWuou18e
	xQvzCp20eCkYgdjYpjD1OcbiEHHh9wfS0OjjlN8xndpCEndoFrvNZwQvnUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790186391; x=1790272791; bh=xHf01C9oHFOt32ZOCkdmi1SxzcvpUhTR6gu
	uXsBwP/I=; b=e9gSzUWE35jO8WA4gRpfP9wQ6o2kiTBVwQ7Snv30M/zVc/tYOiE
	t9/tVOwhG7h71xAuG/1SbOA0bzhzEm7a1P8OuSTL0x7WASfnPnETB3sJzpoHZYwK
	ZxX+LfZH7ZcnQgslQrdSbiCDauykbfLjos92pffpQRZL9rd77NwcPpuTFetyT8wl
	t1I+HE4SfDZEiHNjcP2zaqcCTKx0Wvw/cBgvuLjlkmxXqIjtRHjiE0uM9s76RdKb
	750enK3nVrJXUyITJwCVWOwJ7QbkcnbGaV9ECVRZrSKCvScutaKzaC3WSvt/75pP
	sA24iIpUk8AaFcKSGCf5KLkFPOkpk+jUpLQ==
X-ME-Sender: <xms:lxO0atPUat9j3PpAwWuh1FXVicMbnqlJ5112QNUyV-ZTJ-_jvLdoqg>
    <xme:lxO0am_wZKucK3NYoBamknaTzeRKAugGfvDncyMrLNUaueDgsrqLXkWr2yYoNMtAG
    3j8lg6JB7FI64yQgJPLo7SSugmOIKWlWf4LrXhhZ-_KzJILzcaZfPA>
X-ME-Received: <xmr:lxO0ahQnPADdjJsqAqlej4TjCLr-29FV2JjSQr-tDMxZHZmoGub2neTtGrSqoaUjAlGUAXa7qn9N9J_8gwjaeQLCNJoN7XDeismO>
X-ME-Proxy-Cause: dmFkZTGzolLgfOmpR8/5C6ki9osmt0ib52PZW6YNyWQ564SzcxIRebmUzVD1FEPRLZcZ4Y
    DBeLvvGsZFcJ93m4mAYxbGrPc1X9IWOOJb3f63jAf7lr+VC4tLcm9e57JjXUOUG6gnIYNM
    QatlTZoapx8R6JJZPGCcYvrKou+PyrdP8oC8kh/ZxvWBIAN6o00REkLL+KMLNoBLiPXSZ0
    rYYm8Xi4gk6rDnOs2TkriiETp6EgaOrznusGpZvNZRGc+xy8u16dmXvvItFbkbhAkUtdyF
    0W5L7qSdl3t4c8DMvJNyIT0HlsVSsOhStmuj10N2AjJIYbqFtTSDrsfkDETOyj2TyTketb
    zyVYnRwFzbZrOt+Wwqpc6XwVF2tEbwtTbYBBaKIVJJlSe4CyYYxEwTnwM9v1w41YxCMFXZ
    RT3vFPCW+Wf/htGUrJ6bySmQhZpVdSyjEQ4olhXtEjBXhkXwWtpozZtB9ycllyKaECT0Pb
    iA5AhsNp8s7Ap+pn93WkaIJ/pqTXT4I3m4kzzdCh2rDTmSc/bIOUCHXUYjy9jKUOtzqUPe
    lbX1cYPZVEmfu0HlRHzI5KwIW9m2hwNpac91O/0mqJjc1S8frIpZ9fnsef0KOOcS884GUw
    km8AkZY1xtbE9aGnbqW38v95luP/kiUwZEBaOrWk16+2jcwZhKDhDagkFcgw
X-ME-Proxy: <xmx:lxO0aompSFw7J18bPfTQNOfp3BV9UDQvaXshnuf-pyBFWHHBV0TWpg>
    <xmx:lxO0ahR7zliPWQqWAG1zRgVAqk4jiBPXxY9HSw7yWk9BfW65zHStMw>
    <xmx:lxO0amOthG-sDiskz-_pTCPHbUJv17ncNEokbrFEPyjqMUwteEnhCw>
    <xmx:lxO0aqXYc-iN1HSrfmnhF2-0rOxonRPOG4PpFs99hme2Q7O6H4Ebaw>
    <xmx:lxO0akxuWzVKMkXrEEoZTa0tz_j_h-Qz28TGQMHa96ZqP_2NTHRzq4Mm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 13:59:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend
 committed conflicts again
In-Reply-To: <CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>
	(Elijah Newren's message of "Wed, 23 Sep 2026 10:48:14 -0700")
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
	<CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>
Date: Wed, 23 Sep 2026 10:59:50 -0700
Message-ID: <xmqq7bkbc0h5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Longer term, I wonder whether plain "git commit" should be rejected
> while resolving conflicts for rebase, am, cherry-pick, and revert,
> with users directed to the corresponding "--continue" command.  Plain
> commit has a surprising collection of behaviors:
> ...
> workflow, but I think plain "git commit" should eventually be
> disallowed as a way to resolve conflicts for other commands.
>
> That's post-2.56 work.

I would say castrating "git commit" so that it can only do a plain
vanilla committing, while it may be a very good move from everything
you said above, is post-3.0, not post-2.56, work ;-).

> For now I think either reverting (and trying
> again after the release), or recording HEAD in stopped-head seems
> preferable to relying on MERGE_MSG.

Between the two I'd say giving us a chance for a clean start is far
more preferrable than repeating "Patrick thought of MERGE_MSG and
after a few hours Phillip and Elijah thought of a more robust new
mechanism.  Let's hope there is no more holes found in the newly
proposed mechanism in another few hours" after -rc2 got tagged.

