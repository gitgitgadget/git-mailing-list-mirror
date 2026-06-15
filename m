Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C64307AF4
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516899; cv=none; b=lSQpfX9kviOnc1Q4vVxZZOZ+dRd48BZp3uPSPafoehaC1ZP/EiMq9roFQ18jpdN63APMomGE/HIJ+Y48pCK/t3xin0jXxJMVQYIuzymurdS/w7LhV0r+BO49cmMzHevwvjaVCwiq70LQjMEfSlLy4Re3dOisjqpMb41nAyebwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516899; c=relaxed/simple;
	bh=CqilXcvnb4zhv9dx5S7618gIqmkfTm6yeijMXZ08xu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIkyZ10w8dBuLq6Wst4xJQQtFDlFwEhg2mVAkThTKadtUfReR9J//KR/3FFSqBRrlClhoHdmEINKfYMNwtlwZj8ZtgFjkdiDd/IDHFByIaCJvqN2BWvYQFdhtqwKWUMFzvLsvlRUyPgqrQ/vrL5RU3B7Mt/iVPuzA3Bhr5OUkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mek7HWm4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uy8veseq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mek7HWm4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uy8veseq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DD9931D000BD;
	Mon, 15 Jun 2026 05:48:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 05:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781516896;
	 x=1781603296; bh=w2HXYrYy2sucNaQLJZKF4r9T4ZS4X1xE5wf40EWmaB0=; b=
	Mek7HWm467nrOZCYoKiOsluX7P3MxwZSssz+WUrqvBnjguePjEhOLbuTwq1RL0A5
	8WF0+9i/vOhbCq6FN0RRr62Posu4S/z6sl7fVFob8lErhiY6Ww+9kxe3DgZY61Xw
	ybI/zgvQz8DDBT8sow21e3KKUQvWbhGq1vHZh8qzD+c78Qnzl59txJyLQeqZrP6J
	xX0Xpdo9YQtoCBqv8lNnn76+LLad3bZWk1Ae1nrRJuhidbZfzxnzXfMxypOI+Rok
	V0e6TXyUXy80RwUg/mJhwgBGkoqmmxJoPJ5l4u+hEpTlLEnd5mNtz2/NXxqUIsIA
	l3+TCGO27HhJuiQMYKa8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781516896; x=
	1781603296; bh=w2HXYrYy2sucNaQLJZKF4r9T4ZS4X1xE5wf40EWmaB0=; b=U
	y8veseqlJ+/ya/s4Sr0CEpG6kqQm4m0UopUHxl0+Yw041Jiuv6Z7RxNGil/hX5gL
	GgewQvD1J7aLUXUIerweyfTp8ObYMpJw7G0pRovIqoI41QNMaPZ2pLGGQC4V53Vj
	PDW7oHy1/x2ZsAiN5EWToGW3qMQMTE7eKTpFr3sXcGO7LkAgu+lsxjbUVChfKgxq
	iDfZe/28ZK5oRic6RlPhG5m6QPi77SiH/hhkOaVrsmyIG+AFK1G6Tijb/qqW15nK
	7UFzIGoCSqRhdhjyzYxo5463zuAqrgPDdFurNIDNZFrFxhUzM9amYOssuAPfEd6a
	907CfjDZKkPCZfn6VvTLg==
X-ME-Sender: <xms:YMovalN_hXXHscCmENSvHKHsTgwMj666YKbpxw311Osuw7FfTKMvqg>
    <xme:YMovat9nUy2c0iH2vT-Q7WUko-cW8TP1b-WagZmQFiS-UXFz_fe4QjNLnd6FBLRvO
    nr-YngWW70WwiuGTRb72pctb9DbKYQ_7igyYoxfBrWYUXG_uco>
X-ME-Received: <xmr:YMovah6KspNc4YFo-zKu1jQoTYBr6ojSVDT0HDgfbDc6XTOvu1X9xGOt30LTZlO_Nh02bERbWFymW5iaLiMo515Z-VaVLIRYJV76v2yYiw>
X-ME-Proxy-Cause: dmFkZTGI/lLlEFezf54FBo8SA0ERarSnQkHT92OY0x7cP67eH6u5BNafbixNhOGSUXTycE
    sEdsZFi19UW38QVRZpImY2eV4YnviLeH5zrMj6eAf48Gbgh69DmwNYICQSGrghs+j0/NZv
    Jp06NN9bCqT2EFxLr6FPl1EcFwNTd6CSu27hH+g8pWMZHFp1TCVV3SYo7HqoKJGpTQt1qt
    z8uhdfjOdlDjHh8DwhjzwY7i4j9xAuKlCYPYqBgJdVvPr0shazFKbPiu8i99HDUAxx879C
    XAky9CgouRBvrlSi2ReJTyUTXnNFsCTgzFR/ARuAGPx0RZcShxTv3g/ZXk3ghCHqCJQvBH
    U0HcS6F/pCqkKPJOSyPlbguitnl/lUuyIZ53a7QMau8FYAVwCr1uIxI61lXYFb9LL0Sr0i
    qqP+Z5gK8qAjRM6rHy24YEHUZEG40rSOLeKoTDMJYeXeFU0owL3U46BOOHyXsancF0F2kI
    ua5qgUB5nh4l4dGBZimq+its31/xTjIexsf0jjzV6Z6wJdtfjTGNLoaouHPvjmgehWmDC3
    hdWK3rTJre5m7rhG7pzk9pHGVlqFs2MpBgjhQAtFzW7HDhziRP7tlICSPNp9yWEiH5c/Co
    eXEvsNrEcaKWMrdZDaHxZmfuZseEU/zdeDN16xot/GbqQu4KSCvNmBOpYAHA
X-ME-Proxy: <xmx:YMovas0Lnsq6WEJ1MvfmiYEzgtWyVPEz3i8IiqRi6T-SFJcqc3xriA>
    <xmx:YMovagCyp9Raq-I1k80aGuZMLbMPsU4IekZYVwmXCatw9Jdzv_9qKA>
    <xmx:YMovam216uru0LyjQFMRrqU-WjjAkG5LNUqb9lzcrB9nqQYC06c_UA>
    <xmx:YMovaivg_4YuGY1yLSQ-i-v59CAe-1NMAwXpFSxk-eq52TnXW0Jaig>
    <xmx:YMovan_30KCeBxyp3O762mVUq20U114rU7kxgTcJC1VvwQM5-b6O-mo9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 05:48:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f423c64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 09:48:13 +0000 (UTC)
Date: Mon, 15 Jun 2026 11:48:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
Message-ID: <ai_KWo9o1Fhc6OFs@pks.im>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>

On Sun, Jun 14, 2026 at 02:15:40PM +0000, Kaartic Sivaraam wrote:
> While running `git history reword` using a Git built with `SANITIZE` flag set
> to `address,leak`, we could observe the following leak being reported:

Huh, curious. That seems to hint that we're missing test coverage for
this specific scenario, as our test suite doesn't detect this leak.

[snip]
> A deeper investigation on this reveals the following as the root cause.
> 
> As part of rewording a commit in `git history`, we get the commit message
> buffer in the `commit_tree_ext` function. This in turn obtains the buffer
> from `repo_logmsg_reencode`. Given how `commit_tree_ext` is invoking the
> function with the last two parameters as NULL, we are clearly not expecting
> a reencode to happen. In this case, the buffer that we receive from
> `repo_logmsg_reencode` ends up always being obtained from a call to
> `repo_get_commit_buffer`.
> 
> This buffer is expected to be released with an accompanying call to
> `repo_unuse_commit_buffer` which takes care of freeing it. This call
> is missing in the `commit_tree_ext` flow thus resulting in the leak.

So this doesn't really read specific at all, and I would have expected
us to hit this leak. Puzzling.

> Fix this by ensuring we call `repo_unuse_commit_buffer` on the
> original_message buffer.
> 
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> I must mention that I also noticed the following comment in `commit_tree_ext`:
> 
> »       /* We retain authorship of the original commit. */
> »       original_message = repo_logmsg_reencode(repo, commit_with_message, NULL, NULL);
> 
> ... but I'm not quite sure why we don't unuse the buffer after its purpose is
> done. Kindly englighten me in case I missed something.

Did you maybe confuse "authorship" with "ownership" while reading the
comment? The comment only mentions that we retain the original "Author"
commit metadata, it doesn't refer to ownership of the underlying
objects.

> diff --git a/builtin/history.c b/builtin/history.c
> index 091465a59e..0e9259b5d7 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -154,6 +154,7 @@ static int commit_tree_ext(struct repository *repo,
>  	free_commit_extra_headers(original_extra_headers);
>  	strbuf_release(&commit_message);
>  	free(original_author);
> +	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
>  	return ret;
>  }

Yup, this makes sense to me.

Thanks!

Patrick
