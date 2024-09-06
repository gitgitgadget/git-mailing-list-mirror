Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E311D1F60
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637441; cv=none; b=sqmyXEy1Gi1rmenk62poNW2GGa4N6qBTK+5RxYqdj5HuHvZMv4idiErt/Od43sm7VKqahcVH0TBqi7NuiSJVoSoDnfvIl/FES8Lw4zqNOXrKG2OmpZVHV8t4kYdEnQNj3APjENaoNLNeuypMNMl3JMpYExeRbGFda70EIbAcrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637441; c=relaxed/simple;
	bh=5yLQBu7kXgOBr33Ayob/63NdwdSmf1AbVjzBXH9pGxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DSkqlkMyHIVGjUcZ/CLapxDRdp7QMij67t2egwnDeGdRVuO7T1MtcSRa5cgx39xicCHYFHNvjKfaBbwX4Po9TqxrGTj6wQFQFHcCbzZ1dzj2kSu77khpBmZtu8QNjJky107dxhWxVd8KBqaPrjBnZZxOjKAePIhdSJNTppFsN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gCtk/hoo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gCtk/hoo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F29F135E75;
	Fri,  6 Sep 2024 11:43:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5yLQBu7kXgOBr33Ayob/63NdwdSmf1AbVjzBXH
	9pGxU=; b=gCtk/hoolXwWloOuhCvCLxsOC202ozY2+uMHWCE1m1mbfF6uJMNoWL
	1Dg4/qu3aVeV5olnLj2ee/irsNVqi8te2THDt8JFedcISIdQXSeUZQAAfonCIM0z
	HlHoGn/ELY2uCrxD0VX/QsrlIICqZwg90J1l37zc/m8hp0/O2hUvo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB5FB35E74;
	Fri,  6 Sep 2024 11:43:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B5C335E73;
	Fri,  6 Sep 2024 11:43:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/3] builtin: remove USE_THE_REPOSITORY_VARIABLE from
 builtin.h
In-Reply-To: <17acc1e054c26b67659df17db828b106c005ffea.1725555468.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Thu, 05 Sep 2024 16:57:46
	+0000")
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
	<17acc1e054c26b67659df17db828b106c005ffea.1725555468.git.gitgitgadget@gmail.com>
Date: Fri, 06 Sep 2024 08:43:56 -0700
Message-ID: <xmqqbk10yegz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D42C5130-6C66-11EF-89BA-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
> builtin, remove it from builtin.h and add it where necessary to
> individual builtins/*. The next step will be to migrate each builtin
> from having to use the_repository.

I didn't notice this until I compile-tested the merge result to
'seen', but this omits some files in builtin/*.c hierarchy and add
the USE_* variable to the rest.

That makes the step impossible to review this step.

Can we make this step to mechanically (1) remove definition of the
USE_* variable from builtin.h and (2) add it to everything that
includes builtin.h and (3) do nothing else?

Then each of the files in builtin/*.c that this iteration omitted
can explicitly lose the USE_* variable in its own separate follow-up
patch (e.g. "this file did not need to access the_repository either
directly or indirectly", or "with these changes, this file now does
not depend implicitly on the_repository, so lose USE_* definition at
the same time").

Thanks.
