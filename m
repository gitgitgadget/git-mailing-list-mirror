Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE6369D72
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368865; cv=none; b=aNwf+FIkF3lZcprYsQoVfwYAVi+Chnw4ZUlUT6pTuYzhcuxGE4Rl+lgfJVj/8A7v0C79Fqio/rqkm4qdp/JG4Q1mP2zbFhzE5lN6jdlBL0rg0FRVDZQOofB0bK+O54uV5SD6g/6/v4PUr6zG6GU4CHJVnP+3MMt1NyWqOviBeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368865; c=relaxed/simple;
	bh=W6dVKTRGlM6d5Gx106tvXQtElMiHqSWIRhehgWIep2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PM4xX/MenIb06NsWSgZj101q3UoKGN2b4ef2o9KR2/GG9Be64WhJPt0dR/LapuVaTK9NXh740b1CFXxbUtTVEZfGB7RzfkFmpsdMhvWEeZ2Co9Un/qYSM6pjYBTDFl1JfVfl5ihePDVN0tYI4/afuSgRUIlexvXk+eRcVPryJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=onbziwcP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6Ge1i9v; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="onbziwcP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6Ge1i9v"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E138E7A00EB;
	Wed,  2 Sep 2026 13:07:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 13:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788368862; x=1788455262; bh=OyW4ZecGDy
	wHtOmzob4VoKxzH6ImsqSsKkWN4PqIzhw=; b=onbziwcPcVxx0rsnars3seP2Yi
	7TRqdg5yU6OCkmKw/rnelIpiux8D6hhQh2jyxQDZXn7ZwOkmsOEAqdR7z0uzg8XS
	92Xg855iedTZPYtc1Lo9X4aSFkHGVbi8iTmNBDRm/vh+takl0VLUC80KDA6q4qjW
	VIMtEA4mIr59O7+sD4a1NM485YjhvlgTyNhnNEn+qkK5tJwdWc5XlC13eguQb1xF
	EhFiMlXjvEzhFMY6N8uSdscHPOM4luLts4hDfyY0tZfngMNi35OyxvFqp9WNFleX
	L2VpSeXBed3G4mEakI+2my2feRmEwxN6LrnC61HwjfvdOuOLMeIBmr4PmTMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788368862; x=1788455262; bh=OyW4ZecGDywHtOmzob4VoKxzH6ImsqSsKkW
	N4PqIzhw=; b=p6Ge1i9vrWiaJQLBaV75sSRJlzonRzi/evNCgEHkUDoZN/oJn9P
	31CRT2kwMsOpL97/AFeYeavnHf9Dg+A/nCD9N7Y9woNIer9I2qUw1L8/2ZCKNsFO
	ptd46VEk4txORDoLmQMpwKugOw/H5SX9pNggQPPK6+jnFFCTgei1BU6oWh5xrqx5
	rUNO6Kt91ahMCevRywcXP5TVgOUAepefbZvw5VlI0ibngVz7ErleJc6MOZOxamAc
	7mZg26JR5oWz02FJpr4tlFHm/Z1Yum2SVkjYXyaIQgx9E795qz/Pxw4ix/3dI0mS
	63OSRc1k41KTUHyqVdNk2iLfehngpXsQZMg==
X-ME-Sender: <xms:3leYakm6cBZ7QGTsv342TtRlGfMe33hN8D5udp9P0Ou4ZpGqebjX_g>
    <xme:3leYarTeepAxE6zlhvIwlhcovoJHXmNGrB2dPJkoiAkI7mwd2NbrDU1Y_cTO3RDbO
    JLB3JwYo3zZ4WC2YqGMB7goLJ7dP_EzKvC1VSRnJ5D5o4x5PdwY>
X-ME-Received: <xmr:3leYagCT1IKj-FsmF5INJE-RjlextxxSVzOoaEuYPd95qCpXkeTNcbDSHGiqR5ZxQoMsSSBxEG6iHsHlJuL2Wvp--9kyJkICkg>
X-ME-Proxy-Cause: dmFkZTFbcIWPACIt7dlN2scXowfp06YbRjk4RDsq5ez4jAw5CrSV7zA6sTNlEfdjhHJ5Xt
    SDJPIGQ44b1eL5Ad/PcDbMBru7al58yS7Lp5RxrSjFP79cbKn1oVPCoep3rfPwu+lBPFqk
    z4Nh0p0yt6Z9/GV5Xj2V8zUdZl+ZZ7It8L+zaNhsfoGGk941htuKu9X9Tn6VVdfbISx9kS
    aK5xjSng7adj4NpZuZucd62zpZDXar+B6lN/Wz/GTvaw5lN4f26woUwJ/S68VM6FEGW3If
    ZXhqEiQu5Z3OnsJG7sI85HJX+gbGMKNbggcEthFdPEwcSdnmhtpJad2f1tom4xoJUUcjBf
    0YbftBfhCYk398ArHTZDFSG8HqgbEdphGmf3g8ESYMpq+Px6Ynp6Zx1mZSZwXWf44o+z47
    6pKDkB4FG2P1jjUq5ECBWUSDwYR9yNOaBVIOgO1X46YKwzgpzj4TViMbJbIAfGO7TRRER0
    oIHwZwbWq605bWIndsM0M4WuFze4ZGnwpk3yjBKeRvr63nLjZdKNyZNHbbyHRShSX6T2W4
    6wjEQmKbufFfi1NiRHQRLr+DBvGkqOun5rRZ0KFgnjz2HesUyIYp4lA1OloInj6rVixp+a
    tFBvkqSxZY+ZK6EqV+h/TLT7+TWyCktsMWucyQsWvfxBcAY60GN4cjsFkgAA
X-ME-Proxy: <xmx:3leYaqQaXx1Hxlcz85qzB4k_9MoLF3oCfe9T3cpF_Uh6VvGHGeyu_g>
    <xmx:3leYamor_yS1d651RajdqHDm3pHADPtNmRywMoV6ifXTphPwQkXR-w>
    <xmx:3leYakw58P0PJSRYMDsJD53HkT8s7FEQCTaNckJWCxj9ISoUChW9bA>
    <xmx:3leYajK3pRo2CgsMI_Oy00nscz3YEwxA0mmx0aFwepM7mpmtVD-3Zg>
    <xmx:3leYaiOnH4i1t2CKe2uN1Ut0M5xWyLwT_bCckajhUoNJKu_fNjCTpbOU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 13:07:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] dir: find common prefix among positive pathspecs
In-Reply-To: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de> (Yannik
	Tausch's message of "Wed, 2 Sep 2026 15:04:09 +0200")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
Date: Wed, 02 Sep 2026 10:07:40 -0700
Message-ID: <xmqqecfbk2eb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yannik Tausch <dev@ytausch.de> writes:

> common_prefix_len() skips exclude pathspec items, but uses n == 0 to
> identify the initial item and items[0] as the comparison source. When
> an exclude item comes first, the function returns zero even when all
> positive pathspecs share a directory.
>
> Track the first positive item explicitly. Return its match and the
> common prefix length together so that common_prefix() and
> fill_directory() use the correct string. Add a unit test with an
> unrelated exclude before two positive pathspecs that share a directory.
>
> Signed-off-by: Yannik Tausch <dev@ytausch.de>
> ---
>
> This patch is based on https://lore.kernel.org/git/0CA8678D-0540-4A2E-B314-B9BEB04E2BF5@ytausch.de/T/#u.

I am not sure what you mean.  Do you mean that the other one should
have been marked as [PATCH 1/2] and this one [PATCH 2/2]?  The way
we use the phrase "based on" does not exactly match that situation.
It is more like "This patch applies on top of the other one", or
"This patch depends on the other one."

> -static size_t common_prefix_len(const struct pathspec *pathspec)
> +struct pathspec_prefix {
> +	const char *match;
> +	size_t len;
> +};
> +
> +/*
> + * Find the common prefix of positive pathspec items. The returned match
> + * points into the first positive item and is not NUL-terminated at len.
> + */
> +static struct pathspec_prefix find_common_prefix(const struct pathspec *pathspec)

Our norm in C is not to pass structures by value either as parameter
of as return value, unless there is a very good reason to do so.

Since we can easily use

	const char *common_prefix(const sturct pathspec *pathspec, size_t *len);

to return .match and store the length in *len when we return, we
cannot say that this case has a very good reason to use a structure
passed by value.

Actually, I have a feeling that we do not want find_common_prefix()
helper.  Instead perhaps

    static size_t common_prefix_len(const struct pathspec *pathspec,
				    const char **matched_prefix)

may be an alternative that is easier to work with.  Because the
existing callers assume that pathspec->items[0].match is where they
can grab the common prefix from, they should look like

	len = common_prefix_len(pathspec);
	... use the first len bytes of pathspec->items[0].match[] ...

They want to be told to do this instead now:

	const char *common_prefix;

	len = common_prefix_len(pathspec, &common_prefix);
	... use the first len bytes of common_prefix[] ...

In "use the first len bytes" logic they already have, they know not
to memdup when len == 0 (and ignore pathspec->items[0].match[] in
that case), and they know they need to memdup if they want to have
their own copies, etc., so the changes to them can be kept to the
minimum.

> +	prefix.match = first < 0 ? NULL : pathspec->items[first].match;
> +	prefix.len = max;
> +	return prefix;

So instead of these three lines, your return sequence would become

	*matched_prefix = first < 0 ? NULL : pathspec->items[first].match;
	return max;

If there is no positive element in the given pathspec (by the way,
"pathspec" refers to the whole set, and each element in it may be
either positive or negative, so "positive pathspec(s)" is a
misnomer),  the loop never touches first or max, so when the loop
exits, we won't have "match" and "len" is 0.  Your changes in the
loop to avoid assuming [0] is positive element all look correct.

