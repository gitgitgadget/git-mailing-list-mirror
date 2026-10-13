Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A504531AF6
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914414; cv=none; b=f+TtC4qDReesJeyrDhSgQwRyNTj7rUnPxi6RzQYmWiFtBLcxOdWEKC4yBE66fZhaYRkinOVDUDk762rdFIPRgU4oF3EkZhu942VG5wGqPl6czQgsbYpErEYf1ZyvTZXMcR5QY5/km7JBinVCOEQ7cph9v+dLIemJfNkHQVBwACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914414; c=relaxed/simple;
	bh=3iSPBRf17QGFKM3KiE1RTtLJjzZ2scr7MYBdcIy9x/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVamUXksw4kedwS1e1cM1r6r9edf9+1hUJh0lXM5h9B+YdWSRmaoGZSWXJnRx9vSsgpNGcp9qhcHSIIy+kXRZs4kbmwt7tAqJwpJDOK4NHoLmVBoW2jkiN1aXnT0cQBIpX7/02julu+Nuab+QNOeFfunxdeZ4a+y82x4rfBF10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N1cD4TNf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZP8auHQC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N1cD4TNf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZP8auHQC"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D04427A009B
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:00:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 13 Oct 2026 14:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791914412; x=1792000812; bh=VSjgpWSISh
	pCkltCbkgujgikbubfHSezhjZH1paj2AM=; b=N1cD4TNfQcYLB0g6EV06FfthZR
	6AstG8zGJYhZJf33bQ7QufpXKX9QJ4x0k4UcZ7tXg/e5mcDSmiU13tMvgS+/eEBx
	kV+NUSpJtrLGf17m4ccTkb+5E8UiMeo5E9v6jazkd4W0TKyejFWj1fFwL5TMjpLM
	viD5zXytKKUKkIWcdeSu/qxfwJex+b3AUJROx+2ws+rz+TkpYk0WInCOWRwxnu+e
	luTY2jq8tOoSFg8/GH6Lhu/Dumt5tuZQ9pf53R6AYsorkDB2mj3UhOOqAHP7yBvx
	9g85XlRpRzZB1GJeuSzQwuTUZEeFyIx08/CEpy1x0jIznX/ryQuEaxh23czg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791914412; x=1792000812; bh=VSjgpWSIShpCkltCbkgujgikbubfHSezhjZ
	H1paj2AM=; b=ZP8auHQCdZmBvhy8vTLBlWmTVfHCfzTYrlLfngkFGyiiZQdUbZY
	DzxGz+PdYNKweReneWvrSOz3qgJD2aWkkaGNc6i0lVn13FheuE+NfoBQq44h7Mqb
	ZX0N4oqkV9NfR0vKKIKMjtgFAaIHPuBxZWU06i+CANKud+LLR24EsZKLT31lHFhY
	0KDQ4crugx4AfqPYRPZX2pnvd5dWxZAzsC6jszKq9F4/ztbSTe3kil0Qc/5iafkW
	lHH7rN5CvuvoDldnEwzU5ZX0QWFz8kTlNS4NOPKSDy9dXnbnyROIgN5P0Z9zVnug
	IGb4gqRvOR6vd0O53mGVRJ8z8rw9LaPFwkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791914412; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hWdqdJPjNzAiEQoTFRyyL716QryjGifIG+FWAIR0ni8Ezcp
	1Fe1G6FufwLcw1IEf8l+9dYuUSfSlG1+6GmN54CeoNutDmukjutApT1NnnyzQ/Y2
	AB3BRIFmxQt66ybLkVUHkeFzQtGuJtdEUAJa2QhjpfbYapV5VXaYOsOOp7OMGs7H
	xscSL1KjFDOAExFnsHqmKhjDUSWkFkTaksNQff4ZMFM7hnTTbwNoKA7ldEpK9dqY
	duXR75/ifcB8CJvLBJj8abTK/jKtEebTROq24/CPAbp9tBOKsZ7p8noBQMo/dKnG
	vbAy+rEPEmNoUbN0MKQm5zYgLLFU336ePwqL9hA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Ao/DH/Qq2DQyu1/ASjXiYIA3sNkMUsKBBf3Y1N61d1A=:3iSPBRf17QGFKM3KiE1RTtLJjzZ2scr7MYBdcIy9x/g=;
X-ME-Sender: <xms:rHHOai51KQhp1-2Lmsk3yWN-KFf276m-za42LSEWW3sCOHMokrHSiw>
    <xme:rHHOauI8JKIgkJDjHZUyuel9hw5H0lV5jGJs94pbPBXJV_aRvukWiKVfTEO-1xbau
    4dLzhDnI6iTKLZDXxbpt3FOPYN4MCK2G0oo5bYvrmRCDYJH4G-fp78>
X-ME-Received: <xmr:rHHOajvUvJ9-A8rbAs_WxCZ_zcRsPT3w_R0_KZUsstCaUR2b-Ffz7DX5-BWkJotU9BofR2ZNB9PCG6uTqqLMaqdMEXmZsga6W4eu>
X-ME-Proxy-Cause: dmFkZTEaoNWK0s6d8xGGK78jOxtPck6Hv2HHIBoRWLLuQ5T4l7rhCvVqE0ZUav3ZF0UOi0
    dSrrxBlMZgnU3Bg2YtH7CpEwOhbNB91u1D0vnaAjtvjCPBDJg9n4Ntmd55kYCRqTOiKwom
    ySCt1vVAKgVZYk9VWGGinDW/4qn5PV2+wOJVR7YpMjqh/Cep05S6WNhoM6kCB3epsYxC0x
    yzl0a6gBDTa2sWEj8N2mo7DqQSIHfMfXrZwPnrP3hmxE4iV1jxSwt5mzg8OFw8/XQVBgwx
    V+xMmSnQKJswdsYat+f/uanjYDp0KWA8Ro1AOthQTIjRwkhgt4ahSxq8s/hzdpPDdlUTKm
    0IaXV66MFYX4iO8/gMN27sJlOGTYjR2n4XDdjoBMGoW7aX1FRJt6kcdpNlaDdRrtK6YW3+
    pdsKS0ZRqDdmI6ShzObWr7y4VTBzpMqeQcSk7nevLA4SCt8+oPKHe9Xbh2RqN5hcHXyP1i
    X32rOYYpxHHW5K9c27ErlZxv0asSDYXltE2QzunSedOBCIoxkFrp4e9a29/ouUw0lqg1w8
    0Rv5PK4tBysEkJu5ztAccYe0dFRghZSNxIBZNtyw8hK2d35s4vDyqVBS94Ga58Lncyk07x
    oU34ccCumNutnThbx/HdRxTACgAXICyDDnf/P4xrxLelkhlAF5JXVYyHuQMA
X-ME-Proxy: <xmx:rHHOalLNJgntdJ3MuGu_8N-EEee8Jr1WqRp7iaNpT7z1aZqdvEQukA>
    <xmx:rHHOak_sSW25xvCA_Pf6FyQvaAlhR-r3ySf0HjCV3o0NyjiOPBecvA>
    <xmx:rHHOamz36Z9J4QlkHR8Ik4CXdQwZzX9ClrRmEIkxAUK21PLb92Up9A>
    <xmx:rHHOap68U36uW299axcJqbpk4lcB8OlodvKS8McV4CBc7tw1_zOHSQ>
    <xmx:rHHOaq-qnxRt1aNPMHLOsPwOAKAjDWyhPmhrtOTGPg5HTcrkmBt6dc00>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 14:00:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] delta-islands: use Q_() for island count
In-Reply-To: <20261013164922.93099-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Tue, 13 Oct 2026 17:49:22 +0100")
References: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
	<20261013164922.93099-1-okhuomonajayi54@gmail.com>
Date: Tue, 13 Oct 2026 11:00:10 -0700
Message-ID: <xmqqv775xyz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> The progress message "Marked %d islands, done." is marked for
> translation with _(), which gives translators a single form for
> every count. It reads wrongly when only one island is marked, and
> languages with more than two plural forms cannot translate it
> correctly.
>
> Use Q_() with a singular and a plural form so the right one is
> picked from island_counter.

Nicely written.

>
> Found with:
>
>     git grep '[^Q]_("[^"]*%[id]' -- '*.c'

I am not sure of the value in this, though.  You certainly do not
mean to say that you updated all of the ones that you found with the
above.  You are not inviting others to do the same grep and "fix"
any of the hits, as the pattern gives too many false positives
(i.e., not all %d are about number of things, like the line number a
parser has found the error it is reporting at), and without warning
that, it would not be helpful to these others.

> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  delta-islands.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/delta-islands.c b/delta-islands.c
> index e71a7e1c05..c1c0f992f5 100644
> --- a/delta-islands.c
> +++ b/delta-islands.c
> @@ -496,7 +496,9 @@ void load_delta_islands(struct repository *r, int progress)
>  	free_remote_islands(ild.remote_islands);
>  
>  	if (progress)
> -		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
> +		fprintf(stderr, Q_("Marked %d island, done.\n",
> +				   "Marked %d islands, done.\n", island_counter),
> +			island_counter);

The change itself looks sensible to me.

Thanks.
