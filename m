Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8C1F8933
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735330589; cv=none; b=qy62m07Wh562i9Z0rcAGcbggNpi6Z5E8TvZwJPM0bbjVr7zBROyKRXECtpoGbyJ7K8GjCK6EMRqPLgtJkXCZHo86mUsGOSyfYoItP7/xMtAvWOPgThsTNr+U7qj0JFAMx+WXScrzc//k5tR3G8dONPpy+5OVzEEc/n0j8qtJBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735330589; c=relaxed/simple;
	bh=bubau5PSMQuyQt/AXIPaNYb1iI5CvzoGxu6n1o64XkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1o/AXaczlzpiueezEP6QVi8ZD0XwdWl8J4TGBG4sxOVSe17nFxYbGBFWvpNQFn07HCi7K9RrBVDwDOuPBuQ+HIseJrzFw+zPpkR7/byiyXK929SOmixy7Rs1hdR7GFFaPR1xTX4/21o1vMk2MOU/0wM2FiuUtyzQZGc6iZeBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UN8vnu1f; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UN8vnu1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735330577; x=1735935377; i=l.s.r@web.de;
	bh=aOlyICYEaSPxAUPUHWTkYPUzl9dg9ETgfmWJUkZVo0E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UN8vnu1fiEDWobCI7WIAYxWeqaneH0OjOrz2EdraIe4v7ZPQ86752WErIM8bs0ld
	 OKEEheO9a9kWmvD2Dc6Wp5etqrNSQo47eSe7tIn6QU6TkKYA/MzcF+hw3izUtIZeU
	 MY++xOV1EBLYa4+6WnD+nZScihy7j4+JI/yPOQr6b8q/ftuGNsmkLmaxlNIl6gtzH
	 Db6TGov502P5472p9196ETcF7Oc64H/A9zqLOoQrE2K4Pt2rcl5+ghUfhyzNHlBUx
	 qTCYVDF5MnSU4DVK7mMThdeOH1LH7IZ/0enEBfDvt29XB5BNVd9hoCtHvXZx7vAJf
	 8ciuC/UAqSFQFmrTOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1Lwd-1tXH1n43zv-00zvjl; Fri, 27
 Dec 2024 21:16:17 +0100
Message-ID: <6112daa0-190e-4d15-9b00-98fbc2a69fa3@web.de>
Date: Fri, 27 Dec 2024 21:16:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] t-reftable-merged: check realloc errors
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <6084c017-9557-478b-b485-a1c1a21842e7@web.de> <xmqqplldvfsk.fsf@gitster.g>
 <Z26CmZEMQeqGFuEs@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Z26CmZEMQeqGFuEs@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s/Zo0+m1oGDHvK1ESyoFji8h3sUmDHRGREFH8wr3jmPlImhK9hk
 hzCoIruqVQvzJU8hSNQs+ZAv94FvMJjFP4kpgPzENvYABiUCztXmT164BRZ1IR7pj46Dygy
 VijxKHtDkKbOl0YJVeHDthhLeudMVFFWuWpmpITrCoPe+GGBAJvLmeL+tnU8MgFLEyWILP6
 5QJOgByCgLa9P2lkMsSpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j4/vOPU1k+Q=;4Y7BpelE9GAGk/SoMJnnPQfDD8r
 riDoG2ghLS7ZA8FORHWIea2ionTwJxYIqQpXtyi9BIzlCUuMRhI0cql0T98kQekqpjf2YIGGD
 iv2aR1pTTVShn5w3ONfVeCIFS6RIKvs3GZ0jkbflWAAZgFoMWK+YpPYvoxdxn0UxKElT+vBW4
 hMaQwM2m+MTZeOWN2U1br/1RB+YkXd3xeOXuavGIocGHOLjQZDnn4qCn764I4IEHhVlsaDyng
 tBMmlsZquMQG6B0SWmjHKC5W3heVlGM6UyUDr+IgFpZkLutE8hltTcCAdWNS3I4DxXwvrgfQr
 nCIx/qvuKcHk3RwB6sDMCqc3D7ggV/yKIF+qhRkIfUZhqFp5y0t1gXNqWOBNRazUemW5SpcE0
 cxI1uzaCu0PgAvV18QRB3kA2uiGyIkRxUotGpsBFQ1qrFS08HW/TNX2ffOFEO9hhkKtiA+pzw
 n2gI/iCLPvqauD1y2HPe9lCoplMNTczbJtY2D9fVIe0bWB1vUIKhcfQW0hVF/ASfgQlaOExJR
 CIhmNlb9Ijt+VIdNl1pMeAvug2P9Bh61geFRyOX0WpQ0LMk/x12A9pZWU6CFA43fOikgO/sk+
 LNVE8EUX81OLy/9C4hFMzGaR5+AiI9mCRVSmQfZTKf9d2+cmErRAjO3hBcdEY48WHzEQmZtK6
 SdgXda1QacuQelQfTita8Am618dY+zYHWA3Ywoe+ME1zZ0qQ5pwOuaFK5AfZynR5cpvFCrOZU
 zmDP2+x/nSoovcH3Mp6dDKNn+gsYgPo1lK+g0iNSaorJHF40KeB568t2OG99Zc/3hALlzcUok
 fGC1dSpsVX7ZUOFTprKcioDobjuNxwEVPevRFy2e4X/2emTSeiipnTd3glSBGNz95vSbC7P9R
 lBTnr+qUUzD/RedY7VMQy24DDDViILPbxwWMa2AqVHDpWZjvX/mJMYiDTmyZja9L0jS24vuNP
 uERkvFTJL0RaANVbdOhdroZppLtlOUBZK/cmbz1UayYKgx8j/duf/R48/MpVCElHHfyoJzZZA
 wduXa9CVax5VrQgIX478S+pODH4JvJ1PxpWK7Pp0g7vEvRBmbn4yPD2NHAFtoDwwcEeyVjPKR
 7P62opECc=

Am 27.12.24 um 11:34 schrieb Patrick Steinhardt:
> On Thu, Dec 26, 2024 at 09:46:51PM -0800, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Report reallocation errors in unit tests, like everywhere else.
>>
>> OK.  That's good for consistency if anything else.
>>
>> We have a test framework for doing unit test at such low level, yet
>> we cannot really write tests that validates that the right thing
>> happens when a particular realloc() call returns NULL, which feels
>> somewhat disappointing, but that is not a fault of this series.
>
> In the context of the reftable library we can because we've got
> pluggable allocators. We could in theory swap them out against variants
> that fail, but it's not easy to make them fail in one specific code
> path. For the case at hand though it would work alright.

It should be easy and safe to provide allocator stubs that just fail
and swap them in and out with reftable_set_alloc() before and after
an operation that performs a single allocation.  Will add basic
tests in the next round.

Injecting an allocation error in the middle of parse_names() would
require a version that starts failing after a certain number of
allocations (or allocated bytes).  Possible, but not in scope for
this series.

Ren=C3=A9

