Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA34B04A1
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098273; cv=none; b=oG4mWHP2wtw1xf7CqLrdaxP2mc8q1PLA72sQAoqoOKdOGbdhhSl9BE++JFt+o0LYWqck2bFLtpYlms4pwTFuvSeEvcAFytmdnxsoBFV0dZZPsRPZkDGErdVi69QAh8Q6Nu0pFtzVpNLGyFk0nXxbbSdfWPSz5peCx67YYUxc008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098273; c=relaxed/simple;
	bh=zVLv4ipxbEZF3PhzZ509H+QrL0RwREUr7ufp7XAe9dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D//D7t+aFGIpaDXF+aAMEXDUjsQjWt5V9HtDlnxbb+a6YXqaeoLNJYxhcaiVBjTfnvK4aTfgi3hEiHab8Ai/lZdl3j/QQrCD9KbDqDbUuP5SxBgVDVY9b5XxkIZ5ztMPGmttsKusMPIHApHUXCbziyTOd+ATTUM7DHH+AbNfACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RS+pKcDC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HhUTL8HF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RS+pKcDC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhUTL8HF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B1ECCEC0129;
	Fri,  7 Aug 2026 06:24:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 06:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786098270; x=1786184670; bh=W1v5zrZNRg
	FRK6gkVEB3AjgSqIK+IFfc4+hQqAgX+Ok=; b=RS+pKcDCL9BoNHiw87nkESUczT
	TcjHzsDmDYSC09BgBCEH9RNxqRAAh9cwtjH724CoX4a5946qRZ18s3DHI9nSG9HZ
	/0xTrewarX2nQnVDIAXzKsraYOGa/ax6fTOfOfz/ktdYLTzvX3ZsgbQfJbS/GIKH
	apitzNecISlMhfuUXY+cBaFMZpijpDbQmiomnBxMcEISV+ewy5Ui6SgnnvSQXVDe
	hk+NJZmm3LQqEkRLfuGdfd2NlP7PZITfDdnsKnUSNakcnKnSxvU1HKqUTmjiNIdh
	SSTCj0XWBzNpGf2oPabmt3DH70zLUmzv+hRJDUox1fgXdehY2o5/AvfN0biA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786098270; x=1786184670; bh=W1v5zrZNRgFRK6gkVEB3AjgSqIK+IFfc4+h
	QqAgX+Ok=; b=HhUTL8HF8KALVfw5NvLItDtm1NvV0lRoeie1x+vjmcdjCtk7SNj
	SwUcTLpj22yxGrh/LX2/PnXcpWBcX7TkciVmrRAeD2uly0/Z7dSgUnu3ew/1bTGq
	w/OQ6lkF36oJ5l/a+JH4xf8WFQAMLQXxClbP6GXnU1XH61Kc5RsXX9QN4trxdG7H
	UeDbtsbfoSzN5MNiEV3DlAPlpSo7N/2L5z2+VPyr7Huhwhr144oVxpG9JGmQrMhj
	rKJPA2r4y0tgXOFY0ZyAtjw0z1/ptJ2lSpmyBQEkGfT7vDYDgNPn+ozIrluoTeYF
	4fQYQkBmApfblbrMrQsVliw41nj4+m7uooA==
X-ME-Sender: <xms:XrJ1atj1AvqL4RRNrCIR1y7BuMItWQcp3VugO3aTPHEd3C1q2vFhlg>
    <xme:XrJ1alv-swZLoLktuKuVqUB2haHtfxaaOYPJdRRuMlW-k-pOCJrJzIs3MPattAua-
    MosfhO1_bGgkQXDbh2ZV7o9QtCsBhSjl1rNrhcgiTqkc7H8GjOQlHA>
X-ME-Received: <xmr:XrJ1am5p0D_yVXfviyuKZoZXFv3J1LV1WtluCLWMshVCKUkkpVnaJYFmxSsUdbegiwcYVAtoe0UTed7SS3jcCbgdpw54R07fx-pgeiMgbNGYDQ>
X-ME-Proxy-Cause: dmFkZTEaI8dqWXpBcdka3nLd1vLCfiyXibQhZeJI9rCcQQNwfaJWH4hVQQGPMXnU5itMO6
    bL7lLtI7kt3HuRCiV7RlXphedL+kDd7lK0FjndHUvjY/Y003Yb4xbNPDpV7IjWLnJEfOGJ
    1Nb7XdldhV87AthZRkPY8JpSB51xx2dRcwlsa4qSnuY/F438vD5tCKMGV2PTXaQWLd0jBj
    ejj8+AlF4WPjMvo37K/9NLvoolzqJVJF9a7Gyt1KddrskdGnSsE3nLihYz4NlUW/Y4Hbu1
    vtRffowkOWZ79Fh+bDeziSJ3c7uevgQw3fB3yJHwLbNtcrGeRTjp+Wi2TacMrEKN3hfamZ
    7pn8liH6fFFM9E6o3f29iqivzuBQ1FT674ASSaKNrxkPJH26bog4t7tMkiulHm/tTZO7c/
    AeKQvg3LWzAkRBDfuRyH1YmkfyfOVJvZ017krpDIvFpcCwc9rahV8VKXRZDlXAoDjVo62I
    kTN7fZ7k0UN9I4J7B57CgpnInmXBh/NqWzekpHQ450cSgFMOc4l2EzXA18CTH0mIV/4jkK
    eFsC5RB59FrE6cRDAViq96OCcifKF6MZHGR/xEAiPLgQ6X7feqOC6DmlyjHTwtUwyBDTMi
    mhhNrF+9NXwDg3yVjAj+PB8gRV4ZZXocm37eFFuk7Thu7stbVSMU3KOXgVGQ
X-ME-Proxy: <xmx:XrJ1apMny-OgWBFERKzRymyOFFkWgx-3UpUkkI1x_EHLaxs9dTQEsw>
    <xmx:XrJ1asu6B9-67_g5AiVn9CkJr51NjzwPKb8paUyQAUFLxs1l0JuX-Q>
    <xmx:XrJ1akYJcbRhv3O_RGD2x8UnjJLjsUOs7UehumXpS9IAh3Tbj8sSSw>
    <xmx:XrJ1amxNBrHvenBapyy3L3mJ6ih6I6BM5_K7qvqNRAVJfJMq0lIRAQ>
    <xmx:XrJ1aiYUT_4Hy-IG0boHycggCpAs-Q86pDT9ryPZv9G9EYaK3YFNHYa3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 06:24:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 769538c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 10:24:27 +0000 (UTC)
Date: Fri, 7 Aug 2026 12:24:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, tnyman@openai.com, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
Message-ID: <anWyV9Q4Cmsa5AoT@pks.im>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
 <20260726083905.GB3529069@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726083905.GB3529069@coredump.intra.peff.net>

On Sun, Jul 26, 2026 at 04:39:05AM -0400, Jeff King wrote:
> We recently ran into a case[1] where old versions of coccinelle ran very
> slowly, but newer ones are fine. The version we use in GitHub's CI was
> the old slow version, leading to timeouts of the static-analysis job.
> 
> We get the old version because we ask for the ubuntu-22.04 image. That
> has coccinelle 1.1.1, but the "fast" improvement is in coccinelle 1.3.0,
> specifically their 58619b8fe (break up envs for e1 & e2, 2024-08-18).

I have been wondering about slow Coccinelle for a while now. Making
things faster via a simple version upgrade is great, as it comes almost
for free.

But that being said, we also have a bunch of Coccinelle rules nowadays,
and my gut feeling tells me that there's a bunch of them that aren't
useful anymore. "refs", "object_id", "the_repository",
"git_config_number", "index-compatibility" and "context_fn_ctx" all look
like files that we could probably just get rid of because we have long
done the migrations, and it's unlikely anybody still has patches that
use the pre-migration variants.

They'd of course require a bit of a deeper look, but that could be
another way to speed up Coccinelle for us. Even though I cannot say for
sure by how much, I didn't give it a test.

Thanks!

Patrick
