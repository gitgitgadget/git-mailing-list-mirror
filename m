Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80E3EA66
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359818; cv=none; b=Rx7GmSBeS7kruFVUdmIeQUEafuBS1QZop4tUlIId3ySlWHg3LblVdox8HdgeqS/cz5EXCZhvc2ISnrrEIMyI/VKBlIzpj7tX+fKd0+x83H8F74TktL+ziRA8YxBW/Lm8tuTYNM467F10WgUARWKTBVbdPVTTK8GT3ovKke36vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359818; c=relaxed/simple;
	bh=JfGs3C/EGpZS95X9dp9cw5sXUvnSBDTOmdHa+SAj6zQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyO/xFtBCommq0ro33vAAO7pj3RVsm0EhYza9jDZz6OBytNu2IuPWm5Yb6GpZDImOotoy7/5SN27Z6XRValv3lfWyBGCf6RcJgzQ5PRWLTFJJFE2VA8e7QyLHjFaEfGYD4nh9Q4n3obQZf7/ceFIGRIB1e54BJzSRwbunFg5Yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iqZYHzZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ewTElnnD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iqZYHzZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ewTElnnD"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FB17EC069E;
	Mon,  1 Jun 2026 20:23:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 01 Jun 2026 20:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780359816; x=1780446216; bh=AU4ti5iq9N
	S7HU5f7pGOI6eyqs8Nst4FfoSmdVl4kfI=; b=iqZYHzZSvC7saS/LnSWyitxDF+
	Aomz/CndA3Uf7Rv18m7LC1MaeUZtI7Qgq69+JjvvVaBaB1RXMuHVxerEbk2xEYOf
	fqLIhfx+MyfS514o3FGQzOlXFZls7qzAYZVcjkTIlx4IqhsJZM8PnG9xiXhz5G37
	LBMth1qdGXJDpy6Y/XFPJjmWOikWm7XJ8F0eWiOGACJPVMqYP4g+yeC62uFZ9ZlO
	OFgd3XaBppnM3PAYiXgHOCne9U3nxeFA44eyig8EnwtWCT35rBPWc7xvJ26LOG01
	JeLhiFGZU2dSVkbp3Y35m2FNLUQVOac3YCruHlfNAczW7eczR6lmMQ1d4+Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780359816; x=1780446216; bh=AU4ti5iq9NS7HU5f7pGOI6eyqs8Nst4FfoS
	mdVl4kfI=; b=ewTElnnDWXByXXUbSyTXZBjl1wAe1vZPcFFmiMUdRcXRVto/czu
	K+VI8qV5nqnM3IBTGlwW6hTPDGYxYb4s1bfxEn0Vj8ejyLx2oOlpLN/4X0m7/Dib
	egEpYiS98LWaKkRqokwmF+w5G0Db5VzxBDFkaDKBb4BdxxpGWa+rPoNIVp8BbJIY
	LvDkne8k0fUsmnE4eS7+lGYykTT/nqEN1QvppiXw8U8z682qws1tqiXdIbaA+Gvn
	12fEdyJokTO27ekHdmlwZgvNJDFahY4IOqD3Y787XmC0ip2np/jOweOJcGPCKBeK
	4Kt4P5pA3uCW85cCedUAgq96YxIIt3wOYlw==
X-ME-Sender: <xms:iCIeam8nbIkjplz1EdNf5_4u7kJeqLKkbQSs38eo9Rq0LNWTMiRJzg>
    <xme:iCIeauJ7oPz8S0yySI64dHAgISOKQrQZ-jvt4yIayl4YzgNLqVtLifChBFX04D9V_
    PuebOxX3KChScCRmjjWCbIPE-nCiD1iuMPkPhCIWjyij583rGVvKw>
X-ME-Received: <xmr:iCIeapbTdyTiPBhRhCYkGo45etEkJyijeCcc9zvQuxiHUnGoqFq2qQzCBxkbY3vLwE27EMdbJ0_zI4MC_tUflfE6gbQO90di4cHj>
X-ME-Proxy-Cause: dmFkZTEzB17MVxf9sGY4Ytht6L4hMIc/wb+nPXj0A36KBRIzeeMUX2QHsTQei6qaqcVw1U
    uyv2+YxUMCzAv6GgbEc1WQxzuk3UtH3OZJ9d1smuvaJYRH6PkOJVxJ97MVTDZVE98a3Z2h
    /J/awcRg4goE3LjtVgwGMaIJ/9sWXCbFx7VimTx0PY3QkNxUPGUDgJWmEuxZiGV5IVyYUq
    0TJ349gLlpZxMmo24o0PW2aYBu4o6jwjWvuyIA80/5u77oFJJJ5o+Sl4IAaAkgEPF1CZbu
    u7DAwIWVdgqG6GADufS3pxVgBEVDXHazuzrYgM6CGbFhP2h6f2+vUvKg7nh8Hmm85DuaiU
    Gr3KW5+QqxYP1lojsoSpWqd5JZ3jXsiiYOoxDgRMtnekZ7QBgIZd7Nw0PwuXzZEeNo09M6
    PnSozjZ7o/z4DQ8xwj6FI1o7I1G/0e4DuwoiEi3iu2Nxo4/jFB6HFntyrXMCSnTFYQV5B3
    dAmW154KUFNsjSLZ2u9EmYPNO7aGNoqmFVTnfSTUd64XIb0M5+GYFEcNynLe+AJl4dVLfr
    fzZ8Za2Q13Jwiu4XQEwKrzp0JPwGbFLbrs/jF3NqNITEh561+1TJUGYJUW8y2Dhn2RjYqi
    0Mqtw7sqNCPDvdbgu3OibVn6RaI7qRi1J47EHMWGhVqQMrTK85jiHRutkPVg
X-ME-Proxy: <xmx:iCIeaoJeMDqI7bgUwZYfKh0G8_X3I5R_RhrS8OKxzXmvTOvsKZmNgQ>
    <xmx:iCIeavCEuoH5rRUwL95aeDzLBXe-Pxz4HBgZ1hwcdEdF_zxwd1gV4w>
    <xmx:iCIealq7q4fJ8RVBwKXTzv12pnlWUblma7I9M7mhbcbr-5Bx5Dk4fg>
    <xmx:iCIeaiirPD9NC3g54CNlNb78A6gb2EfJUO9MYzrpT73oFa5Qq9Rlpg>
    <xmx:iCIeao0NcATQ64lejEyhjGun3hbRTh8b5A8yfE8AkY_rEAQvI0WAbeyZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 20:23:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Luna Schwalbe <dev@luna.gl>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: document and test `@` prefix for raw timestamps
In-Reply-To: <20260601213944.645731-2-dev@luna.gl> (Luna Schwalbe's message of
	"Mon, 1 Jun 2026 23:39:45 +0200")
References: <20260601213944.645731-2-dev@luna.gl>
Date: Tue, 02 Jun 2026 09:23:34 +0900
Message-ID: <xmqqfr35zt6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luna Schwalbe <dev@luna.gl> writes:

> diff --git a/Documentation/date-formats.adoc b/Documentation/date-formats.adoc
> index e24517c49..83f676585 100644
> --- a/Documentation/date-formats.adoc
> +++ b/Documentation/date-formats.adoc
> @@ -10,6 +10,12 @@ Git internal format::
>  	`<time-zone-offset>` is a positive or negative offset from UTC.
>  	For example CET (which is 1 hour ahead of UTC) is `+0100`.
>  
> +    It is safer to prepend the `<unix-timestamp>` with `@`
> +    (e.g., `@0 +0000`), which forces Git to interpret it as a raw
> +    timestamp. This is required for values less than 100,000,000
> +    (which have fewer than 9 digits) to avoid confusion with other
> +    date formats (like `YYYYMMDD`).

Does this "additional paragraph" format correctly, instead of
rendered as a literal block (typically typeset in typewriter font,
monospace)?  Don't you need to do something like what is done for
"ISO 8601::" that appears later in the same file?  I.e. lose the
four-space indent and replace the blank line before it with a single
'+' list continuation operator?

> +# pathologically small timestamps requiring `@` prefix
> +check_parse '@0 +0000' '1970-01-01 00:00:00 +0000'
> +check_parse '@99999999 +0000' '1973-03-03 09:46:39 +0000'
> +check_parse '99999999 +0000' bad

This is totally outside the scope of this topic, but we might want
to enhance the rule a bit to declare this is *not* ambigous.  As
there is no 99th month or 99th day, this cannot be in the YYYYMMDD
date format.

> +check_parse '@100000000 +0000' '1973-03-03 09:46:40 +0000'
> +check_parse '100000000 +0000' '1973-03-03 09:46:40 +0000'

