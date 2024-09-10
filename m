Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76B19E802
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989747; cv=none; b=YQZeiA0AX2RmZaXbtGB4QlXjKdIDBPcrOL1K80PZNRZkB3nXDWBb44NvMyN64aVqeYLJhjaLvsKF2dh4nMTI4oLY7Iac5adgaJilhPYJXh6b/knO15tyRv4TE7Hj3xBTKqK4JQb1HAJSBgNSXv9HNVQCwiiYucvrQINxF/fmN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989747; c=relaxed/simple;
	bh=qWm7pH/22yJRXqogDNKud+M42jWZ3TGUngjw9EmZKN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+cuDNSu8mS1mElud2wJwA/rS0YHKZ8K4HslvYyZwHvV0gr+Wu6Of4jRBnOgc+KKcurVCHRPcYCOgeEnCezuA80asZEPtWmshIT7Kgd8tzWRd1e7Ymp9mVPjh8dOVTKbe872iAl+YLDxGLwXCPbbQeqPUVKHlN0n4NhZcK6imEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wd+pN4oT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wd+pN4oT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CE2832BB7;
	Tue, 10 Sep 2024 13:35:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qWm7pH/22yJRXqogDNKud+M42jWZ3TGUngjw9E
	mZKN8=; b=wd+pN4oT/BN7qxNLnZfF3+MTu4NiidrVsbLzq0/CSJYlFpr6+DpniM
	qSzSA3jXOtBpXJ/77mo01TXBylXyxtJ9g1aSSKniN9LyLEu9frvMPmTUbDdqmnw7
	6tpcr5h3cxyHygZU0cZJIJrK2DP9p809HwSURQ9927t015gP+K3EI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3493832BB6;
	Tue, 10 Sep 2024 13:35:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C85C32B69;
	Tue, 10 Sep 2024 13:35:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Makefile: rename clar-related variables to avoid confusion
In-Reply-To: <0ee5282c64c51a2c8c06582510b3ca7ec7173c42.1725949388.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Sep 2024 08:23:45 +0200")
References: <0ee5282c64c51a2c8c06582510b3ca7ec7173c42.1725949388.git.ps@pks.im>
Date: Tue, 10 Sep 2024 10:35:43 -0700
Message-ID: <xmqqbk0vfm34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1BA1525E-6F9B-11EF-B31C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The Makefile variables related to the recently-introduced clar testing
> framework have a `UNIT_TESTS_` prefix. This prefix is extremely similar
> to the prefix used by our other unit tests that use our homegrown unit
> testing framework, which is `UNIT_TEST_`. The consequence is that it is
> easy to misread the names and confuse them with each other.
>
> Rename the clar-related variables to instead have a `CLAR_TEST_` prefix
> to address this.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> As discussed in <xmqqfrq8r8s8.fsf@gitster.g>. This is based on top of
> Junio's ps/clar-unit-test at 894deb76a0 (clar: add CMake support,
> 2024-09-04).

Thanks, looking good.  Let me queue it directly on top of that
topic, and have it graduate at the same time as the rest of the
topic.

