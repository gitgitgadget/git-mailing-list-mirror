Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E21F09AD
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349968; cv=none; b=AR7A9yBLyhRyf2qePRVVFsgUrmlv6vSemu3D5UcOFM3Flr0+KXLKMldO6R1WXDYtcPHn5teTSjb5B/ho0ILV55OZEvW4KuRjfUZ52CTMiP+ADo0rIcNf5nG5Ch22nMKZkoyjSgC6Vl6ana9OHxVxzMzLqKpTj8ULntbZVp6OTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349968; c=relaxed/simple;
	bh=WzhzzGnYhYF9c8PfCLswDsqhgMtg+qImQfMYhPfGMwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g88u88Dj92Bjby6JTB+Q/jm9o0dkyHjRwzjp7nE/OL+jQsdSqs1GerjVZa2GViVVLPrjtVImW+kgNVILjaD5QGkA9fzv5xkSlU+5pAA8haA/1/VSKkxnUwHGVsRlNrKvIi5u/dN0/98+u+mrS1VYhrxBk3/0cwp9yngaIlVrE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LnCTPfE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gsb0jT5U; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LnCTPfE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gsb0jT5U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 24D77EC0243
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 01:12:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 07 Oct 2026 01:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791349965; x=1791436365; bh=2h+M566hv0
	uxWW5+920PnbQ9c0eIAIq3XOBDHDKscDA=; b=LnCTPfE+DGdSntLcCks/Ck7ko3
	bgzbr9b+zBUL/5UAPBB6kENfHxd8YCO7GlqNyqU2FtlRlaR1KzPNekrZrfJnz5mV
	JW001sTXviDd5Y3g+pd1Rs1/RTMrSPqUKLXtHdyaVmmm27B25/gDq1xkzPDJkCCZ
	VKLt0FWW412v7uWcoqaRvgDi7fNSDepIzT9al/by2XAa1KKuSxtQ9WTpFPPUXn0D
	Nx8LPKJWu7w4zl9WWiY55w0BLgLctjQHzfXUP7Z7QaA/c0LcjaHmZGdkQy3oa+MH
	mDcMje1u+QrTmxojfRnbC4F/Qi8TofjGE5kUQsRL9nYAJ4dNTn+sTriezPiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791349965; x=1791436365; bh=2h+M566hv0uxWW5+920PnbQ9c0eIAIq3XOB
	DHDKscDA=; b=Gsb0jT5U2u37wk7WIFhQY2917ctHyOJweK0lAmSJ4cEWalEXmFG
	vGxwE+8n964lSbQsa0TbclnLx+fOGCpLzI0XCkuFFuFVd1mVfPdclL2B/E1Br+A3
	G3nr5W0x+JMjMPO8ukvQv8YHaYOtXT4awU/61s2SgLQfXeMYGtYeKHQwnWambs89
	pGPgIsk/Rk/vKZpjMVTMa+7McscGeYqQxu6qXkM6pIbebHonVrkG8YgSRKO624YV
	YWFmkCM4hktyI60ruAVFN+k+RCUK2E+2telI4ssThda/BAM9PyiDmo7ILhf9CRBY
	9j9uCxU7ideakUADtZoxeFFVotWy6qmkJug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791349965; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:H4/x33AUGYJPasVaFkdU9pl6pC9L3U6UvdySpJfKVtiYKIl
	H+89+mCdQsCdLHMe6OcnIjQudrvBkTRiqhSeYHYME38WSviEjoMUTTt4TkSfO8hv
	L4IfTh56TNzrHxUM85K5r0DM2mkzobY7Y2jOg4YXo/XC/xA4pvWrPmUAcfrjWZGV
	amZUyutiA8b6tokEe+4k/AJSvoeX6Pot1VhL7uok+FOo8Pi588LJ2tn8a8C1JZWZ
	BT7zyMh66VnHBX6tGpbldIw4wKY55Wo+EiYUYS/GVX91nlhf8i1XXcaGn2AOWtfI
	Lu5sVjtitw6XGya1W6YXYcCGl4PfSZwDtUVfgSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:58Y4U2eoCZFEpsLmNjaZs8wZkVZSiiMBatUUhZQErjY=:WzhzzGnYhYF9c8PfCLswDsqhgMtg+qImQfMYhPfGMwc=;
X-ME-Sender: <xms:zNTFamFESK3Epu26_xt9YqaanomDn1TFl-fWGOQs7N3ZyZ6gK6BGhA>
    <xme:zNTFauw6co6ISY4af3u1wE0vChVtx-vt2j7UjYb1cD9muv8ry1Vh_2FDPOwbOPVVH
    1LuE3AQonDn8NFD99c-ThvCON6ns2u5rnAucYk-4UtuG11yN6oGc78>
X-ME-Received: <xmr:zNTFatgmoXVkNJ7LOoQwBfTuZodeg2MECInIr5N_mx89CylJfTbnOA>
X-ME-Proxy-Cause: dmFkZTGg+BoSXPEIphIp3lAwzBYuyw3C9c1U6LdViikZ1F+rmY1A71giIyh9FaWOqYjBbx
    lJF9E7fdaBHv3jtuPWh2NiKKG1uamDaDMnAvK2A6IQc3NlmDlAz8Y7A4iUNYKF44U6fqF9
    gr6zZ7ieKR/bXC6kOj7bUtDx9QoIZBzq7RK/tlBtrHoPulNLTaXVYMxiYQbEQDglkYEKgr
    z89ZX/uDK16RkMT747tJx9o/mash9gbG/lZTd2obhdRjf/oewvU4fABo9bNJCMDYpVGy1u
    69g6VqGFswRWKX0jXU06qbI1PSpkGHot6CY/V+4koyeCyPFV0frsAKSDRT4FqSBILSvwpO
    JkMRWOKD4AMAWWt6pVDJRf1M10Pdy5QjZsiTaJMpgnNU95Mo61/LCT8VeD3NBXDqHc9u1d
    oWXv6gfTAMQU/RZN5DK0daafsCItsVx3eQktgBA49Gp+l7wiCHY8l+fJLQoZS9054geUd6
    JmrvO+/Pd5LmpHoBlbVPJ1N3TOHfwH7DgWV1eREz0wtpo+hV6MQ0Gq/ilk8AIyWHCY4tka
    R+WkIWUZOgFP7e23KboBrRyVeG0eLGMlipqGM89MQ36R++w0YDOrayBtpSWho3fwjLZXJH
    zOkrQ7C60hveQjtSIFiV4Q9Mg4qeiRzhnYBtfXjaN80MIDWH2YeiaCwXFrtQ
X-ME-Proxy: <xmx:zNTFapwdbubd9Efs6NgZ2HSM4bDqMZab9kct9cxA53l-KPXGxB-GBA>
    <xmx:zNTFagI_rgl-VsxyKl6pO1O1cY2xsKaES1Q4PpFYfABj0ncI2B_dZA>
    <xmx:zNTFagQhNogv-yUXZ9--Fv79jKT8LRj_Es0bqUzAvflAsW9ewRz7OA>
    <xmx:zNTFaoqwOPZ1myCYcaTxEKyIoekV6-PgEU-sgXbhI5NsM5wIvwck2A>
    <xmx:zdTFaixEMqmQFY65fRJC6RD3cXCaVkZtV8TOXgkNJ0145utqRccKYHRY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 01:12:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b9bb652 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 05:12:42 +0000 (UTC)
Date: Wed, 7 Oct 2026 07:12:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v3] packed-refs: use `fwrite()` when passing refs verbatim
Message-ID: <asXUx8DBGNg7ltk1@pks.im>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com>
 <asTqPcCl3RdS8YN4@pks.im>
 <CAOLa=ZSbT6AHfU178khN7n9rHAmNE5HEM1acr96HXqXpRcSzmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSbT6AHfU178khN7n9rHAmNE5HEM1acr96HXqXpRcSzmg@mail.gmail.com>

On Tue, Oct 06, 2026 at 05:11:57PM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Tue, Oct 06, 2026 at 11:18:40AM +0200, Karthik Nayak wrote:
> >> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> >> index a73fc6aca7..43ad674cf4 100644
> >> --- a/refs/packed-backend.c
> >> +++ b/refs/packed-backend.c
> >> @@ -879,6 +879,12 @@ struct packed_ref_iterator {
> >>  	/* The current position in the snapshot's buffer: */
> >>  	const char *pos;
> >>
> >> +	/*
> >> +	 * Start of the current record, set when advancing `pos`. Used to
> >> +	 * pass records verbatim to `fwrite()`.
> >> +	 */
> >> +	const char *record_start;
> >
> > The way this is written makes you think that `pos == record_start`, and
> > thus one wonders why we even need this separate variable in the first
> > place. So I assume that we modify `pos` in some cases without modifying
> > the new variable at the same point in time. But if so, the above comment
> > is not true anymore.
> >
> 
> Hmm. I only state that this is 'set _when_ advancing `pos`', Why do you
> think that this would mean `pos == record_start`?

To me it reads as "whenever we advance `pos`, then we set
`record_start`". Which is not the case, we also sometimes advance `pos`
without setting it.

Patrick
