Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C1175A7D
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909078; cv=none; b=aKF53ShoEnfBRwTjT7YTNPIErBVltRKEDJx20Y7uLTgHMGpzvT6hyR/gfVGohMnArupNDjLFjhWRzrzNkqbG7Ex8WWAgGaZ7uBV6rpdIWqD/isrjmE8p41FmhszAHTlKyRZBPa7s6T/HrWpWFX8fpR8xYQ7PAm9GSHmF7scTRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909078; c=relaxed/simple;
	bh=NavulAZcUi0eZ9b2gN8RYlTJDeWWfeZQ3A3ypqWzAAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dr6DCdNQ6P47ZKbixR+kHtFjkpEF5Orr3eN5OZELN/3iLjaa2lpTUAmH3+w4D5MlJcgl708As7coEtmL5TQhHeuPvuM3bcnjUss4TrjkW1Duhohwj0kndTf/nBEE+Wm+e0wLQDcif/oE1xJIfuNh6hGMIee11z6uYqP/uRYnb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vYkTtk9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACFiNBgh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vYkTtk9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACFiNBgh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A3A971D00451;
	Fri, 24 Jul 2026 12:04:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 24 Jul 2026 12:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784909076; x=1784995476; bh=MCOp5xNwYC
	8rXF32jSv1r/jPyzNDFZVb+y7AelP6KWg=; b=vYkTtk9InoQSz30De3qvUs80p1
	C8khfuopexxdjV7rwjvY9gOtWqjN41xDiCnOyj6K5GooOXTWm9ztAIC7vXLEdoex
	XjTxvSNluc3D6oEuMsjr95+wzCPYRbbQRsguHl2Mr666muQtc8zan4cdClZKIufz
	k6ebfF801ueUe+069tEEmMlNIKC8L8Q7tqfJjG+qCtXq0OVWuE4MZwxiOlNnLu7J
	Foy7HPUEVjXAmCOfrvae9MzZw0wqqRDBM0GfNhrQwX0qwzlE2PO1ZrFYrX+yBKcM
	xH27gX2kJG/eXIHW5PAULS3MhbDO4ePkoJk3qCU64jps/RRsxP9zhymiEhtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784909076; x=1784995476; bh=MCOp5xNwYC8rXF32jSv1r/jPyzNDFZVb+y7
	AelP6KWg=; b=ACFiNBghTT/obhHYRJhrvQonDHKkswV0z8Zl7xbCxCCL+tiFiRS
	G1/bRMHGfvK9Q4fS/g9FUaKF/t2btb8xz8vLJsuBAyk30J2rTp8QPlCe1cyZxc1R
	BPOCoYwtMp+QK+EjckKw9Xq03gSsm3aSX8H+P6+huG7yQlxeHtG/EhJRXfmCST2F
	coN8C3lKyoOjmfTIQQdSF2bQMAgv4MdUtIEb52UF5SxB7F5X3fyg6DH0X9Z30/AI
	mMWo0SRo1extzvebMVpNxFnNX/mrn/lQ8/Hb9gtNe/v+EXyrYaK7TkqX6C7e3U3C
	FO5ungDCrcs7pirCkM/tdUBsmayBgvXqBdg==
X-ME-Sender: <xms:FI1javsB9op7Pl3bpgofgc-vwibW9vudps6mO-eWYJLieCwxKQmTLg>
    <xme:FI1jan5RvF-2OiyCFMhNjWw9SK4peiVUzhFPbPAxX1Jahr0beqAIW5fX9gv9U3yYe
    Bh7HDThTt2r2UYmI0li2PNQswNDZU-2a-nN7HJ5Y5BuijQxyoNx>
X-ME-Received: <xmr:FI1jagLvC43Y-Bw_9ZuQL0fDciIpbsLe2Q0B74LTbHo0yzS0fBrsWevLSzLm-VXTApPidQHAVDXSjspeP1t4YmYhKa58eHcgPw>
X-ME-Proxy-Cause: dmFkZTGImhkXXhCk4Rgg6JEKS/JpZPuSNMcMsWr0IxtkBzI37dYOe70W1Xgzw5BxqOa8nB
    oeS5p7Ul+S/VI85IJrFBr1Hd7vA5uOSOhEMMYpFU0KOwij2ix2dVYzRJeFg8wuBm5w/Zcb
    SMz2kRiK3lsYgQYs3PAx+GwuFzrPvZ8ErPdL5sL/boydkVRVolGQROoHXc1K7lmPoOiyFk
    1ZSNE/UbCVrOp9g/wqRnUE4l/c33z4OyALBEzWdfVw0FIp2lsfWbG+OHKZfiO2D52+26ps
    ClUCU9kWAYdHGNZ+jBZaXheFwLglbNy79brkef5n6WmIMgqGL4APMX8vze9fRZs3tWJPUN
    sWD+DcJA4AU077euKJiiBMB9t8s9AByemnbdFKJ5Qa4UTU1iaPUwh6ycMlo+vfdXZir2Pu
    6OBQ9vsH3GDJ0xv21AhAR9oua5JbpiuQbpy4RxxNzVJfy8Vu0DTr0Pbk3Lu7OD+mopGUaN
    EyMWX5Pciej2dnan4VeaGQ9+ztVFfzETf/a3EOlDDXOaBBpusP5lNb90n5pkbFvHlcErKo
    8AIvSuaLL3MdTEYcwDnsUHu9X0b8k23A/vsFrKosYHJoZ5qQFCxl2B82GOtz9HB8P4vtka
    Mt7bsMd7wEm5oUBf2+O6gDBeG723Rwj2WBTmhalVsjmJTQzwt4Yxz8jciJow
X-ME-Proxy: <xmx:FI1jan4Tc8G03wrJ15Veuubr49X8sfcxSa4FZcsgu4ajb7c7rZ55Tw>
    <xmx:FI1jajz8C2hLl3Dp60hfR2nir6UxvwQqniqDMSB9lNmk_GQE7dRQow>
    <xmx:FI1jarbOmauTGHM8V_SgEOnLsZMGyBHuTM_zdeHMcbrOpsz8DAaL_w>
    <xmx:FI1jalSRzxG-RsILeiytI8IXcc8AZqjZvF1qDVjz9y-tHBgJnlSzcQ>
    <xmx:FI1janLyMzC7mZfBOz1zmsypP1J4U_EVI8vxmUtALsWfsaWc61diTho5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 12:04:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Friedli <adrian.friedli@mt.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH resend] builtin/clone: fix segfault when using
 --revision on some servers
In-Reply-To: <20260724123735.666021-1-adrian.friedli@mt.com> (Adrian Friedli's
	message of "Fri, 24 Jul 2026 14:37:35 +0200")
References: <xmqqfr19lmau.fsf@gitster.g>
	<20260724123735.666021-1-adrian.friedli@mt.com>
Date: Fri, 24 Jul 2026 09:04:34 -0700
Message-ID: <xmqqldb08jcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Friedli <adrian.friedli@mt.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So this patch fixes the issue in the right place.  It would still be
>> nice to have a new test to prevent future regressions, though.
>
> Thanks for your review.
>
> While implementing the test I discovered it is protocol version 0 which
> triggers that behavior. I updated the log message and implemented a test.

Oh, the proposed log message reads wonderfully.  Thanks for digging
down to the root cause of the issue.
