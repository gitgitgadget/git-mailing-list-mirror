Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8A1D88A4
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628296; cv=none; b=ngrFo2R5/1VXnPfiBiS4F++D96wjVFC422D/3dsgiHOy4yonDmhXMeR7kyh/z/UeVFnAjqBZw1cJ2V0nTGQphxcTMVhA2SypRUvUuNhWk/k8mYc53YkokWGcVTu/YFmT1a57RgMEos1yMauWYUAqk3Qi5h4y+BGlRMUby4+hafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628296; c=relaxed/simple;
	bh=0KWBlnyXmrITZ/fNJvol90MhAdgEfFaFk6ZFGA141jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3gnftrFxdpAM6ajMytZd2I9qG9Z5TPQRmq72q1UlRmS+HBi3jRr9HWzvEpcLFygWQjMDBj2h5yhfoX1RHQrAQHA2ZxO6k+7Y7JK9kXYiaoXQsXiXOPsx6FeLuNbzwHVRo86WmM779ZEQxadwFk3Fkmx3fE/PEFAhZwtNc28c1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KqeQFTe3; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KqeQFTe3"
Date: Fri, 27 Mar 2026 17:18:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774628292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7hkNrXNrX3y2RRYgslvVXG84OEvte/w9IXB+F9H06M=;
	b=KqeQFTe3ROYAa/Esyp4An0ZYrOVLUE5ZYmonkkI+cN6n/fz/8mdS0BGRQVAExULmltWoHn
	epMnRCRWWpcblwO/FbwBMXNGSRRHBAZSTNoXd+exLpT+BpHrs5dYLgJ3eTIMTjGaz17MoM
	lE6tGbTOExNG5u5Jo4mfUWCWxTYBGq9seYLBl6r7yiMUJkU1kwcNHnVh4HD/gQlJRWmxgU
	0U8Xa8yv7Meo17dQ2LALQZV+hju3gF0dLxHkegd29Y1qk1qqp6rAJrI6BXefZwAS0E2WZw
	v4UEo4kgiQWdxiBgfdTne0PmRbaJykZC5s25uyFbueGtQG7giY6EoecYO/1A9g==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
Message-ID: <acaq3Rg63ZjEV8rH@exploit>
References: <cover.1773959395.git.mroik@delayed.space>
 <cover.1774284699.git.mroik@delayed.space>
 <xmqqqzpa489h.fsf@gitster.g>
 <ad6a32f9-1b48-4bb5-97c5-96d1dfea3074@gmail.com>
 <xmqqpl4qr1he.fsf@gitster.g>
 <acXYSm1JoX6YRuoL@exploit>
 <xmqqldfdmf6r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldfdmf6r.fsf@gitster.g>
X-Spamd-Bar: --

On Fri, Mar 27, 2026 at 09:04:44AM -0700, Junio C Hamano wrote:
> When the payload _can_ be specified to wrap (i.e., end-user
> configurable output format), the wrapping should not be forced by
> the mechanism.  A project that is not ours may want to keep a single
> long line for their commit list entries.
> 
> I do not mind if the default "modern" were defined to include %w()
> to force wrapping to those who follow the default, of course.  But
> do not unconditionally wrap what the end-user formatted to their
> liking.

I see, since there's not much to edit, I'll send the changes regarding
the docs and the wrapping in a single series (I saw that you already
made mf/format-patch-commit-list-format-doc but I hope it is not a
problem), instead of submitting a new one.
