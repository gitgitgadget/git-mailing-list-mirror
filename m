Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B543E6DD5
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700719; cv=none; b=Exajv4gSLb6cj6AWOvrmK/9lqja9KUV7Cuo6LbCvjoPPTXm5zfoDO0ZFPWZjFmsl0eLkzjH1jXMZOy+BC4B4BIRFSBQ71W0VuorpiTi800tI10wj/PaQMrUOXlVVCVy3mJldj3ekWkgNsowLiSjQkkA40aPV9C36KMrSgVvnwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700719; c=relaxed/simple;
	bh=gfmBfvpLaio+D/LcbfvYZGsjCwkC4Tf4eVZ5Lhz0PNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WnQjO5nx6GUcN2voopGlEs8UrZtveD8VBBwgGZ22shDFPKACVopBzYd8i7vs7NeUqbZUz0AGI1aSpBKw06A9EsvlEOCbAfOZg8OaQXAy2ymYrPqKq/pqnIC1lf91BbW+jL35EHIQtcN2l65QOtXVFJaltnTT1Qosgqiuh2gZHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rPNjn88g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e352dhqF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rPNjn88g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e352dhqF"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 51A0F7A03EA;
	Tue, 29 Sep 2026 12:51:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 29 Sep 2026 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790700716; x=1790787116; bh=hSpk124JtT
	vzpFHZshHPEnj21Euol4uTpaUkcm9wTss=; b=rPNjn88gm9Ot8b2PB/FfCkTFe7
	MVSvuB1Alpohwryur6XbpNayjaR6PHTuAKK6S2DpR4tgDHMI/hg6wCNIgCTKrhCR
	Y/o4cKVp+D3QYAbTFhEL1NdSL1OsG9pTD1piSRRG8/mCpIgFQn8ZmZbQ25qgiCTF
	+3h3VhE0uObUmNcngyyRQXXS1aukySbSqGQW/py7zOMJN3mNwXZ6z5hUG0doYOaM
	kf/R7zOqsXosUmVQZYeGq9/YAlcZCOWmBC+2chlHpD91zXFyrelzsT8OQTlD6sTJ
	8314EoLM1Syy4rYwC8oNVMi3cf0DozUpbQv91efANRMUfgtZ5Q5oXVCs30Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790700716; x=1790787116; bh=hSpk124JtTvzpFHZshHPEnj21Euol4uTpaU
	kcm9wTss=; b=e352dhqF37XbPCGLHwyTF90sUSze4vtMN5HW6bMuLhulWyhqIMr
	kkOltfjdyrKd8i/kNocIbDhJpGB9iwnC1yj9k/xYoO9ap9M9Kjs/R0FJalrv+5Rw
	yX6owPb5g+5hl979NB/A9FWSJlaqsohBIstS5JvkpNsQlZ8eQtc7/7TGPb/zvMgy
	JhojAtqyxZuzrOY/VOzuAx3cLrssnWJaOWpzvmKVXCWDUZ1gnjjsrlwL/rmQd5iJ
	ktly+KvnpK0FVJk2x5548Fp0rxTCZ/IrFLJo45e12JIKHeVS9KiJCMeuNjCBb/uV
	R3TA0Cx8sVNvEvONOM9qt54o989967xFm6A==
X-ME-Sender: <xms:q-y7atvdhhXl_ScJg_N54P84Lbmf4BxiRPT7V-CqgH04AifSuTqR7w>
    <xme:q-y7apAYV_gmIJtC-EyatcyZbpOPte_EWP-6TQZMgFfFQoZnPjW837mw-xu6dRe0W
    Q81tKGnNaRVi9ROP3kl2nB5SmDrGq7q7vqvPHkWkYRAA8gbNJfmMw>
X-ME-Received: <xmr:q-y7akaqBAla2gQlYK7UmIYaWoIOENjlK1_UN8VkfcFX6h2139NzsSwl0FUFMpQG9tDzBEGnjBE0xgMptB5bMsDJsgL3olwwaNI8>
X-ME-Proxy-Cause: dmFkZTF7MJE2GBxj07CVh54pQgYlB/7M4sJ93qadut2HuZ3iuxRrX2afGNo9pH9v4UcuR+
    jI8WVrnjf/tFCA9KOf1I/ddTdSIFLc0O8ZjKTN3dW4vvDDxgysVzt7yx55fvv28U9Dp+Ft
    wsL8xY7I7JQf4YHaw6Isnu0xTx6rUExd5jKGrCJLMjxemlAyJer/AMOt0BZlP0DhujTkdb
    CzRUmAToxs/oA/pjM6TYOsUZCCI2ka7Ocdez81SH8PdqRETPIZNNyRXFU/ioMZZY8z/OXp
    VGuvqkuuMp0h9CybskTuBv56CeK9HIl/zayblRvmeHY9soaiCkJBtl5PZFqq5NeQFGunLO
    mSwgcoVKAfgU2T59qTCmTa4qC+G3yQjRNfT8gSsUKErUohT1oEY6ElVeRUXOG97nNwayk0
    ZW7VX2uKz9nPms/EkKyKfk1UWP3+iiRnFOULUSjzk9r8TC16ifpKX/9yd381glEK+frwos
    AteDhSfT2IIQxny0ywQ9YdwYArn5TQZwteuTtp+eGljToQ4XO9GV9rhyRMasPyhCmHGv4G
    kCSoi6qEvmQA/Hz52BuvIxY9QgcxO7PhtKdayhyFYQe3mNO8T5DAgd3n039pzcZ2kbsGEl
    v4jQ9vp9S2it7l3vkeHeessbsGLFJ+i7LvjfJwMcKomfMipqDa+8XwSd3jNA
X-ME-Proxy: <xmx:q-y7akUZDMJKj8JMUlxTSnByQy7Pa5sd8kZLFpuaQVi-UBDJst_2TA>
    <xmx:q-y7ajPw9iCKbqZFjjXKmhUJwCz0MUTfea6dqqLFBILrdRG5SMuvoA>
    <xmx:q-y7aubNl59rcBRUh-2Oie5K9PtyJTqfjJ08hy9A7twUf-iOyf_p1Q>
    <xmx:q-y7ai9LrmNEdachdeubwaPbSNfzIvjG97tFMVD49lFCkWyUoxqtkw>
    <xmx:rOy7atbdPK8Sl-cGXU-jgdrgWaYoalH_T9HI3l-5JxPf3l1QDxVXbcYQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 12:51:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,  git@vger.kernel.org,
  Jean Delvare
 <jdelvare@suse.de>,  Elijah Newren <newren@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 2/2] merge-ll: use tempfile API for external driver
 files
In-Reply-To: <20260929051312.GB1100669@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Sep 2026 01:13:12 -0400")
References: <20260929051200.GA1100000@coredump.intra.peff.net>
	<20260929051312.GB1100669@coredump.intra.peff.net>
Date: Tue, 29 Sep 2026 09:51:53 -0700
Message-ID: <xmqqcxtwhufq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> When there's a long(er) running merge driver helper, the user may just
> decide to terminate it with Ctrl+C. That sends a signal to the driver
> program and to the whole process group as well, including the git merge
> command proper. Hence the cleanup code would not run and .merge_file_*
> files are left behind.
>
> We can fix this by using the tempfile API, which auto-cleans files on
> signal or other error. That covers the Ctrl+C case above, as well as any
> other incidental death (e.g., allocation error due to a gigantic
> output).
>
> Note that there is one gotcha here. The current code uses short,
> relative filenames for the tempfiles (like ".merge_file_abc123"). But
> the tempfile API stores and returns absolute paths. Because we run the
> merge driver as a shell command, this can result in problems if the
> leading directories contain shell metacharacters (like our tests, which
> put a space in the trash directory name for exactly this purpose).
>
> If we were starting from scratch, I'd say the correct solution here is
> to shell-quote the filenames we put in the command. But doing so isn't
> strictly backwards compatible, because users might have their own shell
> characters. For example, if I configure a driver like this:

"own shell characters" -> "own shell quoting"?

>
>   [merge "foo"]
>   driver = "my-driver '%O' '%A' '%B'"
>
> then adding extra quoting will screw things up! Strictly speaking, this
> kind of quoting is wrong (it would fail if %A expanded to something with
> a single-quote in it), but it is entirely harmless with the current
> vanilla relative paths. It doesn't seem worth breaking it.
>
> So let's take the most conservative route, and just continue reporting
> the relative paths.

Very well reasoned, and the implementation exactly matches the
designed behaviour.

Will replace.  Let's mark it for 'next' (unless somebody notices
what I overlooked, which is not a very high bar to cross).

Thanks.
