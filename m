Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354C35CB7F
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282029; cv=none; b=WdfECiHTJnqw+wA0QCwYBhtobiu5VAijLSg2IQINL8rbJdz3TAEfRrlhNcJvXEhT/60ndRK1KfA9qbQWJ31Aq4bGGFRTG0wlOn+EELMRFW1wU7cgySF1ug8B0QZe96R4OxZhqfbhA+1lVNr7MBsVFQ1LmfTAw4TFBL0rJWochIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282029; c=relaxed/simple;
	bh=NYr4Nj/NV1Vs5SeJy9ein7QSkja8qChXjKtm1pmXsZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GH+P1o471cyT7P9m8v+kI4dKoGJCwVzSPkRgBp+bOtYtbOE2RErd/0Fd1NPQ5YFtQwxOnURNVRTTADzHpxCir07VkS/cztpSRljcoLpY4b6Cc2KoDcJrAsY6CrjS8Fbs21T6EREhNq9LIJSCQVrbIOvuiquCeMGVhKTWGOqyVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X1XJdrEk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F0wIg4Xs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X1XJdrEk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0wIg4Xs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1199DEC0974
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 06:20:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 06:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791282027;
	 x=1791368427; bh=L2e5709YCo/xEwxSvxt8r7CPwrjoGhFHLIFdQWBHVxo=; b=
	X1XJdrEk8AEHxLCLlBTfHXPGWpYxK4IXzlWpQUnCSKI6vZeL8eedq4O4PO2s8ewA
	z2ZNxEgH8pFIBUoY+tyoyDyu0DabJgmQlxIiqDYq2Ik45OHjYe5+PY9bFG39TMMl
	iIZnTqJ+OcH+Yf+1BcxO6iOar+eevk6T/Hm2KDbyOqHIZJbydPXr4xUTzfy5/qXU
	YlWHMVVy9TpunnMqSYRI/61zsg82IgWB3AL4yKReEEfxAHIL+Gt20M2J8YWKera4
	18yowgG+/B9duMDDatLdSTDqmV7kr8m8jHgxiOUijSI4eCrgvGLC5C9Cij5Hk4Yg
	zQVkT2BqYEfREDK+Awn5Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791282027; x=
	1791368427; bh=L2e5709YCo/xEwxSvxt8r7CPwrjoGhFHLIFdQWBHVxo=; b=F
	0wIg4XsWV0hsdYIaHiQnwAfIeXE1PM5Kkm+wVC9S6rwmYWEqSjtfNy6IG7lQdKpl
	Gilj2sz9DbyA0/kZe4xCFCWZqX/0ntKYXmdcmpQ3/Ft8KjxggVq5fMUSMx334ji2
	W0OjsnorlnWbEj+9ul7uimqJ7eYxowDemRvgbcqQHSOfCbR/TKmSKLCjY55JWhx4
	HxxkIOyfRU8nYhK4Xv4GiqYE1iihtQ5b4tXQspKxgKDdsrmd2+R+nkthVdEEyILJ
	GLhtb5w4bQiz0VDVBe1BP/gseGtXcCMDa4qrv/tzMNS1GLmB+ZH+FBfMbPeheEH1
	dGkIWGPkl98TE0U9mJsHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791282027; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tG/M3bQ029WSeuBasS0AQQ0sYgpe52H0ykQqpoxXEuxK7TF
	9biQWsZ7oaqQ8swTJp5hyZHZm8Fo8ysGg/rVN3J5b2DGvq5WwQG2EMcuh81QN6X2
	grdgGVo23HWtYOgpr46mIvR7SHhtmatz6VRb+j4WR7u9YjK2z3L1lwzzW9xYaBI7
	IaRLrUirqHFK2OYTe7dM9hQsv0ohxbETBlV4K0IMnTRw5q5uLCTU2EEMcmRgx2PG
	C3p15/fbIKfJoGS4gimsiWUXsZLMD5rMRD7RNIfIcnxQ0bV3TS3XlrN4tq+Du2jn
	p2LyNFFmi+Q7UCajo7XKdl6viiUpl7nPuTi5zWg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JtL/CR6IPXU+/N9UTDeeoBVnv7X/KFkE9aHabTP4uqI=:NYr4Nj/NV1Vs5SeJy9ein7QSkja8qChXjKtm1pmXsZI=;
X-ME-Sender: <xms:asvEakydcOqf-DVamd-AQcgRwf0cvsYj7EtGm_vy5uHp60GYrsv7ug>
    <xme:asvEavInggSYeKrlxdob0sVh1axKnOGODWxG27ZPDsLnWyO4LCH0WfmKsQ0NYASvv
    gjusMOvHO5_NskEkuxEslM0cr3Stc8iK7HdzeEKobVu5MQBFZkT9fs>
X-ME-Received: <xmr:asvEauoAeS00QOwR93oFuUIv-V_uTZkN7_fXeCFnrBaaGVTd2NBAltsBfO9VCnn-Kv7w5A>
X-ME-Proxy-Cause: dmFkZTE1NyywobzqigBsjHvWaAyFsI7cNpfmymIFO5bew9JM89+pv5LA6LCzafJ7ZkTfUs
    tACbyWuzgI++tyDspOw7JYU5Hbm8PZ6i+HrWOTUf4Vy3dqUYTrXMzdXuZEqRz8yz3BH4Px
    neacZDFh2taBqNLaHN5WsQxOyoD+GbD8IpmkoLe0ojfPIWmZaZqlRTv0csQa1YHIVcwFta
    u4ovF1ozHmM96cLlYbmXZiX206VD7MeNu2qdxwX7G2eZ0LLY1I80FXJK/XWmYfNUnBZoV8
    NNKXcQBmGG+7BewtKrA+vTPN8k19IQBnUVez6HrUmja8iyXSL+yjQgTH6JoEmdi/hrH3HU
    d4OZzEdEyd0FBSM3Sfvvlv2jDxYjh+EGnwtOpxSpH+1HbjKwNn2gvEWaCu58vT2FF8JsOg
    sQPJXVKfpDBui9iEIWBFAtwdieWqN7LHkUQYFnEr/gqMVDOHwGBovybPCKpDcneSRtm4sf
    eF7wDcPjkJwZ1GQ5mcrUnio8foHWfYcsZu33t7rU/qxx2T00m+KVy94f3/siB0iNWyptqO
    6MI5Gs0n0prbWLWWKmAcmA3biS9dBPSsCUu7mfQKmkCRQmInOabeBT4ResXk7dJm5hlHc3
    TfhIxW7ZQuGeJQk0ScIdAB8bJfiuy2RZRdHTmOhrwkYwoqANPqNziIVoY9qw
X-ME-Proxy: <xmx:asvEauLJsFwD85V99ESmcuT7VDn2lClVg45GyPEH_psQGiDgjaLHdg>
    <xmx:asvEajS-FJqWec8dxbP3vcHFb1E-SOvYk6hXjciIL4GxcJAlTsPv-Q>
    <xmx:asvEatsNpLEtTzrPmWTrzngeTuOHgn-LieOU8A97CSR4NKbUQ3L3oQ>
    <xmx:asvEakbwaQ1Qib8tB04tVD8xP_6QUQWoA6qYW-rikIXjmSGN1OPBMw>
    <xmx:a8vEaqpcV92cYKO0GVaHAyUdajSS1teydfEhFFcNf048ev_vsDK5ZSGm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 06:20:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62103011 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 10:20:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] packfile: fix corruption due to stale delta base
 cache entries
Date: Tue, 06 Oct 2026 12:20:13 +0200
Message-Id: <20261006-pks-packfile-stale-delta-base-cache-v2-0-69669a2fc6ce@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOTQ6CMBCFr0K6dkxpEdSV9zAshjLIiALpVKIh3
 N2CJ3Dzki95f7MS8kyizsmsPE0sPPQRzC5RrsX+RsB1ZGW0yVOtDYydwIiua/hBIAGj1vQICBU
 KgUPXEug6K6zOjkWeWRWbRk8Nv7eVa/ljeVV3cmGtXh0tSxj8Z7sxpavvv8UpBQ3F4WTQkk2R9
 CWm9vxU5bIsXxFbk37lAAAA
X-Change-ID: 20261002-pks-packfile-stale-delta-base-cache-0d4730487643
In-Reply-To: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
To: git@vger.kernel.org
Cc: Guillaume Chauvel <guillaume.chauvel@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Hi,

this small patch series fixes the bug reported in [1].

To summarize: we never evict delta base cache entries when closing the
owning pack. The cache may thus contain stale entries which are keyed by
by the memory address of `struct packed_git` and the offset of the entry
in the packfile. Now when allocating a new pack that happens to have the
exact same address and that has entries sitting at the same offset, we
may try to use these stale entries and thus yield corrupted data.

This all sounds very unlikely, but the interesting part is that this can
be reproduced by using recursive merges with submodules, as we open and
close the object databases of each respective submodule. And if they
have similar packfiles, then we may trigger the bug.

The series is built on top of v2.56.0.

Changes in v2:
  - Commit message improvements.
  - Link to v1: https://patch.msgid.link/20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im

Thanks!

Patrick

[1]: <CAP4DsUexEmm1qo6jH+Qzy+n3dQs_OCJ8yg=ReF+aVrcTrC7NeQ@mail.gmail.com>

---
Patrick Steinhardt (2):
      packfile: move around `close_pack()`
      packfile: fix corruption due to stale delta base cache entries

 packfile.c                 | 33 ++++++++++++++++++++++----------
 t/t6437-submodule-merge.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 10 deletions(-)

Range-diff versus v1:

1:  e7c340df39 ! 1:  a8af6a79c7 packfile: move around `close_pack()`
    @@ Commit message
         packfile: move around `close_pack()`
     
         In the next commit we'll want to access the delta base cache in
    -    `close_pack()`. Move the function after the declaration of the cache to
    -    prepare for this.
    +    `close_pack()`. Move the function after the declaration of the cache so
    +    that we won't need a forward declaration.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  25efe15034 ! 2:  d6d45b5bf9 packfile: fix corruption due to stale delta base cache entries
    @@ Commit message
         would have the exact same key.
     
         All of this sounds very theoretical, but we can actually trigger this
    -    bug somewhat reliably! When doing a merge with "--recurse-submodules" in
    -    a repository with lots of submodules that have similar-looking packfiles
    -    we end up opening and then closing the object databases of each of the
    -    submodules in sequence. Because of the above mentioned commit we would
    -    close and free each of the packfiles part of the respective databases,
    -    but we wouldn't evict thire delta base entries from the cache.
    +    bug somewhat reliably! When doing a merge in a repository with lots of
    +    submodules that have similar-looking packfiles we end up opening and
    +    then closing the object databases of each of the submodules in sequence.
    +    Because of the above mentioned commit we would close and free each of
    +    the packfiles part of the respective databases, but we wouldn't evict
    +    their delta base entries from the cache.
     
         When using glibc, one of the packfiles will eventually get the exact
         same address, and that will then cause Git to read the wrong entry from

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20261002-pks-packfile-stale-delta-base-cache-0d4730487643

