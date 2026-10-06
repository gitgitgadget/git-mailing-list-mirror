Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07A3769E6
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791266349; cv=none; b=lGZfWFefqXQKnPAlN2oWuiy0ssGYer73MIgfMZ8ydL+4WH/QXQTna2QZfthBdSELODpKYDJY6+8jb3VwYSFo4+Rqm2RsVP2V9heU52jsBccrocqDgaF18wBkaANTSPObIjlSxYUI0pzIxWmu27C6dk100Lzm7UnktnT7Gi3hqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791266349; c=relaxed/simple;
	bh=zaV399V7Lh7vSkaw9SIbHgTVA2dmxeSC4MuuUwvUCoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/fd5N5DR7krDAxVVSGqXqwfFbu9Ae2VdME82zi9HirTJyc8qj9NfmF20e9pt8JDNgaao6njVB3ZY8v4266sO6AskkkhvJPejPDIda2EVP4M5EddJqp/Aj6X2rxXB4wG0Jn7zj1S4bORlZOeAzvstvZzuvAFxyjA0pFpl3ltJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lgi9jmbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFXFZ145; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lgi9jmbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFXFZ145"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B57AEC0AC6
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 01:59:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 01:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791266346; x=1791352746; bh=r+ste86LZ4
	qPy46YGlobD0ac5afQVzGhtSc32Iwhv28=; b=Lgi9jmbCa9B9bzKhZ11t4HRjS1
	poh7/+D31er6rmnWck74tFO1uK03pPOQUjbqTWatAf1poQ3WY7c6YI4tOl/DJERX
	f6a8wTx+r8/eiMOixHUr5b4b9VujHxMel8xMsNPiK5x1P/xCQ/UrH8NESCIbrZpA
	00QP1PN9OxmH8DC9ZQMB2aE1jXcXlB/SQ2GmcXTH057VGN4jl2V1g41JaMpn2OWB
	9gct9cEGsB5lCGSYwQiva9fcuZyOBRfKluCUZ9/UerN1Fgaw8F+zdkMiIWhLsxJl
	fe/j18Mhe0ii7MFb80PYTVPvhd/JAFHb0W7AVkYAEXNKWI8lt5fxAEgSlm7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791266346; x=1791352746; bh=r+ste86LZ4qPy46YGlobD0ac5afQVzGhtSc
	32Iwhv28=; b=OFXFZ145K6XbiV/HiF4CZNbSz5MHix5Hwrg3akDiWPURkz5lnOg
	TB9q5x+JNttjGmwm1TPLhkio0J+jVN8cgun7fIEGxyvATlDmNSe/0KxgdZf2v0Lb
	BW/+G6Z/N8eWf8/aPWJpo5kmLpzbkXRK1D1fZyyXi8bwwjMG929DQQIti+jNxVQA
	VHD9gCyGdZHDfPcKLotNN0f0zgPP7a5GL29nxms4OD/DtciT+c06p07aNDtY3Rqk
	eavzbDtolX2O+UPY+K1GmvBcyiAJ6b31330lqkCNYLk3v4Qfhbc0iwKd4vut1Pz8
	Zt6CTTRZsD+xso4CFTCSYJvb9OaZgYS1leg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791266346; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ShfDbonPszbZbnl6SuZFV8N0jGnmwS2KmBPNUvFKBFmBwUw
	OiT2+vAfJB/r7PZrYB2AWXGaa4DaovW0YBbX5OyOfHEhuoRDCiLIKCKrSSh7HTMI
	3Xuq9yhfQUVGxeZ/Ox1D+UG+GpoD1YaPB5k1+s+/dpzxx+iyW1zIeAUzOC44EoOU
	gM4FvyOzJiIvfMqGQ38vbQRLNryZabYg8ZOPy77ppyZa/lSNIPS2lTqmPPEXCZAD
	B8kJzWqxb9glporj1aCMbY8jGHpEkFoPqkE7pRjSENi1Xr5UhQgbxrxlUeEsplcD
	QpsyZoXoSZdXBYX0rzsft9p6/JFBGfEs3H6cIyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:b+jn2CdmxzUIYaBAixBDn6Rm0L8UCBVkp5Kn25NagzU=:zaV399V7Lh7vSkaw9SIbHgTVA2dmxeSC4MuuUwvUCoY=;
X-ME-Sender: <xms:Ko7EaqSIRgXTyXEgDpvIHWJoJzSUSXQJB7A6hhjgnVuUYQSOAQVPWw>
    <xme:Ko7EamxGKjBzKTld1QLFcC6jhe6eliK5Ea8kF9UHVgw1S-GjAYUX3yTGhYaD4WBrF
    Xqz1BIFeCKcDQJMs2oCmyKQzY3EblzNImUkDpwI5l4TEZtBhsb8FHX_>
X-ME-Received: <xmr:Ko7Eas0Rv37S1Sd2Bus7mKkuuEAJZxkaT9_k9sZnEaU8YJ_7SnmnrSb-qE9gC74t6F4s2Q>
X-ME-Proxy-Cause: dmFkZTGDddFa73sywFWyXiv4FYPkbWM//dkeDYoQilWytsNBrZ9J9BO5LW4RH+UR2ELKAs
    I4ejDoFxPEpvpt+qJYn9h/ndShR1anRRBwJXe3CoY5DrbkqDnRprtuQzVp5YsLeUp63xeo
    X2WU5xQCaenWAAu3pyCeTsjpAM9RDHu9+Zvd0JUzRIxRwNIvfHe55NOeQuBedmRapg4HY0
    5tovVb/M7YeTJg6UMYtaYhD6/7nHVdRVQm+qcesFWNmUxnISCII6Sjl5sb66L0qBPU9NZZ
    pnET9fRLN+1b7y6cakcBRduBF22ooamnutlar6SRI1iD2I6OaDdKPBUAAGcSRljCD0gWEr
    eC8fXuIKANHfEp1ljU+F67E6VhVoWOerhlF/a7JiCTE9xeZCyUGdzXV7RJ4i8H514QZCz+
    tXFp6OGa4Vvf3jjzbJ3uPLwD0A1xBbpDcwYUxbbOU8hzSSboOKPgTLre7PG3M6WUclUbRA
    u/x7xv0M83lSz7fYU3kx0ytdmpOpkYm7egKjRctg9lhbEYUYQgJKI0T/DFekGQ6Pms0m8F
    t8vfWoiDu5cXPKDhS4dDMLo22J4alQe+OrYJXTh/T2EfA7riMOeYZMIfYVjay/N6N9ey9m
    LFM0TV5G9XGqQLfBXgDxTvwn9zxZfRf2+buYcaEaEG4XRMB/iEWfsoEhE3Nw
X-ME-Proxy: <xmx:Ko7Eak7QdKnxty--Gsp2uiPFH1WsqwyHsBtEjAmB177mumjYc8_P3Q>
    <xmx:Ko7EavX6C3MhHP89N2x9QYW1YUnv1QqmeW0WDSutGxjwPxz3qnqqsw>
    <xmx:Ko7EajBGBN7zqkOgU18Ktjrmk36wAtrmtkKFCfYzku_yRP_X2wWjKw>
    <xmx:Ko7Eau4VDDvZkAebPFdP4Sp5V7Yweidg28mqS4UB_GRkUcsaYjja2A>
    <xmx:Ko7Ean8F9XPHU8wyJf1MVWGbbSZG4X5PUhNSaISyjzs8LuQsl_UfuMR5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 01:59:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18a9778f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 05:59:04 +0000 (UTC)
Date: Tue, 6 Oct 2026 07:59:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 1/2] Documentation: describe connectivity checking
Message-ID: <asSOJVUTS3BMq6kS@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
 <97c11449aeae924436ba22a00a2545254e988a58.1790600552.git.gitgitgadget@gmail.com>
 <asNY7SfEohsOSf0J@pks.im>
 <xmqqece4j6t4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqece4j6t4.fsf@gitster.g>

On Mon, Oct 05, 2026 at 12:17:27PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> +Full connectivity check
> >> +-----------------------
> >> +
> >> +`check_connected()` (see `connected.c`) normally performs the
> >
> > I'm always a bit hesitant to directly refer to code in our docs. We
> > should either make this documentation part of "connected.c" directly, or
> > we should not refer to code. Otherwise, chances that this documentation
> > grows stale is very high.
> 
> This is totally outside the topic of documentation updates, but it
> makes me wonder if we should pay attention to connectivity roots
> other than refs (like index entries) that we use when we run fsck.

Hmm, I'm not sure. I guess performance of the connectivity check is
typically an issue on the server side only, much less so on the client
side. And the server would of course typically not even have an index
entry at all. Same for reflogs, at least in many setups.

I also wonder whether that'd really speed things up if we add more data
sources. At GitLab we typically have the problem that we have too many
connectivity roots with refs alone, and that is making the whole check
painfully slow in some repositories. So adding more connectivity roots
to it would probably be counterproductive.

Patrick
