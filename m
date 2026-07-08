Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3B3126BF
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492972; cv=none; b=MIDyUi2zSAcCsrS+eeVFRQW60mAjh6DAOTuude3FF2tyGs9Px2vNsbx6Ut7Q/GdYX2opCfeNMYw1VlCwFOA+JyuKo23fx5welEmGbjL8Nm7nEfA0zxZcndYSHNAZzmG62xPDzG3nTyCSQ0CRVczd6uRMdkpUm7f7ZjBQPAPtDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492972; c=relaxed/simple;
	bh=i4Bn9bj9D/1fG1sQwoHG19bsqyTpkNaZhBp2Ijb+wIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cw0+3yqsIrYlYAEr6PNrI7w8b7R9KCTQdevqPVJZOnmR5aBz+lRmoQ4gP8q4fiOK2vyA8gwoVa8mBAE8avRLwXmwiPPB3j/GG2nR7+kcmzeQXr2Q8DzVIDPchWTW2mbS1p6z+qkHLNFEVvyP8T/0/iklGJPn0wI6FHn/vlSBSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VZEhQA5K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8n6zcQq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VZEhQA5K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8n6zcQq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D1871400035;
	Wed,  8 Jul 2026 02:42:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 02:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492968; x=1783579368; bh=r9kGySvKO0
	ivuHYulkDgW08k3SjSqgwA9NVIYKDiyK0=; b=VZEhQA5Km0QGYS1FTrHvSYVaas
	eKXtGMqUZTp8+6iLJ1aboFQy1S6v/pr5KpUXFPYEzBujPi7b0w8EIZR0WgsO1YU6
	WLCvBRWr89De2yf40Vj4QEMl6sYrx2Vb03KhX3vi0VoJBN0PmH7rSzb09E2bVpVE
	HNKydf26dzgryafPn/kEZ+DeRcmlI2sVQQ2s4mgqR5huiHF9Q1N4OqSoh6G3mkvd
	MQnD3kShVVawCviYtaV/VZ6kU0oUTHPGnX83+c/lMqXuUbWCVLahtST+KiMxWtvG
	BhJJP5oXwP2i7ExQkC2beiRirV7lDW3TclX2hIDljheDqo9Cku12KsFoXvog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492968; x=1783579368; bh=r9kGySvKO0ivuHYulkDgW08k3SjSqgwA9NV
	IYKDiyK0=; b=Z8n6zcQqNNFYGCH1a8Lj1u062igrqWTCSmk3ZYb0lD5i5qHDULj
	LJm6KDwHArlg3rHE5kLLkgDF20NFeNokYATxkJ9eaDB/eDLHZXlNS74KIUAHhl9R
	cWmpnDQabsHRFYUJgngYr75c2nhTRG2bCZibijY9jpng7mQMeyF+z3YTHlaoQ8tq
	9ieBm3Whwk9lNKL6K41pdVAPCWL6zLh/iFnpXx94w0W7i3Vo1mQ/z/QICqtbXi1r
	pKxwoSz5tpjVqL+0mnkjzzQANpEiasvrDbPRoOpoNcBAu2lblJ6w9ULcISxx/vcg
	6PgUm6MT8VubxblAoP2hFP+ellLH/X0+CMQ==
X-ME-Sender: <xms:aPFNanx0YRSRK4oxjOhefuZ-gcRjl62rl-kFmHK8-p6lg2vPj6qf5g>
    <xme:aPFNamv4R9jm7inGmyNg0ZQ0PjwWcNDWWuPw8f6IqQBKVn1zeXWd1_jT4XbfQHhmi
    DTUist8wZw4H_xwBI3S-NWGlLjEk0N2riVEFHUD0wBMw2FO6zMdzQ>
X-ME-Received: <xmr:aPFNauvv9sBafqUm1kosSV9GOzyt_fUESMJS_xJZXiYzKW0vxkBvIbkJAP5W0UQPiDKrrPs6QKBFayN8ma8g3VGdvyFDyOz6q2hNW5gG>
X-ME-Proxy-Cause: dmFkZTE0P9wlwrtCswMIg2/ic7U2lUS6Jy9/dW2+TnwibIZm2bzPOdDiBtDyp/hr06HXno
    m4OYQ9BdJe2SB3VH4Dm2iprZGjZO4jG8mjl5R2XcEAoFtYFYncBtXjYal6R2nrk5HXou12
    oHeShqpAVGM8s2WzL7xUeqK0Zw3uUgGObAUti3l24VI6ePNkg/uftIcaY9ltiBYYznD+MR
    WDPz/At7FXhPYCQC3DPbOaMSqll55JEK8yUddn/BdbiL98J0oQN23nDZ03VcysMUU89iHM
    Br0fUmhb3tv/cDgkhhdOoybEsAXYUgL7uWAHSUUHFxB6J4PDGKaw6ltTdPw5MQ+RkNsgGN
    yXb6VtpUQ+MNKzSyCt7g7xVpaCXXxTuBtpV7c1gFWKYKpNkyQ4TvwM1L1/hDi1dcBpgCIQ
    QIhTQgFdM53a80vu4eDCgdRo1hjKYqecwuWdvgljItUqRYnEv33YfrL5lBXeBwhe3g5pHX
    6D5TNFuOqtYnc+8msHFmEHynw+QesTCsFR+Cc8tHEYowKSORnKurU9VRqslIkqqErzSBHg
    fk20nAV5T2QnaPPjd/zE1PvcVVP7FfzCgTbl9W1W6eSevSORynFnRemP2w5IfzH2ZcSP1O
    ceZS4EX9tiJhaAAmLsiNjdP6iezPP7haX4ZXMcEa7APILZxxvj+pI966HAvw
X-ME-Proxy: <xmx:aPFNarPMH-RqvYF0dO3cvqTovto1YUy0YGqOO3pKIRfYURiY2dR6Tg>
    <xmx:aPFNas112AyQV5wnHxaWHkjbfyouAFJMptnLZEj2YLzVoWCR73DzUA>
    <xmx:aPFNanPXjVsuohVuKSIPnRi_2SM3WhsJsUfkTDNnwNc0X91uAg9O0Q>
    <xmx:aPFNas0XzTCwz96ynPEElaY268uYjp2kJyBz3jJEq350wxn7y0tlTQ>
    <xmx:aPFNams2raXea-U51YZ_0ID0P33VINroeCRtgOBVB4upRSue3AJR27-P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:42:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 739421ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:42:46 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:42:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 00/11] receive-pack: use ODB transactions to stage
 object writes
Message-ID: <ak3xYym22Z7PFZ5y@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:01PM -0500, Justin Tobler wrote:
> Changes since V1:
> 
>   - Adapted other "file" ODB transaction helpers to be more consistent
>     with current naming scheme.
>   - Removed redundant NULL transaction handling from
>     `odb_transaction_files_begin()`.
>   - `odb_transaction_begin()` now returns an error if there is already
>     an inflight transaction pending instead of setting the `out` pointer
>     to NULL.
>   - Updated `odb_transaction_env()` to return an error code and append
>     environment variables to a strvec provided as an argument.
>   - Removed redundant setting of tmpdir environment variables for child
>     processes after tmpdir has been migrated.
>   - Split changes adding ODB transaction flags into a separate commit.
>   - Consistently wire the ODB transaction throughout git-receive-pack
>     code instead of reading it from `the_repository`.
>   - Updated user facing error message.
>   - Updated some comments to better document functions/flags.
>   - Clarified some commit messages.
>   - Fixed typos.

I've got a couple smaller nits, but overall I'm quite happy with the
shape of this series now. Thanks!

Patrick
