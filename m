Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84873491E1
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646484; cv=none; b=uQoAUgkplR3idbkHMcmhN3MheAuFpo2HnqhoDJ3M/F2GmfOzVR0XJQDvjsBV2ggAP3JATGes60zH5E7r7a2IGSv5yt0Hdzy9Ga57xxt8XCkGwCQGEYHdgFTAUWAGwD9+9zzKocnkKBGcPJFcRLd3je2BKA2jvrRDq575AjDhAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646484; c=relaxed/simple;
	bh=mK2xtocOTxkfJpxDM+ofcBOSW8KvCTlU0Idw8D5sEBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdHaLJX2suelEKtg3P40M7kiAv/vkkYQMZK+b4OSo9X911koD/OGVSPW57DRGOzQnNkm0jCzyaV1ViV2N6ENh2POPzuH0tFocKC9TsXw6N3RMo0eHFxAn3h/rIAmPF2b4LIj0xUCTgik5TGQxhHCf18prKXo4e+Bd0xKucrdqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ECGraG7M; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ECGraG7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770646473; x=1771251273; i=l.s.r@web.de;
	bh=G5GP/ceMeqw0gkYcfTNfh26oGHeHnHY6lEblTnLBOzU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ECGraG7Mde2u7f4ncqhJtG1H4MUCv2uMENa5DKn6Scfx8RUwtmDwEokZQI3bg1D4
	 MyzwBqjNB7ZP3IVymalpRNI1PJMuYUASQZ+3o3JEvMTYcsc/CWqFeiHZC3HjlcUeQ
	 go9edGJ+4wzQnrc1Ieo8SP0pPVMqpBu0rDGVmSm4I2dKt7hRrhbQ6Tr4XhGOP2gYg
	 HQdJyUxGasQYE0j8/VVb+EGQB8sgIbclvC1gpai22SfKUgHzJciZE20iNLQ1Rt+ct
	 hgVMTcDZkZu/Gn/Fwy+97X1WWOq/GuGItVH2RkfpkOpjFN0UXJM/fw+fuVJIWYDnz
	 tLcL2OARCc5AEHE8mQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1vnF6f23rs-00A15S; Mon, 09
 Feb 2026 15:14:33 +0100
Message-ID: <ee549683-1c80-4a9b-83b4-a44fafb1a47f@web.de>
Date: Mon, 9 Feb 2026 15:14:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
 <aYmtab_uqMZBygAG@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aYmtab_uqMZBygAG@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8/iLyPgocA2DkJXGlG4d7g+yQnxpuQTMs1B9G7wi7nwCWyQQSOC
 773CiBX5Atx+Ule9+7KClDDErTduLYKWyZhYZLWppv103eGQ/0arM/WDg++KaknfgMG9cjx
 2tji9B6cp5Ak7K3gBqRc9cjwkWmifBdV9EuxDLyGtxsIKCx7VEh2GhsvYxgDX/g7srdlwCL
 IAo7GAbyb+e0DeVPrmFpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jadsBI5EFUY=;P5QtNisSRHKh4RtseNpmgEgdXfW
 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
 wSTsj0gB12u2WmIX6ptL/A8eYjmMxqZ0VngouC

On 2/9/26 10:48 AM, Patrick Steinhardt wrote:
> On Sun, Feb 08, 2026 at 02:47:40PM +0100, Ren=C3=A9 Scharfe wrote:
>> diff --git a/xdiff-interface.c b/xdiff-interface.c
>> index 1a35556380..cd7493730b 100644
>> --- a/xdiff-interface.c
>> +++ b/xdiff-interface.c
>> @@ -7,6 +6,7 @@
>>  #include "config.h"
>>  #include "hex.h"
>>  #include "odb.h"
>> +#include "repository.h"
>>  #include "strbuf.h"
>>  #include "xdiff-interface.h"
>>  #include "xdiff/xtypes.h"
>=20
> It's a bit surprising that we have to add this include, but I assume
> that we use a function that's declared in this file?

Good point, we don't actually need it.  It's left over from an earlier
version that had a struct repository pointer as new parameter. :-|

Ren=C3=A9

