Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2E35C6AB
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578275; cv=none; b=GfVVqnYwy9f1OgUQ4ITuFQqviMNMvatmrz+KRdLxrsddz4Bey8n4ANJbRTl1rhZb07mARAdSOyKU+m6hTmGxH1ITP4ABw/L15751znN2t6NdoDBSRMFphSMShEBLzwS5QxuGPneScSVDmxMNzb2Wpb5915FKj7ZGXMSiYYJDPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578275; c=relaxed/simple;
	bh=xcR7v+90fOOsO+p+qaFrXoOQeloFx+v+frbx4glET9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omg/N9PqT00JjXgtBHs96/Z1Qc+ndH3zXaHI5CfjW11SRbzPoV+Pf6/iRClPXEu43EgnOmD0n1Kc92kUpc+Oj1w/HgkAh5xfbutgImBOmqRzxVW3tl4e9Nhj5EtP0oL31M2y4JTCP6+Eokiko5U0H66dlM4Nk3QVSghwm8AsTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p9cGZakl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wTnDp9aN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p9cGZakl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wTnDp9aN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AD4A7A00D9
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:37:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 16:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791578272;
	 x=1791664672; bh=De2DvGKwADcGX39RIusGck94AsScTSYU+A3JXCkl11g=; b=
	p9cGZaklPoZ3Aw6RihnMrhs9IBp5mzunBEZmkOVDSiM8Myajoq3wLel9lQVI2rhn
	v9xVjTiV0clcsCYz4egqPLUlc7jdpjhYOX3mkPF/4YWBmWJP+W9EbXFfyTmst+Iv
	w1LOMhItfRAVLni77gnnhtV6jcMzaGwJqNnS7/+gL8FwZovncGPzxQha2T6M1uqV
	rgl/vT2OeMv/V5ZCuCurYOJjMfJZhgCtzvFQk08SshTm0yy9xIBeY5/c4EkRbtvZ
	45ODM65U5d/vF/GXXYT45ay9V+BuUG3ftuqx0sh8DzFMkNpc8Lfbp0ZpY+JLAn89
	NgbBiqPh0ZGP+H+7madR5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791578272; x=
	1791664672; bh=De2DvGKwADcGX39RIusGck94AsScTSYU+A3JXCkl11g=; b=w
	TnDp9aNPD8CSlSYs0I6WPbKHJfo6k8PhkvYrRX8DJ1KeS65QicqfkLhNBoEqVgo7
	5vAzk6s8xVgdYWtgpZ4J6pUOoBfd5vInz0ClzsasIIAVQsvns5QdlsLGh0pSfOK7
	fWCFNx7+nDhvrQe37gled+0yIsc/W7CO4B+44woCpK3Ac98P8M6v07q5BMn3GmP4
	IGjadIMk8w9vEJKT7znE/K8Cp5SAKLRVnNK2lETC7QAKCZbbRkYxP8ASq3ax6s4f
	zQTGawsETCSMe9W37ivt25svcLx090l9AJcPYcTN/YszCJwWH1BT5NIChP/BhZfj
	19HTot+7U54UYNSCv9jTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791578272; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KgyTSfH7nGcLJPmtD4r7r+ciMz00/NXdYSRlPd9jcLQkbj9
	f3OzFY46zKSzOc9beTIa43uXD/9s4iUrqKJlA/tjYARbsOK/ErTlh5TH8xlHQyct
	wSe/peC7H1g3uQ9/aVU5Gmat/KqBWS2epdO0Foko4h6IO0Ahv69dcg/3lrlOMZyF
	+IIgJkRQQWheJaWfZRTfr6GrmXLEDzLQGFR5gl3rrftRGnidT/qQ93JPt3fJ6jT2
	Ih5g9gXe5Eb761OQIWXaCHhh3Vs8h1N67GYRHwfgzaTtv66zfA/iXnKb3ShUUdxN
	zw5dNIBwVp2U7mqJyQh18B9l7L3wCz4eoMoPS2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lKNYAAHJn86Gn7oO/jnci3dJxWpj8+ik69/PNXEiE44=:xcR7v+90fOOsO+p+qaFrXoOQeloFx+v+frbx4glET9Y=;
X-ME-Sender: <xms:n1DJaoEr70zPwcjZOGkYhBP6KFMT_ZE5c0gPsqS1j7B58rKU4-dK4g>
    <xme:n1DJajlwpZoqjbPfarz_U96SzwK7Ii1jdF4FwpqENFgvWJE_CTakQe_HRv8nNulBm
    ulvn2HOftvUuFoHEwU8_VSa4tEI3FIg9N_Gb37q2kHbjNNfoJkXmw>
X-ME-Received: <xmr:n1DJakbaE0ly2Y4hHCxAQv-yY2hG7WOOTIgm5zk_B81CMYx8zResRu9KUiVqpkPd80NONcdRd3kmBoGuJ0tFsZYY2XpdDKG0GDDrhnavfgDZlJ1OrPXuabk>
X-ME-Proxy-Cause: dmFkZTFKiE6GfEnhUA9LxMRPM7UBaLWGJA8+8RgOjGOkxDVOIYC+1X3Gy0AjYDwEqS1MzN
    /3BfiGRe3q/lQJJZ5fUHzz8Bni4L8cpc582TRQpYvKLZcI3ImQV3EK446tcmPSHis8ksKm
    r7k+z08triZERxyFVfSI0FUq5yfAL5Kmtpg1h79oKU6LkcH+aC1Uq+XtFlez1iTajyzzfm
    ZS1LNjyj2q+R2fNOohKDMtsGZXNem9TuBObwcSErkvs/4VmlRxOa3ecRn4uReDbs9suoWR
    Iu88Ph4jGhqROqtcEu5p9hULaioYHqw9mpEzIb5N3TXX+8OSgCtGUWY5Yl+nKac68NX4YZ
    +AcCTQC3VSYn3HhkbviEQzmxkHdBjf1TyzhX7kN+zVUl6zR7BGlmSof3zDWZpuv2Vl7xcP
    3ZuC4G6lbkZ8bAZPCZH0GZsLL9s2jBEne85qXg0AlkL6HYuNN2jx9PjYwQ20VLT8LLx0vK
    AYPfSlyP8yjfxMOy4IPiCchwTRqRJ1OKc5mZoMFJMZZgWMltBvzGBge/8Cuogmc2PPj/q8
    KczVUSvX6htNRp45mEFSTXnUZy2/FXe0ptxbg/ZJuh1uA428QZ0Z5OTUySlaE8OpuAT05m
    dnQeJcj91Vx5FCtCSbSMSoAnSqbDI20BWnCqdxjEPZiJepnFZWqKv1r8Xbpg
X-ME-Proxy: <xmx:n1DJagFCxm5Chq7p6kyTUMZmo7jHy_TadYKnJvJCclWyEzJN_dC-vA>
    <xmx:oFDJatLUV0jLhrMU2vkByHoEdLY4UmFX3CuFQSCdQqGSJ79x9zqS7Q>
    <xmx:oFDJajOpf1aeb3asTx5ZFCzia9qUimjBZeOqxrU7ITkQKZdRRcQAZg>
    <xmx:oFDJalk4PS8wQZMCQqjGQuaEbFnsG_c4_ptXmt6VpB5iT3jo2m89iQ>
    <xmx:oFDJal13RRjBAftMozskqpmn2YBg52bzgKbVsoQ3xtDQSsFhOinf3lQx>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:37:51 -0400 (EDT)
Date: Fri, 9 Oct 2026 16:37:49 -0400
From: Todd Zullinger <tmz@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Sam Reis <sam@opencanopy.dev>,
	Sebastian Thiel <sebastian.thiel@icloud.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
Message-ID: <20261009203749.x4V9kN18@teonanacatl.net>
References: <20260929112544.86511-1-scott@gitbutler.net>
 <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
 <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
 <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
 <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>

D. Ben Knoble wrote:
> Interestingly, Gentoo claims Git's license is only GPL-2, but I think
> they compile in the sha1dc code since it's the default in meson.
> Should we be claiming the Git package (with sha1dc) is actually GPL-2
> and MIT?

I _think_ that that depends on whether Gentoo's license tag
is meant to be the "effective" license they are distributing
their Git package or attempting to encompass the license of
all of the code which goes into the Git package.

Fedora's Git package has:

    BSD-3-Clause AND GPL-2.0-only AND GPL-2.0-or-later AND LGPL-2.1-or-later AND MIT

I think I was the last to touch that, in ef75bcd (update
license data and convert to SPDX format, 2022-11-07).  I
attempted to capture all of the licensing, but I most
certainly could have missed some things.  And things may
have changed since then too.

Fedora's guidelines have a lengthy page on the License tag².
It includes a 'No "effective license" analysis' section
discussing this.

I don't know if any of that helps. :)

¹ https://src.fedoraproject.org/rpms/git/c/ef75bcd
² https://docs.fedoraproject.org/en-US/legal/license-field/

-- 
Todd
