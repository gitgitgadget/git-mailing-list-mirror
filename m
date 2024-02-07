Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E76BFCB
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343694; cv=none; b=DRnaUOqJwrkT1CECY7eevjOHGz6H/HU4gU/DOYotbsjsxdM+1i+7H8r1USUw2Hw2lz52QgPsmcfE4Qnq0qGiG48QCqhNOkf1cDscUbyq8BzcF5kE22vSeifKmv28SyoyXf/yzLVp0zLsHld0F4mQJLPduzdQMvKpkgIA8d8LHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343694; c=relaxed/simple;
	bh=lG2I/2AOsF/AzCVCQS62qgB3crnjUZJwputC99mTSGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m0BZzAeOAJ5wGQsTBpfDSUivE1MsruHdsBNN+JUM7fCRIiN99O9CJPVe9ZqyER7JNRA2IXqbXe1MTdypp6ySEJtH73kIMNQh1/deakG657DJEhIJBNGnBFcuxNCdFDoD9b7rDlgXVFAxYh3pSepjNVDOKcJI4fsGONioig2et+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SlSm0QG0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SlSm0QG0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B27B2C018;
	Wed,  7 Feb 2024 17:08:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lG2I/2AOsF/AzCVCQS62qgB3crnjUZJwputC99
	mTSGw=; b=SlSm0QG0CO6xMyWNYnexV9SqlXn+6j510b+RNiR084hxKRUmEyujTw
	kLgKa4Wpp3Aa1NwMt+Xtst9vN0IGBgwHEWXfIMhI9d1ObyE8WnRoh1Ls9HoySnJ8
	VM2Ko7/IYvxdkx7Oh4ho54X0D19v/ROwa4VnfxqXSDoKpBMqBS8LY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6349A2C017;
	Wed,  7 Feb 2024 17:08:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15AEA2C016;
	Wed,  7 Feb 2024 17:08:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>,  Philippe
 Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/5] completion: remove hardcoded config variable names
In-Reply-To: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Mon, 29 Jan 2024
	13:27:56 +0000")
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 14:08:07 -0800
Message-ID: <xmqq8r3w53nc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 607DD2FC-C605-11EE-B6B5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
>  * Corrected my email in PATCH 2/5 (sorry for the noise)
>
> v1: This series removes hardcoded config variable names in the
> __git_complete_config_variable_name function, partly by adding a new mode to
> 'git help'. It also adds completion for 'submodule.*' config variables,
> which were previously missing.
>
> I think it makes sense to do that in the same series since it's closely
> related, and splitting it would result in textual conflicts between both
> series if one does not build on top of the other, but I'm open to other
> suggestions.
>
> Thanks,

Neither rounds of this series unfortunately got any review.
Comments from anybody interested in helping to improve completion
scripts?

Thanks.
