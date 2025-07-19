Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22CF9E8
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928582; cv=none; b=YgqdPictnN8ogkZjm/eRy2laBoiPmZ3jzD0MDElk0xEK9I9ucc88yw5ji6qkLf1qBQLr0Dp3YODj8GX53f6PbZQdE8MAhKo/Sj7t4pOccd1oFLDimYIFHNbsg8/CEUbsuLGBtGw6kG9HCA5sTRi52QAeCMXBG9UJYjolmXJ6jCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928582; c=relaxed/simple;
	bh=NEZ16/hYgoBMwIvRSUOC5Cj7MZhRFyfaolVtGx6wUdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwJ9k3v9TN++Mv1c5AQMeczdR4tPzutvECUVABoagV+ZvO9M09QW0Mw6Q2ouJFwU3iFJeceGQC4SSDgYEbvntF4yFWe8ksca9yd2sIQAfGHIRVNWv1UiIulYnqvih74DVx35iSUIN8BnjE8qowV2Toh64eBxZrsqhd67KZQOeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YLycy1vM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YLycy1vM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752928565; x=1753533365; i=l.s.r@web.de;
	bh=A80LUIS5F1Us/kfBoffpb1sCfIPanBkWP681Ucx8eF4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YLycy1vMU/XPgwYO/2TSO4CNzHhu0Tk2tHrsJUaPCwu1Virg1HTCdLqKT38NdsPc
	 hfY+zKajYbCjmeVPxi28ME3mZ76kxQgc//hRJmIT03wWZKlOrH74uA8jKtxLwQmrw
	 o347uA8hY+fwf3ytNuC2yTz0+7z25DBEBbOCta/ngdlYjKIlU8vlPmD9tSxnp6UgR
	 aZWGTOahslaDLusprvkEPBs7iCXIGPdZVteuiefACDHXARI3dG9Wqn/NKDjaPLGW5
	 UdN5m8kI7w+ur/CAxlDF/OI9y3mANFNVTDcje/cob8aBRGr7yBAdGnFEVOv/caVak
	 xufRvUZeWdCPJjTfvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZM3-1uALWv3KDB-00KIuK; Sat, 19
 Jul 2025 14:36:04 +0200
Message-ID: <fc4da804-37ed-4425-8dda-14cfcb607906@web.de>
Date: Sat, 19 Jul 2025 14:36:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rev-list: make "struct rev_list_info" static to the only
 user
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqa551127o.fsf@gitster.g>
 <20250719063551.GA705356@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250719063551.GA705356@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yyueMcbFKtBOEVsPcz7mjez/j9tntlmeWYY6sR2z5SKjlRUSH1f
 j4enPSapTgS+y8cSwEBQVPMF+1WdPqq2429KZBZ9RVhdYv2DSS3LX73/M5hVw+W5EvIFpmh
 TX1wE0ICyJ0hN8GL0jHFU8SdGSpIaBjFP7UflUIYcyqcaT5ULDdFpC0vrvQAJ8wMgdvRuUf
 YNss4E0DH7nlOSbavQ6ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u7yKt8G3NvQ=;3ywthx6/nccDluFNaMWTrUMLdlg
 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

On 7/19/25 8:35 AM, Jeff King wrote:
> On Fri, Jul 18, 2025 at 04:58:03PM -0700, Junio C Hamano wrote:
>=20
>> The structure has nothing to do with what "git bisect" does; as
>> nobody other than "git rev-list" implementation uses it, move it
>> as a private data type to builtin/rev-list.c
>=20
> Nice improvement.

*nod*

>> @@ -652,7 +660,7 @@ int cmd_rev_list(int argc,
>>  	 */
>>  	/*
>>  	 * NEEDSWORK: These loops that attempt to find presence of
>> -	 * options without understanding that the options they are
>> +	 * options without understanding the options they are
>>  	 * skipping are broken (e.g., it would not know "--grep
>>  	 * --exclude-promisor-objects" is not triggering
>>  	 * "--exclude-promisor-objects" option).  We really need
>=20
> This tacked-on bit seems funny to me. Isn't the original more correct?
> The loops do not understand that the options are broken.

No, the options are fine, but the loops are broken -- they cannot tell
what they are looking at is an option or an argument of a preceding
option, yet they ignore that latter possibility.  So the word "that"
is best left out.  I also don't see a connection to the struct move,
though.

Ren=C3=A9

