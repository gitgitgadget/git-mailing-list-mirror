Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504015ECFA
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972347; cv=none; b=lzdlt5ygTl7zhxMzQo8RRFTp5DPs+8pge7+z8dN9ZwFjreDfHBcu4vv7pcrDsR2lSJvM8NDMxalBty0dGW3pMgMkOKyP9eEUjNdsruvaGnY0Ky94y/MsC+FDY5NCXRCPYXu5jMJQNV4iy2lm6c+V0ppfZ3bHJJCbYfYTkQ6TosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972347; c=relaxed/simple;
	bh=qKqoJFePLK+GVgFHVVfupoLPNSDzWZa8vrnJHqlCIJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DIT+J6SznoDNbey9zAymNR8zymadHNSw/mS75y8YcE3U6uOU6RdplGzZ6R/d/FXqD0vz3xEUyXG+70yANEqlug/GUlr26wjLR2RQd2JIF8kcFpw9/vrn7DUXxRL4EwN2wFQ1aTBohmqReZjN4jvzJyujIixCecEK1RNS2H9NhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eOLXojDf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eOLXojDf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D48B1FEB5;
	Wed, 24 Apr 2024 11:25:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qKqoJFePLK+GVgFHVVfupoLPNSDzWZa8vrnJHq
	lCIJ0=; b=eOLXojDf7Ei2Qz5sKGU/86knkGCCcoePBJuo6DowNn74I/cYELdAbS
	KQOeXN0r54Vdopr8KfUbleeMhYI5ADwybwto54tX2tFfdZGSOMt6gcTZFGRk3b61
	sgkPVwVnt27QUusVX1sfuDwDyKbYafH5OStmsBWNupKhOFKhyhH1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85B1D1FEB4;
	Wed, 24 Apr 2024 11:25:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4C121FEB3;
	Wed, 24 Apr 2024 11:25:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4 2/2] format-patch: "--rfc=-(WIP)" appends to produce
 [PATCH (WIP)]
In-Reply-To: <aa628eba-1545-47ac-9773-8aff47ca4adf@gmail.com> (Phillip Wood's
	message of "Wed, 24 Apr 2024 11:16:08 +0100")
References: <20240421185915.1031590-1-gitster@pobox.com>
	<20240423175234.170434-1-gitster@pobox.com>
	<20240423175234.170434-3-gitster@pobox.com>
	<aa628eba-1545-47ac-9773-8aff47ca4adf@gmail.com>
Date: Wed, 24 Apr 2024 08:25:42 -0700
Message-ID: <xmqqplue2361.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA8D1FB8-024E-11EF-95B7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm not convinced this is a good idea as I'm not sure how adding "RFC"
> at the end of the subject prefix makes the world better than just
> having at the start of the prefix and I find using "-" to do that
> quite confusing.

I am not convinced it is a good idea, either.  "PATCH (WIP)" was the
best example I could come up with.  I am also a fan of "a list of
space separated labels or keywords" you mentioned, but *if* a
project convention somewhere is to have them before "PATCH", then it
is not entirely unreasonable to wish to have a way to prepend these
labels.

But I am fine to drop it for the sake of simplicity.  It would help
discourage users from trying to be "original" in a way that does not
make a material difference.  If a project comes with a concrete need
to prepend, the patch is always resurrectable from the list archive.

As to the syntax, I think "-" is a fairly good way to indicate
whether it goes to the front or back.  When told to "Combine '-RFC'
and 'PATCH'", I expect that most people would give 'PATCH-RFC' and
not '-RFC PATCH'.

Thanks.
