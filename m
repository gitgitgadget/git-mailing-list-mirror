Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938631428EE
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598158; cv=none; b=OHGoZuMcbNzksluRtQOoIMLevJkbF/JMXk3RXniKwh1BImUhO4EnWyWqZ6tIOXOBoRaNz1qmEP6EBKu+R/1mETVpjDRcFg/VPCW4LhMR6Q8kAmTDQ+gvBwDBupQ04r2/2QeiXU6PzLLmMAJ5AXxXkGhgZPTSBJDoytAUo8nIpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598158; c=relaxed/simple;
	bh=g4K4QSeKWdZMYnf+GswpuA8+E1aRNFvajx1bjzPevL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gv2FVCIY0L62YoIylYpU3KBy7Ktd0hyuQGfXzV/CzxoL2FZULl4gYFvr+wRSwVHpvi0EiGW94YVtvwvG+B2Zbz8uJYO5dlpzUWNPcgBxaWcude1XyFKEyXZgeELq3cl2rm9V42JKeVW2N4XVSiEeNbJRTulBnlvFA1u2PK1H3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ryy2ANKA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ryy2ANKA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D2DC1F383A;
	Mon,  8 Apr 2024 13:42:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g4K4QSeKWdZMYnf+GswpuA8+E1aRNFvajx1bjz
	PevL4=; b=ryy2ANKAzmmC3aCH4KrFZd0qQA8XAssmicsaDVh0/oGiqewyzsFxXJ
	gkpz0stR7yml+O0eh067A33Uy2wnCzQr6y8SlVg6Rp02HaNS30ITApfMhjWIyk8c
	FYAtJffpAesLVnEsUJH+dSRFu+WzoB2opYqZfcq2RlVDqkREhk+B8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 442961F3839;
	Mon,  8 Apr 2024 13:42:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A70B11F3838;
	Mon,  8 Apr 2024 13:42:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Benji Fisher <benji@FisherFam.org>
Cc: git@vger.kernel.org,  nasamuffin@google.com
Subject: Re: [PATCH] MyFirstContribution: use switch for changing branches
In-Reply-To: <20240407212109.35131-1-benji@FisherFam.org> (Benji Fisher's
	message of "Sun, 7 Apr 2024 17:21:09 -0400")
References: <20240407212109.35131-1-benji@FisherFam.org>
Date: Mon, 08 Apr 2024 10:42:33 -0700
Message-ID: <xmqqr0ffbvjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 620B0D84-F5CF-11EE-A4DA-25B3960A682E-77302942!pb-smtp2.pobox.com

Benji Fisher <benji@FisherFam.org> writes:

> Use "git switch" instead of "git checkout" for changing branches.

... because?

In the proposed log message, make sure you are telling the readers
WHY the change was needed and desirable.

The usual way to compose a log message for this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

For this particular patch, I do not see a compelling reason why we
should make these changes.  It is not like MyFirst* documents
consistently uses "git switch" (and "git restore") in other places
and these three are the exceptions (in which case that would be a
very good justification you would describe in the "observation"
paragraph of your proposed log message).  We are not deprecating
"git checkout", either.

Thanks.
