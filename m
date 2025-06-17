Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1E2E7F1D
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172974; cv=none; b=GUEuDHOvyu0rUX7GmQjbeAkj7l+FUQf5QCIjifudMIfzlTbMSsX1E0OCYvEaCX6p1T8apj6gmeEJLLJJmn6AC2vna1efJJ0MJ/nWVD02cDGBusvoEIw6HBD4KJusfY9r2czqZG8yxlZYy+Oy0OzERaBszdi2cZuQm8KJFTJQLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172974; c=relaxed/simple;
	bh=Yq/82NAlCZyxLTL1EJFWz1BwhpuDPZttxQYnglZmwBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bS5qSHj8HSqwtnMQmEFpR4hoOvtLC987hHdkVjKYxIpgvC/32580rAoVW1vrGPY94+hoQuVb4dqKDsKjqEtMXUjnrLbH9ex/rjQTaJP9C5z2nBqSb/EFhCfHsnaUsqUKZLs1UApR6i1kFYtHpkINqAygaMRihTkIyfiABPo3jcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lnPaeZG+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OSTEch1W; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lnPaeZG+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OSTEch1W"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 968B711400D2;
	Tue, 17 Jun 2025 11:09:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 17 Jun 2025 11:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750172970; x=1750259370; bh=jMeiJU7xNO
	HG7rkRyJBKPvZ0955fokO7QfSKjE8FfDw=; b=lnPaeZG+D8IXUKFGE6jKselM66
	jatO9BTn65Kp3mAKzObVTsb2zaCZspnYViDAEcnuLVmLHwhk6xyRESSGtcurcSpX
	wcbLP2XLkGhYFTH9cJvIqmd5FcpXOU1Yeykp+n5yacXPXGo1BTM1gjMEvE/g+59X
	2QImcju2GW9yESQ7EQQb7Adz9C+B/JkuzA57j6TEGGDPJ6489nvWV4gTcBTtz/MR
	TM2Sqtq8Mlan8BI5340vBmI1RoMT6144+g0BLv1liBam0JwlpoRKKpOCAPDXC98J
	6UB6bzVLb8VR16J8BMbvPVsij9t4Q3dL9mLWDGaw5In23eqFnQkVFu0VNMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750172970; x=1750259370; bh=jMeiJU7xNOHG7rkRyJBKPvZ0955fokO7QfS
	KjE8FfDw=; b=OSTEch1WNy0BqGu5W9GcaSQpImT21BWSreyndTRmQT3cHvRPvKC
	g5pZsm8gaGU/Q5j61gOlu8ZWMtrk53UnST1tvgZRxWAZ9h7bzOkHYfzVOpTkh/BI
	+5TfYjkbLSu087RYLj6y5NycwRIrm8fA6gu8ygufOu/rIZfMWXarogZ+9x1thl3z
	UnyN26IBDWeo1mgNTM0wQQJcLBI8j94EPRrX29F2jX52AtT5jxnGRbovpK1ynGOA
	U6ZBM5L+/baMuvPKiw5boDGjpjw9ugY7nIXq2pn6S7YibyFDGuuWLM51BLQZib7D
	wc5XUUt9wbWyvBBbBEIuyzz0HUl+VO6MCPg==
X-ME-Sender: <xms:KoVRaAjZoAB6a_BUoAiL3Q7ZtOJ3dRSI-8PwCJOu4c8Z3DOhbzAD3A>
    <xme:KoVRaJC0zxL3Kd-bSq6969BtCVv0mPcxpw4aEDN1TxkrJXVOvBmf2L1HOeNsuuy_8
    F2IRiulELdkx-I7oQ>
X-ME-Received: <xmr:KoVRaIGZyerp0fMl023vbABa68fEpEkKNvBKXULl-gW9AKvJXbZUL0LJoaP0G_ySfW3abKO6odMrp9xRne6nDm5xTcHrUQM4u9JK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvg
    hllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:KoVRaBSuj73_rDUcjgJ4Kf0JIn7vQ-lEmH6SwkfrrNFDQNY9j5jbtA>
    <xmx:KoVRaNzaRtvXTJ3TxrARCv4U2nDieagjmCre_pit1J4cr9_6UAs8MA>
    <xmx:KoVRaP5zgxE_YXJ_RorG9eh16UtJJ3Yehb-1pN9z3lkcsklxlzl64w>
    <xmx:KoVRaKwo9DN4POD1RRrlLFKuAvaPN7GShh1swznCwS6PUnJPF3kjsw>
    <xmx:KoVRaBPscSSIzzJCoxDCXNkt2paMto_1DG3EZ4tFv9ozFCm5W0hNEcGL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 11:09:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH 0/6] submodule: improve remote lookup logic
In-Reply-To: <83af9bc9-7884-4ce8-a343-28dbcded7954@intel.com> (Jacob Keller's
	message of "Mon, 16 Jun 2025 16:20:33 -0700")
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
	<f16e09e8-55f8-4fb7-825d-fe4c9b049d1c@intel.com>
	<xmqqbjqnz4ve.fsf@gitster.g>
	<83af9bc9-7884-4ce8-a343-28dbcded7954@intel.com>
Date: Tue, 17 Jun 2025 08:09:28 -0700
Message-ID: <xmqq4iwexv4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> On 6/16/2025 3:41 PM, Junio C Hamano wrote:
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>> 
>>> Seems like there hasn't been any interest in this series? :(
>> 
>> So far it seems, but we have been in pre-release freeze for a few
>> weeks combined with slower summer (in northern hemisphere anyway)
>> season, so it might have just been a bad timing.
>
> Oh true. I can resend once release freeze ends :)

Before doing so, can you run with leaksanitizer?  When merged to
'jch', many tests fail and t1013-read-tree-submodule.sh #52 is one
of them.

Thanks.

not ok 52 - git_test_func: modified submodule does not update submodule work tree to invalid commit
#
#                       prolog &&
#                       reset_work_tree_to add_sub1 &&
#                       (
#                               cd submodule_update &&
#                               git branch -t invalid_sub1 origin/invalid_sub1 &&
#                               $command invalid_sub1 &&
#                               test_superproject_content origin/invalid_sub1 &&
#                               test_submodule_content sub1 origin/add_sub1 &&
#                               test_must_fail git submodule update &&
#                               test_submodule_content sub1 origin/add_sub1
#                       )
#
1..52

=================================================================
==git==1541109==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 768 byte(s) in 1 object(s) allocated from:
    #0 0x561ea1a821c7 in realloc (git+0x8a1c7) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)
    #1 0x561ea1da4126 in xrealloc wrapper.c:140:8
    #2 0x561ea1d181a8 in refspec_append refspec.c:209:2
    #3 0x561ea1d1e698 in handle_config remote.c:506:3
    #4 0x561ea1bf7878 in configset_iter config.c:2140:7
    #5 0x561ea1bf775a in repo_config config.c:2519:2
    #6 0x561ea1d195fd in read_config remote.c:615:2
    #7 0x561ea1d1b6ba in repo_remote_from_url remote.c:1794:2
    #8 0x561ea1b8ae07 in repo_get_default_remote builtin/submodule--helper.c:54:29
    #9 0x561ea1b8d475 in get_default_remote_submodule builtin/submodule--helper.c:135:8
    #10 0x561ea1b8d789 in fetch_in_submodule builtin/submodule--helper.c:2355:10
    #11 0x561ea1b8d98e in run_update_procedure builtin/submodule--helper.c:2481:7
    #12 0x561ea1b8c7b8 in update_submodule builtin/submodule--helper.c:2700:9
    #13 0x561ea1b8ba35 in update_submodules builtin/submodule--helper.c:2784:10
    #14 0x561ea1b87097 in module_update builtin/submodule--helper.c:2924:8
    #15 0x561ea1b84b9d in cmd_submodule__helper builtin/submodule--helper.c:3646:9
    #16 0x561ea1a86cfb in run_builtin git.c:480:11
    #17 0x561ea1a858a0 in handle_builtin git.c:746:9
    #18 0x561ea1a866a8 in run_argv git.c:813:4
    #19 0x561ea1a8562b in cmd_main git.c:953:19
    #20 0x561ea1ba41da in main common-main.c:9:11
    #21 0x7f60975e6ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #22 0x7f60975e6d64 in __libc_start_main csu/../csu/libc-start.c:360:3
    #23 0x561ea1a52210 in _start (git+0x5a210) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)

DEDUP_TOKEN: __interceptor_realloc--xrealloc--refspec_append--handle_config--configset_iter--repo_config--read_config--repo_remote_from_url--repo_get_default_remote--get_default_remote_submodule--fetch_in_submodule--run_update_procedure--update_submodule--update_submodules--module_update--cmd_submodule__helper--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main--_start
Direct leak of 192 byte(s) in 1 object(s) allocated from:
    #0 0x561ea1a821c7 in realloc (git+0x8a1c7) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)
    #1 0x561ea1da4126 in xrealloc wrapper.c:140:8
    #2 0x561ea1d1edb4 in add_merge remote.c:177:2
    #3 0x561ea1d1e23c in handle_config remote.c:432:4
    #4 0x561ea1bf7878 in configset_iter config.c:2140:7
    #5 0x561ea1bf775a in repo_config config.c:2519:2
    #6 0x561ea1d195fd in read_config remote.c:615:2
    #7 0x561ea1d1b6ba in repo_remote_from_url remote.c:1794:2
    #8 0x561ea1b8ae07 in repo_get_default_remote builtin/submodule--helper.c:54:29
    #9 0x561ea1b8d475 in get_default_remote_submodule builtin/submodule--helper.c:135:8
    #10 0x561ea1b8d789 in fetch_in_submodule builtin/submodule--helper.c:2355:10
    #11 0x561ea1b8d98e in run_update_procedure builtin/submodule--helper.c:2481:7
    #12 0x561ea1b8c7b8 in update_submodule builtin/submodule--helper.c:2700:9
    #13 0x561ea1b8ba35 in update_submodules builtin/submodule--helper.c:2784:10
    #14 0x561ea1b87097 in module_update builtin/submodule--helper.c:2924:8
    #15 0x561ea1b84b9d in cmd_submodule__helper builtin/submodule--helper.c:3646:9
    #16 0x561ea1a86cfb in run_builtin git.c:480:11
    #17 0x561ea1a858a0 in handle_builtin git.c:746:9
    #18 0x561ea1a866a8 in run_argv git.c:813:4
    #19 0x561ea1a8562b in cmd_main git.c:953:19
    #20 0x561ea1ba41da in main common-main.c:9:11
    #21 0x7f60975e6ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #22 0x7f60975e6d64 in __libc_start_main csu/../csu/libc-start.c:360:3
    #23 0x561ea1a52210 in _start (git+0x5a210) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)

DEDUP_TOKEN: __interceptor_realloc--xrealloc--add_merge--handle_config--configset_iter--repo_config--read_config--repo_remote_from_url--repo_get_default_remote--get_default_remote_submodule--fetch_in_submodule--run_update_procedure--update_submodule--update_submodules--module_update--cmd_submodule__helper--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main--_start
Indirect leak of 36 byte(s) in 1 object(s) allocated from:
    #0 0x561ea1a81d3d in malloc (git+0x89d3d) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)
    #1 0x7f60976667a9 in strdup string/strdup.c:42:15
    #2 0x561ea1da3e14 in xstrdup wrapper.c:43:14
    #3 0x561ea1d17f2b in refspec_item_init refspec.c:160:14
    #4 0x561ea1d17ef1 in refspec_item_init_fetch refspec.c:166:9
    #5 0x561ea1d180dd in refspec_append refspec.c:203:9
    #6 0x561ea1d1e698 in handle_config remote.c:506:3
    #7 0x561ea1bf7878 in configset_iter config.c:2140:7
    #8 0x561ea1bf775a in repo_config config.c:2519:2
    #9 0x561ea1d195fd in read_config remote.c:615:2
    #10 0x561ea1d1b6ba in repo_remote_from_url remote.c:1794:2
    #11 0x561ea1b8ae07 in repo_get_default_remote builtin/submodule--helper.c:54:29
    #12 0x561ea1b8d475 in get_default_remote_submodule builtin/submodule--helper.c:135:8
    #13 0x561ea1b8d789 in fetch_in_submodule builtin/submodule--helper.c:2355:10
    #14 0x561ea1b8d98e in run_update_procedure builtin/submodule--helper.c:2481:7
    #15 0x561ea1b8c7b8 in update_submodule builtin/submodule--helper.c:2700:9
    #16 0x561ea1b8ba35 in update_submodules builtin/submodule--helper.c:2784:10
    #17 0x561ea1b87097 in module_update builtin/submodule--helper.c:2924:8
    #18 0x561ea1b84b9d in cmd_submodule__helper builtin/submodule--helper.c:3646:9
    #19 0x561ea1a86cfb in run_builtin git.c:480:11
    #20 0x561ea1a858a0 in handle_builtin git.c:746:9
    #21 0x561ea1a866a8 in run_argv git.c:813:4
    #22 0x561ea1a8562b in cmd_main git.c:953:19
    #23 0x561ea1ba41da in main common-main.c:9:11
    #24 0x7f60975e6ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #25 0x7f60975e6d64 in __libc_start_main csu/../csu/libc-start.c:360:3
    #26 0x561ea1a52210 in _start (git+0x5a210) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)

DEDUP_TOKEN: __interceptor_malloc--strdup--xstrdup--refspec_item_init--refspec_item_init_fetch--refspec_append--handle_config--configset_iter--repo_config--read_config--repo_remote_from_url--repo_get_default_remote--get_default_remote_submodule--fetch_in_submodule--run_update_procedure--update_submodule--update_submodules--module_update--cmd_submodule__helper--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main--_start
Indirect leak of 22 byte(s) in 1 object(s) allocated from:
    #0 0x561ea1a81d3d in malloc (git+0x89d3d) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)
    #1 0x561ea1da3e92 in do_xmalloc wrapper.c:55:8
    #2 0x561ea1da3f94 in do_xmallocz wrapper.c:89:8
    #3 0x561ea1da3f26 in xmallocz wrapper.c:97:9
    #4 0x561ea1da3ff8 in xmemdupz wrapper.c:113:16
    #5 0x561ea1da4077 in xstrndup wrapper.c:119:9
    #6 0x561ea1d19118 in parse_refspec refspec.c:55:15
    #7 0x561ea1d17f46 in refspec_item_init refspec.c:161:9
    #8 0x561ea1d17ef1 in refspec_item_init_fetch refspec.c:166:9
    #9 0x561ea1d180dd in refspec_append refspec.c:203:9
    #10 0x561ea1d1e698 in handle_config remote.c:506:3
    #11 0x561ea1bf7878 in configset_iter config.c:2140:7
    #12 0x561ea1bf775a in repo_config config.c:2519:2
    #13 0x561ea1d195fd in read_config remote.c:615:2
    #14 0x561ea1d1b6ba in repo_remote_from_url remote.c:1794:2
    #15 0x561ea1b8ae07 in repo_get_default_remote builtin/submodule--helper.c:54:29
    #16 0x561ea1b8d475 in get_default_remote_submodule builtin/submodule--helper.c:135:8
    #17 0x561ea1b8d789 in fetch_in_submodule builtin/submodule--helper.c:2355:10
    #18 0x561ea1b8d98e in run_update_procedure builtin/submodule--helper.c:2481:7
    #19 0x561ea1b8c7b8 in update_submodule builtin/submodule--helper.c:2700:9
    #20 0x561ea1b8ba35 in update_submodules builtin/submodule--helper.c:2784:10
    #21 0x561ea1b87097 in module_update builtin/submodule--helper.c:2924:8
    #22 0x561ea1b84b9d in cmd_submodule__helper builtin/submodule--helper.c:3646:9
    #23 0x561ea1a86cfb in run_builtin git.c:480:11
    #24 0x561ea1a858a0 in handle_builtin git.c:746:9
    #25 0x561ea1a866a8 in run_argv git.c:813:4
    #26 0x561ea1a8562b in cmd_main git.c:953:19
    #27 0x561ea1ba41da in main common-main.c:9:11

DEDUP_TOKEN: __interceptor_malloc--do_xmalloc--do_xmallocz--xmallocz--xmemdupz--xstrndup--parse_refspec--refspec_item_init--refspec_item_init_fetch--refspec_append--handle_config--configset_iter--repo_config--read_config--repo_remote_from_url--repo_get_default_remote--get_default_remote_submodule--fetch_in_submodule--run_update_procedure--update_submodule--update_submodules--module_update--cmd_submodule__helper--run_builtin--handle_builtin--run_argv--cmd_main--main
Indirect leak of 18 byte(s) in 1 object(s) allocated from:
    #0 0x561ea1a81d3d in malloc (git+0x89d3d) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)
    #1 0x7f60976667a9 in strdup string/strdup.c:42:15
    #2 0x561ea1da3e14 in xstrdup wrapper.c:43:14
    #3 0x561ea1d1e22d in handle_config remote.c:432:22
    #4 0x561ea1bf7878 in configset_iter config.c:2140:7
    #5 0x561ea1bf775a in repo_config config.c:2519:2
    #6 0x561ea1d195fd in read_config remote.c:615:2
    #7 0x561ea1d1b6ba in repo_remote_from_url remote.c:1794:2
    #8 0x561ea1b8ae07 in repo_get_default_remote builtin/submodule--helper.c:54:29
    #9 0x561ea1b8d475 in get_default_remote_submodule builtin/submodule--helper.c:135:8
    #10 0x561ea1b8d789 in fetch_in_submodule builtin/submodule--helper.c:2355:10
    #11 0x561ea1b8d98e in run_update_procedure builtin/submodule--helper.c:2481:7
    #12 0x561ea1b8c7b8 in update_submodule builtin/submodule--helper.c:2700:9
    #13 0x561ea1b8ba35 in update_submodules builtin/submodule--helper.c:2784:10
    #14 0x561ea1b87097 in module_update builtin/submodule--helper.c:2924:8
    #15 0x561ea1b84b9d in cmd_submodule__helper builtin/submodule--helper.c:3646:9
    #16 0x561ea1a86cfb in run_builtin git.c:480:11
    #17 0x561ea1a858a0 in handle_builtin git.c:746:9
    #18 0x561ea1a866a8 in run_argv git.c:813:4
    #19 0x561ea1a8562b in cmd_main git.c:953:19
    #20 0x561ea1ba41da in main common-main.c:9:11
    #21 0x7f60975e6ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #22 0x7f60975e6d64 in __libc_start_main csu/../csu/libc-start.c:360:3
    #23 0x561ea1a52210 in _start (git+0x5a210) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)

DEDUP_TOKEN: __interceptor_malloc--strdup--xstrdup--handle_config--configset_iter--repo_config--read_config--repo_remote_from_url--repo_get_default_remote--get_default_remote_submodule--fetch_in_submodule--run_update_procedure--update_submodule--update_submodules--module_update--cmd_submodule__helper--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main--_start
Indirect leak of 13 byte(s) in 1 object(s) allocated from:
    #0 0x561ea1a81d3d in malloc (git+0x89d3d) (BuildId: 8e698d3663135d471ee5cb682ce22cd9ec7b4322)
    #1 0x561ea1da3e92 in do_xmalloc wrapper.c:55:8
    #2 0x561ea1da3f94 in do_xmallocz wrapper.c:89:8
    #3 0x561ea1da3f26 in xmallocz wrapper.c:97:9
    #4 0x561ea1da3ff8 in xmemdupz wrapper.c:113:16
    #5 0x561ea1da4077 in xstrndup wrapper.c:119:9
    #6 0x561ea1d1923b in parse_refspec refspec.c:73:15
    #7 0x561ea1d17f46 in refspec_item_init refspec.c:161:9
    #8 0x561ea1d17ef1 in refspec_item_init_fetch refspec.c:166:9
    #9 0x561ea1d180dd in refspec_append refspec.c:203:9
    #10 0x561ea1d1e698 in handle_config remote.c:506:3
    #11 0x561ea1bf7878 in configset_iter config.c:2140:7
    #12 0x561ea1bf775a in repo_config config.c:2519:2
    #13 0x561ea1d195fd in read_config remote.c:615:2
    #14 0x561ea1d1b6ba in repo_remote_from_url remote.c:1794:2
    #15 0x561ea1b8ae07 in repo_get_default_remote builtin/submodule--helper.c:54:29
    #16 0x561ea1b8d475 in get_default_remote_submodule builtin/submodule--helper.c:135:8
    #17 0x561ea1b8d789 in fetch_in_submodule builtin/submodule--helper.c:2355:10
    #18 0x561ea1b8d98e in run_update_procedure builtin/submodule--helper.c:2481:7
    #19 0x561ea1b8c7b8 in update_submodule builtin/submodule--helper.c:2700:9
    #20 0x561ea1b8ba35 in update_submodules builtin/submodule--helper.c:2784:10
    #21 0x561ea1b87097 in module_update builtin/submodule--helper.c:2924:8
    #22 0x561ea1b84b9d in cmd_submodule__helper builtin/submodule--helper.c:3646:9
    #23 0x561ea1a86cfb in run_builtin git.c:480:11
    #24 0x561ea1a858a0 in handle_builtin git.c:746:9
    #25 0x561ea1a866a8 in run_argv git.c:813:4
    #26 0x561ea1a8562b in cmd_main git.c:953:19
    #27 0x561ea1ba41da in main common-main.c:9:11

DEDUP_TOKEN: __interceptor_malloc--do_xmalloc--do_xmallocz--xmallocz--xmemdupz--xstrndup--parse_refspec--refspec_item_init--refspec_item_init_fetch--refspec_append--handle_config--configset_iter--repo_config--read_config--repo_remote_from_url--repo_get_default_remote--get_default_remote_submodule--fetch_in_submodule--run_update_procedure--update_submodule--update_submodules--module_update--cmd_submodule__helper--run_builtin--handle_builtin--run_argv--cmd_main--main
SUMMARY: LeakSanitizer: 1049 byte(s) leaked in 6 allocation(s).
Our logs revealed a memory leak...



