Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353858248B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654266; cv=none; b=CIPEf5yd8d0PcdNAAczrWbp5MGazvAlluI0P8S2ZJY5XMFIMqvHnSg2NY6zsZO+Cl5Cohd1FhV0QVTlucuskNlPrCKdycgZ/0jD4d1rdQbpTdKkWW4tCpHcste2oKQyRXZLSxHQXGhLOL0w6gExbdkzj8H3fdHBNVY6EyEdxNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654266; c=relaxed/simple;
	bh=70yPD/H2gbfjNLG1ptTEgUh9BLyHX+wHvqBqt7bX/b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7wXdDG1GlgDepWeCAQFHE9tO+fB/owhPrsLdL/FKdNu8ER1FuaXC4JK7wKOFlVF0hytfkIGKrM210wMLnPySLSvBrU7f/9vcKb8YiL0sYCrJbRqLy4HtAGJ8W/r9BoUfm3vyQev3DEpF5SCPfRXRswLo71/4P+nvJgBFFsStPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oQJUeXQ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYSR2L11; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oQJUeXQ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYSR2L11"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 38B111D0004B;
	Thu,  9 Jul 2026 23:31:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jul 2026 23:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783654264; x=1783740664; bh=Y5IwHp/+ci
	Sec3ixxVhMlawz6Sj9O7whc/K/huSQ3UE=; b=oQJUeXQ5VywcuaddraveDvtlue
	56Q2ctGN9b1nsCOrRW9GW6leRXuE5L3ox2vz9DkzBsWcPM+1Be+BYwZT0vDGGsoo
	AaqD8rSQUq8gOOopNWXjDN+YWCL8HCfSHmx1KsmBXoP8PCSk8Rgu6Sqc8Qt4tQQi
	nLOH9q84SmbpIlNDbMjWZ4taLsBMwI2raJNSMBxHZTLn3puR+G21aNwVHCdG3Mvy
	IkC8RqBGHj9We+kFTrqnjHuPWgkzqe2Hrah28wFrfxISZFSXDyIAUdVTBkfVdxUG
	F7gHdNaNvypK3S6jTN5prjfr+GwzlNvDhn25xQPwWy8QsSea7JtG4xFpmu1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783654264; x=1783740664; bh=Y5IwHp/+ciSec3ixxVhMlawz6Sj9O7whc/K
	/huSQ3UE=; b=NYSR2L11DfAkikPccP+JYsyIxnXGl2NEjI+JdjcbXLEXTssc/um
	LVT5oQ3SaGnCi8feoCbQiwxJIU9iPHdi9qhykaGlZ7ssmPWHUKp41W30C66kBeeg
	4RIklwI8dMs1HeZnX9nZNFm230FyW1YgSGOSfnrPplFv7mRsEp0O14oqinc6Q/vW
	BACV35FcaTcmvl9B3DJMuxSrpA7hvKhobBKi9Zfi335GMdfZyUp+oy3eCX2PMVjR
	AF0/7TR70I+RXclNSoixYyiyIGafpOSkihY4p6D7XjKTnId+8FKfpfrAPC9MWB4J
	zH2hV7BXL/bnhTRGuseG1vDfqSSzKJtSG2w==
X-ME-Sender: <xms:d2dQao19QSFc_zG64LVkpgdYrhtNkdB64dD76h0FHkoXhh2RIo5fvg>
    <xme:d2dQaqHj2WY6rPAqk949KOUSrdrdqzNiw-teA6nV88r1-QQM4spNbA6rxrI69eQmS
    5-jGLVguxmcbWpDJX3nQw558_DIvMzjp_WJf-1YWxxPxdxXpG8K>
X-ME-Received: <xmr:d2dQal6fnnGJp5bDA7HB4SFtzw10pPttVusFhnXm0-hlHDuz2lzm3watzB4KtELsl52vhKl90vFcUsklfTU6rtsOJt1Ab8GYK_JQJTk>
X-ME-Proxy-Cause: dmFkZTGJ5+vXf5rEn+O3j4LP19EhYnFPG9z0L3zbaUU777r5HqCyj2IKi9M7Fvx0u8V87f
    m0z/IvrfpnUwJLLFpVgJMgubluqAXwr/spI5R3A+avKtpnnw8A/yv4sVGueuMsRkMVb9SC
    kjSnAz/AShkbF36AWvkFpEV+rTqIx8qmpTWbITA89/o22KvshCRGn7i1ssv8InnmYftTkI
    ucIyfWN/ER2LXA+wf90pUfV4KNb0hTrHzOyuJriPEhBycFycIdBF6Yp9FoBApzkt9ERF7y
    PNMO/to6K9N74eRScGAilRxHiIjsc3LPb3J/jhqGeiJxg60kfTzqRoGp2EGMJnvDg6oel6
    iBulYCn2cLGUqXn6iIFMToQldu0/UeoK7q00ZkiNEmmR0ubzkK2IXfDkr2fvvBR4U+aQD/
    FETsXN0/+pY4rCpTlemJ5q3FVxA5gjw95V3zLjXUwJEaZRQM/LuK5WzgJ7s9jXm5TkcSil
    Nei/62cBJi5QqgQHPdRtXZTk8WxNnji5VKHb8Y8tmF8ZXIg24QLcpTBUgqOzAIgH4bZUpr
    OcW5+Rxrw1y66Q6jtGtLCGxwGH+D2zIJpyZp/osbXbdI8A2H1wxwDy0mNXhoT+5bwCJD42
    jOqMohmA2XTVHuX8xCjk8bCrNZFVR0cPRt+J4M1khQch5bzJbvvXpFnkIL1g
X-ME-Proxy: <xmx:d2dQagtdgCuxUcloiqO0xW6kaJBiqwS3a5QFPBjHO0u6zMKfnkJqhw>
    <xmx:d2dQam61pNZbv9wAnC8fhKm9q8g_jXj7ZnDVtmlFSVJcc0LWAKy1ew>
    <xmx:d2dQarVhIFNJjtoaVX3E9Cj487lZweQ923cVKDcuj1Detlf6LTWZZw>
    <xmx:d2dQao9LWQ0SLE7Bl2BDWsxC-4toDOzFETQe4gtwx-CN0TUC2JpNvg>
    <xmx:eGdQajTzyc9I1lI3s7E8TbvVK_3GxNbZCmVBsL-RaAmfu0KTUQgoH-Sy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:31:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/11] mailsplit: move NULL check before first use of
 file handle
In-Reply-To: <41eef047ae6e3c332e1c8f96a9f9abf55d5004fc.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:32 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<41eef047ae6e3c332e1c8f96a9f9abf55d5004fc.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:31:02 -0700
Message-ID: <xmqq8q7jh66h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 264df6259a..0993418e63 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -225,14 +225,14 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
>  	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
>  	int file_done = 0;
>  
> -	if (isatty(fileno(f)))
> -		warning(_("reading patches from stdin/tty..."));
> -
>  	if (!f) {
>  		error_errno("cannot open mbox %s", file);
>  		goto out;
>  	}
>  
> +	if (isatty(fileno(f)))
> +		warning(_("reading patches from stdin/tty..."));
> +
>  	do {
>  		peek = fgetc(f);
>  		if (peek == EOF) {

Ah, obviously correct.  Cannot believe nobody noticed this since it
was first written in 7b20af6a06 (am/apply: warn if we end up reading
patches from terminal, 2022-03-03).

Thanks.
