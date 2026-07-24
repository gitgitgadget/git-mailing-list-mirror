Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7812D23A6
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784868199; cv=none; b=ih0AfZTvQtkQXQLxL7j7f0dPSfyNeqTxazzckwdYKW3eucUDSmAFUu8+lhFXtJrS1mv3IbRsCi5wypdGDDyWzJkQDXemF5DYA8zruV+vTbfzPlNqTOBtABHrsK+tkcDmbtpXGEXwUK56zvGSHOKk4F0hMOl8CPooJxbbdSRRCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784868199; c=relaxed/simple;
	bh=j/alzO6yLfGVWvvuq8H/ImuPOoA2jZ7SiGxiqwZU3iQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCR9yEsirJC590XUDMQVTM4JUy7XEmdrZ1y4Mekn4EWPiUxSp2Ju+stGgEcNgv+4MqmPdaXWh7SgPgz9rVrJ9apKfALvCf1FarOtAS26v7RshFnhIBmbuUqerUDAX+rk/5jzRD4f9+RL4OqJPwD9X+VNbxpojX0otZVgdXeHaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mL/1oUkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z/IPcN+1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mL/1oUkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/IPcN+1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA0DD7A0349;
	Fri, 24 Jul 2026 00:43:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 24 Jul 2026 00:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784868196; x=1784954596; bh=Ju7VAYedQ6
	JbcjkzctkRoocw3N+ktDrggDzPsPAzLPA=; b=mL/1oUkfT+6CgZFFju8RnoU8a4
	g5B6SLA2YeT3Eo+9mY6pGUyGgyQzLihcAGI75sPSi7fhfbfbNzeHzx6uWz42p1Tq
	VTKpbBFj+gzKk2u1zxtME/AvQFKUp8OhQF9cVRA981pyFK2zj899H5xroKFSi+FL
	QvTeN5DbDQNjB8xJy6Bf3kmFFnW+XVIOtxsNz0ePzxwlWtFvO5KjxtAlJlt5hZrr
	3O5gaprt5BFGolJlo5udCimfkwHGQA3PtpFyxCnBgTqn71q6LxN9JlrtuEEMQMV5
	Tgdi5rvBmSfSTyxMPmPk9v/TjfNvBptCEHkK9BbYBxm3umNHksEFZyVy0MWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784868196; x=1784954596; bh=Ju7VAYedQ6JbcjkzctkRoocw3N+ktDrggDz
	PsPAzLPA=; b=Z/IPcN+1/SsjH+caD2GNVPJtjMUM4zTXv79M2cHKYlR7LTr8WC1
	X3HYiEKdgRflvo9zWLCSoxDRJpZCOPJriLxGlLZQxmmQYJYg5vJKorA9kxTkcQWZ
	TKERlcRiK8d8LrwF0t81uJxCOG/JwA0cAPQhU4aG0P7cF88kZEXpPzNvVRYiyxed
	yPopZ6Uqzg35I7PuFfGmbFtNwgpoIy22I0XXQeVvKOdML1Ymoz2Jngjd1lCHqb/h
	LIOtHoVnJ03JCTdclchJSzmzFC29YobOrM/DlaJZxK0oLX0INFbwMqLnTCVQcFwy
	ot0hk+E94GbGYa10+JDt8O69RxUKDVJ1T6w==
X-ME-Sender: <xms:ZO1iatcBWVjUgUpbwugZNypAM7o_zk1J0wW_WlUv27o_oh7-tmuczA>
    <xme:ZO1iatzSdOzZCHWyj2oZpaHSklZKWF2Fv9pdlJIhalZp8CCIK92-YAOwmhsO3L5PD
    P79jP7teFaySQ5YOKda8-zk2aF6z-BYfmQA6iyTMr0rQQ1en7ht>
X-ME-Received: <xmr:ZO1iaqJEHVWCo5QMtT-2v-hWZhi4WHU9iJVp-KAx63igRzT9gonZuMoIgorfBXR29rx8T1KYhufHHXUGm3HDZ7orQI_gswS_Iw>
X-ME-Proxy-Cause: dmFkZTGWjFQywaqokuZIvOq93bxmj4MYuAa0cPUtgPBoEXxxqxq+7tYefymcqt/xlFO5Nn
    umNdvIxvNK2b8r7Kct3njWrH6KCeHp1wSdJNIkmhADW4O9PSuQMBQnw/lneqP9LfG7HQnD
    jc7S5KvpGEzzt6TnO1YsZkFE/U9M+xbxm453rcLouHw0QsU3LoSJwwWqSIfQG6C3eoNMer
    6XvNlODBBcjAJzvnAivQlQpFZnvB7BCOxK6bTuSatYer/rQedRCaead4Y7tOQkn37Ren6z
    eCQ8brWNifZaDMxgPQEkjWOyUXNIk/IBuosv5bVeBdN4gvU175otZaakefDYUxd/w+RgXB
    w/SRnmu5KUPkppz+yW6wexmp0fWFFCL1CwnymWLyNXdmk04z6xUZpqhGgUDnX+VadZLLxi
    8iyI+yTuEhihHY3IM6TnkAE8hOwES+IcdwjhZ4MCbWqfxMg8tfngbz89IDOgFPfYuhyIUl
    EEv8JHGkfYZERGwj6Xb9kNgXKhoVYpl2I/CUiJUD8bIqpv/SO7yZc7JkGXOMSAHhU5Bbdn
    Z7bFe4BqCxGnpWZ7Yci/EjXojdieVxF3guD7kebglPkQnXWpOsK4mPn1JMZEUwJmn18j9/
    7qmxZDnf03TuuwfBBIW9rjRZX60lZ8doq2+NJd9D8QlUGM00WUyuORzJMaQg
X-ME-Proxy: <xmx:ZO1ianF6BFifpUsyN7DMDVXiJD3MVkcSo0CQ5yk1-rTdxGsDKoyitQ>
    <xmx:ZO1iau_Xld-wR0FtHS0I3Jbr_wPCD4q-NYpzClPXZK5T1Cj7i30dKA>
    <xmx:ZO1iavJgwzYXIIMH5dSVfkcyy4kwdmRJTm1I7BXKajh87kUUZAp67w>
    <xmx:ZO1iakuvaN5OZ_NP7z26NK5Bd7Ed7SDee1euIGVisFeia5qHsLjqRQ>
    <xmx:ZO1iamRyp2dzDWLWnLUyHiS1HpJLfUUSTTpI5NxzDlouVKzo6dcVF3FL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 00:43:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net,  ps@pks.im,
  karthik.188@gmail.com,  sandals@crustytoothpaste.net,  avarab@gmail.com
Subject: Re: [PATCH v3 0/3] packfile URIs: support concurrent downloads
In-Reply-To: <cover.1784676106.git.tnyman@openai.com> (Ted Nyman's message of
	"Tue, 21 Jul 2026 16:29:39 -0700")
References: <cover.1783982021.git.tnyman@openai.com>
	<cover.1784676106.git.tnyman@openai.com>
Date: Thu, 23 Jul 2026 21:43:14 -0700
Message-ID: <xmqqldb19evx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ted Nyman <tnyman@openai.com> writes:

> Packfile URI and dumb HTTP downloads stage packs at
> objects/pack/pack-<hash>.pack.temp so an interrupted transfer can
> resume. Opening that file in append mode forces every write to its
> current end. Two Git processes fetching the same pack into one object
> database can therefore append duplicate data and corrupt the pack.
> ...
> The tests cover resumption, a completed partial returning 416,
> overlapping 200 and 206 responses, unlinking the staging path while
> index-pack holds its descriptor, and a pre-existing .keep file. The
> unlink test does not require FIFOs, so it can exercise MinGW's sharing
> behavior even though the concurrent-download tests are skipped there.
>
> Changes since v2:
>
>   * Split the --index-pack-arg documentation and error-message cleanup
>     into a preliminary patch, as requested by Junio.
>   * Clarify why per-descriptor offsets keep overlapping writes safe and
>     why MinGW permits the shared staging path to be unlinked.
>   * Add a non-FIFO unlink-while-indexing regression test that can run on
>     MinGW.
>   * Rebase onto the current master.

When merged into 'seen', this topic seems to cause t5550 to hang
fairly consistently.  It is not surprising, considering that the
topic adds roughly 240 lines to the test script in question.  It is
entirely possible that we are seeing an existing breakage from
another topic in 'seen' that is exposed by the additional tests.

The CI run

  https://github.com/git/git/actions/runs/30045343889

is today's seen (excluding this topic) at 728e180b7b; it has
breakages in leak checking jobs from other topics, but does not see
t5550 hanging.

The CI run

  https://github.com/git/git/actions/runs/30048327878

is seen at 05d0dd408c that merges this topic on top of 728e180b7b
above.  It breaks the same leak checks, but in addition makes t5550
hang.

Can you help figure out what is going on?

Thanks.


PS. Recent CI runs on 'seen' started to spend so much time on static
    analysis (aka coccinelle) jobs, even though I do not think we
    acquired any new rules recently.  We probably need to figure out
    what is going on there, too.  There is something wrong for these
    CI runs that usually take ~40 minutes to spin for more than 4
    hours.

