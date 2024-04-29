Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3084E1A
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410487; cv=none; b=je09gJmslfH076dMrdT0Rwvf507qN1dOMiKdsLq89mkLgeBnbaIYKOATT22IFgDZiad3WBqXhFvrRshv9IEAt8TIBz2uHQy0g06QZQUa24uK75UiVwarGx8TvSEJG08L+sShvy8Mbi3KxdFbsoaVR3sSfZmcsk6xBRcNSxqzNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410487; c=relaxed/simple;
	bh=lGKTkzvEXIB7oj8mKTW7eclS+kECjwuXOpc9O98kFzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/lElThUZ7Am23p+IPY0Re3FPfbMDA92TZuzhaw/CtgYO4ej2LOFZlmAr9EB2OBumN7wLzGmhYdEP+m7kyoCfeD7kXLLuqFkcyvRi17aHnd/R1edtR2oK3EjnFh7deOuKkYjjyjcfTXrud4K7/D9NlowRJrwekluVSGEO9Mj8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KtvrAn1l; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KtvrAn1l"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 323DF3EC0A;
	Mon, 29 Apr 2024 13:08:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lGKTkzvEXIB7oj8mKTW7eclS+kECjwuXOpc9O9
	8kFzU=; b=KtvrAn1la4fYBVu6uW829Dmk9HXkZ2tSvfmZNp40Hlomn11IQDHUg0
	3EDbiZGwwnIX4cLR6EVNNVj9zbzbU7sQ8dpS9EGUX2NkUKScECI+7XgW4oWtl8Il
	iAZpckOl5T22OpBw2J6mYb5QfD0s+IU1MH6eppfQdLsAbv46d+b2k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B5FA3EC07;
	Mon, 29 Apr 2024 13:08:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E4C83EBE0;
	Mon, 29 Apr 2024 13:08:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Passaro <john.a.passaro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  John Passaro via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin/tag.c: add --trailer arg
In-Reply-To: <CAJdN7KhCesU-j=yyM5Sk0sMj8W2Gk=LJc-Dzf8-2+gjhkgA4HQ@mail.gmail.com>
	(John Passaro's message of "Mon, 29 Apr 2024 11:05:36 -0400")
References: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
	<Zi9DGYwlT7VnW7oj@tanuki>
	<CAJdN7KhCesU-j=yyM5Sk0sMj8W2Gk=LJc-Dzf8-2+gjhkgA4HQ@mail.gmail.com>
Date: Mon, 29 Apr 2024 10:07:59 -0700
Message-ID: <xmqqedaow100.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08DC1960-064B-11EF-9909-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

John Passaro <john.a.passaro@gmail.com> writes:

> It seems to me the duplication goes further than that.
> Ideally I would love to have a unified approach to the problem of
> combining `-m`, `-F`, `-e`, and `--trailer` generally. That would change
> one existing nit I have in git-tag, which is that with `-m`, `-F`,
> or `-fae` to replace an existing tag, it doesn't add commentary guidance
> the way git-commit does.
>
> That's a bigger change than I'm comfortable taking on and it's
> arguably beyond the scope of this ticket. Question here is - first,
> is such a consolidation possible in the future, and second, if it were,
> would this refactor (dedicated function for augmenting a strbuf/file
> with trailers) still be valuable?

There is no doubt it would be, if it were ;-)

At least, it should be straight-forward to turn the copying and
pasting in this patch to a proper refactoring into a common helper
function as Patrick suggested and add it to the trailer API.  It
should become a separate, preparatory clean-up patch on a two-patch
series, upon which the main "now we have a reusable piece split out
of 'git commit --trailer' implementation, let's use it to teach the
same '--trailer' to 'git tag'" patch can come.

Thanks.
