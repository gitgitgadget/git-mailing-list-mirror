Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9815D5C0
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762839; cv=none; b=ncm4cNp7Iy31Uo9Un5nKK2usKP3HnlBuKFlS3NxRtz+jSlDCwqi01c2zUWuvqXeYYOKWnoRM9huMKz4dkV0+y1ywRR9O56e0sgNnAKAxZQzVTRlBo+MXzxX3QYIj4JUY76kygSGqAmlULZYlo7loi2D4DG4zZ/sJxtg6S96XOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762839; c=relaxed/simple;
	bh=/WOUc56i2LbXFHgGvdlnoU46DUWQ32rh6zg4gwwr+Y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHGiFJRmTxkcqcLdOlbGrmVMA51ZNIxLxpB14pryNZvtpqUK2qVJJVmlOGVQCC/vi8/7apSAFGSpELSD92Mg57iPzoGtkCH1iott8W11J2R6NHQ8mmLBTSdwDnASQlnAd0XXA23zXfNmXvPRK5n0qT8JatjtyMp/gSWEfS/gzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wK4QXzLr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wK4QXzLr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77C0D1ED322;
	Wed, 10 Apr 2024 11:27:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/WOUc56i2LbXFHgGvdlnoU46DUWQ32rh6zg4gw
	wr+Y4=; b=wK4QXzLr4/ZUVViC0a90I7Syu6H7IRU7miqCF8R1RgmrS2ij005385
	sBLYT3ZSfHZfaywa9G/3GLrGou9u2gCQAoE1v88XQuQVKCWg6AHC4n/kBjraTWyL
	3cpUEXcKCj58jO35b9PSi+0co3wPfCsVY4nqS2ENFP0fS3Rx+F9sc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FDB71ED321;
	Wed, 10 Apr 2024 11:27:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA73C1ED320;
	Wed, 10 Apr 2024 11:27:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/3] show-ref: add --symbolic-name option
In-Reply-To: <ZhY3UCwJeMcG4fH1@tanuki> (Patrick Steinhardt's message of "Wed,
	10 Apr 2024 08:53:04 +0200")
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
	<a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
	<ZhY3UCwJeMcG4fH1@tanuki>
Date: Wed, 10 Apr 2024 08:27:14 -0700
Message-ID: <xmqqseztxmp9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CFA799CC-F74E-11EE-A76F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 08, 2024 at 05:38:13PM +0000, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>> 
>> For reftable development, it would be handy to have a tool to provide
>> the direct value of any ref whether it be a symbolic ref or not.
>> Currently there is git-symbolic-ref, which only works for symbolic refs,
>> and git-rev-parse, which will resolve the ref. Let's teach show-ref a
>> --symbolic-name option that will cause git-show-ref(1) to print out the
>> value symbolic references points to.
>
> I think it was Peff who shared a way to achieve this without actually
> introducing a new option via `git for-each-ref --format=`. Can we maybe
> provide some benchmarks to demonstrate that this variant is preferable
> over what's already possible?

Yes, I recall that discussion, and in fact I was a bit surprised to
see that this iteration still went to the show-ref route.

Thanks for bringing it up.
