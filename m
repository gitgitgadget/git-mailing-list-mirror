Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C871442F6
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537607; cv=none; b=oJTsRaaN3IyPu765wAza9PpgrncXTVlXGcZuuYftiPvD7nusN4EjHbmWVWEOsiNvpe5QeAhLgMWv02FjzR448f8sKkU/rltz6I6QFet5kAnzoLt73OBs4rHKRd4nhX26cBMYN0ENVnsX9pdAsqWMBvDBKLpbd+mgtIPSaDOBDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537607; c=relaxed/simple;
	bh=pV/F24BmAQO06hVyhBckkMGwiwzXdBfwsI5SIDJkUdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aWTQHvUyfRGvkP7dFcIuvDBJMrq8tJb5XzZ2G7NEP3Z+uxvv14VwRUvhWh6YqEHOng4llE7RvCbdwBrmrWbsz5KDLsh3FrJrl7JQMl/LBN+WsZid+niqayTPqFXqlJ4h8q0CrpiBtQokwXI9wi+O5Ki6r9yB+PlMEYyvSBRJNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6R8BnDH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6R8BnDH"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E54A22540111;
	Wed, 13 Nov 2024 17:40:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 17:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731537604; x=1731624004; bh=tZXp7VR4+sif5NeKA8H31mmScPaslkqwHKg
	nz0R+yLE=; b=K6R8BnDHTnSkrFeaQQgJneMJDyCBjMrOBbI9g6E+DdnjK8nvCDK
	cZOW0VpR2XObk+K/hR9Fw/sZNtbb40a1IBS53jm92DBi7gNGjT+N9r6G1t21tt4p
	/pCo0Sj8zCiEAY5FzuXplvbS4F/NvVtyObH+j0rRDgYGjZVH3pWeBsg33zfujALV
	YkmgP/TW9g9Whj1afmEvvfEGCvjF0I1pEB4O906hvgqqhLERM7yhx3bBNL9VyUWF
	34qIv0VnorxXtSizcJGSVZNhh0VejUUXj1W3EJt3SKuidsunC7ZG73XJ98dpMTZ1
	7LZ4RrBkEzxvaMRNEiNEf2G+c3PziBoWi4g==
X-ME-Sender: <xms:xCo1Z4cifVbCPAG09vBVvtOvGT6tEWKFbV2t2EJXLp_QLD85st-0hQ>
    <xme:xCo1Z6MZt24Aey8T52niR-Wu4dqp1m_0c0bHTECPLbR1ftmkYj9n9U45BDLE54Xqq
    vjFBSqTUrzXcx-MdA>
X-ME-Received: <xmr:xCo1Z5i0opjMUO7Lb2vyzSbBTbn7KuijEYiNTwqdl0rX_aTT7xmKmzhY4-gNjBecmniRXUd8lMVQYJDHprbrbARijUDxtuO7nEjd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdduucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhho
    mheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomh
    eqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffet
    iefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsehmrgihhhgvfidrnh
    grmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xCo1Z9_giry6qG6KwGdcMahdnTyF5U7VnRhl1V2VT_Xa-Bq_7ruSNw>
    <xmx:xCo1Z0vdAfkNb3Ch7pHuKXrf4LAfOMeo41zVjmqataetnTVlzUuxaA>
    <xmx:xCo1Z0E3pz5dokvNT7nDTHFSlfIhLCnuGc1PGlhl9Kv5ltwlxB6hHQ>
    <xmx:xCo1ZzN-YKmRzM8V2fZ_oZ0vBhyJq2ZkrpKl52aVbN8H2T_i2Hx4Lw>
    <xmx:xCo1Z4g3pOAq1_E4eQVnXf1toWUx3B09zt_xCF2PUQ2mzxwNtWgxAGjY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 17:40:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Neil Mayhew <neil@mayhew.name>
Cc: Jeff King <peff@peff.net>,  Victoria Dye via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Victoria Dye
 <vdye@github.com>
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
In-Reply-To: <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name> (Neil Mayhew's
	message of "Wed, 13 Nov 2024 12:24:21 -0700")
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<20240110102338.GA16674@coredump.intra.peff.net>
	<d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
Date: Thu, 14 Nov 2024 07:40:02 +0900
Message-ID: <xmqq5xoqahbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Neil Mayhew <neil@mayhew.name> writes:

> ... immediately corrected by another commit. However, the bad commit is
> still in the history. It happened 6 years ago, so there's no
> possibility of us changing the history.

I think fsck.skipList was meant to cover such a case.  The idea is
that the blob object name of the bad .gitmodules file can be placed
on the list, and the rest of the "bad commit" and the whole history
can still be checked for consistency, without triggering the warning
(or error) resulting from the offending .gitmodules file.

> Is there any possibility of "loosening the fsck.gitmodulesUrl
> severity", as Jeff suggested?

Isn't the suggestion not about butchering the rest of the world but
by locally configuring fsck.gitmodulesUrl down from error to
warning?  I personally think excluding a single known-offending blob
without doing such loosening is a much better idea in that it
prevents *new* offending instances from getting into the repository,
while allowing an existing benign and honest mistake to stay in your
history.  Loosening the severity of a class of check means you will
accept *new* offending instances, which may very well be malicious,
unlike the existing benign one you know about.

