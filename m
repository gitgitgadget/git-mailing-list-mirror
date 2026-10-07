Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6763E7BD5
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395589; cv=none; b=JJeg1a6oNKmR/6jTr1Xdf0tlPEZGOMa9zjiPThRn4JXCiDM+yoN4WWpReHLtmyvRG7JRB2ZbqB/YzTpTij2kWCvZBYYgaG0/rRamosXfoCPNBjKxtCBkEpnFTfYhhsna9breQjT6xGz3kQIugGxmkIUA5nEYqVAjYTYS7cHqhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395589; c=relaxed/simple;
	bh=/NP5Ber69Bl+vpG4Bsdh0u29T6+03dM7ucgzTTO98Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEub9yFIUaBWY+6sWu65nyNDwoDQrp8erfhE18HlGh9CKgyXMLKwe2YvqPZsksvcbQEVqyrB3yaN4TNSCAy6yWp5nDduKBq2XKQ1ajV/IUioN4zbGn5GMjP1CqA06omTNzj6gOyr0BLdo2ltYhoK73nfYzNFazv7Ty+enyfELEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H5Jh8rTC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xC+eC8DG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H5Jh8rTC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xC+eC8DG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 17E80EC0467
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:53:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 07 Oct 2026 13:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791395587; x=1791481987; bh=WIbbEFRxAJ
	vInRTtpc3GK3Og386S7bgMeZSyPnHdZbc=; b=H5Jh8rTCLQ+CK60mG0gPuiOMhm
	tvr+iB3HYnfIAWx5D19P4+0hzG8dS1uBg5fARZDJ6R9A9w0l/0ki0McRMgIWNixo
	4n0h6n8ri3cYzDrD0Ntbw15LLVIFUtynqtmsLwfTMXKp7s+mCd2qTPc3I49esl9D
	mvmErnHdtnyDw61HHu5+a0iyr08nAXYivk5XVv5MdorT3LT6JMnR2zlyD7ED3Rym
	ZSG94ZFhacOXXzk+Xu67nRFXjqqnGfJnhk3F0rumkFBmNANDPyq1AFFz+HdN8NOy
	DtcIFTbYmm6UKykcUakic/+CG8VrCRY1pzIwQwhxeTPULOW01z3mdnHPP1jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791395587; x=1791481987; bh=WIbbEFRxAJvInRTtpc3GK3Og386S7bgMeZS
	yPnHdZbc=; b=xC+eC8DGpxydJkZru4dOgclQ1l+7iqIuw1PpA13Eqc6FI+aFDIG
	R6uuD4kyrqQv2rGI9MpI7NvR3LLPg6l65XF6jYTAdWnJu7QcKNRj4ISdCPPKbMwl
	7LqLsm5fU3OXuZR4wMtliHpaYlL8bM0qcS2sAhuu4+4LGjd6SpUGTnl+sdF0O7+W
	nJ0NXJZ5ayOyxSnsP4m7sQ5D9DSkXP23FAMKpwrshZbKH9FpTE4y00NTkihiDKcs
	TMqaff9ycLibrvXDgHAEPxdQY7joFhI6N+w93v2pUvH/VPwACYlPIAIwCy8E+0T7
	iNVcswfYu3z4ylebdFdg1mz40xS0y4858Nw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791395587; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:azk78myzFtPpYtM/IH9qA4HmbLRnq3GeI2xuU+Ymn7OvXPc
	JEzhcFWcKJZCfPZVwLA8DdjaiGtIlp3npFWoJps9A9bXTqWCpwXVZAeWVP0eF7Mm
	FORXlD3u7L9oA4DE7aFxCy2YBmEQm2HmP1KjC7luI59rzIPKj/8oP4wZoOHknOMT
	nxzcDrD290PPkFsQKD21+ncPsN7Im+HoNYO+pMtdZg+gQTuPVgp2NDJrwxy4/BV6
	QkWLjmw9x4ginHW4W73oVa1m6OoX3cKeF/h/tf4kfg4kBTqgJHFK1ZzUBGn19+1b
	X+J4PhfJnt0npOp0peN6L+NWxnxvPE9itHutYgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rWtQdc9tOGW8wmk3tlni9neQ3NQyAjeB6HqwojJW8Dk=:/NP5Ber69Bl+vpG4Bsdh0u29T6+03dM7ucgzTTO98Zs=;
X-ME-Sender: <xms:A4fGasXqeg2I7H2ZogUsZEMuMBKptFXRtKmsAcqs4fHvWgcyyS6XzQ>
    <xme:A4fGaoDrsCEPpxUpHSnX7B8jvRMVZPiF008w69PmVcPSIJiFp5ryn_8W0xG8mSfAx
    15mGxDL5qo-4PSs8kYl9u6x7WmHsJLcwe4astUIqil_tLY3kQFmxg>
X-ME-Received: <xmr:A4fGatxNZ5o63iJnB-y7ducTKyMGkLvv4TB5WB15ZF1Bd_Aw4QSC-Gbs0pAflmdp7iU85n8Dg9lVPqDIctbpfdkZ4qhrw5P-C8AA>
X-ME-Proxy-Cause: dmFkZTEXDHMorjeIEA8iFP9sYYyz8HKboCd8yIP1IJbsUszr+DQxJHI9zhVkKcA45l+lKz
    LlBiYSn6iVva0mLeBm3xeV5vlxItLeFZPUjQloWFEQ4eMmHfQmJ7LnIAWGuBHQD9gOQ6zA
    ui88K9uRkamc7wkq9hsjklvUTU8PDqtNvbuZxlr4+3hONdFxu8NQX+nhERBrMqMuun66RB
    iuPgJSVdsfx4rNdyPv+Vr4qfALq2/LiA7SMXeFeTvtIt5xxyBObLIzWyGVQ8fkU/ra/ALH
    PzIscfVqihZGQwPvY+6ZbbHCg8dQciroItRZ+qOu/VHiCHV6E4z4glcBSTA66e9hhfb/Ry
    vkwMEjF2wC928f5MrybzoFUZAPSxwLQgP+1TfJ7Eu6Saxhc9+wW7f/aZ+YtF09wIx27w3k
    kQFHWZvRkgt7ikJbe7RbwQtKwu7SoSNRy84KZ7h3TlOE2gFcUnCrn5otuEYX99uRNY0ec8
    9cJgthHsKf2Cpp1HsgcfG0/RRNFwCYdhVodRrIy7zMLy0izTW3iYH4vU7aCvvwDrCvkeIa
    qTJhHQLT9xKAPbkmOT2qpG/69MoAgbjnFCeDD1VZzkjBLMQl0yR51GubfGHOlxXiSWHWfX
    iAXuxqs0miBt4osXu8YHKBGkOIBm4IpqJKw3oqgXv+hVMVzAwM8qC5tzrLtQ
X-ME-Proxy: <xmx:A4fGalBSigV4imR0ZW7Z9ZEPkddxzzFD-jPF7uqAspFp7CWXW7O4uw>
    <xmx:A4fGaqZn-k0_qqs78sjHv0dFsikQB3PYQbbEbXh7yMfWtx5ddckPjQ>
    <xmx:A4fGatjGVrgiCDqgsZ4vUKYQIqraxUKQ__kbe9UDi9h7v4IJrrTbPA>
    <xmx:A4fGas7Di4AjrVfAhNPNYnAZ9hOj_kWornQyrnnQUFcbkduz3MhZmA>
    <xmx:A4fGasD1Z4bHSqZP89kfA-BA12MYQdVI4tovWMDcWX1Cn66yWTGTEpLF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 13:53:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] combine-diff: honor relative paths consistently
In-Reply-To: <cover.1791390459.git.dilsheddilu123@gmail.com> (Muhammed Dilshad
	A.'s message of "Wed, 7 Oct 2026 22:05:12 +0530")
References: <xmqqld89bmd1.fsf@gitster.g>
	<cover.1791390459.git.dilsheddilu123@gmail.com>
Date: Wed, 07 Oct 2026 10:53:05 -0700
Message-ID: <xmqqh5ix8kji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Muhammed Dilshad A <dilsheddilu123@gmail.com> writes:

> The revised patch prints there/file as ../there/file when the prefix is
> here/. All displayed names then use the same base. The tests cover both
> discovery paths, including raw and NUL-separated output.

This sounds like the most sensible behaviour, within the constraint
that --relative must give a relative path to the prefix.

> The index rejects repeated separators, but tree entry parsing does not
> enforce the same check. The helper now skips all separators at the prefix
> boundary, so it does not rely on there being only one. Explicit prefix
> arguments stay literal, matching ordinary diff's filtering behavior.
> I also wrapped the added C lines to fit the coding guidelines.

Do *not* respond to review comments in your cover letter.  Nobody
reading the above, other than those who have seen our earlier
exchange of you sending v1 patch with I commenting on it, would not
know what you are talking about in the above, and especially what is
so special about "repeated separators" without context.  The cover
letter should aim to welcome even those late-comming reviewers who
missed an earlier round.

Review response should be done as a response to a review message,
unrelated to your rerolled patches.

> While checking the two discovery paths, I found that the fast multi-tree
> scan bypasses the relative-prefix filter entirely. Patch 2 fixes that
> separately and adds tests for outside paths and repeated separators in
> an explicit prefix.

Great.

>
> Changes since v1:
>
> * Use relative_path() for parent names outside the prefix while keeping
>   ordinary diff's literal-prefix behavior for matching names.
> * Preserve /dev/null, skip all boundary separators, and wrap long lines.
> * Add cross-directory rename tests and the separate fast-scan fix.
>
> The developer build with SANITIZE=leak succeeds. The affected suites pass
> all 77 normal tests with SHA-1 and SHA-256. A separate run with
> LSAN_OPTIONS=detect_leaks=1 also passes without a leak report. The existing
> three-parent coalescing failure in t4038 remains an expected failure.
>
> Muhammed Dilshad A (2):
>   combine-diff: honor --relative when printing paths
>   combine-diff: filter the fast scan by the relative prefix
>
>  combine-diff.c           |  70 ++++++++++++++++++---
>  t/t4038-diff-combined.sh | 130 +++++++++++++++++++++++++++++++++++++++
>  t/t4045-diff-relative.sh |  62 ++++++++++++++++++-
>  3 files changed, 251 insertions(+), 11 deletions(-)
>
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
