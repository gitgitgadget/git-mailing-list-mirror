Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6D78F39
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794160; cv=none; b=dKTWSTOwoz8thqfOCwWD3pW8XjHAiwW340DS736pIn9IrkM4M2xnmRJX1GmZHfm3MjZEMaIi555QLiz/k/pGFlPZt4/V1rPhFvKCloqlIFBrzo+0WAW7uF7e52IXoT+hdwPAADFKDSsB2Gs3zEu6CkvIA48dba8ebe3bVmh++wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794160; c=relaxed/simple;
	bh=+ZG7DsjaxXCx2VrgiFJ2J8N/h9fGf1e7cTKk7b4A3Vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qxm0rVaGCQG9mt7cXvCJr9c1EJ30Naw1FaCSI5/vd7czW8wdPCdBQe1b1WeV8rMvZVVHtL+smCa1P83NljwGck+5ZbpNn0TQJbwtbnwOtzU8CNPqRWiIxBWNkjBhEpJF+IG4BfgdTsYgpPJORX7qSxIXcPSetBYY6QTTO3Nbivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gXQcxeKq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eiJI/uPL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gXQcxeKq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eiJI/uPL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B97C71400056;
	Mon,  3 Aug 2026 17:55:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Aug 2026 17:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785794157; x=1785880557; bh=ZgGT5u6WMg
	q9h1Pi+C0e8VpysWbDf4+UKDu+n+9EYGY=; b=gXQcxeKqyP+MtT5VriHjdK/Emj
	M0z43jW2ZvjNmbEAscZPg9FxiYUlY9c88mZuiOlrXaXVqaUd5rmvmB77zsh7LKFO
	X8mWKVL1wQj67an0ZkRsj3PRdh0Ckr9yDkMS3d+sTG9qc+NW9VHy0ILDK2pqccY4
	2dROjYKwKQG7hIjVUyGXinerw8NILy717pmszDJWBWGTZ71qZdkaXoMBCXiXYl0a
	51GDZ3E9o/mD/mqKRyPBoN0w9JzikDoMCQebEQU2ObIMoAvsEOh8eTWqEBpJ3XeH
	9AHAc9C9khPCq1ru9hqWjXiJgXXTjoPV6zPUtSaIxag6621OdzcrngiYjahg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785794157; x=1785880557; bh=ZgGT5u6WMgq9h1Pi+C0e8VpysWbDf4+UKDu
	+n+9EYGY=; b=eiJI/uPLJYhce7KWySgDvkb+aYR3y06Ow5c6BwwDdM21P1+fOjH
	8Gfln8/J7An6ntqEIZJVF0orZQhzCXypF6wj+x/DFSsEK89A6FAt5L3E/Tq/79Jr
	JBjNhv/9EL7z3ZeAMonDusl/pTf7uT0Y/5h6YJXfY0mXr0kNOhGqLn4n3E22kdvU
	s8D6tKllyThFOFUTmksqZfiZ0XkLfWOlfC2j1n32VP1h/X9LWOEQls7KxxvC9wz8
	Yys5gEFTMq+KDeXuzS0Wv3B5Grs/+wC8rVa8mTWlWhRETTM1VcJJvSZqsG3HEaNw
	E04fQ5t+wk9mcN6sLISqaBg8lQSsIjoLtXg==
X-ME-Sender: <xms:bQ5xamgB2k_40BNAlrGPaoCayTh04JOQzw7JOICggDzoyVglXBuBZQ>
    <xme:bQ5xauDJJLyjW865H2W3SpwcOIzLxvySVXZz_GuKjaKspuVP4bHsk-2CTxsDktFdH
    xDB7oPsTjwXS1-FUJ_bgjdl9RbrikwLDfE_aGCT8YiABKbYMITn0bg>
X-ME-Received: <xmr:bQ5xajFCc_FJsaWn72XQoXEPlkYBLw4fbfBmoRZ8iTUSglzCLrhUSrL_Jsc7pumd4A58KRQCvSyUDfWpcjG916WbzYAG4dheiw>
X-ME-Proxy-Cause: dmFkZTE7FV6ZZYK+HRazlVNsViEqVL6PktfWU/JU7VjdCYa88xR32/9RKYO+m1x+rf/6id
    PfaF+CMxujcjsvirRrvZ049wL4vdgoNdppQHi/gjFUlZkbgCVIQJTswM3jxcRgNq0+9rLz
    WwC+pUhv4mrZy1ERp/QQSbR57lo1VN+MhXKxt/viQb32NvmviyS/DC2hffnGhCwfYKjycZ
    Gau7LND1FH9vf+F5n/082HnARqTltj7Yos/HVSCRP7b6TlDwq5xnlzrsD9zo3oJ0igsqI3
    ur9wxiK6PW9U2owXpQ85LLFT9MkhGCnZnP2iKy4xNsCKObT8RPiT73NyiF9gJp1IOebjLc
    uqzUy7/g4NI5pROZgTv4M2cpO/4efQMzJiRflTcdbiZtjAWn8q9xn1EWlUCqcUBUay3hOD
    nahhSbeL/Il4UfJU77hHs2Ns3Lc/Bz7v233ryvstME2CjWK1Kt3zkogCGXaup2lQFjC11P
    AyooLgGkqbQome+cuioH9JEQi2Tw/YiJDVsDjB3gTF/ai3KWMqMOVQa5JIm7iwUyfnxBn+
    Ly0RdJTnHp20prt4osV20dAQM4DuuvSFRDYw6p+NCePCcSBbatOH0q4WMO4kJ1DHBx530P
    AW1AJNY5wTBQxLjaZr0hzMpmPuTR+Wmv8vhO0OfEwjh8V7A9LeCmU27U8xfA
X-ME-Proxy: <xmx:bQ5xauJC17dQuS-xKLV4at-E-BZmW96UfANYos5EdOsAK-oOmbbS4w>
    <xmx:bQ5xavm7V_45nrH3cDklpt61KUfk-wTCXoHJ7eA3K6Yd5lQGjYOJeg>
    <xmx:bQ5xauQMX6S9VSZFjLo99s9HXV7RQvguhty8VWkh5eVy2gBQjoRIUg>
    <xmx:bQ5xapJoKITnuHWYk0NQbyWosCfiRurVzByj1qpfHGeVZFQHbsCLaA>
    <xmx:bQ5xaqmvGwHilCpZQBkLzw76OJ4sK6bEKfJU7ybCuBwdQ0MApu5rMiOT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 17:55:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
In-Reply-To: <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Fri, 10 Jul 2026 17:30:54
	+0000")
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
Date: Mon, 03 Aug 2026 14:55:55 -0700
Message-ID: <xmqq4ihayil0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Each fix is local: claim/consume the one-shot marker with an atomic rename,
> and elect the first request with an atomic mkdir, rather than a "test -f"
> followed by a separate remove or touch.
>
>  * Patch 1 fixes apply-one-time-script.sh (the actual flake) and adds t5567,
>    which drives the helper directly with no web server so the overlap can be
>    forced deterministically.
>  * Patch 2 makes http-429.sh atomic.
>  * Patch 3 documents the atomic idioms generally in t/README (they are not
>    specific to CGI or HTTP), citing Git's own lockfile machinery and
>    make_symlink(), with a pointer from the lib-httpd list.

I was scanning the "What's cooking" report for topics marked as
"Needs review" to see if I could find ones that are relatively easy
to validate, and I hit this one.

The key change [1/3] is well thought out and nicely done.  [2/3] is
explained better than the corresponding step in v1, and [3/3] adds
helpful tips to the t/README documentation.  They all look quite
good.

Thanks.
