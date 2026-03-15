Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9634DB6D
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590677; cv=none; b=Ig3UAeSp2dqp7I3jII5q6olyUFhTIOI8m0pJaIhseyIqD/tqKx5P2wb5bdjOX3ICEp4MqCaOz2L3YMr85cL1BxlOJtE1dRbhZPzSpj0q5lF8I8UPa+XunogtSPQR3kIBmZOG4uzhcYtxar601pn9rX+/iUqoEd/hXIJtST+x+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590677; c=relaxed/simple;
	bh=C31hwro2gqWDRYNs8bLgVv9KxAKSlMUwX0p0Acp8PT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HM58OQbtL1mslg3AMbItdgBD8b3tDBk/VToOXT4kxkdfeu0EF8vWNGVGtaM6nzjVrpq4QZ00Thkcxa4MXG/2QXIoakSe8WXoIsJ+Sdq8wWhgZL8a49X/GgkRL7xPagaFe6dCqBDgVEHMzWl4PdANkv1BSgDG6QgcqpC4M80XEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ys6Cj8nh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5NoKNn8W; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ys6Cj8nh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5NoKNn8W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AEA8EC060E;
	Sun, 15 Mar 2026 12:04:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 15 Mar 2026 12:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773590675; x=1773677075; bh=hgtgLDLMmI
	NnnRG/GCaJyOdaAf0BmEPcsOAgUXl19vE=; b=Ys6Cj8nhvXGedpDr5c9uAZi+Zf
	7MUkQ5AUw3VJSfJsBGplt/JXjvF78lkrBibgT2qt34XXVuUXoFOTeRM9qzQdcTb0
	2koiKgD2vVY0x8v60XqAepifHV8P3ObEewfWnJrCzOLm7gks2O1zgJBqy4VlqLt6
	5qcwhQFgq3cENMGyFoUqXWxXSd6XI9q/iuhrasi31vtfg2acaRpklR1+6W9xjxDh
	AJj5vzxuIDARgR9dCmU/kQjhTylPlWbDmNrKIkECCUOnLTJkMiV30NjbOi2YrTWH
	FAPtxMcX9PByDLjpGSDvXATddFGr/WgKbJQKygNc0EdpWLiypzHiv6o6z6Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773590675; x=1773677075; bh=hgtgLDLMmINnnRG/GCaJyOdaAf0BmEPcsOA
	gUXl19vE=; b=5NoKNn8WtVqpia9AUduvKaJuzlUdO6aIJc7N6JAL8W/nIzxpKDC
	tIUrtY0pyYMTzwPiYLTgeCPDsR6F5C1/bOCIOkKuK8NcQvwr1HNcl/xolqFTc5TP
	mB6iYMHgeEp0SXhSZdVIZDz4YMOU64cfBy/2Gc1zc3wrm8ktsEAi/9HiO/QgLQHW
	Q3re3AOV/geLALYiS2oRgYPgvXL1NayaP+v8LBj/T6by/V4wxdi6QPz3RepnhR88
	SOplxEEW0bz/t7pFOwo/NZ45QXckefBFWv0uBt/FjGFLTONnMTI3muLdkUoIoggj
	4rxbDn0g+iukRudfbwp2Oa9rF5nrXhwNtvQ==
X-ME-Sender: <xms:kti2aQYj73_41uztqa_ppDAIXTJPL7tngNpLREzS3O5HIy1AwtNzNg>
    <xme:kti2aS1Fo4E63-I60imTMUDzOJYmWLag5fH8fTLpwa3v-n-YeFraadCKAiMU6_RSc
    RU4eoMJidMkKUnB8i814j1VArh-2gScfzADn2DfKhDE7IUAlnx4Aw>
X-ME-Received: <xmr:kti2aYXqpOIA03uJEMGhFfbnA3EsX7dZSF3BY2MlodGGBaKEqB3iPkGsVT9y_SvKaBRX5DEYn6uNXLv7e3VoP9DgL5kciGJA1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleehleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kti2aUXcURxN2fMAg5UGGUZuvwLZ3J8XB4TjT8UcXSXlFYgB1LaDIg>
    <xmx:kti2afdCvuqdkjcExbpBQnLDSZOQp2a2SZn-wH0NuB6Cp4CbXwjvMA>
    <xmx:kti2aVXucdszuerQTi0TeGxPbYf2YE2yzA1EfIOYcLZzUUjP9dmWig>
    <xmx:kti2aQfi0aXw3MPE7LISLWZTiD82lZMUWOZiVfEpHXkL-qULruPgpA>
    <xmx:k9i2aQA6djgTAEpthMDvaPA-KsRn3A8TblSo696QQk-clho3DJi8htO4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 12:04:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0008: fix "large exclude file ignored in tree"
In-Reply-To: <abZwbCF1R0_bnFBv@exploit> (Mirko Faina's message of "Sun, 15 Mar
	2026 09:50:06 +0100")
References: <20260315034851.2261530-1-mroik@delayed.space>
	<xmqqv7extzd9.fsf@gitster.g> <abZwbCF1R0_bnFBv@exploit>
Date: Sun, 15 Mar 2026 09:04:33 -0700
Message-ID: <xmqq7brdt6y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> When running "GIT_TEST_OPTS='-l -v' git make t0008-ignores.sh", "large

This must be "make", not "git make", right?

> exclude file ignored in tree" fails with the comparison failing due to
> an extra warning "warning: unable to access 'subdir/.gitignore': Too
> many levels of symbolic links".

test_expect_success SYMLINKS 'symlinks not respected in-tree' '
	test_when_finished "rm .gitignore" &&
	ln -s ignore .gitignore &&
	mkdir subdir &&
	ln -s ignore subdir/.gitignore &&
	test_must_fail git check-ignore subdir/file >actual 2>err &&
	test_must_be_empty actual &&
	test_grep "unable to access.*gitignore" err
'

The above step creates symbolic links subdir/.gitignore and
.gitignore, each of which pointing at a "ignore" file next to it.
This test has extremely bad hygiene and depends on "ignore" having
preexisting contents "*" in it (so a bad version of Git that follows
symbolic links would ignore almost everything).

Files err and actual are created, and when the test finishes, only
".gitignore" is removed, everything else left behind.

test_expect_success EXPENSIVE 'large exclude file ignored in tree' '
	test_when_finished "rm .gitignore" &&
	dd if=/dev/zero of=.gitignore bs=101M count=1 &&
	git ls-files -o --exclude-standard 2>err &&
	echo "warning: ignoring excessively large pattern file: .gitignore" >expect &&
	test_cmp expect err
'

Ah, OK, you're right.

The problem is not the subdir/ directory itself, but the leftover
symbolic link subdir/.gitignore that would cause "ls-files -o" to
notice and complain about that symbolic link.

If that is what is happening, then this should probably be fixed in
a belt-and-suspenders fashion.  The primary bug is that the
expensive test that does not protect against pre-existing files in
the working tree when it starts.

In the failing test, remove preexisting .gitignore everywhere in
tree.  With as bad hygiene as this entire script has, we do not know
what is left behind in the working tree by which other test piece
that comes before this last test, something like

test_expect_success EXPENSIVE 'large exclude file ignored in tree' '
	test_when_finished "rm .gitignore" &&
	find . -name .gitignore -exec rm "{}" ";" &&
	dd if=/dev/zero of=.gitignore bs=101M count=1 &&
	...

perhaps?

And in the previous test, as you said, you would need to remove at
least subdir/.gitignore in addition to .gitignore to make the next
test pass, but (1) the next test should not depend on it to work
correctly, and (2) it would be a good discipline to remove any and
all dropping you make.

So the change to the not-expensive piece would be

test_expect_success SYMLINKS 'symlinks not respected in-tree' '
	test_when_finished "rm -fr subdir .gitignore err actual" &&
	...

and the primary reason why we make such a change (to be described in
the proposed log message) is not about the next test, but is about
cleaning cruft created in each test before it finishes.  It would be
OK to make both changes in a single commit, as they are fairly small.

Thanks.
