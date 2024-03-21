Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54C83CC1
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026133; cv=none; b=PHlWASlhsETBog0zztIf/xhdvHPWby/bgBVETmRvIFzU8w/cbTKWsuiBvdAxaCglL4rdILs+bSldstBrJvSkao3AIPnKZyHS16C+dQKcBUGPxvBHE4ez4oDOlz12gAgkDNndYN2lqO52AZdUVnuL71JVcD/vVJPxZVkqQ4R5mK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026133; c=relaxed/simple;
	bh=R+N4627bmm8MJLhN/Qe9RX4D8KKzt79UZLjvxGTpdZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nDK7i3dRnKLhhx4HNBFt//Qaxuw4fz7OiXwPNbUUCziyyskLQ7GFemS/g+TSXEQ66ZavuuW3w0peUKUxrPy7FktIufiN4uITekkCpSkbiVFBtvZaO5pksfkAabFaSs5dWxMGq7PgrtaxNvTJ2PNr/PZLYnfPRud+qmJj+ROnruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TqgFUJCk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TqgFUJCk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 374EF2A809;
	Thu, 21 Mar 2024 09:02:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R+N4627bmm8MJLhN/Qe9RX4D8KKzt79UZLjvxG
	TpdZ4=; b=TqgFUJCk6C1ODqAteq8occP6/7XyKfUW4nOrLsDeA90vr/eQzwlF24
	i8B/dLS1V9qSm+q8ebGs1aON188lnMYUNJiNCab1fPzjC/Ij3wtrGWgYRvpTEwnL
	Yd+iz3SelFuQsMrbfJ1SD0UDJnKRsrKOptpcdoNsUexiVHH7HNYg0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3016E2A808;
	Thu, 21 Mar 2024 09:02:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D07D2A807;
	Thu, 21 Mar 2024 09:02:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>,  <phillip.wood123@gmail.com>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <17bea28cf691d3eb.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Thu, 21 Mar 2024 01:13:54 +0000")
References: <17bea28cf691d3eb.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 06:02:03 -0700
Message-ID: <xmqq34sjd9h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 375E43DA-E783-11EE-B0F6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

> A strategy that I have seen work well is for any commit making a notable
> change (one that should appear in the release notes) to include an entry
> in a CHANGELOG.NEXT.md file.

While I very much like the idea of distributing the burden of coming
up with an initial draft for an entry in the final release notes, I
am not convinced that the approach to use a single in-tree file
would work well in our distributed development style where the
history is merge-heavy with many topics in flight in parallel.

I can imagine how well the approach for each contributor to give
such a draft entry in the cover letter of their topic would work;
it would be with much less friction compared to a single in-tree
file that will be the source of merge conflicts.


