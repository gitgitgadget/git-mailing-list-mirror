Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208CA94F
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790912; cv=none; b=T2lOyRCYcxhPzw/MzpxXmsXp/TbZJqV6O8vo8dz9proo9N+denRjSa/OrNlZDhF3VtOEpiuKeHSm70BcVynYC/kcduWBJgcTJHzaHP7vdDxo/310FyE+QvPrCPD6dc03SP1Ivw1FZr6CVumac9Nl7KQnz1CqcEg0xn1Du1gZszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790912; c=relaxed/simple;
	bh=SdRabrnXEMB86mzbO/57kyGBD1GWgVD90HdI6UWwm6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUFo8fh1czCIzH8Zxtpsb13+ypgkua4rn6uufzQ50sIQl4VVNQGyUVZ3lCEFO+n41EZir4pLgEOpsaS+13ITWsTMXrstIAbg7y0dG6U+RbA86qBqpjYxRKAGdfqQk0P+c1qVljasLMO+W4agz1L9h7YuUVHjw24YOjCrhLhyA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mcLlXZD1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjkrAHD/; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcLlXZD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjkrAHD/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 93B0A7A00B4;
	Thu, 17 Jul 2025 18:21:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 17 Jul 2025 18:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752790909; x=1752877309; bh=bOqH5Phb3k
	k/SlLtQNyk73xH0wDBo0lw10GT4N6F3OU=; b=mcLlXZD1V+hcBTGfn8cJO+YXGd
	sAlp8TbT82fXegyznhJeQQYhB85T481cJ6SRvmpIuMpfWbU7riiQS8WPwSvU+wK+
	a3CP7ZA6UKNUcWKL+Sm/f2G7OYuBhDafizneKoadFGzwC1tDel0UsHZRcyhHY4FL
	rG4xWurqDLK20lFTuhbunvvklO2c9te7qqwK6xzeKHBwyIzz5L5bVl2o+H/jDN6r
	OrydvKshbGkBwSu4708Z3NL7HaTwUnI2yoD94mV2ARl4lPiK6xWPe5Dk7WBJTaG9
	Dzn096twL1rPH52Nt0dT+BgzhHnZBgXCU1WY+yRYEiF4UZZQDSMsivf1j76g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752790909; x=1752877309; bh=bOqH5Phb3kk/SlLtQNyk73xH0wDBo0lw10G
	T4N6F3OU=; b=TjkrAHD/rdrnmGidrM4zn63Ni8o+z/XzrADf4iffFIGcbkhvWBv
	ee0sRoAuj9JASTjqJJ08NnAgSV6m6bBCv/1QIMAN2T+AB8QFof8iasRMEqwFZbEj
	louy1jnA7zNOhWg/wrGV/N6Vj2ExfmU2srKp33acB5Yz8RUYktuE37KjpXN2y7kK
	a+MTUi+2yWJOgvim+2nGco6wKyYM+ss/sbwVKrILPwzHMtGMwCHHbgdY9O9q5hZg
	Zj8zuxeWSjTKuySSh9xwYhlGvltIPku1C0oiHzjOf90A831vsbVwZ05mj65ciLMf
	NUaQ9JBpgkaHghLvodN64hiejgF/DCneArg==
X-ME-Sender: <xms:fHd5aLl2-2RUcNddYQL-50l5v_Eud3Z-oy1meAl5JDMpeIQeXoMRPQ>
    <xme:fHd5aLuXZVMO9Bk5tV1BxWNTbJLgilV-y005AvUf9T630_WkF9SnnsCyCbzsX0pR_
    tKLdYDjhPE4YKGj6g>
X-ME-Received: <xmr:fHd5aBZShOClYm9JBZX105YpPNCEt-_ko7p1XeQIbrQffhAqvfGEZJvFTibPXkis_psX5ID-ytQSsnEK1BVpTVha-j58Wlb5S0A5zpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgthhifrggs
    sehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fHd5aDDn3rvRWn26fndtovDxhVDs0S7hwC9YN2jD_kbEwr_b13lNQw>
    <xmx:fXd5aJ9FfxMqPVMhJRjyCt6OFw3s5LnihLmvsUYiHMTdpr8ciFgpqQ>
    <xmx:fXd5aPR6WH-YzwbQymb5iHk4_XhBB4O4bClFW859AqsuKQUUn4BgwQ>
    <xmx:fXd5aNV43x_E4u_epQU-If3G95FVCLTOeXf3Yzx8eGMgQOqVj9Vl2g>
    <xmx:fXd5aMw7qwjyYgqQhOovuAszlUfdHYTHAjjMzYSXabfZ0lrAZM_5N3fX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 18:21:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kyle Lippincott <spectral@google.com>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality
 via '--start-after'
In-Reply-To: <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 17 Jul 2025 12:26:31 -0700")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
	<xmqqple1gtyg.fsf@gitster.g>
	<CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
	<20250717015402.GA2127425@coredump.intra.peff.net>
	<CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
	<CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
Date: Thu, 17 Jul 2025 15:21:47 -0700
Message-ID: <xmqqwm864fwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> This series allows the seek function to set the cursor without setting
> the prefix, which is a requirement for pagination. So there is no need
> to set 'prefix_state' for this functionality. Which is why I didn't set
> it, since the default value of '0' (PREFIX_CONTAINS_DIR) would be the
> correct setting for all dirs. This causes the issue.
>
> So the only fix required would be
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..ceef3a2008 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct
> ref_iterator *ref_iterator,
>  				level = &iter->levels[iter->levels_nr++];
>  				level->dir = dir;
>  				level->index = -1;
> +				level->prefix_state = PREFIX_CONTAINS_DIR;
>  			} else {
>  				/* reduce the index so the leaf node is iterated over */
>  				if (cmp <= 0 && !slash)

Yup, that is inside the code added by this series.  It does look
like it fixes the complaint from the checker.

Thanks.
