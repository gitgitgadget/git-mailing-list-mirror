Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18883CD4
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546193; cv=none; b=szt8MLvkwW3wtqhhJcwB0dNrlY9uOXlrhNWWCftM4Tuw2oy5HhtrK9w/AcOxwxuHGcD1FQYVIO3qhxmAqBIeLUx/yOEOu+FCY1sjIzoXh/SKFgF6VVeBii/tnpwjwY9PpR9dGautMOOvUrFs+xEnSgUoZt5F04mHV+gfc+6iJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546193; c=relaxed/simple;
	bh=ecRuZNAodpe9ZvYSlM8Ev4ndF25MpFIbF3XxY5tFY2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yu2e+SQwDUPTlN2BM8mP3Ig2tF3p8laC/u7aD3kQeZpsFtamFt/0xQ/BCqaIC4zevR390tqfhjQTM+ph6lgUYh5ixzC3MnGtMffXuZld8QNX0zu7pOlLU5hfkXJbi4SJjBGLe/UaiV4ng8BafSkF4C7r+aOfGRQsJzbcYqAISsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwxFVi1z; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwxFVi1z"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D96A437822;
	Wed, 21 Feb 2024 15:09:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ecRuZNAodpe9ZvYSlM8Ev4ndF25MpFIbF3XxY5
	tFY2g=; b=bwxFVi1zjzcPggePmv20qTeqigR2IKATdPQyv1SEdBMQhKbvRU5iLY
	BJj5oFr++JXejoIFeN8M3N4Nhr4Znbe/nMUXZCBmSJRjj4+OUzXch8QCfQCxqgaI
	R5k0+NNxc58G6yx9W8ZMzkw9qzNDsgB0Oe6Kfq8+NDoU3BNS0/4g8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CFBAA37821;
	Wed, 21 Feb 2024 15:09:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75D5E37820;
	Wed, 21 Feb 2024 15:09:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ricardo C <rpc01234@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
In-Reply-To: <b84e77a1-93e4-4de0-a0cd-4d76a5691a9b@gmail.com> (Ricardo C.'s
	message of "Wed, 21 Feb 2024 14:13:27 -0500")
References: <20240218033146.372727-2-rpc01234@gmail.com>
	<99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
	<df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
	<78a8733b-c74a-4017-8905-d29b2e05adb1@gmail.com>
	<xmqqjzmzqb85.fsf@gitster.g>
	<b84e77a1-93e4-4de0-a0cd-4d76a5691a9b@gmail.com>
Date: Wed, 21 Feb 2024 12:09:45 -0800
Message-ID: <xmqq4je1o9yu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 296306FC-D0F5-11EE-90DC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ricardo C <rpc01234@gmail.com> writes:

> Permanently enabling keepIndex is mainly intended for people that like
> to stash their unstaged changes before committing (e.g., for testing
> them independently of other changes). The main issue with what you
> recommend is that, if they forget to use `-k`, then the entire state
> of the index is lost, which is especially problematic if the changes
> were interactively staged.

Doesn't "git stash pop --index" meant to recover from such a
mistake, though?  If you stash, because your "git commit" notices
there is no change after you did "git stash" without "-k", your
recovery to "pop --index" would apply the changes to the index and
to the working tree on top of exactly the same commit, so there is
no risk of losing any changes by doing so, right?  IOW, such a pop
will always round-trip.

