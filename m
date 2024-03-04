Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE461665
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574622; cv=none; b=twlsyVKpHw4lfu5xj/MSiQrhip4wOL/CZGbvL6J8siVU00zM8mXg3tA/dDjS6RIRby75MbtUS5nd94FNg1kTpAP67kRLCsqj2JKkg3ik/Ptsx80z+BfSoFcJztWzDfsRhUdJv+NB0/64EyNLi8DZ7LAewUmuj5W6zpFAcevpq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574622; c=relaxed/simple;
	bh=RFvRsYq27z8kx4tqak/1BZjQVev8QQRZsJFV7TkovmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0HIWOS+tLE3HUrN6OnTLVaqoO75vcpIs75Ht0QDoPLrc8BN1Q0Q6dE2fsQrt7k13MHjcR45LPozjuipluIrzjZQMGx0W1WcLtb1C5TAvV4TMXSM6NryOtTnr8S9hFYpIX+jm4dchMijoj3o79yYW8rlYVUT4qYKYOyy/Lv2/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=veFKRUD8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="veFKRUD8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97DE71CEB8C;
	Mon,  4 Mar 2024 12:50:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RFvRsYq27z8kx4tqak/1BZjQVev8QQRZsJFV7T
	kovmQ=; b=veFKRUD8U7njC7I/wpCjX1h6ZxmNnQfzIq/eZq9sMlNGnXXmqNYRvl
	7i9EjAz7OO0qWXrRlxYIFMAl0lZXsrwJtfChhy4r9LL/pCqYYYJkNYUoXb6we7pV
	73fEMk/p8U0Qou0Bj9Q51/5L148uAuaZSNgPRG/NdodgXd/Lx+NCI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EDD41CEB8B;
	Mon,  4 Mar 2024 12:50:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 028A41CEB88;
	Mon,  4 Mar 2024 12:50:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/1] [PATCH] t9117: prefer test_path_* helper functions
In-Reply-To: <ZeWbdvFmhUYN9ekE@tanuki> (Patrick Steinhardt's message of "Mon,
	4 Mar 2024 10:59:18 +0100")
References: <20240301130334.135773-1-shejialuo@gmail.com>
	<20240304095436.56399-1-shejialuo@gmail.com>
	<20240304095436.56399-2-shejialuo@gmail.com> <ZeWbdvFmhUYN9ekE@tanuki>
Date: Mon, 04 Mar 2024 09:50:17 -0800
Message-ID: <xmqq34t5rina.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AA5865DC-DA4F-11EE-93CC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> This version looks good to me, thanks!
>
> One suggestion for potential future contributions by you: it's always
> helpful to create a "range-diff" of what has changed between the
> previous version of your patch series and the next one. Like this,
> reviewers can immediately see what the difference is between the two
> versions, which helps them to get the review done faster.
>
> Assuming you use git-format-patch(1) you can generate such a range diff
> with the `--range-diff=` parameter.

Thanks for a review.
