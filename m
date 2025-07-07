Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7D298CC6
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907497; cv=none; b=I0j25UDJfPnSK7D77XEUnKpnlSyyFyk3ANX5pU53l8HhpGzZSwL96aV71Bkp0vYNMPL9QYQGcTSPAakZ0TQFtAqrAYuM77hv/4RhRKHWtkaqsl8YeGyxgmiMgzzPFwtu/2p1dYGgIc9w4kUUDkX6+rdKbLJfJkq9Qybnbrh4HqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907497; c=relaxed/simple;
	bh=t2hCwGYUMWROAtn91YzrNv8N/i3FZWRKWuAHid0epJE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KEC0V/tGY4bd2uFxFqNGSsI6XHhlFLmhUx3ejjyoq7BavvF36Z+4DXK/CnjhDZydNeUMTiirNPpqYQnmQMeCPHQ6Q2qYwAVCql4vSeUQeL2vDpF0473t9F3YHPv4fZxETi8evYk17Ex2pRJaNhxHW7HlP5gmvu9btD75YDd3pu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=N6AdiXK5; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="N6AdiXK5"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id YpAOu4s1p7HMwYpAQuSrJc; Mon, 07 Jul 2025 17:58:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1751907492; bh=I+qSspu1pmX+GTVddhLuUxABNAeoKGfm+hlI3gXDbnY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=N6AdiXK5bzXAkDjvZGngpoziqNJlDl3uPRi4VjlHkvE/cfM7rgZ9sb83qW/P6IcUw
	 kuxTO3tgDWE1SDUXEJzWuhvJYeTaSYOOaZgl702dTfOL/lxI6k9A2DPEQWnXHfjBN8
	 lnobhCmQvMj2ui9evKtHds+ov75l8mI3RdP6plCujuyC+QDlt9X5MxiA1l4I1RLwhd
	 tz80alIrUzd98n+tgpmBa88i7ULunFFeChVyWvSZXpgKii95P1UNus0MRD/fDaFgo0
	 sxZ5IyAyXuZCzjSCbUSrnYnxPiFCkWVGq7pv0RgzXvMIPb8noMCHZOXXIuBmY5PmMN
	 QcLLQSbFjNNsg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ZNB0mm7b c=1 sm=1 tr=0 ts=686bfca4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8 a=NTinP0x4YiIUHElaYMEA:9 a=QEXdDO2ut3YA:10
 a=jYKBPJSq9nmHKCndOPe9:22
X-AUTH: ramsayjones@:2500
Message-ID: <77b52fde-e1f7-4193-a1c0-1aea94b22e69@ramsayjones.plus.com>
Date: Mon, 7 Jul 2025 17:58:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: fix FreeBSD build when sysinfo compat library
 installed
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Renato Botelho <garga@freebsd.org>, Eli Schwartz <eschwartz@gentoo.org>
References: <e6a80163-47ef-436b-98a6-2ac39c477080@ramsayjones.plus.com>
 <CAPig+cTybBgkwFEsMVNNu2o1w9T5qnhau4chvGU2opEPJO78zg@mail.gmail.com>
 <xmqqzfdg3t78.fsf@gitster.g>
 <ba0a3469-3a4d-44f4-b1b8-d9c1a825cb94@ramsayjones.plus.com>
Content-Language: en-US
In-Reply-To: <ba0a3469-3a4d-44f4-b1b8-d9c1a825cb94@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfD5zYWO1RKMh7xNh3xZkRtnubveq0vzjhliGCAyLP8mLeHP8Un53hHbN/fWraTBYyCtBSEYMI49TGptpGuaW0D/y5dZKTK4zK/Gqit/zgj3+E8zywuLk
 jB0Mp7cJZQH1t61KOagNTPN65jSOUzWamL6ezHJFwvcOEd9ccaD7NXNClOyIvJV84uumP+UeJhDMo0RbXgbZBUeyGqzCDHK8Ybg=



On 07/07/2025 17:51, Ramsay Jones wrote:
> 
> 
> On 07/07/2025 16:40, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>>     need to link a separate library (-lsysinfo). (This would require
>>>>     a similar change to meson.build).
>>>>
>>>>   - change the order of the preprocessor conditionals in the total_ram()
>>>>     function in 'builtin/gc.c', so that the *BSD sysctl() function
>>>>     (in the HAVE_BSD_SYSCTL block) takes priority over the sysinfo()
>>>>     function (in the HAVE_SYSINFO block).
>>>>
>>>>   - suppress the setting of HAVE_SYSINFO when HAVE_BSD_SYSCTL has been
>>>>     defined (in both configure.ac and meson.build).
>>>> ...
>>>> The second solution would only be required by the autoconf and meson
>>>> build systems, the Makefile already sets the build variables to the
>>>> required values (since they are not 'auto-detected').
>>> ...
>>> The final solution is almost certainly good enough (and is definitely
>>> simple), although the second solution has the benefit that it "fixes"
>>> the problem once and for all even if someone defines both
>>> HAVE_BSD_SYSCTL and HAVE_SYSINFO (say, in config.mak), assuming I'm
>>> understanding correctly.
>>
>> Yeah, I think I agree with this assessment.
> 
> [Sorry for the late reply - real life keeps getting in the way!]
> 
> Yep, I thought about including this fix *in addition to* the solution
> implemented in this patch, but decided that the chances that anyone would
> set both in a Makefile build was practically zero. (famous last words ;) ).
> 
> Of course, practically zero is not zero, so we could do this in a
> follow-up patch if we wanted to take a more conservative approach.
> (Carlos has a series in progress which would conflict with such a

Sigh, sorry, Carlo.

ATB,
Ramsay Jones


