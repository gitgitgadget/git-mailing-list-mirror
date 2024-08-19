Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74C15DBC1
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105629; cv=none; b=P2WLMD5ztkb1s03+gehRde0OcsTvXaDXVcToyGk6yy8wRz05E3Wn1dvFRaYyHdGYvdXBXnsXdVPSMr9DSjk1LN6RP9BIqZxKez+lnWCaUMm+Xh5VdkvI2W/K5ZDp66Z+qwc+btKbv5heuWhnPCMERQu1rxp4dJAld4LfBos4qu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105629; c=relaxed/simple;
	bh=zobrw3RZBUxCu7/lHNqJJ4Z4lAzOp9OSTtz8sIsHXxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gsi2k2aBGK1ixH/vsM9sceKZonUs5s+CgbH59ZbWrFltg3v26ELmke4x1SYeRxjsFGHBwqAvi62Rg7kUD11hKyPak7bjSCNyU8aXWDf4TG8UuATHkRkS7TLAaNbNXri1tEOIhZPigXSyttRFdIvkThJsh9SEE84CcByRcL62wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UcKSA3Dk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UcKSA3Dk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 286C81CCB8;
	Mon, 19 Aug 2024 18:13:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zobrw3RZBUxCu7/lHNqJJ4Z4lAzOp9OSTtz8sI
	sHXxA=; b=UcKSA3Dk/Y4LUfIYw5wh4uRhQ3iIAIVtPb14kuBBR05bJiPBLTm5K7
	Kv2GL9r0N9kD1EjRrVPjC0hyMpjlvogHQZg9JLF6iCX7h6F5NalVBFXuwjGOa4oG
	LpmzXHpozktnzmm3pdz9jPDDRkQFsXydK/EEFJMutYsmB011PCuzs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F66D1CCB7;
	Mon, 19 Aug 2024 18:13:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9970B1CCB4;
	Mon, 19 Aug 2024 18:13:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>,  <git@vger.kernel.org>,
  =?utf-8?Q?'Ren=C3=A9_Scharfe'?= <l.s.r@web.de>,  "'Kyle Lippincott'"
 <spectral@google.com>,
  "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,  "'Josh Steadmon'"
 <steadmon@google.com>,  "'Edward Thomson'" <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 2/9] t: import the clar unit testing framework
In-Reply-To: <01ed01daf281$c5dba4a0$5192ede0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 19 Aug 2024 17:50:06
	-0400")
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
	<369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im>
	<xmqqr0akcion.fsf@gitster.g>
	<01ed01daf281$c5dba4a0$5192ede0$@nexbridge.com>
Date: Mon, 19 Aug 2024 15:13:41 -0700
Message-ID: <xmqqmsl8cga2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C07E7E8-5E78-11EF-A952-E92ED1CD468F-77302942!pb-smtp21.pobox.com

<rsbecker@nexbridge.com> writes:

> On Monday, August 19, 2024 5:22 PM, Junio C Hamano wrote:
>>Patrick Steinhardt <ps@pks.im> writes:
>>
>>> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c new
>>> file mode 100644 index 0000000000..3fc2c76815
>>> --- /dev/null
>>> +++ b/t/unit-tests/clar/clar.c
>>> @@ -0,0 +1,842 @@
>>> ...
>>> +
>>> +#ifdef _WIN32
>>> +#	include <windows.h>
>>> +#	include <io.h>
>>> +#	include <shellapi.h>
>>> +#	include <direct.h>
>>
>>This seems to break Windows build
>>
>>  In file included from t/unit-tests/clar/clar.c:22:
>>  D:/git-sdk-64-minimal/mingw64/include/windows.h:89:10: fatal error: shellapi.h:
>>No such file or directory
>>     89 | #include <shellapi.h>
>>        |          ^~~~~~~~~~~~
>>  compilation terminated.
>>
>>https://github.com/git/git/actions/runs/10459342252/job/28963152995
>>
>>As we have other topics that I do want to do well in 'seen' before merging them to
>>'next', I'd temporarily drop this topic from 'seen'
>>and push out the rest of the topics.
>
> shellapi.h is not portable. This breaks the NonStop build also.

Even inside "#ifdef _WIN32"?
