Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442F19B3CC
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782950; cv=none; b=cbEfHQnSBVlUYMnh9e1PRrJzk/M3rPpEA/Hv1vwPnxE/Ylq+JN3k+1hd3DlDRXwlr4MYR/EoCjDXuzS+swkXzSjfqHaH8yGaHRGOTQwMdh2+gyHnicZ2N3Jog6aD3zFeN+0ttH1JKFz0nSREdwYZ91cF5pxvH/nlVM3hWJp/e1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782950; c=relaxed/simple;
	bh=9hsPEwOD/N6nJnZBg5kT7YczAAgieFvhINTwZwziLuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMVMMaqhLEkGk6IaFdhsg0zJ8Z3DHupu4+ab9PaK/xofdtTlQmouTSXt5X11NukwQ8I1xI91eJ1TV4TNXQPOz8XL0ZhuS6F13kazLzwZAx6sBEa0RcoU4mdm7JHOCmFOJLUf+PxHHKC8szUk4gMmzVy3/71rzON0GejltQ/rytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x2ZpdE0G; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x2ZpdE0G"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DC9037730;
	Fri,  7 Jun 2024 13:55:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9hsPEwOD/N6nJnZBg5kT7YczAAgieFvhINTwZw
	ziLuQ=; b=x2ZpdE0GRaj+1WSouILiktgmXzY5ZaE+ne6k1NCS7c3rOY+j2LTa52
	KaoVkASS/bzPsxKkXvSQ5NeKpjZkR8XoBg/QDdaoHVauUV0Or4DvkaNs9VzTuBR/
	ZoWj7q15jul+k733PKQGkvnXzXqBYHNzhH7LkPsCBWXBzu9N1aFgw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 46BBC3772F;
	Fri,  7 Jun 2024 13:55:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5889E3772D;
	Fri,  7 Jun 2024 13:55:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 00/19] midx: incremental multi-pack indexes, part one
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com> (Taylor Blau's message of
	"Thu, 6 Jun 2024 19:04:22 -0400")
References: <cover.1717715060.git.me@ttaylorr.com>
Date: Fri, 07 Jun 2024 10:55:43 -0700
Message-ID: <xmqqwmn0d4dc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2A1C1614-24F7-11EF-BA3B-8F8B087618E4-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Part three doesn't exist yet, but is straightforward to do on top. None
> of the design decisions made in this series inhibit my goals for part
> three.

Nice to always see the bigger picture to come to understand where
the current series fits, but the above is a bit peculiar thing to
say.  Of course there should be no design decision the currently
posted series makes that would block your future work---otherwise
you would not be posting it.  The real question is rather the future
and yet to be written work is still feasible after the design
decisions the current series made are found to be broken and need to
be revised (if it happens---but we do not know until we see reviews).

Thanks.
