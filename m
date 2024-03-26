Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC63C26
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489873; cv=none; b=cvfWCW5TZxa+HsqNz0g0fcovPl5dzXy/ruTtdfTeHR7bb+wD3cCsxfDRlNzM3wgwinMmtuvNEhiXrVl/e27bMDUElyIKrj1vUcGV1zgI0QUkWBJGhCdLv0Kcnt/AzZMbCQ4nfkceR1B0n0LBnBJjEVTvrI0jc2nIpDiwFHy9FKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489873; c=relaxed/simple;
	bh=lAnukgmXA581HDzqxqZAU6H0Dh4Yfu0+Z61DBWkNl60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OoPBmSdbco/5oj29q60WEHH4pq12y7nepeNcXxWRl2xurQJ3Iwd95WExulxPbuepC/vfMst6IXRSsffMn3aM+t/vW+0dGlzZz1xEkM5drZ8Hr7y8OFiRzlmdK8YU4pLAoVXrGOu/72CwC6x0yw12dH8BP95veg4YxbbdBt9NM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BiqKtArC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BiqKtArC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E70C1DA66A;
	Tue, 26 Mar 2024 17:51:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lAnukgmXA581HDzqxqZAU6H0Dh4Yfu0+Z61DBW
	kNl60=; b=BiqKtArC/SB4mJPTdUufEWiASvD1F85/8E9GePgjoWHtmP3OSI2Xz9
	UmQNASg6s9q1LT2K5cX+v4UNqpnjNtA+9CY50UEqiZe0SKz0+QXz6YSu3p6yESvx
	2TBhEXD31WwkfU2rNvM9UAzJ4dpaAgsv5aCAGzWD+pEqCGcMLf6w4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BB001DA669;
	Tue, 26 Mar 2024 17:51:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 725C51DA668;
	Tue, 26 Mar 2024 17:51:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] fuzz: build fuzzers by default on Linux
In-Reply-To: <cover.1709673020.git.steadmon@google.com> (Josh Steadmon's
	message of "Tue, 5 Mar 2024 13:11:58 -0800")
References: <cover.1709673020.git.steadmon@google.com>
Date: Tue, 26 Mar 2024 14:51:01 -0700
Message-ID: <xmqq1q7w8xx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F0686582-EBBA-11EE-B307-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Increase our protection against fuzzer bit-rot by making sure we can
> link the fuzz test executables on Linux. Patch 1 is a small CI config
> improvement to fix compiler feature detection. Patch 2 is the Makefile /
> config.mak.uname change to add the executables to `make all` on Linux.

This has seen a handful of review comments but they haven't been
responded nor resulted in a new round.  Can we wrap this up anytime
soon?

We would expect a review comment to be at least responded to either
rebut or admit the issues raised.  It may be that a reviewer's point
were missing the mark and the patches themselves were perfectly
fine.

But all other cases, even when the reviewer's comment were missing
the mark, such a confusion may have been the result of the patch
text or the proposed log message being unclear.  Of course, the
review comments may have been pointing out an actionable issue.
They would hopefully lead to an improved version of the patches
posted sometime later, so that we can conclude a topic and move
ahead.

Thanks.

