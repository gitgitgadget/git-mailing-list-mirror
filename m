Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E53C98AE
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941397; cv=none; b=aMDCVCKr436boxdgkqrc4rrIimbi2p30kKlMTtmzGtoK6NWEFU15xWOqj5S2LoGz/s/LQIIkzE+LcH/BYm1/MX4lJbN1pAnFs0K/JNtScI5vIzprPRRXOHAxIQnD6OYFBYVY0TkMNMGv9gh9P0zSeVTNZ20h9VmG2oMUEVQiS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941397; c=relaxed/simple;
	bh=TqlrOEY8QZr5Rnoj2wYjlJkyfykyIqVaj8gK93evYrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mIxqrscQdwYYqraOyo13d9trbl5cr60ur9PSop9rG49JHTYvKUuf8KIcMFNgH1TMDz78BiYsqIPw8oYV7LpO1rqYA0ITQs5fIOn7eCt6mH9rmjX+3K33b91vRqmKAUt7JWXBxN9ytbTzJr/B9N0zv+7POcz1yiLHFeiNazk+o2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QW6OTCFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1aSJsEc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QW6OTCFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1aSJsEc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAEC814000F9;
	Mon,  8 Jun 2026 13:56:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 13:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780941394; x=1781027794; bh=3VKxCw7W6t
	uYLB3G8ry3CmozuI7hX45qYA3ZH+AkOrM=; b=QW6OTCFhic3epR5FWP1CQt6WqN
	3P8Y61ZVRTDNpT85pgxeNOvyGc8D7n293rBN4qRwHuIdcN9Us3D5HQZQsuDMVpSr
	y1uDfGYHbdmIl9nLX5oQne0yomQj+5XlnSg0jfStl1KHBAa+oGRbXuh/SnCnSoQw
	ltAPiT9yMOYZDdOKRrbaqzzh0dd8QNUqdo/9N45EerGsM329yuduW26s9nBLjJ7Z
	iMV4sn1aX1YXfCwnm9K2Qyb27NdpJ85Wk4zzsE/CVbcYKuj2tGLqZ1zouYHPQntu
	0LdqhAhvBDDWQ7OE+jOeazIDmOlwC2sEGR359+0GPMW6e/fyvVM4lu+wa8Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780941394; x=1781027794; bh=3VKxCw7W6tuYLB3G8ry3CmozuI7hX45qYA3
	ZH+AkOrM=; b=M1aSJsEcq96j7dhXp0kW45N0muSZplNfqCQlLyqqfUORtE/CC5l
	51sAeiXckuH2sOtYc+m4QtdW/XD19iWcKyYtkAuZhrIFxPGyEb6HlhRoCWdNPkvK
	DbbeZP7Pgj+jmGOY+K91ilbszDa1GWCbxOsQsHZgh8K1dFJhAaOnLWfYd/r4NmPu
	9G3DvMDo16DnlliG7GcuLq+msAGUxd8Lo0uFpWTRB8Nx95zrV9CF+4RelrpwXV7h
	+nZd8stzcJM5Ba2hM+nD+D3jIQknrk+4Zm8WjgVT4/KDbNpL8oBwo/nxJl/laOn3
	bWDfhgwKf7UyNyrT9Z5YVLynpNRsszIvzHw==
X-ME-Sender: <xms:UgInat3TJ5QI0eSLjdZT71hqgWyu3xHBqUv7fThMpfGaICuJy7LY-A>
    <xme:UgInari624Tu_M7hT04fxjve-2kH_Nn78r-md9wxZUINjaFpQdHSrDv7-fX5XioMQ
    6US6SiSil46okdP99kTl6wMKshYq8ZlL9Gl061R2Y7cx6EZow4b>
X-ME-Received: <xmr:UgInarTYbeGd5l8rRXvSgHhpCM0q8Dh7Pj0fQ59CGyvXdhsh27TunOsi732SecORU4WXwcmZJheW7qVi6xx4cb7TASsSXLDjajOi>
X-ME-Proxy-Cause: dmFkZTFrGXhZdhIWwmuoJLkdHOQBL6H+CIbh823ded4rt1Vd19b+vpQX5A1Q5z2omXtcPV
    58EnemDTinm6x3cjkBQn9QrT5iLOQBs1L41bxWlR4kP6SI83ipytZWL1IFGNpr9lwMNl0R
    vffkG7B8tqfLJtWKZ08RYokSfDpgShq2hCsFZq401LORHetK02n0TwSLcNM9ucl12I2hzp
    wWwjK0Bd2+NTPdB3PtSvJ4bTcMnRfu/v87dKboQBvPiVyVPKVW/cGnlr3zHnuuBWUajHvl
    sIxoA8I5ZhhroJMipGNhR8SelYE2Xz41azgyIJWwL9qo8HAcohM4EOb8ynMR7p/TpZnvbF
    aDRudwVhyv1AnY9v3/UPZdVs4M2HQsd5rFRS0uTJxk/1DTFLFLRJhAUtYOSzpLZuXwhZEp
    aFA5QS09eWhAR+KaZpvcsA3r3hFwtFOxPvK+0hhU1U5m5KM/ablyAG/tubrBQd5ayhM8Oy
    b7PnN7Q0Dh4S+OT+XkaH1IAOCaHjIZxkQTNkceowmrhIlgfr7LsWWa8C/eYGmpz3VFoZAQ
    yNkbt5c7kIx6K/+wNXAUv/iKlp9KTtJMx0i6O3HsjgxluGwZfoRNWZHzoQqBV+muDInKiK
    OvuUNEpDP+sfYGpTkvljN8sQMV0f7QJwjvmL0Dpu7MOQDew9fdBcXBtIzwOg
X-ME-Proxy: <xmx:UgInakiAMXMCmomRLcdGQVWOrJN3m9x7C95DyUO4XDKeI2el5nPdvg>
    <xmx:UgInaj7KFaJXko57pLiG6hVQz1GysLWgvLnkm2DGADHblNDJhdLivg>
    <xmx:UgInapBRtNbY-4Bm_oL9wi_8QJIIKxd7pWa9JvgLP-yfClwD6sQ5AA>
    <xmx:UgInaiYkoerwiPUHAmZbWlerR12Y1HDMgHs2GwR9dqqJJ_pOgW1YcA>
    <xmx:UgInarPQgKSw5qM8YbPghKB2u9CTvhlIQwMlC5IJvPcmH0ZVvUqo2S_i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 13:56:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vincent Lefevre <vincent@vinc17.net>
Cc: git@vger.kernel.org
Subject: Re: inconsistent order of --diff-algorithm variants in man pages
In-Reply-To: <20260608112656.GI1082778@cventin.lip.ens-lyon.fr> (Vincent
	Lefevre's message of "Mon, 8 Jun 2026 13:26:56 +0200")
References: <20260608112656.GI1082778@cventin.lip.ens-lyon.fr>
Date: Mon, 08 Jun 2026 10:56:33 -0700
Message-ID: <xmqq5x3sx6em.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vincent Lefevre <vincent@vinc17.net> writes:

> In Documentation/diff-algorithm-option.adoc, which is used by the
> git-blame(1) and git-diff(1) man pages:
>
> `--diff-algorithm=(patience|minimal|histogram|myers)`::
>         Choose a diff algorithm. The variants are as follows:
> +
> --
>    `default`;;
>    `myers`;;
>         The basic greedy diff algorithm. Currently, this is the default.
>    `minimal`;;
>         Spend extra time to make sure the smallest possible diff is
>         produced.
>    `patience`;;
>         Use "patience diff" algorithm when generating patches.
>    `histogram`;;
>         This algorithm extends the patience algorithm to "support
>         low-occurrence common elements".
> --
>
> I think that using the same order in the --diff-algorithm line and
> in the description that follows would be better, i.e.
>
>   --diff-algorithm=(myers|minimal|patience|histogram)
>
> FYI, the text was added in 07924d4d50e5304fb53eb60aaba8aef31d4c4e5e
> in 2013, but without any explanation on this difference.

I think this is meant to list them as equals without any precedence
or preference order, so it is understandable that nobody paid much
attention.  Until now, that is.

I agree that being consistent between these two places makes tons of
sense.  I just do not know what the right ordering should be.  When
listing a set of equals without any precedence or preference order,
the most easy to see to new readers is alphabetical, except that the
built-in default (myers) is a head above among other equals, so it
does make sense to present it first.
