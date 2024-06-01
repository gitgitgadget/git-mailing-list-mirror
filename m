Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99224386
	for <git@vger.kernel.org>; Sat,  1 Jun 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717273428; cv=none; b=WCZPC6zNCfkx/jGb4/i+xsyVN8bSvPHctEh7/RHgvTOQqCpQoUe91gGbtNSmbgyPbl8iXKiBRlVukgRFuIzLdrX+P9MDdRVSzRxL7rOjlzgPubuJkokTsbZPj/0PWDmu333YnHMxLAZb6T5loELpfQu6G+iR/DAbvqNyvR2c9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717273428; c=relaxed/simple;
	bh=K3fgdjqa8zmen2BcOx/GRDlMvbKmr9xP4lEvu01Chgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBsLHQ+nzW2etJbQ2kgWqEYltcbsTYVA+gzFEe516Yxe4O825SprrpNRKdeMZdtJdrDNi1rrXYqiCSubmQay4ku+p2Ue3QelhPHpzRwz7c/OpxXwGN3U2Ru41Z/pcoQSPk/mGd02IhIBMGB+ZxwMoiuvZObARj7B7NlTUe0rQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=cr27NI29; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="cr27NI29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717273420; x=1717878220; i=l.s.r@web.de;
	bh=QIFEVelJBgzeO+n421aMir6EFaF/hOEIhjDByeVE/7k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cr27NI29C+Y3PFJEEC4AWj5nfQfDeOes55WqhaIZUDHfmduZYpIL43GFNCZNH0Q8
	 p8G5t9Awe8HTldy48wrq8EdVEAR1NM5rPCG7vPmhgeC1JTu30xthgOlB1hMggOIPS
	 adBDtdxXl7CMBL+cy4wNZ9YN4S8NdNXEclesE5PhErX6Hj3tIF408UFnamb8AgJlo
	 K58YQAqSRnIIfu+3unWfpMjLFjZD2XySKHxJf3i+bdJ7zZrrkXgstkyDc9Q9+j3Tz
	 uhBGjuJp8e78x7IVthdvFoxBllzdQS+vtFqcuWoxyG72Qu27We4BfvQqcPu42xFmG
	 mnL6UoSSQlowywRjWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGSW-1sLmjm18bK-0066Df; Sat, 01
 Jun 2024 22:23:40 +0200
Message-ID: <f76eaa71-2b04-4d6c-a378-a40010aec22d@web.de>
Date: Sat, 1 Jun 2024 22:23:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] difftool: add env vars directly in run_file_diff()
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <c7c843b9-0ccf-4bcb-a036-d794729a99d6@web.de>
 <Zlbf1IY4jFlUPD7e@tanuki>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Zlbf1IY4jFlUPD7e@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w8XdoT6QaF3KlG8FXL5Hnd8Ql96djugBRwP+jezjTIU+eXYWLlL
 VNA1lNdiZ4KcqRiqq1Jgh++7/o5gSD7Rt0YY3QowBCXllAghsf7DXCgTl9kc1qUqxBRbxPF
 5CiMDTcFbzKmIQCPaQTuc8TIRKOrQfpLIVn6PXAXXnjqgZTOroImHTMxEgyIrXSXXIz2MM0
 FxqJKKeTVA2sd72ZWHBMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GgBcwcOW+3s=;mj2vutWM1PhKR/XLroES9yhoJUv
 9LGeN7BPUtJg7ngA3lfe10C8RI7ULQd31bBx8vG+2BOOwaQROCDxrv/Z/16UR0IvX6g/rcaBr
 a0aPZlRP8d2wuYr2MduQQvKJpIchazPtvuc79QLBx2ta3bMm9CJgncx1gz+pIFx/4/gBZguEI
 cPm4V6t74fRrw4sBB9a4qu/4nDrd1k552DNjGtOxMnqKP7bUyLnGi5d8pns50PgDwmeMCjTXL
 R9sfL3LMHIu6N2pIXhF/at1bNF5FHOk64TB1f4L2jcauC331CZLzuM2W0+9ydcPC3oVceTLZg
 khnd900AzVU92unKHYoe1+PpgUUeWZh49TZSxOw6qAOXDn2Z+yPLlzYBnRGMz1U8lSFD1+ia0
 nA+ipKOZmLciqplikTlhZd5jDRKZzWPhB1yEEl1kxVTVjlyvQFdtJktaIfI1WdapFEgJSjPiD
 AbEIeFkiZY8NOORrmlplL6E0Oj2LWdzs+nhxt4JUJbyKuBTgnOaPgDaVHT61HBeMIEPhTSvsB
 4di9SQ5vtsPb3JsuRc68eu49OAYyS9aEhGNmCVwrHozJlnmvqApZr86b+kcGeNLMiAMVX3i61
 jxLUzJ0KN9SBg3QMTNHBj+vEnb5IzPs7F+40sFyhsuDKFFfAMNXCb1blPT3kjIsCCEcyp+VFE
 APaxT+AGq++lTbsMtbXarDqQztTc2BiRxqV/MgMUR95eIhSQD73eD8bVJVU/aBkqQChH8FgCb
 vC3s+l5v8NG00CP0AEQ2GdN34uz3g5VTY8KHGPPmxdhE1B8LydiK4aCnTBwhllRpZTA3TPA8Y
 ly/F4OHk1V3pv0uDFCQ9pWTWxeNw9JRfEnya3ma6NMQQ8=

Am 29.05.24 um 09:57 schrieb Patrick Steinhardt:
> On Sun, May 26, 2024 at 10:16:50PM +0200, Ren=C3=A9 Scharfe wrote:
>> Add the environment variables of the child process directly using
>> strvec_push() instead of building an array out of them and then adding
>> that using strvec_pushv().  The new code is shorter and avoids magic
>> array index values and fragile array padding.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
> I don't know whether this may cause more allocations.

It doesn't -- strvec_pushv() calls strvec_push() in a loop, the
patch just unrolls it.

Ren=C3=A9
