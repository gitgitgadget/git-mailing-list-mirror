Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6247199FAF
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728977; cv=none; b=gLq3qZjrqtdAmg7xzKMC2brl9l5OPqP0UftgxbRRVZ24Sx4+eH+mFAterlHIIjDBsH3MtOav9ujh0j2mp//1dmaXZl7IjjFRN3O+GYJG8cJ8ZfsNjrEtbOtPM13lD7ssvnt7cNyIBlOZP2QlHesoddeaDUTJmV26kKeCb0VVvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728977; c=relaxed/simple;
	bh=duBeMWlyVEt4nuvqfIn8CUPFqHxQ/agLot5wv973lqA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k6VdIH97V7Egv5QXrj6m8WRaEWyesV3FBp8dwbruWMESnEsNjU3nbJamg50U2BvIYFSLE3Vw0WweQKemKPTnxFraRDB+uZphuY2BEA8wRimUWmtQu8VfYNTNpRcnWwQbDrmQmxRJeY9aoxgio8dpej9dZrkEYScFc2jMUd2/FOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qVaV8Lk0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwW2Rui8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qVaV8Lk0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwW2Rui8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E09C4114043E;
	Mon, 30 Sep 2024 16:42:54 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 16:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727728974;
	 x=1727815374; bh=cT0qTeMiD1RlVZXxfTyzxpgdP98WHuZd1NzsTW81Prg=; b=
	qVaV8Lk0dilMaqLScZBsOhadrNCcEjWTuhrzcCn0cLPX8HXB0oiT1AuTUNb2jpu/
	k9lhnr2H3n20XxYw1xjkJNBz8MQx4BZGGnDMz7Gy5lHwP81BI5Nd4qWYIuRi5kbX
	RW2q9QNUB8mJo9gkMGoZVQBuft9zrbZGCTiEMUJo98eKJK9EWFVB/4T0BfUnIRYq
	5V01iEnPSLLUibvjkG7A7Z/C6pAaWloEhwimbgdmTdegNfJb+hWehHP3mbofzTnM
	6oXcV6xySmv88Z87zNJXVDC/tgKxDIdL0QMXUHAL3bf2q1KN1OFxAbeJu98y+YSH
	t80UBCnSsO7Q5jezMmVdKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727728974; x=
	1727815374; bh=cT0qTeMiD1RlVZXxfTyzxpgdP98WHuZd1NzsTW81Prg=; b=k
	wW2Rui8QvHdgSg0/9G3S4ipGuHNI/Ha4+h01lQjmtn7z5J4xwRBVOI+8yUNqTn66
	U+cbzhW+37FoDqQckRXE6tSzx0gK0vlkGhnoLk2/LPg+wR+iCuzio2O5DMVjFUA7
	tumVFu+IdlKV+RpGOxOe0aO68DFCwqz+LW2fs/+exgFMMjPrvbLvoN+n1H57lz1z
	A+wBx9uIrtNkQjt/Oasok8a6Jcyb07Tm5CAYvigi/wamrpV7n/MqAcKjXaxoWTp1
	ATMqGXJ/AxjnAODY4BZiIzvMHQD3771auAEIsdvFw2odfuigVIjKWbT2sicLd5Wd
	/eITOas+tMezv6DkPfGeQ==
X-ME-Sender: <xms:Tg37ZlRyVlR5wmvMiE9j_8oPjXsh9HhDarR7kIIG0823MFCWJ2FgeRI>
    <xme:Tg37ZuxB7BgwlOGE1dzYs1NRe9Iqiw-XSJ1vcDCDZ7IP9f6Q0kr6VrVIGOCJkYQ3r
    1LG8S6bkd7Zy--ubg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeefjefghedvtedttdetgfejudfh
    vdeluefftdeileejteelveffgedtieevjeeljeenucffohhmrghinhepphhkshdrihhmpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Tg37Zq1xwkQ_TUCBga2Ah53HcBN9JhRDyNMpWFJbhXRYdddkf24ahw>
    <xmx:Tg37ZtBASw8mWY67nLeoJBYFVR3KPCU9dcliZZD0R52hL5XUG_EzDQ>
    <xmx:Tg37Zug8SXtDH3J2XN9UCxX0ECYc7e-9H55wMGihHbN_NOIGnP3qWg>
    <xmx:Tg37Zhr7rSEYYFcyTNOMXQCqTVmFK_o1zz69FhKMXISglhVGa79lVw>
    <xmx:Tg37ZiaWW181eULVbKblR1no9eiz4Wq4qCnCJYO5UoL88qn59VRGufda>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A86A6780068; Mon, 30 Sep 2024 16:42:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Sep 2024 22:41:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Emily Shaffer" <nasamuffin@google.com>, "Git List" <git@vger.kernel.org>
Message-Id: <f4d26c91-6fb6-4c9a-b629-d75b572c39d2@app.fastmail.com>
In-Reply-To: 
 <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
References: 
 <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
Subject: Re: Linking topic merges to mailing list threads
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Like Junio explained refs/notes/amlog is a hidden gem for patch
provenance.

> Hi all,
>
> We've been wanting to gather metrics on Git's code review process -
> how long it takes from first contact on list to merge, how many
> iterations are needed, time between iterations, etc. One missing link
> is the actual merge time in `next` and `master` - a human can infer
> the link between the patch and the mailing list thread, but it's more
> challenging for a script to do it.

Is the starting point the email?  I think you could fish out the
Message-ID and do a grep inside the notes tree

    git grep --fixed-string --name-only \
        '00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.=
im' \
        refs/notes/amlog --

(the resulting hash will need to be cleaned: fanned directory layout[1])

Then try one commit at a time (because there might be unreachable
commits from rewrite operations) using git-when-merged(1):[2]

    git when-merged --log 7cd8f1cc6e17af54fb78768c259a615b1ccc0205 next
    git when-merged --log 7cd8f1cc6e17af54fb78768c259a615b1ccc0205 master

=E2=80=A0 1: e.g. 7c/d8/f1cc6e17af54fb78768c259a615b1ccc0205
=F0=9F=94=97 2: https://github.com/mhagger/git-when-merged

--=20
Kristoffer Haugsbakk
