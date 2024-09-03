Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5771C14
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384095; cv=none; b=m0obuHOpxbMoZgCIuv3B7wGm5knAXoXCyhXqKGVlFnAKpFqYLNSd5n/CMxP6eJXJyZ/iPEu3WBba3lb4Hj/Dqo9CJ0q8XVUObf8cQI7axN1gTZD5xMSk1tW6qj/WiJhTQVC0aJkLiMGY0qjpQOYuh7BKmcWSm4cNdl6QWtDO0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384095; c=relaxed/simple;
	bh=fDH+scz4S2kFPTJORIuWINo+xSmtYr/sDdXd168Jdu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TqflWc8+04Iutq8wT769+7EWLL9EtjpgfJcIEVOLD8oncwsdN+5+D/SbKeJrNg0LgQ7x/SRb4rWLB/0mVKCbKbtErfe8BTq7nb6TrXBdZPA2kVXvdQtGuPtlEZh8yIWZ5eO+T0IDSzQKCNNF2ihG+qFQbp2r6NPo4WiUFQG5XHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F33KteAI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F33KteAI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C617272FB;
	Tue,  3 Sep 2024 13:21:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fDH+scz4S2kFPTJORIuWINo+xSmtYr/sDdXd16
	8Jdu8=; b=F33KteAIVVDoNf9ljwaWU/FrTXzXuDEKZ9dySuGA9GSwabaAObXRrO
	+1ESX0VflhzGjSiwWLTZiGkBWYuNS/Nh3VmBXPwj/w3spUe8q2pQd10tRkDw76yf
	6umVjakWuyGE0cQEdKNAflGlmHwOc/4k2bCP24l3kgK9cqX681d2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0328A272FA;
	Tue,  3 Sep 2024 13:21:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70866272F9;
	Tue,  3 Sep 2024 13:21:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Kevin Lyles via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kevin Lyles <klyles+github@epic.com>
Subject: Re: [PATCH v2 2/2] Mark 'git cat-file' sparse-index compatible
In-Reply-To: <83ec9352-d274-4d05-a6b8-d33924f46205@gmail.com> (Derrick
	Stolee's message of "Tue, 3 Sep 2024 10:17:14 -0400")
References: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
	<pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
	<a92825e502f1795910b869165779279b89212939.1725052243.git.gitgitgadget@gmail.com>
	<83ec9352-d274-4d05-a6b8-d33924f46205@gmail.com>
Date: Tue, 03 Sep 2024 10:21:31 -0700
Message-ID: <xmqqjzfslkkk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6D6361A-6A18-11EF-AB79-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> Thank you for updating the heredocs and other format things that
> I noticed in the previous version. Also, thanks for splitting the
> patch into two parts.
>
> Thanks for working on this!

Yup.  It seems that the patches are getting almost ready?

Thanks for a detailed review.
