Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A801311977
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138370; cv=none; b=QFr2G9Evy3xczi+3CrTAKdeAsM77PDlloiEEsqe+54zaPg2/htiypOh3gKTHodyXBknx1tWQe3PWZLGeAtdCAfT8J70ZaEp5xUebX3JQXGgUrPPbcQGx0P1ZEouhaqXF3mxaZ+/UdXmSShQMt3FW9RFbDUDq93iUbV2u34XAHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138370; c=relaxed/simple;
	bh=niQgmCJlvHW7mYnn9tSEtBhs0h3Q3vyeRDECQ3ErNR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwLXGqZlfrZVy8pF+Wn9OEPB+HlwKRZMjlOr7PQm9PjveAW/c8go77xiGLKll1LhrgMpkSTTNpB7e5jThLF9/XK5U5k9nZpYCa5RfRb3rX2aPq6pWhEMrMHhg36z+hr+3Yn18Z6jkR7n/QSdAvLvAaeme12APAF3l+lBhhs2u6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vqc6MHRz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dB2Nzj9E; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vqc6MHRz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dB2Nzj9E"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D42B51D00149;
	Tue,  3 Feb 2026 12:06:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 03 Feb 2026 12:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770138366; x=1770224766; bh=eRMxrZpOk/
	QR3kKquHalcbHkNaAs+3fcmrXIz39VUy8=; b=Vqc6MHRz2izqRwQwlYBDsoWjf8
	oreYHL65yyN3omzlaQTwThD0tBliTb6QOHwS+VZg278fSxsBxiA9sLsW9cOi/m/4
	vo5NXHzH0bEZN2L1VvV1r8xQf5J8NyxvOuDmQ0JdHtLF0Wa2F3phZu6rCbSddPDp
	4hkchW8jNkLMgFaicv3iwobEplsXP6SnB+lADHrD/D53vYtRo4TntdtQdC/zdAc3
	iBvmSJjHYQcGGdC6TESMQPpHtAwJkO6O5wWxmXeOXVMTzHgDfQ7uj6toFUSXJyad
	qdvzk9LG+Zksc2+DX/4fCvaJubwYRAj18qWSDI1UAsDoLNFBV9/sc0ZoIIyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770138366; x=1770224766; bh=eRMxrZpOk/QR3kKquHalcbHkNaAs+3fcmrX
	Iz39VUy8=; b=dB2Nzj9EPaCawQos9SzscPye0H3CYufOIXZM+wSBEMU3qIg2pxq
	yrMRD8dfwPyrLAgx7jVAugts/v4hSNJaK2VfhC583XeH7y+3gDnqrQakOs0I6hEI
	ZPgMqbN1NzFJcPnN8z9b1hRRCxV1ktdMubavEASm3CPFZV8JyXRTVJT0dPt9WNAR
	Naap5mfyJBdAq1lI/jRyUZUwRToIXwiGp17dn3wvFyBppcnBWkiu7ypaKJjU/QZC
	ogQGPi7kDx5rupQoxqCWHL8vKmUrM+XkxKyLsYERYiCSu54J0yGUmOUe4+w5nt5m
	JtW5uSfBHFlQhlgBRGfaz5u+7RcWONwpVJw==
X-ME-Sender: <xms:_SqCaVcvfH8T0EHk1FV9dRLC1tq0s305wFT2w7oDHsVYrVwEj0BfeA>
    <xme:_SqCaW6TDehjGVFnWXzdqU20aCI9oxxTL8umH276LFceR5Bg9nBW4mChfmD4HGibn
    UF1G7KFV32K8GTh8GlMC0g05kvI6fkREYpKN8r_KWqc3H0GBORA1g>
X-ME-Received: <xmr:_SqCaYX0Z5ZI5GRc8i60yeueZceSS4Ttu4T8iuA7dqW0kgUHm5-030KJWCOhGK8bamXiaelaL592q3gns6Dtv9XiRQjX7xBEBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopegrshhkodhgihhtsehhohifughoihdrlhgrnhgupdhrtghpthhtohepph
    grthhrihhksehpshhpughfkhhithdrtghomhdprhgtphhtthhopegruggrmhesughinhif
    ohhoughivgdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_SqCaV4KfBSJcBu7xGP63VQg_Gde2mKP0eQyKeepwBPHZ4K-SCPaoQ>
    <xmx:_iqCaTqtPqPXoWcur9T5evDeR6xUcrbTzG0eQBE3v-DTjkrrobDDFQ>
    <xmx:_iqCaYn8-V1Q_S_LIXBzCtDiLQIu7jDMubrCw-L1dyxNnGRI47vRCw>
    <xmx:_iqCafMSqEbKZ7GTj2xmnUH_wxXf_EYfRxx1cYkj3Pt084KoGPKJzg>
    <xmx:_iqCaeaWAKtwb3Y-8Hxqq55zlV31bFcF7nwj_d0hCO5puy3U9wy3oyse>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 12:06:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Colin Stagner <ask+git@howdoi.land>,
    Patrik Weiskircher <patrik@pspdfkit.com>,
    Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re* [RFH] adding test coverage for contrib/ in CI jobs
In-Reply-To: <xmqqsebhu9nn.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Tue, 03 Feb 2026 07:30:36 -0800")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	<xmqqjywuyhu9.fsf@gitster.g> <xmqqsebhu9nn.fsf_-_@gitster.g>
Date: Tue, 03 Feb 2026 09:06:04 -0800
Message-ID: <xmqqjywtu58j.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately, this seems to reveal existing other problems with
> subtree tests (t7900), in addition to diff-highlight tests (t9400)
> in various configurations.
>
>   https://github.com/git/git/actions/runs/21617099884
>
> This Ci run is near the tip of 'seen', so there may be breakages
> attributable to new topics in flight, but I suspect that many of
> them are already in 'master', noticed by nobody because nobody ran
> these tests in these configurations (like "breaking changes",
> "sha256", "leaks", "reftable", "asan").
>
> I didn't look into the details of any of these (yet).

I didn't look into CI failures but spotted an easy one by
eyeballing.  As we seem to be lacking a dedicated subsystem
maintainer for this tool, I am CCing those who have touched this
test file during the past 24 months, plus our resident reftable
expert.

----- >8 -----
Subject: subtree: allow testing with reftable backend

"git subtree" (in contrib/) comes with its own test script, which
has this line

    defaultBranch=$(sed "s,ref: refs/heads/,," "$test_count/.git/HEAD")

that assumes that you can read from .git/HEAD as a regular text file
and you'd find a textual symref in reffiles backend.

Not necessarily.

    make && cd contrib/subtree && 
    GIT_TEST_DEFAULT_REF_FORMAT=reftable make test

fails due to this.  Use "git symbolic-ref" instead to read the value
of the symref.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/subtree/t/t7900-subtree.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/contrib/subtree/t/t7900-subtree.sh w/contrib/subtree/t/t7900-subtree.sh
index 316dc5269e..344956e72e 100755
--- c/contrib/subtree/t/t7900-subtree.sh
+++ w/contrib/subtree/t/t7900-subtree.sh
@@ -1597,7 +1597,8 @@ test_expect_success 'push split to subproj' '
 
 test_expect_success 'subtree descendant check' '
 	subtree_test_create_repo "$test_count" &&
-	defaultBranch=$(sed "s,ref: refs/heads/,," "$test_count/.git/HEAD") &&
+
+	defaultBranch=$(git -C "$test_count" symbolic-ref --short HEAD) &&
 	test_create_commit "$test_count" folder_subtree/a &&
 	(
 		cd "$test_count" &&
