Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556514A81
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546290; cv=none; b=d/IN8aC8iG2UcB7TfoRB4IJmzjD/vxn9/b99qdK6MrYe8/4i8EK7wyaqDSpr5XB9ZJKmrvTHe00XbL4gYKIVGoN53E0vGyiHw0XUNWXrqo0crTNaydGEMkbd5Rmg8cnw90+smvBFSdBmWg9pW7YzrUkC63SRKn/kFYw613voEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546290; c=relaxed/simple;
	bh=e1IombGK4F7v2mW9jVoT7BxmXcMSXkx4de7eiF6an2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r53UVRS/tSjHUiMLr6VKbJz6GDJIssqHXXARcJoJlRNQAHhOnBmKMTUR+kATAtyCaDgVuBvWCXuyL/JoEAvMda0Z9+8NTE0JyrXo16tL1P9EuAf3pjm3YsGakoMjp3LTSKNG9Cm/mW6fhk9/PnrEjMzWdYTb3cgQND+ukJ31bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nPFLYNVI; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nPFLYNVI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AA063564C;
	Fri, 15 Mar 2024 19:44:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e1IombGK4F7v2mW9jVoT7BxmXcMSXkx4de7eiF
	6an2Q=; b=nPFLYNVI08ZFclh/l/JIAG60GsdEiJ6mWhZxl0SCooPCOVA8lT4ekY
	lvluwIvZ6UWXL17fsnu3SzPg6GjkPAUdR1kkzc2u+ud9kz6A4WqTMDZt73HyCsls
	mgqzT4nGdiTZndR10c/cdiT0z//PrXSOCoW05l1O3k7K3GGjzAN/g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 524F63564B;
	Fri, 15 Mar 2024 19:44:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD60F3564A;
	Fri, 15 Mar 2024 19:44:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  rsbecker@nexbridge.com,  Dragan Simic
 <dsimic@manjaro.org>,  Chris Torek <chris.torek@gmail.com>,  Ralph
 Seichter <github@seichter.de>
Subject: Re: [PATCH v3] config: add --comment option to add a comment
In-Reply-To: <xmqqttl7njv2.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 Mar 2024 16:41:37 -0700")
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
	<xmqq8r2jp2eq.fsf@gitster.g>
	<CAPig+cQwWu=FA4vnKK9+aLkTzAzMXp6h5aJedEh3FT+1bNTjAQ@mail.gmail.com>
	<xmqqttl7njv2.fsf@gitster.g>
Date: Fri, 15 Mar 2024 16:44:40 -0700
Message-ID: <xmqqplvvnjpz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE904686-E325-11EE-A74D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> There will most likely need where e.g., above or below, around the

"need" -> "need for adding a new option to specify".

In sort, we would need to have more than just "use this message"
anyway, and cramming everything into the single "--comment" option,
even if it were feasible, would not be a good idea.

> "var = val" line to place the comment as well, so I do not see much
> value in investing more brain cycles on what the "--comment" option
> should look like, while we only support single-liners and explicitly
> reject multi-line messages.
