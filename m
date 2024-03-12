Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98D433A3
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271801; cv=none; b=jR2AHkMr7f0xj8C6KRm/XDWzv7AJYjznNUeJrxiHdeX3ZbuH/0sTfAxmQIJy/Ur9hiItsA5DlzKx2vJY9KqCuUQDHsgmSWLJic4Yjv7trfW9xKSSM8iGoQFQ9mPhijSQKrcro6dYERU4/q+vdf2w1KtXBXkWMjxmYmcovRNlV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271801; c=relaxed/simple;
	bh=AhKrFrMs8O0xfb83NQaX3YxjGKJlOOm1SjP2xkQXHIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jj9GlrQ/Kvyg7GhcaAfySorxiyQSq8jXgu/BBFt1osnqHAejwCE+q4lquaf0DHlHGPEWBWRZxGg75+c1waSulHs3mexPAG8wrC5Ca57S5c4FARSapaaFRSAC/t9UjKMWSiak0W33yvOpKNualCmbYeXv6auviftQOADkQ7+b8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h/Bg+oCA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h/Bg+oCA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A07B1C8CB2;
	Tue, 12 Mar 2024 15:29:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AhKrFrMs8O0xfb83NQaX3YxjGKJlOOm1SjP2xk
	QXHIM=; b=h/Bg+oCAP177Rfl2b/Cf7sUcO9qcdKkpQm5rW8zv9f164AWYF2LQtB
	w31jCo1GB9MgX+EL8fSD+hPzG+NfqiiCZqqnTXBlT77D/dlpTsXL4ZOZyo1PW3s2
	cOqrN92N+O0dBaPXR+0m2351d1+L4jg2CBoFUe7p5AZWiY2KBXLJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 707B71C8CB0;
	Tue, 12 Mar 2024 15:29:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC2181C8CAF;
	Tue, 12 Mar 2024 15:29:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] MyFirstObjectWalk: add stderr to pipe processing
In-Reply-To: <ghbk7ja5k2.fsf@gouders.net> (Dirk Gouders's message of "Tue, 12
	Mar 2024 15:27:41 +0100")
References: <cover.1710192973.git.dirk@gouders.net>
	<a2d30eff217e560873c49fe45116c784dc12fd32.1710192973.git.dirk@gouders.net>
	<xmqqh6hcmhmu.fsf@gitster.g> <ghbk7ja5k2.fsf@gouders.net>
Date: Tue, 12 Mar 2024 12:29:51 -0700
Message-ID: <xmqqwmq7jljk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E6543AF4-E0A6-11EE-81AA-25B3960A682E-77302942!pb-smtp2.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> Ah yes, it is a bash-ism, thank you.
>
> I guess you meant

Yup, thanks, that was a typo.

>         upstream command 2>&1 | downstream command
