Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1B350A10
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985122; cv=none; b=h5oBUBGR7mxzcG29yLq+l8GLTp0AaD0Lsj2G0gjVedn+OrNuYOAg08ddRIGilpHgUCkrN4050AFELuj83TfiCMklhQhknRZz5ovis9F2g/i7D4uTPmCxbko4li7SWiZBrWvfomhq6cA9Cl2ISRqg9ocZbwpRqkRry+/NfreVsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985122; c=relaxed/simple;
	bh=CGDKctnc6aisbl1mZ8qrWh8HtPwzAdTEbGZkUmvom8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNRNqTUbajivBxZLNX0S6erh1YvMuU3ek4frtzP+36R3bkPWRCQ33tz4u8AzZS33tKNCU2RObJ9hzu7shWTrthZcaPwCSPX1XA8J/jkRr6Fcg1fI+N/LXXFW5YLf3L/YUsQrVX7U/njFNtLS9Q/qdE/VTT1nZYCYtLHpjig1YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZhRFp68z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXW+rA89; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZhRFp68z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXW+rA89"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CE1AF1D00163;
	Tue,  9 Jun 2026 02:05:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 02:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780985118;
	 x=1781071518; bh=d2cbTqhJmijrlJBwT7y47kPlyq1rIjFb4UmJ7F5TXPg=; b=
	ZhRFp68z89yWluhm8N+aYBbpxukUWLQ2/lee2vuuUGmF4BOpgHdXZ3px9zHdmLSA
	h3SOE+4GWo1PfuGg/v7qR5aiqZAcQW77Cn5mwO/VGgS0dnbybcn5qIMCiUfmcEaL
	Jyu4p2tuHLsuFevxEVNNjVwuvSZgA6cp8dlzHIs64tXVrwpZtoukdEQhdphyIFEp
	B/oPQflPeAWE4NCvnlQqAZiGAz1F5ATDkS3zjUzCxdLjsSdb7Chi4V4Bp4jxsaro
	CbCy+EK8U4KSaQfKUQiM+HwTApggk71j4agnXyYAjZkuYB+chRES+eBHcz1cNPwn
	23lWfpshPiAuunsQFj05jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780985118; x=
	1781071518; bh=d2cbTqhJmijrlJBwT7y47kPlyq1rIjFb4UmJ7F5TXPg=; b=R
	XW+rA898bFmfi223KLgpRuWkG6H+SHiikNj/xntNapK7ZQ8bAr6nUvLKPLY+vuEf
	Pi0xEdd2H2p2uqmk2INMQ/KPw+mPs/vGJhTTwetxuT0rXq8tv9jQUbWByt8ETTq2
	aIw9LzKujiNVax1ANpCh9d0iJKHFQxKGtz551s7AffFl97pEBVLa4iD3pbUADQzF
	SUZ+zOfq5OH985xBIs3zwlVHzFSrEuEGH/a1RMWFb0HKhL01aoj5zt0+NwLK0RwH
	pGNQRUQIBFAXG5/KBBdJ9830XGqI4hSNVedWT7TaGfi+QJ0OJLqKpoB2M+lh/TSG
	Ye3/snSn9vsDdfDGOCwAg==
X-ME-Sender: <xms:Hq0nahtoSkpit3VjTrRbMy30u-1ElanWDTKhVc1qk0p-2mlBtwHtIw>
    <xme:Hq0nauLWi9XmRnZT3uMbhU_2DZqnWryMJjcUX14bp4_aOkq_ZSuN290mtCYk_5AoU
    cHq-gMfjwsDBNMCmBhn-F97FDPJfF4DNs5kRPv45XAUNrp8M0D16A>
X-ME-Received: <xmr:Hq0naunktOyo45Hc0iH3Y_uAR5By21fngDaHtZM6kL2Ee_A_yAyouKl_sevG1SYKh2bS-MHaWZIgQl5jOdXTkrszZC6BlG7UrFJBVlmARws>
X-ME-Proxy-Cause: dmFkZTEZ4iEoKBZKwlxzohtnt0pd0QtcxeemKFFuSLy0EnLIz2ByoCrrr+ClTejGU8g8CM
    DBZyCa/QMrOuxBaLVjHm8tgP7cBb5Bc9hq3X0wtdQXvU1uTsC1EdGB47TZY36FSJ/1O553
    tNozZWB+fOOyr35ImvEY4eom8w+KeNKNi1U/rA9WL5yXWJc1z4YosCv/IBHLG5m10nd6Ul
    hgrfdtJ5A4DYgBOczxyDecgsIY3uIYSiY3l+wJvTeWnsa4kLKYDNF9f1Nrb9Oh5DVSYzE7
    DIMbSafUpkog0ptm+q71W3aBnqiL7BUBut/vbxcheapOeAGCl6HBV/I8OvZIVu1nslI9kw
    CyXStm7LDOTHpk+GOUbD9bfIVfVZznfHwtW2lDEnLYZMVlZv3yEEfCUE/GOGOFEdNfOCEj
    4G1m+TVUVsUJSnne/DHenqKonKlU/YibA7wMFD8MSPxqOwKc3pFEyGo2bA70Skw7naNtRh
    sMZBATmJrJHqDOLxH8qp76HSvlHUDqqstn3PmLOWuJ2xR5AttFuuIaYvujgXNUu9ltl+Yy
    LRYdc3t9A5KNKjmM6TrpbidqOq53OdUtQwLX2G2ROyMMIhPaviG1g362qEFGGY1zbZ3fgO
    R3oegAyg7MBrBpHzGjCi+T+l1et92W0bVRmCfMvPvGWbz9S0g8Tx26vaLsIg
X-ME-Proxy: <xmx:Hq0navI8aEc1qPXNc3udJ9qjGWIZth9cDCpVkt4eGGBm1PdO4GmEDg>
    <xmx:Hq0naj4usX8g2UYD7LabBY3kDalijezKnwlug0E6oroDYCB6pDfflA>
    <xmx:Hq0naj2DVIJ97kVKoOUw6Bp7Ml52kLXMEUAe8BZkCgJqaWc-boBzwA>
    <xmx:Hq0napclKVz1QkH5gyH7YkdIVKOnUQk9dFNz8-MkbgrqVcRKNnBLjA>
    <xmx:Hq0nargWmKKistchaEQRFak3M9A3MLVZQz0bzbBBpZw32cmJXFWQxnms>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 02:05:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99c1cb47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 06:05:13 +0000 (UTC)
Date: Tue, 9 Jun 2026 08:05:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Victoria Dye <vdye@github.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] ref-filter: restore prefix-scoped iteration
Message-ID: <aietF4BX1Ewt3cpG@pks.im>
References: <20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com>
 <xmqqpl20vhni.fsf@gitster.g>
 <CAJ-ks9m9gq-=JB-gqeKaL4YOLSfrP2Cm0DytZjuC3OetG-UVbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9m9gq-=JB-gqeKaL4YOLSfrP2Cm0DytZjuC3OetG-UVbA@mail.gmail.com>

On Mon, Jun 08, 2026 at 06:39:48PM -0400, Tamir Duberstein wrote:
> On Mon, Jun 8, 2026 at 2:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Tamir Duberstein <tamird@gmail.com> writes:
> >
> > > diff --git a/ref-filter.c b/ref-filter.c
> > > index 1da4c0e60d..2388a57b39 100644
> > > --- a/ref-filter.c
> > > +++ b/ref-filter.c
> > > @@ -3315,19 +3315,31 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
> > >               prefix = "refs/tags/";
> > >
> > >       if (prefix) {
> >
> > Below, adding an extra call to get_main_ref_store(the_repository)
> > makes one line unnecessarily split and harder to read.  How about
> > doing
> >
> >                 struct ref_store *store = get_main_ref_store(the_repository);
> >
> > upfront here, and then use that to replace these two calls of
> > get_main_ref_store(the_repository)?
> 
> Yep, done in v2.
> 
> Thanks for the review!
> 
> By the way, how long should I wait before sending new versions of my
> patches? I have 4 outstanding at the moment.

I typically aim to send at most one version per day per patch series.
This avoids that you're "flooding" the mailing list with too many
versions of the same series, allows you to address feedback from
multiple folks in batches, and it gives you enough time to think about
the feedback without having to rush anything.

Whether I actually do end up sending a series depends on a couple of
factors:

  - How big is the series? The bigger it is the more time I give folks
    to perform reviews.

  - How substantial were the reviews you received? Is it just a couple
    of small typos? Then it probably makes sense to wait one or two more
    days to get some more involved reviews. Is it something that
    requires signifciant rework? Then I'd send out soon so that others
    don't review a patch series that will change significantly anyway.

  - How close to being merged is the series? The closer it is the less
    substantial the reviews will (hopefully) get, so it makes sense to
    reroll a bit faster even if you only received minor feedback.

So there isn't really a golden rule to follow here, but a lot of this
depends on gut feeling. You probably won't have that feeling yet when
starting out in a new project, but that's fine. In case we see that
behaviour doesn't quite match the norm we'll typically give a hint that
the contributor should slow down or maybe send a new iteration.

Patrick
