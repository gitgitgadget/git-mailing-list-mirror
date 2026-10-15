Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE63EC831
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043034; cv=none; b=JSgHjN0b+oScNgUdBDbkxR6D4sAmQf7dxUJjrG8io2JfZRh6fnwubcfyKRuHNoi6KQX+TbgVRPUvqSynY1jkY526ycHOQXQ5VI2NWHeS1oJGnCRBM7y8GYxPjrjWX8vir64n9O190bI++Uk5kxMseLyi8P9e0w2Xd9nefT81338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043034; c=relaxed/simple;
	bh=8iRlF0v4LixwKyHAz6pvtqGjF0SvDag+hwW/nC+/b8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkgpWwOdcFPx1eDFMJHjZz0lzUnGFKzLEwem//ygAHUAABPS6k4f705PV6b1kc5j1RLCTkXpBFFrGfAUYRJnIM19f+OCVanDKQUYLJUp/UbZwijfQeQkfpconyuy0YkQnSDWeq4VttJfF62DrS35JIppk4J5LXugqnONMKEDMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lI0udxTx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgPVj9oB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lI0udxTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgPVj9oB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D36CE7A0182
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:43:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 01:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792043032; x=1792129432; bh=M7mnECv7ZB
	DLCZ7Ga7hT+tUn/kDudvO9t/v32kekE+I=; b=lI0udxTx03mgrWLEjHCbNo7IqC
	Qfr3GUskIlUZpZ4M0Wx6g1s/CCx9qlW4uPPehaM/CZAI2vv25kWSdpBiHpkZviaJ
	xxLot5rU22oFfz8kKbCpSHsffL8RVH3fD6Gn0ogXC1oWGmB0/7b6v3051uOaPtE2
	WaIUnFnL8WuAjYnu/CvVU+Ha69lZRBXh4+4QXGiVSF4j7AoqW3R0qXou8D0u761e
	UZPkpuFdDJNK7vIxucuorUa9VNtjp0ygTZdZGVwmoTJx66ENHXdnekpH6PWL1pGj
	+Z9hWSjH54dY+UdRtk0HWIFmSfFwVHh3KURn56mDirAAqyehJ0WwMZ2Tfj4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792043032; x=1792129432; bh=M7mnECv7ZBDLCZ7Ga7hT+tUn/kDudvO9t/v
	32kekE+I=; b=NgPVj9oBx2bZYAaR6soz2gDlvB9N3EwoLg9dRTahSYNMLEa8YJf
	9qqD4b/PvqhWkbPBpEy8o9vdMhbG0OFellxXr6Qot2zQEFssb7wtcY4aADRdDVOE
	vAIXpzyhmSpHt8p+OPDIIPdpgKmNqvbzS8WboMrOn+B4BPiXSeQhBdbFFN+2HWgl
	6VWHUZCNCVcpRYtU0kl0QzNK11x1CcyXeaSpIC+A4J67aTxusJOG5Zmz+Bjzj7Wn
	gW6e0ALXygWDwjbDCYvi4PQ70O919Qk1EkpAVQgpsJXIt/V7uDlLIo47STj3cDNs
	pPC1T67m80OUStY57IR79YOI16w1+eCpjmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792043032; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rOQ2LD3upOXF6xegcLrSVxfKC4Aq3CIf/FoFXz2uBON7GqZ
	nCzj96ov9oRuNJhs6FpHdFquIuosOoRpb9DcWvnc1SwvF0tP4FoJC7EaFbZh4tM0
	OlH3VQ+W6HnAJjB/gI+RToS7rylERXEg+cYYBdm5i9mKhP6GuzOng38AEhQ6HlcI
	gVemOizkJToZ70fBPDVwLkpJicj1onjrWQYev6iu32zqzq/FyQL+TuXe0XV0ot5z
	B/jelK0xm3TMEXXxGZ70Tk85vZx0pKAZmu2Wh5MwUKZRZug4RroIMrWgk/EZXzjb
	rjW9Ty3kLWeMw9/Ei6/QbGZUiPovwELNMY0NcYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WpYUN19yfn1PyEvMX99BJztT6CFjxddbXQaK6OaGA+c=:8iRlF0v4LixwKyHAz6pvtqGjF0SvDag+hwW/nC+/b8k=;
X-ME-Sender: <xms:GGjQakgNzXqgCumEupKmkiHypc5VXEDxMtXWoVjHn01l33VG03WlzA>
    <xme:GGjQaojqr9SiBBHsOhkKdoyceV_gnLlXmJjCddtOhH21VpWW6EYEdigx-pFW-11lQ
    oK1kaQJXxOpRSgMP1Km7f5scET_yCv0L5qWRN6KDL-j-Q2dQlaR>
X-ME-Received: <xmr:GGjQaig2nkYWJK3BbEczdnROlEeU3rikoeJ0yGbEqUWi2ifj1o92D-8Cb5kL6V3Q_Yp8g4E>
X-ME-Proxy-Cause: dmFkZTE2UUk8eXrbAhmNzhH2Thl9d7VvQGGHsdhLkltInzkiIK2LvZLi0vtfkqyO42ICDb
    PUsVmzrbDMbVIo/vyovC4rQcxvHrP9Q2lDjAB0DKOeMelwem1CQYBTu8DRkO5adX+o6Kno
    ueQCvbX3VsyPaFBmvms1JgcjF6IPXrsAh+TAFnsfOJtPyQaSdjFNSw+jMZfAWWrU9ZNMHn
    9JG7c7Mhe5Vu3+I7AHD5rqqW7aPe7Dkr7Bp4cPwB1PZpZ/nUhKPh3QNOlR3mBgCxm2xIgP
    PMPh1BAqaalXkDwpKIM2jIbqT8smWxfu0774KH30b/jWKQcq3/e1ACNCRz2EkpMyLmI5od
    nOtAWQluXjd4nhAc6jv7Q3eAJ+o0sQb2QdWJXXuN/zhuKm8uF3WPtW2nI4jLkgADMLtp+t
    toLhswJkbKPj+DBfJUKh1kQ2gGjlHugV0FLuZTQiyLFBmugPiwH/ABGW811Qu3K+e5CBOV
    g3zd/6HkpidZXyySRA5LgfbbXzlJ4gCCrDFR0g57UjIBSgNyCfpY/566YxjepTwMqwqXFE
    K/KwIGB0k/hEp9uPb/usHXcXRckD2S6nqaCrD7iWgROckMyp5mvuzSY5z1RQG1z/yz0h2T
    t9lkt3yZy7WdSFrKIypSJCd/h7Z5eRo6t7xG22/RYG5r/nJ5nyHsFK3q1yvA
X-ME-Proxy: <xmx:GGjQagK8-gfPoKx-YvXXheX4rS7IqcyKmcTdAnOrJU-iJ25Lin4FIw>
    <xmx:GGjQapEygLwaxwDK97IH-CJ91mmk9uzqmaRm5uZC-gTWOxdycu73SQ>
    <xmx:GGjQasQV6SH87K74Maoy3Sy_v1XH3wCNRjLRNeb0IMtLyObz2bBTKg>
    <xmx:GGjQated7dnw02QX-XdggzuBUWPF1I1CZo-2LOKCsrC9H4AXXACLvA>
    <xmx:GGjQaq9pORGfuUPjde-T-Uwm_iAobxw2k_iH6lGYcPM3jlOkHfwlpB4q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:43:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b2fae21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:43:49 +0000 (UTC)
Date: Thu, 15 Oct 2026 07:43:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/8] ci: some housekeeping and modernizations
Message-ID: <atBoE11OSvlFIKis@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
 <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <xmqqwlrktkzz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlrktkzz.fsf@gitster.g>

On Wed, Oct 14, 2026 at 07:28:00AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Changes in v2:
> 
> This one is v3.

Oops, no idea what happened here. The state I'm in right now with b4 is
somewhat broken. v2 and v3 are almost the same 

> >   - Improve commit messages.
> 
> OK.
> 
> >   - Rework the "linux-reftable" job to be more useful instead of
> >     dropping it.
> 
> Happend in v2, IIRC.
> 
> >   - Rename "linux-exotic" to "linux-feature-testbed".
> 
> This did happen in this v3 iteration.
> 
> This was built on the current master, but I backported to make it
> apply directly on top of v2.56.0 so we could use ot when we need to
> update 'maint' and run CI on it later.

Makes sense. I'll keep the base as-is for now. I assume it's less work
for you this way with a primed rerere cache.

Patrick
