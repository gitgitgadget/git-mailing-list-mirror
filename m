Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578018042
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691641; cv=none; b=ZHHBOZ2XqMXmR4KULUnv+pZlV3f8C0D8tcQs0VEuEV6swINqDv059mTfdCfN5QnwqTHJOHrvgLtWnHOg8GiEgHFjE3RFJWQqUtqCNEXHakIV+w5QFePE8KkJrlRG1T5bwkH0GHBLYPBw1UHdf7Hrm7++/FVni+D3I7e+l98midE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691641; c=relaxed/simple;
	bh=ZCHGEl2IruKZcnMK4UgjEh8mvdJK86WiDOPcqJVkTbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0RPwqd6Kw9EmpGWHX/U9dxQEbqd+YFTPP+i8OHsiETNiDCYpopAZpDiLlLHKPnklRIKf+bKovtPxoAlLC4da8x+k7UP/29rWRQR+J1mqNTnXGHugImWRD6Ej3dMp5uPyUznU2Y+e78RoISMPRMVy+DmFMG3bSScvNSlqbaY4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=suFdpSj2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="suFdpSj2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B1E92401C;
	Mon, 22 Jul 2024 19:40:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZCHGEl2IruKZcnMK4UgjEh8mvdJK86WiDOPcqJ
	VkTbU=; b=suFdpSj2JOnVZD4TYmF15oIW7vgM4gWXdATYHLgP5shGQKCvMfF6IL
	ZlR4kbS6Ge4/m6w6eUfMRuNoQj2IZgqTrIRWBXhNQ9Utg+PiIrBGPnbK0Q8EOcN4
	HenCyYhjHqk8fwYQbx6JPTAJyuORuGzUrYIB0ybvgMK+i5FEYRCqs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 704972401B;
	Mon, 22 Jul 2024 19:40:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6A8A2401A;
	Mon, 22 Jul 2024 19:40:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,  "'Thaina Yu'"
 <thainayu@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [feature request] Is it possible to have git tag can be sorted
 and filtered by semver?
In-Reply-To: <031701dadc8c$db6d3370$92479a50$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 22 Jul 2024 19:14:03
	-0400")
References: <CADeMgjBeyWkE3mp+-x57NSsyNLQf3cTta+Xm5uyVOQE-rpT6yg@mail.gmail.com>
	<Zp7Pg7ZOlBZcfJei@tapette.crustytoothpaste.net>
	<031701dadc8c$db6d3370$92479a50$@nexbridge.com>
Date: Mon, 22 Jul 2024 16:40:36 -0700
Message-ID: <xmqqy15t6lmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC5CA466-4883-11EF-B7FC-34EEED2EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

> Currently, tags would be sorted as follows (simple example):
> 1.10.0
> 1.2.0
> 1.9.1
>
> With semver, the tags would be:
> 1.2.0
> 1.9.1
> 1.10.0
>
> My take is that this, if implemented, would need to be more general, and include prefix and suffix handling, so:
> v1.2.0
> v1.9.0
> v1.10.0

Without implemeting anything, wouldn't "--sort=version:refname"
suggested by Brian work just fine?

In the git repository:

    $ git tag --sort=version:refname | grep -e 'v2\.[0-9][0-9]*\.[0-9][0-9]*$'
    v2.0.0
    ...
    v2.0.5
    v2.1.0
    v2.1.1
    v2.1.2
    v2.1.3
    v2.1.4
    v2.2.0
    ...
    v2.9.0
    ...
    v2.9.5
    v2.10.0
    v2.10.1
    v2.10.2
    v2.10.3
    v2.10.4
    v2.10.5
    v2.11.0
    ...
    v2.45.1
    v2.45.2

sorting 2.1.x series a lot earlier than 2.10.x series that is sorted
after 2.9.x series.

Isn't it exactly what the original requester wants to see?

One mechanism I find it lacking is a mechanism to tell the tool that
-preW in X.Y.Z-preW is a suffix that signals that X.Y.Z-preW comes
before X.Y.Z, while -postW in X.Y.Z-postW is a suffix that signals
that X.Y.Z-postW comes after X.Y.Z.  Using such a mechanism, we
could say v2.1.0-rc0 comes before v2.1.0-rc1, which in turn comes
before v2.1.0-rc2, which in turn comes before v2.1.0 proper.

But other than the ordering of the final release and -rcX, I think
"--sort=version:refname" does the right thing already.

