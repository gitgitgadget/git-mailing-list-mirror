Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8877443E53
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567352; cv=none; b=IZ0jiT5EULmYXMQdPtX2/c6ZykBSdLKXbwMcIUVDgwwsg7YFBLvNzq3Nu8pu8xT4YmU+GIUXOf5GqAue5FN8TN771Rwlaau8AAvVkTSNcN2qoSbhqjGvdDeKhT4RVksl1nEELr8Tak7GnLg+D71BH5rbuQ64tsQ9ViY64bz+K1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567352; c=relaxed/simple;
	bh=HVIxgdXF5gx9IFCwn5zuV6fPVzQaLHvEydO9Jk1YU44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=axp8+kU2YlMEgVMnftlzwRa7LYOTb5eDmbh8YWxwGhCIE/QR+OuWJQpSvcR90OFRtfYWX2NFIeimGJRWb7IJV3JNx/DI1J1t6TnSE+1jfgxgW01HiwauptcojZuWkjThDqENCq1h9HvCJFSfBDMlnuG7Kx6krxRGGGRcTtCIZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U2FwP7jl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdtR2eSr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U2FwP7jl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdtR2eSr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C6ED1400134;
	Mon, 20 Jul 2026 13:09:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 20 Jul 2026 13:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784567346; x=1784653746; bh=HVIxgdXF5g
	x9IFCwn5zuV6fPVzQaLHvEydO9Jk1YU44=; b=U2FwP7jl384XBeXy6ASRlmAAuN
	VAAT84UK2Mt1eou5tjJxU7B+grZxPQnNpDumOLfDZ5lJKcQL2/UL83BmgajuxFZT
	wUE1cKxBNOBv4Icpb3aN86ByO5pVeX3wjAEsyP3W0bGQUsaG5PIZB/qQa+mUaYwm
	gAybr1iMIauEQhFpr8JGFINsfhHic6K/tpAIW9D0mSfEPUZiq3dMwnRVNpl81Vz1
	bQXtAP5TIOdN4OIpeHcfoD47y8AYnjhKV0PKnDVS05uBUpv2bPnUrGNoFnUccNUz
	OaK6I4x41r+Ul3Xnv8s4uenCeR/CqpLWUv5VDg+OFD9N8L7vdF2oKT/C0G1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784567346; x=1784653746; bh=HVIxgdXF5gx9IFCwn5zuV6fPVzQaLHvEydO
	9Jk1YU44=; b=PdtR2eSr3+sw9U1ZQ84mjMskPVotpIVYdeVH32fP4d0qpy3ZetI
	4EL2IouxNMQD771VNM/vA8gDdzzvX/Qbj9Af8FzbZ9h1DugT0fxkU0jhtA+MUU+E
	EtW/YgPAXgjGCY8I0g0bhfIVy1PVSh8IR1Alb4GNjN3vozuHQeCTx0xEpgsjhKcc
	gazqhpYbo1CmYG3UrVgg/7/JaNDOIxVdB4IXwyq5m4u3a9OKSXsnccvnVIAoiK5P
	R42TZxlyrNPSqSQu1fvjvGNrvqt0rRFJKwP9yOnDsiCGKa/SEVEs+JcbUPAxAhP3
	Kh3/p9tg1hVky2TN8GvrSlUM/MLor3alL5A==
X-ME-Sender: <xms:MVZeail0lq5ru8FICKXZL2AsNR9-pNnPNbqJGXK0XWf5boB53ndOvw>
    <xme:MVZeanpZWP_cys4xwqe8q8FkG2lbLN_DOlH5JeFucGsWg6WgliProqWD-kFgp-85V
    tBPXIMhbmLqt8Jrp-OiDPFSUlyPnK7qfUPmI6oqiITCZZhGj6xnyOw>
X-ME-Received: <xmr:MVZearHqug70eio7WwTyeRAlgYaeyk1SDyccK_aFntrRQcfzQEXn6ci5xubQMVaO369yygKSgyy6vEh9QXXI5dQ1la1_ZhOWeQ>
X-ME-Proxy-Cause: dmFkZTFSrHxgwZENihRNDfmrAKR2aCIAAv0tfZmGPSCzwWbAkjyILphwOwd4B5DTfiIYHR
    F29BYRSeePyD64u8K3a8j0N/PS0snBilh+MTeskaY4O5V8FEFm24oicnVpF+jPRL5rFy1j
    rPvXm9yY2CIRCdY1e1CPcZJSQ8A0DXEW9yLnQtBOJXWXwThOI2qi9sZh/NSBx99bAxovtW
    JWhG8MIYOJJYdfql+A11ZyFrcxd9bR+2JFPb3rP1PhepJwH+qWOk7SfPzaqRjJPZ1M30cI
    QGe0LfXIaAXFkQ0Dx6ZDRmfVHOJaeh2bKGUnHQdskAtEZP0A7hV+KN5S7S88Z1EDY3MCq5
    cEs34sA9Sc0Hye+ZlWpIzp8kO7HUmzJR8p80JHZioS+YQGi+ZEBBshqwgCZM4FT413j4+b
    fa/XkpXRhwGc5RskKjKC9sq8J+O5VYR4S0SAXUgvB10w+CQxDFK0DxAHDfCs5tSn93P6a3
    ceO+CHOnkVpz/bTdrtkRRL4b0L6SpkPX7NSS7kppX78F7YA7RzIWu6VdfSI2em+aZ7BZRQ
    xgw7A5Cm4mrd+MfRe840McEclcrtcvx/Gky+hgdpbhQbeP2UPtCdBE5OS22wGVW7aZJvzK
    jbpCdZPaA0lMBegOxlQrr1j9sLFmvSsFm3Cax61OOO9WtOmzK1wNgGfakTPw
X-ME-Proxy: <xmx:MVZeajxBM1wIvHHrTPISRdBbb3tkQqgzPRGPN1aGfxRe9mnlfS2JPw>
    <xmx:MVZeagrCqQG8myKV_oFBxxFejm73M4bco8_nR1NStLzRbwTFjQMPsA>
    <xmx:MVZeatiAAeKGkERcNM8rowXkLdPQGAYf4fDMYOAxGW75wadso0TPOA>
    <xmx:MVZeath-mE6spDbpbZIYxgSUGTpmrKZeU54_BIKsfrCTtYF6tzWYOg>
    <xmx:MlZeasoZ11dy-IM9yd6VvJemb-n9nyDP-IEB85v86XJ-xXDJZKwEzP48>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 13:09:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Hendrik Jaeger <ml_git@henk.geekmail.org>,  git@vger.kernel.org
Subject: Re: git config: unintuitive behaviour with --global and --no-includes
In-Reply-To: <20260720125145.GA5100@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 20 Jul 2026 08:51:45 -0400")
References: <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>
	<20260720125145.GA5100@coredump.intra.peff.net>
Date: Mon, 20 Jul 2026 10:09:04 -0700
Message-ID: <xmqqse5dd1vz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> IMHO lbmk is wrong to be using "--global" in the first place. Looking at
> the source, it is trying to check whether the user has set up their
> identity. But it is not lbmk's business whether you did it in the
> --global config file, or elsewhere!

Exactly.

> Though note there is one other hitch, which is that the user can set
> author.* and committer.* as specific variables, since 39ab4d0951
> (config: allow giving separate author and committer idents, 2019-02-04).
> I suspect not many people do that, but that would also be something that
> a config-specific check would have to handle (but "git var" would do
> automatically).
>
> So I think you might consider sending a bug report to lbmk. Feel free to
> point at this thread, and I'm happy to discuss further with them.

Thanks for your thoughtful and thorough explanation.

The environment variables 'GIT_{AUTHOR,COMMITTER}_{NAME,EMAIL}' also
play a part in determining the author andcommitter identities, so
'git var AUTHOR_IDENT' would be the correct choice here.


