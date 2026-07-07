Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258643C7CA
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448359; cv=none; b=P4+EDr2HrUfy8+NiRQkzfEB+Q9r5oNigm1IsOXg01py5NBB2zTxKhXjfLfH/EoUzOXFdlMaAYpyhy5ebMPbbejuLMIo/p3S1GKAPSWLrxYUltQQkzRQCrKm+yu+HbjpVqtXTdjxL0Kxk7wQrBJq5RRTVKGWPCNVu8yp2mFmP/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448359; c=relaxed/simple;
	bh=Qqs47qSNRiqDeJfY5XyCyGOo9iDhowtYelwcLW0GsL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmH4whzAssEOdyR9yXKNucgWq1wXbiPukpLa2+Bz4nGhrk+8KGDMLDdaVRwI1CkuZngeZowtaSAvQuqkJLIbBK6weWTkXHSJrJF+6X/ihWzZVHDF8x1gvVos4JIBBa3Y7lte1DUL27gNNRLmJzSxcAraLZef0oouViOdydcMmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LldGXpu1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXSXrohM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LldGXpu1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXSXrohM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E9771400138;
	Tue,  7 Jul 2026 14:19:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 14:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783448356;
	 x=1783534756; bh=q/mXGkj7B2tYjQ/Ry85dkZ6s3rjUqM3Uk1B28ZtB/MU=; b=
	LldGXpu1IW969z7hsgMq8UDdPudqsKNgTGSollst+egAxm2NbJOSywtA6FblCa8I
	C8ZXJ1+fnQyMfgQluG3wA24vJ/aPPn+wvYOA78e3mjx5elzl13wBJE1Dm+j6qqEb
	5KTznvQjFgBQdP7BSBDIzyHtfQAEJ94GvjlQpoaGSS9PaL9skWR+D1sCJllzieY6
	jsF2uaJWTf3vy+VSaq2bbe1aPazU5ILEi2ryUn6VYYcXXQk6ehnR/OARLFQa6Mbo
	ytG/WAKb8g+HmbOrmPl6tOxjQJzyNWEfC6j7sb1Cj8+3OsK8W8L9x7imAAzXoglr
	GFCbFlWf81sSKa3NTmAX0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783448356; x=
	1783534756; bh=q/mXGkj7B2tYjQ/Ry85dkZ6s3rjUqM3Uk1B28ZtB/MU=; b=Q
	XSXrohMcACmHZxKGWI3t9jCZ/Af+F1JW1W2JKUhy2gIot0Svk8HFN/aHP1J3HbXc
	WyFjBloHUmGWe5NHRoiWMG7sFSROjdmGJLMCav5qb4kgab8gmDYzQJUuZO+UYtMk
	ryhUxT0RUQJaYqHF+rCenEuB6DyCBBNOg0MnN3Jj9/dievDmtrbHnDcccr2N3K9e
	Jh2VhFMl+aIUWjwAhyXGL+8QzLG+2U/Kv2HntmgD7cd6OlnRwc+tNFwWpN6Ylpnk
	DXUenC5GNMWVXZN4Hm884/EfN2QeI0BONiwMJq6ejQ/0wTnoaigauw6ZJYK1M9WM
	6EJpZej0vqS1Eeh29gh6g==
X-ME-Sender: <xms:JENNaro4yLjRCXc5CtLsaQ07yMPn8fqi_aCIj7_tPcTMw8YCfbI6DQ>
    <xme:JENNasgp3EKfYPLcnapwNWYvaTe4-nkdWVEETBIU8-lGZ30jFG5P2mRwqM6xRd82B
    WVveD-wt5xZ1-IgKPWYlXFU3urAoXSK66Lcdm3kbmLfPyhH2dnKeQ>
X-ME-Received: <xmr:JENNaggNutx-9s5GU6PpP7pzKwM6jmISZRvM00ru3BhP-Qp07EYyenOEFZ1VJtV_8ng4sBbnLrUSTHc7WSCZ-c5WyniE_7bdVYIbnu8>
X-ME-Proxy-Cause: dmFkZTE/fvMbhYduPUHaIF1Dl9G+zr4nYsHDLywheEX4SUtRqo8sZS3TUaumsNeYYexyIM
    6xsORnqlCmKx5a3zDu7A5HL/C4OY31s8CD1UUsKOXY29MYcX942sEbkOe7Sb/JSWmWUh47
    Z7Szok+l8B+d0CJL0+djOLwDBGzlxtGelxZnT6ATf3AC2u8zP87qU/qllUPqnNJOH3k5h0
    fqK4Cv5oiO/OAwplWVfm1UclFPBruwz9F3lhm6n0O842aagPhq54IGrU0lEKBa0CXC1t4K
    YbU1VOBM5uGEO0qrxQgm/sYvrgjP6WOIICAygwvsZxW3FK10wKBeBt5RjoZMHhLa4QynPj
    tGDGMQY+uRkNKlobkTmmjrfcfaeIg1gzc7LBY9xuQe7jmC7U0V3UpcJ9KSke29+ZAuHfDx
    43rRNlJgMhefyHYMu8MmEf3wGgg/gYT3ivmDcf5PlUVeJLjgUg65o/Eu6hTZQXeBjsUCGW
    UwL47hfhX8K75Q7EYclKoOYiGo+5b7EkCQHJ37hxfycy6IYWMEVRABgso3DWb9G8kBsN2k
    38oSMjTCGJveVQq4dCZhzKt6d+/RcqyiuAyV0oXUopuLgOYHOYsQ+kjhY0q1WPlNkwX2iI
    rRE8P3rLs1QCRq0Vf4bpeVADDxnp2NAQbv9rlNShbh/k16zfsBxMVidbIpNg
X-ME-Proxy: <xmx:JENNaqjm7ZvXN1b_L2euB210ses348-cehkDkgh267gIP4nIvBAE0Q>
    <xmx:JENNaoLie6mFN8ZvQXTdEZJSBVyKYoU-SK8wLsNrogc_Q34jtySCdA>
    <xmx:JENNahGXFAeUgO31PJoI_fGScu7ju32PMj7TWBS1nftQFdDM099k-g>
    <xmx:JENNakTgYts80AqPGca3wnecSizmMgEwhbTNPWclfZfEQLxi38r4xA>
    <xmx:JENNasUfyMa1evjl8FKcE9RA9QAEJFnL_R3A4l4nruln_P7vL-H5rmDZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 14:19:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: grawity@nullroute.lt,  git@vger.kernel.org,  Mantas =?utf-8?Q?Mikul?=
 =?utf-8?Q?=C4=97nas?=
 <grawity@gmail.com>
Subject: Re: [PATCH] sideband: allow ANSI SGR with colon-separated subfields
In-Reply-To: <8addf7c0-ae39-f1c0-20ab-52114702aaf6@gmx.de> (Johannes
	Schindelin's message of "Tue, 7 Jul 2026 13:45:44 +0200 (CEST)")
References: <20260513070803.163546-1-grawity@nullroute.lt>
	<8addf7c0-ae39-f1c0-20ab-52114702aaf6@gmx.de>
Date: Tue, 07 Jul 2026 11:19:14 -0700
Message-ID: <xmqq4iia4q8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Mantas,
>
> On Wed, 13 May 2026, grawity@nullroute.lt wrote:
>
>> From: Mantas Mikulėnas <grawity@gmail.com>
>> 
>> The SGR values used for 256-color formatting are officially defined to
>> be a single field with :-separated subfields (e.g. "\e[1;38:5:XX;40m")
>> despite the more common but kludgy use of separate values (which then
>> become context-dependent and lead to misinterpretation by incompatible
>> terminals).
>> 
>> See also: https://github.com/ThomasDickey/xterm-snapshots/blob/6380a3eaed857c182ea6cfa78cd706966b2628d0/charproc.c#L2047-L2118
>
> This change seems well-motivated and well-executed to me. Just in case
> anybody was waiting for my objections, there ain't any coming ;-)

Should I take it as an Ack?

FWIW, this patch literally flew below my radar coverage.  Thanks for
noticing.

A need for fix-up like this does makes me doubt out decision to go
with whitelisting very narrow cases that are known to be OK (and
finding that the cases were too narrow and we need to extend),
instead of rejecting known-bad cases, by the way.

Thanks.

> Ciao,
> Johannes
>
>> 
>> Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
>> ---
>>  sideband.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/sideband.c b/sideband.c
>> index 04282a568e..6cf70ef6f6 100644
>> --- a/sideband.c
>> +++ b/sideband.c
>> @@ -163,6 +163,10 @@ static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
>>  	 *
>>  	 * ESC [ [<n> [; <n>]*] m
>>  	 *
>> +	 * where <n> can be either zero-length, or a decimal number, or a
>> +	 * series of decimal numbers separated by a colon (for 256-color or
>> +	 * true-color codes).
>> +	 *
>>  	 * These are part of the Select Graphic Rendition sequences which
>>  	 * contain more than just color sequences, for more details see
>>  	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
>> @@ -210,7 +214,7 @@ static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
>>  			strbuf_add(dest, src, i + 1);
>>  			return i;
>>  		}
>> -		if (!isdigit(src[i]) && src[i] != ';')
>> +		if (!isdigit(src[i]) && src[i] != ':' && src[i] != ';')
>>  			break;
>>  	}
>>  
>> -- 
>> 2.54.0
>> 
>> 
