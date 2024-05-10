Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060913AA3F
	for <git@vger.kernel.org>; Fri, 10 May 2024 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303104; cv=none; b=CqdUVP7UzyrvIL0FKVNO3s5a959IWmC65xc5gsP1gXXrdtWmZwiantJN5HU4ZDbE1MXUESAKeZZBXLeStjSAcJ6nDFXDL3JvZ6MiWXPvTeV59mPjjdEz9ocZWDU90Mk03q2cBBckG9HvgsZlBHWTXFPV3Yr9IdvmINWev/1yQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303104; c=relaxed/simple;
	bh=iYU2tElntx106lrSft1r+nHELdMagOtaol17Hmyar6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j5kZ038eItmxZFLtaopbO6KcN1JgPrQmKVfaS57vhyXZMKBsPnjPR+84cN95lbgXw+mqA8YXbtuadxiTtDo9DHJO156cm02xM5RB83swMo9/bdvaosa1Y9SkefGjjjI7UbUGH43xNZtvI0GAFdTCgJOicDFVy9xAK4FgdR4zZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DyZ8bIAO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DyZ8bIAO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 940881D9B1;
	Thu,  9 May 2024 21:05:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iYU2tElntx106lrSft1r+nHELdMagOtaol17Hm
	yar6Q=; b=DyZ8bIAOvWqSDpT786R8c5YDZGEcFoP3bfX7Te9mVjAX9HH0gdkl8x
	OV2VbHTlWPAy62Up4ccdbHGMzgr0EnRVuQZ919yaZQrqnXvbxDF/GzcPPWYmcgvC
	zZbJeK8pclFnBK8VaumTgC9yjtZ0xEiqnKcgw3WzbCz5AWYyZbkTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51F2F1D9B0;
	Thu,  9 May 2024 21:05:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 309461D9AF;
	Thu,  9 May 2024 21:05:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (May 2024, #04; Thu, 9)
In-Reply-To: <xmqqfruqsjb6.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	09 May 2024 15:37:49 -0700")
References: <xmqqfruqsjb6.fsf@gitster.g>
Date: Thu, 09 May 2024 18:04:59 -0700
Message-ID: <xmqq5xvmschw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5335A140-0E69-11EF-B8FC-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> * cw/git-std-lib (2024-02-28) 4 commits
>  - SQUASH??? get rid of apparent debugging crufts
>  - test-stdlib: show that git-std-lib is independent
>  - git-std-lib: introduce Git Standard Library
>  - pager: include stdint.h because uintmax_t is used
>
>  Split libgit.a out to a separate git-std-lib tor easier reuse.
>
>  Expecting a reroll.
>  source: <cover.1696021277.git.jonathantanmy@google.com>

Just a heads-up.  The topic is pushed out of 'seen', as it seems to
be hated by osx-* jobs when linking programs.  As the topic has been
expecting a reroll for some time, it is not ultra urgent to fix
this, but before resurrecting it, we may want to look into it.

https://github.com/git/git/actions/runs/9023837489

is an example run where we see error messages like:

ld: warning: ignoring duplicate libraries: 'git-std-lib.a', 'libgit.a', 'reftable/libreftable.a', 'xdiff/lib.a'

and

ld: Undefined symbols:
    _git_config_get_bool, referenced from:
        _precompose_string_if_needed in git-std-lib.a[11](precompose_utf8.o)

in both clang and gcc jobs.

We did not see these breakages before, and we do not see these
breakages in today's 'seen' with this topic excluded.  I haven't
tried to include this but excluding tb/precompose-getcwd topic
instead, which I suspect might also work.

Thanks.
