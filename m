Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF901B415F
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086361; cv=none; b=WqZtPnW5Vc2g+dRf4Ckn30KSlV4UN0a7OUZn/0uSf4rlLAeLKRU4Xb259DoWDQorVerf5WiAuerhvRJvkjAwu719dRBfVHwxaHg7AJgO1E/u6V8iE783ESlT4XxK1BIfLlebxJ+QaqPtpOCZCY+ntGDsLpK5DLy2uTX7LgD2kgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086361; c=relaxed/simple;
	bh=jrV6cZ80QcIlQHyQutu6yw9UIdq0sMzmAheFHcYNhKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgMtmXPH/wVFbvF9j4EP7kcV3rjGMJV49EeSTfTvpD1VvGAYkbndobxqeKjd/x1fld4T8GtW267iEfq17ppnDlme2fUp4iGF3PgfIzbdOGs/SH3Qz9zlW/nXKtzRl6jKbJyn2IbVAp5A9uKE2yMc3jHrcpVGduW7TP97pMdLFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YlARyFNa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcK6S4fk; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YlARyFNa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcK6S4fk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id ED20B1140122;
	Fri, 13 Dec 2024 05:39:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Dec 2024 05:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734086356; x=1734172756; bh=3TC+LesEP6
	4MeP7aAwaLOCNczki4J0sWddTJNKv3A0c=; b=YlARyFNaJYI09svpMCNPb1lsBE
	qEmB/9H+lc9nxOa77BUj0kmyN5lldnR+0DQQUVbKhTgJvno+vGIhs7XU8XMVcwB7
	Rr0E49TUaMfAslMFQO6mVvub86fbG9pPK5TczOsEVJ2U1zZwf2uXmheAktFZOTB+
	xPtRnJggHvEM7bvR2pZZRmH/8nUelZTIpIi98nyb1zNMdAP3i/4d+z+WMB9Yp2B4
	Cw8jf0mSVdNGzW25cY3InbjN0XO3T/xm5PGTB+sII5znLwsT6j8t+ztSZGatieQ/
	h+a4yV2b6jBVXuEX2/mPAIbFcmcF3B2XiHKODh+pRHOyHHpfY6VVsrufGdxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734086356; x=1734172756; bh=3TC+LesEP64MeP7aAwaLOCNczki4J0sWddT
	JNKv3A0c=; b=QcK6S4fkrG57PptShCwiTBVvSxnoMefApJD6k9d7/2NqczWLGMm
	evG6qKyIO7OQx9yhxeRrCnr8nOBD1nEMYMh9zcbMPPTZSfQxplifx3hVSHQ7PuXZ
	Eoa6vSHKfeCba5V7XOs5frI2JcFTcrHhNVqCAqFZT2nMvZ+CBio4gv6FVNfsC0ot
	mcVnsPh3uH0SvhHhSGpz4wvMK1Dg2XQM5M2WDS3z4h7plPvVjcOQW1DFNUzUjF0p
	r0jQ0d9j05xf623RAv70DJRDHmZFKwxoTHKrBtsW5oURZaqVcJ5ME5PnAw5djEmq
	En1n8szbJHp3Rz88ArRrsoHQ+G5pgY0UO5A==
X-ME-Sender: <xms:1A5cZ23YhdyBlKe17d61-Bd6W2LuYnCpxvQLkXnGCE-rRISEUjNEwA>
    <xme:1A5cZ5Ew4Xf5YbIbIbudIN6AeheSYXevqIcogOkYuPcelfYDCDSxs1781OQexsnto
    8H-ELYfNFkR6i2L-g>
X-ME-Received: <xmr:1A5cZ-5LkNcLCVDHcwrccrP1BKbC801IGwrqmysLcDH-7iHyJ8LKhrXPExRlHK1OHFDx-Q-niQ73Rpwt_nQCUOdG3YvglKpx6NEyI1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehfrhgrnhgtvghstgho
    rdhotggthhhiphhinhhtihesthhrrggtshhishdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:1A5cZ32U8xQa1n1ywW5LFRw_2I5L0Aa0YeU6BCH256fnDUhSEnIzfA>
    <xmx:1A5cZ5FLnkgJsqeow3ApfP4AN2gG6Cev9Y1_nOOkkFQsskC03UzHPg>
    <xmx:1A5cZw8P3QthChoibEfYrQgHuBHHf5buU90iPu-xT-2YhLr9kfhkaQ>
    <xmx:1A5cZ-l0GP_weB6_WHG1t5xQ7ep_puq3JIFtc_t54BixZSSMBDq4aQ>
    <xmx:1A5cZ9hXYgSWGUwtrgoqkgokFxxzIleGXa_52ld-qWuIJ8kMt4fVPyru>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:39:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Francesco Occhipinti <Francesco.Occhipinti@tracsis.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: New checkout --track behaviour?
In-Reply-To: <Z1uuqKI_2rb0HXhP@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 13 Dec 2024 03:48:56 +0000")
References: <DB9PR08MB7194822B81F17420B2D3C149903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
	<DB9PR08MB71949D21F5F0E81911F0D50F903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
	<Z1uuqKI_2rb0HXhP@tapette.crustytoothpaste.net>
Date: Fri, 13 Dec 2024 19:39:15 +0900
Message-ID: <xmqqed2beujw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is indeed a subtle incompatibility in command-line option parsing,
> but it's not really avoidable and it does occur in pretty much any case
> where a short option learns to take an optional argument (for any
> software, not just Git).

Perhaps we'd want something along this line?  While it is not really
avoidable if we have to add an optional value to an existing option,
"not really avoidable" is not a very satisfactory explanation to
please those whose established use cases they have, or their
scripts, have got broken.

--- >8 ------ >8 ------ >8 ---
Subject: gitcli: explain why short options are better spelled separately

When the "--track" option of "git checkout" command learned to take
an optional value a few years ago at d3115660 (branch: add flags and
config to inherit tracking, 2021-12-20), "git checkout -tb foo" got
broken, as it is no longer two options "--track" and "--branch=foo"
given together, but "--track=b" and a regular argument "foo".  The
command parser dies upon seeing "-tb" saying "b" is not a valid
optional value to "-t".

We already discourage users to spell short options in stuck form,
and if they spelled "-t -b foo", they would not have noticed this
breakage.  Add a bit more words to "git help cli" to explain why
we discourage the stuck form.

We might also want to add a note to ourselves (perhaps next to the
Documentation/CodingGuidelines, we'd want design guidelines) to
think very carefully before considering to introduce an option that
takes an optional value, and refrain from adding an optional value
to an existing option.  It would save the end users from confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
index bd62cbd043..dcc0aa5bf7 100644
--- c/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -82,7 +82,9 @@ Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
 
  * Splitting short options to separate words (prefer `git foo -a -b`
-   to `git foo -ab`, the latter may not even work).
+   to `git foo -ab`, the latter may not even work, and even if it
+   worked, it will change the meaning once the '-a' option starts
+   taking an optional value).
 
  * When a command-line option takes an argument, use the 'stuck' form.  In
    other words, write `git foo -oArg` instead of `git foo -o Arg` for short
