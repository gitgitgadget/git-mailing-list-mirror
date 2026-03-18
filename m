Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA733C1B7
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853948; cv=none; b=sxU4F8y47BRjwOABbfI+QGzECuwT8dEFJp55ZAhqicS6wBix6zhFbBHvX1Ackx5rQMWuyvzUlmpGXF5DyG2fUP4g75qk9UnqvqnUAVUmvAwN71ubILRauOMs9okRwdvR2vqDRr+Pu/jz3UZUSQGfdwF4890qiw09eXGH73gs04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853948; c=relaxed/simple;
	bh=ev5y+MfniqVyFC/oKhrtEAnhkG3mMV/QpEa9RBM2sos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7P3NSR7mfKaWhWLkGjPpRazxTQzhM+drdL0PGV4B/5sgoM78ZWxb1PsIxUS44wGhikO2OSSF0qUrCoqBSM5wzPhEEneNPfagbsv6GDzDAuqaSxDEA/K1e0N5lv01cUcy+C7o0UqJ5OKurxcP/ds+e2KoX+lzxcP5iQDxe7teog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lf7hxKnW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvqWwUFk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lf7hxKnW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvqWwUFk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F805EC011A;
	Wed, 18 Mar 2026 13:12:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 13:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773853945;
	 x=1773940345; bh=+FDJDUbGOBtfb9VDHM1KsO3E9kzezM536pzxSP14e1U=; b=
	Lf7hxKnW0WNzaJVwV47eMJmGWTtajrdtglfPibWQGc5CH6xVcPKSCb+vRuA4c7sG
	Qw5KjFx49VssIoYH0uIvKN9f+6ltQR/P92g/etWN30mkhFbZG4sJxY4bzwtxBKu7
	R6qOFI7+DEQgTOBQ3cyS5upCQGfPb23wcjADnGoT3nZMTUSKFnArDQW8I0iZNFxW
	5JEJDIVSfrdYXims85w9p6KV3G2QcDAr106ekDPbRJ1/VJNBzebwsWBd11rUgVC4
	h5+cH0wEP3+Yoyg+kWOUNcgnegBjlAXp9fyESjMUXZgojR1nQ/k36cEQ8BjxveLN
	1mdit14Rb5Y/sK/8AvP6/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773853945; x=
	1773940345; bh=+FDJDUbGOBtfb9VDHM1KsO3E9kzezM536pzxSP14e1U=; b=Y
	vqWwUFkH6LRggZ6bMtw64jPwooy38PV7eKCYg/l+cwZG98f2qsBd8/ANTzBebnn5
	rzvdtO2sphMSG65SEcy/r2lRAU7cB6C3kQ6eNi7G6RRM20C85H+XJmNUdUjiSIrM
	q2U6xKuB2QG3F+Gsg+kJSv5Xk6jXBVDGsYpQCtSeHJVbD4DACJ7GP9Fm6p7u44s7
	tVbR8VAL5qpL/LMT0VV9XUai3QNKK+DnBBbP8pTb92g95MDIgXio6GI/pLh6ltTU
	T5J5kBigzKaYc8bPMEeqJ4qLBv2BPvUjg6sl92K2VcLtHExeQIGdgdR0kVG/+sy2
	y0zkplceryvmNV7cQKdvA==
X-ME-Sender: <xms:-dy6abUgiwjt8UbiYuPJsTS7k2YvCBKjdsv4UTSWRsFOoLNNrb3ydw>
    <xme:-dy6aalLqiKoq6VYFJgrhN1-t-wi9M5GqK86BAvUUvDvWFzu-eoW0921kB9B_Fe6P
    dMUYrMi1ikiJXy7dgzDAoXJHeCzv98eO0OWzDzsbLrqkeJFh103Ug>
X-ME-Received: <xmr:-dy6acYaMn6aS-sr7-pgeENZVus2P4UkJavtEPVFhCso42-kAvFAcjq_fYXrftWPXCFwkyn-O8Qsqkbvc6_jDRLT1EqFpndE3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-dy6aVNYC_t92BAQayYqjZaNiaA6uvuMpHNEVqtMENhgOScB7DDj-g>
    <xmx:-dy6aRZj9CiPcxz8wja0mT9l1-YN1tZAYYQqFG1HezI8txdABGIQtQ>
    <xmx:-dy6aT1C8rtBRdSNpcDUi7NfeynKDXb4fEFpj-v8rCuPowoteKQwQA>
    <xmx:-dy6aXcV0CufwEnbphAkMy_06tVnPxtgk3gR3zeQz7YP8VlOn1bv1g>
    <xmx:-dy6aVKsXw1OKxgHZVpQBrkST2jsTIhszbB3tk17651OKje-anmWFH4z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 13:12:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH] apply: fix new-style empty context line triggering
 incomplete-line check
In-Reply-To: <CALnO6CDNwa8Ez4Ug0f8zNyxF1n3C_j8mLRbH7wChVioNoC5QVw@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 18 Mar 2026 12:36:04 -0400")
References: <xmqqldfql4hp.fsf@gitster.g>
	<CAPig+cTTgLVGPG99gsb19BeJVWS=VZCU4F-rjb25yHTAORWwzg@mail.gmail.com>
	<xmqqcy12l2ft.fsf@gitster.g>
	<CALnO6CDNwa8Ez4Ug0f8zNyxF1n3C_j8mLRbH7wChVioNoC5QVw@mail.gmail.com>
Date: Wed, 18 Mar 2026 10:12:23 -0700
Message-ID: <xmqq341xgiyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> I think braces { test_writes lines … && printf … ; } would have
> sufficed for the second example

Nobody complained about them ever since they were written.  More
importantly, we have plenty of them that nobody complained and
bothered to uglify so far [*].

;-)

$ git grep -e '(.*) >' master -- t/t[0-9]\*.sh | grep -v -e '\$(' -e 'cd ' | wc -l
60
$ git grep -e '(.*) >' master -- t/t[0-9]\*.sh | grep -v -e '\$(' -e 'cd ' |
  head -n 20
master:t/t3050-subprojects-fetch.sh:	(git rev-parse HEAD && git ls-files -s) >expected &&
master:t/t3050-subprojects-fetch.sh:		(git rev-parse HEAD && git ls-files -s) >../actual
master:t/t3050-subprojects-fetch.sh:	(git rev-parse HEAD && git ls-files -s) >expected &&
master:t/t3050-subprojects-fetch.sh:		(git rev-parse HEAD && git ls-files -s) >../actual
master:t/t3402-rebase-merge.sh:	(echo "0 $T" && cat original) >renamed &&
master:t/t3900-i18n-commit.sh:		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
master:t/t4001-diff-rename.sh:	(cat path1 && echo new) >new-path &&
master:t/t4015-diff-whitespace.sh:	(echo foo && echo baz | tr -d "\012") >x &&
master:t/t4015-diff-whitespace.sh:	(echo bar && echo baz | tr -d "\012") >x &&
master:t/t4019-diff-wserror.sh:if (grep "$blue_grep" <check-grep | grep "$blue_grep") >/dev/null 2>&1
master:t/t4019-diff-wserror.sh:elif (grep -a "$blue_grep" <check-grep | grep -a "$blue_grep") >/dev/null 2>&1
master:t/t4024-diff-optimize-common.sh:		( zs $n && echo a ) >file-a$n &&
master:t/t4024-diff-optimize-common.sh:		( echo b && zs $n && echo ) >file-b$n &&
master:t/t4024-diff-optimize-common.sh:		( printf c && zs $n ) >file-c$n &&
master:t/t4024-diff-optimize-common.sh:		( echo d && zs $n ) >file-d$n &&
master:t/t4024-diff-optimize-common.sh:		( zs $n && echo A ) >file-a$n &&
master:t/t4024-diff-optimize-common.sh:		( echo B && zs $n && echo ) >file-b$n &&
master:t/t4024-diff-optimize-common.sh:		( printf C && zs $n ) >file-c$n &&
master:t/t4024-diff-optimize-common.sh:		( echo D && zs $n ) >file-d$n &&
master:t/t4101-apply-nonl.sh:(echo a; echo b) >frotz.0



[Footnote]

 * I personally find that we need ';' immediately before '}'
   intolerably ugly.
