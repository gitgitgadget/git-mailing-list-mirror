Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7C17583
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737855709; cv=none; b=qRTe+joeAU/hS/jc4fKCdWUipc+O5YM6qLn02k9alNj8HerPZUUH7t/8n9pDDhrmPJzS48gRHJBuIFQ74cX5TUagm1zAXUllD7dh4+J9SxR8wDaMT+B9Ik2zJu+A9qofjsBCqhz3FO2vdkPrmXMYLYeccLwCYmXudC1NsGiejs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737855709; c=relaxed/simple;
	bh=uVudWnyFuCQnSBr1QFdGvwaNMnT3JjqRyuobcuE8nUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pePFD9oMgVgowQZ9z87EucDxF7Qjpp6sLUadEDNOqJeJrIN4ywOZ94YMAX8tcqiXWAKE4MQkLDf30vJxwWLw/NBv0PPNrqZ4UaV3p5lyZp85YY/MSxJN8vHIm6SJ/pWN2cCDdOj+xOBz78dTLXneGlGcW/RIa7ZMA5JBAeUUJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZeQn1jXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1mLRgxY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZeQn1jXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1mLRgxY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C61B11400B1;
	Sat, 25 Jan 2025 20:41:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 25 Jan 2025 20:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737855705; x=1737942105; bh=RrRaoaTNJt
	nYNpnsPOqBS8bb3y5nbqfJwe28qEws3eI=; b=ZeQn1jXdRqN3OHrNc00CR4y1Qn
	5qBCgQnrTAIyxzkClYys0ZTVqQKs3jwb8h1dE3UtRi48cZjHSObLGSbGLP5LrMZ8
	r8WrHYnTgUnv7uR2M9sQ+HZ0S4TAVhyac61pgBS48G0i3krUV/LjTCuBQ+oL2ige
	HmQcsI4Jtcx6jsakD90iYNn8yLWFzrVSp4GIPjYB3MmMZnaUKbkigLsMKC1INIUr
	nJyqJdkIjZgBrtq885cQ98jOKJr+Nxr71fF7ZmxyH6Uoc62FbqYx4TBUETcpFlat
	/cIV78kiXFclnY3RLW5xgfz1NA7co2OR/q5IvukqVwltHjNMWZZZLJBi493A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737855705; x=1737942105; bh=RrRaoaTNJtnYNpnsPOqBS8bb3y5nbqfJwe2
	8qEws3eI=; b=E1mLRgxYvrgKJkBY+XJhI8n0ohDlVXhVh8gc83VOsX2LCzDqLCD
	VNkwDsH5ZiSHpq5ZrOQB6YVg8AHBxjZufJF0G+Ro/AEgzfK9WxCT4NhvzqqOl9l+
	2qK6bzSX65d2VjDU9UlRhpZ6d+ArsEt0Xu9mpyaeZxFRVS2nCyWsax/OBL+nyFsF
	Z5XHvW0ulk8TmzWfu+GGS33mwMbE3EuDmlmLYB0iCcRuJ0/m2eT6YTbvOuyg78f+
	E2jNY2lMNGujbFZX6fXJgRPPz72s0W+uL5XzvO5SLsfwaqg0UNhVLZaf7MpWqvc2
	tJYoPLzX8hw+p8iA4JL0nfHKPf7I2weV6bw==
X-ME-Sender: <xms:2JKVZ5xqAU5O2esbkyLPOePThRom8iorS9T-2H1sAg5k49QyIQWYpA>
    <xme:2JKVZ5SoKFTp5WoBs86YOvnaWjxLUG7s5oTduFHAUxGIYkMweVfa2IB58F5fnpcuH
    r0mmWhDKo7goF9m6w>
X-ME-Received: <xmr:2JKVZzUXlRQ1yzaHt4WGYGg75OIYWSEJo-AK4ODXBAH-0a6citt3Q8SpBOivORaLqaIdorEieww9GgWvY9X5-wZRcvcUI7p2inSy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgkeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peiiohhtthgvlhgsrghrthesthdqohhnlhhinhgvrdguvgdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2JKVZ7jrE1b-I6tZ4mprdr7lsT-JgHZzzYcU42Kri4fa_t4Sfc0N6Q>
    <xmx:2JKVZ7BxJqZYKhAhhEYC7Bg1ke2rRiv9cSPq7nv4jR2k6V73VAc8NA>
    <xmx:2JKVZ0IkqTfbWA_-8GtyNIHF8gxoqbk1AMxhJwwNoVtF_eJDtnJV1Q>
    <xmx:2JKVZ6BNDcXJFU5OBLy9EgxMYU9egLoAnKGzlAz2-MaOTfzmjCuoQw>
    <xmx:2ZKVZ24PLXNJ_8_aMFIUAyH76xXZCORIbgqc6Q58DThhCrIRznchcFni>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jan 2025 20:41:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Reich <Zottelbart@t-online.de>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
In-Reply-To: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
	(Patrick Steinhardt's message of "Sat, 25 Jan 2025 06:41:34 +0100")
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
Date: Sat, 25 Jan 2025 17:41:42 -0800
Message-ID: <xmqqfrl6wdux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 1d5b211b54..0e4b6a70a4 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -302,7 +302,7 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
>  	return wbuf;
>  }
>  
> -int mingw_unlink(const char *pathname)
> +int mingw_unlink(const char *pathname, int handle_in_use_error)
>  {
>  	int ret, tries = 0;
>  	wchar_t wpathname[MAX_PATH];
> @@ -317,6 +317,9 @@ int mingw_unlink(const char *pathname)
>  	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
>  		if (!is_file_in_use_error(GetLastError()))
>  			break;
> +		if (!handle_in_use_error)
> +			return ret;
> +
>  		/*
>  		 * We assume that some other process had the source or
>  		 * destination file open at the wrong moment and retry.

So this is how we can avoid falling into the retry plus interaction.
This underlying function is prepared to offer both choices at
runtime.

> diff --git a/compat/mingw.h b/compat/mingw.h
> index ebfb8ba423..a555af8d54 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -224,8 +224,12 @@ int uname(struct utsname *buf);
>   * replacements of existing functions
>   */
>  
> -int mingw_unlink(const char *pathname);
> -#define unlink mingw_unlink
> +int mingw_unlink(const char *pathname, int handle_in_use_error);
> +#ifdef MINGW_DONT_HANDLE_IN_USE_ERROR
> +# define unlink(path) mingw_unlink(path, 0)
> +#else
> +# define unlink(path) mingw_unlink(path, 1)
> +#endif

This one is yucky.  All calls to unlink() used in compilation units
with the CPP macro defined are going to fail on a path that is in
use, but in other code paths, there will be the retry loop.

Regardless of the platform, the code must be prepared to see its
unlink() fail and deal with the failure, but I wonder how much the
initial "if file-in-use caused problem, retry with delay without
bugging the end user" loop is helping.  

After that retry loop expires, we go interactive, and I can
understand why end-users may be annoyed by the code going
interactive at that point.

But wouldn't it be too drastic a change to break out of the retry
loop immediately after the initial failure?

Unless the case found in reftable is that the process that has the
file in use is ourselves but somebody else that is not under our
control, it could be that the current users are being helped by the
retry loop because these other users would quickly close and exit
while we are retrying before going interactive.  What I am getting
at is that it might be a less drastic move that helps users better
if we moved the "let's just accept the failure and return to the
caller" after that non-interactive retry loop, instead of "return
after even the first failure."  That way, we'll still keep the
automatic and non-interactive recovery, and punt a bit earlier than
before before we go into the other interactive retry loop.

Of course, if we are depending on the ability to unlink what _we_
ourselves are using, we should stop doing that by reorganizing the
code.  I recall we have done such a code shuffling to avoid removing
open files by flipping the order between unlink and close before
only to mollify Windows already in other code paths.  But if we are
failing due to random other users having the file open at the same
time, at least the earlier non-interactive retry loop sounds like a
reasonable workaround for quirks in the underlying filesystem to me.

Thanks.


