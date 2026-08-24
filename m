Received: from mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126C46AF2D
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589257; cv=none; b=N3Zv2JCuStB8CO65wZrlmCCdOaZGCiV3CXLLPgghwn/JkrjPyGB+r7w2C9EPNo3+Hv14phZ/LTuN1sH1LsN8tENIpS6muWqmPtfFwxZmC+BG6Man6LCQZPjLsG1cg8NDO108rY7fMJVXcakUl8x12EyIL18/f/hSLEUOdzpV9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589257; c=relaxed/simple;
	bh=yp/OJ2wSLw/x3/2rFOghyYgl+e3rUsMbFJsO0SzUqlU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UVQMTJz1vKJveR9dMS7Ht6EpKw1r1Q+iHEOADVPkl9ZaWz1kpbye8LTEYnYt7u5g0dRts8KeEpV8Q/g0lWmiGnG9rk7hD3MgwfbyU8bJoF0C/XzoO0i8pqJvTTSLkaibubWm4UAO3W1EfvU17GxFF3LH4LyIT5hzmYylv3jyxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=GR2XQmuW; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="GR2XQmuW"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yp/OJ2wSLw/x3/2rFOghyYgl+e3rUsMbFJsO0SzUqlU=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787589252; v=1; x=1788194052;
 b=GR2XQmuWto+efKKcFmzHags38i1iO7Jh83r9wzoCaYP5OzbZJX4do7/Df1dyqkdNsTZnXM3b
 GukW3Dm83rkkyvrAwuQOUWIq/KgijQmA85jAfBDW3qanN2ZaUtluTKBJ3j3RtkOZYRp1zQlETY6
 Pt0VVlOORoSfBFNBwnTaaOpwuy7PG3zJCPJqrv6awBReeWEra1Te7zcmdz0SlqqFS8CgZ+7jtzg
 o5ocuDOavTvb9KmCQUyrZFHRjpEQck45odp/CfPsWNplPJlCexd4ok4f6DN4QahnpqL5mfwoFw5
 zIJREPDFVgbYw56bO2k1YIRf6Yft7CZXnc5ACs+CUlXkw==
X-Envelope-To: git@vger.kernel.org
Received: from localhost (117.176.242.187)
	by smtp.migadu.com with ESMTPS id adf8cb945c8385ab;
	Mon, 24 Aug 2026 16:34:02 +0000
X-Mizu-Trace-ID: adf8cb945c8385ab
X-Migadu-Flow: FLOW_OUT
Date: Tue, 25 Aug 2026 00:33:59 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Alexey Samsonov <vonosmas@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
Message-ID: <aoxydzcI0m_y-gsK@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr03qyhk.fsf@gitster.g>
 <xmqqjypfqz9e.fsf@gitster.g>

> Weijie Yuan <wy@wyuan.org> writes:
> 
> > What I was trying to understand is how that fits with the particular DCO
> > concern being discussed here.
> 
> You may never be able to tell where the AI output came from, but you
> can see if the updated code has resemblance to fixes we applied in
> the past to correct similar problems, for example.  After all, you
> yourself without help by AI can copy our code to your patch to
> enhance our code, and that is perfectly legit.
> 
> Take for example 5fe676f448 (t1300: remove global config settings
> injected by test-lib.sh, 2026-04-26) that added
> 
>       test_might_fail git config --global --unset-all safe.bareRepository
> 
> that clearly mimicked the tests that prepared the stage by clearing
> a relevant configuration variable done in an earier 313eec177a
> (safe.directory: allow "lead/ing/path/*" match, 2024-05-29).
> 
> By "sufficient due diligence", what I meant was that I trust Dscho
> well enough that he's done a similar analysis to make sure that he
> is copying from ourselves.

> ... or wrote things using what he learned from other places that are
> OK to copy from (like code of BSD licensed projects).

Ah, I see it clearly now. This could make us able to keep the
provenance of the patch under control.

Thanks so much for taking the time to give me this example and
explanation.  And very sorry for bringing Dscho into the discussion,
sorry.

Apologize for my recklessness.  Thank you very much.
