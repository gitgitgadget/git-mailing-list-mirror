Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1B1C698
	for <git@vger.kernel.org>; Tue, 21 May 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315248; cv=none; b=ggsMRI2uEgtZ87nTAfVCIxuTYopXGZfnE6FDxiwaTRdnD5qPLAtnQbctr6MVAaVC73GfYAvge6HXv3DOK5DR7cJTX+FJbXNck7sbZ/VRjUx4MThNJ/aUOxQq/yZESt/Aof5bUbF0BWT5VIj4yKnaOdGIi8T+2eER7mQhf3VtQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315248; c=relaxed/simple;
	bh=vFNjOg+uNCP569RTMVY03VAyr22oNaHiO3IIPQpzemM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8NhPx0SYxYMvUEEZ/4CWEmeCHCjYd1qat5Q077WSvGmxdoqPZ/egV+LtIOVScQjju4ZVPy9rExvvusjk/DzqDJlOPdHkNrJD1uxH9PcIhomQZ++8Ifn61CdIEMY/hGZkulnyiDp7xBEDSVNhWyBBz5G3hWoF8aTAqxTsGqdTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M0NbHmJ8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M0NbHmJ8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13FF721798;
	Tue, 21 May 2024 14:14:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vFNjOg+uNCP569RTMVY03VAyr22oNaHiO3IIPQ
	pzemM=; b=M0NbHmJ8ZikDdcXjyv6AsuXa+eDwafN5RbExkwZbFg4nRLmXXR9VLW
	NjSC6EiqD8SDiPgH8nu3SWVsA/kuCVlmiuIFmJ/eeQPKYnaVfSUdG0j9cZu5HDRC
	QJx28NrNh8oO115h4pLsl5cEO80c5JwB7+LOmn45ubPy1mipJszR0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 086AA21797;
	Tue, 21 May 2024 14:14:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C17B21796;
	Tue, 21 May 2024 14:14:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Various fixes for v2.45.1 and friends
In-Reply-To: <xmqqikz7d90g.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	20 May 2024 22:33:19 -0700")
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
	<xmqqseycca0z.fsf@gitster.g> <xmqqikz7d90g.fsf@gitster.g>
Date: Tue, 21 May 2024 11:14:03 -0700
Message-ID: <xmqqle439gno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8A345C4-179D-11EF-A9DD-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> So, in short, I didn't see anything unexpected to see in these
> branches.  The "ci" fixes were already reviewed elsewhere (even
> though there are slight deviations), so if people are OK with the 6
> patches in this thread, I would say we are good to go.

Maybe I spoke a bit too early, and we may need to redo (not
necessarily revert) f4aa8c8b as well.


