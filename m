Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438A3B27DB
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815522; cv=none; b=FS3a4MFopagR5yFMENfMJGPP5kGCPV2pjYhLRd/NX5kj5eYrJ4P1fb1tD3hMvjots6vP/2x439oQmlGjX2PIY4Q3UGAOPA8A1Xf9ZrJZcKl4kds4n0KS6p87hhStYN1oJQFhKmUWloAIaMMWeuBS9Y8SBf99feDxvnDTYhPhU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815522; c=relaxed/simple;
	bh=+NFSPYb7GCGg9KX4+9WcA6V1Df7Bt7fRObsz2j9QCzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQLd8bQEKRJMLPK1UzXEhsvNz3nKTvSxNs11v0MzxJsS6TVB7w+Nzhwy2I8pt1Ubjww8CpWqDwQ385TpENGxqarYk/bFcpUdsEip9PoKPW5+7YHNPajOlaZqkBRTCU2gcO/6VjqZQTyHfsJj3sT1qqbebpwtIS2hyTdO1sbc3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gAQcIu/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mw409zUF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gAQcIu/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mw409zUF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C7CE7A0084;
	Tue, 30 Jun 2026 06:32:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 30 Jun 2026 06:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782815520; x=1782901920; bh=Gj3lSFGHq3
	2Lhk3EA23ZovARDpvnLvrfkdVAdk8MKTM=; b=gAQcIu/xnoUboT8QVsxoNVgcNI
	WxtUK+rsYg79+JywcKkOjI9gfO/i4tli2FFQvgZdIeTCvPjFFWhuczCO63uFEZH2
	P1ue/3t7yOx3tZG6NJh+cSAFjUEWFwzIdXuyP3+lM2bZBQsSqtRs8fGoWZDPM3A/
	bNRE7oCDgxDbO61swOFdrUIXUYWeBDlTKUJoWHveD3H+25nR+0ZKdWHpwTNnsR00
	GUJqvhnkmpzyPDmYsJdzHRXl6nyVtnItnAjWAJJbMu9iNnEEke0wjGtL0HUsw8ko
	ajBXBB1QV4wgU46h/MM2oWhyO93AyO2zx8iOn3fkY6E4C1dOj9zJjeZuwNjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782815520; x=1782901920; bh=Gj3lSFGHq32Lhk3EA23ZovARDpvnLvrfkdV
	Adk8MKTM=; b=Mw409zUF28iB3O5MrSD0vgMQwHoRUd0ZJdMXuRDlYbKiH09qzfy
	qM5v/WU+6U0nZvrkcz08PwVcGyzDI2ZJ+6LQUgEqB0RLEZvI93Zm6eHDJAHUIhn7
	QBW2pSEPARQHdM/iOWbTla+bDtmqDtQLxMcG6+LW7TeVBfMT2RRz12m82j3MrDNm
	Gp7yBNAHZYpzXnpHAbTusWTdLR2w10VOoh53ypf2Af7jVUtzk1CeSTE4DZgcXjSc
	3vir0NuH1N2DqS/mukHJVN5+daMFLo6U6m5nSFsa5E7dD/zIu+FIsuW6ieLFCKXf
	xU1shiJRa2z+R/KKnuS0Yh47NzJBzQE4QrA==
X-ME-Sender: <xms:IJtDagXqAQK3KaOpHIOpkDdfR9DPRW64eTorD6aB28q7tpW22JSICg>
    <xme:IJtDaqnBQH5Dx00RnFv0m8lpSKw1UURYDvMmflxcsKxb6LAjhhhReca2_KNR5XJL4
    HUU_RKZ1u0dEAX-TSLgxssZgoq1sytHJikDjKSJ4pYhArQZsZ60Kg>
X-ME-Received: <xmr:IJtDaiBBpTkNR_MvDYecuDvpyYmv2Goze0ljDPnvv5FAptmSgQP6_u00uSpTaSKnDKS4J8yWXzjoW8mrQJJ5saufME-Cq3k7CpGq-oHvvCgl1Q>
X-ME-Proxy-Cause: dmFkZTFT694vMIDm61ohh8Zp1IfwkpSkeYY6U1ud2HT3x6PcfY3XCSl6P9yJE2dhYuStdJ
    7eDdyXmKPf00Ru3IUf4ehgO74cV9iAFkmIVjbcs9zc5es2NjxfOepxTcB7Mk5mdKChDQAF
    0dEv525YNYQoO3haqPf2ASvxOeFNfF1MhDEpDmyDc8V/OiMNbBpfU3XVQwtjBGaj1KL4Z8
    O8Jg+kKVq5sudOnksdWpOkV2PaWPhuJJNpI1rzZG1E4FZM0EATy9qg9ShaXznRCu49CT25
    VOcdxIbuJYT9dg2BFiF2ybKRclJ0nGsDNz+iT/iH/oggGUJHkFPjzlTjmcB3AXJl1WipWz
    DhvzJpWSf7Y8zTjgso7yCaxuqjlqrRqKSa4nvZ38eQL8bO4go/xmo8BXbhqqqj+RXqD5az
    RXgUYUiK/qTdJjFxkEAShirASqq2CCSHTxaSRMCf+saqrLnn9P0GBOQi0UqKVdkYD6ioDp
    tqAZmfZuTtJtNI4sICRYS9jz8JtQSFGLmIlfMTyB0ObjTp7fE9gHmOArVRofXcHVwaO9gv
    NeeUYiBAKv/zYDkkZAjx4sUAcPbwE+IK30QH93t58fk3h6rr9H1vyHqMfyTHqfUqQd5JrE
    TJ62LzX7RuNyAM7kUP/gXQJxX5VESWqflU/BsNp3YQdb+3ORvKm05S7PGh/A
X-ME-Proxy: <xmx:IJtDaqfDOfUOCCfS46rvY_RC7PW0FPVBMIz8yuZakqoWzY07_ur8sg>
    <xmx:IJtDatLVGmn9kQ7J5t7JIHi2lCvBke0RhaZVlAWlSuqG6HQ_ur4llw>
    <xmx:IJtDateht7M7RHrfqqm1in2EdpliKSXfihxCc2TdcPo74jeguIBZUg>
    <xmx:IJtDak3FXwC5HkcdofNJidfUwa6fg0cvOVy0cCEaOn3-ZQSqP_uciw>
    <xmx:IJtDarteNWit-irlQwFDDZvN46kzmEEJ2jUE5DuYuPHlf2dmMKPolo_D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 06:31:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f12c74f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 10:31:57 +0000 (UTC)
Date: Tue, 30 Jun 2026 12:31:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] builtin/refs: add ability to write references
Message-ID: <akObGuYnEwE2Pgxb@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
 <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
 <xmqqik71ul0j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik71ul0j.fsf@gitster.g>

On Mon, Jun 29, 2026 at 01:52:44PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Reference-related functionality in Git is currently spread across many
> > different commands: git-update-ref(1), git-for-each-ref(1),
> > git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
> > hard for users to discover what functionality we have available to work
> > with references.
> >
> > We have thus started to consolidate this functionality into git-refs(1),
> > which is a toolbox of everything related to references. Until now, the
> > command doesn't handle functionality of git-update-ref(1).
> 
> This unfortunately hasn't heard any responses since June 17th, so I
> took a look at it again myself.  All the things we discussed during
> the review of the initial round has been addressed, it seems.
> 
> Shall we mark the topic ready for 'next' now?

Let me send one last reroll to fix the typo you pointed out. But other
than that I think this should be ready.

Thanks!

Patrick
