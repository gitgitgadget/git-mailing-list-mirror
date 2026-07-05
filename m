Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC33C465
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783215486; cv=none; b=sfvFimQRZBIqcAOvBhb3MErh3GV1cf9wzS8lu4GCE+LChIX3uOP/UC0frpdE42WApjQ7qhKKXOcLjdHlOW2TN/4GT5IL2UbdPAN/tSvP7GA4Ny9Fg5++JTkjUuxvy3dZgde+XC3zNaap1E07mV2GupMHm84PUcp94qRydFAhXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783215486; c=relaxed/simple;
	bh=bC4S619+hTIC63itnwnHzODfCGn7QjEl8fy1TOsExw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYhBKOKfs5gTV5J+uxYIPD4sxu1kArqYA+8MJmIGF9tP3cRQnylsPd498GtAaA8d3+CjciJZJWjtcxBolcIl1CaUz+VeejqzkpvDRKmpvwr5r6Hn0yzVdL91mBt/r9eosoGoAr3rTCgh7Pbc+b0TLyTHN2N2pUiZRPCJpJHApAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OLP9EndJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrAMxefb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OLP9EndJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrAMxefb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 81DA21D000A8;
	Sat,  4 Jul 2026 21:38:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 04 Jul 2026 21:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783215484; x=1783301884; bh=LHuQQ8x2bF
	QYtJoryVGhVlNxENkvCUwxk183625zM1U=; b=OLP9EndJPtBU7emMq64bJENm0y
	1gA1jZg3RLYOS5qWdaZ44SEcJj1gAD4IBGPlEfZygXkzh77tdl1fjvIYCfWqcXy/
	iaC5gC/lIkvrZ1nOIGwU412sJWJyO1kfxKRDKQrSySo7fS+1t9cfjTCgwNapG351
	yPs7tv+NRMZT10IHOHnfQE1K+cz5Op7S2sDnBXGdgrO4MK1TmquoD8KlNEg99HeQ
	jlmku2xzxfukoufNnh3/jZA/CrerdlOOqId2Py0/UuIUx1l3mzCOUv1JDSXZYPfK
	2UITaji9WvvUpvTAZkX/qY4Vw1d7hxfKtilFMr7OlgZvlbzkpJHPP6nCP4Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783215484; x=1783301884; bh=LHuQQ8x2bFQYtJoryVGhVlNxENkvCUwxk18
	3625zM1U=; b=TrAMxefbg5hGzzgooFvFb85bMG4LXPn5ir44RdnMGOByeXPjwyp
	Zz8WOldCA9FbASWa3o+H52DMWRhtRz12KDFUiR72ZkM7XMhs7MbO21szMb7JIeHt
	Q46D7Ki52Ft+3xMMMXvS1JS7idx2FCIByGiZUOqPtmBEKyxQuqPbAFH6E95ihFnL
	tKIF9u0SMT9UDIKHjCBQaThNMTMJVPRfBlyzkqmXEVEuEYPaG1JBGeD956TCBMHX
	LeHrCGQU6g9v+vUHX7W3cJXxifN3Q6/ryMNJ9k509LKSIE+3+kuHVj/NE5e3Wv9k
	HvOz/soIcexuaCzcXRMF5hLx1fWwmcKYdgQ==
X-ME-Sender: <xms:fLVJasUHPmhdnbC-9UWPtZfLtZ2LESoFHZSwV61TpvU1UCnMIhiQ3g>
    <xme:fLVJai1Rzht1tiTYbz53Jg5wXAhL29hfdSh2VLRoQuU7-iVKvIRfw_IjsLjKo4368
    XGNZ1WWVrTesrqsRktg7W33EratxIkuhdOrbs4vEisfub73MiEN>
X-ME-Received: <xmr:fLVJairahvpohGZn2GWvQuzHA5KRBz_yQgK1xxfxFVrv8SuIweiA02jowisLdD1Z-GAzKeAlHJQLtx8jFpaz328QWLjeWelMTyRHSdA>
X-ME-Proxy-Cause: dmFkZTFl1P424TMWqfei/Sk8HxuINHNLpWMKiKSI3HCpLZOMZh+TBinsmjTr5nd5XimgIM
    fceu08ZhTHI/eiPGU8ojqdtzBZdnpSxOdyOohyj4ZIXtCGQj3dhWSrosGNcE6lzvOz195/
    8/mRXkSLMezKkwZxHI3YFZhgIyhPM5vkDSR4cP6p29xDgeyBjVhMWp1DeNZjN2LjpRiRu5
    LJ95e8ssoXRG42SY0TevNDF2jERFmWk6z1CBAGPoxQZjIMlWVhuyg3tqlLk8jHJz/iGwNK
    c8w6P/hXttDHkFezXR47xlHpo/66s+MjNio54M/IJusivK2bb5fWzlmRLzDO5KMvlgZFAZ
    Tesww4eSlKAKRgTT5kTZRv9wpwcAeECkWOZeev6gyVuBPmXcwNcIanTPucy3N5vHOEuXRi
    SoFzuJgwYejrGMTG1Y+l4Z5f2popjq+qssQM/SHatCA/QDbSoteAt6BlOPm/q0R/Dl0nUv
    dhyFojljG5Obl2jUCZHAqz1TcXDcCrvG+l7Nth4JZf1d7rOopBJX1u6aqtPPFMQcYfHtbi
    Kv9d6CdzaBhzTrvmh9fm0gfgX9pHx13Rkq/nMIkf93rrEwxoa2bRTSN4RKoHi/Ms1uAlS+
    xjyulYlJf8GQw1ptVtWEWg91rtRYHxrJwlN1KRw9H3e1vTYs29cSji4nrhxQ
X-ME-Proxy: <xmx:fLVJahUO1OzgIr2ECqO3F7TxpfrbvUqV3gaRDHJvFn7XNjMpW8zlBQ>
    <xmx:fLVJalaxAdQDLwqN-B61VOuJHHpHzKefYLynNmSV2zr206uPHTrUcw>
    <xmx:fLVJamcloSsEs64Jca3g1Q7XKWPUibkoXEzR4mpc4bh_Y0dJ95D4Kg>
    <xmx:fLVJan3SBZzxdZFJ6c0E_Lf2qfSf_z5IFXPhhtZ-w98lzl7vgfLbGw>
    <xmx:fLVJarDnFJ66Oq2vYAg5y1MLI8gC4XiaZWa3QTEN5NE7-ZnYmRCkc25O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jul 2026 21:38:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 0/6] t: add greplint.pl and convert grep to test_grep
In-Reply-To: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Fri, 03 Jul 2026 04:54:19
	+0000")
References: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
Date: Sat, 04 Jul 2026 18:38:02 -0700
Message-ID: <xmqqtsqedxmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2:
>
>  * t3420-rebase-autostash: dropped the change to the '! grep dirty file3'
>    line under 'rebase --quit'. As SZEDER pointed out, file3 never exists in
>    the conflicted state, so that grep was passing only because it could not
>    open the file. SZEDER's fix (sg/t3420-do-not-grep-in-missing-file, now in
>    'next') replaces the line with 'test_path_is_missing file3', which is the
>    right check; this series simply leaves that line to his fix.
>
>  * Audited the remaining '# lint-ok' annotations for the same "grep a file
>    that never exists with correctly running Git" gotcha, as Junio suggested.
>    The rule the audit applies: 'grep' becomes 'test_grep' only where its
>    exit code is the assertion; grep that produces data (a filter) or that
>    reads a file whose presence is conditional stays a plain 'grep', because
>    test_grep BUGs on a missing file.
>    
>    * t5537 (.git/shallow): the file is still present after the repack (the
>      client stays shallow), so the assertion is converted to 'test_grep !'
>      like any other; the "may not exist" note was wrong.
>    
>    * t1400 (.git/packed-refs): the file exists only with the files backend.
>      Guarded the packed-refs check with a REFFILES prerequisite; the
>      backend-agnostic 'git show-ref' check that follows still runs under
>      every backend.
>    
>    * t7450 (squatting-clone/d/a/git~2): kept as '! grep' with an improved '#
>      lint-ok'. 'git~2' is the NTFS 8.3 short name of a planted '..git' decoy
>      and only exists when 8.3 short-name generation is enabled. Verified on
>      a Windows VM: with 8.3 disabled (the modern default) the short name is
>      absent, the '! grep' correctly tolerates it, and a plain test_grep
>      would BUG. So this one deliberately stays a missing-file-tolerant grep.
>    
>    * t5326 and t5702 remain annotated: these are genuine data filters (grep
>      produces data that is redirected/captured, not an assertion).

Great.

>      ++   test_grep requires <file> to exist and will BUG otherwise.
>      ++   When a file's presence is conditional (a backend-specific
>      ++   file, or a path that only exists on some platforms, such as
>      ++   an NTFS 8.3 short name), keep a plain guarded 'grep' instead.

It is not quite clear if I can follow this instruction myself,
without knowing what a "plain guarded 'grep'" is, unfortunately.  Is
it different from bog-standard grep?

>      @@ t/t1400-update-ref.sh: test_expect_success "move $m (by HEAD)" '
>        	test_when_finished "git update-ref -d $m" &&
>        	git update-ref -d HEAD $B &&
>       -	! grep "$m" .git/packed-refs &&
>      -+	! grep "$m" .git/packed-refs && # lint-ok: file may not exist (reftable)
>      ++	if test_have_prereq REFFILES
>      ++	then
>      ++		test_grep ! "$m" .git/packed-refs
>      ++	fi &&

The intent is shown very well in this version (admittedly, the
lint-ok comment is readable but only by humans and LLMs).  Here, we
expect .git/packed-refs only while REFFILES prerequiste is active.

Thanks.
