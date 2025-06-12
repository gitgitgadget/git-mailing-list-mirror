Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA17170A26
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760851; cv=none; b=MAx6ZwI5DjKOwJx8Ae/N96uiqtbT+lt7E4tRGf5zP4Z1KOW4JXm2b45mlc4yROw8nG00rxMVdsLcJvMcKLxdc9wlWHeYabOquNeMns+PfW1HZughsdEpwiKzySanhXM4uaTTfvaNhbe6VD3tqDjr4hmhIXwnr6n6eOasRttImH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760851; c=relaxed/simple;
	bh=+wb/v0UJj9E30p0K6eaF9DVkaX8uuL2y0ji+ABuQcDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzoTsT6hVLD5EsAaRcs8du0ce6Nz0xQqaWrWgBjx8axFR0LMgYdUZlSNXjujeavu3+uqO5XEhs39Vq0ak59K0WYu2YdXaL0lNLulCZs3+uZSKU3N9i3wmo8kABZrrNpRoXxYiu5zvHhb2vGp1B+it92FDFTc3+wUZbRwHFO2B28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xn9/abVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQrdZVpS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xn9/abVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQrdZVpS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 61A4E11401E3;
	Thu, 12 Jun 2025 16:40:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 16:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749760848; x=1749847248; bh=eGS1xtjNqo
	mqWhtA8DLtd0BmpP8wKlY0WmPpjp66ZhY=; b=xn9/abVPhZFf3pJHkFn3MIJDEr
	pKQFwh8YxDq9NpQ+c6o08Y9dNB0OClNuyGgIYsnJY8vtHmTAWhA7Q3WieQTpT+Rb
	ZwPFMLxuwkaAIe8sch8N8ONxXdWXm7MMOiE+ctuOO3XU/oTC44REnlIf/dk9OAzi
	gFNYITzKN2E2CaSSKUResBwjvpDXS/CS8iPp9e48Uu7hey2GI+f3lIeO7qc8ajvh
	iiaEFfeTNW35z72j+Z0NErr1jrIvZFetgz/h578oFPNf8KPn1e/8EChhb/dz9sHg
	SaQNJIABRnm7ielh9OJoZm0GQWU+c4V8yjCPNpCd25JsSiS3XoHRlbe3M1Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749760848; x=1749847248; bh=eGS1xtjNqomqWhtA8DLtd0BmpP8wKlY0WmP
	pjp66ZhY=; b=HQrdZVpS4m+oMJSRtmfntL4NgKIz2wQ6Jmq44dkhTKVB+3GLst3
	gqJS8NRgKxowjLlGchCqMYR1GnwVsD9epphMY6JC9iQXisV62DWyMiV3HyefwyHI
	2bGIN6MVJckK4CS6vwvYhIRMEn2hUAeP8HCCFJfudUSiXERYjFX9zuLvl99116pE
	xZ+6URnsJyfscRyALWa/KIrq1omgUuVLnq2Gf+hKLr2hd3aWLBQpFOCOW+vv7JdK
	HTKcH26h0+xFBqpftB7VKPBftHRq7bWkqKcfvXecPHURVQWT8qiU3HWHRHKNazUl
	q6ulV0HF/BRHQn9lreBJYd+7czwrorp1yEA==
X-ME-Sender: <xms:TztLaEQJKld31s4lR5ydMy0DQ4Uf1kIYpBb8hK87wVlRLf82nv1Ytg>
    <xme:TztLaBwm36sKD33nO3Yw1RUvGBJogllIdWOJyCJMlUidh9jBHVwIQocs9K96Mgdzh
    VGrzPqAfblSQCNkNw>
X-ME-Received: <xmr:TztLaB26cAs87UhhjqsGNZ8HD1ACA1wvHaAuGFA54fO5VsCuZtG2U98rcvzsF4n9HaQbMNKWJQ1fJWobXZPm1M3A136sfFS_XqUG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhih
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TztLaIC41CMuz87NCpHQ3jTi6obDinephdx1rZJ5QuVD05dDfmsQ7w>
    <xmx:TztLaNhSmbGUtv0SzSfNZCznbx1I68SuODcYOv2VwlhabXHYbFw10g>
    <xmx:TztLaEryvI4HldNGps9axVFMmz4fAp1D3F_gGYhskKS-6uThwH8uUw>
    <xmx:TztLaAg394L7D5hWbIFdrlSjD1QA0eyA7PNCP_jtPoysk1jEzBeNxg>
    <xmx:UDtLaPQCp2V7MZYhuV5fNjLwcSGJYGwyQAl-4BHRvWM5Lg4p-PEL0fV_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 16:40:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  ps@pks.im,  sunshine@sunshineco.com,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/2] receive-pack: handle reference deletions separately
In-Reply-To: <CAP8UFD0Az9YUd7tHbCWjrZ5bTv1V_0RZ2azasPmOrpf+ARMjug@mail.gmail.com>
	(Christian Couder's message of "Thu, 12 Jun 2025 19:03:00 +0200")
References: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
	<20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-2-e1c41693bd35@gmail.com>
	<CAP8UFD0Az9YUd7tHbCWjrZ5bTv1V_0RZ2azasPmOrpf+ARMjug@mail.gmail.com>
Date: Thu, 12 Jun 2025 13:40:46 -0700
Message-ID: <xmqq8qlwd775.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> when a user pushes multiple branches such as:
>>
>>   delete refs/heads/branch/conflict
>>   create refs/heads/branch
>>
>> Before using batched updates, the references would be applied
>> sequentially and hence no conflicts would arise. With batched updates,
>> while the first update applies, the second fails due to F/D conflict.
>
> Nit: it looks like "D/F conflict" is more often used than "F/D
> conflict" in the Git code base:
>
> $ git grep -i 'd/f conflict' | wc -l
> 119
> $ git grep -i 'f/d conflict' | wc -l
> 7

I do not mind calling a situation F/D conflict if you have a file
and your attempt to create a directory at the same path fails (as
opposed to D/F where directory exists and you cannot overwrite it
with a file), but the above case does sound like a D/F conflict that
deletes directory r/h/b (by removing the last subpath in it), which
is OK, and creates file r/h/b, which the all-or-nothing machinery
does not allow well, so calling D/F may probably be more in line
with the existing practice, regardless of which situation we more
commonly talk about in the code base.
