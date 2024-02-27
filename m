Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2714A0A2
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064832; cv=none; b=kHMWmjpCZsxbLkfOrjbLt+iJ60dVSoCGb6ugttx6aDafY+rMO+2HH4AdOU0mPilo+YwfKa7/2DfMNU/IXAxrPoKNBNlPKwzrI+cIjZBIH3HbIbyR+FHpbKMYKLMzi/Bdn4Jv3Pk+45guuZDCpgVSYBrHsCu0RkJRpDmTFVvAw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064832; c=relaxed/simple;
	bh=hbBJq65qB5YOlmalW7ntFPLJYQifUynv6bnjna0DgVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cuCXQxPXYjudQyVOgm5B85yZ+VFvyrak59DFDEI8L4O+YUgItagWRjYkTZOy/H5OW7MBpi13kvmT03nYBlUYfhW5ga04GA1mykcKPGzO9x5p4A4eijD4xkWV4OaW1bevo1AxTCmbJVDP6PjGz2NtiUdvSwDJ14vhIGdn3FoEhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TWf2FANM; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TWf2FANM"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 646D61DDEAA;
	Tue, 27 Feb 2024 15:13:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hbBJq65qB5YOlmalW7ntFPLJYQifUynv6bnjna
	0DgVo=; b=TWf2FANM6QwpPvRC1QZLC/woxtfXkYSALJtSjIuxoz3l+XnfDS7cJz
	TZxVqlofgWtnNLHidwa49gtS4yHc/SuIkWNiASO9+adAwATJKVT16YNs5mhivtJM
	Ac4n8LvXvLxn3jYYxEx0aY05pS6JzNrbeoXuqqsXns8dO7wTU3CCU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C62C1DDEA9;
	Tue, 27 Feb 2024 15:13:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C92901DDEA7;
	Tue, 27 Feb 2024 15:13:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>, Bo Anderson <mail@boanderson.me>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential/osxkeychain: store new attributes
In-Reply-To: <CAGJzqsknN_RmYeT0xcn4cTLcJhsxSOUC6ppRVepxMDf3day5Fw@mail.gmail.com>
	(M. Hickford's message of "Tue, 27 Feb 2024 20:00:00 +0000")
References: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>
	<xmqqzfw2vr7c.fsf@gitster.g>
	<CAGJzqsmSzMqEG1OU9dH6CORV6=L7qUAFNJSmi41Lqrajf9mSew@mail.gmail.com>
	<CAGJzqsknN_RmYeT0xcn4cTLcJhsxSOUC6ppRVepxMDf3day5Fw@mail.gmail.com>
Date: Tue, 27 Feb 2024 12:13:47 -0800
Message-ID: <xmqqsf1dr7gk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B7B71C52-D5AC-11EE-946B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

M Hickford <mirth.hickford@gmail.com> writes:

> On Wed, 14 Feb 2024 at 22:35, M Hickford <mirth.hickford@gmail.com> wrote:
>>
>> > Thanks.  Will queue.
>>
>> A first-time contributor contacted me to say they are working on a
>> more comprehensive patch to credential-osxkeychain, so let's wait for
>> that instead. https://github.com/gitgitgadget/git/pull/1663#issuecomment-1942763116
>
> Please disregard my patch and look at Bo Anderson's instead
> https://lore.kernel.org/git/pull.1667.git.1708212896.gitgitgadget@gmail.com/

Will drop mh/credential-oauth-refresh-token-with-osxkeychain topic.
The other one seemed to have got some reviews and I think the
current status of the series is that it is Bo's turn to respond with
a new iteration of the series.

Thanks.
