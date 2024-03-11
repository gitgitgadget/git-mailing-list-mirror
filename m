Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657B56458
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186881; cv=none; b=laj0mzVXc/aklYG7lsQfvTh/58KMPpws+yHsIIZu/vQMdn/1+hfjbitRdQ+qCAXS8PLYxdinUNP1K5QvGXroA7htDvJ4TkVX8netFaQwtNVHpyDZ2jnGIz4vKOo1du+X3v+g8fWw3HBDY0rlb5tRW/4VVMffZ77ZoTrJN1tzduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186881; c=relaxed/simple;
	bh=6frddP4X6p9YRJsKtZ1Bw1F1/WZQrLEB95ef5DaoK9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cqHBWCBJRBUl0ha0zjNS8w/MB/8i1lOnde+H9MXRZG5Kq7L9LkXdQFj/wINjwob3+Ehi+WlVsSlDFzeGkfzpwi5V1/elelqW49IVmnBAv8MCLXkMqvCbE0ku77TqBlBiVJZ3CQInm2801lsdaakAbPr1TiQKjuc95aj38RKIL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gPaLdswz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPaLdswz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB3091EEFFA;
	Mon, 11 Mar 2024 15:54:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6frddP4X6p9YRJsKtZ1Bw1F1/WZQrLEB95ef5D
	aoK9w=; b=gPaLdswzuhfFipDq2RyRuGfYx2066BE6d7OB90kuyylR/29umPBWha
	QxOcuM41ihqQhH39XLrQarkH4kYZdIiuB403IIi6dWTEk7kZf+Aw8RYnsh8JPOrb
	PgjYi3C7DR1nkhTXOiodzXdJb2tzMek3RovXwA+hdcXD9Tcc/F+Ak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A277F1EEFF9;
	Mon, 11 Mar 2024 15:54:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D7E71EEFF8;
	Mon, 11 Mar 2024 15:54:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  rsbecker@nexbridge.com,  Ralph Seichter
 <github@seichter.de>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <dd818f1709834ca6cb9050fb4ad0f4ea@manjaro.org> (Dragan Simic's
	message of "Mon, 11 Mar 2024 18:34:41 +0100")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
	<pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<xmqqy1apudvv.fsf@gitster.g>
	<5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
	<xmqqr0ggsmmw.fsf@gitster.g>
	<dd818f1709834ca6cb9050fb4ad0f4ea@manjaro.org>
Date: Mon, 11 Mar 2024 12:54:36 -0700
Message-ID: <xmqqzfv4pmrn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 312D41B8-DFE1-11EE-A901-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>>> Let me interject...  Perhaps also a tab character before the "#
>>> comment",
>>> instead of a space character.  That would result in even better
>>> readability.
>> Depends on your screen width ;-)
>
> Ah, screens are pretty wide these days. :)
>
>> If you were trying to tell me that SP or no SP is merely a personal
>> preference with the comment, I think you succeeded in doing so.
>
> Huh, that wasn't my intention.  IMHO, a space character between "#"
> and the actual comment is pretty much mandatory.

Ah, OK, you were talking about the gap after the value before the
"#" that introduces the comment, but I somehow mistook it as a
comment about the whitespace after '#'.

The gap after the value, I do not have a strong opinion either way
between SP and HT, except that I agree there should be something
there for readability.

Given that other places where we do insert comments, like in the log
message editor during "git commit -e", we always give a single space
after the comment character, I tend to agree that a space after '#'
is pretty much mandatory.  It is a non starter to tell users that
they should add their own SP at the beginning if they want to use
such a common style, i.e.

	git commit --comment=' here is my message' ;# BAD

With a simple rule like "Unless your message begins with '#', the
message is prepended by '# ' (pound, followed by a SP), but when
your message begins with '#', the string is used as is", those who
want to use their own style can use whatever style they want, e.g.

	git commit --comment='#I do not want SP there'
	git commit --comment='#^II want a HT there instead'

and that would be a much more preferrable design, i.e. making the
common things easy, while leaving unusual things possible.

Thanks.

