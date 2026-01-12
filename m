Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0830BBB8
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768193930; cv=none; b=qEwoUUGgzxVmE00rKrWCOWYj0HBBSVAY4h6GyfwAwZXF91vOkALbh8gz0DCkU8S7wrfPb76mZrvR9PJztO4SsoutfdWycByElO26TCoYmHmXfUkFoWZFjyXRoCbOkEZWuDz/4+utUCZ/S9KdMqK7GEuTcw5+6Ul64bZI8xkKBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768193930; c=relaxed/simple;
	bh=h/NtrC9z+2cWDyQ1l11ivD9/ZkAJXPOLAYEhM9UQ0EY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eqSaeRWdD7zm3ObR9KC3ms3rzGeUROPZb0f/mIZxhUUqrbf+/jNKipDTSHIWOA8eLRimDVmvifC8GXrGAuv5vuoxHgNHYk9AbvKBClI8fZd8mYWUHfqhX8nTudi0ZbrdFeM0XFVMM3boOlVLozssPUQLqKwG3pMtumE+DlJ2KqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V8lLr6LE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqKrcck9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V8lLr6LE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqKrcck9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EA5AEC008D;
	Sun, 11 Jan 2026 23:58:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 11 Jan 2026 23:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768193927;
	 x=1768280327; bh=4DJHNz1Q6PWgwpsJ2pYk0gbaZjH48rIWo/QX8IoZLKE=; b=
	V8lLr6LE5CCIwvZ2G61eyLyWaiu668sCLgHFuE1nyDZE0JrMY6cwwPS9WST7+Y23
	71FXvMBoSvwK88ZyEKTqE63zXcJFLXrinEA6pxLmzqJ2TgJ6ei5NNTVQeaojmM6g
	Yj3h/wW3bBsrg0gDOyOM38wblW+/ipvZm1kwwruaZ8HoLn7/m9PJvWfyMntzwHYO
	R116+gnUKh9MQNNakeVgB4epRqSCtyxUN9Xzalpq3mTaGl9kCKWXbNCObHM0RCMg
	v2P/KcVxitgnFARX/NsBA/fcLwWQnonwBdXPcChaiKrfDv2RckgzLM13AjESPIma
	DwAKm8ml3bMrD6ue8rUFWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768193927; x=
	1768280327; bh=4DJHNz1Q6PWgwpsJ2pYk0gbaZjH48rIWo/QX8IoZLKE=; b=d
	qKrcck9TH9xYUyZEFMNFY/DtcBi0FSRj2ztPlePr+BEPVODmhbyXxxlwF3S6ZBR0
	M9WlbidwB4Drnm8bctPWnlmWcv5AivA96HaLABT0w4Vvn85BfEVvr+ty0ex09eV8
	0nfLWeC9NYZmJrXNKFFD+lsnWgurDZcfkuJ0HOKwfAPtHjF5hseFwPnTl3y0pmHP
	cdf29/IZSPxB3D9COqOOU1jJvfVgNisSjoPCry5NU23gYHv2vcpWopMcX/3NrB5g
	bAwE8HHK8/0+DrBsb0npbXidkGmjGvtHireOhHnm0NFqOGMNp7M4jJBYPeC5l5X/
	D/9hAR/AuuFoMpIUHe1Xg==
X-ME-Sender: <xms:hn9kaTcb5KAf2Re7SGab2rt1cEfA-YE7HLSD6MNMCuZafUWzATt7YA>
    <xme:hn9kaQPBdZ3fGknNmcba1co71FLBpipGyQhRgIrR1DQUrpivVBzadjrs5aMM3Rr-_
    uI3plE0GI01P74JjmdKcV9bGGqsoGuz9hJS2Tvt-S6hyNB08pFCrg>
X-ME-Received: <xmr:hn9kaRjuOc0LU4YFFOP0u7AEzciWFVfja595AAqkYs9OlpF5Kdfamb1cz_K2eo8v12I3yRFAYqQwVFn8aO6DN406p1F_IIce032kms0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdfgueejjeffteefteduiefhje
    fgjeegkeegteeuudfhleeijeeuueelvdffvdevnecuffhomhgrihhnpehfihhnkhhprhho
    jhgvtghtrdhorhhgpdhmrggtphhorhhtshdrohhrghdpsghrvgifrdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hn9kaT3-05TjUhvibtwJNGun2dEXjrv39XhMmHCtMLxc5sMT5TBjKg>
    <xmx:hn9kabhDK8jU74NN23UX3eGjwu1lX9J_6JFmxMicXwsaIRmTjbv4cg>
    <xmx:hn9kaTdzeWVS4godfxk3jvmlSPdYTJOplR9f7WuYu6Q2BWWUk0rnmg>
    <xmx:hn9kaemL2MJZVCUItL8n_805OR-VuDD-mkCfdl0bXq3xUa4EYiO-EQ>
    <xmx:h39kaedoW5DGrLQM1KIGUeTrLRluPbcdfkcMSM1rDia5teoOhIN0CYd->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 23:58:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  l.s.r@web.de
Subject: Re: [PATCH v2 1/2] utf8.c: Prepare workaround for iconv under macOS
 14/15
In-Reply-To: <20260111195149.716177-1-tboegi@web.de> (tboegi@web.de's message
	of "Sun, 11 Jan 2026 20:51:49 +0100")
References: <20260111195149.716177-1-tboegi@web.de>
Date: Sun, 11 Jan 2026 20:58:45 -0800
Message-ID: <xmqqwm1no29m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> MacOS14 (Sonoma) has started to ship an iconv library with bugs.
> The same bugs exists even in MacOS 15 (Sequoia)
>
> A bug report running the Git test suite says:
>
> three tests of t3900 fail on macOS 26.1 for me:
>
>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>
> Here's the verbose output of the first one:
>
> ----- snip! -----

Doesn't this tell "git am" that your log message ends here, and ...

> expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
>                 compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
>
> --- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +0000
> +++ current     2025-12-08 21:52:45.786161909 +0000

... makes the tool to apply the patch to file "current"?

> @@ -1,4 +1,4 @@
>  はれひほふ
>
>  しているのが、いるので。
> -濱浜ほれぷりぽれまびぐりろへ。
> +濱浜ほれぷりぽれまび$0$j$m$X!#
> not ok 17 - ISO-2022-JP should be shown in UTF-8 now
> 1..17
> ----- snap! -----

IOW, indent the displayed material used as an example in the
proposed log message.

> compare_with runs git show to display a commit message, which in this
> case here was encoded using ISO-2022-JP and is supposed to be reencoded
> to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
> is from the original ISO-2022-JP representation.
>
> That botched conversion is done by utf8.c::reencode_string_iconv().  It
> calls iconv(3) to do the actual work, initially with an output buffer of
> the same size as the input.  If the output needs more space the function
> enlarges the buffer and calls iconv(3) again.
>
> iconv(3) won't tell us how much space it needs, but it will report what
> part it already managed to convert, so we can increase the buffer and
> continue from there.  ISO-2022-JP has escape codes for switching between
> character sets, so it's a stateful encoding.  I guess the iconv(3) on my
> machine forgets the state at the end of part one and then messes up part
> two.
>
> [end of citation]
>
> Working around the buggy iconv shipped with the OS can be done in
> two  ways:
> a) Link Git against a different version of iconv
> b) Improve the handling when iconv needs a larger output buffer
>
> a) is already done by default when either Fink [1] or MacPorts [2]
>    or Homebrew [3] is installed.
> b) is implemented here, in case that no fixed iconv is available:
>    When the output buffer is too short, increase it (as before)
>    and start from scratch (this is new).
>
> This workound needs to be enabled with
> '#define ICONV_RESTART_RESET'
> and a makefile knob will be added in the next commit
>
> Suggested-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>
> [1] https://www.finkproject.org/
> [2] https://www.macports.org/
> [3] https://brew.sh/
>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  utf8.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/utf8.c b/utf8.c
> index 35a0251939..96460cc414 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv,
>  			out = xrealloc(out, outalloc);
>  			outpos = out + sofar;
>  			outsz = outalloc - sofar - 1;
> +#ifdef ICONV_RESTART_RESET
> +			/*
> +			 * If iconv(3) messes up piecemeal conversions
> +			 * then restore the original pointers, sizes,
> +			 * and converter state, then retry converting
> +			 * the full string using the reallocated buffer.
> +			 */
> +			insz += cp - (iconv_ibp)in; /* Restore insz */
> +			cp = (iconv_ibp)in;         /* original start value */
> +			outpos = out + bom_len;     /* original start value */
> +			outsz = outalloc - bom_len - 1; /* new len */
> +			iconv(conv, NULL, NULL, NULL, NULL); /* reset iconv machinery */
> +#endif
>  		}
>  		else {
>  			*outpos = '\0';
