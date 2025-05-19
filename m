Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63683283CB8
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666996; cv=none; b=WRs45ojhLLwqtYaLAwJdNoSy356uXs8rBtauZWiJyUU1Ly4P3gaQBdSLUKpldFv9P14ataFvgViBI5WmUjAVVnPaNR2tifdLTsN9hWSoTPVqa2DNNV3Zk+trYF8t+/yH/aP+E/VI2slbdNXvwcXQ3Su1KZgz/sKJaUd/ETzGorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666996; c=relaxed/simple;
	bh=eZDoUavNf+yb3iqRk4CMtj7s9wJRDcHUrUoTIGugZzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqIplcIN2SkeU2mFiDBsUx+AH6q2RV6ZLwwDla6tgtyxYIP+q1fCvoXCqtUhjkhLmeftjDRO2ajBJBJC9Qkhcg29QzsGsWKvnRE8ka+5GyAb7P37yxbZ8vUWwZw9h6MLAfCx3/wPlUr+pLQuE5FU0pUU+wxepWh4Iq5MwjUe+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MSyMLdNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WVXMlbYq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSyMLdNj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVXMlbYq"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6450D1140153;
	Mon, 19 May 2025 11:03:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 19 May 2025 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747666993; x=1747753393; bh=gQ4q8cdG0Y
	NLEjkjukHXlftdbgMHzn/g4+fXD9XFQnw=; b=MSyMLdNjEVmifMWL61j8KqagCM
	Dbb/MvPzmsH6kPpkazPDE75PChuZvC957v1ADh5JWCgfJk2hBSs0djOWBoJzgcjL
	On20Cgs7l8IfHJ2LYgMYSuXlag3xyrfWurVGNBIQ1bRDSBNuMryCVodSDRAaz3xO
	7y710/1UUzsqlk+FPlWrq+ahy6LjvqeyBDW13fjs6k6Q6yGPUkIcBlSoM/Wcvh8v
	87JPclAyNqiuZbJC3RimRaD7oHeXx6bmYfE1rrL86OTK/coawBxFNjr1Bh28BWI0
	ksHRcxAnHrK3Z5ld4w9ekKDQaEk0tOQnhsdZc6hfCmgba45Eq85g8r6+MBsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747666993; x=1747753393; bh=gQ4q8cdG0YNLEjkjukHXlftdbgMHzn/g4+f
	XD9XFQnw=; b=WVXMlbYq/VgHnCFKQV/ydGXpd9O8CP/MDtpkNq0C28IbtfOulfW
	WGb49QjWVFr6JSFs2HwXZg1QWFsY1cRPo35RhFzR4wa1i5cdIiZ8l5HUyG/cCyc/
	nudFpeOyOhEdrfFkj28Bu8bFfcoC61TNIrAohvxLcybVXWly+Ip/f2WxLoa4+TNA
	XVUaoUIojAR59ljgN2yfP2kdm+AVBfe4ycGNXXMBt4nOOStn4SCfnm37oouYi5uL
	Sj/JhmVR4AuL+1aUfnwIiCg6/qkURq5iNYcozPK/Ob24swooA1zH8lvLbWH6Ewt0
	a+ImOd0Pvo5C5puN1G4XKmRYfyzXfVQqxJw==
X-ME-Sender: <xms:MUgraC4QslbDz8rhi8d7Le7OGKYMXFOcChHfmtvcaeXKEU7Bmzp-jA>
    <xme:MUgraL5TuPoEetk0Rz4MvGqQXVN-ScL0mSoJpyQc8Jwr-b-qmUhaBdGu1KpchCB_0
    xNM17Wbq9kEhv_aRQ>
X-ME-Received: <xmr:MUgraBe0QErpV3FORPRvWLL0aByzf9cF7039H5MH4ZsEApCjN33-50iUcQ3SVlvXZmutoOMIo1-A_lqy8_zyBpoljN66ob51pEzzYjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:MUgraPLDcPuI7YHH7HEPgOIqz8ytiQOcWqa5PpEz2uzszcG6qPsmgg>
    <xmx:MUgraGKeahqkz7byB7pEhhq6_J7WKp2JzXZ8IICYAG_4g2pxxTimBA>
    <xmx:MUgraAwY8Iiz5FLfQSQUswu07KfSfVpYkD38HLG_R7AFGxxZHybFdQ>
    <xmx:MUgraKKWgglCV85dH6CKgX4vpN9s2bGyeiIzNAGP3Yo0aEQclQ-qAQ>
    <xmx:MUgraGUV1RPmXct6WaPP4cxjX4lwDPhbcltQHn_ozGp4XrS7wXg8mS8l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:03:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/13] t/helper: add zlib test-tool
In-Reply-To: <20250516044959.GH22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:49:59 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516044959.GH22242@coredump.intra.peff.net>
Date: Mon, 19 May 2025 08:03:11 -0700
Message-ID: <xmqqo6voprrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So let's introduce a short test helper for just doing zlib operations.

Oooh. I remember that I did want to use something like this from
time to time.  Nice.

> +static void do_zlib(struct git_zstream *stream,
> +		    int (*zlib_func)(git_zstream *, int),
> +		    int fd_in, int fd_out)
> +{
> +	struct strbuf buf_in = STRBUF_INIT;
> +	int status = Z_OK;
> +
> +	if (strbuf_read(&buf_in, fd_in, 0) < 0)
> +		die_errno("read error");
> +
> +	stream->next_in = (unsigned char *)buf_in.buf;
> +	stream->avail_in = buf_in.len;
> +
> +	while (status == Z_OK ||
> +	       (status == Z_BUF_ERROR && !stream->avail_out)) {
> +		unsigned char buf_out[4096];
> +
> +		stream->next_out = buf_out;
> +		stream->avail_out = sizeof(buf_out);
> +
> +		status = zlib_func(stream, Z_FINISH);
> +		if (write_in_full(fd_out, buf_out,
> +				  sizeof(buf_out) - stream->avail_out) < 0)
> +			die_errno("write error");
> +	}

Even though I may have written this as do {} while() loop, I do not
mind a while () loop that depends on status being initialized to
Z_OK.

> +	if (status != Z_STREAM_END)
> +		die("zlib error %d", status);
> +
> +	strbuf_release(&buf_in);
> +}

Looking good.


> +int cmd__zlib(int argc, const char **argv)
> +{
> +	git_zstream stream;
> +
> +	if (argc != 2)
> +		usage(zlib_usage);
> +
> +	memset(&stream, 0, sizeof(stream));
> +
> +	if (!strcmp(argv[1], "inflate")) {
> +		git_inflate_init(&stream);
> +		do_zlib(&stream, git_inflate, 0, 1);
> +		git_inflate_end(&stream);
> +	} else if (!strcmp(argv[1], "deflate")) {
> +		git_deflate_init(&stream, Z_DEFAULT_COMPRESSION);
> +		do_zlib(&stream, git_deflate, 0, 1);
> +		git_deflate_end(&stream);
> +	} else {
> +		error("unknown mode: %s", argv[1]);
> +		usage(zlib_usage);
> +	}
> +
> +	return 0;
> +}
