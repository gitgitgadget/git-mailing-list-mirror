Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E11340A57
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560519; cv=none; b=ANE5QEuqCBW/0RDOyNhCcrOMi9cTtVhX7x5kruDNKd/wcyNaVoooXAxfecq4Agw6i2h4i0M0qCbXmaOxLdG3P+yNnRgWbjiehlgN8RwXMfJiWddF7BOgmTFZay65EhOqMVnay1ZRUZib7QoV5Ss6ONaB2uaINYSkKZ6pd0+fToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560519; c=relaxed/simple;
	bh=THGIgb3nuKkFWyJYhppW64kiyPkaG4noGd4Hd+282j4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZN89KblHqe9lEmACGWPRW8eeb1b0w4T8EfZBx9PVd1qOXAZ+5zyqQdVGj3ArUzpSnkkcV5Pjs3W0u3aXRF2ryIY5JjI4RoxlNMesgv5zU1racefvG4BqOR/N3YytlUvCZtjBuRcgtQkBVCy408qHksg0Bi910w1aZVzZnfhT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ntQueKcz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XtegZyPH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ntQueKcz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XtegZyPH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAA0414000B2
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:41:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 11:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791560517; x=1791646917; bh=5uoLd6SCUv
	rJkWqgkmLagSHu4Ji+8eCdUCwj+RPdBHY=; b=ntQueKczP7mkT8z7TlwTw5TEjw
	iB4sHUVXQE1qswQ80svc7zAorQ8GE2hIlR/hVwI49Jr6k9USs/45Rb/23SuvRdN7
	InkGbS0S165sqgrs33Y26AVVFuelzsSII6+ryaX1sj92w06iWCOFTerFkpT2AEKh
	5o7drDkDEerzf6Lz9J6A2WgUPAmnT7lAnI/Tx+534FYjexO5qCBu4exTWJWqc5c7
	59rbskY6b6JW/+Li0XehNioTmO/ZaNZT1J6s6QfOHeO6gY7JaDeIRV2B/G9+VYOC
	fXia6QeH9/wnxxAg1sLJnexliECPJH192N+a+Q2AwUDV/oZ1l3h9yyLKbOFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791560517; x=1791646917; bh=5uoLd6SCUvrJkWqgkmLagSHu4Ji+8eCdUCw
	j+RPdBHY=; b=XtegZyPH+An3jkreOQwelEdqsoSMy7/jU+2Jy6t55j92Hw0OWuA
	7WcqRml6RDH/X7y6b0hRUklBkzHDZnrGk7FJaEKV8a7YGp/4J0ZFKLmFxbgaAXK7
	XsgRaLxyYsmeiGXDi6lXIbV8u7qpS/KnD6NDrdX3BtDTR5dEXp1pCqiIEYyG+2ae
	KT1aoROnznTsEXcU/C6ThDJ0i959yQHRTcNbgj5CiqJLnorbUbSICBqzhL8wOmaD
	qhafolEzOzOR/DiAwYaqFZPO9PN41kXxtTWgEZE4dXdR5BPrgExzYCo2EFEC17Fz
	jwxkdKMNCwcQPuDFSf4SStRU4Qi2AmsARnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791560517; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:pP43c1Cll1gdrqxTUdEX4WZeJmWre0PS9dQSQ9u6jXTzKQR
	DhDnTriy3Ot5KV3LYR0sJyhf18FTohSUdcCcH+tObEkYL6HuhWza678SSIWu+9Wj
	/RApUZ8ky/SRLitBsq8GlxMH2GzaG4KEzpeetA0vIF8Nwd+Wu8v7b9D7YLOOio9D
	ijDosVpjUIcOHxi7huuDe3B5O5VauBHSip45UqyRIhuJOQQr4ocY3ORYAmlas06W
	DwYDwwRZDGmeRRy1RydN3rkMsQa+PPkd4y493/7TIhpkcqxYoZCe27V/e8pj5uCN
	JeJsnQ8MxNewwvFO2Yhtz6oBaSXdqv1tfeDB3tQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FqTnN1jc7GEPsVHerQvKQqNobOw9bM0rSfgBiJvF2Ys=:THGIgb3nuKkFWyJYhppW64kiyPkaG4noGd4Hd+282j4=;
X-ME-Sender: <xms:RQvJahltZiyEZGxzAtu8KCumFLFzhCxccMj6ka4BaeEUT8VGGUbvlg>
    <xme:RQvJavHtei39l7rWesiMfIbAhbPyDenHtUH5duNfDXLoOatIqiuSvfFcHjDHO-hqN
    YcVlvI4cMjsgf7A2Z1_fHokRq2M9d7ElWENUVgJsEXzKVug0rNlEDE>
X-ME-Received: <xmr:RQvJap6xjRIcg1XHbx1yxlmbs6hLyRwM8WiBTg3q1BNisscf9RQtkYGFtHjZdfsUDSd31_e5uNUJTAJbJGlq21-GQRlM8AmbQ4Ye>
X-ME-Proxy-Cause: dmFkZTGLCUffWFglxU+Jb2bnx0Ct/AkTcdn8CvgT5x/BOly1laKiNVs9QpH5Xt3iMuKwlO
    WZfUdwtHzPxNHMlwdBH5cUQPrT2T/wPbXbm2UA9VpTqu1IgkuDW16dHODiOdITSY2H1aiF
    ZlExiCbiTKAbfjjiC9PL6h2QX6V6vN9g61s+V32BHKSkpUMgmte673xP4ZlvIffgSk3H9m
    QTFccWpnupOhiYhrVILL6TmTSyrGDYKX4wkr5bh/x3AjeXRTxVb0eYqhDSucQJLrE3GvU4
    M9rIoH1vYcE5k0fE+UYwHr9Jsp8ntP7OKUkZZBj4tNMBLidny9wlkV5GbsZYLrX9z6GHof
    Z8Vr7ouJtJdJpuaaraADL9szQkUHNaIQR5FANKGPZioptBMu29RbEpn5Ew570GGnM/Hgsj
    y2wFjyGjC/jqxVcD9qkZqxWhXrov0GxFElOd9bqksoQdwwBvmRw9SBCPPeeHsu0PqB6yCW
    ImdQpI6E0wc3VenEU9mWdGvYuKbhjdVezO6AnkUNYkM8/QijqEGGKqpOiyjx13j8QeO7jW
    EWvi+w7x0NEIkBwKSN25Gu8JJfIqMdnLpkBBOxeWgRbyxoHcfUISNlkpPf8iuLWr9+cTkF
    eP7JtaOHphCpKIQ4Rh0Gjb4yqeWzFUX/8W6xl4hA444jLib0VWZ55B9peF7w
X-ME-Proxy: <xmx:RQvJankCQIToBfu3BIFePm_RU4JuGNYFIIpx-3YVarPpxX2vqPFA1Q>
    <xmx:RQvJauqXuk4vS0OlDdDUf1azZKRHb-Z0MEwOnbh3KVQGTOD6WXGYZQ>
    <xmx:RQvJamtK9HMAfn8pMlzfhv9H7FwS94uCDWw4xukOvQmcuIVUa1iLkA>
    <xmx:RQvJajEtXrLN3i8sDhY1VzqMwAXcHLZWnbeoeV2jqCy9gyqhb6w3Hw>
    <xmx:RQvJagLbqm1PGjLzD2ngOYVvuOSGDcWPBTWloe5szthpOxlKMreubNmj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 11:41:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/6] [doc] Add new page on merge conflicts
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:07 +0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 08:41:55 -0700
Message-ID: <xmqqse2evq2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * [x] list reviewers in Reviewed-by

We may have a bit of misunderstanding in the process regarding this.

. `Reviewed-by:`, unlike the other trailers, can only be offered by the
  reviewers themselves when they are completely satisfied with the
  patch after a detailed analysis.

is how SubmittingPatches describes it.

ReviewingGuidelines.adoc tells reviewers

  If you are happy with the state of the patch series, explicitly
  indicate your approval (typically with a reply to the latest
  version's cover letter). Optionally, you can let the author know
  that they can add a "Reviewed-by: <you>" trailer if they resubmit
  the reviewed patch verbatim in a later iteration of the series.

For example, you added Ben and Patrick to the trailer of patch #1.

> Range-diff vs v1:
>
>  1:  ad4853dc36 ! 1:  ab0344f947 [doc] Add new gitmergeconflicts man page
>      @@ Metadata
>       Author: Julia Evans <julia@jvns.ca>
>       
>        ## Commit message ##
>      -    [doc] Add new gitmergeconflicts man page
>      +    doc: add new gitmergeconflicts man page
> ...
>           Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
>      +    Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>      +    Reviewed-by: Patrick Steinhardt <ps@pks.im>
>           Signed-off-by: Julia Evans <julia@jvns.ca>

Going back to the review thread of the previous round of this patch,
https://lore.kernel.org/git/ar3sGzEknG2_Un_E@pks.im/

2026-09-24 14:44 ` [PATCH 1/7] [doc] Add new gitmergeconflicts man page Julia Evans via GitGitGadget
2026-09-24 20:36   ` Junio C Hamano
2026-09-24 22:04     ` Junio C Hamano
2026-09-30 13:19   ` Patrick Steinhardt
2026-09-30 19:53     ` Julia Evans
2026-09-30 20:37       ` Junio C Hamano
2026-10-01  5:14         ` Patrick Steinhardt [this message]
2026-10-01 12:10           ` Julia Evans
2026-10-02 17:58         ` Junio C Hamano
2026-10-05 16:54       ` Julia Evans
2026-10-05 17:22         ` Junio C Hamano
2026-10-05 19:11           ` Julia Evans

There are many messages that reply to the cover letter of the same
iteration by Ben that gave a lot of good input, and I know Patrick
also helped during the discussion to improve the document.  I do not
think neither of them said anything about reviewed-by.

We do want to credit the reviewers of previous rounds for their
input that contributed to improvements in the latest round.  But the
way to do so is by mentioning them on "Helped-by:" you add.

Thanks.
