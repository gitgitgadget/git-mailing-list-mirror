Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64510E5
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564861; cv=none; b=tke4tMRAM0V0VaGGxc/cntRm+GXwe1SKm1RtZPyvjJFL+Lxo6Zaqr4zDNiTDZX1uwjiEPUccyCVtPG2uADJoyHn7ha12mNWkjjcYXzeX3OR9vNyvN/LYIPVeaI7Qg1DELmclzw6oZ0D605RuC2rAgKkAHs6uVN/Pyc7aR9R1DB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564861; c=relaxed/simple;
	bh=ojxySVe1d3fvUa9B1DZG8sj+EYSyJmj/p/tYnInmXuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCjdwywlIn68Gs+KNWbbSaJySlwt7k8AragIGoUlL7TPSjeB3X0oxzX15Fw52CCw26RLTKwE6WTAh3tbbR08msrrawfYZIh8lepMMT/EsY2K4qVx8cR9RJVvFMjDAn9j6RbPzZORcHohEctPu9p/up0R2xoCrdTZc49el/wzJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O3UVj/2B; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O3UVj/2B"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 29AEC36E56;
	Wed,  5 Jun 2024 01:20:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ojxySVe1d3fvUa9B1DZG8sj+EYSyJmj/p/tYnI
	nmXuE=; b=O3UVj/2Bad5NRIXFq7hJfMKGXruEmyN62KkfkaaPdR/tdpenMoxNIj
	afLF8KszlR4lv9BRL/1iDRpnD3mI5VIclZF/jbnXgx88VkbcA/r0qny0uPV1fhiN
	aYronrra6cf3Jg2CrDQV5u5NpmRuz1PMVPiS39cqrC8Gg+hhOuwBs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2212C36E55;
	Wed,  5 Jun 2024 01:20:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48E6036E54;
	Wed,  5 Jun 2024 01:20:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: extract script to lint missing/extraneous
 manpages
In-Reply-To: <b06088a2ff65a3455f0f5db2a9b752901f2af14b.1717564310.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 5 Jun 2024 07:16:47 +0200")
References: <cover.1717564310.git.ps@pks.im>
	<b06088a2ff65a3455f0f5db2a9b752901f2af14b.1717564310.git.ps@pks.im>
Date: Tue, 04 Jun 2024 22:20:54 -0700
Message-ID: <xmqqzfs0x8w9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 62E5AED6-22FB-11EF-BAAA-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +++ b/Documentation/lint-manpages.sh
> @@ -0,0 +1,82 @@
> +#!/usr/bin/env bash

I do not see much bash-ism here.  Unless absolutely needed, please
use "#!/bin/sh" instead.

