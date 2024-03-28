Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2661879
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647106; cv=none; b=bdV8I5cX394eEYeQ0cOPEpXzMfHCu2HuDrr5ubPe/0OKC/SASyX3cSGu7aH/yvnFJ5SckYUfyxsiV8s+TOR/7WDlHCXrb7xHEPSLs6Hg9N4o3ngVmd3/6iOZQcdpapQP2txLG9XdMBxI0o4UukYPu/I/gzhhuxkjK0Er1/IrV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647106; c=relaxed/simple;
	bh=vuIvJH6sgR7wM3trNhididDYl+FqX2yrdUAbqvsNrOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IJF2wF38QC4TtqlMB67GMPLLM1PECd2VIc4aEDg/4s14z/nMCE9S9i9B7uiH8Oxszsy5t6v5Qq8odaWWuoYdgn5fai33joQ2TPomQDIT8PmsEryoAbxlO8ZsK6ciHNh/3QQ4Gd7sIvaX1NUd5vugLClwn2XrO3l/l6hF8DqhW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sUN5uYOs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sUN5uYOs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFA2A1EBB62;
	Thu, 28 Mar 2024 13:31:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vuIvJH6sgR7wM3trNhididDYl+FqX2yrdUAbqv
	sNrOk=; b=sUN5uYOsxUBEhmZ8b7HTAUGERJg3mDV3la5UK8Lw8BJWfL03Vsm6zA
	u7WCWlP4CLNLyKpzY7l2nauDbpUOICe0fpczpQvcAmzorF/09N+VnxRDCOiNb9Mj
	XYYmCIQelBiOXbI8ITnSf4JqImN/45iDuvDXiOKrkdLi/1g325cxE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B58451EBB61;
	Thu, 28 Mar 2024 13:31:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10D981EBB60;
	Thu, 28 Mar 2024 13:31:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Han Young
 <hanyang.tony@bytedance.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] quote: quote space
In-Reply-To: <CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 Mar 2024 13:05:10 -0400")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<20240328114038.GA1394725@coredump.intra.peff.net>
	<CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
Date: Thu, 28 Mar 2024 10:31:42 -0700
Message-ID: <xmqqa5miuutd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B1B89A8-ED29-11EE-BFF1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> This reminded me very much of [1] which exhibited the same failure
> mode and was due to the same limitation(s) of the OS.
>
> [1]: https://lore.kernel.org/git/20211209051115.52629-3-sunshine@sunshineco.com/

Ahhhh.  That one gives the official excuse to apply the band-aid.
You quoted from their documentation

    Do not end a file or directory name with a space or a period.
    Although the underlying file system may support such names, the
    Windows shell and user interface does not.

As this test _is_, unlike the cited patch that was not about a
directory with a funny name, about parsing a patch and applying it
to a path with a directory with a funny name, I am tempted to keep
the test with the filesystem, instead of replacing it with the one
using the "--cached" that Peff suggested.  I am _also_ tempted to
add that "--cached" thing (instead of replacing), though.

Thanks
