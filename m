Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9D37F32D
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402955; cv=none; b=tmxS6lKCdTWLXKgligwOHQw4HZ9uRl+AJygEKRA6HvxN5ZIqv1EK1nnMyKY9hdT3d7uciOD1h+7cu4Jj+6BOlSGw3s9pYEzUZPQ0pgaIoRLg1Oo1W5t9bymhlpP/f4u3gP0SnU08N7V3WuiI2nY0HFGtpasu8TC36iZfdFwjAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402955; c=relaxed/simple;
	bh=q5BHwPmMjiH+XAyX6xE3Iu/EFbjMYWyi9oCPiR7taJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iqMDiyM1xickfJ6UwhkJmLOvt54LZOEICGsj2WocXatNBXm6HoeA6Hil1mKtdeiepqXhIsql6x1lW1FmLoSUcT9gS3BTXC8k8IVQerSfNrdPVBKISVAKn7uh5qW6diAeRjjYYBMq8tp5wdaxFreUnQMXoL1pMv66hJefLU35lCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nj8dimLt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qalx/lHI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nj8dimLt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qalx/lHI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D81137A018E
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 15:55:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 07 Oct 2026 15:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791402952; x=1791489352; bh=Egbb8tq5f5
	wjVOXPRJdOPnbXr3xCbPsGzjUhKgsEsBo=; b=nj8dimLttcjG8QGDjtTqUcccrT
	EZzL76ORzCuYo78PVqwVSpizykJy58SnOrtBogQdUlSW3vwhennurW2FUrKdHAnW
	Wpm07b0ly1pPjBHrZ3ZJPnEXV4w1ucnXJUDal6MVyiWIQfg9cszb/m8W5zvVVNbt
	zSTM7ntBIyNfe7Irf43VFj2m++Ybw4TjHPegSKH/6RpeVINiXhk6xHo0fqtqKfwV
	/pguu38Pzgz2AqSq/KwxaSSCG0r21sVxXMaN7sW9ffbJka2+v1KMV1raCE5xljKS
	GxWgZJ0A/rghoRVQMrunN2zGrEYLXMImft4SGTI11oQ58BUxE1u9Czp70u9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791402952; x=1791489352; bh=Egbb8tq5f5wjVOXPRJdOPnbXr3xCbPsGzjU
	hKgsEsBo=; b=Qalx/lHIHW3/EqXk1s5SwNeK1Iofrcuh6OtVHuoly3odIPmYXT1
	At3dq2RpefjIi9s2FyZ+YJS5plPG/IhmymbwR8ebetDN55c5J3Pfz3CtITuJ+4kX
	5GdC8Y97szIjXK7MD48LeIJmarEse9c0mNx3XzOxOYOek9aoNXiwEwqTXK6Q3YKZ
	VCZtXV5W2iPWp/5rx01SAAHNXUV5wEhZZYIRFLt1Dk1FCT4qN4JI+MwuPT+eXJC1
	Xvad0n0Y00i7408N/RmkD56L1FUInRTE7HnPrshDGCA59Q5cCOMcXAlBzMQO1CiS
	0ezfrXU27kRD2mUxaM2iaf/4VyvAfg6f/2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791402952; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HQDVtE1CcJ/vya1XoEriDki0PShSSsrkeTwo5nMwSsiynxW
	0LN+jdpsxaM1FOlZBo1JA00V7ze1QQ7je29jpu8V+Z8Q0SJ5cnvizfKpC+0R3t2P
	Z3/cqOFB4svHQy3Hh+VFUEMCrRP9Lt70YYxtr3a6i8oq+lhy0/luyRQI4Q2f8JZ+
	UqvKzWUqIqGDfbhzSAlks+6Hex5IjW/4Tqe5TYR2IGiFyf5/ePcL77H/Ke4A3T/+
	QzKVIwTh4+Gi1aIQ+IYS8ZzTuvsFR7UT9mAGBWJjZcYyzSmS6UllKQrSqmuuER/b
	4ZcPcRzfnqYoUG4+7B6VdK7pgubcnacBcDGO+ng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:y4ybjgtDkd0oxZCbkS/9YgXLZveIZLxOjt0uY63nOq8=:q5BHwPmMjiH+XAyX6xE3Iu/EFbjMYWyi9oCPiR7taJY=;
X-ME-Sender: <xms:yKPGas0OPiUY2J3f6zx5JHKY7ZHKIusTBFrpVurkMv3tzjq9UsXRsg>
    <xme:yKPGat9h4SI_6w0Zl7BPiQtp6YtsKVkOKC_RN48CKNnnOB7-cMmggwjnENh3Spbff
    3uwkEWjBV39TJQTZeIhZfKWIT5Xt309eJmb7aEZyTj0idAvzZc70Q>
X-ME-Received: <xmr:yKPGatOYi5Z77lbw-SL7fxefpHMIWyYWB0goxH3eVz46qSGNFyov7_i3f7fGtEueF59dhyR3gwE00_p5QqmRguRNq4sacYZOOON_>
X-ME-Proxy-Cause: dmFkZTGtWVwJGX2IE0EIqkqjSCRfXWgx8MXwNbm3aXn2HeRyTg+OGj1lSiDxO4asTXhi8S
    9BZLJrF94owvLJu+grVoTAcEkKhI0yn8tv5jcWZRPyLYeroJrYIiBhRUj/GENoLFK8MQoU
    Nl5gDFCP6qh2wpQcXlTGh32O4CARgybwjLMwTpvHvFwUziliwpfmisz5vq3cDgZXbOIpEp
    zqpwNRYipF+n+Z2Ye60gkP86eITon5cJqFLeYU+1FaBDh7vhWwHxwsrL6skN/MhwMhuGzN
    22CcdGCRqA2F1V6tJ6noy3NIZNf746AoZU4F8dLIJr4IhqhiYAhhX3/1uiXjrHNrITPQph
    jfUgsp0nkV2OXhpxX2oC9kB8Xln789b2uIOFhLiZgFUpKryxYf2NS18gA3BqmAEJrdbuod
    97cijSmqT8b8s4Tbt9SfkRf1ZOIG13eubrFzoS+LNbUh3tkUWWoshCNeTf6iEQhDKAovYd
    0KMhn9XTzSLpOpm/xv52hivt9B8BGDgXbDq0wjvJYFteO5klb5FIoZgEa43XgOrrUJKINJ
    RV2162poeVHL4THCdqBpNBNZgsKtXegEbpx3bievrH3fIll56vVk/dmwkPuPLvEJber8pB
    jbVA+J5mGbVaVuPc+ttaZ9bhYRTRABI/LFKUmHXX18/WqMhajppshBlmW18g
X-ME-Proxy: <xmx:yKPGahfO4uZnwl8OjnfXAwlNsHEgWycc2Ezi8EOEX3bqTGw3SVeYEA>
    <xmx:yKPGasUmBDjq8UfwewMxPAnG1QbvIea4m0ryNQAmO2UAEXJg-AYcSQ>
    <xmx:yKPGapjZMSwFDoJop-0FSEeo1IgxlQsCQUApmslJ5lWxOENanR_bDw>
    <xmx:yKPGar99EVnXAnrNJSDQpGC6j7d-PFmKrt6o3rmh6Lj7MKolnpMCCA>
    <xmx:yKPGagsT0KGsRLBXgNr3Vx5X0n6v5awCY_a2GAALKgDxbhwNyp742OOO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 15:55:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v3 0/4] refs: run copy and rename through transactions
In-Reply-To: <cover.1791395643.git.maciej.ciemborowicz@gmail.com> (Maciej
	Ciemborowicz's message of "Wed, 07 Oct 2026 20:05:13 +0200")
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791395643.git.maciej.ciemborowicz@gmail.com>
Date: Wed, 07 Oct 2026 12:55:50 -0700
Message-ID: <xmqq8q4970ah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> Reference copy and rename bypass the transaction API. With files, the
> reference-transaction hook sees only the source deletion; with reftable,
> it sees neither endpoint. This series puts the logical ref updates and
> the reflog history into ordinary transactions so hooks can observe and
> reject the complete operation.
> ...
>  Documentation/githooks.adoc     |  10 +
>  refs.c                          | 200 ++++++++-
>  refs.h                          |  25 ++
>  refs/debug.c                    |  24 --
>  refs/files-backend.c            | 739 +++++++++++++++++---------------
>  refs/packed-backend.c           |   2 -
>  refs/refs-internal.h            |  28 +-
>  refs/reftable-backend.c         | 334 ++-------------
>  t/helper/test-ref-store.c       |  76 ++++
>  t/perf/p1424-ref-copy-rename.sh |  48 +++
>  t/t1424-ref-copy-transaction.sh | 352 +++++++++++++++
>  t/t1425-reflog-transaction.sh   |  59 +++
>  12 files changed, 1206 insertions(+), 691 deletions(-)
>  create mode 100755 t/perf/p1424-ref-copy-rename.sh
>  create mode 100755 t/t1424-ref-copy-transaction.sh
>  create mode 100755 t/t1425-reflog-transaction.sh
>
> Range-diff against v2:
> 1:  d852537d8c < -:  ---------- refs: run copy and rename through transactions
> -:  ---------- > 1:  6d7c146e57 refs: distinguish internal transactions from logical updates
> -:  ---------- > 2:  5c3ec4eb49 refs: support replacing reflogs in a transaction
> -:  ---------- > 3:  77af4e809c refs: run copy and rename through ordinary transactions
> -:  ---------- > 4:  83fa644fb3 refs: remove backend-specific copy and rename callbacks

I do not think I have time to read these humoungous patches, some of
which weigh more than 1000+ lines, with fine toothed comb any time
soon, but when applied to the recent tip of master 6de20f6092 (The
4th batch, 2026-10-06), it seems to break t0600 and t5510.  The
failing tests do not seem to be anything so system specific (and I
am on a GNU/Linux platform that is not anything remarkable).

I wonder what I am doing differently.  Did they pass for you?  Here
are the first failure from these test scripts.

Thanks.

expecting success of 0600.16 'delete fails cleanly if packed-refs.new write fails':
        # Setup and expectations are similar to the test above.
        prefix=refs/failed-packed-refs &&
        git update-ref $prefix/foo $C &&
        git pack-refs --all &&
        git update-ref $prefix/foo $D &&
        git for-each-ref $prefix >unchanged &&
        # This should not happen in practice, but it is an easy way to get a
        # reliable error (we open with create_tempfile(), which uses O_EXCL).
        : >.git/packed-refs.new &&
        test_when_finished "rm -f .git/packed-refs.new" &&
        test_must_fail git update-ref -d $prefix/foo &&
        git for-each-ref $prefix >actual &&
        test_cmp unchanged actual

test_must_fail: command succeeded: git update-ref -d refs/failed-packed-refs/foo
not ok 16 - delete fails cleanly if packed-refs.new write fails

expecting success of 5510.35 'fetch --prune fails to delete branches':
        git clone . prune-fail &&
        (
                cd prune-fail &&
                git update-ref refs/remotes/origin/extrabranch main &&
                git pack-refs --all &&
                : this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
                >.git/packed-refs.new &&

                test_must_fail git fetch --prune origin
        )

Cloning into 'prune-fail'...
done.
From /usr/local/google/home/jch/w/git.git/t/trash directory.t5510-fetch/.
 - [deleted]         (none)     -> origin/extrabranch
test_must_fail: command succeeded: git fetch --prune origin
not ok 35 - fetch --prune fails to delete branches


