Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A033DED9
	for <git@vger.kernel.org>; Wed, 20 May 2026 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779254858; cv=none; b=UkfgF304k4uwiYzC3JXf58W0nBpgdTdloY4YIZ2SyaXB7V7EqUlPRQacEYDpDi2z80NtxoCNxikoEOTgo3FErtieHZOBrH+R5etvqXnZ1BK1k1VPhEDf3RXZd13bZXHhRAi6DcNEKUweEKKbqdPThp3L1VNMQO4k8n90z2RFz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779254858; c=relaxed/simple;
	bh=GJQ6zrj67wym8F6t+jQCpL2vKOxehCImTTVVP3ReU5A=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pecso7aQpUk1aIahRQ1EJJ11KBGgM+mFJMZnGkywoEBQLWWIqzJ+CfLzY53GowpQxPx5v3k08iAaUs/1NJOSSKi433+Ue54Q2bzq6s14pXvMLHPev4LQcg9FS1mklocofaqtj/dGu+bM5jGwMtKjaJAoixQ0GN634wAyegTyIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wdc5Nvpq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqluSzSj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wdc5Nvpq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqluSzSj"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F018A7A00E8;
	Wed, 20 May 2026 01:27:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 20 May 2026 01:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779254855; x=1779341255; bh=Q/nvMn8DhA
	gHNh9wQUA4BrsZok+gHNC52aC45DiD1Dg=; b=Wdc5Nvpq01M2ulmrWBXXa/LPI5
	GAPxmHq8KolEniFES/O3Nt5JYBcaaGNvS0I79RRxR1boX0gUXGGUY1QIkFlPfrU6
	/47gedrFRLRXIT6nei3jWj5GVEPQzT+KVNFvndp5OpFTSEwQZlJfWowLmGRAkU+o
	ci4/zgiKsigXVapmjrxfXBa5VktPH8nBmBp5+B9o/cYGuffzIV8p0XimM6F45nrm
	ILC+BYaGsmR+CKDWoINuTrROBdcUHw/wE/7EqlNjjybF3ezWeDcQ7bTdwAQsrAqW
	4UCh1/Y+1oBOu5c6YCTGwRLNAePUGtsC/ZXMIuRyXL8/hQZM9phKubPICQLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779254855; x=1779341255; bh=Q/nvMn8DhAgHNh9wQUA4BrsZok+gHNC52aC
	45DiD1Dg=; b=VqluSzSjly4JNvHiqM40hPGseMBIVurrn4UlY0wq6fBhU+Oc3nT
	/zpLjv3JfNP1NvAEICqeZkK7FnnQWzis13lmnKWeXTfekMMGNEWxaw8Lll94QrV0
	28O7V6E8KWmxuAkoq3v++a9ei69AxreAj4/oo1X4WilGk7rdc0ED9cLzxipJ9n6O
	oalOfSVSxJNnDRKoHxSFWoUP5h0fPnHnhnuT10+Te2/NRwsKgEeRYMSS2EzpB1iT
	Cnk1vgxfVuheoSplf6zSYZYISUY9nT6DN0phJjZv8rmz0w7jbABRXone7TO02lb8
	rOS0NhP2WfP66rJUn4fiZel5Kqn54t9hAfg==
X-ME-Sender: <xms:R0YNalaQKwUmYD-QC7x7AD5V12olk3_4T2h1lZ8vghVbS8K0gsDVCQ>
    <xme:R0YNaiZYFdP_IcMusil9PBtCN1jps7hkIdjlXUIO_ugO-NXurjzHyQdGVoI22ej6L
    zXoDm864XCMsGvdjgPtnYCH6VqlVP8Ytt2L9k67TBySj0m9CWXXQQ>
X-ME-Received: <xmr:R0YNalmimXg4IJ7HLaB3nR6uflCSotl6f4BTcUn2RacLM5TuYZUYKxmAkxNNMR40ZQ3gWvesbGRc0aStQvlfM0RVJhsaaN4qng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlhedmnecujfgurhephffvufgjfh
    ffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfetff
    efteekkeffkedvheefhfdvudeigeejfffhffeuvdehgfdtueeuhfehjeenucffohhmrghi
    nhepmhgrshhtvghrrdhkhhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R0YNauxeLGGOB5jBrldhcJkV5SACZGywsBJY9-T_pxROck6U3nPR2g>
    <xmx:R0YNajPwglBf_2st92qCrI2jXiOOncmhEySKX5cXxaxlP1YzjsVtzw>
    <xmx:R0YNaiQDKjLyn3z91127nl68qPMOZMpwKV4YbLf4x9zcnkaxrcTNFA>
    <xmx:R0YNahZhehPEGPWyIuEG0kcKS2JSCbXNG0eTngnVcjn3g17iCQ2oxA>
    <xmx:R0YNaoyBLST75c8Yt-mYDaaZiZ0JJUxhFUw3hSwiW3rXsOIpUcb2YFEh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 01:27:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #05)
In-Reply-To: <xmqqo6ia4q03.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	20 May 2026 14:19:24 +0900")
References: <xmqqo6ia4q03.fsf@gitster.g>
Date: Wed, 20 May 2026 14:27:33 +0900
Message-ID: <xmqqbjea4pmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and is a candidate to be in a
> future release).

The following shows status of various topics.  The information
contained there can mechanically be produced from the contents of
the "What's cooking" report I am responding to, but I am sending it
out as an experiment to see if people find it easier to grok to have
something like this near the top as "table of contents", perhaps
before the main report.

------------------------------------------------------------

Comments?
 - cs/subtree-split-recursion                                   03-05          #3
   <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
 - jd/unpack-trees-wo-the-repository                            03-31          #2
   <pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
 - th/promisor-quiet-per-repo                                   04-06          #1
   <20260406183041.783800-1-vikingtc4@gmail.com>
 - mm/line-log-cleanup                                          04-27          #3
   <xmqqfr3xp98b.fsf@gitster.g>
   <pull.2094.git.1777349126.gitgitgadget@gmail.com>
 - ua/push-remote-group                                         05-03          #3
   <20260503153402.1333220-1-usmanakinyemi202@gmail.com>
 - rs/strbuf-add-uint                                           05-12          #4
   <20260512115603.80780-1-l.s.r@web.de>
 - hn/status-pull-advice-qualified                              05-13          #1
   <pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com>
 - mm/doc-word-diff                                             05-13          #1
   <pull.2113.git.1778686956622.gitgitgadget@gmail.com>
 - rs/strbuf-add-oid-hex                                        05-13          #1
   <183aa0fd-d455-4ec9-9c42-d511fac8b3e4@web.de>
 - ps/maintenance-daemonize-lockfix                             05-13          #2
   <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
 - hn/branch-prune-merged                                       05-13          #5
   <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 - ds/path-walk-filters                                         05-13         #14
   <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 - ta/approxidate-noon-fix                                      05-16          #4
   <20260516151540.9611-1-taahol@utu.fi>
 - hn/config-typo-advice                                        05-16          #1
   <pull.2302.v2.git.git.1778935976330.gitgitgadget@gmail.com>
 - ja/doc-synopsis-style-again                                  05-17          #5
   <pull.2117.git.1779049615.gitgitgadget@gmail.com>
 - jt/config-lock-timeout                                       05-17          #1
   <xmqqzf1xbl4i.fsf@gitster.g>
   <20260517132111.1014901-1-joerg@thalheim.io>
 - hn/checkout-track-fetch                                      05-18          #1
   <pull.2301.git.git.1778623888178.gitgitgadget@gmail.com>
   <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
 - mf/revision-max-count-oldest                                 05-18          #1
   <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
 - cc/promisor-auto-config-url-more                             05-19          #9
   <20260519153808.494105-1-christian.couder@gmail.com>

Expecting a reroll.
 - ob/more-repo-config-values                                   04-23          #8
   <CAD=f0L8-_3sDGGkCzF4WA0xmUtaY_qiz__3zq5AemLgwTsqvsg@mail.gmail.com>
   <xmqqlddqu013.fsf@gitster.g>
   <20260423165432.143598-1-belkid98@gmail.com>
 - js/parseopt-subcommand-autocorrection                        04-27         #11
   <xmqqcxz2tzpr.fsf@gitster.g>
   <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>

Need to wait for the base topic.
 - ps/odb-in-memory                                             04-10         #18
   <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>

Needs review.
 - kh/doc-trailers                                              04-13          #9
   <xmqq1pfivfa3.fsf@gitster.g>
   <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
 - lp/repack-propagate-promisor-debugging-info                  04-18          #6
   <xmqqse7xm8av.fsf@gitster.g>
   <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
 - en/ort-harden-against-corrupt-trees                          04-20          #5
   <pull.2096.git.1776731171.gitgitgadget@gmail.com>
 - pw/status-rebase-todo                                        05-01          #2
   <cover.1777648598.git.phillip.wood@dunelm.org.uk>

On hold to help the base topic with wider exposure.
 - jc/neuter-sideband-post-3.0                                  03-05          #2
   <20260305233452.3727126-8-gitster@pobox.com>

Unclassified.
 - ed/check-connected-close-err-fd-2.53                         05-14          #1
   <pull.2303.git.git.1778827194448.gitgitgadget@gmail.com>
 - aj/stash-patch-optimize-temporary-index                      05-19          #1
   <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
 - tb/bitmap-build-performance                                  05-19          #9
   <cover.1779207127.git.me@ttaylorr.com>

Waiting for response(s) to review comment(s).
 - ps/shift-root-in-graph                                       04-27          #1
   <20260513230216.GA1378627@coredump.intra.peff.net>
   <20260427102838.44867-2-pabloosabaterr@gmail.com>
 - st/daemon-sockaddr-fixes                                     05-14          #3
   <agGLRC1ziF5F8Okh@pks.im>
   <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>

Will merge to 'master'.
 + kh/doc-log-decorate-list                                     04-27/05-15    #2
 + za/t2000-modernise-more                                      04-29/05-15    #1
 + mm/git-url-parse                                             05-01/05-15    #8
 + kn/refs-generic-helpers                                      05-04/05-15    #9
 + pw/xdiff-shrink-memory-consumption                           05-04/05-15    #5
 + aw/validate-proxy-url-scheme                                 05-05/05-15    #1
 + jc/ci-enable-expensive                                       05-10/05-15    #2
 + sp/shallow-deepen-on-non-shallow-repo-fix                    05-11/05-15    #1
 + ag/sequencer-remove-unused-struct-member                     05-11/05-17    #1
 + kk/paint-down-to-common-optim                                05-11/05-17    #2
 + jk/dumb-http-alternate-fix                                   05-12/05-17    #1
 + jk/pretty-no-strbuf-presizing                                05-12/05-17    #1
 + mm/diff-U-takes-no-negative-values                           05-12/05-17    #4
 + dk/doc-exclude-is-shared-per-repo                            05-12/05-17    #1
 + tb/pseudo-merge-bugfixes                                     05-11/05-19    #9
 + kk/limit-list-optim                                          05-14/05-19    #1
 + kk/merge-octopus-optim                                       05-11/05-20    #1
 + en/batch-prefetch                                            05-14/05-20    #4
 + jk/apply-leakfix                                             05-15/05-20    #1
 + jk/commit-sign-overflow-fix                                  05-15/05-20    #1
 + pb/doc-diff-format-updates                                   05-15/05-20    #3
 + rs/trailer-fold-optim                                        05-15/05-20    #1
 + ps/t3903-cover-stash-include-untracked                       05-16/05-20    #1

Will merge to 'next'.
 - jt/odb-transaction-write                                     05-14          #7
 - kn/refs-fsck-skip-lock-files                                 05-17          #1
 - jk/connect-service-enum                                      05-18          #1
 - jk/sq-dequote-cleanup                                        05-18          #3
 - rs/use-builtin-add-overflow-explicitly-on-clang              05-18          #2
 - ds/fetch-negotiation-options                                 05-19          #8
 - tb/incremental-midx-part-3.3                                 05-19         #16

Will merge to 'next'?
 - ps/graph-lane-limit                                          03-27          #3
   <bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
   <20260328001113.1275291-1-pabloosabaterr@gmail.com>
 - sa/cat-file-batch-mailmap-switch                             04-15          #1
   <20260416033250.4327-2-siddharthasthana31@gmail.com>
 - pt/fsmonitor-linux                                           04-15         #13
   <xmqqa4u5nnxq.fsf@gitster.g>
   <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
 - cl/conditional-config-on-worktree-path                       05-13          #2
   <2989eb07-2933-4b5a-9e5c-33ef9b805528@gmail.com>
   <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn>
 - jr/bisect-custom-terms-in-output                             05-14          #3
   <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
 - tc/generate-configlist-fix-for-older-ninja                   05-15          #1
   <20260515-toon-fix-almalinux8-v3-1-b545a0647f0f@iotcl.com>
 - ed/check-connected-close-err-fd                              05-16          #1
 - kk/tips-reachable-from-bases-optim                           05-16          #2
   <pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
 - jk/commit-graph-lazy-load-fallback                           05-18          #1
   <20260519050513.GA1635924@coredump.intra.peff.net>
 - ps/setup-wo-the-repository                                   05-19         #18
   <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>

