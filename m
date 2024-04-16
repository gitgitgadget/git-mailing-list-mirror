Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E239FCE
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281880; cv=none; b=bVtP9HAXrB72ynLtoZq9zWmuR60BVv9TG51+a3rRHjh/fAdXAz4SEZQYKmHbGO+KD4OqUPU0AL/QFTxcItwknAkxP07mV9uUV68Qc2hdQ/la7K83dzUHXiG0BUF93dQevJJkOsmyo7MnKpcpKuWkI8p5CwnooE7UT2I1IR7jwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281880; c=relaxed/simple;
	bh=J/o/50u25AJ7u1Z8WYdgutWMNIhuclujXpbwT7yV3cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+etRSqX+GIFsaT0aUiRwjsbgX/ZH2+n3p9PizKg4Jer2NNo05IaBWhGlvy8aLOgBKrTj6TunuUgLyB/DFXs7gPKJXCPA315U9aiD0hm55JWilQHOqv+d75BsFwHxKw6n2NK8CL6DwuPweQPKzKJkXkosPpzyAaxY6WLjSitMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wwW51Z9M; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wwW51Z9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713281867; x=1713886667; i=l.s.r@web.de;
	bh=ZyjxK+ATPmkW1gT7IrUyCWEGo1clmSSJP+ier9/4nWQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wwW51Z9MvodSXHoZdxzP5NW8My2wdNYUX5fJh+VjpBqU6okc9plA2E8OFssro1OA
	 NZXNMbgGkQhmhV1KXDQoHlyCkqvwXnciibYaD+W4xZLsOe0uDP6OsQ0u3Qh8y4DlZ
	 cYbjPDpr2qJsscjFTAKclKsv1bAmLw0tCbKy52jNEK6/jPtNU9ZrsuncDs8XEIw8Q
	 K6FmTvnz/1H+0POtEgchTTfkhlbSTcBL0sYQ0SATwekX1X+yWbE7VRbSGbe2xnWuO
	 xmX2IXbOMof8A0bStl3PTjrWa6RnkpT6F5lWQVxIYcl/fqwendiIe50WNdB6f4/S7
	 enMe805OgreBLZxHqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVaf-1s1Rc20K3d-00DV1Z; Tue, 16
 Apr 2024 17:31:55 +0200
Message-ID: <5d35dd4a-3569-4292-a736-45cfd0442f24@web.de>
Date: Tue, 16 Apr 2024 17:31:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imap-send: increase command size limit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
 <ZhwV6CmcC8zeSJ-7@tapette.crustytoothpaste.net> <xmqqil0impy3.fsf@gitster.g>
 <20240415184552.GA1709228@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240415184552.GA1709228@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7QPqYVEUWrMiSmbWPdl6KcKvWvniqA/Z6TPsgM+We/M27zUmfsc
 gk7NC+PB/Hmgj6M/8M2aiYX6aVJpwQ4FwkzJSkgWBoeeIj46gwTC6C2BBJCPEytjoWnk/Nx
 6rpcDn63yLYVHsebuQ6UdV28CitWrck7w2pR2xsFlCxhH2QXitWdIFZ2EWFrfbFOV4kJDH4
 LWpK5QLWEizBx+eaos4Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XnVJXqIABdg=;p6MJKJ9Y0bNGdeTGvXSriSc+w/S
 6w/ajF/XMeV7yTIDOKUSLOtKwuOajhrlBY1LZ9t3WxmGJIMkJAuJV6SufHWRY2C06i4yLll1q
 JQM/iO1ox/423dKBkmLPGemM1x/WpHzbUA/kQ/rKfBWE8NjXnyJgCTO0DTXl/aTd3Ibcl4sRa
 008poijhpcrybKsEyCNYm6DdkyBoyk7tnOI9feqpgyckgheQJ/bXhWdB3NT5DPWEs+UCPTAaA
 jo1XcOodj5jjjEDfP2jLvzRrHaqWHNi2fkQzSP+5ArLlc6cki7ES3WG2IzMcljSVJKxc5rLy8
 BgAr6p5UDhnGN1ZYfIHjH9WHF3G54LsgXWBX1XFdq6Wuk4RADOCZdbQo4noLqLTGBg/OejEhH
 1hVzqio8o76/m+CjIuFGRLv5y3p4SvzlW7FBUDlca9ltkvKKBOoobdpkyK4YOI7wM8T2ItWO/
 SideWBFPqIXdwoK3Hyw7KvIEVhD1PJ9BQ04Wp98dDm31bn8QK0KPn2mBgteErZ4JsaR+L1G3Z
 LAB9OpJIrEQgATSp/hS+LbO2IwDUnizKucShStV0Mex28PWFtNd3SDdcCkQBBFEoN007/8Mhv
 S43FwSN23jUNbBsnD+a8AcmWdTaLGkmiXI1D0VRFT0Lawws07dkBR/bpi66boLg20IlIPxtAK
 vGkxhO184UeLKhiFujKaqwT3rrKZUrHe0RLtsaL0vAzB5WwPYY15w+R2E9XKWKUrcncKIdBkv
 GAr1bXvfBySyS4WpSKdyVWApI/Bieuit65CYuy053xed+U1voiYb1hhiI0c3vVftlGjXuFHfk
 k3N/moogG7eVT9hsLkFwPHNMUajYwzFirGBaJ1vswp9X8=

Am 15.04.24 um 20:45 schrieb Jeff King:
> On Mon, Apr 15, 2024 at 11:38:28AM -0700, Junio C Hamano wrote:
>
>>> I'm curious, is there a particular problem that you (or someone else)
>>> ran into that caused you to make this change?  I agree it seems pruden=
t
>>> in general, but if there's a particular real-world broken case that th=
is
>>> hits (e.g., mailbox names in a given language), I think the commit
>>> message would be a great place to mention this real-world impact, whic=
h
>>> would lend support to your argument that this is a valuable change to
>>> make.
>>
>> I personally am not curious about real-world problem in this case,
>> but I won't stop you asking ;-)
>>
>> I view this more about code simplification.  We no longer need a
>> custom nfvasprintf() helper nobody else cares about, leaving the
>> resulting code easier to read.
>>
>> Will queue but will wait for a day or two to see if Ren=C3=A9 wants to
>> add clarification to the proposed commit log message before merging
>> it to 'next'.
>
> Yeah, as the suggested-by person, I can affirm that this is not
> something I saw in real life. I agree the primary motivation is the code
> simplification, and dropping a pointless limit is the bonus. I'd
> probably have written it in that style, but I'm OK either way.

Right, it's just intended as a code cleanup.  I mention the limits only
because lifting them is a change of behavior.  Though you can now use
passwords and folder names longer than 1000 characters, I don't expect
that to catch on.

Ren=C3=A9
