Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294D147C91
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163426; cv=none; b=usD5tJMFfOcoZq+WOfxX5rtYrcP3Rq0BQbxh4OkWl/davVBjyT/z1E1eSogWZwyQMirrM/8OlTAGkZpK8gvDq5i66i55vzXT2oLd+QfBWTdfZKvLaCg+5SonHn4/zTUAMEQZXL/U5NhVLEiopb25JrAUwLBR1+ygbrJP/6ygPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163426; c=relaxed/simple;
	bh=e2tC9Cm+tnj4nl/5yyBH+7OOORltmrZWSxo++A7d7qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9T8j+p4mm5UYab5WCGx0yQ+EaRcNmp/TXc7iNMSt/Rs1CvUI11y6G3cdyP+42hNpvLZuX6Er8YuZ0MYxM2TZFEkjaXTpyhQy+3ILLwRzmldAMzMQbItPg2x8oUrREtLk+z2vw2pNsnvyF2xQFBnx4/hpaG2++VywWOCdxbu7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hLnaZkuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNUvXVVB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hLnaZkuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNUvXVVB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC7DF1140297;
	Tue, 24 Sep 2024 03:37:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Sep 2024 03:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727163423; x=1727249823; bh=vSY2ESdUv5
	nRr2rOV33FiSpvKAs/62obHcuPPkohMGo=; b=hLnaZkuD9UeDijTQz9qF8FMD99
	Z/PcRdUWfGTRLAKN+u9q9PsKDEPJT9l4POjZ2Gn1asmXOq3TZXVjQs2BPDoJ4vgK
	WHF2QbBUEoxtCfMH0sEMOiNbqKrM7lJMTnE0njx9iGLITv9Sa9BC8OCeYj2DE41b
	bmGt9BDsz/wMpYaSjylD33x6YkC2Xq7TSHKGWPK1YllNv1pJcqT1qXQAPJPYgHHA
	fe/JSjtJeKfsUpEIBdwGRDKMkth8RnhipndRddsF/0Nki7pxM/k57i9Jp3gcBFOw
	58il19495S1B6sa1edhA+N7Qb5E3hMHA9ldSovY+/cBgLJyDA6NTAPzn0okw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727163423; x=1727249823; bh=vSY2ESdUv5nRr2rOV33FiSpvKAs/
	62obHcuPPkohMGo=; b=WNUvXVVBdVzOleIxyjvYob3Ka4B/5k88EHoJI84al5F4
	Anq71A0jiN3KTL7SxTK7voBYkKVu2ebWO5kPcY62HDCW/P9FwxggMHYrWJC/2kvX
	H8BZt2N4nztz2OkoDrUji5bJ2wIQZBvGxomGAizpRsEcMm4nhVmFiMkVAFKEHr9R
	ASUyCy16pjfEN5Jddpbp2Sp7bf9mkbrRc5DTiolHxDBDWN+VDNlUPr1Isn5R4cOL
	xU8jB/3sfSpVpDawqP+CnjxXe77Ib0rkn2vzyxZLBbr3TWAsNhCrbfJM/7WgdFpE
	9l4wYSbItpFOTzsiMUe9UA2I57lva2DkFivYOI6GNg==
X-ME-Sender: <xms:H2zyZlnFcWCpXzfRuCl-JIdaTARoP22M34gEz_reLUkMnaEXctBFug>
    <xme:H2zyZg0ZwauM8KJQXR9yXP7Kxn5EX0cIMTLqGcevIrwRVbfdVvtHtbplW8-e6d9zH
    gCAttqH6etgE6UTPw>
X-ME-Received: <xmr:H2zyZrqwFfN_j_xJgdih-LWtynPeDsVZUQ0E2q5_wpZsZUSmjqJzdU7z1O0CH1F5nQK-Y3mYPLyQOO4wK-du9mWGiQz6MXsfs2-T2Dx9Pt4_AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejffffveehte
    dukeegjedtuefhjeeghedtffetgfegfeeljeefhffgueehjefhvdenucffohhmrghinhep
    phhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:H2zyZlnHXnlA-p51THq9RqeKeXVuJTRx6gEHfbICuaeNnmk5Q621Lw>
    <xmx:H2zyZj2bxASfoM4uMbTB5LV37Oo_SkhuzkqOLE6bKP4WWm4rZnZzwg>
    <xmx:H2zyZkuDUS4EgXChF2V6VwPjKjUDZtIOFqD7HRjji5vo8wwcfqNqxw>
    <xmx:H2zyZnXaa3qQ3e1KmiXvcwUUyhonNmY6t5W35iiqwQUXq-XjhXBxJg>
    <xmx:H2zyZhDzXslwRSQBP7NuzJlhBnpnNSTuBbHsS4UFDw_QYrs7mBpbHQtA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 03:37:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc878571 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 07:36:27 +0000 (UTC)
Date: Tue, 24 Sep 2024 09:36:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #09; Mon, 23)
Message-ID: <ZvJr45YKvMUEi4hC@pks.im>
References: <xmqq5xqmxc3k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xqmxc3k.fsf@gitster.g>

On Mon, Sep 23, 2024 at 03:02:39PM -0700, Junio C Hamano wrote:
> * ps/reftable-concurrent-writes (2024-09-19) 3 commits
>  - refs/reftable: reload locked stack when preparing transaction
>  - reftable/stack: allow locking of outdated stacks
>  - refs/reftable: introduce "reftable.lockTimeout"
> 
>  Give timeout to the locking code to write to reftable.
> 
>  Will merge to 'next'.
>  source: <cover.1726653185.git.ps@pks.im>

We're drawing closer to Git v2.47-rc0, and this topic looks like it will
be included based on its current status. But to make things explicit:
this fixes real issues I have hit in the wild with the reftable backend
that are caused by concurrent writes and that can lead to annoying
behaviour, so I want to ensure that this topic really does end up in Git
v2.47.

Just as a heads up :)

> * ps/leakfixes-part-7 (2024-09-16) 24 commits
>  - diffcore-break: fix leaking filespecs when merging broken pairs
>  - revision: fix leaking parents when simplifying commits
>  - builtin/maintenance: fix leak in `get_schedule_cmd()`
>  - builtin/maintenance: fix leaking config string
>  - promisor-remote: fix leaking partial clone filter
>  - grep: fix leaking grep pattern
>  - submodule: fix leaking submodule ODB paths
>  - trace2: destroy context stored in thread-local storage
>  - builtin/difftool: plug several trivial memory leaks
>  - builtin/repack: fix leaking configuration
>  - diffcore-order: fix leaking buffer when parsing orderfiles
>  - parse-options: free previous value of `OPTION_FILENAME`
>  - diff: fix leaking orderfile option
>  - builtin/pull: fix leaking "ff" option
>  - dir: fix off by one errors for ignored and untracked entries
>  - builtin/submodule--helper: fix leaking remote ref on errors
>  - t/helper: fix leaking subrepo in nested submodule config helper
>  - builtin/submodule--helper: fix leaking error buffer
>  - builtin/submodule--helper: clear child process when not running it
>  - submodule: fix leaking update strategy
>  - git: fix leaking argv when handling builtins
>  - builtin/help: fix leaking `html_path` when reading config multiple times
>  - builtin/help: fix dangling reference to `html_path`
>  - Merge branch 'ps/leakfixes-part-6' into ps/leakfixes-part-7
> 
>  More leak-fixes.
> 
>  Will merge to 'next'?
>  source: <cover.1726484308.git.ps@pks.im>

I do not plan a reroll of this series right now, and your review read
favorable to me. So I'm happy to have it merged now-ish, but I'm also
okay if you want to wait a couple more days to maybe get more eyes onto
it.

Overall, there is light at the end of this tunnel:

  - I've got ~45 patches in the pipeline which I'll split up over two
    more patch series.

  - I've nerd-sniped Peff into fixing leaks in the http-walker for me,
    and that patch series will likely end up on the mailing list later
    this week.

With that, we're now at 7 remaining test suites which aren't yet leak
free. So overall, I think it's going to be four more patch series in
total until we're done with the effort. And then one final patch to
convert the leak sanitizer from opt-in into opt-out.

Patrick
