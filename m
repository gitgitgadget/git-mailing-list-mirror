Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611D8833
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521037; cv=none; b=ZK5LQhSGdSz+CcZkWQgR+g7Seg7UHL6utH5XEZVg3AFeXoFAhxjVpUW6e0VQBzJUe64SmfCHD/MAZCCzdmXsOP1IbKtBo6Nw8ja4k7dbnCNxDenHt1bdXp3zjDaOlQUcF38nUYhpKMdst/RQtTzs1/sqo9XLxvNp60VlUUbdPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521037; c=relaxed/simple;
	bh=vj62BGGVMExHhaTF0pqIKfli/lX5NUAIwkM1SeU+2cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JBw9lhNDTAy6KlDYIJ3m7J+w+E4v5Ba4wi0ABImsVk0LzoM1b9Cfd2zxC/Mlt3GHwais5Ch+9IM2O9z+bAgbwdH6ggWHCYPsYHg0txvyRQxU3VQ9BMggBnATBupnfPhFJgM5uCXGwn7nlY14qOfgFVzM1BjY/UddbalrF90t/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=PhyX+yxo; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="PhyX+yxo"
Received: from localhost (ip-109-42-178-117.web.vodafone.de [109.42.178.117])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42R6UKGL023017
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 07:30:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711521020; bh=vj62BGGVMExHhaTF0pqIKfli/lX5NUAIwkM1SeU+2cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PhyX+yxo9L5LI1fVNq/XqQ/NnfYrJiSI++IC9kVb3FOjphqDvaIB8EJsSwVzT/toc
	 C+dLYIwcqnmilSdoOlc328257n2gvglPgnPMcWRSVxx9O0lb0BNN6QvvSl5CQS3Y/l
	 Qs74n1tfHA22o2FaxcB4mcxNIEZtIjLoLDBUD7gw=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v4 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <xmqq1q7waghc.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	26 Mar 2024 13:24:47 -0700")
References: <cover.1711368498.git.dirk@gouders.net>
	<20240326130902.7111-5-dirk@gouders.net> <xmqqo7b1apx3.fsf@gitster.g>
	<gh34scvjq3.fsf@gouders.net> <xmqq1q7waghc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 27 Mar 2024 07:30:14 +0100
Message-ID: <gho7b0tceh.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> Oh yes, you are right (as far as I can say): I would change this to
>> something like:
>>
>> "Asking for this list of filtered objects may cause performance
>> implications, however, because in this case, despite filtering objects,
>> the possibly much larger set of all reachable objects must be processed
>> in order to populate that list."
>
> Better, but the verb "cause" applied to "performance implications"
> feels funny.  It may "have" implications.  Alternatively, it may
> "cause" degradations.  As implications can be both positive or
> negative, it would be better to say "cause performancedegradations"
> when you know if it is negative.

Thank you for the clarification with "implications"
I will fix it.

Dirk

>> (Later in the document, it is suggested to do timing with the two
>> versions, which kind of follows up on the performance impact that is
>> focused on, here.  So, this doesn't remain an unresolved detail.)
>
> Great.
>
> Thanks.
