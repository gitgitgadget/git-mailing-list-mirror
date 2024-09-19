Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFA566A
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726705604; cv=none; b=uZqFAD/x9UBlPNP3U3fXHnfw7Y1jF2o/gNQ3glKG4bw/+TyWyZCPOUi7A1xJt8bX4JE90KtRwu8PohceZ87RNFY4+CZCCuokAuSQk01GVUb7vWMdKsIw/yi0PmE/mVwsSMa0wgz/PeQuT4/S+JK6MJBsTgUX2JHLR2o+ttoBFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726705604; c=relaxed/simple;
	bh=wKOKOvSTKBKB2Kg52AMFE8KX5rhwQE0rc0zb5s72u7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MIPImTfiT+KVyKpEZr7Yib6DpDWSaH7yH+PwM93Iz1w8CUVySeiU8/IPRutMZrS1xKm0q22EJkOiVM2jY6TaudLeZWwK56LaCKfIrdN4uKzZ0RfhghCKj/G5LqfkwfvJvOH/yOYkNBEmfC/CejeUlSD/IoBB/JTKBhxAkTUYwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YicXzQ78; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YicXzQ78"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DEEB36035;
	Wed, 18 Sep 2024 20:26:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wKOKOvSTKBKB2Kg52AMFE8KX5rhwQE0rc0zb5s
	72u7U=; b=YicXzQ78FkEWnVa7aEXiU7raxsedlsP9JwTd9TM96EZIlxgUZJqvhD
	ltLEKYl1ixQ/iZ6pKK22y0aLvEaqWbGqIzPVJXGTJ2c6sY2u9HeRVH+O65LB6Fj1
	UcJ6+sv32puX1kUOEklsV68NHx4AYtpnm/xDFUKP4EtYdJhe61k0Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85FB736034;
	Wed, 18 Sep 2024 20:26:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E880836033;
	Wed, 18 Sep 2024 20:26:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] deprecating core.preferSymlinkRefs
In-Reply-To: <beb10633-78d7-4fe3-a71b-73d5a4bbb5ac@gmail.com> (Derrick
	Stolee's message of "Wed, 18 Sep 2024 19:38:52 -0400")
References: <20240918232825.2627999-1-gitster@pobox.com>
	<beb10633-78d7-4fe3-a71b-73d5a4bbb5ac@gmail.com>
Date: Wed, 18 Sep 2024 17:26:39 -0700
Message-ID: <xmqqed5ga3pc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D7473202-761D-11EF-A110-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> I do like the idea of having someone set 'feature.git3=true' in
> their global config and having that mean that they are ready to
> accept the Git 3.0 breaking changes as they are available in
> a Git 2.x release. As much early testing as we can get would be
> beneficial.
>
> This would be a way to get your patches 2 & 3 into 'master' and
> released, but I'm not sure exactly how to keep patch 4 queued
> for a potential future release.

I actually am not worried about that one, i.e., "Clean-up phase",
even less than I would worry about the "Proposal phase".  Cleaning
up after the dust settles can be done at a leisurely pace after the
big version bump.

I think the feature.git3 opt-in knob would be a nice approach.
Thanks.
