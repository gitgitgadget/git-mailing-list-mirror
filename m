Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273F322A
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640686; cv=none; b=N9UbWgFA/RD3BcqoGO42NFwzpK1L67kUU9P5JW6wOvDFXvsqMdFPZ2cnXfvEYMR6BG3OFzdrZ9yRSPq+2DXup5wZUSxtkynOSpzD22EhTOAtaEWugmz428mIhu2lo8jtU9juw6KF7EPPPTVVCrdlrzgrAMJQR9kNyP2PeXAcaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640686; c=relaxed/simple;
	bh=BrSD3Bc8IbRGfpeAz5wy5iG7c0bSM63zyH80u1PKshY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tz1VUn4kEnqK/lgZv6J5FYG+1wCf1S1BTz2GMKlm5UJHkMPFOUTtFkRhkC2NE7foorXwMMRYc0ZUVGii2A6hRFv1ycswRXMclU7v0BN6IvfXHQKqtborIORh6HUlKbd+sJbHx2QDtqZTI4dwGDUdKZHp5os687ZZP6Z93UZZE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SarnCoih; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SarnCoih"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F68836A76;
	Fri,  6 Sep 2024 12:38:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BrSD3Bc8IbRGfpeAz5wy5iG7c0bSM63zyH80u1
	PKshY=; b=SarnCoihUgq0/Ajv8Lc98HBwKtEO51GkKmKgpyAwxc+PgcTWWES768
	CB9H+q9Uav1GIsZSsI1jJAwlxJ+3eVmERyblStsKN+oWMxfTZFFhPZGFahc4QcW6
	rNJsMD0onjmZsWqCQJ+Q8aJDhbXz5xoE5Xl1+Kf5IfjUBTH0QP1sQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66CB236A75;
	Fri,  6 Sep 2024 12:38:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A81BB36A74;
	Fri,  6 Sep 2024 12:38:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <20240906113746.8903-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Fri, 6 Sep 2024 16:59:09 +0530")
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
	<20240906113746.8903-1-chandrapratap3519@gmail.com>
Date: Fri, 06 Sep 2024 09:38:01 -0700
Message-ID: <xmqqo750wxee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6288941E-6C6E-11EF-AAF4-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> Changes in v5:
> - Edit the commit messages in patches 3 and 4 to reflect the changes
>   and the motivation behind those changes better.
> - Add newlines after variable declarations in patch 6.
> - Introduce patch 7 which removes leftover cruft from the previous
>   reftable testing scheme.

Hmph, the end-result looks good to me, but the structure of the
series is a bit curious.  I didn't expect there will be a separate
step for removal.  Shouldn't these "leftover cruft" be removed *in*
the same step that they become cruft (which I am assuming is when
reftable/stack_test.c and all references to it gets removed in an
early part of the series)?

Other than that, looking good.

Thanks.
