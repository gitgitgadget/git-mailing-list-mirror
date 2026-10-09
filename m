Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B938DC7C
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524251; cv=none; b=FRyWmnWJAyB+/NRwj8LrTfCiBMYt/JYk+BjDPltfC2sTMlnPe/pUoPdtVKMVeNdWTPnwUTx1C66khfED0FU+NaSS5yvst2JLgNkwU2RlBLS2/RLvW0iuCmKdA3OTXdf3RVjBfvjhT3H2OPCPKi7zAzLKrdDKhRbYLNWIEbs5j3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524251; c=relaxed/simple;
	bh=y2p3YFU8HjHuvi4QDxBt4V1p1eSX/CtNim+I1eNX6vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=saYML7SLuhsa6K8yjcj3wxG/mDSeGzStdB8kIVMzhjEldxVaab8sp7nTf/kDAufffBn3uY5zArsACNVVEF1QN9d42tEqp8WucUwvaBODRXmVnFfLfmz9K0Ypo6+BJwct7xzCdNrsgx+k6o9rVAjWZh/UMUosFnVUCy8wq+eYIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WWanRhXo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YA6kTKkG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWanRhXo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YA6kTKkG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 98E171D000CB
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 01:37:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 01:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791524249; x=1791610649; bh=0FI9xE3jSy
	LjOTA5luIoDNpX6+Yinulm9c55CDjJ8y8=; b=WWanRhXo3cviQDkb7/JRD+sEwB
	rfPEX0iuhWsecM4la8BboX1+Xgx2Kxbt+cCqcBtx7B9DXbprDf1z3Ma/UhmLomqN
	yINcCUKR1i3B4o+EaTwPKklv324vS/IKI/SYN7vzNwiS+OUQsDL9dnMgcR/5E1R7
	Qe4FsGnSsAZF9s2eL1I9v/YJrGuxqVimOL12fOH31+t4k/Qi+5h4qbC4pLCdhi+O
	uu+RtDxITKrcFbroiSfmISLUTfUPoDXamVMhRSQX66qV5fGUYj378FisEKk/TI36
	QLnGzoaSMxWetCthABacOh7JRlx5JPV2cSC8ZjBHLI6IBtQzc3q1+8Fc7NXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791524249; x=1791610649; bh=0FI9xE3jSyLjOTA5luIoDNpX6+Yinulm9c5
	5CDjJ8y8=; b=YA6kTKkGCj2GFUvfvpfGvMu9Zw2DvIGfaLrY3hVW3PyI8+H1W1n
	ShwJDXBvYSY8P1eUsOXWGAisR67MP09pnB+0vuETrrwJIzkE/Byx3td87AMvmu7a
	614flhU70b4XQ6E+GuYp+g8i+3DDjeIJfqzb2/P8e14nFepew1RMgqmivOLiwoXY
	Sq0oi1vACtYPqO9H6KtwRGLSuM6V2io5U0ZVIWCMDjBrO0x5GFBkZiG+WSliZcT5
	pC9gAGcf/7wi++joJz8FbxIoxQifAeKxl32xxZe07D3Xo8Stzl5TSm0g4FE06lha
	8nCOHf/QDD/io8Or5unUXX89tzvgqXUkkiA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791524249; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:afEsRWSosk6jDtQ0ybSWqD0Ha7F00lQOF7Xl+HNbhhIM+E0
	X6HFvoeIp5jpCqpMqYuiiO7kPAVwIlV9wBPXE6+XHfClUUM9MhOrhXuT+QvmuAWm
	0Kpb0BIrckS6MdRkrnZhhWAKKJmk991Ylj6IkASEqrtAii+nBRuqvAu2SicVXXaG
	jhAbCair/2X6FLqDmrLjxsNlp2Ep+VyeoEMkNQf/6S8uYR+8XNg9drcL5q/Hlfly
	pQy5jHXMndbRpLvfZ+aPD0ifJSbRyfsdXUi23IpEvKuC5SyDnBoTWinPZry2ZV4Y
	myBnww+L3Nd/XVMqgbwQ1T54GfPbPVTuf3RcrNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nsObxjoBxq5ZJNaMuIrwJBSsenOCRI0XwaPQgTW4wts=:y2p3YFU8HjHuvi4QDxBt4V1p1eSX/CtNim+I1eNX6vs=;
X-ME-Sender: <xms:mX3IarCepo_61X9Q3OE3lg5KCprZiO3yD1X7bpmLiag4ppUn-dsPXw>
    <xme:mX3Iaohx8inHJ8GgcuQbQeF1p4s5UBRnk5rwwDs_xAfkmXTIbdYuC-_RKWUsK5bmt
    _pzWmYp97-sKALhi2kExwieWAsNXyMe8R6IZDrz6j3vcMZhUTulZw>
X-ME-Received: <xmr:mX3IarmUhLUoIf4vKaZ0aAsDgWY3Nrv6QBkocVoMSpZt-QVrMB4EfTAoZwH_gmPubXTK1JLfmiYYC67Q7gKDZUQTbcnJx8aBuyhz>
X-ME-Proxy-Cause: dmFkZTGo0CJE0fDrrhTruOFmGm8cQqT6KhewiAfyQPbXGuv7qj+EfpzdJfd3WI8gu46vRX
    9bMnrYFwYPQMVrdSXrqU6oJA6sBSx+jVgWj5Oqn60EjopqL+DHQjPtBey1Vv1Y9nFBkZmT
    kQFNPcVLOxCAxdLSUgEr6N27VgJ0UAn9ia1cVXNDV1v32fdJYTFAeLN6r0Wr9Wnd7ZSVQB
    BFPdiXNHBEnW/5CdkOfERaKn9hZfy+rwk2NX9YW6aokA90w0byJpDSOvplyb5z+QiVaazT
    YP6hVpTqASTNVtrBRFAz1gKQaugS2bASIoKftSxmdgYJEPfNojFeS+CW3oY73raSQvFFm3
    0qawi3ipxjfOi8u3ou6gbLNHUItTG/SmQH7ymp7lhf/CO4Y0KoEwVLvOCb4M/Gu6VmSOZn
    Fr9N8UqpsPNjJLC5CnGPAKgRxV6UEIWj52x9r9wkcw7Wx+gss4eZGI7PxOav9oWVoR3z4V
    6I2T1SaxwbKJJoNR72XSfErK/AN2Je+Z6FZYbhQZPbs0rwWgqHuBxSWOzQUMRhz8Y+/Gvk
    aPctWyCARhxCp8AAI7p8Ecv/zWhHyI8BHsZUtGEa/HW1pscNMmz0FruE9l9IUzMq/c50Lh
    CZQiUTJEEmRkKnAlt0kS4Hg68L4xHXOKCBkXTb9zMvKHfwt2SpUoB0CE17WQ
X-ME-Proxy: <xmx:mX3IasqWvcjQoWE0hxlUzDBZ9hCrHybpqc3_xOU9ybRlmKAW4BdmjA>
    <xmx:mX3IasHlq6l6_IJd7dDt9y2C1bHuGLx3ixkXjWchpy9Ug3YtrhjQCg>
    <xmx:mX3IagyHHilRok0wMVs3paY8umX-8nlWeAAc0gZm14bwBPBuiERcqg>
    <xmx:mX3IappbT15NgxdJq8X4LyBHKi8O_L2DohXmDY3D_wt9ZNZLEHlJ5g>
    <xmx:mX3Iamlr-YwgRSURiiPWPlkQg3l3uKsKo5a2eqzjZL-TxP4VdJ10dRiH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 01:37:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Curtis Allen Smith <curtis.allen.smith@gmail.com>
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>
Subject: Re: [PATCH 1/2] read-cache: do not trust a size change when
 conversion is active
In-Reply-To: <20261008204603.1988-2-curtis.allen.smith@gmail.com> (Curtis
	Allen Smith's message of "Thu, 8 Oct 2026 14:45:03 -0600")
References: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
	<20261008204603.1988-2-curtis.allen.smith@gmail.com>
Date: Thu, 08 Oct 2026 22:37:27 -0700
Message-ID: <xmqqfqyfwi20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Curtis Allen Smith <curtis.allen.smith@gmail.com> writes:

> "git status" can report a file as modified while "git diff" and
> ...
> next run of the tool flags everything again.
>
> Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
> ---

That's overly verbose.

>  read-cache.c    | 129 ++++++++++++++++++++++++++++++++++++++++++++++--
>  t/t0020-crlf.sh |  45 +++++++++++++++++
>  2 files changed, 171 insertions(+), 3 deletions(-)

And it is curious why we need so much new code, especially after
reading an explaination in the proposed log message that makes it
sound as if "we let ce_modified_check_fs() to compare converted
result already when timestamps differ, and it is just the matter of
doing the same when sizes are the same" is what is happening in the
patch.  Why do we need to add a new function that compares converted
data?  A new function is not automatically a bad thing.  If there is
already an existing code path that does the same thing, a new
function may be a good way to replace that code path with a more
generic code and apply essentially the same logic implemented by
that new more generic code to a new code path.  But in such a
refactoring patch, we usually see a comparable number of removed
lines, which is not what we see in the diffstat above.

