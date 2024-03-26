Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BBE1BDE2
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490253; cv=none; b=jNlLPGmwwcAvEvLFnh2dQv9QKv6BzC2JvUauH0fwHfK9cRPhtXUebCRJbnCMrf26mVCAwerB6I6BZ5uTh/hUUilGwsBvOSi/tVQ5H1bp3mcP3fD5H0FvJkPt5jLeb7fo5sX6LHzTf7gK7z6+4Q7SZ6qBtNHlCMkxV7SPeMsjnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490253; c=relaxed/simple;
	bh=KE/RxO22bgWu6p5bcycrNDAuNUSrP0PEACMa8ijtiPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qm6KFuDQ0rcxIdkHtLD7IFFOc40N/PbiAWnCSHB53+n6kfYy8cGTEf5CW0S2XCpG/69MbnZ1T4lA0sa8wjCGOtca1fNE2h9yyxYTqiwht22hpDl2wIIhas5UJKPDrtlA4aLgx9TOnNCb9cMu+eDXjJSZ66DZU5DGcwDD7LYpSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pYnK1jGH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pYnK1jGH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C00A11DA6BB;
	Tue, 26 Mar 2024 17:57:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KE/RxO22bgWu6p5bcycrNDAuNUSrP0PEACMa8i
	jtiPo=; b=pYnK1jGHLdtFnldigsMMOE4e69wdH40SR/N+XbkKQoZLfutwCxJSXY
	DeX+5y7/cD49Ku/fo447OohmXH6iZJ0UFS7d/dJtqOyrjAMfIi1exShrMheBDtMn
	V5ZckTcvKD+3MSmyM3Ofsh5l4DbC8Y/2AkA81rIjRjKCpue32XLqY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B70621DA6BA;
	Tue, 26 Mar 2024 17:57:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 230C81DA6B8;
	Tue, 26 Mar 2024 17:57:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>,  "Christian
 Couder" <chriscool@tuxfamily.org>,  "Emily Shaffer"
 <nasamuffin@google.com>,  "Josh Steadmon" <steadmon@google.com>,  "Randall
 S. Becker" <rsbecker@nexbridge.com>,  "Christian Couder"
 <christian.couder@gmail.com>,  "Kristoffer Haugsbakk"
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
In-Reply-To: <pull.1694.git.1710485706.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Fri, 15 Mar 2024 06:55:00 +0000")
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
Date: Tue, 26 Mar 2024 14:57:29 -0700
Message-ID: <xmqqplvg7j1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D77A8978-EBBB-11EE-9F74-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is based on the initial series [1], notably the v4 version of
> patches 10-16 as suggested by Christian [2]. This version addresses the
> review comments for those patches, namely the avoidance of (temporary) test
> breakages.

It has been 10 days but we haven't seen any reviews on this one.  It
could be that it did not get to intended mailboxes due to the header
corruption (I manually fixed in this message), but without reviews
we cannot move forward.

