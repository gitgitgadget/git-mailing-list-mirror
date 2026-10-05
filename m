Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2C36E483
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202652; cv=none; b=J74C0WG/qhXTWEVC8qY8aV+0a5fGarm6WlyDdQ5QkuNbKT9Np/CjRtPs0XHa9o6R7pK29LOQzIDhGiS1cs1xeBencZuF7Ju9Y7+Md3XrkX6dF/R1/+jLOY4IbcMmyr7Zat/LBILVST/mdEoGzzy5KlJtzZhvQJQPNUzFRJmwMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202652; c=relaxed/simple;
	bh=QBKBDxaKypjwBQJ1/dO6wOYNCWwNb5JDrrlW2WdZOhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6A4UR2inpOEm1GRJ4SK6xLzN1PUfMwEP3OWCv+Eu+UPL3KwSeMVB1SQ+vneO879iEzGvISHiGsxqw9MqktKkdAFOc8SBAoLpFC/KyqlG1ivuElIzuwew3tFPHdB5seUKfQaXA2+WXV8aMRxc7ug09APcH7lAMnUJbRccNxTDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RFpulhti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lp9gcUNO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFpulhti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lp9gcUNO"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 937071400134
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 08:17:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 05 Oct 2026 08:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791202649; x=1791289049; bh=YSY5sJjYP1
	DaS8ekCs70GX4AAwVcZAu1dAajuvOlEwk=; b=RFpulhtiD4ixhiqMFvkFjoPLj6
	IOVAhx4s1trzdshrjb9XZRXUvKVfzyoXudHK8de2EXI2lSaQnxC+I2ar9+W9o1rh
	cpI28B97a5O9akFtEh3Pf85cDGKLtp7sIhF/qUX8zLVAul5gg3YlwKe8qZn9V/HD
	AEZaQShF2DBz+oJjpih6gXKw84xEP7L6BTwk7jivN5VoIoVUyTHOyXNrmXpTTc5o
	TsPTmg+W+Z+3bndalf1Dkp4qW7VN06K5WsNNbw8anqiDsdBz8Q0u5hjxKel6pH5F
	EwL9In4k/Sboql+ANhnBg6FhHgte2ey5bJTh5Y7eNm8QNnNHg3L8ylN1qdWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791202649; x=1791289049; bh=YSY5sJjYP1DaS8ekCs70GX4AAwVcZAu1dAa
	juvOlEwk=; b=Lp9gcUNOG7MZwtCJ1C9ubO0hmfleCzjNRoZPXviFru3P8aGdZAi
	LvMmixgY17tuqqBoisZn3Tu72yWbjD7p7XuEXKuIRhCmJAX7r8hboA0Vu3nwNA9J
	mgEzmSe+sNahvG8k/3qobIn7RVGTrq4E9q04UQQHMA6D0yGqjLGGh4y6fcGlYR0e
	zTZhyTRTV86We2gY6djR59Mp7+K2Hgv/T86MS2dpCiGkysD10qDGmjC5SOyaLClP
	tsLqScIGUZE5Od9YsZ1W4kr2mdPy7w5A0A5eet2GVClUsPZVPz7xD2jPFe6YmXT/
	/DsB8hHk1ZDqefhkfv592VKPWN1SOcTStlQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791202649; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:p/p5e8A1AWvYrP0cgk1ZDXG0jTM7E/IPHGOd2kDZMvY/CJQ
	s2wAhrusXFTtj7+NLI6lav8sSrnLrzSDDrAnSRfCJt3S2XBuhKgsrndR8S04d2TP
	q4wz4cEZlKObDLGo1i8evp/Nhu29LzkT3tOvVvsbB01OzsmZAegVygDjbI4AdFZW
	Xsv0cV3Aa2cjQWGi4ibtbVb9ZL8dm+5fF4WzcZ7X29+ukBUSZR260Fr1f5xc6MX4
	sLbhCwsPIPkxGsieWlOf3yBQaZHPIwaZ4cwDoEMRVywmq3BmB1Rdw8DxT5DJfkzi
	xP3kWHGolY01GBqufYmGL+ZdYZ7iRTyz4+qWcoA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xpoEghPgeQiPPjrlKvTEwin7aZVdcvuCiNo4z0vNqsw=:QBKBDxaKypjwBQJ1/dO6wOYNCWwNb5JDrrlW2WdZOhs=;
X-ME-Sender: <xms:WZXDaoWvsqH_clWYhy5lXIckzer9spOhdyEFcBRnz9-oIP52g_ychQ>
    <xme:WZXDagR7036Wn8vaXk02hDfe6fX3w-AJMSw17_TPzTYTzpNHYs8fx1Y0uHPzmY87g
    lPOO5q0_ihWBMbPG58jGwcDQNE2TJp8xiP64nV85CSyPIozZue5SQg>
X-ME-Received: <xmr:WZXDamNTBCmZemnskmFmR1ozYLoHXXhOibOL_eAReICKEyJ3gykiC-55YFAUNc1hFrK3f6aXsUCxjEzTGID2o4fAt2iKC3Nbz818>
X-ME-Proxy-Cause: dmFkZTF6jBKpoK+5lJMwBGVDzwPGjDwhODmXnPXcJL4p9/CJXBL9sJWUTMc4Fkia8qYlCE
    ++iVvP34Bum8xxbQFqdepSHfSd+Q6WahuRWhTfprLLMgNGiOBjDS6fL70nBvdGUdhZX/5D
    2YL8qRGihdj0r3k3hXMCYZDYGXrpM9VDK+8pteM5xGdRqKfA67dy9T3X4VStsNvtn0Ansf
    89FAW+Q90htyF/cGFcdR6IAExF8yrshHr1AU38z8MLvVOgA98Ud+pSWctBM0wgDOcf8cGh
    1Rfg3I4ssQE4HtgOAYisXWhNByCtmBXil7F+j1M2m4T3q+MNGKaVLyTw+D6WK0r4uk4GSs
    Jh7Q7/6U2o/aXN4Ev/XzxGd51S4e2hgN8QlnFqxxsP0u/22rJjjWBmV1SY+ygjw+FnkTNn
    uwo1wILrvKUj/ywDOzPIizswREyuAumGPn44EGFEf2GfiIHModyHvxpslSPCXgmcgR0qW6
    hPiWHQgwpXm4Lz4UJEUnWi4P96gbAWh1AurZngH4N1gdjp/iUqRDFgApSjbOWFVl/1fl6E
    feKglBIN/Ufix3iHIu/eY9FizQnrPycjRHp1VMG9tBrtd14GPiCaU7ILNkIcskJU5zlb6H
    njm8hifYFSNFtLqteuuE9kZkyPZFhn8GICZIkV0vjnUIdxOxHRnINq0j2Xkg
X-ME-Proxy: <xmx:WZXDauTi8_YAHDYgH5tOHQkKcxcOaN9xA9FFR5ebtli1ABrc4NxmyA>
    <xmx:WZXDakhCVozBk8cYE4ZrZOUq87VKvxm8WjFIj3PndIMZGQnuSjGZpA>
    <xmx:WZXDan8H11kzw15vRF6k3ZqbPsIgDiFgcElewiNxe6vbvZI8PQnNJw>
    <xmx:WZXDarHBZorosZ1qtB07zy6wqK_QYaHKc4DSVsIswEgwVs45BVp5Nw>
    <xmx:WZXDam6QZnNaECDA8kVS7hXU04R2t9PIl5SX4WwfvBIkrJb5McS_F5zj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 08:17:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 0/4] fetch: avoid fetching every branch of a new
 remote in a shallow repo
In-Reply-To: <CAHwyqnXz+acRBytu9tWL+RzsKnzTZyZCnzzQQhEFjvWT5cgoww@mail.gmail.com>
	(Harald Nordgren's message of "Sun, 4 Oct 2026 21:51:01 +0200")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
	<xmqqv77hs7ut.fsf@gitster.g>
	<CAHwyqnXz+acRBytu9tWL+RzsKnzTZyZCnzzQQhEFjvWT5cgoww@mail.gmail.com>
Date: Mon, 05 Oct 2026 05:17:27 -0700
Message-ID: <xmqqv77gnxyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> If you try to run this with [1/4] alone, however, it errors out with
>> "fatal: --refmap option is only meaningful with command-line
>> refspec", which is suboptimal when triggered by a configuration
>> variable.  Even though our design says that remote.*.refmap makes
>> the command behave as if the user gave '--refmap' on the command
>> line, applying that rule here is a bit too strict.
>
> Thanks for pointing that out. How did you find that?

By thinking the process through while writing these very basic
tests.

I think this topic textually interacts with Collin's followRemoteHAD
work.  I tried to be careful while resolving the conflicts when I
merged both to 'seen', but please double check the result when I
push it out.
