Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B683B14A9
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513875; cv=none; b=YYhhhnvK//nyhVvUA4HpxoAPfcfnl0tv3ZITUhdLevIJEAZ1cjL8DwnB2r+l2zT6Ue+oxSoR1/vVSb+zZ9NKcXH9huKt2mvQcNqxEYj1f7TIZqNuxjoDtN1nv1QCnLgetMyJeB/f0SYHbnchVVTuE+QZ8SOGcOYa6ey0OE8BdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513875; c=relaxed/simple;
	bh=6qmbuSVRR+Efs4zdjwl1pE+Mqy48l+r/rgMUBKyjPFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8Exq6YUfrxJC2XZc4nTCzRv5eEauTrLqSC8SBVbLibFhZQBreHWc8maaaCzKqZmGN2R22NK4x+8Gu0U+xH3vrueW0I+hauqli9reTqBZrnzjf3+pq1BXwdsFnqBH+OvmnqkliC++PEoWjpR3mf0ey+ZmZx7LRVPpXud7BIgz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WzUY/4Mj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wfjfzwj3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WzUY/4Mj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wfjfzwj3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 384BD1D0013A;
	Mon, 15 Jun 2026 04:57:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 04:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781513872; x=1781600272; bh=KccrH5SJza
	qu2sIhTDEqA9mqSkYEZrsyCLnW7bHzGIk=; b=WzUY/4MjbtzNToGP2mNlFJLp1j
	f7fR5En7E3D7pcvSxRPoGbXc5qSEnFq8WIuomSX+dlALFJSbrp8NPHHXw9/deyaI
	jO49cFgIN8aqK1q83oa5tM/VRKMBX4XLlhRieVo922uL9eiPg0T0FOFZG2QkwbHo
	RgKHnM6Nc/7fO4jsjMh66np14vuwj7+EDaV1mVS3Cv8xx8AcO3BdnTC0Nt0kd5Rz
	kSN1ch3sdcwZdkLGnAKqFVWVwIE8TdvIztv0XssbeNV0DE4nUg+ZhWgTxJfnfcJE
	C0zHL2FGTp/m83PM51v7dxTd8Su7z9nB/QdPAG9vMfN8sDrvixYAFxlmk1gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781513872; x=1781600272; bh=KccrH5SJzaqu2sIhTDEqA9mqSkYEZrsyCLn
	W7bHzGIk=; b=Wfjfzwj3XBliX88Z/taUIrJ7GPNd9b+5kTuOrSiVyZrwvLuIPSs
	aN5cr/9vy7+ByiF2AjFiG60QxfFstXMMOATZCzoJry2kQGEkwyoXLZzRX35lC4eQ
	7CaOLt+OooZZTIygQmzkXfCmHMGst3JrP+ADAQmx+yFhYimi1b1H+03PZ6/21hOt
	lEphdN5aUO9zrU8ZeBqwa8vNktpOSVteLZxLlpLMh2QwsOzVOAL/3TKEMcvb/E2F
	LOLq9+WmR9IVPzMgfGOj4T9TUA+wPl+Op1OhEePcyd5BhnyPS0/gbHmvnzkrVUNh
	nDhqTpphCUCa1uZd7jkgALoQoIaylCNzuLQ==
X-ME-Sender: <xms:kL4vag5CEWk020spv96_g_O7mbf9yHzMiJ3eGUYYvHIYJHfd2imFdQ>
    <xme:kL4van5TLR_Vmb8hUNI-V0RjEZL-aaSIoOoG_pPWYQ2znoSzpMc4_kq-bn9Md3qEr
    ZBjSKWC5JwUZnrAmKPBk5mysQl-4N0j8irzIvTZp8gFn2XE33PSSA>
X-ME-Received: <xmr:kL4vatG2wG9Ur7KOJxRiNOQQj2yhkVr8E0KvmXOcoFwyQVsfvT7Cx-Bus2xhXOkyWRXExq7rJ1sDu-zTUeiCXDRAzZAW1jk-LeUYPTbAxQ>
X-ME-Proxy-Cause: dmFkZTGNyJfmyA/LryuH0DZGYV0s/oFiIGBVys2R6A7ziCiWXH4DYNIMS2zVs6M5Tt+1mQ
    vhkF7zdf97LFzrHnmLWuGRFN7weZeK5j02ka5N19EJVb3ivAM7M3jlzcC8EIf5FBflvfYa
    X4fkh1x+keqMhw8H9LdtUm6yOeM68eefQKx/UZDlXG/uNFVbEa0vwAnA9SXdvmh+gL4Mh4
    GSr0pfhpZdUnfkZSLZosq5lbKYCxBCXGASTRYI3bbaixSW/76SotBR7SE3x8ov/T21KsO9
    KdXWJqsNSNCIVb2Qw5aLrubkM/4fW1sFPMy6aUKo4EQLmpNtilNfbiUkyp0/eHKlcFVBpx
    rRaAOCy3xoutVM323LzvXxYHgLEoETMJQ/5Gqz/yKdnMFI3gL42B7W5pIyJvnqhX5xONvg
    YdfP9qdvBrWiYDRfx0lEUPmDUejBpgIeCg/5+nLxAeonv2vLF36kWKQQxihzmWolgC5zMk
    2mRSdi+9Vx/TxXdS326fPVbc4mHoid67/ptwcMR4tsG/7goQDBufsYjOY2CxJ0l5rEmSeT
    P+jopT5pUi/6NqaDmOT5BAJJo/IHcmHRpwamWfVDhm3WX/HokkBOKH0jPVoqTCMm5ehayT
    +A0JYLsJhFlH/ZcvWWmylU6YvZ9ND1AP25dgGmYqrr201QH+mO6Vd6toO97w
X-ME-Proxy: <xmx:kL4vagTm06dzNCiGO651d5-i4OGP0vt73ktFJ9yEkp1ZBGfKO4t9gw>
    <xmx:kL4vamsFV0PteYiuf1yXnoDMynQfnRndfGkHZzJIrV-siq_Wo1sc_w>
    <xmx:kL4vavxbJ0HLRJ6lYiW9TrTnFV0s8bnJ9vDTd8Pc9YoctYvGdvEutw>
    <xmx:kL4vag5FS0rjeQ-i_sIQVrlk5Pp2i6cNSQ2cnS5ZmIzzzS0BKEljTw>
    <xmx:kL4vakRvJiQw4YdJivsDJwYfBFytHcMnPXx2HxX5odFIS7Jumdcg8pWG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:57:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84c7b745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:57:50 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:57:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] update-ref: add --rename option
Message-ID: <ai--jEk23E7RJPnc@pks.im>
References: <xmqqv7brz9ba.fsf@gitster.g>
 <xmqq7bo4n4ge.fsf@gitster.g>
 <aiugat0gvprSX5yr@pks.im>
 <xmqqqzmbhikj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzmbhikj.fsf@gitster.g>

On Fri, Jun 12, 2026 at 08:41:48AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > A slight tangent: this is part of why I really don't like commands that
> > determine their mode via flags: you now have to worry about every
> > combination of flags and whether they even make sense. With subcommands
> > we at least only have to worry about the set of flags that directly
> > apply to that given subcommand.
> >
> > Makes me wonder whether I should have a look at extending git-refs(1)
> > further:
> >
> >     git refs delete <ref> [<oldvalue>]
> >     git refs update <ref> <newvalue> [<oldvalue>]
> >     git refs rename <ref> <oldname> <newname>
> >
> > I always wanted to do this eventually so that we have one top-level
> > command that knows how to do "everything refs".
> 
> That may indeed be a better direction to go, but isn't update-ref
> the "everything refs" command already?

Well, it doesn't handle reading references, which is something that
git-refs(1) already knows to do.

Patrick
