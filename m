Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AC2AD2C
	for <git@vger.kernel.org>; Mon, 25 May 2026 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.38.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751227; cv=none; b=OyGlLrd864J72TqK8FcEpDCzwwTh4iQ8m0DLQarcwvm0miV5dZFxwyuVumqqdbZ+OVThFnIkucXDaake0B2ybspGozSWFNFB/sleSHNGGhivIrTHkJ7Soz3fSb0JcU+Tm2CDdBRwCPmb3II2TRb7uGjjpAfrArBBHYSfWj1GDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751227; c=relaxed/simple;
	bh=kklSjhCZXwxIfUxBlzmFFTdzJT08hLPT4sJ4poMhM2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6DX+yjrBsDuvaOghWqoHi3RKBxAOwcsTV6neE3hiZZ1EbQqjBXPiJDH/z5nzF3gPWuIVs821gp9OyF/h7tGFP681DiRD6CRP4Mkt0dgREIWrstO6WRj0UjXPVFvU0jIXywcdYzSEB/OF1hfyxKoXXU0UTSxQBaSCwG402znAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=light-speed.de; spf=pass smtp.mailfrom=mail.light-speed.de; dkim=pass (1024-bit key) header.d=light-speed.de header.i=@light-speed.de header.b=L4IUI+nM; arc=none smtp.client-ip=85.214.38.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=light-speed.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.light-speed.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=light-speed.de header.i=@light-speed.de header.b="L4IUI+nM"
Received: by mail.light-speed.de (Postfix, from userid 501)
	id D4F7B3D49411; Tue, 26 May 2026 01:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=light-speed.de;
	s=mail; t=1779751223;
	bh=hXtDCmhrQsuhtTMofhpJp5W4ffnwnWqW7unHiMZiiNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L4IUI+nM4LfKvcE5RA5CDc1laGXaBIGg2akXEkoUmGcyDu8er+LCi54PK4CRAjR2J
	 ErQ87yPsKOPPA6LaHTeRr4f30VFBbaV6RTeLtAYbs8UlLZZ9RiUn0TdloGENxYYRn4
	 LYWyR8TQJaqADpWmm8UHPdpVFK53h+WzALEOot5Q=
Date: Tue, 26 May 2026 01:20:23 +0200
From: Jens =?iso-8859-15?Q?Tr=F6ger?= <jens.troeger@light-speed.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Subject: Re: How does git track history overwrites?
Message-ID: <ahTZN7BurySMbEgM@light-speed.de>
References: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de>
 <87se7gasn8.fsf@gitster.g>
 <074E783A-027D-4C5B-BC44-CC38C53735D7@light-speed.de>
 <xmqqfr3fnl2n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfr3fnl2n.fsf@gitster.g>

Hello Junio,

> Sorry, I may have been unclear.  I specifically meant the "grafted,
> " part in the message.  I know how "git log" output looks like ;-)

The “grafted” too was part of the git log output; here is the complete
cmd line output:

    /tmp/bla > git log
    commit fda77690955e9b63c6687d8806bafd56a526e45f (grafted, HEAD)
    Author: Adam Johnson <me@adamj.eu>
    Date:   Mon Sep 8 16:31:35 2025 +0100

        Version 1.20.0

On *why* the “grafted” is there in the first place, I suspect that’s got
to do with the fetch --depth=1 and that previous history isn’t available
in the shallow repo clone.

Cheers,
Jens
