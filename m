Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383203D98D
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766017; cv=none; b=Q5MMZvRaiYoqUsbvzU6D+FMCAMIPkPFT4NQSaTFceHrEptUvY9V7ziJYbQkHxH+GoCG7KZzDrf380bIq1yNFptPmnRha0jEieOhxFQrpoZeYkcwDqmjvyfIFw4szI+kRzxNoWNt129sk05nMLpzvf1Xb2XMrQa1GIasVkv/OBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766017; c=relaxed/simple;
	bh=eqScSGNB0RAuwNaUt+wf/51y8AjAOMdXgHmJ7CN4vlY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2p1N+b3mN4ulrBFkdHckSNd5Wu8SGL9D5VBthNDoUc/jfCMZbBzLhNNCvRmVYp6yxvGg+SyAQwgV3op1OqDUiohduBaGmS2J0tGIjWDjVISEq/8zCib+pA5lU9gvsw6tkcqzHA5njuWTfOCClcO6zJGdndE/YNlF44VU3pviCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41CJQm0a3628148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:26:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>	<xmqqbk8nbvqy.fsf@gitster.g>	<002a01da5c94$a1bc5340$e534f9c0$@nexbridge.com>	<00fa01da5dcd$5b060150$111203f0$@nexbridge.com>	<xmqqzfw57hw0.fsf@gitster.g>	<010601da5ddd$3dec41a0$b9c4c4e0$@nexbridge.com> <xmqqil2t5wwk.fsf@gitster.g>
In-Reply-To: <xmqqil2t5wwk.fsf@gitster.g>
Subject: RE: [BUG] git 2.44.0-rc0 t0080.1 Breaks on NonStop x86 and ia64
Date: Mon, 12 Feb 2024 14:26:42 -0500
Organization: Nexbridge Inc.
Message-ID: <010d01da5de9$6c40a530$44c1ef90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEKhykLt/LB5hLsEaYKWm4eL/p/IgHSi0nNAaWPrR0Cxs1+jwIIq4sYAXenlhgBVDjmJbJOKJKQ
Content-Language: en-ca

On Monday, February 12, 2024 2:02 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On Monday, February 12, 2024 11:43 AM, Junio C Hamano wrote:
>>><rsbecker@nexbridge.com> writes:
>>>
>>>>>This looks like a good plan.
>>>>
>>>> This might be trivial, but I cannot tell. The #ifndef should be
>>>> changed
>> as
>>>> follows:
>>>
>>>https://lore.kernel.org/git/xmqqttmf9y46.fsf@gitster.g/
>>
>> I applied this fix but there is no improvement in the result from the
>> last report. actual just has two lines. expect looks reasonable. I
>> still had to modify the #ifndef.
>>
>> I have tried cherry-picking the change (no effect), building on
>> master, next... am lost.
>
>We seem to be looking at something totally different.  The later patch in
question
>(not the "looks like a good plan" outline) does not have any #ifndef and
applies the
>make_relative() logic everywhere.
>
>I would suspect that cherry-picking f6628636 (unit-tests: do show relative
file
>paths on non-Windows, too, 2024-02-11) would be the simplest.

Would you mind pushing that commit to github, please? It is not in the
current history.

