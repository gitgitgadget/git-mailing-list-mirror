Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BC3A382F
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374702; cv=none; b=unYlqynD4/XztD7Km25MK+Jt6QuzwH7DUMuzjin4Fi6EwQf93Tk77S1pIH3sdgdBRq1STpns/rbl/akTb7GDkDmPECvRf+IOaB18WJgdSJIcEQ5ln81ToFtpLBDPQHDGsoM8ZDE2pOxlw29vROG/GlyJHwLTjrZ4A0bKYzwxRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374702; c=relaxed/simple;
	bh=X9QsRCCZeaUb9WwP6kof8LNO7uBZFWtalE531JZfG/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GraTagUutPzUB36qC+KyCPYJ5g95W0Fl9JxN+GOcYWSFrfzci4Jf/s42DIPWDJOcnIXkt1Rnz4gdri49eSvTWphnPZ+AvI3sbRU5koqjo37KfXvvuvTTpjQSGuCckVZw4lNfwYoD4hFzUUfTYG8CQZBKHYitn/YHeNrPyUEzals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZPUKpjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezqd4aQa; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZPUKpjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezqd4aQa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CA10FEC019E;
	Mon, 10 Aug 2026 11:11:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786374699; x=1786461099; bh=gwiFjurTrD
	wqOb08tVCnqZToGmp7sJHJD+74gHOPMU0=; b=bZPUKpjSs/kUVRW24Nt2bj1cuF
	Fgq8WYxzULW1jHC6AvT8crzQKo5b4y/+Pz1rbg61ZX2JKrbZZuvX7S3ZTSh41my5
	BJFqQzlibvSuAkhBMBHAtJwxwN/dFMuYZFI+OopXBsMXbzlPZK1zIFwHyVbLnpSG
	m0oXf+yD5v2OZC55oKVSAgei/AHsFb5Athx0d2ufZyylKKnyQ5XEHNMSAO09H7lb
	9GNZ5V3SyALvLEh+GTNGSXQP1FKGLduUaj0Q37BrwxjLZ1EvvRNAw2RgjDlnAHxn
	U5s5lcmjNXri++6AnXSZ7LFw+g6jWVJKbtaff1PK0LNbFXCuEi8Uct9ftkoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786374699; x=1786461099; bh=gwiFjurTrDwqOb08tVCnqZToGmp7sJHJD+7
	4gHOPMU0=; b=ezqd4aQaVyGZmQ+b/z72TggRzJeVtzHEbCsGW88KB8mtatkBn7a
	LyAR6NVlSdQ4SATHWHnWwgyv+A+yEXiq5FxAhm3DAagSLwa7bB8cJIPVDXVFLqCw
	S3mdHBkBjukHiddcEI6ZvGMOK41joxgCzKW6jXXGhWxzrdAHe/4BbAbEU/5O6wNd
	Z2YrqkWt3+BDvQ74KffA5CoPn2NE0GyWd1shDd/8t7+kaWT/2Z3YlS4JtwEDCMM3
	VG8a4yO5/NKuC/1Xgs9POL3z4l964dXcViNkJ5nzGo34iV9TV8JR+F49g+TTXgyW
	7QNd/vdQSdEXOZFj49Ss9FJ966YGTG2wJyA==
X-ME-Sender: <xms:K-p5auhmx2KTDxZlMM8b1BjYXXOndI17IQeBXKcHDxvNH7SAg_xayA>
    <xme:K-p5al4naF6BV6ntdQ5jaTw4k0_JZcPxSKqd3nzIswwiMu2W2gZInbVCa-GZG5fRA
    M5Y3tO-YrrLcnUr1nzAS5GnvRvHHH-gkw5XBrlqZp3DVxABpL1Yw_0>
X-ME-Received: <xmr:K-p5aubJcTceImgA5ONC6P8wCRQO4O0KyPTXh5u98nCWkk2GF-L27kEuEV2DreaMJ4KptRG1JLeq8YAGAnkPXW5LKf_mu_dHc_qaPHuieQ>
X-ME-Proxy-Cause: dmFkZTENwoEEX3lR1X/rozXJxEm0dGf8Nn722kGavEfmdVJIiu+0zIijtgFzLWojXvtpbc
    iyXjpyrfY8NEBuhkeD3E8xqYGMpLmM6bt6ie/pxxonLZsNak+fO5BF19gWAjY24nIG8Iv8
    YAK3pf6VUmwfXyZBb6bMdmX5TTTOEgUln39v03vY+PmzDpxVzaO0VEw+84m0CpiMBKXsuP
    hpFdR/EZ+7pXPB5pq893RlUguR4tRsBJX6wrW16R6gyaJivaRZ9sn5vVVOAIJvVZkEAwIU
    w7cutco4Vfabea/qR1SYuyfsMU2GadDFRc1s4iwbQf0TxLZ3BPmoV8JjkcYN6HQQ6Wv0Qm
    K3nvPlXEzUjnj/8lqk3CNrkET8o8KBtisCMaB588iOj7P4pO76lTVLPdDASvA+Xk4CZiux
    KV4BuaNl/JstTKT+YUk8KsjcNRgKOIIQ7/wytkjmZyEfkNDNsLVJLvOy2Ep26YRfiRgIeg
    Ett6t8jqBa2/UFDq4d17SxUbBfTJZ+tlI6eXd84XXOoi8pUYJjWOaFXmQ6d3rs+R29jZWm
    3KyBEkt3h0jx8aH+ij+utOmLck6Py/6cjppgU4iIIMX0+VKoqvMXsM94QllDi74C9u4VcL
    vXAU552OoZeBsA8fa+pSSWxdLrIrprFCGrOXIlMfsr//7PRp2HspI626pReg
X-ME-Proxy: <xmx:K-p5ai7FgPDvdFweRQe37CDfASd7ztx4CrzFF9KkO6VyQnpa2V171Q>
    <xmx:K-p5apAFefdYJh0vm0MBjMVIhja2-uLUe9eVXLURVjObLnRY1vncpQ>
    <xmx:K-p5agcYQx6MGhG6tMALPowHVS4mnwh0RWPkWww_27KFivyo4mzb8g>
    <xmx:K-p5agLN1LgF-0NSqIbkb0S7uaxpsFwxqiJQSrOL9fxXqkJrwHRydQ>
    <xmx:K-p5anZsFWjeZ7rZqQrWrFQFW4f8M_6cM0c0dzPwBetqT9AVvFu7DW0v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 11:11:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef9cb71f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 15:11:35 +0000 (UTC)
Date: Mon, 10 Aug 2026 17:11:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 1/2] maintenance: account for promisor pack geometry
Message-ID: <annqJGFJPviEyfEC@pks.im>
References: <cover.1785902237.git.ttaylorr@openai.com>
 <a9de123b43efb58c53c99c71eb7e34f29e075071.1785902237.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9de123b43efb58c53c99c71eb7e34f29e075071.1785902237.git.ttaylorr@openai.com>

On Tue, Aug 04, 2026 at 08:57:40PM -0700, Taylor Blau wrote:
> Commit 9bc151850c (builtin/maintenance: introduce
> "geometric-repack" task, 2025-10-24) added a new maintenance task to
> perform either a geometric repack, or an all-into-one repack if the
> geometric repack would itself produce a single pack.
> 
> Some time later, commit dcc9c7ef47 (builtin/repack: handle promisor
> packs with geometric repacking, 2026-01-05) taught the geometric
> repacking machinery to separate promisor packs from ordinary ones, but
> did not update the maintenance task accordingly.
> 
> As a consequence, the geometric-repack maintenance task only considers
> the non-promisor pack progression. It falls back to all-into-one
> whenever a geometric repack would roll up all non-promisor packs into a
> single pack, even if the promisor progression would keep a large pack
> and roll up only smaller ones.
> 
> Check both progressions before choosing the repack mode. If either
> leaves a pack above its split, geometric repack still avoids rewriting
> that pack, whereas the all-into-one fallback would rewrite it. Use the
> fallback only when neither progression leaves a pack behind. That
> preserves the reason for the fallback: let the all-into-one repack
> handle unreachable objects when it is not rewriting more packs than the
> geometric repack.

Okay. The consequence of the status quo could be that we perform an
all-into-one repack more frequent than really desired because the set of
non-promised packs is small, and thus even writing a small set of new
objects could cause a full repack.

This might create the reverse situation though, where we don't perform
the all-into-one repack at all anymore. We could come up with a clever
solution here, like for example considering both sequences together and
repacking when we cross a certain combined threshold. But I'm not sure
it's worth it for now, and we can still evolve the strategy as needed.

Patrick
