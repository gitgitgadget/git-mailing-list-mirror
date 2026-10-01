Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01735C193
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860569; cv=none; b=mAsxBQ1RIr9uJn+is7ycC/KuHhaOhzToPKbyruLwcZA/+oWr73ua8acRx3k2ONmBN+CxWRM64wdH8Pqs6UViD54a/opQkPV640pjBxm/dqguGjIEWZPfzv+HoVMY5r0GjY+kjwdT1L3kGR8bPRlmkYQP7FvIr53h+0rKyG1RH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860569; c=relaxed/simple;
	bh=D9VL3sy2eWAGPDHLeuLvZJuO2e9DB82Ohp87lQlG8Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l33wbKZbzBI6ZJaTjZmpVF/K4RIftnj6lVkQbjElqQ2DgD3HSzVQJnKnF1kFN3v3059gajVG3kOQkEUf6MiSan+io6WllLOnvQBSXhBfpKxKQtVi3x2OV1sVY4tI0cesHSLwDKtKKBVJOtXHeH0yBQbS5DAvjwP+UTSy1RBEXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=murFN/P7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IY6bOFp0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="murFN/P7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IY6bOFp0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5495FEC01DA
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 09:16:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 01 Oct 2026 09:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790860567; x=1790946967; bh=GtkwRI1t0N
	pBUA0ts01Up11tMXmhH8EQMsc6mACVAPY=; b=murFN/P7D4oAKTo+MoOsuyfRjh
	FPIHF1z9gKIVw7vyB8x1nXELEdKCGRz1+F32GwWAKjoshovmkmpppenAqPHaRuB+
	PiH8hCKvSZoraI9UVaTdb7e46tCe6yLHh5T15QGyaKLDNOwxpONEP5hoBDlXtsSm
	7jtqKnB+jiE3sUVaEulasc8sd0xbF57GVg3uI2+ZaxHshRCc/Te5P9xYmdqVqGKq
	6571VK/Oak0NTw+9kKk6avXWix/ZTQ0R7/aIvRMhxiyDG/j313L3Gr7ICl4DLkWE
	k91lNZ+YHoANmRytjwTrxcOZFsJy7+l9ceGQGH3aKD3nb0zWmnldGUkubw7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790860567; x=1790946967; bh=GtkwRI1t0NpBUA0ts01Up11tMXmhH8EQMsc
	6mACVAPY=; b=IY6bOFp0i3ok7C14GTG3XrJzB4cGu09Uhk4vYcFrpp0tIKZXCTp
	JtabfeIFEJ1sN/GcDhhJw9JWdSKr4a5CeArJTqdUx1SaMiLwtiyTvjsArS6552ZG
	0FDggqMND8VdbtniFl/hjAagyz8lId4bXwemUYyr9f7eDR6MhuY8DzevKkeYbYhe
	gGyk51CvydgL4w4WAFPyed0StZaADxfytU2xJ7QC2xmhp9rGXYWPMYIQvW2ovNgO
	fl4NSKV0Jv6iZG8mYhskPgXb/ElYGl+NORPrfMKkudOkmlLBsWlLnZWJy9HuMlth
	mck68kVs5JvmgsUSDqe4F7A0AlVMj8GdiPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790860567; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:C+COczGQ4FI5kAOkCQQt86GzhB+dO1NRdYNAiJbT9M5I/5Q
	CGIv8e2LJ1Kb/XkEOycy0AsSYOWh6T8LsJB73QDUyuoKr23aIpxcn+FC/fCBAD6I
	GWF7BYpo30XnjvehURTgaE6qn0kjZgbvjawdmWYNxfKn5G0TSSEUAsaxw8CHlfnv
	HV8iez+O45IJBIGL5lgv4y5BOOqwI01eVoqpXrD6kdlcuG/i6IVEfTZifwZRtW6c
	4Sem3gZpvZbY1p5MGylcfxMzenOqn7ukCDzEzzhIQYL1emJge++ENhCtYKBwRe5b
	msE96xJVMS6ki2ymJSB9oR5KWRmjoiT5ZtsbhEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lVYwDxAra4YyGyjExhCK5EYl564Gshc3biLU9EXbZn4=:D9VL3sy2eWAGPDHLeuLvZJuO2e9DB82Ohp87lQlG8Ss=;
X-ME-Sender: <xms:F12-asoo8Cay0RymCX5m9GpDE6WpBui97cR8JvNl8amu0dgB_aeInA>
    <xme:F12-apqaTYJ8wbJDDMlFMyC03Dp3mLPy61hsjt8Ol06fha32XaJ0yG4s3_pVcczPz
    7tt73aRn7tHDhETHffXM6IAc1Ruc_RMdbSaUqWJ16HTEg1gD59Od_Y>
X-ME-Received: <xmr:F12-amM907PgCEIKcpnAKLYP9XX4bdDTCVHizjB1Svc73vexjIqMOo6NrBBG0ljrsnhqMA>
X-ME-Proxy-Cause: dmFkZTE8Qi0PkpmTe3iCifH5UvlqOSJ8HtiOaly746YqDXjzm61MqkjtD3CJpuLDl80o34
    k8/Y7iIcZLNVDztJUUgUC4ddAH2gdmXN4E2Wh0gW7qSH0AkaE1x1OFjtaA4Q87T8z8Czmt
    mN9KbgIGZa34ZCvImJqxizxnu6oMrh6E/1O5yRyWFB4Nq4EbacpHTMMEXfGk2CpWAGTsHg
    FsrkCjk8nI47vi9nEtYcg0rolbl5nurX3s1P4wRNuf5mxVCcsocpcou0b8pdW+B41e8u/D
    6upWnBoz3zppkvGFhl83K3Hs3KX06PSKouWDhfkbqHYgQPjdk1umfvlizPku08egK9yHkU
    pIU8NFsoawNhwgQPdP0CsQaXP6qnqyE0C/qtygChbSoNxytub619Jo9M0R3s283VMT1YBy
    rT97F8jUvEOi1RpPG5iScPOK27mLmO22x2FsbEhv4qERiUdcof4h0/tTUV9P1m1a14uhya
    EWnf4zSgCrrVTkuhaj/lnHK1lTuJOKnDjQCAgLEq5ExDeOuuvVtGJrtRKUiu0fRMifIk1q
    REXMjOLjVDpN7DPxScaqTL6xthkbOwNbd6s4Q3QyIps3emASNb9W5A7Xp31dDoqF3EwW6c
    BwT7mZJ38iXCx8bqOl3KY4P+c3UHj/N2CIPAhkHy1M4DfBEDtN183YND+6CQ
X-ME-Proxy: <xmx:F12-aiwjfKSjyKUV6d8nR-inrlSy8YbD9mJBv01KEhc0ieLnpAtApg>
    <xmx:F12-anu3RdJDIQycFNlKpJw8m9K6J41H8W98Oy2k6jZFidzpaKrAtQ>
    <xmx:F12-aj7vgUjLlX5KjpK0JUFRIdk6WD2TV-Lau3NMgtKkc82IMbCUrw>
    <xmx:F12-auSkV3UGRfBj6PyvhFNql-7e4yEmHSao6ibJ6UycDPeZif5Axg>
    <xmx:F12-asJ_vWS-v53mCbIgWm3sxUWAYRcIneF_5cC2Gh_UWSqBA3p3gh6G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 09:16:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61009d36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 13:15:59 +0000 (UTC)
Date: Thu, 1 Oct 2026 15:15:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 5/7] merge-ll: use read_mmfile() to read external
 merge results
Message-ID: <ar5dDe02hgodgOHS@pks.im>
References: <20260930234348.GA1340390@coredump.intra.peff.net>
 <20260930234416.GE1347555@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930234416.GE1347555@coredump.intra.peff.net>

On Wed, Sep 30, 2026 at 07:44:16PM -0400, Jeff King wrote:
> After running an external merge driver, ll_ext_merge() reads the result
> back from a temporary file. We can do the same thing with much less code
> by using read_mmfile().
> 
> There are also two behavior improvements.
> 
> One, read_mmfile() correctly uses xsize_t() to detect the case when we'd
> truncate the result.
> 
> And two, read_mmfile() will report errors to stderr if it can't read the
> file (whereas the existing code silently returned NULL). I think most
> callers would have said _something_ in this case like "failed to execute
> merge" (from merge-ort), but more specifics are probably helpful (e.g.,
> to distinguish a random system error from a badly configured merge
> driver).

Okay. Those code paths would now print two error messages, but that's
probably fine.

Patrick
