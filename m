Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510B1E505
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777164255; cv=none; b=LihA1Bh2EVska0FmI+HRkIfS+N1p8m8GWoMgSCxKvsBVO7d6fonCUrNVb7k0pWFN7GuBUs1l7plQKoo0/AUUpkMIGCBkG9SNOTUvgjQWD4/1jpp1Hx7bQahvRFg92jCPoE09B5C8ozLEfNknI/+sFvoePfWcgAi9hpP1anmWLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777164255; c=relaxed/simple;
	bh=t4KXf6iDNvw7b2lnqfO3JeXsQBytt8rNUCIKvotm8Rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k31BmmA/IJ7sn31zrJVOp6wK+dFJuCpPUh7CeiEI7MHj4aa1f4HUR5bG478E2t122fH+jLjjW1SSv+h6snQO9Az4pzzGm0QGGncNYrZy9tHO2wEeKMGFA15AMRU9nGF1JgPLuQKRwpT512a9jpJLcU2p1YBCLdhuR57oeZ0YAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=woHSI575; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPngl9ov; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="woHSI575";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPngl9ov"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5715F7A0060;
	Sat, 25 Apr 2026 20:44:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 25 Apr 2026 20:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777164253; x=1777250653; bh=SDAwpAcI1M
	NnjuHmm96RD62CNEf2cjprtinXpDUCft0=; b=woHSI575vlzrcp00qBRcBotQ3f
	Rfksde0GdnxXRJFAtEx0jPhW5N/byPzVyexAdcIE3U3KEFO/Ftp4UqaUK7tau8Qs
	6ndcZGxVsTtUuDVaoj4pnfyDawuni4F6fSbcNqbYgdlyTsQv077iCX8VtrBheEes
	+O4n5s0Mdq3WdlvK3VnJy1kQl4SjnaynNE4UxmINPjVGyZPAjrk1IQdo33tzarpL
	L98k9wQKSBAm2colDJ/G4Ey64YYGX3XXmQRQP50ZnUJ6oDlTEbnOiFeWVaJC/TpE
	CvLdYMSYOpSus8ah57CaP21fsxMa/bemp6JZezKVnUQMdg/MYy37LFEzlHKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777164253; x=1777250653; bh=SDAwpAcI1MNnjuHmm96RD62CNEf2cjprtin
	XpDUCft0=; b=BPngl9ov1hoaDDD/YZroNV9KYg7XKAaSG5++O3u+iSkd+h2/x2B
	e8rbtpY7Pj/Obkfqlt5tGJr1qcWYYjLEK6SCaRh6PqSJFqQKOcDknGhsvhBnG6Fd
	l3NVmTLZdCtZbS2/u4X1C77LpyunXfwgJj0LIxc6SEc352mq3PaSO3EW3jQck4PH
	MpXYjooOSw5pOmjo7fXlni3d1T6qTpXUgfZnO26KX/W8mmEzkPnWhDohvpZQJW5J
	R6ltdAtxncmUUyP6emxBeHNp2gyOJk8ZhWItEMP6inddUe2Kp3Yh3LoDTGvzzor5
	84wxz2vn4wPePJEmbOksnB6bmZc14MHyBzg==
X-ME-Sender: <xms:3V_tad6-Q3IN544BgiRwcNtwPWR9b56JH1ukmmG3tVoOYzMBP_LGyw>
    <xme:3V_taR55KmBb0XOdU_N-5dp_7GFm-aHKCi4F81ig7PANRSSjV1OPf1BzPaa1NYVuO
    dRCN8ldjXw56VpPQDKhIpjgaGXnLymcHazbWusdI7oOXZ3vKylsHA>
X-ME-Received: <xmr:3V_taZeTeDT9ZhysIiRhpJdxMuKHudjEjgvuc7sboVq0-3n9lXs5s_ycD_frZiRuAEPNuz8oqHsMOAZ2F5VLOQ5-1tOyyY8jXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejgeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3V_taVCPRIZ6fUgQ0KqM61XuqDjBNFt5XsmNnaHSD74E78T7pSSAwQ>
    <xmx:3V_tac8a9O6ZJUhrPCFsUnRFxQaw7il2yWbTjbO4tonMvFxVfU_ZAA>
    <xmx:3V_taQKyb5WnDTg973T_31vldCj1lpfCpTfc06DfYkdR-yQRFYpq_Q>
    <xmx:3V_taViqP1jFw6x_CpFHPsx8fHM7rGO8E8tp-1okqS4Frzr-YIYuOA>
    <xmx:3V_tae1Y9cPCshKz8ViyO_hMB8V40utKLTQtHP-I7_TjmhpHmZzFtN2t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Apr 2026 20:44:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/8] ls-files tests: filter `.gitconfig` from `--others`
 output
In-Reply-To: <ef57244778d8f72754801d80a9e7e8ad034cec28.1777042877.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Fri, 24 Apr 2026
	15:01:15 +0000")
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<ef57244778d8f72754801d80a9e7e8ad034cec28.1777042877.git.gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 09:44:11 +0900
Message-ID: <xmqqldea7dpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +# Remove .gitconfig entries from a file in place.  test-lib.sh may
> +# create $HOME/.gitconfig (e.g. to set safe.bareRepository) which
> +# can appear in ls-files or status output.
> +test_filter_gitconfig () {
> +	sed "/\\.gitconfig/d" "$1" >"$1.filtered" &&
> +	mv "$1.filtered" "$1"
> +}

Thanks.

When I suggested the "just use the usual configuration mechanism to
keep the semantics of existing bare repository tests, and that would
be very unintrusive", I didn't think of this fallout from an extra
file getting reported by ls-files, and this helper function does
make sense.  If we were starting from scratch, we probably would
have created $HOME that is separate from the test repository in the
test framework.  The simplest layout would be to emulate a developer
who has repositories under their $HOME, i.e., $TRASH_DIRECTORY stays
to be the $HOME, but the initial test repository would be created as
a directory inside $TRASH_DIRECTORY instead of using the trash
itself, or something like that.  It is all water under the bridge
now, unless somebody wants an opportunity to work on a non-trivial
clean-up.

By the way, when merged to 'seen', with the 'ps/test-set-e-clean'
topic already in 'next', many tests (especially the ones with early
test_done, like p4 tests in my environment where p4 does not exist)
seem to fail with WITH_BREAKING_CHANGES turned on.  I don't have
enough time to be sitting in front of the keyboard to isolate the
cause, but because this series is one of the topics with biggest
impact to the t/ directory that was replaced after the last
successful run, I thought I should mention it.

