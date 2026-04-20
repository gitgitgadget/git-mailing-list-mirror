Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBC2D9EE4
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703321; cv=none; b=KXn/WrKrnxzmGnK3bJAyd3y5ESuDlXe9NdFSkX/1Dr8cRuyIBGkNSZva7KEMxUPobTwYqvflkQFvoJdy0Qc8tS6Tfwq1n0gAknxIK52hVvtZi5j0ovc2/XoACA3WeJXZ6Vdf6IgQDMXhr3JwfgetjO4yLuFRjBY72EjuAj+7Lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703321; c=relaxed/simple;
	bh=nuA7lrvDOXuIPBMPT2UP7In0sCi6bWtBQNyzkeKhTmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hu6mqEJtAzOKwvY0rfmdonx44rP1PLGe82m2AcuC100KUXU57B7vBj4YCwXs7TorW4exm+L9yJbmA1TqYn/xlFj3YvxSLC01OzwWUt6KVqxf5VsumEAP3fvKn7oc3COEgK5oBlmJ7jbE123XgZ/kROVoQQbsN2qrFLlnvZpYq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eufS0LJE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1cVDgBa; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eufS0LJE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1cVDgBa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A6DBDEC0412;
	Mon, 20 Apr 2026 12:41:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776703319; x=1776789719; bh=zh/INCupMB
	xCVue0gaLttGB1HBlfWvOUpm+ll1J3Hd8=; b=eufS0LJEVnfL7IX3EjMxNHpjup
	mZuf0jnPJ1ayn2J97mFn+/rahffZFMf+n4zzsxK+TbjA4NEFJWgic4K3US79jLxw
	T8zMdlxou2DwzULO7HCeupBazfr4lUZcMRwzuQDLNeY1II/mc5p7NlIrVRr+JDVW
	tDZcGTsjVUBDcG/lmzH5I2vI2E7tpgoNV70KhRmXAwx2ZzlPcU+fIVcDJLNjoZzX
	mvZtxr2ydv62lzcCFj7LPAkDSY1AqZdG1/Dhndj4C54Ax5uTrhQR2Ox953AClOXL
	xP+8BLAYy+FCfl6ZzEIsPiG5/p6ZwNnTd4avuKQSuWsoMMBqpfFPH6aBEM/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776703319; x=1776789719; bh=zh/INCupMBxCVue0gaLttGB1HBlfWvOUpm+
	ll1J3Hd8=; b=b1cVDgBa1E1xQpY6yTMj9+4kH0Y7zdNyPxHfkamWDIssGJaj5V2
	jUBIA0O1A4Y2g1uWSqumikJvxU9xf2MYkMmqS4qjRUsIRSEIHF8odMP/u1pYPnFB
	RDVqFtHLjBNvHAPFsAP634BdoSu/8mtmziSaYA+DSEm6ZB1YL+/cUZvnlspQRbkZ
	ofTWAS2jQI6jrA0FSmfuWdlwtWxG4gunttajc26yKutmEGySIPtBkLS157EGeT3T
	7MqPlGwNesYLJyaZ67qKmGghx1EgjtfoyH3GmvDQzghLhilm9Yp/wLAJvVaCLo88
	Y0F64PFZotz+pkBWUqcD4Loz4Mj01I6w58A==
X-ME-Sender: <xms:V1fmaXH17p9varv8lCJ2W-dvKjmO-9Hy7RJXS0RA_CjhEwfbXwLeFQ>
    <xme:V1fmabPtmiaI6l_pDU4WXwVBzF-Gi-yjrXtrjqaIilj-nYTxnrdskWle7CMqLCuol
    ut3TinYd9dhnLFEcEukhPuBJdNXIF7gt72fn7fRqFGUyw-1FWg>
X-ME-Received: <xmr:V1fmaReanJ-7b5B-xsQAXO9KDIyf1w8F6QMyzFv81HeuQXdICNSOE4V7zAk7wkPtl1GUdxjORI8VejgVN7SG8-2TvYjziRl6NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:V1fmaQtw8yye_Ba1fdSHSQL66ZzBiAz1KYA5OGh3J_aayHKF40Mr1g>
    <xmx:V1fmaalTiuNv9lUXGNKEVv7CxotVmbZ_g6AtaILIieec4VVeM-mE1Q>
    <xmx:V1fmaazO19rptuhvTLEiRfjb0_lRHvgQQNGWcbBGCNrqpdYeWCa23A>
    <xmx:V1fmaUPPWhbMLhAnkWyjSf3Jv4Zh6lbi53WeiyhB8qKBxTfMU_Glnw>
    <xmx:V1fmaf8tz6Olqb0aT9RIqeWhnr1Mc362BV0XwOtsNnKw66mPLbFgOSgg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 12:41:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  LorenzoPegorari <lorenzo.pegorari2002@gmail.com>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] diff: fix out-of-bounds reads and NULL deref in
 diffstat UTF-8 truncation
In-Reply-To: <pull.2093.v3.git.1776699778177.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Mon, 20 Apr 2026 15:42:58
	+0000")
References: <pull.2093.v2.git.1776465910538.gitgitgadget@gmail.com>
	<pull.2093.v3.git.1776699778177.gitgitgadget@gmail.com>
Date: Mon, 20 Apr 2026 09:41:57 -0700
Message-ID: <xmqq8qahr3ca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> f85b49f3d4a (diff: improve scaling of filenames in diffstat to handle
> UTF-8 chars, 2026-01-16) introduced a loop in show_stats() that calls
> utf8_width() repeatedly to skip leading characters until the displayed
> width fits.  However, utf8_width() can return problematic values:
>
>   - For invalid UTF-8 sequences, pick_one_utf8_char() sets the name
>     pointer to NULL and utf8_width() returns 0.  Since name_len does
>     not change, the loop iterates once more and pick_one_utf8_char()
>     dereferences the NULL pointer, crashing.
>
>   - For control characters, utf8_width() returns -1, so name_len
>     grows when it is expected to shrink.  This can cause the loop to
>     consume more characters than the string contains, reading past
>     the trailing NUL.
>
> By default, fill_print_name() will C-quote filenames which escapes
> control characters and invalid bytes to printable text.  That avoids
> this bug from being triggered; however, with core.quotePath=false,
> most characters are no longer escaped (though some control characters
> still are) and raw bytes can reach this code.
>
> Add tests exercising both failure modes with core.quotePath=false and
> a narrow --stat-name-width to force truncation: one with a bare 0xC0
> byte (invalid UTF-8 lead byte, triggers NULL deref) and one with
> several C1 control characters (repeats of 0xC2 0x9F, causing
> the loop to read past the end of the string).  The second test
> reliably catches the out-of-bounds read when run under ASan, though
> it may pass silently without sanitizers.
>
> Fix both issues by introducing utf8_ish_width(), a thin wrapper
> around utf8_width() that guarantees the pointer always advances and
> the returned width is never negative:
>
>   - On invalid UTF-8 it restores the pointer, advances by one byte,
>     and returns width 1 (matching the strlen()-based fallback used
>     by utf8_strwidth()).
>   - On a control character it returns 0 (matching utf8_strnwidth()
>     which skips them).
>
> Also add a "&& *name" guard to the while-loop condition so it
> terminates at end-of-string even when utf8_strwidth()'s strlen()
> fallback causes name_len to exceed the sum of per-character widths.

OK, that does sounds sensible.

If we start from a valid UTF-8 string, chomp a few bytes from the
tail end of it, and feed it into this loop, the initial part of the
last character is fed to utf8_width(), which hopefully is already
prepared to honor the NUL termination to avoid an OOB read while
returning an error.  And eventually we would see that NUL that
truncated the last UTF-8 multi-byte letter ourselves in the loop and
that is where this new loop terminating condition would help.

