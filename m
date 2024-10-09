Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD2197558
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494902; cv=none; b=qBnMH+L8jl6yUydws/7DiX+eODw1M2DQD0tkL8XIOjHANMoCzmYSHDqbhEBhsz01ggNGVHiuWkR+rgikoz67R4KqJFEAbEX3svKGQTIKScdUkmLvBJ6l1XkxI6aRZQFTMRVnmamdSo5w2Toa+M4z4KEHOe9eIaim8uL5Hlq2yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494902; c=relaxed/simple;
	bh=0zi3Qn/iM116OqRRuC78OdOeiFx3qFiSf/IZ9gmzZqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhPgCB9MEvat8yy9tJiGfBq8iKAVM1sPh6c42zOtID/u0SS2Aikhc6csYLujDbBjGICVu5tgNen3N0ZykpaWHCP0I/xK/Wf3w98fbCpoi6pZ8Laiw0w8EkJxNRU45O91zyJv1vhKay8vT8gBCmTzjAlZWNP5L0YS3TvnNawqPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qB0K1X1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itToA2nF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qB0K1X1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itToA2nF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 77CF913801F7;
	Wed,  9 Oct 2024 13:28:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 09 Oct 2024 13:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728494898; x=1728581298; bh=eROJP2SPX2
	0q7NAkfbo7HNIQ63t7w5uUhY+ZzhYz778=; b=qB0K1X1xO4ce71BirS4jT6pfD9
	PjK7u/peUSO4bmlMz0lvvN+PaKkEXdgrCxcQAf9DdJLhIZHL252goBy5znHOyAg9
	AFKY9IptW8cNzw6JL1q4tKDA0mt1DDQaVC82YaJTMMVh2zWVyHdUl2ul5FSPAoos
	0biiTSY0hattjzXbs3QtmYY0HfDUFK+tqcMcI0Tp1xKGvKumM71H6Rr/dGKhGbVW
	6CpkCJeJ3gTDZLQ8yE8tv+m3JcuHd/F4iZ3OJp57v2wXy1q7c8U3Afv8kxUwJmrD
	v4HV/ejh82dCIDkOa9mx/yqEpIFOWs8+7R9OaMWPAIPTZ7y/bT3CecB3pPtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728494898; x=1728581298; bh=eROJP2SPX20q7NAkfbo7HNIQ63t7
	w5uUhY+ZzhYz778=; b=itToA2nF7B6TvwdQXOgugHIekhoy176nfqaSZaEPEIKO
	d6WX/EckUgMp7hT2bDCGXPlAEzEYB4lb1w8ZtpZvBQRYSVVJ3Ea/o7y2I1FHcV7Y
	6zPSveyoJSviMBCnNuqxUhvEI/ltqJG5seQt+qAzt55H9YzvlCzGIbnrl5cWAF5K
	ryaPAM3PqyZWHxvYfia0Fpq3e44xjWP7ZjGTO67OSlTkO73cP5y4VhwRu0q44hDJ
	dh+zSPYs2hIdzVPAG+ktVlcqxLKu6sTq2fGBHmaKbkg1pBjMs1iExNU9aS0Er0tc
	qBm+gmgkaKthjVWLkre1F7n+VqFzrx3FV/4IsKt8/g==
X-ME-Sender: <xms:Mr0GZ-arB0GZlCue-u2z77riNdcDw3PMGpTP3JAj5GgVFJ5w5FWp4g>
    <xme:Mr0GZxbxssiUFABHTAeRyecVIeQjVQi_wKZz5qmgBZfurzYZDzqDHET_GcZwPRlbT
    JcmoSK98q2Odn8kVQ>
X-ME-Received: <xmr:Mr0GZ4_CcoROCYOex0_PpBylxOyYNXZycJU3aiwNBEkbOQBlOcE89iRbeIDu41NS8S1F-Q_qJHykBkHP6N-sySwkTO-a8Sz9IW84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhusghhrghmrdhkrg
    hnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:Mr0GZwq9YCKQi5_oEaCysQ3Sqe-VXYjuSP0bG90xieA0VPjGNkGPYA>
    <xmx:Mr0GZ5o9g7rrIPq7AqWeynS3dt6UOq63wLuFp--LeYheJ4HKQ7rMeQ>
    <xmx:Mr0GZ-QyGCpAtaHvzOIh3F957J2gNxtCpReW7_V8v2VoJtxFGkgy5w>
    <xmx:Mr0GZ5oU1L4NximrVUMz2HKaVfqBnnxwR6cGjoBd9d0p3LOID6DPGA>
    <xmx:Mr0GZyDA47FzYoz0LVWfb0Gc3z1iB5hu3xvLbW0Z_HPHhm5alcJZKOQO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:28:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Shubham Kanodia
 <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v2] builtin/gc: fix crash when running `git maintenance
 start`
In-Reply-To: <26e589c7-7625-409c-9913-9ed4b8ef9808@gmail.com> (Derrick
	Stolee's message of "Wed, 9 Oct 2024 09:13:47 -0400")
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
	<5798c31e1ef9346e7faf73f8c80b32c436937a8a.1728455715.git.ps@pks.im>
	<26e589c7-7625-409c-9913-9ed4b8ef9808@gmail.com>
Date: Wed, 09 Oct 2024 10:28:16 -0700
Message-ID: <xmqqttdluqxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> ... But
> a way to rephrase what you mean is "Git has compile-time expectations
> that crontab doesn't exist for macOS and Windows, but Git checks for
> 'systemctl' on the PATH regardless of compiled platform."
>
> Thus, placing a systemctl script works for these platforms even when
> they don't have systemctl available normally.

Very nice rewrite.  Thanks for pointing out what your initial
reading hiccupped, as it is likely the same would happen to others.

