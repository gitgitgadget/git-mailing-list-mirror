Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98623CF956
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179077; cv=none; b=Ynq+4Lf6V7ZKgzBwwlBkXXyVQSXrP5fGDDhrsB1jvJgog0pwp9lBNr+XBkcsOoZgnUdNrpFq1y7RDI0nFBXemOszUfJZZzevBUU8vMWrLmYxccyyFzanNOvTFzmZ4ktgkQvNzme4aSp5CDrw7FqdGZ6kcdF/lB+VQPw12PstDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179077; c=relaxed/simple;
	bh=77FBJBA2hLkBRi7l4hMCM0IL8r1/pa92J1BHrxnR5e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JfVmVXw0ZUkPF00qPwIV2Iqf1iKCC7BxU6FZq+DVSpWf82G+A2fXK/zAs+0kQ3Ke9shTkOSa4yxrIPA99Iq87NWm67xpIAcpzHUcQJqkS6/zIj1zhwtsl+/fzx8KIfzeEbHtLoQPkSu2NdTkDsrmXMi+/YEbNBMFaRF6PTq4Y2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ko6ND/5c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zf83CNUm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ko6ND/5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zf83CNUm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BFE4EC0148;
	Thu, 11 Jun 2026 07:57:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 07:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781179075; x=1781265475; bh=Jbhuui2zLv
	uz9BY6Kg4uWNKiPE/MeFSaaHzv0mUTvsk=; b=ko6ND/5cT0PJh3YNwMcE7mzNmY
	W1wufiXzjx7hDvbk5FK6gcvXF88I1clTVC0PKfreYqLMB5WROW9PV4ifL1EOPxU0
	+5XiuzFKPp8f8IrcRMmTpLFHMdrnXEgSo582Rm8HRybm4PnCE2hPUYbOEgO64wRa
	fAYOhLAIEcO2+5S+SeVoyLpkFF/ToGjWQizttSo/wqEGLH2kL/w2YDSZYNE9WRfb
	It6/IFcUBwmrzvEbkgEW6eRyoolYwyjE5RdJlTHI0bB1hoUyHcqgyH7xXipA/k0/
	4SocXLXDp2jfNUi4hbnNsGOGSKWnE05vYa2mbnutgdMyZ1uQalS2zoUyniVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781179075; x=1781265475; bh=Jbhuui2zLvuz9BY6Kg4uWNKiPE/MeFSaaHz
	v0mUTvsk=; b=Zf83CNUm6GF7w/07gvHRqZz45bLGUcoN9Zyb1g6i+iGeb/Gn1N+
	5kV6olqiKo/VN7edMdkyDgdBnUpeWR/RKVDA0/Eag6usO8gEgZjZXV9yVNnxsO3V
	yaFV9Y99wfsr44WJ022ytBxtS/wlX9svoU32mJqL4etOaArMi9jJAyO49J7V11s0
	D99C9W2P5YMXAsvgNRDQIsXfEavCsgZDdjlXSfVWjFkhVRjfkmCxCYPiWbON035j
	+2bG+znB8XqpofccpFTcE8IqPmbHT4WBbXaUlrwq5AlhN7vRu15nWgCwTBTM2GKk
	WUOEc9w9/qCisO4jyd3WIfloke0tX9Pql7g==
X-ME-Sender: <xms:wqIqakQVMcQtzFF1ueUbZpSahkO5tUoHwmI_3JXT85xcYzzWM_XzOQ>
    <xme:wqIqag0hGsO_93bKF0BfUVfQRxs-j-lq_qkK5WF1yBjvNUOvxzE6Mmd2zxt0mrJCQ
    3qMhGrx91TYXW9v9jRLUxU2nvKaU9Mhff-n73l0cfwUS-I1fsCinQ>
X-ME-Received: <xmr:wqIqaoB-Wt2nUpnUFs-JEGQQ6Upe6qMPLBomD09Om8nSPNwHOgfgF1o8l59NlbIrCAJyVi2l09ycCH3eXpyDfwIQs6hp4cZw1_vz>
X-ME-Proxy-Cause: dmFkZTFcULSoqEH3tpGF5gJIsRuK2iO1InFRq5dIGcwLDpKhJfUeTdK4Jf7QdCukY/uI9c
    mgqkgEb7G4Opcr1EtCQJIJE6UDr6mC9L3pTTCA8IPZB2OCjLphWbwcTIwcWbbhYJnG16Fu
    fD8JTSh0gILPTV4V0zx925/lLjj6dqRfhQPQkxz9C9Ckt/nLFw83ZYq06qtFDvmeu9KKnb
    zCM6D3RYClnA3MP7s3Md0SON0iYUW13T4s/HB+FO/F+7sQi3xXpHQhXv7vUbfbXfkVXkDd
    3ym3tWyQlFwO8/xrXT1GNcq2jXHXlR7VWQvvi4GHVhq7KtqnYmXA3RQfeW0jVBW1XLd8ri
    eT2LFMCyJTa7gKynC7i8gd1fHocziMXibOanAZcll6qOHkhGIY+zbKRqey+6I88Pw39z8q
    0pncQnHJ7GMMW/BY9ezHgb09xDJycCHbVa+A19y5SCr/ZucwdgTzVetHXT8CNE3vVzT6at
    wRzYWAWMXm6189cHuLGQsKZRi9n1WeE2V0kfdvF1PrN1ZZ5B/o4Na2oPgp+keyBouJc2yE
    Sq8LETQMxC0r/SIgpH22Upfj1JnfcwTGYQzpZ31pchLchIFIGLtUPwFgcONcLn+lAosn0z
    DVvf1yHkS8d9LPKXOGkps0JwO5Y4TNyIAnIB8ZZiIR+y7UwUlOSM4f4nrsrw
X-ME-Proxy: <xmx:wqIqakj6F6BfHiPzdbTI1siDqcgJRWzt1nP-78bxmQ4fcpsz7ws7Vw>
    <xmx:wqIqaiPPsAeOkRRd8dUf0itImQHaCmt6SzHM44J_jpTxIZckrZ5NjQ>
    <xmx:wqIqas-hXU__QsRE1EaBFsrBJLNd118RJg0wYakNymVnr7kwYIuTDw>
    <xmx:wqIqarcv1RkjK1ptLp5BWtgrtycoxeeebvM3fesfDXvB7QneTMaslg>
    <xmx:w6Iqat9QwSlKGaNKFHLSr8jFNU4afZahpX2nHWUITVF_wCE2jMBSfdF8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 07:57:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  christian.couder@gmail.com,  jackmanb@google.com,  Linus Arver
 <linus@ucla.edu>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
In-Reply-To: <xmqqcxxyt4op.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	10 Jun 2026 15:24:06 -0700")
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
	<V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
	<xmqqcxxyt4op.fsf@gitster.g>
Date: Thu, 11 Jun 2026 04:57:52 -0700
Message-ID: <xmqq1pedthkv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> kristofferhaugsbakk@fastmail.com writes:
>
>> Interdiff against v2:
>> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
>> ...

By the way, what I queued last night was missing [10/11] as I used
"b4 am" to grab the latest thread messages by giving the message-id
of the cover letter, but somehow [10/11] had a bogus value in the
e-mail header.

    Subject: [PATCH v3 10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
    Date: Wed, 10 Jun 2026 23:21:28 +0200
    Message-ID: <>
    X-Mailer: git-send-email 2.54.0.22.g9e26862b904

So, I reverted to the old and battle tested way to pick these 11
messages manually in my newsreader to replace the topic.

If you have a chance, could you investigate where the send-out
process went wrong and gave one message a bogus ID?  I am worried if
you may have triggered a bug in send-email, in which case we would
want to fix it to avoid hurting other users.

Thanks.
