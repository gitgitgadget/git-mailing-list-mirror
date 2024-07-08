Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDE1FA3
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468673; cv=none; b=Z2DLRe7qoUhrekUtvmLy4Nd+d3pZBWvDqsz9qvaJU4zmex7EM6yiN60fYq2EKY7M02Ljpxx0NPPMqJFPH5qydc51c9iHJBGc9HP3OF1ePbc8cehU2TfEI2kFKEPKitONpIcSalNWGWxcXBzINI0/YiiJRfvEYQ5Dbu8bvklh2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468673; c=relaxed/simple;
	bh=oUwhL3YZv6ePy8KAXzrbA6eu6E1QklwUDNKkuv0kCp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xi4zUSKq35em9W8ulvW6ll6n+kjLOWjjKr8vfPeXmmKa7CNr+7ShQPRFcTlIX+u2eUf62PvX0f/ptcPY+UaBPvAl0jLlKsaZxZN2e3Uk1GGiXeNfUk2FCCFR9FfY8TjZNribPytrSKqKjjBLl/1yxGkFUpK6/bVqootqZ39aMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L6lojwyL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L6lojwyL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7658E35D8C;
	Mon,  8 Jul 2024 15:57:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oUwhL3YZv6ePy8KAXzrbA6eu6E1QklwUDNKkuv
	0kCp4=; b=L6lojwyL8j1BsbZRJ/chMevwG6u5PMU7UkAIDvLEZkImtA7PmZuCzk
	n+6xRTGGGwO+GPdqNeQAHu0Is8E+LSSqL02oZZJUTUvTgngbZUwghq7Z42hG+5Lm
	nCYPXIIRgOtnaR2z+CMAfGeQGmy36NwlJ7HArXPZA+kQhbJBONXHU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DFC135D8B;
	Mon,  8 Jul 2024 15:57:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EED4435D8A;
	Mon,  8 Jul 2024 15:57:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org, Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: Unbalanced closing paren in help of git commit
In-Reply-To: <87o7792xgu.fsf@posteo.net> (Tomas Nordin's message of "Sun, 07
	Jul 2024 12:33:21 +0000")
References: <87o7792xgu.fsf@posteo.net>
Date: Mon, 08 Jul 2024 12:57:46 -0700
Message-ID: <xmqqcynnejwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5988CCD2-3D64-11EF-BF3C-C38742FD603B-77302942!pb-smtp20.pobox.com

Tomas Nordin <tomasn@posteo.net> writes:

> Hello List
>
> The second line of the help message for git commit looks like this:

This seems to have come from 00ea64ed (doc/git-commit: add
documentation for fixup=[amend|reword] options, 2021-03-15),
if "git blame" is to be trusted.

>     [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]

We can have --dry-run but we do not have to, we can have only one of

    "-c <commit>"
    "-C <commit>",
    "--squash <commit>",
    "--fixup amend:<commit>"
    "--fixup reword:<commit>", or
    "--fixup <commit>"

as they are mutually exclusive, but it is OK if we have none of
them.

The last closing parenthesis after <commit> but before the closing
square bracket is unwanted, I think, as you pointed out.

