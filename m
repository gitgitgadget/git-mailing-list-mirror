Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="axNyXduQ"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC27EA
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:17:03 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61FAF1C6966;
	Wed, 13 Dec 2023 10:17:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kOUBDRpbBkfKJPlMjYlPpaObsl7yGPdb2C3Dx5
	iEHLM=; b=axNyXduQqotfLhMXwq5dAZplm3Cw1vioG4HZcwei9BZhjhIPwtxqU6
	Zz3lvLCV3voYO1/NVBP1WgWWy0iPA56F39RbFOF7v7AhbkNxUxOo2AzGeJumPHJy
	RXxod6OxQXUAyQBf3pVBk5FaMmfv4p3RfAeuwMLr7wbzLbt+Qgi00=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 598A41C6965;
	Wed, 13 Dec 2023 10:17:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A91BB1C6963;
	Wed, 13 Dec 2023 10:17:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  AtariDreams via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Seija Kijin
 <doremylover123@gmail.com>
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
In-Reply-To: <20231213080143.GA1684525@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 13 Dec 2023 03:01:43 -0500")
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
	<20231212200920.GC1127366@coredump.intra.peff.net>
	<8bea38fe-38a3-412a-b189-541a6596d623@web.de>
	<20231213080143.GA1684525@coredump.intra.peff.net>
Date: Wed, 13 Dec 2023 07:17:00 -0800
Message-ID: <xmqqil52nndf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AA7562CE-99CA-11EE-8B99-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> Without digging into the code, I had just assumed that flipped_block was
> used as an array index. But it really is a boolean, so I actually think
> "flipped_block = !flipped_block" would probably be the most clear (but
> IMHO not really worth the churn).

;-)

> I don't even know that we'd need much of a weather-balloon patch. I
> think it would be valid to do:
>
>   #ifndef bool
>   #define bool int
>
> to handle pre-C99 compilers (if there even are any these days). Of
> course we probably need some conditional magic to try to "#include
> <stdbool.h>" for the actual C99. I guess we could assume C99 by default
> and then add NO_STDBOOL as an escape hatch if anybody complains.

Sounds good.

