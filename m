Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A794CCDC0
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217886; cv=none; b=K9gKF0QcHJQy8ka7VAan3yByPHVneIq9rIlDXYKxo8wc7tMDKMIjhZ8Y5prbY10JowGvFLifX5u8t9N0aAQ9KTjvMZZcUym+VlcGf3+uE3FbUEssgZaUcQ8gOvDT1Wagj/rkhL3G0Sy7Z3yp3q2n//xomw8V4JwA/keqV34DYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217886; c=relaxed/simple;
	bh=Ll89cV7yKbGLTwjg7dPYm3VqmyppFf6xGVcPiOjmeto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbnIrTDhNZDYI9DN83D5dbeR6cbaTDvoDYt5hian0Uw3Dd2q9Yg1wHIBKNfjkm9LFNNVdf7hjM6/Plc6C3lUirGByfbFmZATbMo5G6mbLoGJe09RogVEjbKmXUXO08erx3HWz0j8+JZZ0i7jNlYG18krqlOWdz5JLlGMrtjfzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HgQpe1y0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uaA/DIHB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HgQpe1y0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uaA/DIHB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DFAEBEC0920
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:31:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 05 Oct 2026 12:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791217883; x=1791304283; bh=vpYWyt4aC6
	yj9BidF+sT0JQqPeFwRGGQgMHB/T4za5w=; b=HgQpe1y0f+LfqvQ2QdMl0CSK+0
	KHFG387Ay63K6rrphSGcpNglGpTFOgWto/t9Fo2SUJRqzydepYy7BNvRcsouUFEy
	yC1b1W1Z0X5lC+lnILD95RcDm7Mk2G03umS5SlYutW6HDaN5nMxsr/73Q0EeJDgd
	Y2qHqme30Al9l/WdyJ96lfp3fU1x552i8qF8uH9ERFlreVDtMKxxPBjtUf0PvdSt
	xEpWUlGPTLMDsEbROR+GYqOHsOVkInCKW00aV22gGwk86pl5Sc4B6/F2Sr8/M3/g
	qhiuMwD7GnBZ3iFJZI2iD99xYa3rTf40MX2C80duhhhj4taoXONcIz6q/TaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791217883; x=1791304283; bh=vpYWyt4aC6yj9BidF+sT0JQqPeFwRGGQgMH
	B/T4za5w=; b=uaA/DIHBV6MOljqh/t7ivsaVNYFC0cIE6yw5Js3TLOFeZ+1oETO
	DCbwG6w7u6C5znN3d9z42lI8qkFf2Srv3Hsn531h7poH1RjIHiMTww63bjJn4+U0
	uMO7jGOHwSEaXy0+acuMG/e3FVrF8Uueefiu51rq1zR35tuLlyRake/nS49b7qx9
	KT6EYNE7+78G2YDtHXagPBNg9OAZItSxUUjStjr9xKKvYziRfCqI1n9CVEE+BL6P
	Q6rJplbqzvjPRx4XE2RykGXzfL7KaLvAGygwMmxm//236HT4yrAxXYwTb5KCUj5N
	YC3G/CkmEANgXQz+nfZgR2/N1ntADu1Adag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791217883; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Uev+qjWySWTi+o1DmF7E9iEvwodBAeZe3u+RBcdqPsAs5Qd
	k87n5NHEa0ZXyBuSoitCDn+bYMWFa2LXC645F3mFRaGh8RL4EHS2wUeSo0wvNa/p
	SLnh2O1/aDtv1UHxSw3NIfvlQjdFsFo1YkcTVD38JqIOyJaymzcfL4YRNtVCqUWD
	CbtXSHWhxw0ZnYvI90rH9vCGZmYp1L9my96RztDsIY4lgf+oDywkRKGnYZF7l/Zy
	8RfzFd41DrJGpaOBLzBUlCeeZgfugYKb3b1YH3eJbrJ2olFgpAhx8uBwdBXA1dkM
	sX5rhOWZGeyEsirL7yxNTQnnnAFpubzZVuK9ryA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/YBKIAd/F8TEN31L1FIJqKIzx91MnlRyxHl1CRJl/SA=:Ll89cV7yKbGLTwjg7dPYm3VqmyppFf6xGVcPiOjmeto=;
X-ME-Sender: <xms:29DDavRfGNdVUYki_Vd35BDjeQUG4sqDwkwzxCZhGxGcCFddyQHjhA>
    <xme:29DDanr5sqPQkuulx91WthVBTr88ck6QAA9-DsGZY_69b9KnG1ilAVYqpV0JHf6Dm
    lMK7oWJDEqh6Dt1u1sIIbQWbGbTGixesD00yVe_QT3HiB0mOuvlE5A>
X-ME-Received: <xmr:29DDatJn4uohTvfAj8NFk7wFLC7vwK2EJs5vr_f_IaTXPec7dRMnuewrJeDZEnF1Ptje6-o-jBLIpmVK_K8pI0cVJf-K8Q2tZ-my>
X-ME-Proxy-Cause: dmFkZTFN8p+BikCD63bmQPRqG8+Rtwd93Iv/qH3JyN8BZ9rFwPu6u2jJjuW/zN6PzZqY5U
    J3SNWFImGdPaPuQ21rkDtVSrfGCyRvdGiuWdCJgX7vsL2rHXFaYqzBATlJ0MtNFDSO3USJ
    c9fTB0OOikbWySxniBawMZSCl8HOhPWj84QGRguFyD9VxZ5msm2ocTOTdas4vxpxpZHbv6
    ducDHVOknCNdZswRhyQFVtF7dZeDgg2kexPy2YI0N21NIJtRKHVeastK6VTbk+WWc2UmxP
    /BPr+tulQm77U2Of0hnHjXl96HsDzXQK/PHhh5Mzt/PIbmpEebzF7ectn31Ki/m2BjwrlJ
    O+WXxL06SI3oh2URohIs6OrCFZXCi3a8OKu2EE37SgtVMaPDUzF4oIPGif00sJKXS/QlOk
    yYh8bWy230FHcj+q8l/JEg+XrBI1vhkuBxr3Zauw/OjTZZy5zkNyBOhvBZ9g8chQmBLnig
    zAmAR4Qa9x41J0n87Hdtgvymrq0TmQV0oBEvlCvbQ4WnNFdzUIQ5U2jsd3Eer2oKTI3x2/
    4jXDpu7LvtFqyfFp7THUyP1PmMr+zwgjj53nvk3T0YwsZ+0XyRmOaLXFbzIAvaFSIyvg0f
    XehCcoUcQkBmgptoSooulUVhQt9hBKpLCEJBATREti/RD8gtB0AUe5Xj/YBw
X-ME-Proxy: <xmx:29DDaqoK5sI2LRozQm6Iag-mJkMplAztzbY0c6cvd4ZyQfSUyJcnow>
    <xmx:29DDalwDVR9LVcqfj0vnn3maAQXLgijwacI9a7Tu47sXDWPXU-f10A>
    <xmx:29DDauNvA53SiKKi0_qZ-WFiJctm0QyUYka13zR2gP4_w-0NzBKI7w>
    <xmx:29DDaq7deUaAqVQ9AMWVlzwkm0UBis8Iz4KSRYXGKhvg2Kw9_Fg3gg>
    <xmx:29DDam5hzuC9YxsICbQd-A5cKZEs3rpf2SexXWoij_5TrPa88qs_Q4bK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 12:31:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] merge: remember conflict labels
In-Reply-To: <18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 5 Oct 2026 14:24:49 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791206658.git.phillip.wood@dunelm.org.uk>
	<18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
Date: Mon, 05 Oct 2026 09:31:22 -0700
Message-ID: <xmqqbj98kt2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Note that merge_switch_to_result()
> we assign "result->priv" to "opt->priv" and later clear "opt->priv" in
> order to get a pointer to the private struct as result->priv is void*.

I missed this part.

>  		trace2_region_leave("merge", "write_auto_merge", opt->repo);
> +
> +		trace2_region_enter("merge", "write_merge_labels", opt->repo);
> +		opt->priv = result->priv;
> +		write_merge_labels(opt->repo, opt->priv->labels[0], opt->priv->labels[1],
> +				   opt->priv->labels[2]);
> +		opt->priv = NULL;
> +		trace2_region_leave("merge", "write_merge_labels", opt->repo);

Would it be better to do it this way instead?

	struct merge_options_internal *priv = result->priv;
	write_merge_labels(opt->repo,
			   priv->labels[0], priv->labels[1], priv->labels[2]);

Also, with the way merge labels are prepared and passed around, I
wonder if we should just tighten its function signature and take

	write_merge_labels(struct repository *repo, const char *labels[3])

so that this calling site becomes[*]

	struct merge_options_internal *priv = result->priv;
	write_merge_labels(opt->repo, priv->labels);



[Footnote]

 * Here, I deviate from the usual naming convention to call an array
   of things in singular (so the second label would become
   label[2]), because from the point of view of the API consumer,
   "labels" as a unit is what they pass around, and call it in
   plural.
