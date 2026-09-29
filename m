Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7711569F36
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711724; cv=none; b=FlXLEBeAc43+LOeoVtc01UbLPjptcTTtKZv0V9VPOWlrlBdHyIDott2czVVz0bN0f5PKYWMgCcflXX+HmXhZA2wQZCTdjalkbXZIJDyb3gHVMmsaE4rnBUqoDNqMNIc/1L8lSar38SWMVfgQymJIgQR/Ql/pfJ+OtBbEATFninE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711724; c=relaxed/simple;
	bh=SEbJFQjDZMhGtPwkE1aGXsoJCW9/WwYHRhW0fcWzLe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NJyMxhnLhOa+YwwIscPeOTV9TkYvmGyOz2QvCoCOp2UQ1ZrADUE8eTlOKHyqojrmT02a9B5lqmkU+pqNAMaoa53FWd5paWcM5Xc+2dlejNWZJoo4ANwynlYPYWmpPZc/gNuvqIbSybbhjZ4nlpJyuiXrTJQzt0gE0hUWLGSVuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L/tvmPrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jcEYQvoS; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/tvmPrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcEYQvoS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F5617A079C;
	Tue, 29 Sep 2026 15:55:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 15:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790711720; x=1790798120; bh=aD2jq99qXo
	bL/gtGB8QuG6VZ4D/Nm9SaSk24TRjrbGQ=; b=L/tvmPrC/jKOX1C6sitDblnPMS
	nafzZNEJhXmPkOn/zYF9Tm0vRuFlW2MpbCVUDiaRn+3jQLCc5/pukjx48lldkGLd
	Y4BKANKdLk/3gUXARbPT6xepMvGt5IgvMmWyb4INleWtgDrWV90vGyeQFjOBHgBk
	f2AOtvyfzCgzJfO5b71lJ/63tFkZJr8+dRHGih20ZC3XM90cl90+xvLeeuTS7EpY
	iLoFFi05AMKoixZuzHgvrybHlciX/dHaqR8IM0nfHAi+sKrmbREUVdwU+1IibhBR
	PnO1D2avWpwMWoEh+CMMAnPnSK1ghHjxz/D+VdmkjHXUDWCxlaSi8MWnqlOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790711720; x=1790798120; bh=aD2jq99qXobL/gtGB8QuG6VZ4D/Nm9SaSk2
	4TRjrbGQ=; b=jcEYQvoSjX1HrBzHZB8p6pszEWa3S2kzh67y7eHpXKWSFWcdCpG
	KgG3cAW7NNNDLBRpXdGygqFhZ+MSLORQAFRM870YuNoj/O/J63lM1dKRj/QdyCsI
	JMHU1VZHRLgnlyaWwPAIuqx4zu1T51h4PXQW4syqbb6aD/NL1A2mFBw1/8CLDWWz
	4JCqFguSalbL95obp0Z+QkOGNFEp1Boyaeyhpz/36QQPoqam89QKbeIDcXmAc/tN
	6IpVak58iEEh8LIvO41wDoBPzFLvhzJFhSJVpaVVuo2B2qqCzC0bFFRuVki1B6Iy
	e5Y5yLBpdCFilArjgulxjJkQmn/0KdWff+A==
X-ME-Sender: <xms:qBe8akl-6lEQLndzVcCUyuzde1-wjlaQgkkBKLFhZygQykxi3CtFRw>
    <xme:qBe8aqtBxmIOdXTGn5tD3xR99WJOlMB0FpYlD54_wnRVglswTaRicaym_scG17SgA
    LOmeGk7oW8ZaYXxqIeWrimv4vuSLDsdQLlDnqq3ujXpqC4Ns4ZMJw>
X-ME-Received: <xmr:qBe8aq8qIKRTFAWC4TEbt-HJs_L2obkxtccrL6erJA1DosiNIgWxE5aNJofmptUOUuNPYByLJW6hcq4Nf6sPM2RfRgZNhVzg5u1p>
X-ME-Proxy-Cause: dmFkZTFEPEU4XaA5clvzr3d8Q1Aw/Zr3E+9m6aqQnkQ5cKO67xA/WSfDJ+vMGEvyYOhqq9
    /rCCB2HSPFyp6ue3icKRPC+zpwtBCcnZgnVTMUgnULJuuxkG6D65vaOQZOw/0ph6IxoEOD
    Tts54e/3nrXBQJMxsNl1Xzg8eyAg3TSyiIGH4yxIEe2hBzGM2vUEhwnrUGHXTZ2WXq8u/D
    LyX70K2Dmo+fq+rzHSxKgm3CzSTvylLYisIYPeLxwdXxSPquY2rPcLLgIbl/CzwluB9BxI
    PrJDibPuSol3jr1lkaW9iRaPhXXKk9EEHtJONWUC9Z7qErkpSrk/PkfkApCyXdGnFv34GV
    CxfFcM9ly2kveBQVURoSESIND9JHaQSW1iHUDkgDhWAWTv8OTXsDYw9bJXaa7k6Tt9ThIW
    zNc6icPWAQG5aFUH/CPId6//Bn6m7z2g401nHLq/mzmJgwLFDjHLYk/uzU6n4GsyY3F8HC
    N01aD+uREcCS5HjwSQ60DvLzEq7B3ICbi7ObwM71ObqiE4lVtqtqQjUpmRdFNK2gU2MzyC
    pp8Q3q2ylehDRfKdhd6pGDGQZr147mbQx6vaAUU4vUI0oWPCYSrsemEoE7w3tRtQS7GbaC
    QW4txIBEU9KjMNOQ38re7DBWOPfqtHIGfuXRAazzCBKseElYitjShUF+gg+A
X-ME-Proxy: <xmx:qBe8asOQAGmiF7mzrJFlOrsEU1_38b61qY8f2YwhkpW_OapLzDQokQ>
    <xmx:qBe8agGSJvoV6Uywxti1oh6wip-Zg6hk1NJ4masEC7hvvV3-CNBLLg>
    <xmx:qBe8aiRqgaQppiIHq2DEJtMJc7fVKIcQgMkCu5rhx9Y5CBVDRvmbUA>
    <xmx:qBe8alvR37eajhtcns3mv3dID8dpgtlaAfv4WbS6mIvAUQUDxqi4vQ>
    <xmx:qBe8airX7VmiuR-sBiosErLDmi44lYtnqnVljI6OR_CMQa7QZj2yWUvl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 15:55:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ignacio Encinas" <ignacio@iencinas.com>
Cc: "Jeff King" <peff@peff.net>,  "Isabella Caselli"
 <bellacaselli20@gmail.com>,  <git@vger.kernel.org>
Subject: Re: hostname: includeIf condition =?utf-8?Q?=E2=80=94?= anyone
 already working on this?
In-Reply-To: <DLRSIZ3JV2DF.10GG1YB2D8DHW@iencinas.com> (Ignacio Encinas's
	message of "Tue, 29 Sep 2026 13:14:34 +0100")
References: <CAK4AdTRdNEU8cLFQ_7A=CUUL6u6dc327rn_H-SeBBD_dD-K7PA@mail.gmail.com>
	<20260929014415.GB1089022@coredump.intra.peff.net>
	<DLRSIZ3JV2DF.10GG1YB2D8DHW@iencinas.com>
Date: Tue, 29 Sep 2026 12:55:19 -0700
Message-ID: <xmqqa4ozg7dk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ignacio Encinas" <ignacio@iencinas.com> writes:

> On Tue Sep 29, 2026 at 2:44 AM IST, Jeff King wrote:
> ...
>> It looks like after review on v3 of the series we never saw more. I'd
>> guess the author (cc'd) just never got around to pushing it forward.
>
> That's what happened. Similar to Isabella, I was looking for a small
> contribution but it ended up being more complicated than expected. I got
> a bit overwhelmed and decided to drop it.
> ...
> I hope the discussion from 2024 is at least helpful now if this ends up
> being implemented by Isabella.

I was re-reading the thread yesterday.  It looked like we were _so_
close to the finish line before the discussion stopped, which is a
shame.  All the good bits were already designed and the only thing
left was to assemble and package them up.
