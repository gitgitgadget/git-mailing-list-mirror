Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9D2475D0
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426859; cv=none; b=CuyvME+g2WYL8dQYIlkMJ3h77cbG04MZFGSBFI3Jftrn09V62T6PgLBWPpomrSaFQi58dlrbZ77p2xwMUaCVdyPXOo6rzCtWgpK33dZpjAe5KhnFznpCnuOU6f9FtPSRGMc9zbwlCHcQhGxPCADQH7X2ccN+HNAEzhFg3fMrxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426859; c=relaxed/simple;
	bh=lRXKK3B9ofr+5obBhqKh9rg+Obn3CgLFSeFQBuvT+aY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etB+F7v/BZWq+bGhgEbxbCbuqbRU1TgNLcZCGKGdL0B0xuMvaToQ4zbSSggWWK5dtmLqkNj393A5g5FgDvK/yq+mpZ6/2cLOAgzU7gf+9wc0FSJoTpsBNF/aQiHWBFTIRHRelsEcsu24UiRlMNuEwIGysgBxOCd6Wv/PyQDMWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xTgx/x7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRCZ0x7o; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xTgx/x7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRCZ0x7o"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B26B7A00F4;
	Fri,  6 Feb 2026 20:14:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 20:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770426857; x=1770513257; bh=nkxVA4Tg8V
	4s6axTbKESXynLjAjIfvjlU/d9zLTq20I=; b=xTgx/x7Wb2Z/wLxtO8GcUD74WG
	H9l6j6Ba7X6nCo/jJ4OH7OQjFJT9E7fh1atiEtvWzWRGO6BHaH+AKE3ylGtGXVKW
	D+z4dWUVw9iOg8sbk2Y0E08UDFFMWP9ipb8URDmGlQrLMoCZn+0CCUT3eUSJVA6u
	S3totKmi1m5+kv5sq/05ogEElOvQULlfipx11qE0Jd3N8IbNEtNo3Z1FYl6VRkBc
	CHuVuRENLRQZNf5QzOBUEcHu66iAxZHKGDR4Lum3RkyobRi4tiAEbInIJoDbMtfH
	jHOPjZlaV1pZLq2bV0ngKHXJQHq2VRvIsk/QMskCS28yrvsKSMUXT7quNj5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770426857; x=1770513257; bh=nkxVA4Tg8V4s6axTbKESXynLjAjIfvjlU/d
	9zLTq20I=; b=BRCZ0x7oDdOAiax3CsJMkLjwLQIZjZ5G8hSaaaYjsvBRTI4WCtC
	5pE0JKC1gjYSYNUxMrOq59sAqPqjj/+3UFoMsPPL/Z/tAdaxL17vhskwT+ohUjAS
	t/jwjq6rQa+LtVXpRZRsaP5l3r8Gygl5N4lUse3eDp1kG0nMjq1Sdc2z7KSQrKbe
	M6Uv6X43TbXEQFwuUA+VP8/4iMAtjfEVuUyLv2O1IFirmnjv+p+RG9Ep/+L54jht
	b/p9Z6b27k8LTGaRZL+UHZGrj3OgWPvp94RioNExuDW/vrgKXcTN6r6njz5X7UPL
	TsWPp/KnLsMg2ssVfYdF+gdwpWDcPspY15w==
X-ME-Sender: <xms:6JGGaWdQbLnA-M_9Ij4ZUfSO8g9HdE-_cBr_6v1Z1_g0-goYMoMtow>
    <xme:6JGGacysGizvk7ZdGZ3h96GyEDpw6gtgPH0bj2DcdrVM7AalnDvuxBA5WV6Jvfe4E
    H7LrTqlUZ3_TF0vkXfi9tLq5Svc8WNxxxGPxVWSGa2Wkngb5dCzow>
X-ME-Received: <xmr:6JGGab8TUWa2HKPifZhinVxCGMVNVlqtb_kVpCWM3JJmqCds2MlehXu3uCgMhWgXkfTdChFGV0gyw2kdURJQwLVl4VX5va7hOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhk
    ihguleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhs
    mhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrg
    hrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:6JGGaawDzG4G7hYfnyOnD2vUqnPMN5vZNePAoggfj8aMTY9AwpyaHQ>
    <xmx:6JGGaTrw116SmGT-3j2TaY-OEkAGGvm_bhhXrsFVV6EPHoB7akGqyg>
    <xmx:6JGGaTrcP_7I7p8x5jq4eCuPOOQn_IpHXyySkVs-jqzvrH2SIyRg-A>
    <xmx:6JGGabBJRYZ3ae9zzVTLAQK5S9mOdSwpS2cL7gELIsxh-R1IPvRC1A>
    <xmx:6ZGGabAy0I_q_GL8PFRdoEjoeMIpzkWkN20h4eaFgfK-l56G2SJMaSBO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 20:14:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
In-Reply-To: <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Tue, 3 Feb 2026 16:42:09 +0100")
References: <cover.1770127568.git.belkid98@gmail.com>
	<7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
Date: Fri, 06 Feb 2026 17:14:15 -0800
Message-ID: <xmqq7bspcq3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
>  attr.c        |  7 ++++---
>  environment.c | 12 +++++++++---
>  environment.h | 11 ++++++++++-
>  repository.c  | 12 ++++++++++++
>  repository.h  |  7 +++++++
>  5 files changed, 42 insertions(+), 7 deletions(-)

I bisected our recent CI failures that break fuzz smoke test down to
this change.

$ make -j32 \
            NO_CURL=NoThanks \
            CC=clang \
            FUZZ_CXX=clang++ \
            CFLAGS="-fsanitize=fuzzer-no-link,address" \
            LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
            fuzz-all >/dev/null &&
$ oss-fuzz/fuzz-commit-graph -verbosity=0 -runs=1

INFO: Running with entropic power schedule (0xFF, 100).
INFO: -max_len is not provided; libFuzzer will not generate inputs larger than 4096 bytes
INFO: A corpus is not provided, starting from an empty corpus
BUG: repository.c:63: repository initialized already
==2050473== ERROR: libFuzzer: deadly signal
    #0 0x56169aaf4065 in __sanitizer_print_stack_trace (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x32a065) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #1 0x56169aa4835c in fuzzer::PrintStackTrace() (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x27e35c) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #2 0x56169aa2d2d7 in fuzzer::Fuzzer::CrashCallback() (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x2632d7) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #3 0x7fb4c6f59def  (/lib/x86_64-linux-gnu/libc.so.6+0x3fdef) (BuildId: 61e1dea1f540b3b4b4d8ec76716e409cec096ece)
    #4 0x7fb4c6fae95b in __pthread_kill_implementation nptl/pthread_kill.c:43:17
    #5 0x7fb4c6f59cc1 in raise signal/../sysdeps/posix/raise.c:26:13
    #6 0x7fb4c6f424ab in abort stdlib/abort.c:73:3
    #7 0x56169ae91316 in BUG_vfl usage.c
    #8 0x56169ae8f527 in BUG_fl (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x6c5527) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #9 0x56169ad79d07 in initialize_repository (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x5afd07) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #10 0x56169ab2c4e2 in LLVMFuzzerTestOneInput (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x3624e2) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #11 0x56169aa2e9da in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x2649da) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #12 0x56169aa2dfe9 in fuzzer::Fuzzer::RunOne(unsigned char const*, unsigned long, bool, fuzzer::InputInfo*, bool, bool*) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x263fe9) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #13 0x56169aa2fdaf in fuzzer::Fuzzer::ReadAndExecuteSeedCorpora(std::vector<fuzzer::SizedFile, std::allocator<fuzzer::SizedFile>>&) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x265daf) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #14 0x56169aa30390 in fuzzer::Fuzzer::Loop(std::vector<fuzzer::SizedFile, std::allocator<fuzzer::SizedFile>>&) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x266390) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #15 0x56169aa1cb65 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x252b65) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #16 0x56169aa48ec6 in main (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x27eec6) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
    #17 0x7fb4c6f43ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #18 0x7fb4c6f43d64 in __libc_start_main csu/../csu/libc-start.c:360:3
    #19 0x56169aa10ec0 in _start (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x246ec0) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)

NOTE: libFuzzer has rudimentary signal handlers.
