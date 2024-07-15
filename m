Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F14D53C
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058413; cv=none; b=tNfVWgpctHDowSLSU2UMw+3p18HavWfn3i+qPPM7Ruse45Z36Rid9nFmORm67zF2r7gG1pIK/NqoVWqWQAZwfzq6JGFj0B6Wy/RPzhbWTPrZsQNb7kYsTqHyvwH32rWKAz2c1TAQOD7CXA6TRcTqQSx0BQ9UrQmEHKAn9vDmJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058413; c=relaxed/simple;
	bh=7Kqin94ALDBY2qk7Vaxd+Nxgu5jsDBwS8mzj8ZP0FyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iH4X68G/Uvmq/nM0llaithncmSVDzPRQqKudfH4OD55Y/L6kCNLLXOhL1Gw6kSYBWWEp8+OznKi+rVccZD03bjUBiXY/cl1UDSlVwO5LZjkwa+xNDN6GHVY7aUN4/t7mWiiwM6EMK9vr38bYc2sKQgMVqOkroY+z4vRbgH1T/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q6rxURfR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q6rxURfR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DFF6E21BEF;
	Mon, 15 Jul 2024 11:46:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7Kqin94ALDBY2qk7Vaxd+Nxgu5jsDBwS8mzj8Z
	P0FyY=; b=Q6rxURfRW9xQJFYpEVD+ZjJA8Z4EnlbGVO/JtDOHRlQIqnGTN8a1+e
	EJ8zSABetkqIDGdJQa1gmZ2FS7MCXAflXJ6Z2PVYu33WfTRH9BBLbpCjQKNCWo+6
	7Z87SmJXE0L/amTLJC4glihg+LCIny84+khCL4/uL4tnHmVChvvXw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D986F21BEE;
	Mon, 15 Jul 2024 11:46:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69E7621BE8;
	Mon, 15 Jul 2024 11:46:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: clarify post-receive hook behavior
In-Reply-To: <20240714194626.29512-2-jltobler@gmail.com> (Justin Tobler's
	message of "Sun, 14 Jul 2024 14:46:27 -0500")
References: <20240712224748.56843-1-jltobler@gmail.com>
	<20240714194626.29512-2-jltobler@gmail.com>
Date: Mon, 15 Jul 2024 08:46:46 -0700
Message-ID: <xmqqfrsa7j4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 723CC348-42C1-11EF-AF70-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> +See the link:git-receive-pack.html#_post_receive_hook[post-receive hook]
> +section in linkgit:git-receive-pack[1] for additional details.

Use of link:*.html to point to the HTML version of the manual page
is questionable.  Do we have any example that uses such a link
already?  What would this line do to those who read the manual page,
not HTML, iow, "git receive-pack --help -m"?

The latter link using linkgit: is bog standard and perfectly fine.

Thanks.

