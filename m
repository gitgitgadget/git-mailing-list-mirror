Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722BF136349
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766016919; cv=none; b=D0+lBlxpNVgoh5Lb8+exfmKymNP5bLnjtnEheLWk9kDfMTCUQiqCRsW3qfeMnONzC7MDzRfzA2R8lYBzwsFkwSWhY4SIZb+1XLzOJ93AhQrte14zRqt+vCYfgJthtuaM8fIYUKN7b21jHpc9TEXHoss71SmZoW7AdzjPo9sSNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766016919; c=relaxed/simple;
	bh=sTa6bDQlIAyVoDmQXk0hTePGvqdd82cVkoWg6xDxRF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gogmgQv/3FHuSP5+uhKvE1AHDuqHe6FPcZucOunBwhe3qVaesJ03DKWApld190DIRWBdAjmrLN8UZQQdB24oEM7lhV8GNFelhsnl/4QUM7nX9BgD4Ev9Wrqoo6iexuyQA7RJ0X5DPp9xKR06OXhNaLqFQRkDEfIspeVrUQ9pjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WyniqsWu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nEZwu3ma; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WyniqsWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nEZwu3ma"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84AD014000BE;
	Wed, 17 Dec 2025 19:15:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 17 Dec 2025 19:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766016916; x=1766103316; bh=BQxl2lX+P0
	Sj6EylIt54UEVuAKSj32wkkK2fpqpqi0Q=; b=WyniqsWuebLk4Az6Oor8s9CB9Q
	BUsa3UylLqrELxC87ZIKJU9+XMgxu/nHOdoqd+fbjkO9rv/jV2ur1jD99LUvfuyi
	5ROkttIEzrizZOzLKgTHJbshotldYUDrTTzM3e9LNp4nX8ciNM3n9PD0uwsJbGwm
	nCOb+I5IT6H1FqWsccnLC9mB3oEvbOQ2g2aKDd3yLMD+UXzdNV+XqlzG4PWq+yRF
	l6DgG92TLNHk1wUanmAE/Aw3eUWUI6T3yQ39JBlFQWhzlWiNZWUDy67srozB9avN
	A3s+wvk8iwu0Fm6c+agxGyLVaE1cIuUUHDhkArQGHe0mgu/W9N7f4A3XINNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766016916; x=1766103316; bh=BQxl2lX+P0Sj6EylIt54UEVuAKSj32wkkK2
	fpqpqi0Q=; b=nEZwu3mapFTSDjfrMN9bzzuoMcDa2elfDMwxtzq3IzFVqWaCCsi
	+uPvkc7Oi7yfcmSgNk49I7hIhRkuK6yCJ9JgJ6iRdsETDKz7Yabz82vKHIvVbCr0
	ZeuBPtFrFmIyu5dzzlXDUl9tvkCs+wXs2YavB0qihRsmDvywIB4iAvNPEjdnMPjZ
	WDanA7AMOHbCj9NmhyGAFQ3oOsB/IpfnvEGjnK6131s0jZ8tVXVTWtcQHITX1/uc
	9AytjEeazmlRIDZ+QnzWID6tfQ/JVgnjxN0BghQgmcCtVaooScMekmOrhU200j/l
	X5fPDnNJAdu/AK1OKhwBXyconi8enqIaJDA==
X-ME-Sender: <xms:lEdDaV4bbjbOPh48ypM-Dd2yQms32e4V2HoBZb2rJyxAq_JPKKZKjA>
    <xme:lEdDaaUS8omXhVxNDxrTmvsofMW5uxxNsH5fEcAOuLUdWQA9z9otedKVaJxoJd7Jc
    YcHHhdMpUPqIWoyE1NyhQpzkpQ7EXGRzw6p4W7cCsZ3KismjbcTbQ>
X-ME-Received: <xmr:lEdDaZ02bLMGHCffG3DsD8-0wcaI7K73ZLktfQ3Ngl5tx5m9ZyN6f19H0bCLCBr50j28RxiQrF78mqWnmq4CEAdJ8M2fgLlzTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrghtthhhvgifhhhughhhvghsleefgeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lEdDaX3SqgWSCXkHsdd6i4FUNYSls_5XoB45XnV9_DMyRgu0CyjvMQ>
    <xmx:lEdDac9odb4WXxJLpu3bv8eYjJXc7y792ZNtIzahCiDEviibXNBOpg>
    <xmx:lEdDaU0bjb8qvdU6EMiqZ59OFMefQAWusHfECd4iJyxWU0kBQ9KaOw>
    <xmx:lEdDaZ_XarSKqFlPdZKShL82gxNVA8LV4jr0uztzTeGgytodzYxtZw>
    <xmx:lEdDaSWdrpS6coM8ZrjjISd1Wtw45KGq9JqDvV02oB7GZFUO_3fodyaW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 19:15:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] docs: note the type of core.attributesfile
In-Reply-To: <20251217195917.25710-1-matthewhughes934@gmail.com> (Matthew
	Hughes's message of "Wed, 17 Dec 2025 19:59:55 +0000")
References: <20251217195050.24837-1-matthewhughes934@gmail.com>
	<20251217195917.25710-1-matthewhughes934@gmail.com>
Date: Thu, 18 Dec 2025 09:15:14 +0900
Message-ID: <xmqqldj0zlv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Hughes <matthewhughes934@gmail.com> writes:

> This change is basically the same rewording as was done to
> 'core.excludesFile' in dca83abde2 (config: describe 'pathname' value
> type).

Indeed, when we look at Documentation/config.txt in the commit
immediately before that one, the description for core.excludesFile
and core.attributesFile starts quite similarly.  The old commit 
dca83abd (config: describe 'pathname' value type, 2016-04-29) should
have done this already back then when it touched core.excludesFile.

Will queue.  Thanks.


> Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
> ---
>  Documentation/config/core.adoc | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
> index 01202da7cd..9bc9de29d9 100644
> --- a/Documentation/config/core.adoc
> +++ b/Documentation/config/core.adoc
> @@ -492,10 +492,9 @@ core.askPass::
>  	command-line argument and write the password on its STDOUT.
>  
>  core.attributesFile::
> -	In addition to `.gitattributes` (per-directory) and
> -	`.git/info/attributes`, Git looks into this file for attributes
> -	(see linkgit:gitattributes[5]). Path expansions are made the same
> -	way as for `core.excludesFile`. Its default value is
> +	Specifies the pathname to the file that contains attributes (see
> +	linkgit:gitattributes[5]), in addition to `.gitattributes` (per-directory)
> +	and `.git/info/attributes`. Its default value is
>  	`$XDG_CONFIG_HOME/git/attributes`. If `$XDG_CONFIG_HOME` is either not
>  	set or empty, `$HOME/.config/git/attributes` is used instead.
