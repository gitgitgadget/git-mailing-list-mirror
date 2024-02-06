Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1D2CA4
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191094; cv=none; b=K5ozL8ke6vWsUPQ0HUbTwym7SU7s+E0vGLXHsjSBuhwWS2TLXUrNYd+Tm9kUsqBtc1v5GAplRl44ohYIl+xIoVa0uxSBM840YrCUF/DLN7C7FtsOp7JbLYgd9WjkUPGO8PlUdwlADDrSBA/oADdgCKGrdK/IOmrajJd/tGGJ1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191094; c=relaxed/simple;
	bh=0rXDdo6tcGDzWG9odY/kGYUCrEKTX+L5JVZU6dSCrH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XMdydCu19pKX9F7JEmcsb83VjWlHrPjD+ycTDJJLtA3i9k2Y3+k7jcE5VIvGhbQ5q/jc7Nk25HR1TLZ99v8JvOHgJL522NZj9pY4nN9u8JSkOU93Rg/+/vaZOQuKquf7zQzYaynPFZ65c4coX9kSpVWuBEi9Zyk65nidMBySRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nkPxqx3z; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nkPxqx3z"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A42841E570E;
	Mon,  5 Feb 2024 22:44:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0rXDdo6tcGDzWG9odY/kGYUCrEKTX+L5JVZU6d
	SCrH8=; b=nkPxqx3zp/rD+tE4RwaI9wtQYltbl00mWTdNs3Cq6F3+ZL3D3H8c3R
	E9M3+g61YZw0xPeA43G9V9sRsvoCbl2kzC1VnXJPwk967U10HEB7A2RIhVlGXD6Y
	c4diomUwvR13z7FxmNIzw8VVHw5gRkYuM+Kd50qramcf9p0TvgDuo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 881E91E570D;
	Mon,  5 Feb 2024 22:44:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8FFA1E570C;
	Mon,  5 Feb 2024 22:44:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: git@vger.kernel.org,  Teng Long <dyroneteng@gmail.com>,  Maarten Bosmans
 <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
In-Reply-To: <20240205204932.16653-2-maarten.bosmans@vortech.nl> (Maarten
	Bosmans's message of "Mon, 5 Feb 2024 21:49:29 +0100")
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
	<20240205204932.16653-2-maarten.bosmans@vortech.nl>
Date: Mon, 05 Feb 2024 19:44:49 -0800
Message-ID: <xmqqil32l0i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 14E08C18-C4A2-11EE-B040-25B3960A682E-77302942!pb-smtp2.pobox.com

Maarten Bosmans <mkbosmans@gmail.com> writes:

> From: Maarten Bosmans <mkbosmans@gmail.com>
>
> From: Maarten Bosmans <maarten.bosmans@vortech.nl>

Which one of you are you?  Please make up your mind and use only one
;-)  IOW, the first one is unneeded, as the latter matches what you
have on the S-o-b line.

> Avoid the need to launch a subprocess by calling stream_blob_to_fd
> directly.  This does not only get rid of the overhead of a separate
> child process, but also avoids the initalization of the whole log
> machinery that `git show` does.  That is needed for example to show
> decorated commits and applying the mailmap.  For simply displaying
> a blob however, the only useful thing show does is enabling the pager.
>
> Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
> ---
>  builtin/notes.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

I am not sure if we want to accept an approach that feels somewhat
narrow/short sighted, like this patch.  When "git show" learns an
improved way to show blob objects, who will update the code this
patch touches to teach it to use the same improved way to show the
notes?

I actually was hoping, after seeing the use case description in the
cover letter, that the series would be introducing a batch mode
interface to allow callers to ask notes for many objects and have
the command respond notes for these objects in a way that which
piece of output corresponds to which object in the request, reducing
the process overhead amortised over many objects.

