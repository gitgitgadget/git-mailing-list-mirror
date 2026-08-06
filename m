Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909AD373BF2
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037212; cv=none; b=RYlrhqAGAL1D4lj6nLkvrmNDSmicdjt7a7bZn9JTMEQbPdbdqwjFiKgsFrwxBv/AVcyg5ngEGQ/gTrADfrAqZJe8zEZZq9+5MLjEbXBFpzbbEyv2TUSj+c73heO73sW23dSDkDGwvSVTPqRrNJ01BnIsNSdLOh4dBXGjWO2pnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037212; c=relaxed/simple;
	bh=sZckkjEsFm/mybDIoPg91n514CQrQGWsOMiKMPUGy9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZHzi2omVG0WZZ42rZkYn/SnG/ABustxiee4BYGZSaVFJ6dMN3JXT9UcVStu7PgcJoZChdU7WyA7XxTwd+JTQXVyB3bGRUpsseZuTcuxWVBTBWigGX0ON5vgxPxZg3NphE9CjcswS6rZTGOttQsHaGeAXVjID7eKFMCGVrpGf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jSkPy2y9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wm8cJwzd; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jSkPy2y9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wm8cJwzd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3DB97A00D0;
	Thu,  6 Aug 2026 13:26:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 13:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786037210; x=1786123610; bh=nZdBl2VPBy
	UXJVJFy4TeP8Z0OumsUUhzsm8Xk5lLOpQ=; b=jSkPy2y9QJ//i0jxAr+RaSTzZt
	IJUIocf6vUoCK+uwNqzvMLoWma5pQe3NNo3GeWB2L8eId1/odxLNnvWFr7OMIl4/
	4kOrWuBXuekfaPcdIsLxS/EA8Zn4NF8iVEqGpfOrCzY/0k7IQaFE+kSJ+6cCTOpP
	jyigEsqd6Mty8LEX5OX7mxaYUiUMW+e/TMyI8z4bcb9kkLnRPhZINo/TjoL+GCXu
	+/kHv9aCg6Hq0xy0mwDB72C4LwJFW01DY3aD7MHbgBJVHI5jOZwn+0ApN8UndnAU
	W/DtVQeRXRw+6efXdh1pZdPhJ0/lElMBgudvm9D+PpANXlPMhdHumv6DcJrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786037210; x=1786123610; bh=nZdBl2VPByUXJVJFy4TeP8Z0OumsUUhzsm8
	Xk5lLOpQ=; b=Wm8cJwzdcVrJuXC0PB95ktKiCUB6F77eGQ0E89cDTaIlcDC3qE7
	FUU83RX/ujBRF/dkzbW11VkA6/eIHasCp4Xtf1eF18ZICQRlM0f5/S/RLcpoT+gd
	8glTVjEcVyQtde1rHc8T7y5s4V+PXaw3Dt17ypbxNKEef10KrY1MdksQMjjf0FqP
	wSpv4jyN91/4ftGlWv8R9VEcTFSV6x9EtWAxOgygGpiItI7DQdH9VTU/WPPmGJKU
	12VvFbxyQT7dmGZ/9h22UScHZ52EABC1eFrowSuVG75mHhhOX+J98Sg7VeX1T0l9
	ZyIWzLHfsGx5K/whM1wKvcpY2v1/pHi7Hng==
X-ME-Sender: <xms:2sN0avnFZU_dMvrQH7NQ1YmtKmsKwJ-RbzGiJZfSB5kQbA7r_5VmOg>
    <xme:2sN0ap3B7RBmsGiBLShK9LHUQnYvYs_jbpmGhzrA9BdoUZnxH8GOZy4leXj6NPINW
    mXxkiALXS8Op4wjRIQLIgitiyFdSfixALzU-L6E4ev3OcDaMDhThQ>
X-ME-Received: <xmr:2sN0aqqL1OHWKHi8Na0FwumSMxfb6CmGVudgbtuewUWvOGtjtHbZB817AgCy_s4mGG3cu33hfMMZKo9YRSmRhxz90MgQvCPpXA>
X-ME-Proxy-Cause: dmFkZTElnZWLExWKBKZWlCxAl4wMjHAYIeltk/droKY8L1quXe/XzMhXK3AG/DQn1EMJhc
    CRBdYJMCQYEn1y1571RbYBQhxvA40fQpUdB1j/vzfxguRQ/VALduUB3EklQFWEedzW5OkH
    pE3Bzpgo/TisZzriBu3s8H9NwL2vX99Y/BLsJlUZfSD7IGd7PPAxafphUTHQciVCRx18IS
    W2euKuN3ww1Ig1tqndtK50gbUIn2S2tz7FWDhXBWJyHsv0Z5DHA7usILuYdWiUPKfAY4sj
    y90TcrIb7h8ErHL+qPK564fR/iRl+I+nBAze18TYfpFde3uSG23n8isZ9Eevh2lGWnztCE
    FBsUe5wb6a4aYlWQYS7kJ1I7c2WzKGVgqg+IfbSzcqgh9skgr0NLGChbQUcSx3DInQfz0B
    iw4OavH4wSesg2o2JB50CLycqobbLGn2l8TiReK1dwPtks1wPJfrv9A5m6WQI1O11/XJGW
    xoOEPn4VGqrxgUpdx7W2r7KdpJ8SE86jKgXkGBtafvsye7gzaYVOVB2agXYTYrRFidzqLn
    tb/PMahY+OlNWwGnxbv/s+0wcyX82VffJ2IMx3LXIMm2SQBW6SvuNe18xZltpfVrCQ+brs
    yiQdbI4A+78tgbMk19M1PP7QV6SFS3KJBDql60wOe70AVU3KXs58PI/PysYw
X-ME-Proxy: <xmx:2sN0amdB0iKKRy9ucoa6ERp2hgeWWlx4Eza7tBSLPCZALPjk5I2JLw>
    <xmx:2sN0apqYfQQfzHtfaVa9Rx2zB49EX-hc0qHD34VkmB2H5zNHIMjrCA>
    <xmx:2sN0anGjIkm8bRqPXYncfTb9Xb55GrJQa-Q9EGRuhxCiozVLjFMdow>
    <xmx:2sN0apswrnTGn_gBwhjHoUFy-1eR5e5CmeVhcmZFL54RknTRqtGZ0w>
    <xmx:2sN0aoAhISzsn7XqYOFB5Y_XiE1vmeEKIikqsSxVM9UDaDibvEp9Uyii>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:26:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 12/12] mingw: allow `git.exe` to be used instead of the
 "Git wrapper"
In-Reply-To: <f822133191c9cca40477fb1bdd5d1416c9fe66c1.1785939999.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 05 Aug 2026
	14:26:38 +0000")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<f822133191c9cca40477fb1bdd5d1416c9fe66c1.1785939999.git.gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:26:49 -0700
Message-ID: <xmqq33wrkvmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -3186,6 +3225,32 @@ static void setup_windows_environment(void)
>  			setenv("HOME", tmp, 1);
>  	}
>  
> +	if (!getenv("PLINK_PROTOCOL"))
> +		setenv("PLINK_PROTOCOL", "ssh", 0);
> +
> +#ifdef ENSURE_MSYSTEM_IS_SET
> +	if (!(tmp = getenv("MSYSTEM")) || !tmp[0]) {

Checking tmp[0] is a sign that we do not consider MSYSTEM set to an
empty string a sane state and ENSURE_MSYSTEM_IS_SET is about
correcting it, right?

> +		const char *home = getenv("HOME"), *path = getenv("PATH");
> +		char buf[32768];
> +		size_t off = 0;
> +
> +		setenv("MSYSTEM", ENSURE_MSYSTEM_IS_SET, 1);

In config.mak.uname, ENSURE_MSYSTEM_IS_SET is defined to "$(MSYSTEM)".

+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY \
+		-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" -DMINGW_PREFIX="\"$(patsubst /%,%,$(MINGW_PREFIX))\"" \

Can $(MSYSTEM) be an empty string or undefined at the build time,
making ENSURE_MSYSTEM_IS_SET set to "" (two double-quotes)?  Which
would mean we are exporting MSYSTEM defined to be an empty string as
well with this setenv.

It seems ifeq($(uname_S),MINGW) side protects against this situation
by placing the cflags definition
	
+		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
+			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \

inside "ifneq (,$(MSYSTEM))..endif".  That way, ENSURE_MSYSTEM_IS_SET
is not defined to "" (two double-quotes), so #ifdef ENSURE_MSYSTEM_IS_SET
would not kick in.

