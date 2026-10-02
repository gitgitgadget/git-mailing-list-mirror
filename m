Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A13DFC7F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925595; cv=none; b=kkZegzSR2B7g3dAyZ6C1+Ihkh1vfUjSUvWycKSCi9/Z2s1XFe2UcUa0o28/OYve4j6oedhCLJ0bgETMD5aG9Peave5a2W8Pt/Ecjq2nyNW+kj48wD34gDByaUxau1Ll7WDX0gl0fOMpCimQC0KxMSTbs6R5ob4C6RDYrEZSCUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925595; c=relaxed/simple;
	bh=KV7VFqSQS0KII5KjQ7Ghs4zycz0+1Tktdwfr+HKmSRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcA9Er6qCpfEH/lKjaimUIPVOYulU/L0Er+N6Jiv/YyAYQL6IEERiiV4tzWcGdGw+BQ7fgKDt4LG3RcSKta0OACl3YfyBzZZTSfxGglGTXu3oq24oPpIaUMG2HsfxI5I3EYiwRTOsX/oXCzF9b8/Zy76vGm1y8kSZpO055Cru2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eA40h/OY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=stG8hh4g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eA40h/OY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="stG8hh4g"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D1F71400167
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 03:19:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 03:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790925592; x=1791011992; bh=mwoukBghqz
	WmFDA4uL5J83aQKZ1yzoOpoTaPMCdER+0=; b=eA40h/OYM/bNL7UynMh10BXf2Y
	4/7ayxDMJICV9rouItn2Gq66eKIMsOSzDvi3QU04dLd9ATFdEHb+IhMjMEV3f50g
	Qwes3jNiZHvxsgwKAGuULkz7YzF7+gPO3rmGcdbmSENg+nTIN1l9JzuhLfEu2/3Q
	L2tmjLlE/iIUDq8kCxj2PqpLpEXlh8RQUwIgsgvTB+/c03g18wkA6butkc3gdRFk
	cvQTvkaK0cXhIAXVPK6qKyl1aIy3PRhff9LjPZQVmhwmDzcpzfNOMGY/XfN87gV3
	G09AC14dmU2xROO8bKSKRpLk4eQOD0v7UBiLAN9LfFKeOLUNYt+LmXB7WygQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790925592; x=1791011992; bh=mwoukBghqzWmFDA4uL5J83aQKZ1yzoOpoTa
	PMCdER+0=; b=stG8hh4giR9CmPz4oxOSRE6YZJIo2ZhHwDGDqmFvcT9FVROOkzA
	vr+XNHDKwDSEhfHBQv65dKILBT8XBNafGBXI/oUcjfDEXxEJeIieXo9xr9ns4WgL
	mWS6V0LQjgLqWJdz9BhQNIlNkpEGn4y8FSxq9FfjKjSXsKeYf5XIIEatA672tSoN
	BJLzjDxWpvhdtAUYPht7xt/BVCvTMz1g2+rSlmT/64WmpLR4OmrgMFZZYEY1wpPv
	5/TjiqIlah8ioYzlH1lcvSc7fFyhvp72nwDlS+Rn66CUic+jDKwLxiCsTQ5a6xwa
	rr4z7WWh/qMdioiZkXcofv5PNa1JgPVKVBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790925592; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:vQ5YDsH1f0dZR1pz8pLV7deqxN7Rn3aXU/yyGUeJhn1ezeT
	7IoJFpo1J8+fURmObHNEAh4y5muMw2l0koazeMD4YHoli/Ozw8iTBPMOFKyD9aO3
	y9ox1Kk49I7EM1ZDZlV1uMfKgYsb5dtjlVwKnoUozE75530bRlZKRhWmAv8YDdpZ
	RjpvK88sU+ANfrf56r+VKcXsH6j2Ipbt7R2sKVG5cxqnGTi3lVrGHK1UCXfDUOsB
	pmoX1/MVtNNHNcav0dwXoEeehd7wK1X2snOtvjWQsAiXJ6bBBaY3h1GBKhwYP5h5
	S3lBhXWGSa//7TLRS8WhOsIrdBOespAvt6E5+5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5fdV3nRIvElT8fXicdBGLTDYs8AY2KjvPNGyArbSu2c=:KV7VFqSQS0KII5KjQ7Ghs4zycz0+1Tktdwfr+HKmSRI=;
X-ME-Sender: <xms:GFu_au9mTsvDYiirWhNPK2FeRNKFkaMsK6Kc8DiTaOwD_mD6Bl1OJg>
    <xme:GFu_akstxP8FxArDW7qAysAQ2_Jt8S4dxlTOVLHdw0XpgDZme4dqQYQ-gAb3v-yrz
    qer6siMU-grFG6hUFvPzMpQI1iHsP3G7_RG5iJGIpCVHAun8GGayq1o>
X-ME-Received: <xmr:GFu_ahqhpSYh37JzvOFK_WjRXZBKIs-b-hlCVtHlcTOCt3SF2enAkQ>
X-ME-Proxy-Cause: dmFkZTEukxZF5QZ5MxW1jFkbFdOMivy08vNZIXtjzfFniRrhKe57ukWLoyQu//NdmPYj+y
    45RXcCtHQ1JKZKtFE3uMP1ppQzMSlxazQANFiir32TVMyNnrDMAWCwDE3ieRZ1x0hZrm/y
    R26k2XSW6TsUtoxxF7HDaOquuXTYzzjRJ4Qq2g9QBSMSr5IcnrjTyvcqwcTrxmmooRGkPd
    EacmTG32cXN276EbNPm+kE+kk1FM+W7SJuGyBAVTE4cvtqRvXEcSIxWvDFtzXfMX69X5Vs
    YOT/Ti1aiOyz5GmKxOGxVbTYFXwlcgRBomRzWwy7G0OMXQX/gQo5+0zb1QNDylQjMtQOkr
    7h1ir+qQCfsfVnlGN1qMSw0XNqioPKHfiFOw5M0UjPyPGV9p6CM80Nww1MBVuhv3BQNGEW
    p0n1TisbcuPFGVCjMfqS/GEibwMtcqTA2cg0NS18mOEDJU0fTpFRRYVhnYjqQJ99aQzK/K
    EV1/yCWQ0vYwGLYdxHetyw75LJB0nO7LVFzjJBXfXxeJ00/zh+O5XVsBczrmvDZvwzApmm
    ZG06/GJODKCRDDXhr0WA1m+CZMDpxVyKKTApcye0ley38QS+47GDQXj4PlNfYMAn67R5/1
    tUzWNjVzM5agsHtGtdiJfPghpej0DmkgC/6rZFDAUanijfFQKGC+3EkOEl+g
X-ME-Proxy: <xmx:GFu_ahk9FXtctho4Fkfy_iKSEEPg0H-10yv9SJCvANx90eleUhgvrw>
    <xmx:GFu_alz3wWfm2sefXyRLmQxemOTSjqgLvMjMS3ubGazH6bKtHnJ1mA>
    <xmx:GFu_apnlOuCzqCifP5tNVEoXhflU3U3dnk4r8MWOGVUwbl4mEEs37w>
    <xmx:GFu_aufq-5VvLccXC8lx5y9fwcprJC9cAoGZXHBACswHevT2qmUGhQ>
    <xmx:GFu_aqWYJBq7vUHVJqKMCuQrEMEK6a11LaMhMfBWIsi-6AgVohZIycWl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 03:19:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58bca26e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 07:19:50 +0000 (UTC)
Date: Fri, 2 Oct 2026 09:19:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] parse-options: fix completion format when first
 option is skipped
Message-ID: <ar9bDza3ImB71AIN@pks.im>
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
 <20261001-b4-pks-parse-options-subcommand-groups-v1-1-01eb2f4a4c32@pks.im>
 <xmqqik3l5njz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik3l5njz.fsf@gitster.g>

On Thu, Oct 01, 2026 at 10:38:08AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "--git-completion-helper" option can be passed to any command or
> > subcommand that uses the parse-options interface. The output it
> > generates is a space-separated list of subcommands or options understood
> > by the command.
> >
> > The format is slightly broken though in the case where the first option
> > is not being printed, like for example a group or a hidden option. In
> > that case, `show_gitcomp()` will of course skip that first entry. But
> > when printing the next option it checks for `opts == original_opts` to
> > verify whether we're printing the first option. The check will evaluate
> > to false though as we have skipped it, and thus we'll print a leading
> > space even though we have printed nothing else yet.
> >
> > Fix that bug by tracking whether we have already printed anything via a
> > local variable.
> 
> Very clearly articulated.  I would have chosen 'shown' as the
> variable name to so do, but 'first' may also be OK.

That's a fair point. We explicitly _don't_ care whether it's the first
entry or not, as that would match the old logic that caused this bug in
the first place. So `shown` is a better name indeed.

Patrick
