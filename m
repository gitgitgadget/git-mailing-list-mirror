Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EA79FE
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738739021; cv=none; b=hBXkbUtwd85Hzd8plmxNMahLh0451DbYvzP6BsQiMgwMJ306yTaEVOVqOmmlzCINuezo31jf4jsaZcgxTAoMZLj/qdzCziGFZxB6pEHV2jp3SLrwJd5bgOYPjaFHJEzuq/hvp/I7QH9rak46Ot2aq62ZW7ZHdg5TKi5/HWj3q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738739021; c=relaxed/simple;
	bh=M9B5fMDO9mNviUbJMDF7z0IRz7s4XTSt9jEaD4GyHKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prpX8wK9qAcAI1B8oh+YOu3gg1hevXGZIRii3nCFDpph8pS3gs+i0K4MVgMNRKR+xKjqjHkZpTjDx0fcnKvyS5vpxvaGg602kAfZual7vfvlAgE/ocPN6KqDBgkl2/vGu1JnADs270juU0gLeJar564E5AnPQDZet1UI2/wl2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qxwWPZPT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W389/tcM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qxwWPZPT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W389/tcM"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 21D3713801A9;
	Wed,  5 Feb 2025 02:03:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Feb 2025 02:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738739018; x=1738825418; bh=3iuRPgdrth
	P4P6W7yblhoUb636fEz1AomjuW2sIOFJw=; b=qxwWPZPT8VIVOlUTrCFY3y1vNe
	GkwV7gY+ZNjimzeF/R4hkuTy/zR2l5yrY0uLJ1ZU/lyA4cdx7xOMH2/b8otGnbPX
	3FyLAZtNM79pAUv6CqXR2/Cna2CueUtg10xBUQisy0kikUv7C+3Ab4Yxcs5v6C7d
	2V5uKUzWfRhhciOy+KDNEMUVlcAizjYbydd76zc8s4PyQPPwalFRMZU/RQjDJY0O
	xRq+0wsVGrztYCMUB2fHQQBOfeQ+ERj5OQeFyWRVnTEEJ6jvO2xTlMXY4D/yHGmz
	k1vDr0nRd1XLssRmxlmPptzJUFiV+g98f96dGNFVTbWYRx5YvOnQVnuqewUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738739018; x=1738825418; bh=3iuRPgdrthP4P6W7yblhoUb636fEz1Aomju
	W2sIOFJw=; b=W389/tcMcylNd/PrWdzs00Iio5unhgTeGqkStVBSQYe9CeQI6vu
	LQ/3JoSuNnhBOeIAK6uzByLtIAsn22kCTl4fHP7L/01M+LOvHHWYkKPWrVw3V6t6
	16FY5xLK58L9EcFAPTKkWcxj4DXSqK642MGgFvOFXfAMG3V7aQ/j5WsJPlK/sDhX
	FMwKsHR/UY+HgjErTdht/qLmoun+BLV+6ez8EdZaAWK4iz/Z8QAegieHrJkTv6tv
	VMF4jqyKZcVn+l4C6CKe2DM9ZhBJKUdj5FnPW3AgvKn2oHGsKyGIKeIwJZhMZV6/
	Y7omDOCtp7D6/XJnvw0D+docCEubY6LSe8A==
X-ME-Sender: <xms:SQ2jZwJp7yqwkwDkXuD4WKK7t0oeSUngf8Uv361PM4hPR436_ipeLw>
    <xme:SQ2jZwKeFTJM0OX6Um0Xb0bPlbmoTQ7l7B6p3a9l4ZDlSCeHDEspnjqJYao6u1RiP
    egxtKz2n8LTE62IMw>
X-ME-Received: <xmr:SQ2jZwtrYhx0gUYFxYrxT6oMPofRGfjjz4FpWoYHYFlInVBy9EtcwY3lqcuDtt_MyPWx6J_S4qbNRYrmOcSVut87cWbQ98UAkrYDMkZytjOx5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefgueeugedtgfffudetuddtueeffffhhfefvdfgvdfg
    tdduvdffffektdetkefhhfenucffohhmrghinhepthhhvghmrdhknhdpmhgvrhhgvggurd
    gsfhdprhgvrgguhidrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SQ2jZ9bhGv81iwraUEiViZShiWJ2qOy9kdlkjGKFNLf8wnwblmg6Dg>
    <xmx:SQ2jZ3Yw5MaUok8FjzY-3baYlY_jg9EjyVGOv1iN75_DEFSE1-HF8Q>
    <xmx:SQ2jZ5BCYTR-Ivp8t604kU27IXdZzfhVwX4rdyTxtBUHTRnqYMSfoQ>
    <xmx:SQ2jZ9ZIlF7eUTnStusv59_rfiWn8f1L4ih1ve4slkbtVLe-RS7Oxw>
    <xmx:Sg2jZ2XcORApPDo6bUX2wovovDSMwJs7vnG72GkBblJ31HK7Y6BAI55G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 02:03:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43974043 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 07:03:34 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:03:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Feb 2025, #01; Tue, 4)
Message-ID: <Z6MNRVrhw3Nxz6Iw@pks.im>
References: <xmqqldulrvly.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldulrvly.fsf@gitster.g>

On Tue, Feb 04, 2025 at 06:08:57PM -0800, Junio C Hamano wrote:
> * tc/clone-single-revision (2025-02-04) 7 commits
>  - builtin/clone: teach git-clone(1) the --revision= option
>  - parse-options: introduce die_for_incompatible_opt2()
>  - clone: introduce struct clone_opts in builtin/clone.c
>  - clone: add tags refspec earlier to fetch refspec
>  - clone: refactor wanted_peer_refs()
>  - clone: make it possible to specify --tags
>  - clone: cut down on global variables in clone.c
> 
>  "git clone" learned to make a shallow clone for a single commit
>  that is not necessarily be at the tip of any branch.
> 
>  Will merge to 'next'?
>  source: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>

I'll do another review today.

> * ps/reftable-sans-compat-util (2025-02-03) 19 commits
>  - Makefile: skip reftable library for Coccinelle
>  - reftable: decouple from Git codebase by pulling in "compat/posix.h"
>  - git-compat-util.h: split out POSIX-emulating bits
>  - compat/mingw: split out POSIX-related bits
>  - reftable/basics: stop using `UNUSED` annotation
>  - reftable/basics: stop using `SWAP()` macro
>  - reftable/stack: stop using `sleep_millisec()`
>  - reftable/system: introduce `reftable_rand()`
>  - reftable/reader: stop using `ARRAY_SIZE()` macro
>  - reftable/basics: provide wrappers for big endian conversion
>  - reftable/basics: stop using `st_mult()` in array allocators
>  - reftable: stop using `BUG()` in trivial cases
>  - reftable/record: don't `BUG()` in `reftable_record_cmp()`
>  - reftable/record: stop using `BUG()` in `reftable_record_init()`
>  - reftable/record: stop using `COPY_ARRAY()`
>  - reftable/blocksource: stop using `xmmap()`
>  - reftable/stack: stop using `write_in_full()`
>  - reftable/stack: stop using `read_in_full()`
>  - Merge branch 'ps/reftable-sign-compare' into ps/reftable-sans-compat-util
> 
>  Make the code in reftable library less reliant on the service
>  routines it used to borrow from Git proper, to make it easier to
>  use by external users of the library.
> 
>  Will merge to 'next'?
>  source: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>

From my POV it's ready, but I'd like to get an Ack from Justin and
Johannes, as they both had comments on the last round. I've Cc'd them.

> * kn/reflog-migration-fix-followup (2025-01-22) 4 commits
>  - reftable: prevent 'update_index' changes after adding records
>  - refs: use 'uint64_t' for 'ref_update.index'
>  - refs: mark `ref_transaction_update_reflog()` as static
>  - Merge branch 'kn/reflog-migration-fix' into kn/reflog-migration-fix-followup
> 
>  Code clean-up.
> 
>  On hold.
>  cf. <Z5DgxQuc2j_-5GHg@pks.im>
>  source: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>

I think this topic should now be unblocked as all the preceding fixes
and fixes of fixes have been merged.

> * bf/fetch-set-head-fix (2025-01-27) 2 commits
>  - fetch set_head: fix non-mirror remotes in bare repositories
>  - fetch set_head: refactor to use remote directly
> 
>  Fetching into a bare repository incorrectly assumed it always used
>  a mirror layout when deciding to update remote-tracking HEAD, which
>  has been corrected.
> 
>  Will merge to 'next'?
>  source: <Z5Mrk02wMdABtrVZ@pks.im>

Yup, I think this series is ready.

> * ds/backfill (2025-02-03) 7 commits
>  - backfill: assume --sparse when sparse-checkout is enabled
>  - backfill: add --sparse option
>  - backfill: add --min-batch-size=<n> option
>  - backfill: basic functionality and tests
>  - backfill: add builtin boilerplate
>  - Merge branch 'master' into ds/backfill
>  - Merge branch 'ds/path-walk-1' into ds/backfill
> 
>  Lazy-loading missing files in a blobless clone on demand is costly
>  as it tends to be one-blob-at-a-time.  "git backfill" is introduced
>  to help bulk-download necessary files beforehand.
> 
>  Will merge to 'next'?
>  source: <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>

I'll do another review today, but think it should be close or ready.

> * ps/send-pack-unhide-error-in-atomic-push (2025-02-03) 8 commits
>  - send-pack: gracefully close the connection for atomic push
>  - t5543: atomic push reports exit code failure
>  - send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
>  - t5548: add porcelain push test cases for dry-run mode
>  - t5548: add new porcelain test cases
>  - t5548: refactor test cases by resetting upstream
>  - t5548: refactor to reuse setup_upstream() function
>  - t5504: modernize test by moving heredocs into test bodies
> 
>  "git push --atomic --porcelain" used to ignore failures from the
>  other side, losing the error status from the child process, which
>  has been corrected.
> 
>  Will merge to 'next'?
>  source: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>

I think so.

One topic that I miss in the cover letter is [1]. You probably forgot to
pick it up :)

Thank you, as always!

[1]: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>

Patrick
