Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60A9475
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059133; cv=none; b=p+bj/ujZ80xXBG+5Qc/+WdPl8wdAtb0sczWbRXGyVXE9yyjJFowg+tX11OI0VXG+DJ3CZ45C90aEpb7STFe7SU+TOZpx7KIP90swFM1d9sSOjr4JsvdrXfvayCQA/bW5XivvfC1ZbfrkhtuR9vZJ9xqYcqHQljXMqWRjCMlgh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059133; c=relaxed/simple;
	bh=NgTAQXQy9AIMl3W4qE4g9MnD1V6fQGilw7VHZsxJCfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q1hSrlfhe5joXSIpocd/+/NbRlBgsw6MZpzKEGHMnEcrUSk2LZ9haCxymSX6ApysMIvN8BEG+qxiyNCdLTYqUwEE3gIa0gGbHgyretFEsgqWiUDgoFkSDlnfQoj/XVjkN8FO2FHNTY+ITBnf7Na+JjIeVBao/vzjQzvQjJ7yep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HCY3SDtK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ksXZ6zZN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HCY3SDtK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ksXZ6zZN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B9252540081;
	Mon, 12 May 2025 10:12:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 12 May 2025 10:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747059129; x=1747145529; bh=X3JFzO2SiW
	GzDt6//CeUPsbyvJBV1Km08SCsP1vCGmk=; b=HCY3SDtKYEEJrUVuBPcG9LdbCm
	O88T4YZzaoYuRRAA/5MRXJgdPPPiMNyA5UcomxbcDQ7FvL//c4FotyZo4N7nUo0c
	UkdrYu9NtNK+Xm9wnTH3gdajAU5qGgb4tINCN95Kep0NIqNt96k5i3wCyCCVLwA1
	U383gaUO89BE+Miq9tfjH+RPFBkxf5bGNTGiyZh335r98kjm/cLEJbRqUCJRgCMd
	p+TcFeipGqOvERSsDnPEK3ZDcnnJWEIHa11TfCcMi+TCj2c1vPVCb20MvtyvG8H/
	EQdjf1e4ueZFoJXLqmhhbpKQwjFt2EMWR+4ppOiKn59XShdhlucQ7G9AaZ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747059129; x=1747145529; bh=X3JFzO2SiWGzDt6//CeUPsbyvJBV1Km08SC
	sP1vCGmk=; b=ksXZ6zZNoQKBbZihmaPgNJ+49SetwiF8UWoroPUFlcnM1HdMic6
	v2dkn3BHapEVP0XQDygsVdNLS8+jUXZ69FIa/GHaY1Y0hJSRWgX3is9ippAmq/Dh
	OxeHQK6ljrIpdm+2jhxwby5EsCjCck9HT+bXtA4XHrELjzDRXT5V2zFkT0dWWmKE
	Vn3+nXlVg770NUJ0LqEUC38aLnoeF2z+J+WCuDDL4K9Z9JnhYl9bgmeNftfHzb5C
	I4hoOM4IqPdXl8yq1EDE63mhSIkG0xLx/H+kvSRnHgkykHOV9NjhIW4+QvIo6HYo
	Q9vfXpv9gJ49ei16bRt8BDtz75VWO5HYZVw==
X-ME-Sender: <xms:uQEiaKhuK9sBwy0UgnoENrIe1BeQYkkaAF4vD8jfLmR328f6-z0Qyw>
    <xme:uQEiaLApv1H6TDlilvRzTuVvcTARXY0y2XVn5r9uAkAHp-lUdGtMMVT9RYbB8QqYF
    0blj30iveTbVajSGg>
X-ME-Received: <xmr:uQEiaCE4eZPGkmdCJF4MhOnnmfWkahKl4gTbM_ZlYdHNRc31AFpsO7kIfu9m_itgzqDLf_hMu94ZAGySbujyBqdrYnVtIsmaKB14-jk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephe
    dtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uQEiaDT4WVRCoWcPsNJqR5iT6KEtc5yC6Vmzwd0dlpRxp6zXEkSbBQ>
    <xmx:uQEiaHwqgeO1viW_30Yr1VmNGglmAqdEm0H97xdaO0GXWWyK0AdJww>
    <xmx:uQEiaB4bYR1j78PAzlH58a592ayuTsh8U7SxKvWN-mRVSP6VsQzegg>
    <xmx:uQEiaEwR-zbb1WncDbS0qqy8F15GPof-oaL9oBt_BwMNVaxhehscgA>
    <xmx:uQEiaF0-h-Z5ICDQitZGgC8nuJmvae22XL3Ta5SG6vbqidMESduBJWjS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 10:12:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] mailinfo: fix pointential memory leak if
 `decode_header` failed
In-Reply-To: <pull.1956.v2.git.git.1746980097510.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Sun, 11 May 2025 16:14:57
	+0000")
References: <pull.1956.git.git.1746711521614.gitgitgadget@gmail.com>
	<pull.1956.v2.git.git.1746980097510.gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 07:12:08 -0700
Message-ID: <xmqqcycdx6iv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In mailinfo.c:decode_header, if convert_to_utf8 failed, the strbuf stored
> in dec will leak. Simply add strbuf_release and free(dec) will solve
> this problem.
>
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>     decode_header: fix pointential memory leak if decode_header failed
>     
>     In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored in
>     dec will leak. Simply add strbuf_release and free(dec) will solve this
>     problem.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1956%2Fbrandb97%2Ffix-mailinfo-decode-header-leak-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1956/brandb97/fix-mailinfo-decode-header-leak-v2
> Pull-Request: https://github.com/git/git/pull/1956
>
> Range-diff vs v1:
>
>  1:  81fdfb94315 ! 1:  90dc9b0d49b decode_header: fix pointential memory leak if decode_header failed
>      @@ Metadata
>       Author: Lidong Yan <502024330056@smail.nju.edu.cn>
>       
>        ## Commit message ##
>      -    decode_header: fix pointential memory leak if decode_header failed
>      +    mailinfo: fix pointential memory leak if `decode_header` failed
>       
>      -    In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored
>      +    In mailinfo.c:decode_header, if convert_to_utf8 failed, the strbuf stored
>           in dec will leak. Simply add strbuf_release and free(dec) will solve
>           this problem.

Much better.

> +static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
> +			    int rfc2047)
>  {
>  	const char *in = q_seg->buf;
>  	int c;
> -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
>  	strbuf_init(out, q_seg->len);

Don't let the caller pass in an uninitialized thing and force the
callee to initialize it.  Drop this strbuf_init(), and make the
caller always do:

	struct strbuf dec = STRBUF_INIT;

	...
		decode_q_segment(&dec, ...);

instead.  That makes the division of labor easier to see (e.g., what
if the caller had a code path that never calls decode_x_segment()
before it has to return?  it might want to add something to dec
itself so that it can base its behaviour always on what is in dec,
or at the end it may just be able to strbuf_release(&dec) without
having to remember if it called decode_x_segment().  Which means it
is more convenient for it to always assume that dec is initialized
whether it called decode_x_segment() or not).

> -static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
> +static int decode_b_segment(struct strbuf *out, const struct strbuf *b_seg)
>  {
>  	/* Decode in..ep, possibly in-place to ot */
>  	int c, pos = 0, acc = 0;
>  	const char *in = b_seg->buf;
> -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
>  	strbuf_init(out, b_seg->len);

Ditto.

> @@ -530,18 +529,23 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
>  		default:
>  			goto release_return;
>  		case 'b':
> -			dec = decode_b_segment(&piecebuf);
> +			if ((found_error = decode_b_segment(&dec, &piecebuf))) {
> +				goto release_return;
> +			}

Don't enclose a single statement block inside {braces}.

>  			break;
>  		case 'q':
> -			dec = decode_q_segment(&piecebuf, 1);
> +			if ((found_error = decode_q_segment(&dec, &piecebuf, 1))) {
> +				goto release_return;
> +			}

Ditto.

>  			break;

Just a mental note (i.e., not anything wrong in the posted patch).
Even though the caller is prepared to see decode_x_segment() to
notice and report an error, the implementation just does not bother,
and mostly skips a garbage in the input.  Outside the topic of this
series, we may want to consider allowing the user to say "be strict
and barf when encoded contents are broken".

>  		}
> -		if (convert_to_utf8(mi, dec, charset_q.buf))
> +		if (convert_to_utf8(mi, &dec, charset_q.buf)) {
> +			strbuf_release(&dec);
>  			goto release_return;
> +		}

This, together with ...

> -		strbuf_addbuf(&outbuf, dec);
> -		strbuf_release(dec);
> -		free(dec);
> +		strbuf_addbuf(&outbuf, &dec);
> +		strbuf_release(&dec);

... release here, look somewhat pointless.  As you declared "dec" at
the outermost scope in this function, why not do the release at the
place everybody else is released/freed, at release_return: label?

>  		in = ep + 2;
>  	}
>  	strbuf_addstr(&outbuf, in);
> @@ -634,23 +638,24 @@ static int is_inbody_header(const struct mailinfo *mi,
>  
>  static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
>  {
> -	struct strbuf *ret;
> +	struct strbuf ret;

Do the "= STRBUF_INIT" at the caller.

> +	int found_error = 0;
>  
>  	switch (mi->transfer_encoding) {
>  	case TE_QP:
> -		ret = decode_q_segment(line, 0);
> +		found_error = decode_q_segment(&ret, line, 0);
>  		break;
>  	case TE_BASE64:
> -		ret = decode_b_segment(line);
> +		found_error = decode_b_segment(&ret, line);
>  		break;
>  	case TE_DONTCARE:
>  	default:
>  		return;
>  	}
>  	strbuf_reset(line);
> -	strbuf_addbuf(line, ret);
> -	strbuf_release(ret);
> -	free(ret);
> +	strbuf_addbuf(line, &ret);
> +	if (!found_error)
> +		strbuf_release(&ret);
>  }

THis is puzzling.  We add whatever is in ret to line, but release it
only when there is no error?  What happens when we did find error?
There does not seem to be any caller-callee contract on what the out
parameter should contain upon an error, which is a good thing, so we
should release it unconditionally, no?



