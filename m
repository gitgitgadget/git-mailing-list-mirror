Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B794597E
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944934; cv=none; b=LxkO2zjzSSzHCF0Fv5k+iyWufHdyJgXT2YlnpfxEVNdNGc24fn9va7D3XsO0jvZdw68YHMBTHjgMR9TkjB2MlL9b0BAXnx781YlvZHv4IE0oS3Ve4VnM73+b2u0pqsCTjUvC7FWUk5S2/hGm9pLKYrhc9B1dquPMHSeDfbqxMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944934; c=relaxed/simple;
	bh=uYQRxwhPbqhqjsssXMag7xbZy4TyAvy3ySDs9RtiRRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hghR2U36ADE2CHf2T5feh0DT8OwwOuMsMBo+dwUdMrKX7vV05sVS6fxiFEJulrWPNfzOp+xba+QUnT5FbzlvSSLr8B3yu309NudevyChFsNFGSOIU4CLlgjwtMXTQKzWXj+Jae3pKQNi7X+fDrCPXggcjnXHO3REqVviYaVAGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qBLCQwYQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qBLCQwYQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 039ED1DE185;
	Wed, 20 Mar 2024 10:28:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uYQRxwhPbqhqjsssXMag7xbZy4TyAvy3ySDs9R
	tiRRw=; b=qBLCQwYQFrxn6BVR7z83qtqO76z/9EM+synkkbl6iCzt/VQ8k61Y0m
	pBzZmnP7UggZDa9u1QURgm3Rwf6c/68gu5CL5D0Hi80NtVJBJDC1k7ik56UvI52b
	ydjzRsbc/euPU1+sO120+eyVFQeCqUrTChlXRs9JijIvW1n2IgFEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EE5351DE184;
	Wed, 20 Mar 2024 10:28:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60DAE1DE183;
	Wed, 20 Mar 2024 10:28:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <c5736219057c73a3a344237257534bdc@manjaro.org> (Dragan Simic's
	message of "Wed, 20 Mar 2024 07:59:18 +0100")
References: <cover.1710800549.git.dsimic@manjaro.org>
	<92ddcd1f668906348e20a682cd737d90bb38ddc6.1710800549.git.dsimic@manjaro.org>
	<xmqqzfutjtfo.fsf@gitster.g>
	<32c4718d09ff6675e37587e15e785413@manjaro.org>
	<c5736219057c73a3a344237257534bdc@manjaro.org>
Date: Wed, 20 Mar 2024 07:28:50 -0700
Message-ID: <xmqq4jd1j7tp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C2D3C2C-E6C6-11EE-A90E-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Oh, I just saw that you've already picked this patch up in the "seen"
> branch.  Would you prefer if I make this change and submit the v4, or
> to perform the change in the already planned follow-up patches, which
> would also clean up some other tests a bit?

The purpose of the "seen" branch is to bundle the branches the
maintainer happens to have seen, and to remind the maintainer that
the topics in them might turn out to be interesting when they are
polished.  Nothing more than that.  Consider that a topic only in
"seen" is not part of "git" yet.

The contributors can use it to anticipate what topics from others
may cause conflict with their own work, and find people who are
working on these topics to talk to before the potential conflicts
get out of control.  It would be a good idea to fork from maint or
master to grow a topic and to test (1) it by itself, (2) a temporary
merge of it to 'next' and (3) a temporary merge to it to 'seen',
before publishing it.
