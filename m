Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D162DC32E
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129304; cv=none; b=b6i/EiBv9qLvVRewtrLPPHe3B9QMdAoOIxthxftdGw/bpDHKKeOktVbscZ2P8FjrOKbbwQUIm+4BjVBZKfnUvNdzG0+oCf+oky0XMBTSqixVLJ7MPS0yrcdy3AzadbKbkFspje3dy2ugrpd5H5oxloxVynwZfDUbp5FFIu92NUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129304; c=relaxed/simple;
	bh=695qPu/bWL3xq6FIlf/JNkp/RcI2soycV6uHV8RdvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNBb3EMvgb9lSCuni2+QYgg8Pdk/Ft1iNvciKO/Ajdv16wW0WuaEY2eN6XJHD1YmiWEOnCrWnNlZqVinVDnDu+LQtxB/bIwzuTf92fosKcfOTf3i/7qku6bRDq76nAMyYpy69eZbIqduXWRBtEY6fGoMMC70G/QoAtEsQQ1S3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gm9nBF8z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/CyzA1U; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gm9nBF8z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/CyzA1U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5829F1D00137;
	Mon, 22 Jun 2026 07:55:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 22 Jun 2026 07:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782129302; x=1782215702; bh=ZU3+L1b6+d
	O3rMyGbxC5qny2ODV7N43RtfIMOu56nMo=; b=Gm9nBF8zGHn9xspETHzQEZZFLf
	TupR9mTqXhXhJfN/wyVc7hoFaYX5mvmzm8iyMfO81KyG9IJpJbZMjH8GMsFNcV0I
	ZMAbFa6Uf0xVwULuuSzn9lLJpRRATJzHLglAy2/hAd1HMuZCyPzyP1J4xrvhM7/g
	KLBnNOOBmVWFsFRkt8kbr0WrZDO6YPczA8hkU9h66eboJzLlGEd+Y/rsPLqiEy3d
	d+bL4i8Gaso5+gEajSv2+ZIqH4sHz51UGYdXrh82RVDHgLYkaCPYW/lInGXJMDaq
	ChZNQvU4/hXYo2zeKAaTs+hYfFXHawcAovrDa1/BZu3u4UFvJTXYM0iEF1rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782129302; x=1782215702; bh=ZU3+L1b6+dO3rMyGbxC5qny2ODV7N43RtfI
	MOu56nMo=; b=C/CyzA1UCPMa7qaMJGLMtYOWJUffWbg/O+iWPqNdpFFEi0C0jts
	s4PXDOFh6MOnjl8NinsJ00yktv8Xmvegus6Rj2XDvfRPglcbpEExaQ81HNmLJzU7
	W1ZF39tgTtsnIfm/hyZdRvf9Wqp6UTXC3mbQnLoxut3SnwBZICj5CLSDvS8iEPpp
	FLhggq7acjXRgul1DkYFmIQ9W0EInI6uNKe9j23KjuhHVC9U80djmxjZL+Jlih4B
	rKFgOlOeb+M1kxIE21ASZS/380Zo4RdhZH6a3t/onBRsG0AuFKTUjHSG6ded7B2e
	C3XdJGZs49MDdleO6qSANas4ia2w4dXJaAQ==
X-ME-Sender: <xms:lSI5ashaNNqM0gnbEQM3ETzB2kB5fGl-sQZLvWCrT0-zO2zL8ddUDg>
    <xme:lSI5asdODMRLOrnGS00QTatu1G0IuA83qmVyb01IL7NoBJLvjxQ0LkhLAzjNaUmRv
    hp_iNilmcXGWn5keOP9gEgVeTF1ghTKB-rNZI8RkBJUm_kf9EZE5Q>
X-ME-Received: <xmr:lSI5ahdd9u2Od3PLhG8IfhCcA_M9JSYDIZjqFpEyGqxEdbudiw-2ZLpLvDrUOCoXBAiCUEcKGmYUUuYk09r1dqkV7PBYx85thBU52QFyvA>
X-ME-Proxy-Cause: dmFkZTEGwYAlECQbTBnQKZqYr9qjvBG5XMNyGqZpwBmrICceJ196IyoUBFMXFc6P7yRZgy
    QKbGSRZmkXWbQur3341K31v71ea0I7eAjG6lFizwa0VAe+YYajrcwG8GJBTTULwJV5JKCx
    qTfUFl6taujYjrAGFZ3RjASXps7+MK+3HQ1G5CB5/tCKDWNysNL5TNdeSQrr7IIlBcGSIN
    k9G7uw2/kvJK3V0CpvBWu4UHjaRSKUDy98K7olwYyS66nQFd704afCg/vu75MqiG1k2BCa
    ntTWc/RRYLN2C6GIp0333lexANm+rO2oCmVuk4QaJaAe/wGgJU1N0l2uzsp07NQIVp4oc1
    OtBNdvjzJFw58++FZ7BqTIfZ/vElfvguV2/LCflcpVgm40B1Kdj9YKzNwza0ET0VOUADxu
    qWsLcluYRpg4Qw4SB8xGxBWaZ5CXc8V5JcLcSgxBG299r3b+rG/cLE45x1HORkDTZJd8sv
    zXtr4c7d9KO5K99qrsjqpKamMJG3WAnYwf11veD4qKNdsRapab3/G+dVAfyG8V/NQa1qja
    YIVv8+JGsiide6xa3RwHFU6oN5mGlMZPhwklF4EM0Y1OGfVcKCZszzoG6qppI3ejY624bE
    XcmUY/G3GArH5DK7kUDqwB+mzgB372pK7wATmcxsf80j5opFMZZk7KIglI/Q
X-ME-Proxy: <xmx:lSI5am_QhlVWo8YsXv9kEU10KQzifx_jGgBfL6u2HZDSTfl-Nk_pcw>
    <xmx:lSI5atn0X1wrLSlwdoe48bA_u6DYg-ffjhCHerZnWZsBrhixajgyOA>
    <xmx:lSI5ao-3c3vEsd6ggpYmgyP-ZU_QaehOL4Rhj26GcuZhjKkmJlW4iQ>
    <xmx:lSI5armr1i5Tp9JCGOYrIZIWhKKOojmDaQmTsN-STfTeUy58EnHo8Q>
    <xmx:liI5an57rcAIhVqtqs0puTGUg9EzB2lkwH7aEcByBR7YJo4HUzEUBWLX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 07:55:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b869cbbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 11:54:57 +0000 (UTC)
Date: Mon, 22 Jun 2026 13:54:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 0/4] history: add squash subcommand to fold a range
Message-ID: <ajkijomPo_kXSXul@pks.im>
References: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
 <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>

On Sun, Jun 21, 2026 at 05:53:11AM +0000, Harald Nordgren via GitGitGadget wrote:
> Adds git history squash <revision-range> to fold a range of commits.
> 
> Changes in v4:
> 
>  * git history squash now detects when another ref points at a commit inside
>    the range being folded and refuses, with an advice.historyUpdateRefs hint
>    to use --update-refs=head.
>  * A merge inside the range is folded fine as long as the range has a single
>    base; a range with merge commit at the tip or base also folds correctly.
>    Only a range with more than one base is rejected.

Some of the conceptual questions on v3 are still open, like for example
whether we should be using "--ancestry=". Please make sure that you are
replying to questions like that when rerolling, especially when you
don't plan to address them. Otherwise the reviewer will not know why you
didn't take feedback into account. See also the thread at [1] for
guidance.

I'll wait for open questions to be addressed before reviewing this (or
any subsequent) version.

Thanks!

Patrick

[1]: <xmqqv7bhxiby.fsf@gitster.g>
