Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363D2D0617
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302854; cv=none; b=mdi+EisTGwFpnMI1tkqkFFuoqeYa4/WlLDBZhNKZqYMX+AdHtLMBBALS4zLzmix6R0SiocAhlbs1//TMQdmmKl5/3ypn3EKViQHSu75v2m/lqd5AOvjYXPvB7ZMh9dIGk8RJ6jKKFhY+/4MCBzmqk2aFQf0MVaGadyai2IAEQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302854; c=relaxed/simple;
	bh=9bBSs3RIU4wv9Dkg5P8tPW06kLsaWPpJsTvBEUgYlyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6Z7O/yyFsTHhwt17+ruF7ZkKQuKO2oA/arppMGg8t18bPJSihXAU/xKaB02uJD5YneaqSoenokHUun6yuFkmCYirQPQCjvdht1xmD7wiYHwRyNvEtOrig5/iWz3BL545Yd9U5j+76vTqTGHjaizP1geXiUM1RZ+30oDtoqtUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RLdBAN9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFvo179j; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RLdBAN9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFvo179j"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D50B614000F0
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:07:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 06 Oct 2026 12:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791302849; x=1791389249; bh=m7m9ZM3lDN
	5WCmamE1lhXerGb/lk3JX9PentMQ1I3HE=; b=RLdBAN9NczM/s0Is0hE4Pi+Tw9
	q4zmYkeey8wFliS0quSm3dUlQblss4jeqNwp8bk87cKhriejJ9S3c4L3l4Iltjod
	o01x7JNmA0fiuP10mjWUggnFn9ESswgNNFfIxB7OofoZbqpBN7ns/iM5sunkmTh0
	F9lqoCXKrORq4f11TsKPucaPM4/PVnH3I907v74u/FNUnrMcinsvY+I20m1l04QD
	9Wj6L72SYNZkejHQ5N7l3xWLUK6Wzxl45CG67loHA3ROssvr47KCWGzMX+T/9VpW
	8JRNyMzujMyXwZ/oYtWQCx+4thvmkJA0ISpaDUsdylc6C2wS9SJeg7QSo+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791302849; x=1791389249; bh=m7m9ZM3lDN5WCmamE1lhXerGb/lk3JX9Pen
	tMQ1I3HE=; b=VFvo179jFWjX+BbubvQLCppzeCvDRLfTcFJsyDkja5AAQfDbCJY
	mIW+ByiNepQOaYOeVVvbe8FJngC05LMDxU/l7/ehbBm5QuQyR6l/6rbZw1/GcgIK
	fSQu4o8t6SZgLnJ7TfHkInskWDPGqXT9w9alskMNC0fBk5jsN2a1VdlEnD8Solp1
	coq/cL55DiQFB4ifYnNGbLdiXcKYwLmYl0WJpdC4+AkMZ4D2v170ZwUcb0QoVy8B
	uThi0/FecbT/PbQg6OxgDtnzSixMyF7EI6PWmWTuBe7L+DLzd2SWLKYnAv1v8cbh
	JnRcpy9XNnAz4hpL5CIEmYYy52xxacLq58Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302849; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:l06LVDPDjBZD6TtKYgNCPcpXfCLnUkD2cHeW6oLmNo1XgCg
	8UqeX2mvNMuUJJ6PREa6SvRsu7aKmTHVsifvtCoc87uU7aVe/B7YnDFXLkxIOA+a
	8PAAgkO3ygZAgYUIrMa2dpE7iNCwc7b28BZql4ymMjnOXbpClizHQr9BLWMrHQRN
	teg7EHA+ZjqwJ1Ujowp7MXI3PyuMRCTP709TJ6n53nDVUx/f5PAwV1fz2v3oj46W
	l5yVEYKe1P/PvMNV2Ld5N8FgLqjn3heHTg3AlvtVnPuHWsgeLZIVVrnAFFAB8SGY
	sjEax8JpSzd8YEgrPE1bKzJNsTKxhDiiNBKDMEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:B5o/X93j/E12IrYM+X7Ee1J/NOq0lCWDp8DmzWCO7XI=:9bBSs3RIU4wv9Dkg5P8tPW06kLsaWPpJsTvBEUgYlyY=;
X-ME-Sender: <xms:wRzFal-FCRQ9PpYbM1xfyJxHM6jLLWwzMWQDMgd3aqk-hEiCUfaUJA>
    <xme:wRzFagkKooamodZTUrxoFbXJULCeVhAzFzJygYU9jwefuHp44HIoprh2srA8UcVYS
    jbWrZkc-CY9iZF6RMa2wmhMrFbuynW3FGstZXgqAR6mLm5jC8lnFQ>
X-ME-Received: <xmr:wRzFarXuYJlSkfMZl5IhZsah2RDJJWv5wiEo-jhpI52mGo8xCDugvMCLOg-ZN4nXPFGCLhZhbgX_VJWz-ZbnUNgm54ab0uX_QtoG>
X-ME-Proxy-Cause: dmFkZTEEQNSMZAT012mfTk2X/I+lzKS5Q2ax5LMUK94H9jRvjTEeKc4QIPAhKFtVz8q4hh
    RuST8pj0SOZpg6Ts9tklEutz1cMKr65tbIerlHZHkH/tnTwQa1gQMRV6pQeNyyJmIVudlO
    nVIagBF+zX1dmd09bQH1TljpkSZ9kgpXT2y3rlB1oKHmVhFOfxhZKqzlLACCu+J+69PxCr
    EO2CK2/uZGQSmFW7MAluuCptcX3eFeEfUPJZzGRxyiu6jZca5U0qnRWA513zuv/7VwflFo
    nWZVXh+whqD4NCmQtPYRCa/sawXstSxzWP7OIN07v/VuKYBV/YeIazCNJuNmhMsJgWcpQM
    cJ2UuAfVcSabAMwHjLU9upyMZxCggRU6TpH5X8gP+bJOhFfoCL6HqBEclkL3V9HcuuDMeO
    gaN+EXpWCy1cgcDkhHhEMQ+CPN7vDEF5TSg1ieABM9G2UnSanQQ5eLxhqEvpH4tJUtVI20
    L1SQF8CdIC0L5M0V1UXuBQjrPAl7oeRIE8qN85YGPTfwHCP+rJHWD4yxlzecCANtdpEGzZ
    6r/1Md02yJMUtgDvWi5xXkUMqr5WKjeQByOZVyhlpwxeL6JM4Iw/WtwKAJtUFJUKxuCbDY
    4YMyv7j8bDiiKfJy9fCX3NY7Ac5sTMNrz3rloP7VORIADj/wbU7U7z6wAYrw
X-ME-Proxy: <xmx:wRzFalFrOe8JImMv9DgqT8W64JFu_90A48ejCK4fBcTf7LyT2FCb5Q>
    <xmx:wRzFanc0n9OLuWzPy_E9dzeuCgcAjvGXx3Scvscp5li_49oGRwlSFg>
    <xmx:wRzFamKanLfH7yVxSKGUO3_SM6DPrbz8J1XTIb1Oo8rbE4uIt5GsXg>
    <xmx:wRzFasEP84SFPFIFRJN0HyntpzgIvQWRCm8-zNctPArpusHrKKsCPw>
    <xmx:wRzFap1VLUhc9nGU4kSLaXzXwymu6_an1jaaTfSGtnN73LJinJvOEKIt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 12:07:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Tuomas
 Ahola" <taahol@utu.fi>
Subject: Re: [PATCH v2] doc: don't require a SYNOPSIS in section 7
In-Reply-To: <afb72458-bc22-4a7a-87ec-83c77e83aeaf@app.fastmail.com> (Julia
	Evans's message of "Tue, 06 Oct 2026 07:17:36 -0400")
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
	<pull.2246.v2.git.1791033057232.gitgitgadget@gmail.com>
	<xmqqece5vc48.fsf@gitster.g>
	<afb72458-bc22-4a7a-87ec-83c77e83aeaf@app.fastmail.com>
Date: Tue, 06 Oct 2026 09:07:27 -0700
Message-ID: <xmqqy0caersw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Or maybe like
>
>    `$line =~ m/\((\d)\)/ or report("first line should look like `somename(1)`");`
>
> or some similar error message

Sure, not being totally silent is better but we also need to make
sure that we do not end up using undef when we issue such a warning.

Thanks.
