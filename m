Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435212E47
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705787686; cv=none; b=UdzvjXL5dp1Sw1cV28k5PlpR1X1aHiKhaBkdTsarQ9ve7vXpErVN+gfIL5tzapBiWzT5sO6hE8AS64W3ev/UO9j/ZgWmhPXsLLLucsCGOi7Jtm+FFTOkROFbtiPurctVm56FkzQp6L0+roL8i0vKtlVdWOYzR4yTLiPeUd1p4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705787686; c=relaxed/simple;
	bh=X/IowKTcGd4R3UaAwf7Tz72DQaSyo7yB6pc+5J/4YH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFhsBZ5YP4C96bpxEKjjumQXvnaFbv4qrnHoB6tDXshOyQ54zE1PI/g2k8mt1NvjgRJPzVr7EHOfwbBx94HlDQiyFBAWCdtV7H318IyD49APPHeEDBVB1pDFm8Gqt5Y6lYtGzVfhlSu0KJo7HTVkvnVytMiqWjqAgObfnvlmAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rz1JxLFx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rz1JxLFx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CE7861B12E;
	Sat, 20 Jan 2024 16:54:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=X/IowKTcGd4R3UaAwf7Tz72DQaSyo7yB6pc+5J
	/4YH8=; b=rz1JxLFxts9Nnhg+CeNcA4NtdAOmCKPVAXNfFK8blh50WWj6XFmGBa
	uF5pcyl61Zlt0jzm7l39zsNFG3nihZ0K7MaH2rju4/8qfsP6UwHF0wHr8H2xVAGH
	oPu91mzLuvxw0ltM2ma8yOC5/TZV3trlLiIcp5xGfAsFtDWZj5p8A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C6B4A1B127;
	Sat, 20 Jan 2024 16:54:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FFDD1B126;
	Sat, 20 Jan 2024 16:54:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: James Touton <bekenn@gmail.com>
Cc: James Touton via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] git-p4: use raw string literals for regular expressions
In-Reply-To: <CAA3pzWRRrwLN16RsNEJjdQg7vnSM_p_MtLqCU2ZXg5L=WPc-RA@mail.gmail.com>
	(James Touton's message of "Sat, 20 Jan 2024 11:34:37 -0800")
References: <pull.1639.git.1705775149642.gitgitgadget@gmail.com>
	<xmqqr0ibetap.fsf@gitster.g>
	<CAA3pzWRRrwLN16RsNEJjdQg7vnSM_p_MtLqCU2ZXg5L=WPc-RA@mail.gmail.com>
Date: Sat, 20 Jan 2024 13:54:38 -0800
Message-ID: <xmqqmsszekm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8308F5E8-B7DE-11EE-BD59-A19503B9AAD1-77302942!pb-smtp21.pobox.com

James Touton <bekenn@gmail.com> writes:

> ... is it enough to mention that they're
> already in use?

Sure.  Thanks.
