Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9668256C8D
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669561; cv=none; b=nmSBEhm6JDCIfvnbVDMN3f55AdRpFK0f9QKFs29vY+KiG3lFyAauU0ZRrbfrClv7NVAl8zsq5CumsR+fQNIhpRBbQ/1D0ckswPiP7JajtmgivxZliLQYwdUcDn4h+ue0E8YjILa8lQPRU91hbyjguzSVxLU20865CNy+80bh9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669561; c=relaxed/simple;
	bh=Lh5SnKwrnlh/qyrYX9GMk3JeaBoGRymmywULeHvZBy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfj0UtX/Lka3vY6OEw1VvgGxhtJOeW+Ua9RITXy/xJcHXaRr9RZZ/mQXy1djGu80XcTHjJhna/oI8dh4VIL6fAbJtrj08u4eBhlp9Kbe7eBmQFaLtv9RldCbm6dfZSv8pzYhv9cd0kbASFYwrXck3NNaVRQE0uwRkGXoEwobwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y7uCTrza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9asardX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y7uCTrza";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9asardX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 147B0EC031A;
	Mon, 20 Apr 2026 03:19:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 03:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776669559; x=1776755959; bh=852zSDIFiO
	fKELYOskXxyPn+IBKF8W9XRudfqkY6Zsw=; b=y7uCTrzakB6mMlJPtWybVBfzHT
	gWUAjYpfeb59CP3bVwZv9H7+ftNyb1nH/HRxb7xpgT3q54asTE1sU8lNfPr+qVxz
	lhonxhPtuowev0vlrRyWydwCsxHDSwK8ew5RXwZUlPz9jzpgzRYYyWRnXbMhtXrT
	Srp0BY8M8TGTdiqBSWVqQ2oe0wQlzJo425Z/FipA0oCS2K19rTNgSsDJWxMvYVDp
	D3I1QnmknSY3b5oqgAgezcfz0rs7uUGJupFt9UIzGMr5l8egTcrFHRka3KYaYzTP
	7WhumclolKfWWEu/nYQtE75Yhw95p+2yKhITQB39OFxTIqIJEoVyfIofFH5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776669559; x=1776755959; bh=852zSDIFiOfKELYOskXxyPn+IBKF8W9XRud
	fqkY6Zsw=; b=Q9asardXUCPPgcFCVRgXzna1MjkL+ysx3GxM0x3RaHXf7CMnpTh
	sK5HO6nU/ynpXHo9OBe3CpeCv0HplqaVCyNj2bYJ708jsgnR8Fo0y62Ve0dXSTT+
	ae8XVb04wIm9Yldmq1g9KYQkT+P1NRrt4NcbyslraQL25IkjIlmwiMeEb5/b10+a
	vgERC1mOMIdmCDBmHEY25pF2aXGV6jLmx2YLjWlkmFenGxiuRJ8O4dLpSRJTN0OH
	Qz2S1Ax6Z0mOm8d7S1Ik7Wzq3YKk11g+WR64Us7skcJuMhBOddkaNTWM5RGWkkii
	DpJ0h0BMWQs534n63OAuX3CFn74RJg2rGAQ==
X-ME-Sender: <xms:dtPlaQiAoC3x93NPsguSfoyET2DI8YvBeAQDa5E9xY4I0skS5FMi1g>
    <xme:dtPlafBSUXCwJug1IM44WsSkQExHhWtCYe6qsWvjzT7fgsyvv-ZNuvxfe0eF2ULiO
    3hvBEfQyiMTl2zNxIxwPeZ5ueiLiNFf0GQr-TL5LYfBy7MYbFvt>
X-ME-Received: <xmr:dtPlaVvmrKwm8ZbHRG8DYC-5vJSkxT_pCjT8AYeM-Xsdo8v-pz9eNbQpyi7nyJSrZOeWsvRDl_iZxeCIYHXdX7EM5dPkbDCGH1tEIXAMh84_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepieelffekvdefiedujeehleffteethfdvudfgle
    ekkedvteduvefhteejvdekgfejnecuffhomhgrihhnpehsuhhgghgvshhtihhonhdrphhs
    pdihvghsrdhpshdpshgvrhhivghsrdhpthenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dtPlacYfUkoVOWMvIbbLZ9XwICm4es7NzKYclGeJSbi-8Us0Mglfcg>
    <xmx:d9PlaQXp0VUyLKObZWWL0amQ0yJvL5ZJ3P9TU-3IouKz2CSMpYJAlg>
    <xmx:d9PlaY6g7uWmslOHuCmgB9UUyuIVO9yDDK0FDSywdCNxnRvvzfDtwA>
    <xmx:d9PlaTijVk3Rn2cVZzu1e4JIgsHHuvS-NShJ2obXANQiQaEi6Gym2Q>
    <xmx:d9PlaT4yngV-U7ZH2zp4xei_LId1c-ALG8t7raa8iLZlI2owyxKiUHho>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:19:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b97fe8fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:19:16 +0000 (UTC)
Date: Mon, 20 Apr 2026 09:19:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2026, #05)
Message-ID: <aeXTcZ7K9a6kUIbk@pks.im>
References: <xmqqy0ilus5p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0ilus5p.fsf@gitster.g>

On Fri, Apr 17, 2026 at 03:40:50PM -0700, Junio C Hamano wrote:
> * ss/t7004-unhide-git-failures (2026-04-14) 3 commits
>  - t7004: avoid subshells to capture git exit codes
>  - t7004: dynamically grab expected state in tests
>  - t7004: drop hardcoded tag count in invalid name test
> 
>  Test clean-up.
> 
>  Will merge to 'next'?
>  source: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>

I think overall this series is an improvement, but I think that the
first patch might warrant a reroll based on your suggestion.

> * ps/odb-in-memory (2026-04-10) 18 commits
>  - t/unit-tests: add tests for the in-memory object source
>  - odb: generic in-memory source
>  - odb/source-inmemory: stub out remaining functions
>  - odb/source-inmemory: implement `freshen_object()` callback
>  - odb/source-inmemory: implement `count_objects()` callback
>  - odb/source-inmemory: implement `find_abbrev_len()` callback
>  - odb/source-inmemory: implement `for_each_object()` callback
>  - odb/source-inmemory: convert to use oidtree
>  - oidtree: add ability to store data
>  - cbtree: allow using arbitrary wrapper structures for nodes
>  - odb/source-inmemory: implement `write_object_stream()` callback
>  - odb/source-inmemory: implement `write_object()` callback
>  - odb/source-inmemory: implement `read_object_stream()` callback
>  - odb/source-inmemory: implement `read_object_info()` callback
>  - odb: fix unnecessary call to `find_cached_object()`
>  - odb/source-inmemory: implement `free()` callback
>  - odb: introduce "in-memory" source
>  - Merge branch 'jt/odb-transaction-write' into ps/odb-in-memory
>  (this branch uses jt/odb-transaction-write.)
> 
>  Add a new odb "in-memory" source that is meant to only hold
>  tentative objects (like the virtual blob object that represents the
>  working tree file used by "git blame").
> 
>  Will merge to 'next'?
>  source: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>

I think this series is ready, yes.

> * ps/test-set-e-clean (2026-04-17) 12 commits
>  - t: detect errors outside of test cases
>  - t9902: fix use of `read` with `set -e`
>  - t6002: fix use of `expr` with `set -e`
>  - t1301: don't fail in case setfacl(1) doesn't exist or fails
>  - t0008: silence error in subshell when using `grep -v`
>  - t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
>  - t: prepare execution of potentially failing commands for `set -e`
>  - t: prepare conditional test execution for `set -e`
>  - t: prepare `git config --unset` calls for `set -e`
>  - t: prepare `stop_git_daemon ()` for `set -e`
>  - t: prepare `test_must_fail ()` for `set -e`
>  - t: prepare `test_match_signal ()` calls for `set -e`
> 
>  The test suite harness and many individual test scripts have been
>  updated to work correctly when 'set -e' is in effect, which helps
>  detect misspelled test commands.
> 
>  Will merge to 'next'?
>  source: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>

I'll send one more version today that will add an explicit opt-in for
this new infra, and make our CI use that opt-in.

> * sp/refs-with-less-the-repository (2026-04-04) 3 commits
>  - refs/reftable-backend: drop uses of the_repository
>  - refs: remove the_hash_algo global state
>  - refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
> 
>  Reduce the reference to the_repository in the refs subsystem.
> 
>  Will merge to 'next'.
>  cf. <adYV6NK93Kzg1EYG@pks.im>
>  source: <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>

> * sp/refs-reduce-the-repository (2026-04-04) 3 commits
>   (merged to 'next' on 2026-04-09 at bb1d626802)
>  + refs/reftable-backend: drop uses of the_repository
>  + refs: remove the_hash_algo global state
>  + refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
> 
>  Code clean-up to use the right instance of a repository instance in
>  calls inside refs subsystem.
> 
>  Will cook in 'next'.
>  source: <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>

(Shuffling things around a bit). I think these are both the same topic?
I guess you accidentally included them twice.

> * jt/odb-transaction-write (2026-04-02) 7 commits
>  - odb/transaction: make `write_object_stream()` pluggable
>  - object-file: generalize packfile writes to use odb_write_stream
>  - object-file: avoid fd seekback by checking object size upfront
>  - object-file: remove flags from transaction packfile writes
>  - odb: update `struct odb_write_stream` read() callback
>  - odb/transaction: use pluggable `begin_transaction()`
>  - odb: split `struct odb_transaction` into separate header
>  (this branch is used by ps/odb-in-memory.)
> 
>  ODB transaction interface is being reworked to explicitly handle
>  object writes.
> 
>  Comments?
>  source: <20260402213220.2651523-1-jltobler@gmail.com>

I'm happy with the status quo of this patch series.

> * pt/fsmonitor-linux (2026-04-15) 13 commits
>  - fsmonitor: convert shown khash to strset in do_handle_client
>  - fsmonitor: add tests for Linux
>  - fsmonitor: add timeout to daemon stop command
>  - fsmonitor: close inherited file descriptors and detach in daemon
>  - run-command: add close_fd_above_stderr option
>  - fsmonitor: implement filesystem change listener for Linux
>  - fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
>  - fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
>  - fsmonitor: use pthread_cond_timedwait for cookie wait
>  - compat/win32: add pthread_cond_timedwait
>  - fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
>  - fsmonitor: fix khash memory leak in do_handle_client
>  - t9210, t9211: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
> 
>  The fsmonitor daemon has been implemented for Linux.
> 
>  Will merge to 'next'?
>  source: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>

I'm still somewhat torn on this series, mostly as I still haven't seen
an in-depth review on later versions other than my own :/

Thanks!

Patrick
