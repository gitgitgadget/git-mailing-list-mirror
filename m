Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4B20309
	for <git@vger.kernel.org>; Fri, 10 May 2024 04:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715316474; cv=none; b=U+dwSeyQlYByLtcI/hnMB+dYGA29R6/R4h6w0oXewnIT1RiNKmVkxdJR1VUdxNjd2BGeJh5wmV1aptaqFY/yuhosIxl5rcIWNGdhxrzwpcJIZfc26SKwZuOigF2cSgz5ujxpjZAQ1NDzlOzSFNdB0u4WaeVJNNYRi6utsaM0MmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715316474; c=relaxed/simple;
	bh=Jp9cX94BywV9vFVT1T1i22eVTcXDm7WXolDYPqtr0+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GKfTpvMtg1SCLiJujXP3D89h79A9EUxIscR9BKCTExbJN37JUkq7ubVAYJQWp1/x9aHSbIYcS5eYiNfF+TUO7WOydOPFf2mrQgrLolv0uXhxh5pNdRVz0E10EdMnpPZxdWsK1RfKRAH+se8Ad47ZUH3+ORfxCGb09yKQg62S308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sWOqbumT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sWOqbumT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C0D21F3BD;
	Fri, 10 May 2024 00:47:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Jp9cX94BywV9vFVT1T1i22eVTcXDm7WXolDYPq
	tr0+Q=; b=sWOqbumTNmVWBhalNO0vw/AQWflOnbl/yy7iWlJ280CTO2957wbgEp
	j4pvTct+6jkIheAg1oMU6De38ILRxLRsN9p9FTSX53eXL4X1YSXIfIX7s9hqoc54
	0lj6II0RoCr8sAvMOyyr/chx+DFSoaVFLpok7iq8qxpTwFyKyc3EY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 72EF21F3BC;
	Fri, 10 May 2024 00:47:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D40731F3BB;
	Fri, 10 May 2024 00:47:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
In-Reply-To: <obsrinbe2uvemiq7q22zrbcln2lmfaukn6lqn7nagrassoicb4@ihwb6ifpjomc>
	(Justin Tobler's message of "Thu, 9 May 2024 21:15:29 -0500")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<obsrinbe2uvemiq7q22zrbcln2lmfaukn6lqn7nagrassoicb4@ihwb6ifpjomc>
Date: Thu, 09 May 2024 21:47:49 -0700
Message-ID: <xmqq1q6aqnm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 74BFBC3C-0E88-11EF-BC2A-25B3960A682E-77302942!pb-smtp2.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> I would like to see the double dot and triple dot syntax (".." and "...")
> removed from `git-diff(1)` as I think they get easily confused with
> revision ranges.

I tend to agree that the double-dot notation does not need to exist
as it can be done with a pair of bog-standard revs.  But triple-dot
notation needs a replacement syntax that is just as easy to access
the feature as the current syntax.  After updating a tip of a topic
branch,

    $ git diff topic@{1}...topic

is extremely useful (in addition to "git log -p" and the like, of
course, with the same range).  Also during a conflicted merge

    $ git diff ...MERGE_BASE

and its reverse are very handy.  Having to say "--merge-base" is
probably a usability regression.

If somebody wants to pursue this further, my recommendation is to
treat the two separately.

 * Deprecate and eventually remove double-dot notation.

   - First, notice the use of double-dot notation.
     builtin/diff.c:symdiff_prepare() is the place to do so.  Issue
     a warning about deprecation and possibility of an eventual
     removal, and tell the users to use "diff A B" instead of "diff
     A..B".

   - Gain consensus that the removal is a good idea.  Finish these
     steps long before Git 3.0.

   - Remove the support for A..B.

 * Deprecate and eventually remove triple-dot notation.

   - Introduce a new syntax to allow an access to the "symmetric
     diff" feature just as easily as the current syntax.  Wait for
     a handful releases to gauge its acceptance by the end users.

   - Then notice the use of triple-dot notation.  The place to do
     sois the same builtin/diff.c:symdiff_prepare().  Give a warning
     about deprecation and possibility of an eventual removal, and
     tell the users to use that new syntax we introduced.

   - Gain consensus that the removal is a good idea.  Finish these
     steps long before Git 3.0.

   - Remove the support for A...B.
