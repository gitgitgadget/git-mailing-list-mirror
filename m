Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EA128DB48
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075840; cv=none; b=sIEg/zuPBEubxHXe+ne1c1YkjoUdfCErXuiXQXSa+HZZEyA+K0p3o9wU9d4ip1j+69cGh1OgT52PtKu0KfhqK73TgFUcQA0HIniJ0NjbE6ud6GHKZfKS5+yyCEwUFpAfui+TbhV+VxG5NZfK46jjlYbj0+KSO9xtAiGsTmW9L2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075840; c=relaxed/simple;
	bh=9dkaYNCFMx0ByeRhVIH7TG33FdpWRbF4XzsOQGk2lv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xhn01XHWlVXL65Fa1SxLompHcmdlXM9AmlTjnQTD6YbUHSTnSSWNvntNWtpRY1BlIl64QJwRikibeoD+SF7zzi93Uj/ll3CPa9Z/JScZsGcqrLnoc4e2tTxH3gV3qfPMoIkmngIr1Ax6+GnGy6AEI2uvs1mqGZZ4uUCv+Ey3tf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bch974q4yz7QTlK
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 17:04:59 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bch8z2Bj9zRpKH;
	Wed,  9 Jul 2025 17:04:51 +0200 (CEST)
Message-ID: <668ce4d4-3b60-47e0-a4a5-dbf73efd1e75@kdbg.org>
Date: Wed, 9 Jul 2025 17:04:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
Content-Language: en-US
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 Junio C Hamano <gitster@pobox.com>
References: <xmqqplebzgm7.fsf@gitster.g>
 <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 09.07.25 um 12:41 schrieb Carlo Marcelo Arenas Belón:
> CC: Johannes Sixt on feedback for SIGCHLD in mingw which uses 17 instead
>     of 22 (cygwin and others) and therefore seem to cause signal to err
>     without setting errno as it should.

I don't know what the relevance of the actual number of a signal is.
Nobody is supposed to use the number, only the macro. But I may be
misjudging the situation as a bystander of this discussion.

Furthermore, there is no such thing as "a signal" on Windows (outside of
Cygwin), let alone a SIGCHLD. Therefore, this topic about SA_RESTART is
irrelevant for the MinGW port.

That said, we have a very stupid emulation of SIGALRM, but it doesn't
work like a POSIX signal in any way (if it works at all).

-- Hannes

