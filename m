Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1A322C67
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287328; cv=none; b=QqYCrmM6lvZSnHYkU0/yokSoRKdhI5odkGLpbdaT9EFkAKFQkpcn61FevNLBFMlKGOuyuWd/1VCdRbjJi8bbvu+cfREKhZ2J/uk1/zNdHSpLeP8TL24IxUa3QymPuXoULKtweMhvpmGKieq9ZpoJdVmpgKKZ8vhtqIA+b95OLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287328; c=relaxed/simple;
	bh=vymVvWaRApQYlHGuqqz6vz4dBNYGLM64PK0rMb1CIBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ6A0BUWb8edYLEoadrcauEpCg3hXODPLaUiphfjpK0xzqG3l0R7bR/RZ3PK+XC6h4mT9WiddhDF+qsHf+d+G0eEf+nQNael+q94jkb3Ycnt2e4342MkOg9vvbmcGPyj4BpVIhzmg5d1pgGWTRoiZU0ZLhcCjXgFRa8uJrmxeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VskOufhV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jUAEg39+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VskOufhV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jUAEg39+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9901E1D0007D;
	Fri, 12 Jun 2026 14:02:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 14:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781287325; x=1781373725; bh=bOneXlNGKf
	b2LqNkG4Hx5i8zNKJroxTojD9U4ZyF/BQ=; b=VskOufhVgA5YXXEsS5SNF5kyz4
	N4s+EjnwMjQXaBZX18oySIw+cergz8frbPMGkiLJ4TQuVNC3WhW1Igsqy3PMLdQY
	vQystVREIXAyN5FM/DC4nPnMu05nI7pyu98xB/DHe0XuslVB9OKoRFQrAl51rcM/
	lGv0WQvSd4UYxM6BRi6s3zv3DrbVYN1ErrgO+z9jPsGMMd9fkMGi3FaAy18mKdCg
	pzP1Jp24MYXKWbe58MIyt8hGtpT5U8GRM9IffkCNZflZRoYbG+vf+Dc1ZPheRNd0
	mnOSi3Y04Hede/K7B+/Nk2+VftEUcaTZZeisQ1gHfdZXi5ct5RLpF1nVxBhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781287325; x=1781373725; bh=bOneXlNGKfb2LqNkG4Hx5i8zNKJroxTojD9
	U4ZyF/BQ=; b=jUAEg39+t0Iie7HRv2lRVSxG5HBowZwuBunogUv3KRkzwa4dgJD
	S/7XkQhRc/QmOdEPDlwPk/zdT7MKm03/qnLu02eSFyRgQIN/fGeW85NpUuAAuA39
	m7NG9TraPPQbOptnCnpf8xMFNt4qcwGx1rYCBhYmWZTHsY71HmO8OThjDynTHhaM
	M+kmZyk+ASa+ArKYsWO3H1fND0n8tRybjtgbHZy885zLITDxN1Mva9volFGhwWkQ
	6rm4p8E4itxHM30Kkl4XQLVGrTUi5UEBByUri1CK40q3p3QAVIQzsdzkEap3B1Xz
	WCpxTuh0eWzMz6Q+bVFBa/sNqiBgqEdOJ8Q==
X-ME-Sender: <xms:nUksapXA2p8Qfjf9nJLskhanA9ZaJu-7l_8RCpAmfckonucdekfjJQ>
    <xme:nUksavl8GTFLjDZxU5yrYvkAn-ru8ELRUIMfjG3bSQR2y5XiSuoANlXIYKgfM4n0q
    Cuqct9y02hkSvHAnnbvq84M1UjHx8WCyQVImNQIAUc4u2SKH2uJcUI>
X-ME-Received: <xmr:nUksajDi9iUkmLsv3r7IFBf-L852QZ9bniElwcKLOwYJI4GV1r_1NrTtRgBKEziCHObYVMAws-t_tKmAvJgGULyeF6i2Z9BK50w_YN0Im9n9HKUDxvHNwck>
X-ME-Proxy-Cause: dmFkZTEUYDSRLxRLUFTccxtbqPfGgrIVVnTEyC6AM37zrUflaDef0sgGx39wPoqY3DKDoP
    H4xdZG8suKwp7A5JfbCxqH8wgh0teehRY68EsWIgE38oZ7cmTZzQLR7BYrcj3MdMcuAU2A
    gQmF3pB1dUsPnZHJFDBA4ULiHsybQYFSLLn5ZxWLdrMimd1qPnjJ40/FRLj65Vl2ts0H5I
    lL8mrM59Rwk+n+f9pXPiIlWGLVNVS5PKM1ulAqqRGMNA7j6VIodE22+XeRHnLoVHaLUUX2
    SBjPXtkT1UYouznnUvCMYIMz/JKdVEmfMiZtxqFhBn/JfHcTHQitYiX3HaTm9qMaDZ5vre
    eWn+/AyCiGLaRr/+6IAoYt51QADTEswB50B/dpb2Ve8KVx5DVWnrjJymi1duLJEiStyo+c
    f8v5q31EjazHLgH8dhcoyeHeEknuQIUznqeQUIJ3wl2wpwwGFgvOmYC3h1NYdruZDvtSy6
    aqGP9OnAROy9a057PF0uBZCiu7vY873kaOnAaVDOpxJQKvjusqBlXR3nCue072/o5oK+IL
    aaulZmjtSvbUakMY3fOhKW5BAt7izXdxdo9LwQGw98YNR8/9uCp5mMd1xwSztTHtxh9NcE
    32Ogu4hqN0KMPcoEeN6iUf24SZPwzIv7LmNcPO9kJ4Hr9xrpvZX9kLzILIDw
X-ME-Proxy: <xmx:nUksane3b0Xvt4vNZEM2rAFp1EPAQPQr7ByN6Aco3r9Xf2ox5PQYJg>
    <xmx:nUksamKF4CyQs78Ul2TBUWQwaajEzS3bBKN-5dvRiDlVsnD0Imrqow>
    <xmx:nUksaifCXmM8hv3DtyJyCX6vfqUcNoYl55IehMCXp9momXCm2Ec9Sg>
    <xmx:nUksal1nUBtc-7bV_AuJNcpwXbEddEEPbv0Lcp99D-aq3brXwgWVGA>
    <xmx:nUksajJgJ8BMXkTpy7qZqJoMQLU-5RYZktlFogPBch066FSstBIE1x-B>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 14:02:05 -0400 (EDT)
Date: Fri, 12 Jun 2026 14:02:03 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Matthew John Cheetham <mjcheetham@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: t5563-simple-http-auth failures with v2.55.0-rc0
Message-ID: <20260612180203.s2qSgDUs@teonanacatl.net>
References: <20260611210456.XYfhytSL@teonanacatl.net>
 <VI0PR03MB1163416D5C66FAB25AECAAE21C0182@VI0PR03MB11634.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR03MB1163416D5C66FAB25AECAAE21C0182@VI0PR03MB11634.eurprd03.prod.outlook.com>

Hi,

Matthew John Cheetham wrote:
> On 2026-06-11 22:04, Todd Zullinger wrote:
>> I notice that Fedora 44 (where the tests all pass) has
>> curl-8.18.0 while Fedora 45 has curl-8.21.0-rc2.  The
>> version of httpd is the same between them, FWIW.  I didn't
>> compare other package differences; it could be something
>> else entirely.
> 
> Thanks for the report. The failure is not in Git, it is a libcurl
> behaviour change, and there is already an open upstream issue:
> 
>   https://github.com/curl/curl/issues/21943
>   "Negotiate ignored with --anyauth" (Dan Fandrich, 2026-06-10)
> 
> Dan also bisected it to the same commit I had locally,
> `8f71d0fde515` ("creds: hold credentials", curl PR #21548).
[...]
> Daniel Stenberg has acknowledged the curl issue but has not yet
> posted a fix. I will follow curl#21943 and, if the upstream answer
> is "the new behaviour is intended", come back here with a proposal
> for what Git should do about `http.emptyAuth` and test 18.

Excellent.  This is it good hands all around.

With luck, curl is updated and the canary of distributions
like Fedora's Rawhide will have served a useful purpose in
flushing out issues before they affect most people.  With
the help of git's excellent and thorough test suite, of
course. :)

If there is a curl update, I imagine it will be picked up
reasonably quickly in Fedora (and elsewhere that was testing
8.21.0 release candidates) and there will hopefully be no
strong need to make any changes on the git side.

Thanks!

-- 
Todd
