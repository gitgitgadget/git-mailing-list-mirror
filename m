Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006D13E3F3
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758932; cv=none; b=iD17rcTXilGI1XGhxnbSTBoQnAhN8A7/367UP/t/pRMN6dF8F9ly9eY9p2t8efN5R78N4Mxk/83V1HwlgFFxQK5Rfb5DNqIm7jfL5HP24gaq4NT7KneQbhuKnXKPuqjMkH98OUXk2hj2zWaD8jUU81d/EQ3mm/WLYsWQtfrP4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758932; c=relaxed/simple;
	bh=Vks8ZNG2ZSkltVcIcn3qZDhk5DD4OW/xy5YudAeOvKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XOe98uWpTh1Eg9nCpaS1fLMpCO4uA9DQCOiC3hn+bkokW2dUOBb9vLaKEij3CRPL+fKSw5SSFPbNqUxlP5Bv4asQM20m/a5qfeylsBtFWNV1r4i2NNYvdl4zZJRY8VK714a0gs25+5Bk92Ydhq1m9K8l8yds+tIRlYmXEmDJowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pxge2NxF; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pxge2NxF"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8F161ECC0A;
	Wed, 10 Apr 2024 10:22:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Vks8ZNG2ZSkltVcIcn3qZDhk5DD4OW/xy5YudA
	eOvKw=; b=pxge2NxFzznTV6Sw6ltob8movgIj5t1WHalyPVA5D6JIimOtgwVWeE
	JI2Tdlf+uLdG99TFpUdtnfNfGBHmP162ADSRfuhPS6OhMkVnmkcmkogeyshhM2hM
	dOQlavGc8BxT8j8swX7qz/tjwEShrLjLOmHexzBbiJ7kKDlZcP0oo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADEA01ECC09;
	Wed, 10 Apr 2024 10:22:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 910021ECC06;
	Wed, 10 Apr 2024 10:22:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] t3428: restore coverage for "apply" backend
In-Reply-To: <6ab115bf-7b78-4633-a64c-9a0925d68e3f@gmail.com> (phillip's
	message of "Wed, 10 Apr 2024 10:42:10 +0100")
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
	<b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
	<xmqqzfu2yw00.fsf@gitster.g>
	<6ab115bf-7b78-4633-a64c-9a0925d68e3f@gmail.com>
Date: Wed, 10 Apr 2024 07:22:06 -0700
Message-ID: <xmqqjzl5z4a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B62A900C-F745-11EE-BD9B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

phillip.wood123@gmail.com writes:

>> Hmph, doesn't this lose coverage for the merge backend, though?
>
> I don't think so, we had coverage for the merge backend from the other
> tests before 2ac0d6273f as all of the other tests in this file use the
> merge backend. We're no longer testing "--signoff" without specifying
> some other option that selects a backend but it seems unlikely that we
> could break that without breaking one of the other tests.

OK, so we have "rebase --merge --signoff" tested elsewhere and we
are replacing "rebase --signoff" with "rebase --apply --signoff"?

Thanks.

