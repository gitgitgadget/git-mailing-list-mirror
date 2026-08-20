Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823543441A
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225929; cv=none; b=tqTLk0mkkFfmCMq03rJ0eKM1IamfCE8y2JPPWNgLFvrsQjV8jeAXJpDOxc0Efdw4RVRSPXsZUpS4rPqucNXRuCHYYdJEsiuKVKmyEwoIsV/dLKgAaRYS3FW9eRIbUbDm8ccc/oYmG/OAA7LmN0DFFz8Czel0lW2+qDVnIb5nQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225929; c=relaxed/simple;
	bh=Y4jTateaNMa30GnVeXqVPfFuKDY6R2xkeULDfey1uC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e42tdFisywHtnC0rHhcOFH6a/DdpseO6c0kL+jlCthiDVK+GaHOhSAsPvM5GnYW4Q5524t0Bw2YRqA3wZNCyiVVRXGDLNV6HHfkgIa33YPlImXHaISYidLDANUrLRQhOHq2SueKQBBFDNLyE04fqAvs8FwGeYun65T9FuU82d0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XyO00h/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g8/tLJvL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XyO00h/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g8/tLJvL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A6323EC01AE;
	Thu, 20 Aug 2026 07:38:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 07:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787225926; x=1787312326; bh=9X2IStjmxY
	pWzTCTy6OHSRJnKMKOjoX5urQtRYSKtOI=; b=XyO00h/7QKg6/3Ks7+xYBXn/u3
	Tk3lVIxSI20RWdx4+frlj+y0naGBTZEgAH/Y83B/H7BxcLhfQ3xI9yJ/BxiwaS4f
	gxvmXv168QkCUBgkP3ZbBG6hv8KxHJ1p2mzDWeCmxi0hRVnhiVYGZ8C4aUdKLjrO
	np7CCqGpTiyHbjLXsHMa5bb2YnnzBhiP1n9W7zKlaJ3bDh2Zqz4w94g44OflWqAP
	M6dy68jzkHHA+fqbBBw72dbDdDyYDI9xtgEU/cQA9i8M1DQlm9y/UabHdiCIKqdL
	FpD+xml9EdOb0a3ERYyVl9NuLx2n70RUcvFC1OeLyRjuKpPNw5l4wqo5d2bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787225926; x=1787312326; bh=9X2IStjmxYpWzTCTy6OHSRJnKMKOjoX5urQ
	tRYSKtOI=; b=g8/tLJvL3aXu+5RLXiZmc4ePZKAJBB656H1TcR6WXcSmP0f/Hn+
	cmfgeeOOUPUQU7vZpalK624NgaV26T3IkVoVgwfCZQbM3oBJkYOCm4p9Oy7TioPL
	uaJx9X+GUIfjb2H/VvkoP/75g4xzwrIi4ePJpFyAHwu1IbOybmFzNPHGsm3zy0FU
	wFmg8pNeGdMkNCzueITu+ofrpSP/S6/NU6yoY+qVW2aAwGhD0J1P12tOQeJikwUF
	es/Vl7aam3S5mtF2/2Tw8myqsDBdmogGh3IbqIusjcbVqV6FQxfw7llC2XujTz8s
	d0vQ6+2ypps/dQJoH2FP18pzT8CIo0dXQWQ==
X-ME-Sender: <xms:RueGagg5klMq1Wak9L7j_-t4kP4ue_O5lZNdq_MqhjrB9_FgnnLzpw>
    <xme:RueGav5eDJP4GQWgDWVhyH0WQHmqr7lfkPYFIVhphkQwNa8csi29KF-t2Y09lvQfr
    az1P86o9ZSGJqk0o4XaPM9CWVKchlOHP7wgN2CEr5BAp9y3-C31_Q>
X-ME-Received: <xmr:RueGagY51zKXmlH0h1pPPm2DlI3bMyAugbmLden3sH8EuhSoBGeGbZQtYO8SSQhAcqkS_e3z1fHfJEozhRlyabXX5yvzIsg5xKjvFpqVIA>
X-ME-Proxy-Cause: dmFkZTFWHYkG1q0B5NUv6TZlhvAu+qqcNdNseQgRnEnTTgnZ3q9NeEGnWEebmf1xPm9LtB
    bi6Gx7Yc/aTnLjrmxv842RgcFqW9Vwoos/btylBz/PhAaFC/dEScnGJGcbs2MlewFphw4z
    dndoapGdRDyWmT8IKPH41oF7NpuGN4lH3zTafnBEUKQQY4nn81Hx3r5TJGbUkfF0v0mMQm
    HW9wnsReSC0RbnKXF1VqtuapHGm43wosDuHnl/Be6xIzT4qwVaXpds3+Dc+YdNxVV43iBU
    UQqIVzgwz5YTE0qoaaeeRsv2tA1sFpefei32BFpY4VcPYR06am/aWRC9fJu7pdXK/ZNvfP
    b5BRi0pdxOPxRJ7CsBj/f6xuNt22FfoLUbx+H25FAHQd4gn0vXj+0lfbBDbb3sGDa5Qrx7
    /+wueCzmsD4e+cr5CMW4iKSSgytgeHFnDurPlq3uBa5H+NJfaZfrQ9TPtOjxEvbejuhSGK
    id/mn4rXfF0NirQPy7ww7bsY+LMjA5zi58ZssGWZo2YSy45zyLCDRiHksHeTMadfP48as7
    f23aLVu29KpVwIpDTYemC+Az9Mklzci5q7+5MepRnh5LVWwEvXRkzm4ZlVqlnZV3Hl1tO4
    lAQgtV0hZRLef8HslMe0YBAI27bCmUgDbfTxLJklAZ5HrF49YtS2h1/Wjkhg
X-ME-Proxy: <xmx:RueGas7VB040uYkVdNkr4scHJjNs6-SMrBe4vP3LgB8vYMlB3ZBu7w>
    <xmx:RueGarDZajZF8IODDJ4tdx37RClpo3FZxYdknjX4rk0TdXn9AqPALg>
    <xmx:RueGaqcpT30MCB2Zq14WNYnKO-bLe9zp3VVdQ_r0Fp_hWAMmFCetrA>
    <xmx:RueGaiIOTgicsKjnq7RVwhc9ON1cshO1i2D3RmaiwZBmnAk_vN9pyA>
    <xmx:RueGaoJFkJ4GGU1AWgkXtNJSPDCABY02ZolsrNUfpu-Nn8iMOhrajx-u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 07:38:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af7d5ae0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 11:38:42 +0000 (UTC)
Date: Thu, 20 Aug 2026 13:38:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 6/6] bundle: generate packfiles via the object database
Message-ID: <aobnP3bJ1SQpYoFa@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
 <20260820-b4-pks-odb-generate-pack-v3-6-bc42252f6169@pks.im>
 <CAOLa=ZQ7-_=T1NSXY433oME8OoddJOuLX0wmdbk2ocQ0JTAuKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ7-_=T1NSXY433oME8OoddJOuLX0wmdbk2ocQ0JTAuKQ@mail.gmail.com>

On Thu, Aug 20, 2026 at 07:19:45AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
> > data that gets appended to the bundle header. While bundles are not
> > part of the wire protocol, they are a transfer mechanism for packs all
> > the same, so convert them to use the pack generation interface of the
> > object database as well.
> >
> > This makes the pack generator the single spawn point for all pack
> > streams that leave the repository, leaving only local maintenance tasks
> > like git-repack(1) with direct knowledge of git-pack-objects(1).
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/bundle.c | 10 +-------
> >  bundle.c         | 69 ++++++++++++++++++++++++++++----------------------------
> >  bundle.h         |  3 +--
> >  3 files changed, 37 insertions(+), 45 deletions(-)
> >
> > diff --git a/builtin/bundle.c b/builtin/bundle.c
> > index bfafadc984..de86e092a6 100644
> > --- a/builtin/bundle.c
> > +++ b/builtin/bundle.c
> > @@ -69,7 +69,6 @@ static int parse_options_cmd_bundle(int argc,
> >
> >  static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
> >  			     struct repository *repo UNUSED) {
> 
> This '{' should be on the next line, but that's not on you :)

I can sneak in a small fixup. Doesn't hurt, I guess.

Patrick
