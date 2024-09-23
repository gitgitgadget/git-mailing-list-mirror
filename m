Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C746BA
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107337; cv=none; b=CStV+/tdedHzR9N3OMagsOZuo4tsY3o7vQgYjjK4OLi9ddqo7elaN06rvf+niF/WN46w7wZerCwXAZsPgnaQokKxn2JYF5DLq/n2mAPKjMhboypU9Pet+AZwiJohsEtpHsF2sldQnmgWNshHVmlLZO0vtVTbhj4fjcZhJ6tZj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107337; c=relaxed/simple;
	bh=dynrPfZAnKqsd1kwZYnsxdhAWKr9fP7LCWszlWEaHUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TWIfFL1zM2f1ZTaoZlXbrCZ7vwkwGL6F05htCvBTazjjtV2H60MSa5sW06BYMHjT5OMBESygHHg5L6QR5YuwOpQJ/4OCSoGJQsjXPTUnk7s0pbIYuaXC+vD+0oQy88KDb+6Ju7jexRlufBy03kEM1cwUjKS/HDFGMjPG1vREluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ProqOrL9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ProqOrL9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD77D21679;
	Mon, 23 Sep 2024 12:02:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dynrPfZAnKqsd1kwZYnsxdhAWKr9fP7LCWszlW
	EaHUk=; b=ProqOrL9CiXGZD7QB/tiWC0j5EUveWxXQZMDhoWZqzLP6qmQ8xTZLe
	/x7c60tsfDg+7vpwYG1ax4czm7Tb5EgARF9t9SkmeWfPbJcdb+Y1CJGT+XfzVEU8
	x/0fTf/sAIOL7i4drR+cld+TM7bKWghkY/UoveV8445xOruWN8CFg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A51C821678;
	Mon, 23 Sep 2024 12:02:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE95B21677;
	Mon, 23 Sep 2024 12:02:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] add-patch: edit the hunk again
In-Reply-To: <2ad1f7b1-714c-4d6e-89a6-fd65271222b9@gmail.com> (phillip's
	message of "Mon, 23 Sep 2024 10:07:08 +0100")
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
	<4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
	<2ad1f7b1-714c-4d6e-89a6-fd65271222b9@gmail.com>
Date: Mon, 23 Sep 2024 09:02:12 -0700
Message-ID: <xmqqbk0e5pff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 32D39AAC-79C5-11EF-A227-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

phillip.wood123@gmail.com writes:

> Thanks for the re-roll. I'm still not convinced that changing this
> without keeping an easy way to get the current behavior is a good
> idea.
>
> This is not very obvious to the user, it would be much better to give
> them the choice when we prompt them about editing the hunk
> again. We've been giving the user the original hunk for the last six
> and a half years so I think it's a bit late to unilaterally change
> that now.

I almost never use the (e)dit in "add -p", but after trying it and
deliberately screwing up the edit, I tend to agree with you.  It is
very easy to lose what the original change was, what you wanted it
to say after the edit in the end state, and how the patch for the
current state should look like, and being able to easily start over
(and more importantly, knowing that I'd get the version that has
none of my screw-ups) was the only thing that convinced me that I
might in the future try to use the (e)dit mode again when I find an
applicable situation.

Thanks for review.
