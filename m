Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE75381C4
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498051; cv=none; b=LhFV6gX/5h62Y6Vwwx0q7td++R48o79xBUgdSq30BYlWoL9A9mqMx6G921AbF+U7yAn3vZMZdHQ/zi0e5v/v2fxYqoFsuxlNPl0BHCjMeo4y4g9YB3j/m8nCuZWO1e2KB7yxDOdIUJtAPy9l+S9w6J02ZwpSlvlGKA84D/U2Ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498051; c=relaxed/simple;
	bh=opL7mFthWqzes675LyB8i+s+AnKWv72oHbvgNiiOlfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrqqMaDhYLO74Dx6T4s1KsXwQQZxUTNjj0aWFxQ+Rjl8K7my/rH04tj4TE/NgUXZBmaaRIH/n19vsh7CLp2kc33kcU6vqQbqA4WJgUY+lGU1dLkradAe5r97kgTYkw1Xp8cCmZHvSZ//T4yY4psHAcq4zQxuG/t7RfH6EYdu5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UC2txkZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzaZc3xD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UC2txkZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzaZc3xD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C8489138043B;
	Wed,  9 Oct 2024 14:20:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 14:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728498048;
	 x=1728584448; bh=vtFk94xBVGy7nP/BjmfqRYWNWK0vefbsOLFxe+kkyLA=; b=
	UC2txkZgcVV83iJd9avz8LqFGL+jMGM2DNN0X4nGB0q0GkZR4fPMZufBqaa9Qg6B
	z4PLJoGA/OfsxxzH4u5trXW44WfPKzEJ05rNB54Q5U0Nkhgkqvc6waPaezQVj5Jm
	Sd31pxcqWaYborGJlsmft2fLn6CNDFFOueVz+9IEE/YVzlM4SDJnJUd6E8lOSPhi
	ZfGazueBv4GqEDnRYugHEypic4Uj+9XqredfZVLMy/6g+/4ym809EHE/mctb/QDz
	IT4AhyxAfePEg9jlqBeO1IOOkHP4bAzoBdmh16eYu2FwoGf3Lkbq2DA9kHw7yPo0
	slSs2CSXL9gRi2OS3LEKQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728498048; x=
	1728584448; bh=vtFk94xBVGy7nP/BjmfqRYWNWK0vefbsOLFxe+kkyLA=; b=G
	zaZc3xDyaDaqDgnM1ajwuo7PjCag+FcqBkrObGLf4bJ+QD3Im2JJ/x2LGhMTYZWp
	il5NK7d1lpJFdELnkRCyX5xkCHT1+o+0Koh1WbaAhymgZ6FbMjB8ZR9zF/q7ZtEd
	8TpSemoTdG7vGfz/J4nUko2wcLBn78Wfsx2If6gXH4mPABsptDYlk+R0rC1T2wOi
	UhFmx1IVEY2odeBRerQNAZNhgU3BPLVOkd3Bu6VKu+8BDiT6eFsMGN0WTVYPdSzo
	iegpXrOKp9p4i527XCsu6F7FP3WVA75v6v9Ng9f6sro1Er7FLd4v511g+oHKawMO
	bEc3/F1+Q39Y/IU/y5wXw==
X-ME-Sender: <xms:f8kGZ7CYIv_zYDSvMuKoqjto2q1RjTrkCVjNrG5mU6SJSPWWNkWmKA>
    <xme:f8kGZxg_H2Gd88MEJiOlp2lhX9ghosw3l8gNM98nDFVaQN6dSmc82Pii8jcTE7ajt
    EJU7j-7sNPAkNxKmg>
X-ME-Received: <xmr:f8kGZ2nFfV46zfAcMEF8fuiIn7hEwbbTDm2DLjtrHZavNOwMylR4A8UCBx_YTt0zXTGo11GosDG1ljnJnh92l1Yw6--f3kJc_TdX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthgsohgvghhiseif
    vggsrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:f8kGZ9zPmIrbdvwT50fybmgytVoPaScMRsMy0e6XV9XoufLlG7koXw>
    <xmx:f8kGZwTt4_A0hTkfbYq3jOISf2vyHmICJCtGinxXDBv1LKHKJYgtDg>
    <xmx:f8kGZwYflNChhuBjgeBcKMkk9-c7n-mKCc0yFwvZZI0QdJnm0Fgmrg>
    <xmx:f8kGZxQrFiN89w9Gk1A2009JCisPoHACMOeJe2sbiZzCPYsC9FloTw>
    <xmx:gMkGZ1L62UEZE_etEcfzBkJugTkTZC3XncYO5VVlnVTRbiNDhrzEfY2W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 14:20:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org,  tboegi@web.de,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] [PATCH] mimgw: remove Compiler Warnings
In-Reply-To: <20241009171342.2354-2-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Wed, 9 Oct 2024 19:13:42 +0200")
References: <4530b7cc-3f91-4009-977e-97519a5a9f85@gmail.com>
	<20241009171342.2354-1-soekkle@freenet.de>
	<20241009171342.2354-2-soekkle@freenet.de>
Date: Wed, 09 Oct 2024 11:20:45 -0700
Message-ID: <xmqq4j5lt9xe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sören Krecker <soekkle@freenet.de> writes:

> Remove some compiler warnings from msvc in compat/mingw.c for value truncation from 64 bit to 32 bit intigers.

An overly long line?

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 0e851ecae2..5293f4cdae 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -782,7 +782,7 @@ static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
>   */
>  static int has_valid_directory_prefix(wchar_t *wfilename)
>  {
> -	int n = wcslen(wfilename);
> +	ssize_t n = wcslen(wfilename); /*can become negative*/

Aside from the malformed comment ("/* can become negative */" with
spaces would have been OK), I am not sure where it can become
negative, unless wcslen() is allowed to return a negative value to
signal some kind of error (in which case, the comment should say
that), which is not the case.

The loop body in the post-context of this hunk looks like

>  	while (n > 0) {
>  		wchar_t c = wfilename[--n];
		... 'n' is not written anywhere else in this loop ...
	}

so an 'n' that is not negative before entering the loop can never
become negative by what the loop body does.

> @@ -891,7 +891,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
>   */
>  static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
>  {
> -	int namelen;
> +	size_t namelen; /* contains length of a string*/

Indeed, this receives the return value of strlen().  I am not sure
if this comment is necessary, though.  Just like you omitted any
comment on size_t variables that receives .len in a strbuf, its
correctness is rather obvious.

> @@ -1274,7 +1274,8 @@ static const char *parse_interpreter(const char *cmd)
>  {
>  	static char buf[100];
>  	char *p, *opt;
> -	int n, fd;
> +	ssize_t n; /* read() can return negativ values */

The word is "negative".

But 'n' is also used to receive the result of strlen().  A kosher
rewrite may be to split it into two separate variables, 

	size_t cmdlen = strlen(cmd);
	ssize_t bytes_read = read(fd, buf, sizeof(buf)-1);

> @@ -1956,7 +1957,7 @@ char *mingw_getenv(const char *name)
>  #define GETENV_MAX_RETAIN 64
>  	static char *values[GETENV_MAX_RETAIN];
>  	static int value_counter;
> -	int len_key, len_value;
> +	size_t len_key, len_value; /* lengt of strings */

"length".

Again given "size_t strlen(const char *)", this may be sufficiently
obvious.

> @@ -2001,7 +2004,7 @@ char *mingw_getenv(const char *name)
>  
>  int mingw_putenv(const char *namevalue)
>  {
> -	int size;
> +	size_t size; /* lengt of a string */

Ditto.

> @@ -3085,7 +3089,8 @@ static void maybe_redirect_std_handles(void)
>   */
>  int wmain(int argc, const wchar_t **wargv)
>  {
> -	int i, maxlen, exit_status;
> +	int i, exit_status;
> +	size_t maxlen; /*contains length os arguments*/

Missing SP around the words.

Again, given "size_t wcslen(const wchar_t *)", it may be obvious to
readers.

> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
> ...
> +#ifdef _WIN64
> +typedef __int64 _ssize_t;
> +#else
>  typedef long _ssize_t;
> +#endif // _AMD64

It is a bit unusual that "#ifdef X" is not closed with "#endif /* X */".
Some folks write "#endif /* !X */" but what I am wondering about is
a mismatch between _WIN64 and _AMD64.


