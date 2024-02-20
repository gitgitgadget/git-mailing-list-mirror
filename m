Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B62E413
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 02:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397568; cv=none; b=hy4/X9238Sv6flPSFR38EMIX8iNF/OREOAwmVmhCaMuoPD1Wp3HWaDhwpCKGF0rLiQZYHOmbqXEYbAyiUWBH0CROUZR3lZaaz7SXKN/KW7J98pwtijNMnnABlNjtiYRxzl8XCRGs32hcB+TsuDd0MnXeIW9jYsaHvEtFHxWMseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397568; c=relaxed/simple;
	bh=vo7HvxWuMfbHxG8Jwbgq4hcG1RKrvlrzP4yU3g+KU5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6jMHvJwPKdyGaWRAPlPuYsylSAt5MW5Hq2ZGH6RBDJ3eEJ26/27XgG0GaVQVd5X5uZvOjnO6Q4YJSzqfCGnxC3G+l5g4sJQ1fglsGqynvbUVakGP6Aacmv9qAwODMbcI2czAkAi34CiU+DKmwD0te8tcO148AQYgxhdRDf2Mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AeeAYyux; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeeAYyux"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 14D001D512F;
	Mon, 19 Feb 2024 21:52:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vo7HvxWuMfbHxG8Jwbgq4hcG1RKrvlrzP4yU3g
	+KU5Q=; b=AeeAYyuxEupMKYpADhuxoHvNjl3JhHbH/4hSC4Tnp8jEnliog9y5xH
	QjDczablP3gY6I3FYTK3dFG4ozWaMJPm4zSIHo72yaClufN6Eq9ZsArJH8ufPhIa
	7075RYtwF4ca7JioA9VretiEItmG3LINargvMYBW7ARWKsp1jfKtg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CB771D512E;
	Mon, 19 Feb 2024 21:52:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AE441D512C;
	Mon, 19 Feb 2024 21:52:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kipras Melnikovas <kipras@kipras.org>
Cc: git@vger.kernel.org,  greenfoo@u92.eu
Subject: Re: [PATCH v4] mergetools: vimdiff: use correct tool's name when
 reading mergetool config
In-Reply-To: <20240217162718.21272-1-kipras@kipras.org> (Kipras Melnikovas's
	message of "Sat, 17 Feb 2024 18:27:18 +0200")
References: <20240217074343.12608-1-kipras@kipras.org>
	<20240217162718.21272-1-kipras@kipras.org>
Date: Mon, 19 Feb 2024 18:52:43 -0800
Message-ID: <xmqq8r3fyhhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1F30384A-CF9B-11EE-B633-25B3960A682E-77302942!pb-smtp2.pobox.com

Kipras Melnikovas <kipras@kipras.org> writes:

> Okay I've finalised the documentation, should be the last patch.
> Also I realise I've forgotten to cc the mailing list on my replies to
> Junio and Fernando - sorry! First time..
>
> Range-diff against v3:
> 1:  0018c7e18c = 1:  0018c7e18c mergetools: vimdiff: use correct tool's name when reading mergetool config
>
>  Documentation/config/mergetool.txt   | 21 ++++++++++++++-------
>  Documentation/mergetools/vimdiff.txt |  3 ++-
>  mergetools/vimdiff                   | 12 ++++++++++--
>  3 files changed, 26 insertions(+), 10 deletions(-)

That's curious.  This is v4 and no changes from v3?

