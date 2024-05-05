Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F963A5
	for <git@vger.kernel.org>; Sun,  5 May 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714904401; cv=none; b=YtIGxtV7RrtV5aMbY3NGEyBeQFi0BP0zyIzW3Xk6Z8cXKEj37cFkhDHTsx2wbQ+fD8lo0cIznfYFD/vIHdOUwxTggEgc2GxgfIyJrgThKOkRNJOIZP7SqoSF+ICbtZhk71cgyVXDPUkLtEi8zi2T6SNJ9aw5Qqx3m7+4J9ZRWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714904401; c=relaxed/simple;
	bh=3WIpl0fR4uOvn2UrNLX0AES2h+3qNmfC2trGjeSqziw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twgTZHTYul6BwNrQMIL1YS5EgWAkcHsmtO1USuOXjL8dGDwFPKvb0NYXrBzXEk6XJENhMh7NXPOOFa8Q6jE4fZm18EDrikt7cY9xfviWiFakCErsHkWVYKUVUKxF+X9Qd1JpBdy76OGnrBQ7NuToAE5r5Yhs4zh/iSh1F57GU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FOC704eE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FOC704eE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714904391; x=1715509191; i=l.s.r@web.de;
	bh=qqTpr2eU52e1XLI9Ha2makNrqnMgihA8YC8TeF8QIFM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FOC704eEuMHzpyUrNs1ONXpy5clNj+2YkFJ+rfTDDqfKOlvYbamdX4bRGSLIl3T+
	 ZlKT2oXPaB9kc3udt3q/eg+LXXIqh6IeeV3nJeG7xsm40JBkLFkTNOcSeqn9QeY6G
	 C+srTgPqOk7m+HqufdX64nZUnh5RJShY9IP2EUcJXjHA2t5kkBe9lvhnSTF3NEDXt
	 H2YfZnHFqa3Ex7BBq0ervQDos81VAD2SxzI5eMObRxAIkxu3UTZZF3Pg3/IIFHuuC
	 lZkp5N48dOCt4c45OBfyhYCGg7wdpbGXM881tGODklrQ5nQqmc62dtNJQHp911ycO
	 KqpgefAjZhVwitqsAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1sAwok2Fsb-00RtqF; Sun, 05
 May 2024 12:19:51 +0200
Message-ID: <caa6cca4-182f-4788-b08e-35806879fdca@web.de>
Date: Sun, 5 May 2024 12:19:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible git-diff bug when using exit-code with diff filters
To: Junio C Hamano <gitster@pobox.com>
Cc: German Lashevich <german.lashevich@gmail.com>, git@vger.kernel.org
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de> <xmqqy1961sxf.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqy1961sxf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eHt9Lp/2dtYQRQoifr0q46UdEKO2vHNtgYxzgDbqHZPf1biJJUZ
 ZSLzRsbuFswbnY+S+Wuqs9ClSICVYseXQUhVnveBAxmoswTKSDqaU8L7rKA7JJnk+CwDndZ
 KY/t3BkabHJeNxMDYSOsL4+1RXdXPzvE6tXHMg7tv/xHVH+qTVMwZWIoLcXgZUad/r3+1o5
 CRMaiLe6Nj7qGvbLC3Zmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pov+f3wzdRA=;6QwoKbGEvNy9HF2IF98T64Vi021
 o1ydIRDnlcgzddNGS/sDz6s+66bBq8RTEshIAt7T56xoqa/y59HrkROfzBy7MbHoUln1hKxPD
 qiFWsfkojv8tnAwqNduMSqSorLipXX24ETEVGvi5S7X8Xj7vI2VS5URuWcXQqBCidcsY6lJIV
 Pu2nOkwBMjE4hy4LK+AEVTCDuZdMCm4HKqpzoeEh4PQNXacCXxp666ytb125Dsfh8NUx1lTLk
 5kkF5vdMwlN5ZxP1lqxzMVoHG8pLFi8XFKE9T2hZ6qeAO+tk4BOwG6T5PjIGsabtPdg/ZtYOY
 m+vZvfWB0TPs54mfc7tGXmPlE+GauT8rgwEOxoFclFTWcbVoRvFE8fOIp6mC+h9h6y977pX9B
 kgrQcfl3OBZBa/XhEO6VRfCGE45Lj+hp1Na4MV6R0S4hS/T++8fICPfXwvQWaXBm1+hvfMk9S
 MzK8uGpoEe0HjyTubdUemf1PNEccvFtkMGDC5LhQxdFm/DhqGsrYKW8eymakUZcFDdN+ZuER5
 ZgcvzQCJ7v+qRjJUE00T+Y/P5Gcehe5QIQT0zIFtlHNxd+KjMxdTG0Ds3R4M/sCVHUIVQdIkT
 jGw/MG3SfdWsh34rXlyr48FVXcy/496mCRbzH20C8Yjpa6ZAhAP40Ndlngn6KeKIVJtYywvLY
 P+WvkZXgf6suOPDdsHEoMCzI3NBZogVQUSC9v7wMXEP916YyjLsdPWgZsvbYFoNhDFmweSQ7S
 V60Jkof+RcmhQWCx7fF0yMVxrpE29j2CnQIkEFtQTKMiesvCLn3hyOCaUNsVwKGQLTnk0rQKa
 +hkOn5EQKAxSgLtHpXPM16qvCtbS/DsPn0oT0zVcGtuEE=

Am 21.04.24 um 20:17 schrieb Junio C Hamano:
> A much simpler fix may be to declare that these two features are
> imcompatible and fail the execution upfront, instead of just
> silently ignoring one of the two options.

It would not be *that* simple -- if we want to error out upfront we'd
have to evaluate the attributes of all files (or all changed files)
first to see whether they require an external diff.

Reporting the incompatibility in the middle of a diff would be easier,
but I don't see why we shouldn't support that combination.  It takes
some effort, sure, but not prohibitively much.

Ren=C3=A9

