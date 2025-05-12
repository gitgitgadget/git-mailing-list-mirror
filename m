Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604A296D1D
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747078335; cv=none; b=G3NiX7faFco6gwWbx2qiY9BFFkDOrEJbdPw/vM/WxMWekQajx6gBGA5n0KujRoxsIfzpoegx5dsO8gLYR0rRsF5ZBRmCUPeGKCvXAnDQ/uM1FlS3vlL4if9UsS/EjrW+D0DyqBPMmlZxc8KDfKWCgrbfHYb9DcMRcNrT96zZ+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747078335; c=relaxed/simple;
	bh=Cq8UvYD8kyb017wylGP/STZchDd0mhSZdniP33OKo0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ecHqAxWv/o/18POiunNOKnt4Ob55oqo1l0IQJ+7w8QCXcox3PcFZMUljG1EGCU1MKqhh89xRyADJ7Thbjs+PuRK0kRdbTIC/GTzPcb7XRfS0v0iKssNFmaL3egX15w8dVKaMt5Il+6OOqDQnS0FyVHgciuIS3MQc6Q0vVQ6Jq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fQ4QUeT1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsoP/6gu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fQ4QUeT1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsoP/6gu"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C9AE1380201;
	Mon, 12 May 2025 15:32:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 12 May 2025 15:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747078331; x=1747164731; bh=qHYIxQ0oe0
	xj0kyN3JZM8e/fSwjQPvAS2GIAfz05FQk=; b=fQ4QUeT14ENaihjBuOh3xNGc0v
	88COJYCIkIsPakj4qeFgNmAjVPHyIkziCjo7sNjj7uzHRURKi617NI9SbmPpsEGz
	zHWXDg1RhNjuAx8M6SCpHhFiV5VDzlAmzrVsI0Wx3mN8B7PUwDYZbWQQkTOdl79y
	B8WMameLwRkN8i4ngQqzqIm1Qm0id+cqLjt5j51dlwRzYj1X0oF61rLCkxV2zHW6
	PfBhw6BSHDaRF/sY6O+gm1yBBv+4voYb+6T0xe3Sdbn61XuCdX6q94FMIlcjmN0v
	WXbQpEegyr/cIMjtzBom4Krd+HNt+moVfWmxgzX719cfXH7Pj+1DX7cwZqNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747078331; x=1747164731; bh=qHYIxQ0oe0xj0kyN3JZM8e/fSwjQPvAS2GI
	Afz05FQk=; b=NsoP/6guiXf6Ql0eQVv8DOzlGt0ZYSuMvLOkVSZh6dj8ZQVC4G5
	/w6VFxn4KUhMRbeBu2PFtw5LMORZ1NNI3niLptpzGthM2sK8rqLBTci29lPU69WI
	AnDGJmwBXS8pFG9kNxtSGYcQCqUqRy4BMPByhj6AJj2UWj/LfYBMg4G0EK0ojWQY
	pMxSDWxvxqNS1Rh3NwzEux86O4xmdLCrFyU5Xv8Czi5e2nLhzf/9dbhXiwJd2+6T
	jVUJoYx8wB5HywQgBzAjHT96H8jx0CgST4gSwuuCiKMVnlPpsxX6GsKS3vDsOKMW
	ooL+0gRAkPeZSk8hTJgFMcjq5jikCBHDI/w==
X-ME-Sender: <xms:ukwiaGetdOexxIMUIq8wFYmeGh47IZVY3UldK-PnJqnGZDkOy8SE5g>
    <xme:ukwiaAN7YtUkRbyvS-hNDDqrh0qZ3jU8J-59skuPIxFH7Ama6D7o05YjZ8EYGAgTv
    CLnupc42GPMGrix3w>
X-ME-Received: <xmr:ukwiaHhql00K6rAc54n-JxVBFbKJpXFBw7aVpj7ZizgOSiXRVsWlSm0c0oGr51ibZeh7U55KWtDG8AJe4u_Teq_lujFGX6SAJ_LjFzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnh
    hjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ukwiaD-Ro45OY-YAZT3CC5BAowWiEhNyzWzcgaoBL81H9-TE14vn-w>
    <xmx:ukwiaCs2e3SKJd8bicBLHLXI8zV_vuNJpb7RRIk-4CXsXP6OET8Dmg>
    <xmx:ukwiaKFOqwXd45eumlsKMqrGGdGmhvEOYr9CulPcrYi3YSe9l_0xnA>
    <xmx:ukwiaBOynt-XPaZl772ey6-cbkdT2XmADZg-Nuxm8zd5uaXDfMbslQ>
    <xmx:u0wiaFnGKg54GzRG_s7lGYALDWUL1D4I2aIbzetSUKAKP8T7wlJ5dmnT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:32:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3] mailinfo: fix pointential memory leak if
 `decode_header` failed
In-Reply-To: <pull.1956.v3.git.git.1747066627330.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Mon, 12 May 2025 16:17:07
	+0000")
References: <pull.1956.v2.git.git.1746980097510.gitgitgadget@gmail.com>
	<pull.1956.v3.git.git.1747066627330.gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 12:32:08 -0700
Message-ID: <xmqqbjrxsk07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
> +static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
> +			    int rfc2047)
>  {
>  	const char *in = q_seg->buf;
>  	int c;
> -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
>  	strbuf_init(out, q_seg->len);

This strbuf_init() is still here?

> +static int decode_b_segment(struct strbuf *out, const struct strbuf *b_seg)
>  {
>  	/* Decode in..ep, possibly in-place to ot */
>  	int c, pos = 0, acc = 0;
>  	const char *in = b_seg->buf;
> -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
>  	strbuf_init(out, b_seg->len);

Ditto.

> @@ -475,7 +474,7 @@ static int convert_to_utf8(struct mailinfo *mi,
>  static void decode_header(struct mailinfo *mi, struct strbuf *it)
>  {
>  	char *in, *ep, *cp;
> -	struct strbuf outbuf = STRBUF_INIT, *dec;
> +	struct strbuf outbuf = STRBUF_INIT, dec = STRBUF_INIT;

Initializing this at the caller side is good.

> @@ -530,18 +529,20 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
>  		default:
>  			goto release_return;
>  		case 'b':
> -			dec = decode_b_segment(&piecebuf);
> +			if ((found_error = decode_b_segment(&dec, &piecebuf)))
> +				goto release_return;
>  			break;
>  		case 'q':
> -			dec = decode_q_segment(&piecebuf, 1);
> +			if ((found_error = decode_q_segment(&dec, &piecebuf, 1)))
> +				goto release_return;
>  			break;
>  		}
> -		if (convert_to_utf8(mi, dec, charset_q.buf))
> +		if (convert_to_utf8(mi, &dec, charset_q.buf)) {
>  			goto release_return;
> +		}

Don't enclose a single statement block inside {braces}.


Thanks.
